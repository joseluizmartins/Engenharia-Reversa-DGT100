/*
 * DGT-100 Minimal Emulator
 * Usa libz80ex para emular o Z80
 * Implementa o mapa de memória e stubs de I/O baseados na análise da ROM
 *
 * Mapa de memória:
 *   0x0000-0x37FF  ROM (14KB, corrigida)
 *   0x3700-0x3BFF  RAM sobreposta (o código escreve aqui!)
 *   0x3C00-0x3FFF  VRAM (1KB, 64x16 chars)
 *   0x4000-0xFFFF  RAM principal
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <z80ex/z80ex.h>

/* ─── Tamanhos ─────────────────────────────────────────── */
#define ROM_SIZE   0x3800   /* 14KB */
#define RAM_SIZE   0xC800   /* 0x4000-0xFFFF = 50KB */
#define VRAM_SIZE  0x0400   /* 1KB */
#define OVRAM_SIZE 0x0500   /* 0x3700-0x3BFF = RAM sobreposta */

/* ─── Memória ───────────────────────────────────────────── */
static unsigned char rom[ROM_SIZE];
static unsigned char ram[RAM_SIZE];
static unsigned char vram[VRAM_SIZE];
static unsigned char ovram[OVRAM_SIZE]; /* RAM sobreposta em 0x3700-0x3BFF */

/* ─── Estado do emulador ────────────────────────────────── */
static unsigned long total_tstates = 0;
static int running = 1;
static int vram_dirty = 0;
static int io_log = 1;         /* loga I/O desconhecido */
static int max_steps = 500000; /* limite de segurança */

/* ─── Teclado simulado ──────────────────────────────────── */
static unsigned char kbd_port0A = 0xFF; /* 0xFF = nenhuma tecla */
static unsigned char kbd_port30 = 0xFF;

/* ─── Leitura de memória ─────────────────────────────────── */
Z80EX_BYTE mem_read(Z80EX_CONTEXT *cpu, Z80EX_WORD addr,
                    int m1_state, void *ud)
{
    if (addr < 0x3700)
        return rom[addr];

    /* RAM sobreposta: 0x3700-0x3BFF */
    if (addr >= 0x3700 && addr <= 0x3BFF)
        return ovram[addr - 0x3700];

    /* VRAM: 0x3C00-0x3FFF */
    if (addr >= 0x3C00 && addr <= 0x3FFF)
        return vram[addr - 0x3C00];

    /* RAM principal: 0x4000-0xFFFF */
    if (addr >= 0x4000)
        return ram[addr - 0x4000];

    return 0xFF;
}

/* ─── Escrita de memória ─────────────────────────────────── */
void mem_write(Z80EX_CONTEXT *cpu, Z80EX_WORD addr,
               Z80EX_BYTE val, void *ud)
{
    /* ROM: ignora escrita mas loga */
    if (addr < 0x3700) {
        printf("  [MEM] Tentativa de escrita em ROM: 0x%04X = 0x%02X\n",
               addr, val);
        return;
    }

    if (addr >= 0x3700 && addr <= 0x3BFF) {
        ovram[addr - 0x3700] = val;
        return;
    }

    if (addr >= 0x3C00 && addr <= 0x3FFF) {
        vram[addr - 0x3C00] = val;
        vram_dirty = 1;
        return;
    }

    if (addr >= 0x4000) {
        ram[addr - 0x4000] = val;
        return;
    }
}

/* ─── Leitura de porta I/O ───────────────────────────────── */
Z80EX_BYTE port_read(Z80EX_CONTEXT *cpu, Z80EX_WORD port,
                     void *ud)
{
    unsigned char lo = port & 0xFF;

    switch (lo) {
        case 0x0A:
            return kbd_port0A;  /* teclado: nenhuma tecla */

        case 0x30:
            return kbd_port30;  /* scanner de teclado */

        case 0x42:
            return 0x00;        /* DMA/storage: pronto */

        case 0xFF:
            return 0x00;        /* cassete: sem sinal */

        case 0x0F:
            return 0xFF;        /* status */

        case 0x00:
            return 0x00;

        case 0x21:
            return 0xFF;

        case 0xC1: case 0xC3: case 0xCF:
            return 0xFF;

        default:
            if (io_log)
                printf("  [I/O] IN  porta=0x%02X  (stub -> 0xFF)  PC=0x%04X\n",
                       lo, z80ex_get_reg(cpu, regPC));
            return 0xFF;
    }
}

/* ─── Escrita em porta I/O ───────────────────────────────── */
void port_write(Z80EX_CONTEXT *cpu, Z80EX_WORD port,
                Z80EX_BYTE val, void *ud)
{
    unsigned char lo = port & 0xFF;

    switch (lo) {
        case 0xFF:
            /* cassete — ignora silenciosamente */
            break;

        case 0x09:
            /* controlador de vídeo — ignora silenciosamente */
            break;

        case 0x40: case 0x41:
            /* controle de vídeo — ignora */
            break;

        case 0x42:
            /* DMA — ignora */
            break;

        case 0x00: case 0x01: case 0x13:
        case 0x20: case 0x2D: case 0x45:
        case 0x47: case 0x48: case 0x49:
        case 0x51: case 0x54: case 0x59:
        case 0xCD: case 0xD6:
            break;

        default:
            if (io_log)
                printf("  [I/O] OUT porta=0x%02X = 0x%02X  PC=0x%04X\n",
                       lo, val, z80ex_get_reg(cpu, regPC));
    }
}

/* ─── Vetor de interrupção ───────────────────────────────── */
Z80EX_BYTE int_read(Z80EX_CONTEXT *cpu, void *ud)
{
    return 0xFF;
}

/* ─── Renderiza a VRAM como texto ────────────────────────── */
void render_vram(void)
{
    printf("\n");
    printf("╔");
    for (int c = 0; c < 64; c++) printf("═");
    printf("╗\n");

    for (int row = 0; row < 16; row++) {
        printf("║");
        for (int col = 0; col < 64; col++) {
            unsigned char ch = vram[row * 64 + col];
            /* Filtra chars não-imprimíveis */
            if (ch >= 0x20 && ch < 0x7F)
                printf("%c", ch);
            else if (ch == 0x00)
                printf(" ");
            else
                printf("·");
        }
        printf("║\n");
    }

    printf("╚");
    for (int c = 0; c < 64; c++) printf("═");
    printf("╝\n");
    printf("  VRAM 0x3C00-0x3FFF  (64 colunas × 16 linhas)\n\n");
}

/* ─── Carrega a ROM ──────────────────────────────────────── */
int load_rom(const char *filename)
{
    FILE *f = fopen(filename, "rb");
    if (!f) {
        fprintf(stderr, "Erro: não consegui abrir %s\n", filename);
        return 0;
    }
    size_t n = fread(rom, 1, ROM_SIZE, f);
    fclose(f);
    printf("ROM carregada: %zu bytes de %s\n", n, filename);
    return (n > 0);
}

/* ─── Main ───────────────────────────────────────────────── */
int main(int argc, char *argv[])
{
    const char *rom_file = argc > 1 ? argv[1] : "dgt100_corrected.bin";

    printf("╔══════════════════════════════════════════════════════════╗\n");
    printf("║       DGT-100 Minimal Emulator — libz80ex                ║\n");
    printf("╚══════════════════════════════════════════════════════════╝\n\n");

    /* Inicializa memória */
    memset(rom,   0xFF, sizeof(rom));
    memset(ram,   0x00, sizeof(ram));
    memset(vram,  0x20, sizeof(vram));  /* espaço */
    memset(ovram, 0xFF, sizeof(ovram));

    if (!load_rom(rom_file))
        return 1;

    /* Cria CPU */
    Z80EX_CONTEXT *cpu = z80ex_create(
        mem_read,  NULL,
        mem_write, NULL,
        port_read, NULL,
        port_write,NULL,
        int_read,  NULL
    );

    printf("\nIniciando execução...\n");
    printf("(I/O desconhecido é logado; portas conhecidas são tratadas silenciosamente)\n\n");

    /* ─── Loop principal ─────────────────────────────────── */
    int steps = 0;
    int last_vram_render = 0;
    int halt_count = 0;
    unsigned short last_pc = 0;
    int loop_count = 0;

    while (running && steps < max_steps) {
        unsigned short pc = z80ex_get_reg(cpu, regPC);

        /* Detecta loop infinito */
        if (pc == last_pc) {
            loop_count++;
            if (loop_count > 1000) {
                printf("\n[EMU] Loop infinito detectado em PC=0x%04X\n", pc);
                printf("[EMU] Isso é normal — o sistema está esperando I/O\n");
                printf("[EMU] (teclado, cassete ou outro periférico)\n");
                break;
            }
        } else {
            loop_count = 0;
            last_pc = pc;
        }

        /* HALT = sistema parado */
        if (z80ex_doing_halt(cpu)) {
            halt_count++;
            if (halt_count > 10) {
                printf("\n[EMU] HALT detectado em PC=0x%04X\n", pc);
                break;
            }
        }

        /* Executa uma instrução */
        int ts = z80ex_step(cpu);
        total_tstates += ts;
        steps++;

        /* Renderiza VRAM a cada 50000 passos se mudou */
        if (vram_dirty && (steps - last_vram_render) > 50000) {
            printf("\n--- VRAM após %d instruções (PC=0x%04X) ---\n",
                   steps, pc);
            render_vram();
            vram_dirty = 0;
            last_vram_render = steps;
        }
    }

    /* ─── Relatório final ────────────────────────────────── */
    unsigned short pc  = z80ex_get_reg(cpu, regPC);
    unsigned short sp  = z80ex_get_reg(cpu, regSP);
    unsigned short hl  = z80ex_get_reg(cpu, regHL);
    unsigned short de  = z80ex_get_reg(cpu, regDE);
    unsigned short bc  = z80ex_get_reg(cpu, regBC);
    unsigned short af  = z80ex_get_reg(cpu, regAF);

    printf("\n╔══════════════════════════════════════════════════════════╗\n");
    printf("║  ESTADO FINAL DA CPU                                     ║\n");
    printf("╠══════════════════════════════════════════════════════════╣\n");
    printf("║  PC=0x%04X  SP=0x%04X  HL=0x%04X  DE=0x%04X            ║\n",
           pc, sp, hl, de);
    printf("║  BC=0x%04X  AF=0x%04X                                   ║\n",
           bc, af);
    printf("║  Instruções executadas: %-8d                          ║\n", steps);
    printf("║  T-states totais:       %-8lu                          ║\n",
           total_tstates);
    printf("╚══════════════════════════════════════════════════════════╝\n\n");

    printf("Estado da VRAM no momento da parada:\n");
    render_vram();

    /* Mostra alguns bytes da RAM do sistema */
    printf("RAM do sistema (0x4000-0x4020):\n");
    for (int i = 0; i < 0x20; i += 8) {
        printf("  0x%04X: ", 0x4000 + i);
        for (int j = 0; j < 8; j++)
            printf("%02X ", ram[i + j]);
        printf("\n");
    }

    printf("\nOverlay RAM (0x37E0-0x37FF):\n");
    for (int i = 0xE0; i < 0x100; i += 8) {
        printf("  0x37%02X: ", i);
        for (int j = 0; j < 8 && (i+j) < 0x100; j++)
            printf("%02X ", ovram[0x0E0 + (i - 0xE0) + j]);
        printf("\n");
    }

    z80ex_destroy(cpu);
    return 0;
}
