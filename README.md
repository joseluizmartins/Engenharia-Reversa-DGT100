 DGT-100 / DGT-1000 — Engenharia Reversa e Reborn

**Projeto RetroLABS** | J.L. Martins & Luiz Pacheco | 2026

Repositório de engenharia reversa completa das ROMs do computador nacional **DGT-100** (também comercializado como DGT-1000), fabricado pela **Digitus** durante o período de reserva de mercado de informática no Brasil. Inclui análise das ROMs, desassembly Z80, emulador mínimo e análise dos discos do sistema operacional **DGP/M** (CP/M localizado para português).

**O que este estudo descobriu**
O DGT-100 é um computador brasileiro original que usou o mapa de memória do TRS-80 Modelo I como inspiração, mas construiu em cima disso um sistema completamente próprio — com barramento de dados invertido, BASIC em português (DIGBASIC II), debugger embutido (DIGBUG), mecanismo de boot proprietário, e um CP/M localizado (DGP/M) com arquitetura de disco invertida. Uma máquina muito mais sofisticada do que parece à primeira vista, e um objeto de preservação histórica importante para a computação nacional.


---

## Conteúdo do Repositório

```
├── README.md                    ← este arquivo
├── docs/
│   ├── ANALISE_COMPLETA.md      ← relatório técnico detalhado
│   ├── MAPA_DE_MEMORIA.md       ← mapa de memória completo
│   ├── PONTOS_DE_ENTRADA.md     ← funções principais da ROM
│   ├── PORTAS_IO.md             ← mapeamento de portas de I/O
│   └── DGPM_ANALISE.md          ← análise dos discos DGP/M
├── roms/
│   ├── original/                ← dumps originais (dados invertidos, como no hardware)
│   │   ├── AM2716_U28_ROM1.BIN
│   │   ├── AM2716_U29_ROM2.BIN
│   │   ├── AM2716_U30_ROM3.BIN
│   │   ├── AM2716_U31_ROM4.BIN
│   │   ├── AM2716_U32_ROM5.BIN
│   │   ├── AM2716_U33_ROM6.BIN
│   │   ├── AM2716_U34_ROM7.BIN
│   │   └── AM2716_CHAR.BIN
│   ├── corrected/               ← ROMs corrigidas (XOR 0xFF, para análise e emulação)
│   │   ├── DGT100_FULL_14KB.BIN ← ROM completa concatenada
│   │   └── DGT100_CHAR.BIN
│   └── patched/                 ← ROMs patcheadas para emulador
│       ├── DGT100_EMULATOR.BIN  ← para emuladores (trs80gp, SDLTRS)
│       └── eprom/               ← para gravar nos chips físicos do clone
│           ├── DGT100_U28_ROM1.BIN
│           ├── DGT100_U29_ROM2.BIN
│           ├── DGT100_U30_ROM3.BIN
│           ├── DGT100_U31_ROM4.BIN
│           ├── DGT100_U32_ROM5.BIN
│           ├── DGT100_U33_ROM6.BIN
│           └── DGT100_U34_ROM7.BIN
├── disasm/
│   └── DGT100_full.asm          ← desassembly completo (~8800 linhas)
├── emulator/
│   ├── dgt100_emu.c             ← emulador mínimo em C (libz80ex)
│   ├── Makefile
│   └── README.md
└── disks/
    ├── DGPMUTL1/                ← arquivos extraídos do disco 1
    │   └── (CADIR, dBASE II, Turbo Pascal, utilitários)
    └── DGPMUTL2/                ← arquivos extraídos do disco 2
        └── (Turbo Pascal, código-fonte Pascal em português)
```

---

## Descobertas Principais

### 1. Barramento de Dados Invertido

**Todos os EPROMs do DGT-100 têm os bits invertidos (XOR 0xFF).** Esta é uma decisão de hardware intencional — as linhas D0–D7 estão conectadas invertidas entre os chips e o Z80. Para analisar ou regravar os EPROMs, é necessário inverter todos os bytes:

```python
# Corrigir um dump do EPROM para análise
corrected = bytes(b ^ 0xFF for b in raw_dump)

# Preparar dados para gravar num EPROM novo (clone com hardware original)
to_burn = bytes(b ^ 0xFF for b in corrected_data)
```

### 2. Identidade do Sistema — Nem TRS-80 I nem III

O DGT-100 usa o **mesmo mapa de memória** do TRS-80 Modelo I, mas **não é compatível** com ele:

| Característica | TRS-80 Modelo I | DGT-100 |
|---|---|---|
| ROM | `0x0000–0x2FFF` (12KB) | `0x0000–0x37FF` (14KB) |
| VRAM | `0x3C00–0x3FFF` (1KB, 64×16) | **idêntico** |
| RAM início | `0x4000` | **idêntico** |
| RST vectors | ROM fixo | **Indireto via RAM `0x4000`** |
| BASIC | Level II (Microsoft) | **DIGBASIC II** (em português) |
| Portas I/O | Padrão TRS-80 | **Completamente diferentes** |

### 3. DIGBASIC II

Microsoft BASIC adaptado para o português, derivado do TRS-80 Level II BASIC. Inclui todos os comandos TRS-80 (`CLOAD`, `CSAVE`, `INKEY$`, `MEM`, `RESET`, `SET`, `POINT`) e mensagens de erro em português: _"B Erro na linha"_, _"Excesso de dados"_, _"Prepare o gravador"_.

### 4. DIGBUG

Monitor/debugger embutido na ROM de produção, acessível por comando especial. Exibe registradores Z80 (`SZ-H-PNC`), permite operações aritméticas e acessa o cassete.

### 5. Mecanismo de Boot Próprio

O DGT-100 tem um boot loader proprietário em `ROM 0x06BA` que carrega 256 bytes de um endereço de RAM mapeada (`0x37EC–0x37EF`) para `0x4200` e executa. Este mecanismo é completamente diferente do TRS-80.

### 6. DGP/M — CP/M em Português

O DGP/M é o CP/M 2.2 original da Digital Research localizado para o português pela Digitus. Os discos têm arquitetura invertida: o BDOS fica na **última trilha** (trilha 34, no CP/M fica nas trilhas 0 e 1), e todos os dados estão invertidos (XOR 0xFF), como os EPROMs.

---

## Como Usar as ROMs no Emulador
Ainda apresentam alguns erros, não está planamente funcional, mas já executa o boot e comandos do BASIC.

```bash
# trs80gp (Windows/Linux)
trs80gp -m1 -rom roms/patched/DGT100_EMULATOR.BIN

# SDLTRS (Linux)
cp roms/patched/DGT100_EMULATOR.BIN ~/.sdltrs/model1.rom
sdltrs
```

O emulador exibirá:
```
By RetroLABS JL Martins & Luiz Pacheco  - 2026
DIGBASIC II
Ready
>_
```

## Como Compilar o Emulador Mínimo

```bash
# Ubuntu/Debian
sudo apt install libz80ex-dev

cd emulator
make
./dgt100_emu ../roms/patched/DGT100_EMULATOR.BIN
```

## Como Gravar nos EPROMs Físicos (clone)

Os arquivos em `roms/patched/eprom/` estão prontos para gravar diretamente nos chips AM2716 com qualquer programador de EPROM. Cada arquivo corresponde a um chip:

| Arquivo | Chip | Endereço na placa |
|---|---|---|
| `DGT100_U28_ROM1.BIN` | U28 | `0x0000–0x07FF` |
| `DGT100_U29_ROM2.BIN` | U29 | `0x0800–0x0FFF` |
| `DGT100_U30_ROM3.BIN` | U30 | `0x1000–0x17FF` |
| `DGT100_U31_ROM4.BIN` | U31 | `0x1800–0x1FFF` |
| `DGT100_U32_ROM5.BIN` | U32 | `0x2000–0x27FF` |
| `DGT100_U33_ROM6.BIN` | U33 | `0x2800–0x2FFF` |
| `DGT100_U34_ROM7.BIN` | U34 | `0x3000–0x37FF` |

---

## Trabalho Futuro / Itens em Aberto

- [ ] Esquemático completo do DGT-100 (necessário para concluir o mapa de I/O)
- [ ] Identificar o chip controlador de vídeo (necessário para decodificar a CHAR ROM)
- [ ] Mapear completamente a porta `0x84` do FDC proprietário
- [ ] Confirmar o comando de acionamento do DIGBUG
- [ ] Implementar FDC no emulador para rodar o DGP/M completo
- [ ] Criar driver MAME/MESS para o DGT-100
- [ ] Identificar codificação da CHAR ROM (requer esquemático do circuito de vídeo)

---

## Licença

Os arquivos de código (emulador, ferramentas) são disponibilizados sob licença MIT.

As ROMs e discos são material histórico preservado para fins educacionais e de pesquisa. A Digitus encerrou suas atividades há décadas e os produtos não têm mais suporte comercial.

---

*RetroLABS — Preservando a história da computação nacional brasileira*
