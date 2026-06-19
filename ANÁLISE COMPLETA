# DGT-100 — Análise Técnica Completa

**RetroLABS | J.L. Martins & Luiz Pacheco | 2026**

---

## 1. O Hardware

O DGT-100 e o DGT-1000 são idênticos do ponto de vista de hardware. São microcomputadores nacionais fabricados pela **Digitus** durante o período de reserva de mercado de informática no Brasil (Lei 7.232/1984). A máquina é baseada no processador **Zilog Z80** e usa sete EPROMs do tipo **AM2716** (2KB cada) para a ROM do sistema, totalizando **14KB de ROM**.

---

## 2. Descoberta Crítica: Barramento de Dados Invertido

A primeira e mais importante descoberta da engenharia reversa foi que **todos os EPROMs têm os bits invertidos**. Cada byte armazenado nos chips é o complemento lógico do byte real (operação XOR 0xFF).

```
Byte no EPROM físico:  0x0C  →  0000 1100
Byte real (corrigido): 0xF3  →  1111 0011  (DI — instrução Z80 de reset)
```

**Por que a Digitus fez isso?**

1. **Layout de PCB**: rotear as linhas D0–D7 invertidas simplifica o traçado das trilhas em certas configurações de componentes.
2. **Proteção contra cópia**: quem tentasse copiar os EPROMs com um programador comum obteria dados aparentemente aleatórios, sem perceber que a inversão era intencional.

Esta inversão aplica-se a **todos os dados do sistema** — EPROMs de programa, CHAR ROM e dados dos disquetes — sendo uma característica arquitetural de toda a plataforma Digitus.

---

## 3. O DGT-100 e o TRS-80

### É um TRS-80 Modelo I, III ou nenhum?

**Nenhum dos dois — mas é claramente inspirado no TRS-80 Modelo I.**

| Característica | TRS-80 Modelo I | TRS-80 Modelo III | DGT-100 |
|---|---|---|---|
| CPU | Z80 @ 1,77 MHz | Z80 @ 2,03 MHz | Z80 |
| ROM | 12 KB (`0x0000–0x2FFF`) | 14 KB | **14 KB** (`0x0000–0x37FF`) |
| VRAM | `0x3C00–0x3FFF` (1 KB) | `0xF800–0xFFFF` (2 KB) | **`0x3C00–0x3FFF` (1 KB)** |
| Layout de tela | 64 × 16 caracteres | 80 × 24 caracteres | **64 × 16 caracteres** |
| RAM início | `0x4000` | `0x4000` | **`0x4000`** |
| RST vectors | ROM fixo | ROM fixo | **Indireto via RAM** |
| BASIC | Level II (Microsoft) | Level II | **DIGBASIC II** (pt-BR) |
| Portas I/O | Padrão TRS-80 | Padrão TRS-80 | **Proprietárias** |

### Prova pelo código: a VRAM em 0x3C00

A função de scroll do DIGBASIC II, em `ROM 0x0554`, confirma a geometria da tela:

```asm
0x0554:  LD DE, 0x3C00   ; destino = início da VRAM
0x0557:  LD HL, 0x3C40   ; fonte = segunda linha (64 bytes depois)
0x055B:  LD BC, 0x03C0   ; 960 bytes = 15 linhas × 64 colunas
0x055E:  LDIR             ; sobe tudo uma linha
```

`0x03C0 + 0x40 = 0x0400 = 1024 bytes = 1KB` de VRAM, de `0x3C00` a `0x3FFF`, exatamente como o TRS-80 Modelo I. O TRS-80 Modelo III tem VRAM em `0xF800`.

---

## 4. Mapa de Memória Completo

```
Endereço       Tamanho    Conteúdo
────────────── ────────── ──────────────────────────────────────────────
0x0000–0x07FF   2 KB      ROM — U28 (ROM1)  boot, vetores RST, init
0x0800–0x0FFF   2 KB      ROM — U29 (ROM2)  DIGBASIC II (início)
0x1000–0x17FF   2 KB      ROM — U30 (ROM3)  DIGBASIC II (cont.)
0x1800–0x1FFF   2 KB      ROM — U31 (ROM4)  DIGBASIC II (cont.)
0x2000–0x27FF   2 KB      ROM — U32 (ROM5)  DIGBASIC II (cont.)
0x2800–0x2FFF   2 KB      ROM — U33 (ROM6)  DIGBASIC II + DIGBUG
0x3000–0x37FF   2 KB      ROM — U34 (ROM7)  DIGBUG + init avançado

0x3700–0x3BFF   ~1,2 KB   RAM sobreposta à ROM
                            0x37EC: magic byte de cold/warm start
                            0x37EF: fonte de dados para boot de disco
                            0x3840: byte de configuração de hardware

0x3C00–0x3FFF   1 KB      VÍDEO RAM (64 colunas × 16 linhas)
                            0x3C3E–0x3C3F: flags de POST/boot

0x4000–0x4015   22 bytes  Tabela de jumps RST (preenchida no boot)
                            0x4000: JP ??? (handler RST 1)
                            0x4003: JP ??? (handler RST 2)
                            ...até RST 7

0x4016–0x40FF             Variáveis do sistema
                            0x403D: flag de estado (12× lido/escrito)
                            0x40A6: variável de controle principal
                            0x40AF–0x40B1: ponteiros de memória

0x4100–0x41E4             Workspace do interpretador DIGBASIC II

0x41E5–0x41F7             Área de strings de sistema

0x41F8                    Stack pointer inicial (SP)

0x41F9–0x42E7             RAM estendida do sistema

0x42E8+                   RAM do usuário / programas BASIC
```

---

## 5. Vetores RST

O DGT-100 usa um mecanismo **indireto** para os RSTs: cada vetor aponta para uma posição na tabela de jumps em RAM (`0x4000`). Isso permite que expansões de hardware substituam rotinas fundamentais sem modificar a ROM.

```asm
; Vetores em ROM (imutáveis):
0x0000:  DI            ; desativa interrupções
0x0001:  XOR A         ; limpa A
0x0002:  JP 0x0258     ; → cold start handler

0x0008:  JP 0x4000     ; RST 1 → RAM[0x4000] (preenchido no boot)
0x0010:  JP 0x4003     ; RST 2 → RAM[0x4003]
0x0018:  JP 0x4006     ; RST 3 → RAM[0x4006]
0x0020:  JP 0x4009     ; RST 4 → RAM[0x4009]
0x0028:  JP 0x400C     ; RST 5 → RAM[0x400C]
0x0030:  JP 0x400F     ; RST 6 → RAM[0x400F]
0x0038:  JP 0x4012     ; RST 7 → RAM[0x4012]

; Tabela instalada em RAM no boot (copiada de ROM 0x06D2):
0x4000:  JP 0x1C96     ; RST 1 — display/cursor
0x4003:  JP 0x1D78     ; RST 2 — display/cursor
0x4006:  JP 0x1C90     ; RST 3 — display/cursor
0x4009:  JP 0x25D9     ; RST 4 — I/O geral
```

No TRS-80, os RSTs têm destinos fixos na ROM. No DGT-100, os destinos são configuráveis em tempo de boot — uma decisão de engenharia que demonstra maturidade arquitetural.

---

## 6. Sequência de Boot

```
RESET
  │
  └→ 0x0000: DI ; XOR A ; JP 0x0258
                                │
                    0x0258: LD HL,0x37EC ; LD (HL),0xD0    ← marca cold start
                    0x025D: JP 0x0674
                                │
                    0x0674: OUT (0xFF),A                    ← init hardware (cassete/serial)
                    0x0678: LDIR [ROM 0x06D2 → RAM 0x4000] ← instala jump table dos RSTs
                                │
                    0x0066: LD SP,0x0600  ← stack temporário
                    0x006D: CP 0x80       ← warm ou cold boot?
                                │
                    0x00AC: LD SP,0x41F8  ← stack definitivo
                    0x00AF: CALL 0x1B8F   ← init de hardware
                    0x00B2: CALL 0x01C9   ← init complementar
                    0x00B5: [PROTEGER?]   ← verificação de área protegida
                                │
                    0x00FC: LD HL,0x010E  ← string "DIGBASIC II"
                    0x00FF: CALL 0x28A7   ← exibe banner
                    0x0102: JP 0x1A19     ← ENTRA NO BASIC
                                │
                    [prompt '>' aguarda comandos]
```

---

## 7. Funções Principais da ROM

### Funções mais chamadas (top 10)

| Endereço | Chamadas | Descrição provável |
|---|---|---|
| `0x032A` | 33× | Saída de caractere para display |
| `0x0235` | 21× | Envio de byte completo (8 bits serial) |
| `0x0264` | 13× | Envio de 1 bit serial / bit-bang |
| `0x09A4` | 16× | Processamento de expressão BASIC |
| `0x0955` | 15× | Avaliação de token BASIC |
| `0x28A7` | 11× | Impressão de string terminada em 0x00 |
| `0x309D` | 11× | Acesso a storage (DGP/M / disco) |
| `0x20FE` |  9× | Main loop do BASIC |
| `0x1B8F` |  8× | Inicialização de hardware |
| `0x1C90` |  7× | Rotina de display/cursor (RST 3) |

### DIGBASIC II — entry points

| Endereço | Descrição |
|---|---|
| `0x010E` | String "DIGBASIC II " (banner) |
| `0x1A19` | Entry point principal do BASIC |
| `0x1657` | Tabela de keywords BASIC |
| `0x18C9` | Tabela de códigos de erro |
| `0x1919` | String "B Erro" |
| `0x1929` | String "Ready" |
| `0x1930` | String "Break" |

### DIGBUG — Monitor/Debugger

| Endereço | Descrição |
|---|---|
| `0x34E5` | String "DIGBUG >" (prompt) |
| `0x34EF` | String "Area Protegida" |
| `0x3505` | Strings "A+B", "A-B", "B-A" |
| `0x3516` | String " HL" (display de registradores) |
| `0x3523` | String "SZ-H-PNC" (display de flags Z80) |
| `0x3555` | String "Prepare o gravador" |

---

## 8. Portas de I/O

> ⚠️ Atenção: algumas "instruções OUT/IN" na faixa `0x1600–0x1800` são dados da tabela de keywords BASIC e **não** são código real.

| Porta | Dir | Função confirmada |
|---|---|---|
| `0xFF` | IN/OUT | Interface de cassete (bit-banging serial) |
| `0x09` | OUT | Controlador de vídeo (envio de dados) |
| `0x0A` | IN | Teclado (leitura de teclas) |
| `0x42` | IN/OUT | Possível DMA ou storage externo |
| `0x40` | OUT | Controle de vídeo (atributos/modo) |
| `0x41` | OUT | Controle auxiliar |
| `0x30` | IN | Scanner de teclado (linha/coluna) |
| `0x0F` | IN | Status/flags |

---

## 9. DIGBASIC II — Keywords

O DIGBASIC II é um Microsoft BASIC com localização portuguesa, derivado do TRS-80 Level II BASIC. Inclui todos os comandos padrão e extensões específicas:

**Comandos TRS-80 encontrados no DGT-100:**
`CLOAD`, `CSAVE`, `CMD`, `CLS`, `RESET`, `SET`, `POINT`, `INKEY$`, `MEM`, `TIME$`, `TRON`, `TROFF`

**Mensagens em português:**
`"B Erro na linha"`, `"Excesso de dados"`, `"Ready"`, `"Break"`, `"?REDO"`, `"Prepare o gravador"`

---

## 10. CHAR ROM

A CHAR ROM (chip separado AM2716) é lida **diretamente pelo circuito de vídeo**, não pelo Z80. O Z80 nunca acessa a CHAR ROM — ele apenas escreve códigos de caractere na VRAM e o hardware de vídeo faz a renderização autonomamente.

Consequência: a CHAR ROM **não pode ser analisada isoladamente sem o esquemático do circuito de vídeo**. Para decodificá-la é necessário saber como os pinos A0–A10 estão conectados ao controlador de vídeo (possivelmente um MC6845 CRTC ou circuito equivalente).

---

## 11. DGP/M — O CP/M Brasileiro

### O que é

O **DGP/M** (Disco Grande Porte M?) é o sistema operacional em disco da Digitus, baseado no **CP/M 2.2 original da Digital Research** (copyright 1979), localizado para o português.

### Localização

Todas as mensagens de sistema foram traduzidas:

| Original (CP/M) | DGP/M |
|---|---|
| "Read error" | "Error de leitura" |
| "File not found" | "Arquivo(s) nao existe(m)" |
| "Disk full" | "Disco cheio" |
| "File exists" | "Arquivo existe" |
| "Disk R/O" | "Disco R/O" |
| "Drive not found" | "Nao existe drive X:" |
| "Boot error" | "Erro Boot!" |

### Arquitetura do disco (diferente do padrão!)

O disco DGP/M tem uma estrutura **invertida** em relação ao CP/M padrão:

| Trilhas | Conteúdo |
|---|---|
| 0–1 H0 | Boot loader proprietário Digitus |
| 0–1 H1 | Overlay do dBASE II |
| 2–33 | Arquivos de dados (diretório CP/M normal) |
| **34 H0** | **CP/M BDOS + BIOS** (última trilha!) |
| 34 H1 | Turbo Pascal overlay (PROLOGICA-85) |

Além disso, **todos os dados do disco estão invertidos** (XOR 0xFF), como os EPROMs.

### Formato físico do disquete

- Tipo: 5.25" DSDD (double-sided, double-density)
- 35 cilindros × 2 lados × 10 setores × 512 bytes = **350 KB**
- Gravação: MFM 250k
- Interleave: `[4,7,10,3,6,9,2,5,8,1]` (3:1)

### FDC (controlador de disco)

O DGP/M usa as seguintes portas para acesso ao disco:

| Porta | Função |
|---|---|
| `0x84` | FDC comando/controle (proprietário Digitus) |
| `0xEC` | Disk enable latch (igual ao TRS-80 Modelo I!) |
| `0xF0` | FDC status/command (WD1771) |
| `0xF2` | FDC sector register |
| `0xF4` | FDC data register / drive select |
| `0xE4` | Drive select auxiliar |

A porta `0xEC` e o FDC WD1771 (`0xF0–0xF4`) são **compatíveis com o TRS-80 Modelo I**, indicando que o DGT-100 usava uma expansão de disco baseada no mesmo controlador. A porta `0x84` é exclusiva da Digitus.

---

## 12. Compatibilidade com Emuladores

### DIGBASIC II (ROM patcheada)

A ROM patcheada (`DGT100_EMULATOR.BIN`) roda nos emuladores TRS-80 Modelo I:

```bash
trs80gp -m1 -rom DGT100_EMULATOR.BIN
```

Patches aplicados:
- `0x00B5`: `JP 0x00FC` — pula verificação de hardware `PROTEGER?`
- `0x00B8–0x00B8+60`: nova string "By RetroLABS..." (área de código morto)
- `0x00BB`: `NOP×5` — remove `CALL 0x1BB3` + `JR C`
- `0x00C4`: `JP 0x00E7` — pula teste de RAM de 48KB
- `0x00FD`: `0xB8 0x00` — ajusta ponteiro para nova string

### DGP/M (discos)

O DGP/M **não roda** em emuladores padrão por três razões:
1. Depende do boot mechanism proprietário da ROM DGT-100
2. Usa porta `0x84` (FDC proprietário, não emulado)
3. Dados do disco estão invertidos

**Alternativa imediata**: os 83 arquivos extraídos dos dois discos funcionam no **RunCPM** (emulador CP/M 2.2 para PC), especialmente `TURBO.COM`, `CADIR.COM`, `DBASE.COM`, `PIP.COM`, `STAT.COM` e todos os fontes Pascal.

---

## 13. Trabalho Futuro

Para completar a engenharia reversa e o emulador dedicado, são necessários:

1. **Esquemático completo do DGT-100** — necessário para:
   - Identificar o chip controlador de vídeo e decodificar a CHAR ROM
   - Mapear completamente as portas de I/O desconhecidas
   - Confirmar o circuito de RAM sobreposta em `0x3700–0x3BFF`
   - Identificar o hardware na porta `0x84` (FDC do DGP/M)
   - Entender o mecanismo `0x37EC–0x37EF` (boot de disco)

2. **Acionar o DIGBUG** — o comando exato para entrar no debugger embutido ainda não foi identificado (possivelmente `CMD "BUG"` ou uma combinação de teclas)

3. **Licença do BASIC** — investigar se a Digitus licenciou o Microsoft BASIC ou o adaptou de outra forma (a estrutura interna é muito similar ao TRS-80 Level II para ser coincidência)

---

*Análise realizada sobre ROMs: U28–U34 (DIGBASIC II, 14KB) + CHAR ROM (2KB)*
*Discos: DGPMUTL1.IMD (DGP/M + CADIR + dBASE II) + DGPMUTL2.IMD (Turbo Pascal + fontes)*
