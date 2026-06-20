; ╔══════════════════════════════════════════════════════════════════════╗
; ║  DGT-100 / DGT-1000 — Desassembly Completo com Anotações           ║
; ║  Engenharia Reversa: RetroLABS                                      ║
; ║  J.L. Martins & Luiz Pacheco — 2026                                ║
; ╚══════════════════════════════════════════════════════════════════════╝
;
; Gerado a partir de: 7× AM2716 (U28-U34) + corrected XOR 0xFF
; Tamanho: 14KB (0x0000-0x37FF)
;

        ORG     0x0000


; ═══════════════════════════════════════════════════════════════════
; DGT-100 / DGT-1000 — ROM Completa (DIGBASIC II + DIGBUG)
; Fabricante: Digitus (Brasil) — Período da Reserva de Mercado
; Engenharia Reversa: RetroLABS — J.L. Martins & Luiz Pacheco — 2026
;
; NOTA IMPORTANTE: Os EPROMs originais têm todos os bits INVERTIDOS (XOR 0xFF)
; Este arquivo já contém os dados CORRIGIDOS para análise e emulação
; Para gravar nos chips físicos AM2716: inverter novamente (XOR 0xFF)
;
; Compatibilidade: usa mapa de memória do TRS-80 Model I mas NÃO é compatível
; — VRAM em 0x3C00-0x3FFF (64x16 chars) ← igual TRS-80 Model I
; — RAM em 0x4000+                       ← igual TRS-80 Model I
; — RSTs via tabela em RAM 0x4000        ← DIFERENTE (TRS-80 usa ROM fixo)
; — Portas I/O completamente diferentes  ← INCOMPATÍVEL com TRS-80
; ═══════════════════════════════════════════════════════════════════

; ─── SEÇÃO 1: VETORES RST (0x0000-0x003F) ──────────────────────────
; TRS-80 Model I usa estes mesmos endereços, mas com rotinas FIXAS na ROM:
;   RST 0  (0x0000): Cold start
;   RST 1  (0x0008): @CPOS  — posiciona cursor
;   RST 2  (0x0010): @DSPLY — exibe caractere
;   RST 3  (0x0018): @PRNTF — imprime caractere
;   RST 4  (0x0020): @CHARTR — traduz caractere
;   RST 5  (0x0028): @GETKY — lê teclado
;   RST 6  (0x0030): @JOBP  — job processor
;   RST 7  (0x0038): @RSRD  — I/O redirect
;
; DGT-100: todos RST 1-7 redirecionam para TABELA EM RAM (0x4000-0x4012)
; A tabela é instalada no boot copiando 0x36 bytes de ROM 0x06D2 → RAM 0x4000
; Isso permite que expansões de hardware substituam handlers sem modificar ROM

RESET:
  0000:  F3            DI                            
  0001:  AF            XOR A                         
  0002:  C3 58 02      JP COLD_START                 
  0005:  C3 00 40      JP 0x4000                     
RST_08:
  0008:  C3 00 40      JP 0x4000                     
  000B:  E1            POP HL                        
  000C:  E9            JP (HL)                       
  000D:  C3 9F 06      JP 0x069F                     
RST_10:
  0010:  C3 03 40      JP 0x4003                     
  0013:  C5            PUSH BC                       
  0014:  06 01         LD B,0x01                     
  0016:  18 2E         JR 0x0046                       ; -> 0x0046
RST_18:
  0018:  C3 06 40      JP 0x4006                     
  001B:  C5            PUSH BC                       
  001C:  06 02         LD B,0x02                     
  001E:  18 26         JR 0x0046                       ; -> 0x0046
RST_20:
  0020:  C3 09 40      JP 0x4009                     
  0023:  C5            PUSH BC                       
  0024:  06 04         LD B,0x04                     
  0026:  18 1E         JR 0x0046                       ; -> 0x0046
RST_28:
  0028:  C3 0C 40      JP 0x400C                     
  002B:  11 15 40      LD DE,0x4015                    ; ← RAM sistema
  002E:  18 E3         JR 0x0013                       ; -> 0x0013
RST_30:
  0030:  C3 0F 40      JP 0x400F                     
  0033:  11 1D 40      LD DE,0x401D                    ; ← RAM sistema
  0036:  18 E3         JR 0x001B                       ; -> 0x001B
RST_38:
  0038:  C3 12 40      JP 0x4012                     
  003B:  11 25 40      LD DE,0x4025                    ; ← RAM sistema
  003E:  18 DB         JR 0x001B                       ; -> 0x001B
  0040:  C3 D9 05      JP 0x05D9                     
  0043:  C9            RET                           
  0044:  00            NOP                           
  0045:  00            NOP                           
  0046:  C3 C2 03      JP BASIC_EVAL                 
  0049:  CD 2B 00      CALL 0x002B                   
  004C:  B7            OR A                          
  004D:  C0            RET NZ                        
  004E:  18 F9         JR 0x0049                       ; -> 0x0049
  0050:  0D            DEC C                         
  0051:  0D            DEC C                         
  0052:  1F            RRA                           
  0053:  1F            RRA                           
  0054:  01 01 5B      LD BC,0x5B01                  
  0057:  1B            DEC DE                        
  0058:  0A            DB 0x0A                       
  0059:  00            NOP                           
  005A:  08            EX AF,AF'                     
  005B:  18 09         JR BOOT_STAGE2                  ; -> 0x0066
  005D:  19            ADD HL,DE                     
  005E:  20 20         JR NZ,0x0080                    ; -> 0x0080
  0060:  0B            DEC BC                        
  0061:  78            LD A,B                        
  0062:  B1            OR C                          
  0063:  20 FB         JR NZ,0x0060                    ; -> 0x0060
  0065:  C9            RET                           

;
; ─── SEÇÃO 2: BOOT STAGE 2 (0x0066-0x00B4) ────────────────────────
; Chegamos aqui via JP de 0x0695 após init de hardware
; Define stack temporário, verifica warm/cold boot, configura SP final

BOOT_STAGE2:
  0066:  31 00 06      LD SP,0x0600                  
  0069:  3A EC 37      LD A,(magic_boot_byte)          ; ← RAM sobreposta
  006C:  00            NOP                           
  006D:  FE 80         CP 0x80                       
  006F:  CA 00 00      JP Z,RESET                    
  0072:  C3 00 30      JP 0x3000                     
  0075:  11 80 40      LD DE,0x4080                    ; ← RAM sistema
  0078:  21 F7 18      LD HL,0x18F7                  
  007B:  01 27 00      LD BC,0x0027                  
  007E:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  0080:  21 E5 41      LD HL,0x41E5                    ; ← RAM sistema
  0083:  36 3A         LD (HL),0x3A                  
  0085:  23            INC HL                        
  0086:  70            LD (HL),B                     
  0087:  23            INC HL                        
  0088:  36 2C         LD (HL),0x2C                  
  008A:  23            INC HL                        
  008B:  22 A7 40      LD (0x40A7),HL                
  008E:  11 2D 01      LD DE,0x012D                  
  0091:  06 1C         LD B,0x1C                     
  0093:  21 52 41      LD HL,0x4152                    ; ← RAM sistema
  0096:  36 C3         LD (HL),0xC3                  
  0098:  23            INC HL                        
  0099:  73            LD (HL),E                     
  009A:  23            INC HL                        
  009B:  72            LD (HL),D                     
  009C:  23            INC HL                        
  009D:  10 F7         DJNZ 0x0096                     ; loop para 0x0096
  009F:  06 15         LD B,0x15                     
  00A1:  36 C9         LD (HL),0xC9                  
  00A3:  23            INC HL                        
  00A4:  23            INC HL                        
  00A5:  23            INC HL                        
  00A6:  10 F9         DJNZ 0x00A1                     ; loop para 0x00A1
INIT_STACK:
  00A8:  21 E8 42      LD HL,0x42E8                  
  00AB:  70            LD (HL),B                     
SET_STACK_FINAL:
  00AC:  31 F8 41      LD SP,STACK_TOP               
  00AF:  CD 8F 1B      CALL HW_INIT_1                
  00B2:  CD C9 01      CALL HW_INIT_2                

;
; ─── VERIFICAÇÃO DE ÁREA PROTEGIDA ─────────────────────────────────
; 'PROTEGER?' — O sistema aguarda resposta do hardware externo via porta 0xFF
; É um handshake serial proprietário da Digitus
; Sem o hardware físico: loop infinito aqui
; PATCH no emulador: 0x00B5 = JP 0x00FC (pula direto para o banner)

SHOW_PROTEGER:
  00B5:  21 05 01      LD HL,0x0105                  

;
; ─── BANNER RETROLAB (área de código morto após patch) ─────────────
; Original: código de verificação de proteção
; Após patches: string 'By RetroLABS JL Martins & Luiz Pacheco  - 2026'
; seguida de 'DIGBASIC II\r' e terminador 0x00

BANNER_STRING:
  00B8:  CD A7 28      CALL PRINT_STRING             
  00BB:  CD B3 1B      CALL PROTEGER_HW_READ         
  00BE:  38 F5         JR C,SHOW_PROTEGER              ; -> 0x00B5
  00C0:  D7            RST 10h                       
  00C1:  B7            OR A                          
  00C2:  20 12         JR NZ,0x00D6                    ; -> 0x00D6
  00C4:  21 4C 43      LD HL,0x434C                  
  00C7:  23            INC HL                        
  00C8:  7C            LD A,H                        
  00C9:  B5            OR L                          
  00CA:  28 1B         JR Z,0x00E7                     ; -> 0x00E7
  00CC:  7E            LD A,(HL)                     
  00CD:  47            LD B,A                        
  00CE:  2F            CPL                           
  00CF:  77            LD (HL),A                     
  00D0:  BE            DB 0xBE                       
  00D1:  70            LD (HL),B                     
  00D2:  28 F3         JR Z,0x00C7                     ; -> 0x00C7
  00D4:  18 11         JR 0x00E7                       ; -> 0x00E7
  00D6:  CD 5A 1E      CALL 0x1E5A                   
  00D9:  B7            OR A                          
  00DA:  C2 97 19      JP NZ,0x1997                  
  00DD:  EB            EX DE,HL                      
  00DE:  2B            DEC HL                        
  00DF:  3E 8F         LD A,0x8F                     
  00E1:  46            DB 0x46                         ; 'F'
  00E2:  77            LD (HL),A                     
  00E3:  BE            DB 0xBE                       
  00E4:  70            LD (HL),B                     
  00E5:  20 CE         JR NZ,SHOW_PROTEGER             ; -> 0x00B5
  00E7:  2B            DEC HL                        
  00E8:  11 14 44      LD DE,0x4414                  
  00EB:  DF            RST 18h                       
  00EC:  DA 7A 19      JP C,0x197A                   
  00EF:  11 CE FF      LD DE,0xFFCE                  
  00F2:  22 B1 40      LD (ptr_mem_high),HL          
  00F5:  19            ADD HL,DE                     
  00F6:  22 A0 40      LD (0x40A0),HL                
  00F9:  CD 4D 1B      CALL HW_INIT_3                
SHOW_BANNER:
  00FC:  21 0E 01      LD HL,0x010E                  
  00FF:  CD A7 28      CALL PRINT_STRING             
ENTER_BASIC:
  0102:  C3 19 1A      JP BASIC_MAIN_LOOP            

;
; ─── STRINGS DO SISTEMA ────────────────────────────────────────────

;
; NOTA: A partir daqui, os bytes representam STRINGS ASCII
; O disassembler não distingue dados de código automaticamente
; Bytes 0x20-0x7E são caracteres ASCII; 0x0D = nova linha; 0x00 = terminador
STR_PROTEGER:
  0105:  50            LD D,B                        
  0106:  52            LD D,D                        
  0107:  4F            LD C,A                        
  0108:  54            LD D,H                        
  0109:  45            LD B,L                        
  010A:  47            LD B,A                        
  010B:  45            LD B,L                        
  010C:  52            LD D,D                        
  010D:  00            NOP                           
STR_DIGBASIC_II:
  010E:  44            LD B,H                        
  010F:  49            LD C,C                        
  0110:  47            LD B,A                        
  0111:  42            LD B,D                        
  0112:  41            LD B,C                        
  0113:  53            LD D,E                        
  0114:  49            LD C,C                        
  0115:  43            LD B,E                        
  0116:  20 49         JR NZ,0x0161                    ; -> 0x0161
  0118:  49            LD C,C                        
  0119:  20 0D         JR NZ,0x0128                    ; -> 0x0128
  011B:  00            NOP                           
  011C:  C5            PUSH BC                       
  011D:  01 00 05      LD BC,0x0500                  
  0120:  CD 60 00      CALL 0x0060                   
  0123:  C1            POP BC                        
  0124:  0A            DB 0x0A                       
  0125:  A3            AND E                         
  0126:  C8            RET Z                         
  0127:  7A            LD A,D                        
  0128:  07            RLCA                          
  0129:  07            RLCA                          
  012A:  C3 FE 03      JP 0x03FE                     
  012D:  1E 2C         LD E,0x2C                     
  012F:  C3 A2 19      JP 0x19A2                     
  0132:  D7            RST 10h                       
  0133:  AF            XOR A                         
  0134:  01 3E 80      LD BC,0x803E                  
  0137:  01 3E 01      LD BC,0x013E                  
  013A:  F5            PUSH AF                       
  013B:  CF            RST 08h                       
  013C:  28 CD         JR Z,0x010B                     ; -> 0x010B
  013E:  1C            INC E                         
  013F:  2B            DEC HL                        
  0140:  FE 80         CP 0x80                       
  0142:  D2 4A 1E      JP NC,0x1E4A                  
  0145:  F5            PUSH AF                       
  0146:  CF            RST 08h                       
  0147:  2C            INC L                         
  0148:  CD 1C 2B      CALL 0x2B1C                   
  014B:  FE 30         CP 0x30                       
  014D:  D2 4A 1E      JP NC,0x1E4A                  
  0150:  16 FF         LD D,0xFF                     
  0152:  14            INC D                         
  0153:  D6 03         SUB 0x03                      
  0155:  30 FB         JR NC,0x0152                    ; -> 0x0152
  0157:  C6 03         ADD A,0x03                    
  0159:  4F            LD C,A                        
  015A:  F1            POP AF                        
  015B:  87            ADD A,A                       
  015C:  5F            LD E,A                        
  015D:  06 02         LD B,0x02                     
  015F:  7A            LD A,D                        
  0160:  1F            RRA                           
  0161:  57            LD D,A                        
  0162:  7B            LD A,E                        
  0163:  1F            RRA                           
  0164:  5F            LD E,A                        
  0165:  10 F8         DJNZ 0x015F                     ; loop para 0x015F
  0167:  79            LD A,C                        
  0168:  8F            ADC A,A                       
  0169:  3C            INC A                         
  016A:  47            LD B,A                        
  016B:  AF            XOR A                         
  016C:  37            SCF                           
  016D:  8F            ADC A,A                       
  016E:  10 FD         DJNZ 0x016D                     ; loop para 0x016D
  0170:  4F            LD C,A                        
  0171:  7A            LD A,D                        
  0172:  F6 3C         OR 0x3C                       
  0174:  57            LD D,A                        
  0175:  1A            DB 0x1A                       
  0176:  B7            OR A                          
  0177:  FA 7C 01      JP M,0x017C                   
  017A:  3E 80         LD A,0x80                     
  017C:  47            LD B,A                        
  017D:  F1            POP AF                        
  017E:  B7            OR A                          
  017F:  78            LD A,B                        
  0180:  28 10         JR Z,0x0192                     ; -> 0x0192
  0182:  12            DB 0x12                       
  0183:  FA 8F 01      JP M,0x018F                   
  0186:  79            LD A,C                        
  0187:  2F            CPL                           
  0188:  4F            LD C,A                        
  0189:  1A            DB 0x1A                       
  018A:  A1            AND C                         
  018B:  12            DB 0x12                       
  018C:  CF            RST 08h                       
  018D:  29            ADD HL,HL                     
  018E:  C9            RET                           
  018F:  B1            OR C                          
  0190:  18 F9         JR 0x018B                       ; -> 0x018B
  0192:  A1            AND C                         
  0193:  C6 FF         ADD A,0xFF                    
  0195:  9F            SBC A,A                       
  0196:  E5            PUSH HL                       
  0197:  CD 8D 09      CALL 0x098D                   
  019A:  E1            POP HL                        
  019B:  18 EF         JR 0x018C                       ; -> 0x018C
  019D:  D7            RST 10h                       
  019E:  E5            PUSH HL                       
  019F:  3A 99 40      LD A,(0x4099)                 
  01A2:  B7            OR A                          
  01A3:  20 06         JR NZ,0x01AB                    ; -> 0x01AB
  01A5:  CD 58 03      CALL 0x0358                   
  01A8:  B7            OR A                          
  01A9:  28 11         JR Z,0x01BC                     ; -> 0x01BC
  01AB:  F5            PUSH AF                       
  01AC:  AF            XOR A                         
  01AD:  32 99 40      LD (0x4099),A                   ; → RAM sistema
  01B0:  3C            INC A                         
  01B1:  CD 57 28      CALL 0x2857                   
  01B4:  F1            POP AF                        
  01B5:  2A D4 40      LD HL,(0x40D4)                
  01B8:  77            LD (HL),A                     
  01B9:  C3 84 28      JP 0x2884                     
  01BC:  21 28 19      LD HL,0x1928                  
  01BF:  22 21 41      LD (0x4121),HL                
  01C2:  3E 03         LD A,0x03                     
  01C4:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  01C7:  E1            POP HL                        
  01C8:  C9            RET                           
HW_INIT_2:
  01C9:  3E 1C         LD A,0x1C                     
  01CB:  CD 3A 03      CALL 0x033A                   
  01CE:  3E 1F         LD A,0x1F                     
  01D0:  C3 3A 03      JP 0x033A                     
  01D3:  ED 5F         LD A,R                        
  01D5:  32 AB 40      LD (0x40AB),A                   ; → RAM sistema
  01D8:  C9            RET                           
SERIAL_SEND_BYTE:
  01D9:  3A 3D 40      LD A,(sys_state_flag)         
  01DC:  EE 01         XOR 0x01                      
  01DE:  D3 FF         OUT (port_cassette),A           ; cassete/serial bit-bang
  01E0:  40            LD B,B                        
  01E1:  32 3D 40      LD (sys_state_flag),A           ; → RAM sistema
  01E4:  C9            RET                           
  01E5:  CD D9 01      CALL SERIAL_SEND_BYTE         
  01E8:  3E 20         LD A,0x20                     
  01EA:  3D            DEC A                         
  01EB:  20 FD         JR NZ,0x01EA                    ; -> 0x01EA
  01ED:  C9            RET                           
  01EE:  3E 24         LD A,0x24                     
  01F0:  18 F8         JR 0x01EA                       ; -> 0x01EA
  01F2:  00            NOP                           
  01F3:  00            NOP                           
  01F4:  00            NOP                           
  01F5:  00            NOP                           
  01F6:  00            NOP                           
  01F7:  00            NOP                           
  01F8:  E5            PUSH HL                       
  01F9:  21 00 FB      LD HL,0xFB00                  
  01FC:  18 1B         JR 0x0219                       ; -> 0x0219
  01FE:  7E            LD A,(HL)                     
  01FF:  D6 23         SUB 0x23                      
  0201:  3E 00         LD A,0x00                     
  0203:  20 0D         JR NZ,0x0212                    ; -> 0x0212
  0205:  CD 01 2B      CALL 0x2B01                   
  0208:  CF            RST 08h                       
  0209:  2C            INC L                         
  020A:  7B            LD A,E                        
  020B:  A2            AND D                         
  020C:  C6 02         ADD A,0x02                    
  020E:  D2 4A 1E      JP NC,0x1E4A                  
  0211:  3D            DEC A                         
  0212:  32 E4 37      LD (0x37E4),A                 
  0215:  E5            PUSH HL                       
  0216:  21 04 FF      LD HL,0xFF04                  
  0219:  CD 21 02      CALL 0x0221                   
  021C:  E1            POP HL                        
  021D:  C9            RET                           
  021E:  21 00 FF      LD HL,0xFF00                  
  0221:  3A 3D 40      LD A,(sys_state_flag)         
  0224:  A4            AND H                         
  0225:  B5            OR L                          
  0226:  D3 FF         OUT (port_cassette),A           ; cassete/serial bit-bang
  0228:  32 3D 40      LD (sys_state_flag),A           ; → RAM sistema
  022B:  C9            RET                           
  022C:  3A 3F 3C      LD A,(vram_post_flag2)          ; ← VRAM
  022F:  EE 0A         XOR 0x0A                      
  0231:  32 3F 3C      LD (vram_post_flag2),A          ; → VRAM
  0234:  C9            RET                           
SERIAL_SEND_8BITS:
  0235:  C5            PUSH BC                       
  0236:  06 08         LD B,0x08                     
  0238:  CD 3F 02      CALL 0x023F                   
  023B:  10 FB         DJNZ 0x0238                     ; loop para 0x0238
  023D:  C1            POP BC                        
  023E:  C9            RET                           
  023F:  C5            PUSH BC                       
  0240:  4F            LD C,A                        
  0241:  DB FF         IN A,(port_cassette)            ; cassete/serial bit-bang
  0243:  47            LD B,A                        
  0244:  DB FF         IN A,(port_cassette)            ; cassete/serial bit-bang
  0246:  A8            XOR B                         
  0247:  F2 44 02      JP P,0x0244                   
  024A:  A8            XOR B                         
  024B:  06 43         LD B,0x43                     
  024D:  10 FE         DJNZ 0x024D                     ; loop para 0x024D
  024F:  47            LD B,A                        
  0250:  DB FF         IN A,(port_cassette)            ; cassete/serial bit-bang
  0252:  A8            XOR B                         
  0253:  07            RLCA                          
  0254:  79            LD A,C                        
  0255:  17            RLA                           
  0256:  C1            POP BC                        
  0257:  C9            RET                           

;
; ─── SEÇÃO 3: COLD START HANDLER (0x0258-0x0673) ──────────────────
; Entry point principal do reset
; Escreve magic byte em RAM sobreposta (0x37EC) e vai para init de HW

COLD_START:
  0258:  21 EC 37      LD HL,magic_boot_byte           ; ← RAM sobreposta
  025B:  36 D0         LD (HL),0xD0                  
  025D:  C3 74 06      JP BOOT_HW_INIT               
  0260:  00            NOP                           
  0261:  CD 64 02      CALL SERIAL_SEND_1BIT         
SERIAL_SEND_1BIT:
  0264:  C5            PUSH BC                       
  0265:  F5            PUSH AF                       
  0266:  06 08         LD B,0x08                     
  0268:  4F            LD C,A                        
  0269:  CD E5 01      CALL 0x01E5                   
  026C:  CB 01         RLC C                         
  026E:  D4 EE 01      CALL NC,0x01EE                
  0271:  DC E5 01      CALL C,0x01E5                 
  0274:  7F            LD A,A                        
  0275:  10 F2         DJNZ 0x0269                     ; loop para 0x0269
  0277:  06 1E         LD B,0x1E                     
  0279:  10 FE         DJNZ 0x0279                     ; loop para 0x0279
  027B:  F1            POP AF                        
  027C:  C1            POP BC                        
  027D:  C9            RET                           
  027E:  00            NOP                           
  027F:  00            NOP                           
  0280:  00            NOP                           
  0281:  00            NOP                           
  0282:  00            NOP                           
  0283:  00            NOP                           
  0284:  CD FE 01      CALL 0x01FE                   
  0287:  06 FF         LD B,0xFF                     
  0289:  AF            XOR A                         
  028A:  CD 64 02      CALL SERIAL_SEND_1BIT         
  028D:  10 FB         DJNZ 0x028A                     ; loop para 0x028A
  028F:  3E A5         LD A,0xA5                     
  0291:  18 D1         JR SERIAL_SEND_1BIT             ; -> 0x0264
  0293:  CD FE 01      CALL 0x01FE                   
  0296:  AF            XOR A                         
  0297:  CD 3F 02      CALL 0x023F                   
  029A:  FE A5         CP 0xA5                       
  029C:  20 F9         JR NZ,0x0297                    ; -> 0x0297
  029E:  3E 2A         LD A,0x2A                     
  02A0:  32 3F 3C      LD (vram_post_flag2),A          ; → VRAM
  02A3:  32 3E 3C      LD (vram_post_flag1),A          ; → VRAM
  02A6:  C9            RET                           
  02A7:  00            NOP                           
  02A8:  00            NOP                           
  02A9:  CD 14 03      CALL 0x0314                   
  02AC:  22 DF 40      LD (ptr_program),HL           
  02AF:  CD F8 01      CALL 0x01F8                   
  02B2:  CD E2 41      CALL 0x41E2                   
  02B5:  31 88 42      LD SP,0x4288                  
  02B8:  CD FE 20      CALL BASIC_PROMPT_LOOP        
  02BB:  3E 2A         LD A,0x2A                     
  02BD:  CD 2A 03      CALL DISPLAY_CHAR             
  02C0:  CD B3 1B      CALL PROTEGER_HW_READ         
  02C3:  DA CC 06      JP C,0x06CC                   
  02C6:  D7            RST 10h                       
  02C7:  CA 97 19      JP Z,0x1997                   
  02CA:  FE 2F         CP 0x2F                       
  02CC:  28 4F         JR Z,0x031D                     ; -> 0x031D
  02CE:  CD 93 02      CALL 0x0293                   
  02D1:  CD 35 02      CALL SERIAL_SEND_8BITS        
  02D4:  FE 55         CP 0x55                       
  02D6:  20 F9         JR NZ,0x02D1                    ; -> 0x02D1
  02D8:  06 06         LD B,0x06                     
  02DA:  7E            LD A,(HL)                     
  02DB:  B7            OR A                          
  02DC:  28 09         JR Z,0x02E7                     ; -> 0x02E7
  02DE:  CD 35 02      CALL SERIAL_SEND_8BITS        
  02E1:  BE            DB 0xBE                       
  02E2:  20 ED         JR NZ,0x02D1                    ; -> 0x02D1
  02E4:  23            INC HL                        
  02E5:  10 F3         DJNZ 0x02DA                     ; loop para 0x02DA
  02E7:  CD 2C 02      CALL 0x022C                   
  02EA:  CD 35 02      CALL SERIAL_SEND_8BITS        
  02ED:  FE 78         CP 0x78                       
  02EF:  28 B8         JR Z,0x02A9                     ; -> 0x02A9
  02F1:  FE 3C         CP 0x3C                       
  02F3:  20 F5         JR NZ,0x02EA                    ; -> 0x02EA
  02F5:  CD 35 02      CALL SERIAL_SEND_8BITS        
  02F8:  47            LD B,A                        
  02F9:  CD 14 03      CALL 0x0314                   
  02FC:  85            ADD A,L                       
  02FD:  4F            LD C,A                        
  02FE:  CD 35 02      CALL SERIAL_SEND_8BITS        
  0301:  77            LD (HL),A                     
  0302:  23            INC HL                        
  0303:  81            ADD A,C                       
  0304:  4F            LD C,A                        
  0305:  10 F7         DJNZ 0x02FE                     ; loop para 0x02FE
  0307:  CD 35 02      CALL SERIAL_SEND_8BITS        
  030A:  B9            CP C                          
  030B:  28 DA         JR Z,0x02E7                     ; -> 0x02E7
  030D:  3E 43         LD A,0x43                     
  030F:  32 3E 3C      LD (vram_post_flag1),A          ; → VRAM
  0312:  18 D6         JR 0x02EA                       ; -> 0x02EA
  0314:  CD 35 02      CALL SERIAL_SEND_8BITS        
  0317:  6F            LD L,A                        
  0318:  CD 35 02      CALL SERIAL_SEND_8BITS        
  031B:  67            LD H,A                        
  031C:  C9            RET                           
  031D:  EB            EX DE,HL                      
  031E:  2A DF 40      LD HL,(ptr_program)           
  0321:  EB            EX DE,HL                      
  0322:  D7            RST 10h                       
  0323:  C4 5A 1E      CALL NZ,0x1E5A                
  0326:  20 8A         JR NZ,0x02B2                    ; -> 0x02B2
  0328:  EB            EX DE,HL                      
  0329:  E9            JP (HL)                       
DISPLAY_CHAR:
  032A:  C5            PUSH BC                       
  032B:  4F            LD C,A                        
  032C:  CD C1 41      CALL 0x41C1                   
  032F:  3A 9C 40      LD A,(0x409C)                 
  0332:  B7            OR A                          
  0333:  79            LD A,C                        
  0334:  C1            POP BC                        
  0335:  FA EF 35      JP M,0x35EF                   
  0338:  20 62         JR NZ,0x039C                    ; -> 0x039C
  033A:  D5            PUSH DE                       
  033B:  CD 33 00      CALL 0x0033                   
  033E:  F5            PUSH AF                       
  033F:  CD 48 03      CALL 0x0348                   
  0342:  32 A6 40      LD (sys_ctrl_main),A            ; → RAM sistema
  0345:  F1            POP AF                        
  0346:  D1            POP DE                        
  0347:  C9            RET                           
  0348:  3A 3D 40      LD A,(sys_state_flag)         
  034B:  E6 08         AND 0x08                      
  034D:  3A 20 40      LD A,(0x4020)                 
  0350:  28 03         JR Z,0x0355                     ; -> 0x0355
  0352:  0F            RRCA                          
  0353:  E6 1F         AND 0x1F                      
  0355:  E6 3F         AND 0x3F                      
  0357:  C9            RET                           
  0358:  CD C4 41      CALL 0x41C4                   
  035B:  D5            PUSH DE                       
  035C:  CD 2B 00      CALL 0x002B                   
  035F:  D1            POP DE                        
  0360:  C9            RET                           
  0361:  AF            XOR A                         
  0362:  32 99 40      LD (0x4099),A                   ; → RAM sistema
  0365:  32 A6 40      LD (sys_ctrl_main),A            ; → RAM sistema
  0368:  CD AF 41      CALL 0x41AF                   
  036B:  C5            PUSH BC                       
  036C:  2A A7 40      LD HL,(0x40A7)                
  036F:  06 F0         LD B,0xF0                     
  0371:  CD D9 05      CALL 0x05D9                   
  0374:  F5            PUSH AF                       
  0375:  48            LD C,B                        
  0376:  06 00         LD B,0x00                     
  0378:  09            ADD HL,BC                     
  0379:  36 00         LD (HL),0x00                  
  037B:  2A A7 40      LD HL,(0x40A7)                
  037E:  F1            POP AF                        
  037F:  C1            POP BC                        
  0380:  2B            DEC HL                        
  0381:  D8            RET C                         
  0382:  AF            XOR A                         
  0383:  C9            RET                           
  0384:  CD 58 03      CALL 0x0358                   
  0387:  B7            OR A                          
  0388:  C0            RET NZ                        
  0389:  18 F9         JR 0x0384                       ; -> 0x0384
  038B:  AF            XOR A                         
  038C:  32 9C 40      LD (0x409C),A                   ; → RAM sistema
  038F:  3A 9B 40      LD A,(0x409B)                 
  0392:  B7            OR A                          
  0393:  C8            RET Z                         
  0394:  3E 0D         LD A,0x0D                     
  0396:  D5            PUSH DE                       
  0397:  CD 9C 03      CALL 0x039C                   
  039A:  D1            POP DE                        
  039B:  C9            RET                           
  039C:  F5            PUSH AF                       
  039D:  D5            PUSH DE                       
  039E:  C5            PUSH BC                       
  039F:  4F            LD C,A                        
  03A0:  1E 00         LD E,0x00                     
  03A2:  FE 0C         CP 0x0C                       
  03A4:  28 10         JR Z,0x03B6                     ; -> 0x03B6
  03A6:  FE 0A         CP 0x0A                       
  03A8:  20 03         JR NZ,0x03AD                    ; -> 0x03AD
  03AA:  3E 0D         LD A,0x0D                     
  03AC:  4F            LD C,A                        
  03AD:  FE 0D         CP 0x0D                       
  03AF:  28 05         JR Z,0x03B6                     ; -> 0x03B6
  03B1:  3A 9B 40      LD A,(0x409B)                 
  03B4:  3C            INC A                         
  03B5:  5F            LD E,A                        
  03B6:  7B            LD A,E                        
  03B7:  32 9B 40      LD (0x409B),A                   ; → RAM sistema
  03BA:  79            LD A,C                        
  03BB:  CD 3B 00      CALL 0x003B                   
  03BE:  C1            POP BC                        
  03BF:  D1            POP DE                        
  03C0:  F1            POP AF                        
  03C1:  C9            RET                           
BASIC_EVAL:
  03C2:  E5            PUSH HL                       
  03C3:  DD E5         PUSH IX                       
  03C5:  D5            PUSH DE                       
  03C6:  DD E1         POP IX                        
  03C8:  D5            PUSH DE                       
  03C9:  21 DD 03      LD HL,0x03DD                  
  03CC:  E5            PUSH HL                       
  03CD:  4F            LD C,A                        
  03CE:  1A            DB 0x1A                       
  03CF:  A0            AND B                         
  03D0:  B8            CP B                          
  03D1:  C2 33 40      JP NZ,0x4033                  
  03D4:  FE 02         CP 0x02                       
  03D6:  DD 6E         DB 0xDD,0x6E                    ; instrução IX
  03D8:  01 DD 66      LD BC,0x66DD                  
  03DB:  02            DB 0x02                       
  03DC:  E9            JP (HL)                       
  03DD:  D1            POP DE                        
  03DE:  DD E1         POP IX                        
  03E0:  E1            POP HL                        
  03E1:  C1            POP BC                        
  03E2:  C9            RET                           
  03E3:  21 36 40      LD HL,0x4036                    ; ← RAM sistema
  03E6:  01 01 38      LD BC,0x3801                  
  03E9:  16 00         LD D,0x00                     
  03EB:  0A            DB 0x0A                       
  03EC:  5F            LD E,A                        
  03ED:  CD 03 30      CALL 0x3003                   
  03F0:  20 08         JR NZ,0x03FA                    ; -> 0x03FA
  03F2:  14            INC D                         
  03F3:  2C            INC L                         
  03F4:  CB 01         RLC C                         
  03F6:  F2 EB 03      JP P,0x03EB                   
  03F9:  C9            RET                           
  03FA:  5F            LD E,A                        
  03FB:  C3 1C 01      JP 0x011C                     
  03FE:  07            RLCA                          
  03FF:  57            LD D,A                        
  0400:  0E 01         LD C,0x01                     
  0402:  79            LD A,C                        
  0403:  A3            AND E                         
  0404:  20 05         JR NZ,0x040B                    ; -> 0x040B
  0406:  14            INC D                         
  0407:  CB 01         RLC C                         
  0409:  18 F7         JR 0x0402                       ; -> 0x0402
  040B:  3A 80 38      LD A,(0x3880)                   ; ← RAM sobreposta
  040E:  DD 4E 03      LD C,(IX+3)                   
  0411:  B1            OR C                          
  0412:  47            LD B,A                        
  0413:  7A            LD A,D                        
  0414:  FE 1E         CP 0x1E                       
  0416:  20 09         JR NZ,0x0421                    ; -> 0x0421
  0418:  3E 80         LD A,0x80                     
  041A:  A9            XOR C                         
  041B:  DD 77 03      LD (IX+3),A                   
  041E:  AF            XOR A                         
  041F:  18 35         JR 0x0456                       ; -> 0x0456
  0421:  C6 60         ADD A,0x60                    
  0423:  FE 80         CP 0x80                       
  0425:  30 14         JR NC,0x043B                    ; -> 0x043B
  0427:  CB 70         DB 0xCB,0x70                  
  0429:  20 2C         JR NZ,0x0457                    ; -> 0x0457
  042B:  FE 60         CP 0x60                       
  042D:  28 04         JR Z,0x0433                     ; -> 0x0433
  042F:  CB 78         BIT 7,B                       
  0431:  28 02         JR Z,0x0435                     ; -> 0x0435
  0433:  EE 20         XOR 0x20                      
  0435:  CB 38         SRL B                         
  0437:  38 FA         JR C,0x0433                     ; -> 0x0433
  0439:  18 1B         JR 0x0456                       ; -> 0x0456
  043B:  D6 90         SUB 0x90                      
  043D:  30 0E         JR NC,0x044D                    ; -> 0x044D
  043F:  C6 40         ADD A,0x40                    
  0441:  FE 3C         CP 0x3C                       
  0443:  38 02         JR C,0x0447                     ; -> 0x0447
  0445:  EE 10         XOR 0x10                      
  0447:  CB 38         SRL B                         
  0449:  30 0B         JR NC,0x0456                    ; -> 0x0456
  044B:  18 F8         JR 0x0445                       ; -> 0x0445
  044D:  07            RLCA                          
  044E:  CB 38         SRL B                         
  0450:  CE 50         ADC A,0x50                    
  0452:  6F            LD L,A                        
  0453:  26 00         LD H,0x00                     
  0455:  7E            LD A,(HL)                     
  0456:  57            LD D,A                        
  0457:  06 60         LD B,0x60                     
  0459:  CD E5 01      CALL 0x01E5                   
  045C:  10 FB         DJNZ 0x0459                     ; loop para 0x0459
  045E:  7A            LD A,D                        
  045F:  FE 01         CP 0x01                       
  0461:  C0            RET NZ                        
  0462:  EF            RST 28h                       
  0463:  C9            RET                           
  0464:  DD 6E         DB 0xDD,0x6E                    ; instrução IX
  0466:  03            INC BC                        
  0467:  DD 66         DB 0xDD,0x66                    ; instrução IX
  0469:  04            INC B                         
  046A:  38 2E         JR C,0x049A                     ; -> 0x049A
  046C:  DD 7E 05      LD A,(IX+5)                   
  046F:  B7            OR A                          
  0470:  28 01         JR Z,0x0473                     ; -> 0x0473
  0472:  77            LD (HL),A                     
  0473:  79            LD A,C                        
  0474:  FE 20         CP 0x20                       
  0476:  DA 06 05      JP C,0x0506                   
  0479:  FE 80         CP 0x80                       
  047B:  30 29         JR NC,0x04A6                    ; -> 0x04A6
  047D:  CD 41 05      CALL SCREEN_SCROLL_ENTRY      
  0480:  7C            LD A,H                        
  0481:  E6 03         AND 0x03                      
  0483:  F6 3C         OR 0x3C                       
  0485:  67            LD H,A                        
  0486:  56            DB 0x56                         ; 'V'
  0487:  DD 7E 05      LD A,(IX+5)                   
  048A:  B7            OR A                          
  048B:  28 05         JR Z,0x0492                     ; -> 0x0492
  048D:  DD 72         DB 0xDD,0x72                    ; instrução IX
  048F:  05            DEC B                         
  0490:  36 0D         LD (HL),0x0D                  
  0492:  DD 75         DB 0xDD,0x75                    ; instrução IX
  0494:  03            INC BC                        
  0495:  DD 74         DB 0xDD,0x74                    ; instrução IX
  0497:  04            INC B                         
  0498:  79            LD A,C                        
  0499:  C9            RET                           
  049A:  DD 7E 05      LD A,(IX+5)                   
  049D:  B7            OR A                          
  049E:  C0            RET NZ                        
  049F:  7E            LD A,(HL)                     
  04A0:  C9            RET                           
  04A1:  7D            LD A,L                        
  04A2:  E6 C0         AND 0xC0                      
  04A4:  6F            LD L,A                        
  04A5:  C9            RET                           
  04A6:  FE C0         CP 0xC0                       
  04A8:  38 D3         JR C,0x047D                     ; -> 0x047D
  04AA:  D6 C0         SUB 0xC0                      
  04AC:  28 D2         JR Z,0x0480                     ; -> 0x0480
  04AE:  47            LD B,A                        
  04AF:  3E 20         LD A,0x20                     
  04B1:  CD 41 05      CALL SCREEN_SCROLL_ENTRY      
  04B4:  10 F9         DJNZ 0x04AF                     ; loop para 0x04AF
  04B6:  18 C8         JR 0x0480                       ; -> 0x0480
  04B8:  7E            LD A,(HL)                     
  04B9:  DD 77 05      LD (IX+5),A                   
  04BC:  C9            RET                           
  04BD:  AF            XOR A                         
  04BE:  18 F9         JR 0x04B9                       ; -> 0x04B9
VRAM_FILL:
  04C0:  21 00 3C      LD HL,VRAM_BASE                 ; ← VRAM
  04C3:  3A 3D 40      LD A,(sys_state_flag)         
  04C6:  E6 F7         AND 0xF7                      
  04C8:  32 3D 40      LD (sys_state_flag),A           ; → RAM sistema
  04CB:  D3 FF         OUT (port_cassette),A           ; cassete/serial bit-bang
  04CD:  C9            RET                           
  04CE:  2B            DEC HL                        
  04CF:  3A 3D 40      LD A,(sys_state_flag)         
  04D2:  E6 08         AND 0x08                      
  04D4:  28 01         JR Z,0x04D7                     ; -> 0x04D7
  04D6:  2B            DEC HL                        
  04D7:  36 20         LD (HL),0x20                  
  04D9:  C9            RET                           
  04DA:  3A 3D 40      LD A,(sys_state_flag)         
  04DD:  E6 08         AND 0x08                      
  04DF:  C4 E2 04      CALL NZ,0x04E2                
  04E2:  7D            LD A,L                        
  04E3:  E6 3F         AND 0x3F                      
  04E5:  2B            DEC HL                        
  04E6:  C0            RET NZ                        
  04E7:  11 40 00      LD DE,0x0040                  
  04EA:  19            ADD HL,DE                     
  04EB:  C9            RET                           
  04EC:  23            INC HL                        
  04ED:  7D            LD A,L                        
  04EE:  E6 3F         AND 0x3F                      
  04F0:  C0            RET NZ                        
  04F1:  11 C0 FF      LD DE,0xFFC0                  
  04F4:  19            ADD HL,DE                     
  04F5:  C9            RET                           
  04F6:  3A 3D 40      LD A,(sys_state_flag)         
  04F9:  F6 08         OR 0x08                       
  04FB:  32 3D 40      LD (sys_state_flag),A           ; → RAM sistema
  04FE:  D3 FF         OUT (port_cassette),A           ; cassete/serial bit-bang
  0500:  23            INC HL                        
  0501:  7D            LD A,L                        
  0502:  E6 FE         AND 0xFE                      
  0504:  6F            LD L,A                        
  0505:  C9            RET                           
  0506:  11 80 04      LD DE,0x0480                  
  0509:  D5            PUSH DE                       
  050A:  FE 08         CP 0x08                       
  050C:  28 C0         JR Z,0x04CE                     ; -> 0x04CE
  050E:  FE 0A         CP 0x0A                       
  0510:  D8            RET C                         
  0511:  FE 0E         CP 0x0E                       
  0513:  38 4F         JR C,0x0564                     ; -> 0x0564
  0515:  28 A1         JR Z,0x04B8                     ; -> 0x04B8
  0517:  FE 0F         CP 0x0F                       
  0519:  28 A2         JR Z,0x04BD                     ; -> 0x04BD
  051B:  FE 17         CP 0x17                       
  051D:  28 D7         JR Z,0x04F6                     ; -> 0x04F6
  051F:  FE 18         CP 0x18                       
  0521:  28 B7         JR Z,0x04DA                     ; -> 0x04DA
  0523:  FE 19         CP 0x19                       
  0525:  28 C5         JR Z,0x04EC                     ; -> 0x04EC
  0527:  FE 1A         CP 0x1A                       
  0529:  28 BC         JR Z,0x04E7                     ; -> 0x04E7
  052B:  FE 1B         CP 0x1B                       
  052D:  28 C2         JR Z,0x04F1                     ; -> 0x04F1
  052F:  FE 1C         CP 0x1C                       
  0531:  28 8D         JR Z,VRAM_FILL                  ; -> 0x04C0
  0533:  FE 1D         CP 0x1D                       
  0535:  CA A1 04      JP Z,0x04A1                   
  0538:  FE 1E         CP 0x1E                       
  053A:  28 37         JR Z,0x0573                     ; -> 0x0573
  053C:  FE 1F         CP 0x1F                       
  053E:  28 3C         JR Z,0x057C                     ; -> 0x057C
  0540:  C9            RET                           

;
; ─── SEÇÃO 4: ROTINAS DE VÍDEO ─────────────────────────────────────
; VRAM em 0x3C00-0x3FFF (64 colunas × 16 linhas = 1024 bytes)
; PROVA de compatibilidade de mapa com TRS-80 Model I (não Model III!)

SCREEN_SCROLL_ENTRY:
  0541:  77            LD (HL),A                     
  0542:  23            INC HL                        
  0543:  3A 3D 40      LD A,(sys_state_flag)         
  0546:  E6 08         AND 0x08                      
  0548:  28 01         JR Z,0x054B                     ; -> 0x054B
  054A:  23            INC HL                        
  054B:  7C            LD A,H                        
  054C:  FE 40         CP 0x40                       
  054E:  C0            RET NZ                        
  054F:  11 C0 FF      LD DE,0xFFC0                  
  0552:  19            ADD HL,DE                     
  0553:  E5            PUSH HL                       
VRAM_SCROLL_UP:
  0554:  11 00 3C      LD DE,VRAM_BASE                 ; ← VRAM
  0557:  21 40 3C      LD HL,VRAM_LINE2                ; ← VRAM
  055A:  C5            PUSH BC                       
  055B:  01 C0 03      LD BC,0x03C0                  
  055E:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  0560:  C1            POP BC                        
  0561:  EB            EX DE,HL                      
  0562:  18 19         JR 0x057D                       ; -> 0x057D
  0564:  7D            LD A,L                        
  0565:  E6 C0         AND 0xC0                      
  0567:  6F            LD L,A                        
  0568:  E5            PUSH HL                       
  0569:  11 40 00      LD DE,0x0040                  
  056C:  19            ADD HL,DE                     
  056D:  7C            LD A,H                        
  056E:  FE 40         CP 0x40                       
  0570:  28 E2         JR Z,VRAM_SCROLL_UP             ; -> 0x0554
  0572:  D1            POP DE                        
  0573:  E5            PUSH HL                       
  0574:  54            LD D,H                        
  0575:  7D            LD A,L                        
  0576:  F6 3F         OR 0x3F                       
  0578:  5F            LD E,A                        
  0579:  13            INC DE                        
  057A:  18 04         JR 0x0580                       ; -> 0x0580
  057C:  E5            PUSH HL                       
  057D:  11 00 40      LD DE,RST_JTABLE                ; ← RAM sistema
  0580:  36 20         LD (HL),0x20                  
  0582:  23            INC HL                        
  0583:  7C            LD A,H                        
  0584:  BA            CP D                          
  0585:  20 F9         JR NZ,0x0580                    ; -> 0x0580
  0587:  7D            LD A,L                        
  0588:  BB            CP E                          
  0589:  20 F5         JR NZ,0x0580                    ; -> 0x0580
  058B:  E1            POP HL                        
  058C:  C9            RET                           
  058D:  79            LD A,C                        
  058E:  B7            OR A                          
  058F:  28 40         JR Z,0x05D1                     ; -> 0x05D1
  0591:  FE 0B         CP 0x0B                       
  0593:  28 0A         JR Z,0x059F                     ; -> 0x059F
  0595:  FE 0C         CP 0x0C                       
  0597:  20 1B         JR NZ,0x05B4                    ; -> 0x05B4
  0599:  AF            XOR A                         
  059A:  DD B6 03      OR (IX+3)                     
  059D:  28 15         JR Z,0x05B4                     ; -> 0x05B4
  059F:  DD 7E 03      LD A,(IX+3)                   
  05A2:  DD 96         DB 0xDD,0x96                    ; instrução IX
  05A4:  04            INC B                         
  05A5:  47            LD B,A                        
  05A6:  CD D1 05      CALL 0x05D1                   
  05A9:  20 FB         JR NZ,0x05A6                    ; -> 0x05A6
  05AB:  3E 0A         LD A,0x0A                     
  05AD:  32 E8 37      LD (0x37E8),A                 
  05B0:  10 F4         DJNZ 0x05A6                     ; loop para 0x05A6
  05B2:  18 18         JR 0x05CC                       ; -> 0x05CC
  05B4:  F5            PUSH AF                       
  05B5:  CD D1 05      CALL 0x05D1                   
  05B8:  20 FB         JR NZ,0x05B5                    ; -> 0x05B5
  05BA:  F1            POP AF                        
  05BB:  32 E8 37      LD (0x37E8),A                 
  05BE:  FE 0D         CP 0x0D                       
  05C0:  C0            RET NZ                        
  05C1:  DD 34 04      INC (IX+4)                    
  05C4:  DD 7E 04      LD A,(IX+4)                   
  05C7:  DD BE 03      CP (IX+3)                     
  05CA:  79            LD A,C                        
  05CB:  C0            RET NZ                        
  05CC:  DD 36 04 00   LD (IX+4),0x00                
  05D0:  C9            RET                           
  05D1:  3A E8 37      LD A,(0x37E8)                 
  05D4:  E6 F0         AND 0xF0                      
  05D6:  FE 30         CP 0x30                       
  05D8:  C9            RET                           
  05D9:  E5            PUSH HL                       
  05DA:  3E 0E         LD A,0x0E                     
  05DC:  CD 33 00      CALL 0x0033                   
  05DF:  48            LD C,B                        
  05E0:  CD 49 00      CALL 0x0049                   
  05E3:  FE 20         CP 0x20                       
  05E5:  30 25         JR NC,0x060C                    ; -> 0x060C
  05E7:  FE 0D         CP 0x0D                       
  05E9:  CA 62 06      JP Z,0x0662                   
  05EC:  FE 1F         CP 0x1F                       
  05EE:  28 29         JR Z,0x0619                     ; -> 0x0619
  05F0:  FE 01         CP 0x01                       
  05F2:  28 6D         JR Z,0x0661                     ; -> 0x0661
  05F4:  11 E0 05      LD DE,0x05E0                  
  05F7:  D5            PUSH DE                       
  05F8:  FE 08         CP 0x08                       
  05FA:  28 34         JR Z,0x0630                     ; -> 0x0630
  05FC:  FE 18         CP 0x18                       
  05FE:  28 2B         JR Z,0x062B                     ; -> 0x062B
  0600:  FE 09         CP 0x09                       
  0602:  28 42         JR Z,0x0646                     ; -> 0x0646
  0604:  FE 19         CP 0x19                       
  0606:  28 39         JR Z,0x0641                     ; -> 0x0641
  0608:  FE 0A         CP 0x0A                       
  060A:  C0            RET NZ                        
  060B:  D1            POP DE                        
  060C:  77            LD (HL),A                     
  060D:  78            LD A,B                        
  060E:  B7            OR A                          
  060F:  28 CF         JR Z,0x05E0                     ; -> 0x05E0
  0611:  7E            LD A,(HL)                     
  0612:  23            INC HL                        
  0613:  CD 33 00      CALL 0x0033                   
  0616:  05            DEC B                         
  0617:  18 C7         JR 0x05E0                       ; -> 0x05E0
  0619:  CD C9 01      CALL HW_INIT_2                
  061C:  41            LD B,C                        
  061D:  E1            POP HL                        
  061E:  E5            PUSH HL                       
  061F:  C3 E0 05      JP 0x05E0                     
  0622:  CD 30 06      CALL 0x0630                   
  0625:  2B            DEC HL                        
  0626:  7E            LD A,(HL)                     
  0627:  23            INC HL                        
  0628:  FE 0A         CP 0x0A                       
  062A:  C8            RET Z                         
  062B:  78            LD A,B                        
  062C:  B9            CP C                          
  062D:  20 F3         JR NZ,0x0622                    ; -> 0x0622
  062F:  C9            RET                           
  0630:  78            LD A,B                        
  0631:  B9            CP C                          
  0632:  C8            RET Z                         
  0633:  2B            DEC HL                        
  0634:  7E            LD A,(HL)                     
  0635:  FE 0A         CP 0x0A                       
  0637:  23            INC HL                        
  0638:  C8            RET Z                         
  0639:  2B            DEC HL                        
  063A:  3E 08         LD A,0x08                     
  063C:  CD 33 00      CALL 0x0033                   
  063F:  04            INC B                         
  0640:  C9            RET                           
  0641:  3E 17         LD A,0x17                     
  0643:  C3 33 00      JP 0x0033                     
  0646:  CD 48 03      CALL 0x0348                   
  0649:  E6 07         AND 0x07                      
  064B:  2F            CPL                           
  064C:  3C            INC A                         
  064D:  C6 08         ADD A,0x08                    
  064F:  5F            LD E,A                        
  0650:  78            LD A,B                        
  0651:  B7            OR A                          
  0652:  C8            RET Z                         
  0653:  3E 20         LD A,0x20                     
  0655:  77            LD (HL),A                     
  0656:  23            INC HL                        
  0657:  D5            PUSH DE                       
  0658:  CD 33 00      CALL 0x0033                   
  065B:  D1            POP DE                        
  065C:  05            DEC B                         
  065D:  1D            DEC E                         
  065E:  C8            RET Z                         
  065F:  18 EF         JR 0x0650                       ; -> 0x0650
  0661:  37            SCF                           
  0662:  F5            PUSH AF                       
  0663:  3E 0D         LD A,0x0D                     
  0665:  77            LD (HL),A                     
  0666:  CD 33 00      CALL 0x0033                   
  0669:  3E 0F         LD A,0x0F                     
  066B:  CD 33 00      CALL 0x0033                   
  066E:  79            LD A,C                        
  066F:  90            SUB B                         
  0670:  47            LD B,A                        
  0671:  F1            POP AF                        
  0672:  E1            POP HL                        
  0673:  C9            RET                           

;
; ─── SEÇÃO 5: BOOT HW INIT (0x0674-0x06D1) ────────────────────────
; Primeira instrução de I/O: OUT (0xFF),A — reset do hardware de cassete
; Instala jump table dos RSTs em RAM 0x4000 via LDIR
; Boot de disco: carrega 256 bytes de 0x37EF para 0x4200 e executa

BOOT_HW_INIT:
  0674:  D3 FF         OUT (port_cassette),A           ; cassete/serial bit-bang
  0676:  21 D2 06      LD HL,0x06D2                  
  0679:  11 00 40      LD DE,RST_JTABLE                ; ← RAM sistema
  067C:  01 36 00      LD BC,0x0036                  
  067F:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  0681:  3D            DEC A                         
  0682:  3D            DEC A                         
  0683:  20 F1         JR NZ,0x0676                    ; -> 0x0676
  0685:  06 27         LD B,0x27                     
  0687:  12            DB 0x12                       
  0688:  13            INC DE                        
  0689:  10 FC         DJNZ 0x0687                     ; loop para 0x0687
  068B:  3A 40 38      LD A,(hw_config_byte)           ; ← RAM sobreposta
  068E:  E6 04         AND 0x04                      
  0690:  C2 75 00      JP NZ,0x0075                  
  0693:  31 7D 40      LD SP,0x407D                  
  0696:  3A EC 37      LD A,(magic_boot_byte)          ; ← RAM sobreposta
  0699:  00            NOP                           
  069A:  FE 80         CP 0x80                       
  069C:  C2 75 00      JP NZ,0x0075                  
  069F:  3E 01         LD A,0x01                     
  06A1:  32 E1 37      LD (0x37E1),A                 
  06A4:  21 EC 37      LD HL,magic_boot_byte           ; ← RAM sobreposta
  06A7:  11 EF 37      LD DE,disk_data_port          
  06AA:  36 03         LD (HL),0x03                  
  06AC:  01 00 00      LD BC,0x0000                  
  06AF:  CD 60 00      CALL 0x0060                   
  06B2:  CB 46         BIT 0,(HL)                    
  06B4:  20 FC         JR NZ,0x06B2                    ; -> 0x06B2
  06B6:  AF            XOR A                         
  06B7:  32 EE 37      LD (0x37EE),A                   ; → RAM sobreposta (atenção: área da ROM!)
  06BA:  01 00 42      LD BC,0x4200                  
  06BD:  3E 8C         LD A,0x8C                     
  06BF:  77            LD (HL),A                     
  06C0:  CB 4E         BIT 1,(HL)                    
  06C2:  28 FC         JR Z,0x06C0                     ; -> 0x06C0
  06C4:  1A            DB 0x1A                       
  06C5:  02            DB 0x02                       
  06C6:  0C            INC C                         
  06C7:  20 F7         JR NZ,0x06C0                    ; -> 0x06C0
  06C9:  C3 00 42      JP 0x4200                     
  06CC:  01 18 1A      LD BC,0x1A18                  
  06CF:  C3 AE 19      JP 0x19AE                     

;
; ─── RST JUMP TABLE SOURCE ─────────────────────────────────────────
; Copiada para RAM 0x4000 no boot (0x36 bytes via LDIR)
; Define os handlers reais de cada RST

RST_JUMP_TABLE_SRC:
  06D2:  C3 96 1C      JP RST1_DISPLAY               
  06D5:  C3 78 1D      JP RST2_DISPLAY               
  06D8:  C3 90 1C      JP RST3_DISPLAY               
  06DB:  C3 D9 25      JP RST4_IO                    
  06DE:  C9            RET                           
  06DF:  00            NOP                           
  06E0:  00            NOP                           
  06E1:  C9            RET                           
  06E2:  00            NOP                           
  06E3:  00            NOP                           
  06E4:  FB            EI                            
  06E5:  C9            RET                           
  06E6:  00            NOP                           
  06E7:  01 E3 03      LD BC,0x03E3                  
  06EA:  00            NOP                           
  06EB:  00            NOP                           
  06EC:  00            NOP                           
  06ED:  4B            LD C,E                        
  06EE:  49            LD C,C                        
  06EF:  07            RLCA                          
  06F0:  64            LD H,H                        
  06F1:  04            INC B                         
  06F2:  00            NOP                           
  06F3:  3C            INC A                         
  06F4:  00            NOP                           
  06F5:  44            LD B,H                        
  06F6:  4F            LD C,A                        
  06F7:  06 8D         LD B,0x8D                     
  06F9:  05            DEC B                         
  06FA:  43            LD B,E                        
  06FB:  00            NOP                           
  06FC:  00            NOP                           
  06FD:  50            LD D,B                        
  06FE:  52            LD D,D                        
  06FF:  C3 00 50      JP 0x5000                     
  0702:  C7            RST 00h                       
  0703:  00            NOP                           
  0704:  00            NOP                           
  0705:  3E 00         LD A,0x00                     
  0707:  C9            RET                           
  0708:  21 80 13      LD HL,0x1380                  
  070B:  CD C2 09      CALL 0x09C2                   
  070E:  18 06         JR 0x0716                       ; -> 0x0716
  0710:  CD C2 09      CALL 0x09C2                   
  0713:  CD 82 09      CALL 0x0982                   
  0716:  78            LD A,B                        
  0717:  B7            OR A                          
  0718:  C8            RET Z                         
  0719:  3A 24 41      LD A,(0x4124)                 
  071C:  B7            OR A                          
  071D:  CA B4 09      JP Z,0x09B4                   
  0720:  90            SUB B                         
  0721:  30 0C         JR NC,0x072F                    ; -> 0x072F
  0723:  2F            CPL                           
  0724:  3C            INC A                         
  0725:  EB            EX DE,HL                      
  0726:  CD A4 09      CALL BASIC_EVAL_EXPR          
  0729:  EB            EX DE,HL                      
  072A:  CD B4 09      CALL 0x09B4                   
  072D:  C1            POP BC                        
  072E:  D1            POP DE                        
  072F:  FE 19         CP 0x19                       
  0731:  D0            RET NC                        
  0732:  F5            PUSH AF                       
  0733:  CD DF 09      CALL 0x09DF                   
  0736:  67            LD H,A                        
  0737:  F1            POP AF                        
  0738:  CD D7 07      CALL 0x07D7                   
  073B:  B4            OR H                          
  073C:  21 21 41      LD HL,0x4121                    ; ← RAM sistema
  073F:  F2 54 07      JP P,0x0754                   
  0742:  CD B7 07      CALL 0x07B7                   
  0745:  D2 96 07      JP NC,0x0796                  
  0748:  23            INC HL                        
  0749:  34            INC (HL)                      
  074A:  CA B2 07      JP Z,0x07B2                   
  074D:  2E 01         LD L,0x01                     
  074F:  CD EB 07      CALL 0x07EB                   
  0752:  18 42         JR 0x0796                       ; -> 0x0796
  0754:  AF            XOR A                         
  0755:  90            SUB B                         
  0756:  47            LD B,A                        
  0757:  7E            LD A,(HL)                     
  0758:  9B            DB 0x9B                       
  0759:  5F            LD E,A                        
  075A:  23            INC HL                        
  075B:  7E            LD A,(HL)                     
  075C:  9A            DB 0x9A                       
  075D:  57            LD D,A                        
  075E:  23            INC HL                        
  075F:  7E            LD A,(HL)                     
  0760:  99            DB 0x99                       
  0761:  4F            LD C,A                        
  0762:  DC C3 07      CALL C,0x07C3                 
  0765:  68            LD L,B                        
  0766:  63            LD H,E                        
  0767:  AF            XOR A                         
  0768:  47            LD B,A                        
  0769:  79            LD A,C                        
  076A:  B7            OR A                          
  076B:  20 18         JR NZ,0x0785                    ; -> 0x0785
  076D:  4A            LD C,D                        
  076E:  54            LD D,H                        
  076F:  65            LD H,L                        
  0770:  6F            LD L,A                        
  0771:  78            LD A,B                        
  0772:  D6 08         SUB 0x08                      
  0774:  FE E0         CP 0xE0                       
  0776:  20 F0         JR NZ,0x0768                    ; -> 0x0768
  0778:  AF            XOR A                         
  0779:  32 24 41      LD (0x4124),A                   ; → RAM sistema
  077C:  C9            RET                           
  077D:  05            DEC B                         
  077E:  29            ADD HL,HL                     
  077F:  7A            LD A,D                        
  0780:  17            RLA                           
  0781:  57            LD D,A                        
  0782:  79            LD A,C                        
  0783:  8F            ADC A,A                       
  0784:  4F            LD C,A                        
  0785:  F2 7D 07      JP P,0x077D                   
  0788:  78            LD A,B                        
  0789:  5C            LD E,H                        
  078A:  45            LD B,L                        
  078B:  B7            OR A                          
  078C:  28 08         JR Z,0x0796                     ; -> 0x0796
  078E:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0791:  86            DB 0x86                       
  0792:  77            LD (HL),A                     
  0793:  30 E3         JR NC,0x0778                    ; -> 0x0778
  0795:  C8            RET Z                         
  0796:  78            LD A,B                        
  0797:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  079A:  B7            OR A                          
  079B:  FC A8 07      CALL M,0x07A8                 
  079E:  46            DB 0x46                         ; 'F'
  079F:  23            INC HL                        
  07A0:  7E            LD A,(HL)                     
  07A1:  E6 80         AND 0x80                      
  07A3:  A9            XOR C                         
  07A4:  4F            LD C,A                        
  07A5:  C3 B4 09      JP 0x09B4                     
  07A8:  1C            INC E                         
  07A9:  C0            RET NZ                        
  07AA:  14            INC D                         
  07AB:  C0            RET NZ                        
  07AC:  0C            INC C                         
  07AD:  C0            RET NZ                        
  07AE:  0E 80         LD C,0x80                     
  07B0:  34            INC (HL)                      
  07B1:  C0            RET NZ                        
  07B2:  1E 0A         LD E,0x0A                     
  07B4:  C3 A2 19      JP 0x19A2                     
  07B7:  7E            LD A,(HL)                     
  07B8:  83            ADD A,E                       
  07B9:  5F            LD E,A                        
  07BA:  23            INC HL                        
  07BB:  7E            LD A,(HL)                     
  07BC:  8A            DB 0x8A                       
  07BD:  57            LD D,A                        
  07BE:  23            INC HL                        
  07BF:  7E            LD A,(HL)                     
  07C0:  89            ADC A,C                       
  07C1:  4F            LD C,A                        
  07C2:  C9            RET                           
  07C3:  21 25 41      LD HL,0x4125                    ; ← RAM sistema
  07C6:  7E            LD A,(HL)                     
  07C7:  2F            CPL                           
  07C8:  77            LD (HL),A                     
  07C9:  AF            XOR A                         
  07CA:  6F            LD L,A                        
  07CB:  90            SUB B                         
  07CC:  47            LD B,A                        
  07CD:  7D            LD A,L                        
  07CE:  9B            DB 0x9B                       
  07CF:  5F            LD E,A                        
  07D0:  7D            LD A,L                        
  07D1:  9A            DB 0x9A                       
  07D2:  57            LD D,A                        
  07D3:  7D            LD A,L                        
  07D4:  99            DB 0x99                       
  07D5:  4F            LD C,A                        
  07D6:  C9            RET                           
  07D7:  06 00         LD B,0x00                     
  07D9:  D6 08         SUB 0x08                      
  07DB:  38 07         JR C,0x07E4                     ; -> 0x07E4
  07DD:  43            LD B,E                        
  07DE:  5A            LD E,D                        
  07DF:  51            LD D,C                        
  07E0:  0E 00         LD C,0x00                     
  07E2:  18 F5         JR 0x07D9                       ; -> 0x07D9
  07E4:  C6 09         ADD A,0x09                    
  07E6:  6F            LD L,A                        
  07E7:  AF            XOR A                         
  07E8:  2D            DEC L                         
  07E9:  C8            RET Z                         
  07EA:  79            LD A,C                        
  07EB:  1F            RRA                           
  07EC:  4F            LD C,A                        
  07ED:  7A            LD A,D                        
  07EE:  1F            RRA                           
  07EF:  57            LD D,A                        
  07F0:  7B            LD A,E                        
  07F1:  1F            RRA                           
  07F2:  5F            LD E,A                        
  07F3:  78            LD A,B                        
  07F4:  1F            RRA                           
  07F5:  47            LD B,A                        
  07F6:  18 EF         JR 0x07E7                       ; -> 0x07E7
  07F8:  00            NOP                           
  07F9:  00            NOP                           
  07FA:  00            NOP                           
  07FB:  81            ADD A,C                       
  07FC:  03            INC BC                        
  07FD:  AA            XOR D                         
  07FE:  56            DB 0x56                         ; 'V'
  07FF:  19            ADD HL,DE                     
  0800:  80            ADD A,B                       
  0801:  F1            POP AF                        
  0802:  22 76 80      LD (0x8076),HL                
  0805:  45            LD B,L                        
  0806:  AA            XOR D                         
  0807:  38 82         JR C,0x078B                     ; -> 0x078B
  0809:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  080C:  B7            OR A                          
  080D:  EA 4A 1E      JP PE,0x1E4A                  
  0810:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0813:  7E            LD A,(HL)                     
  0814:  01 35 80      LD BC,0x8035                  
  0817:  11 F3 04      LD DE,0x04F3                  
  081A:  90            SUB B                         
  081B:  F5            PUSH AF                       
  081C:  70            LD (HL),B                     
  081D:  D5            PUSH DE                       
  081E:  C5            PUSH BC                       
  081F:  CD 16 07      CALL 0x0716                   
  0822:  C1            POP BC                        
  0823:  D1            POP DE                        
  0824:  04            INC B                         
  0825:  CD A2 08      CALL 0x08A2                   
  0828:  21 F8 07      LD HL,0x07F8                  
  082B:  CD 10 07      CALL 0x0710                   
  082E:  21 FC 07      LD HL,0x07FC                  
  0831:  CD 9A 14      CALL 0x149A                   
  0834:  01 80 80      LD BC,0x8080                  
  0837:  11 00 00      LD DE,0x0000                  
  083A:  CD 16 07      CALL 0x0716                   
  083D:  F1            POP AF                        
  083E:  CD 89 0F      CALL 0x0F89                   
  0841:  01 31 80      LD BC,0x8031                  
  0844:  11 18 72      LD DE,0x7218                  
  0847:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  084A:  C8            RET Z                         
  084B:  2E 00         LD L,0x00                     
  084D:  CD 14 09      CALL 0x0914                   
  0850:  79            LD A,C                        
  0851:  32 4F 41      LD (0x414F),A                   ; → RAM sistema
  0854:  EB            EX DE,HL                      
  0855:  22 50 41      LD (0x4150),HL                
  0858:  01 00 00      LD BC,0x0000                  
  085B:  50            LD D,B                        
  085C:  58            LD E,B                        
  085D:  21 65 07      LD HL,0x0765                  
  0860:  E5            PUSH HL                       
  0861:  21 69 08      LD HL,0x0869                  
  0864:  E5            PUSH HL                       
  0865:  E5            PUSH HL                       
  0866:  21 21 41      LD HL,0x4121                    ; ← RAM sistema
  0869:  7E            LD A,(HL)                     
  086A:  23            INC HL                        
  086B:  B7            OR A                          
  086C:  28 24         JR Z,0x0892                     ; -> 0x0892
  086E:  E5            PUSH HL                       
  086F:  2E 08         LD L,0x08                     
  0871:  1F            RRA                           
  0872:  67            LD H,A                        
  0873:  79            LD A,C                        
  0874:  30 0B         JR NC,0x0881                    ; -> 0x0881
  0876:  E5            PUSH HL                       
  0877:  2A 50 41      LD HL,(0x4150)                
  087A:  19            ADD HL,DE                     
  087B:  EB            EX DE,HL                      
  087C:  E1            POP HL                        
  087D:  3A 4F 41      LD A,(0x414F)                 
  0880:  89            ADC A,C                       
  0881:  1F            RRA                           
  0882:  4F            LD C,A                        
  0883:  7A            LD A,D                        
  0884:  1F            RRA                           
  0885:  57            LD D,A                        
  0886:  7B            LD A,E                        
  0887:  1F            RRA                           
  0888:  5F            LD E,A                        
  0889:  78            LD A,B                        
  088A:  1F            RRA                           
  088B:  47            LD B,A                        
  088C:  2D            DEC L                         
  088D:  7C            LD A,H                        
  088E:  20 E1         JR NZ,0x0871                    ; -> 0x0871
  0890:  E1            POP HL                        
  0891:  C9            RET                           
  0892:  43            LD B,E                        
  0893:  5A            LD E,D                        
  0894:  51            LD D,C                        
  0895:  4F            LD C,A                        
  0896:  C9            RET                           
  0897:  CD A4 09      CALL BASIC_EVAL_EXPR          
  089A:  21 D8 0D      LD HL,0x0DD8                  
  089D:  CD B1 09      CALL 0x09B1                   
  08A0:  C1            POP BC                        
  08A1:  D1            POP DE                        
  08A2:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  08A5:  CA 9A 19      JP Z,0x199A                   
  08A8:  2E FF         LD L,0xFF                     
  08AA:  CD 14 09      CALL 0x0914                   
  08AD:  34            INC (HL)                      
  08AE:  34            INC (HL)                      
  08AF:  2B            DEC HL                        
  08B0:  7E            LD A,(HL)                     
  08B1:  32 89 40      LD (0x4089),A                   ; → RAM sistema
  08B4:  2B            DEC HL                        
  08B5:  7E            LD A,(HL)                     
  08B6:  32 85 40      LD (0x4085),A                   ; → RAM sistema
  08B9:  2B            DEC HL                        
  08BA:  7E            LD A,(HL)                     
  08BB:  32 81 40      LD (0x4081),A                   ; → RAM sistema
  08BE:  41            LD B,C                        
  08BF:  EB            EX DE,HL                      
  08C0:  AF            XOR A                         
  08C1:  4F            LD C,A                        
  08C2:  57            LD D,A                        
  08C3:  5F            LD E,A                        
  08C4:  32 8C 40      LD (0x408C),A                   ; → RAM sistema
  08C7:  E5            PUSH HL                       
  08C8:  C5            PUSH BC                       
  08C9:  7D            LD A,L                        
  08CA:  CD 80 40      CALL 0x4080                   
  08CD:  DE 00         SBC A,0x00                    
  08CF:  3F            CCF                           
  08D0:  30 07         JR NC,0x08D9                    ; -> 0x08D9
  08D2:  32 8C 40      LD (0x408C),A                   ; → RAM sistema
  08D5:  F1            POP AF                        
  08D6:  F1            POP AF                        
  08D7:  37            SCF                           
  08D8:  D2 C1 E1      JP NC,0xE1C1                  
  08DB:  79            LD A,C                        
  08DC:  3C            INC A                         
  08DD:  3D            DEC A                         
  08DE:  1F            RRA                           
  08DF:  FA 97 07      JP M,0x0797                   
  08E2:  17            RLA                           
  08E3:  7B            LD A,E                        
  08E4:  17            RLA                           
  08E5:  5F            LD E,A                        
  08E6:  7A            LD A,D                        
  08E7:  17            RLA                           
  08E8:  57            LD D,A                        
  08E9:  79            LD A,C                        
  08EA:  17            RLA                           
  08EB:  4F            LD C,A                        
  08EC:  29            ADD HL,HL                     
  08ED:  78            LD A,B                        
  08EE:  17            RLA                           
  08EF:  47            LD B,A                        
  08F0:  3A 8C 40      LD A,(0x408C)                 
  08F3:  17            RLA                           
  08F4:  32 8C 40      LD (0x408C),A                   ; → RAM sistema
  08F7:  79            LD A,C                        
  08F8:  B2            OR D                          
  08F9:  B3            OR E                          
  08FA:  20 CB         JR NZ,0x08C7                    ; -> 0x08C7
  08FC:  E5            PUSH HL                       
  08FD:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0900:  35            DEC (HL)                      
  0901:  E1            POP HL                        
  0902:  20 C3         JR NZ,0x08C7                    ; -> 0x08C7
  0904:  C3 B2 07      JP 0x07B2                     
  0907:  3E FF         LD A,0xFF                     
  0909:  2E AF         LD L,0xAF                     
  090B:  21 2D 41      LD HL,0x412D                    ; ← RAM sistema
  090E:  4E            DB 0x4E                         ; 'N'
  090F:  23            INC HL                        
  0910:  AE            DB 0xAE                       
  0911:  47            LD B,A                        
  0912:  2E 00         LD L,0x00                     
  0914:  78            LD A,B                        
  0915:  B7            OR A                          
  0916:  28 1F         JR Z,0x0937                     ; -> 0x0937
  0918:  7D            LD A,L                        
  0919:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  091C:  AE            DB 0xAE                       
  091D:  80            ADD A,B                       
  091E:  47            LD B,A                        
  091F:  1F            RRA                           
  0920:  A8            XOR B                         
  0921:  78            LD A,B                        
  0922:  F2 36 09      JP P,0x0936                   
  0925:  C6 80         ADD A,0x80                    
  0927:  77            LD (HL),A                     
  0928:  CA 90 08      JP Z,0x0890                   
  092B:  CD DF 09      CALL 0x09DF                   
  092E:  77            LD (HL),A                     
  092F:  2B            DEC HL                        
  0930:  C9            RET                           
  0931:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  0934:  2F            CPL                           
  0935:  E1            POP HL                        
  0936:  B7            OR A                          
  0937:  E1            POP HL                        
  0938:  F2 78 07      JP P,0x0778                   
  093B:  C3 B2 07      JP 0x07B2                     
  093E:  CD BF 09      CALL 0x09BF                   
  0941:  78            LD A,B                        
  0942:  B7            OR A                          
  0943:  C8            RET Z                         
  0944:  C6 02         ADD A,0x02                    
  0946:  DA B2 07      JP C,0x07B2                   
  0949:  47            LD B,A                        
  094A:  CD 16 07      CALL 0x0716                   
  094D:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0950:  34            INC (HL)                      
  0951:  C0            RET NZ                        
  0952:  C3 B2 07      JP 0x07B2                     
BASIC_EVAL_TOKEN:
  0955:  3A 24 41      LD A,(0x4124)                 
  0958:  B7            OR A                          
  0959:  C8            RET Z                         
  095A:  3A 23 41      LD A,(0x4123)                 
  095D:  FE 2F         CP 0x2F                       
  095F:  17            RLA                           
  0960:  9F            SBC A,A                       
  0961:  C0            RET NZ                        
  0962:  3C            INC A                         
  0963:  C9            RET                           
  0964:  06 88         LD B,0x88                     
  0966:  11 00 00      LD DE,0x0000                  
  0969:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  096C:  4F            LD C,A                        
  096D:  70            LD (HL),B                     
  096E:  06 00         LD B,0x00                     
  0970:  23            INC HL                        
  0971:  36 80         LD (HL),0x80                  
  0973:  17            RLA                           
  0974:  C3 62 07      JP 0x0762                     
  0977:  CD 94 09      CALL 0x0994                   
  097A:  F0            RET P                         
  097B:  E7            RST 20h                       
  097C:  FA 5B 0C      JP M,0x0C5B                   
  097F:  CA F6 0A      JP Z,0x0AF6                   
  0982:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0985:  7E            LD A,(HL)                     
  0986:  EE 80         XOR 0x80                      
  0988:  77            LD (HL),A                     
  0989:  C9            RET                           
  098A:  CD 94 09      CALL 0x0994                   
  098D:  6F            LD L,A                        
  098E:  17            RLA                           
  098F:  9F            SBC A,A                       
  0990:  67            LD H,A                        
  0991:  C3 9A 0A      JP 0x0A9A                     
  0994:  E7            RST 20h                       
  0995:  CA F6 0A      JP Z,0x0AF6                   
  0998:  F2 55 09      JP P,BASIC_EVAL_TOKEN         
  099B:  2A 21 41      LD HL,(0x4121)                
  099E:  7C            LD A,H                        
  099F:  B5            OR L                          
  09A0:  C8            RET Z                         
  09A1:  7C            LD A,H                        
  09A2:  18 BB         JR 0x095F                       ; -> 0x095F
BASIC_EVAL_EXPR:
  09A4:  EB            EX DE,HL                      
  09A5:  2A 21 41      LD HL,(0x4121)                
  09A8:  E3            EX (SP),HL                    
  09A9:  E5            PUSH HL                       
  09AA:  2A 23 41      LD HL,(0x4123)                
  09AD:  E3            EX (SP),HL                    
  09AE:  E5            PUSH HL                       
  09AF:  EB            EX DE,HL                      
  09B0:  C9            RET                           
  09B1:  CD C2 09      CALL 0x09C2                   
  09B4:  EB            EX DE,HL                      
  09B5:  22 21 41      LD (0x4121),HL                
  09B8:  60            LD H,B                        
  09B9:  69            LD L,C                        
  09BA:  22 23 41      LD (0x4123),HL                
  09BD:  EB            EX DE,HL                      
  09BE:  C9            RET                           
  09BF:  21 21 41      LD HL,0x4121                    ; ← RAM sistema
  09C2:  5E            DB 0x5E                         ; '^'
  09C3:  23            INC HL                        
  09C4:  56            DB 0x56                         ; 'V'
  09C5:  23            INC HL                        
  09C6:  4E            DB 0x4E                         ; 'N'
  09C7:  23            INC HL                        
  09C8:  46            DB 0x46                         ; 'F'
  09C9:  23            INC HL                        
  09CA:  C9            RET                           
  09CB:  11 21 41      LD DE,0x4121                    ; ← RAM sistema
  09CE:  06 04         LD B,0x04                     
  09D0:  18 05         JR 0x09D7                       ; -> 0x09D7
  09D2:  EB            EX DE,HL                      
  09D3:  3A AF 40      LD A,(ptr_mem_low)            
  09D6:  47            LD B,A                        
  09D7:  1A            DB 0x1A                       
  09D8:  77            LD (HL),A                     
  09D9:  13            INC DE                        
  09DA:  23            INC HL                        
  09DB:  05            DEC B                         
  09DC:  20 F9         JR NZ,0x09D7                    ; -> 0x09D7
  09DE:  C9            RET                           
  09DF:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  09E2:  7E            LD A,(HL)                     
  09E3:  07            RLCA                          
  09E4:  37            SCF                           
  09E5:  1F            RRA                           
  09E6:  77            LD (HL),A                     
  09E7:  3F            CCF                           
  09E8:  1F            RRA                           
  09E9:  23            INC HL                        
  09EA:  23            INC HL                        
  09EB:  77            LD (HL),A                     
  09EC:  79            LD A,C                        
  09ED:  07            RLCA                          
  09EE:  37            SCF                           
  09EF:  1F            RRA                           
  09F0:  4F            LD C,A                        
  09F1:  1F            RRA                           
  09F2:  AE            DB 0xAE                       
  09F3:  C9            RET                           
  09F4:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  09F7:  11 D2 09      LD DE,0x09D2                  
  09FA:  18 06         JR 0x0A02                       ; -> 0x0A02
  09FC:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  09FF:  11 D3 09      LD DE,0x09D3                  
  0A02:  D5            PUSH DE                       
  0A03:  11 21 41      LD DE,0x4121                    ; ← RAM sistema
  0A06:  E7            RST 20h                       
  0A07:  D8            RET C                         
  0A08:  11 1D 41      LD DE,0x411D                    ; ← RAM sistema
  0A0B:  C9            RET                           
  0A0C:  78            LD A,B                        
  0A0D:  B7            OR A                          
  0A0E:  CA 55 09      JP Z,BASIC_EVAL_TOKEN         
  0A11:  21 5E 09      LD HL,0x095E                  
  0A14:  E5            PUSH HL                       
  0A15:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  0A18:  79            LD A,C                        
  0A19:  C8            RET Z                         
  0A1A:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0A1D:  AE            DB 0xAE                       
  0A1E:  79            LD A,C                        
  0A1F:  F8            RET M                         
  0A20:  CD 26 0A      CALL 0x0A26                   
  0A23:  1F            RRA                           
  0A24:  A9            XOR C                         
  0A25:  C9            RET                           
  0A26:  23            INC HL                        
  0A27:  78            LD A,B                        
  0A28:  BE            DB 0xBE                       
  0A29:  C0            RET NZ                        
  0A2A:  2B            DEC HL                        
  0A2B:  79            LD A,C                        
  0A2C:  BE            DB 0xBE                       
  0A2D:  C0            RET NZ                        
  0A2E:  2B            DEC HL                        
  0A2F:  7A            LD A,D                        
  0A30:  BE            DB 0xBE                       
  0A31:  C0            RET NZ                        
  0A32:  2B            DEC HL                        
  0A33:  7B            LD A,E                        
  0A34:  96            DB 0x96                       
  0A35:  C0            RET NZ                        
  0A36:  E1            POP HL                        
  0A37:  E1            POP HL                        
  0A38:  C9            RET                           
  0A39:  7A            LD A,D                        
  0A3A:  AC            XOR H                         
  0A3B:  7C            LD A,H                        
  0A3C:  FA 5F 09      JP M,0x095F                   
  0A3F:  BA            CP D                          
  0A40:  C2 60 09      JP NZ,0x0960                  
  0A43:  7D            LD A,L                        
  0A44:  93            DB 0x93                       
  0A45:  C2 60 09      JP NZ,0x0960                  
  0A48:  C9            RET                           
  0A49:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0A4C:  CD D3 09      CALL 0x09D3                   
  0A4F:  11 2E 41      LD DE,0x412E                    ; ← RAM sistema
  0A52:  1A            DB 0x1A                       
  0A53:  B7            OR A                          
  0A54:  CA 55 09      JP Z,BASIC_EVAL_TOKEN         
  0A57:  21 5E 09      LD HL,0x095E                  
  0A5A:  E5            PUSH HL                       
  0A5B:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  0A5E:  1B            DEC DE                        
  0A5F:  1A            DB 0x1A                       
  0A60:  4F            LD C,A                        
  0A61:  C8            RET Z                         
  0A62:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0A65:  AE            DB 0xAE                       
  0A66:  79            LD A,C                        
  0A67:  F8            RET M                         
  0A68:  13            INC DE                        
  0A69:  23            INC HL                        
  0A6A:  06 08         LD B,0x08                     
  0A6C:  1A            DB 0x1A                       
  0A6D:  96            DB 0x96                       
  0A6E:  C2 23 0A      JP NZ,0x0A23                  
  0A71:  1B            DEC DE                        
  0A72:  2B            DEC HL                        
  0A73:  05            DEC B                         
  0A74:  20 F6         JR NZ,0x0A6C                    ; -> 0x0A6C
  0A76:  C1            POP BC                        
  0A77:  C9            RET                           
  0A78:  CD 4F 0A      CALL 0x0A4F                   
  0A7B:  C2 5E 09      JP NZ,0x095E                  
  0A7E:  C9            RET                           
  0A7F:  E7            RST 20h                       
  0A80:  2A 21 41      LD HL,(0x4121)                
  0A83:  F8            RET M                         
  0A84:  CA F6 0A      JP Z,0x0AF6                   
  0A87:  D4 B9 0A      CALL NC,0x0AB9                
  0A8A:  21 B2 07      LD HL,0x07B2                  
  0A8D:  E5            PUSH HL                       
  0A8E:  3A 24 41      LD A,(0x4124)                 
  0A91:  FE 90         CP 0x90                       
  0A93:  30 0E         JR NC,0x0AA3                    ; -> 0x0AA3
  0A95:  CD FB 0A      CALL 0x0AFB                   
  0A98:  EB            EX DE,HL                      
  0A99:  D1            POP DE                        
  0A9A:  22 21 41      LD (0x4121),HL                
  0A9D:  3E 02         LD A,0x02                     
  0A9F:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  0AA2:  C9            RET                           
  0AA3:  01 80 90      LD BC,0x9080                  
  0AA6:  11 00 00      LD DE,0x0000                  
  0AA9:  CD 0C 0A      CALL 0x0A0C                   
  0AAC:  C0            RET NZ                        
  0AAD:  61            LD H,C                        
  0AAE:  6A            LD L,D                        
  0AAF:  18 E8         JR 0x0A99                       ; -> 0x0A99
  0AB1:  E7            RST 20h                       
  0AB2:  E0            RET PO                        
  0AB3:  FA CC 0A      JP M,0x0ACC                   
  0AB6:  CA F6 0A      JP Z,0x0AF6                   
  0AB9:  CD BF 09      CALL 0x09BF                   
  0ABC:  CD EF 0A      CALL 0x0AEF                   
  0ABF:  78            LD A,B                        
  0AC0:  B7            OR A                          
  0AC1:  C8            RET Z                         
  0AC2:  CD DF 09      CALL 0x09DF                   
  0AC5:  21 20 41      LD HL,0x4120                    ; ← RAM sistema
  0AC8:  46            DB 0x46                         ; 'F'
  0AC9:  C3 96 07      JP 0x0796                     
  0ACC:  2A 21 41      LD HL,(0x4121)                
  0ACF:  CD EF 0A      CALL 0x0AEF                   
  0AD2:  7C            LD A,H                        
  0AD3:  55            LD D,L                        
  0AD4:  1E 00         LD E,0x00                     
  0AD6:  06 90         LD B,0x90                     
  0AD8:  C3 69 09      JP 0x0969                     
  0ADB:  E7            RST 20h                       
  0ADC:  D0            RET NC                        
  0ADD:  CA F6 0A      JP Z,0x0AF6                   
  0AE0:  FC CC 0A      CALL M,0x0ACC                 
  0AE3:  21 00 00      LD HL,0x0000                  
  0AE6:  22 1D 41      LD (0x411D),HL                
  0AE9:  22 1F 41      LD (0x411F),HL                
  0AEC:  3E 08         LD A,0x08                     
  0AEE:  01 3E 04      LD BC,0x043E                  
  0AF1:  C3 9F 0A      JP 0x0A9F                     
  0AF4:  E7            RST 20h                       
  0AF5:  C8            RET Z                         
  0AF6:  1E 18         LD E,0x18                     
  0AF8:  C3 A2 19      JP 0x19A2                     
  0AFB:  47            LD B,A                        
  0AFC:  4F            LD C,A                        
  0AFD:  57            LD D,A                        
  0AFE:  5F            LD E,A                        
  0AFF:  B7            OR A                          
  0B00:  C8            RET Z                         
  0B01:  E5            PUSH HL                       
  0B02:  CD BF 09      CALL 0x09BF                   
  0B05:  CD DF 09      CALL 0x09DF                   
  0B08:  AE            DB 0xAE                       
  0B09:  67            LD H,A                        
  0B0A:  FC 1F 0B      CALL M,0x0B1F                 
  0B0D:  3E 98         LD A,0x98                     
  0B0F:  90            SUB B                         
  0B10:  CD D7 07      CALL 0x07D7                   
  0B13:  7C            LD A,H                        
  0B14:  17            RLA                           
  0B15:  DC A8 07      CALL C,0x07A8                 
  0B18:  06 00         LD B,0x00                     
  0B1A:  DC C3 07      CALL C,0x07C3                 
  0B1D:  E1            POP HL                        
  0B1E:  C9            RET                           
  0B1F:  1B            DEC DE                        
  0B20:  7A            LD A,D                        
  0B21:  A3            AND E                         
  0B22:  3C            INC A                         
  0B23:  C0            RET NZ                        
  0B24:  0B            DEC BC                        
  0B25:  C9            RET                           
  0B26:  E7            RST 20h                       
  0B27:  F8            RET M                         
  0B28:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  0B2B:  F2 37 0B      JP P,0x0B37                   
  0B2E:  CD 82 09      CALL 0x0982                   
  0B31:  CD 37 0B      CALL 0x0B37                   
  0B34:  C3 7B 09      JP 0x097B                     
  0B37:  E7            RST 20h                       
  0B38:  F8            RET M                         
  0B39:  30 1E         JR NC,0x0B59                    ; -> 0x0B59
  0B3B:  28 B9         JR Z,0x0AF6                     ; -> 0x0AF6
  0B3D:  CD 8E 0A      CALL 0x0A8E                   
  0B40:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0B43:  7E            LD A,(HL)                     
  0B44:  FE 98         CP 0x98                       
  0B46:  3A 21 41      LD A,(0x4121)                 
  0B49:  D0            RET NC                        
  0B4A:  7E            LD A,(HL)                     
  0B4B:  CD FB 0A      CALL 0x0AFB                   
  0B4E:  36 98         LD (HL),0x98                  
  0B50:  7B            LD A,E                        
  0B51:  F5            PUSH AF                       
  0B52:  79            LD A,C                        
  0B53:  17            RLA                           
  0B54:  CD 62 07      CALL 0x0762                   
  0B57:  F1            POP AF                        
  0B58:  C9            RET                           
  0B59:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0B5C:  7E            LD A,(HL)                     
  0B5D:  FE 90         CP 0x90                       
  0B5F:  DA 7F 0A      JP C,0x0A7F                   
  0B62:  20 14         JR NZ,0x0B78                    ; -> 0x0B78
  0B64:  4F            LD C,A                        
  0B65:  2B            DEC HL                        
  0B66:  7E            LD A,(HL)                     
  0B67:  EE 80         XOR 0x80                      
  0B69:  06 06         LD B,0x06                     
  0B6B:  2B            DEC HL                        
  0B6C:  B6            DB 0xB6                       
  0B6D:  05            DEC B                         
  0B6E:  20 FB         JR NZ,0x0B6B                    ; -> 0x0B6B
  0B70:  B7            OR A                          
  0B71:  21 00 80      LD HL,0x8000                  
  0B74:  CA 9A 0A      JP Z,0x0A9A                   
  0B77:  79            LD A,C                        
  0B78:  FE B8         CP 0xB8                       
  0B7A:  D0            RET NC                        
  0B7B:  F5            PUSH AF                       
  0B7C:  CD BF 09      CALL 0x09BF                   
  0B7F:  CD DF 09      CALL 0x09DF                   
  0B82:  AE            DB 0xAE                       
  0B83:  2B            DEC HL                        
  0B84:  36 B8         LD (HL),0xB8                  
  0B86:  F5            PUSH AF                       
  0B87:  FC A0 0B      CALL M,0x0BA0                 
  0B8A:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0B8D:  3E B8         LD A,0xB8                     
  0B8F:  90            SUB B                         
  0B90:  CD 69 0D      CALL 0x0D69                   
  0B93:  F1            POP AF                        
  0B94:  FC 20 0D      CALL M,0x0D20                 
  0B97:  AF            XOR A                         
  0B98:  32 1C 41      LD (0x411C),A                   ; → RAM sistema
  0B9B:  F1            POP AF                        
  0B9C:  D0            RET NC                        
  0B9D:  C3 D8 0C      JP 0x0CD8                     
  0BA0:  21 1D 41      LD HL,0x411D                    ; ← RAM sistema
  0BA3:  7E            LD A,(HL)                     
  0BA4:  35            DEC (HL)                      
  0BA5:  B7            OR A                          
  0BA6:  23            INC HL                        
  0BA7:  28 FA         JR Z,0x0BA3                     ; -> 0x0BA3
  0BA9:  C9            RET                           
  0BAA:  E5            PUSH HL                       
  0BAB:  21 00 00      LD HL,0x0000                  
  0BAE:  78            LD A,B                        
  0BAF:  B1            OR C                          
  0BB0:  28 12         JR Z,0x0BC4                     ; -> 0x0BC4
  0BB2:  3E 10         LD A,0x10                     
  0BB4:  29            ADD HL,HL                     
  0BB5:  DA 3D 27      JP C,0x273D                   
  0BB8:  EB            EX DE,HL                      
  0BB9:  29            ADD HL,HL                     
  0BBA:  EB            EX DE,HL                      
  0BBB:  30 04         JR NC,0x0BC1                    ; -> 0x0BC1
  0BBD:  09            ADD HL,BC                     
  0BBE:  DA 3D 27      JP C,0x273D                   
  0BC1:  3D            DEC A                         
  0BC2:  20 F0         JR NZ,0x0BB4                    ; -> 0x0BB4
  0BC4:  EB            EX DE,HL                      
  0BC5:  E1            POP HL                        
  0BC6:  C9            RET                           
  0BC7:  7C            LD A,H                        
  0BC8:  17            RLA                           
  0BC9:  9F            SBC A,A                       
  0BCA:  47            LD B,A                        
  0BCB:  CD 51 0C      CALL 0x0C51                   
  0BCE:  79            LD A,C                        
  0BCF:  98            SBC A,B                       
  0BD0:  18 03         JR 0x0BD5                       ; -> 0x0BD5
  0BD2:  7C            LD A,H                        
  0BD3:  17            RLA                           
  0BD4:  9F            SBC A,A                       
  0BD5:  47            LD B,A                        
  0BD6:  E5            PUSH HL                       
  0BD7:  7A            LD A,D                        
  0BD8:  17            RLA                           
  0BD9:  9F            SBC A,A                       
  0BDA:  19            ADD HL,DE                     
  0BDB:  88            ADC A,B                       
  0BDC:  0F            RRCA                          
  0BDD:  AC            XOR H                         
  0BDE:  F2 99 0A      JP P,0x0A99                   
  0BE1:  C5            PUSH BC                       
  0BE2:  EB            EX DE,HL                      
  0BE3:  CD CF 0A      CALL 0x0ACF                   
  0BE6:  F1            POP AF                        
  0BE7:  E1            POP HL                        
  0BE8:  CD A4 09      CALL BASIC_EVAL_EXPR          
  0BEB:  EB            EX DE,HL                      
  0BEC:  CD 6B 0C      CALL 0x0C6B                   
  0BEF:  C3 8F 0F      JP 0x0F8F                     
  0BF2:  7C            LD A,H                        
  0BF3:  B5            OR L                          
  0BF4:  CA 9A 0A      JP Z,0x0A9A                   
  0BF7:  E5            PUSH HL                       
  0BF8:  D5            PUSH DE                       
  0BF9:  CD 45 0C      CALL 0x0C45                   
  0BFC:  C5            PUSH BC                       
  0BFD:  44            LD B,H                        
  0BFE:  4D            LD C,L                        
  0BFF:  21 00 00      LD HL,0x0000                  
  0C02:  3E 10         LD A,0x10                     
  0C04:  29            ADD HL,HL                     
  0C05:  38 1F         JR C,0x0C26                     ; -> 0x0C26
  0C07:  EB            EX DE,HL                      
  0C08:  29            ADD HL,HL                     
  0C09:  EB            EX DE,HL                      
  0C0A:  30 04         JR NC,0x0C10                    ; -> 0x0C10
  0C0C:  09            ADD HL,BC                     
  0C0D:  DA 26 0C      JP C,0x0C26                   
  0C10:  3D            DEC A                         
  0C11:  20 F1         JR NZ,0x0C04                    ; -> 0x0C04
  0C13:  C1            POP BC                        
  0C14:  D1            POP DE                        
  0C15:  7C            LD A,H                        
  0C16:  B7            OR A                          
  0C17:  FA 1F 0C      JP M,0x0C1F                   
  0C1A:  D1            POP DE                        
  0C1B:  78            LD A,B                        
  0C1C:  C3 4D 0C      JP 0x0C4D                     
  0C1F:  EE 80         XOR 0x80                      
  0C21:  B5            OR L                          
  0C22:  28 13         JR Z,0x0C37                     ; -> 0x0C37
  0C24:  EB            EX DE,HL                      
  0C25:  01 C1 E1      LD BC,0xE1C1                  
  0C28:  CD CF 0A      CALL 0x0ACF                   
  0C2B:  E1            POP HL                        
  0C2C:  CD A4 09      CALL BASIC_EVAL_EXPR          
  0C2F:  CD CF 0A      CALL 0x0ACF                   
  0C32:  C1            POP BC                        
  0C33:  D1            POP DE                        
  0C34:  C3 47 08      JP 0x0847                     
  0C37:  78            LD A,B                        
  0C38:  B7            OR A                          
  0C39:  C1            POP BC                        
  0C3A:  FA 9A 0A      JP M,0x0A9A                   
  0C3D:  D5            PUSH DE                       
  0C3E:  CD CF 0A      CALL 0x0ACF                   
  0C41:  D1            POP DE                        
  0C42:  C3 82 09      JP 0x0982                     
  0C45:  7C            LD A,H                        
  0C46:  AA            XOR D                         
  0C47:  47            LD B,A                        
  0C48:  CD 4C 0C      CALL 0x0C4C                   
  0C4B:  EB            EX DE,HL                      
  0C4C:  7C            LD A,H                        
  0C4D:  B7            OR A                          
  0C4E:  F2 9A 0A      JP P,0x0A9A                   
  0C51:  AF            XOR A                         
  0C52:  4F            LD C,A                        
  0C53:  95            DB 0x95                       
  0C54:  6F            LD L,A                        
  0C55:  79            LD A,C                        
  0C56:  9C            DB 0x9C                       
  0C57:  67            LD H,A                        
  0C58:  C3 9A 0A      JP 0x0A9A                     
  0C5B:  2A 21 41      LD HL,(0x4121)                
  0C5E:  CD 51 0C      CALL 0x0C51                   
  0C61:  7C            LD A,H                        
  0C62:  EE 80         XOR 0x80                      
  0C64:  B5            OR L                          
  0C65:  C0            RET NZ                        
  0C66:  EB            EX DE,HL                      
  0C67:  CD EF 0A      CALL 0x0AEF                   
  0C6A:  AF            XOR A                         
  0C6B:  06 98         LD B,0x98                     
  0C6D:  C3 69 09      JP 0x0969                     
  0C70:  21 2D 41      LD HL,0x412D                    ; ← RAM sistema
  0C73:  7E            LD A,(HL)                     
  0C74:  EE 80         XOR 0x80                      
  0C76:  77            LD (HL),A                     
  0C77:  21 2E 41      LD HL,0x412E                    ; ← RAM sistema
  0C7A:  7E            LD A,(HL)                     
  0C7B:  B7            OR A                          
  0C7C:  C8            RET Z                         
  0C7D:  47            LD B,A                        
  0C7E:  2B            DEC HL                        
  0C7F:  4E            DB 0x4E                         ; 'N'
  0C80:  11 24 41      LD DE,0x4124                    ; ← RAM sistema
  0C83:  1A            DB 0x1A                       
  0C84:  B7            OR A                          
  0C85:  CA F4 09      JP Z,0x09F4                   
  0C88:  90            SUB B                         
  0C89:  30 16         JR NC,0x0CA1                    ; -> 0x0CA1
  0C8B:  2F            CPL                           
  0C8C:  3C            INC A                         
  0C8D:  F5            PUSH AF                       
  0C8E:  0E 08         LD C,0x08                     
  0C90:  23            INC HL                        
  0C91:  E5            PUSH HL                       
  0C92:  1A            DB 0x1A                       
  0C93:  46            DB 0x46                         ; 'F'
  0C94:  77            LD (HL),A                     
  0C95:  78            LD A,B                        
  0C96:  12            DB 0x12                       
  0C97:  1B            DEC DE                        
  0C98:  2B            DEC HL                        
  0C99:  0D            DEC C                         
  0C9A:  20 F6         JR NZ,0x0C92                    ; -> 0x0C92
  0C9C:  E1            POP HL                        
  0C9D:  46            DB 0x46                         ; 'F'
  0C9E:  2B            DEC HL                        
  0C9F:  4E            DB 0x4E                         ; 'N'
  0CA0:  F1            POP AF                        
  0CA1:  FE 39         CP 0x39                       
  0CA3:  D0            RET NC                        
  0CA4:  F5            PUSH AF                       
  0CA5:  CD DF 09      CALL 0x09DF                   
  0CA8:  23            INC HL                        
  0CA9:  36 00         LD (HL),0x00                  
  0CAB:  47            LD B,A                        
  0CAC:  F1            POP AF                        
  0CAD:  21 2D 41      LD HL,0x412D                    ; ← RAM sistema
  0CB0:  CD 69 0D      CALL 0x0D69                   
  0CB3:  3A 26 41      LD A,(0x4126)                 
  0CB6:  32 1C 41      LD (0x411C),A                   ; → RAM sistema
  0CB9:  78            LD A,B                        
  0CBA:  B7            OR A                          
  0CBB:  F2 CF 0C      JP P,0x0CCF                   
  0CBE:  CD 33 0D      CALL 0x0D33                   
  0CC1:  D2 0E 0D      JP NC,0x0D0E                  
  0CC4:  EB            EX DE,HL                      
  0CC5:  34            INC (HL)                      
  0CC6:  CA B2 07      JP Z,0x07B2                   
  0CC9:  CD 90 0D      CALL 0x0D90                   
  0CCC:  C3 0E 0D      JP 0x0D0E                     
  0CCF:  CD 45 0D      CALL 0x0D45                   
  0CD2:  21 25 41      LD HL,0x4125                    ; ← RAM sistema
  0CD5:  DC 57 0D      CALL C,0x0D57                 
  0CD8:  AF            XOR A                         
  0CD9:  47            LD B,A                        
  0CDA:  3A 23 41      LD A,(0x4123)                 
  0CDD:  B7            OR A                          
  0CDE:  20 1E         JR NZ,0x0CFE                    ; -> 0x0CFE
  0CE0:  21 1C 41      LD HL,0x411C                    ; ← RAM sistema
  0CE3:  0E 08         LD C,0x08                     
  0CE5:  56            DB 0x56                         ; 'V'
  0CE6:  77            LD (HL),A                     
  0CE7:  7A            LD A,D                        
  0CE8:  23            INC HL                        
  0CE9:  0D            DEC C                         
  0CEA:  20 F9         JR NZ,0x0CE5                    ; -> 0x0CE5
  0CEC:  78            LD A,B                        
  0CED:  D6 08         SUB 0x08                      
  0CEF:  FE C0         CP 0xC0                       
  0CF1:  20 E6         JR NZ,0x0CD9                    ; -> 0x0CD9
  0CF3:  C3 78 07      JP 0x0778                     
  0CF6:  05            DEC B                         
  0CF7:  21 1C 41      LD HL,0x411C                    ; ← RAM sistema
  0CFA:  CD 97 0D      CALL 0x0D97                   
  0CFD:  B7            OR A                          
  0CFE:  F2 F6 0C      JP P,0x0CF6                   
  0D01:  78            LD A,B                        
  0D02:  B7            OR A                          
  0D03:  28 09         JR Z,0x0D0E                     ; -> 0x0D0E
  0D05:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0D08:  86            DB 0x86                       
  0D09:  77            LD (HL),A                     
  0D0A:  D2 78 07      JP NC,0x0778                  
  0D0D:  C8            RET Z                         
  0D0E:  3A 1C 41      LD A,(0x411C)                 
  0D11:  B7            OR A                          
  0D12:  FC 20 0D      CALL M,0x0D20                 
  0D15:  21 25 41      LD HL,0x4125                    ; ← RAM sistema
  0D18:  7E            LD A,(HL)                     
  0D19:  E6 80         AND 0x80                      
  0D1B:  2B            DEC HL                        
  0D1C:  2B            DEC HL                        
  0D1D:  AE            DB 0xAE                       
  0D1E:  77            LD (HL),A                     
  0D1F:  C9            RET                           
  0D20:  21 1D 41      LD HL,0x411D                    ; ← RAM sistema
  0D23:  06 07         LD B,0x07                     
  0D25:  34            INC (HL)                      
  0D26:  C0            RET NZ                        
  0D27:  23            INC HL                        
  0D28:  05            DEC B                         
  0D29:  20 FA         JR NZ,0x0D25                    ; -> 0x0D25
  0D2B:  34            INC (HL)                      
  0D2C:  CA B2 07      JP Z,0x07B2                   
  0D2F:  2B            DEC HL                        
  0D30:  36 80         LD (HL),0x80                  
  0D32:  C9            RET                           
  0D33:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0D36:  11 1D 41      LD DE,0x411D                    ; ← RAM sistema
  0D39:  0E 07         LD C,0x07                     
  0D3B:  AF            XOR A                         
  0D3C:  1A            DB 0x1A                       
  0D3D:  8E            DB 0x8E                       
  0D3E:  12            DB 0x12                       
  0D3F:  13            INC DE                        
  0D40:  23            INC HL                        
  0D41:  0D            DEC C                         
  0D42:  20 F8         JR NZ,0x0D3C                    ; -> 0x0D3C
  0D44:  C9            RET                           
  0D45:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0D48:  11 1D 41      LD DE,0x411D                    ; ← RAM sistema
  0D4B:  0E 07         LD C,0x07                     
  0D4D:  AF            XOR A                         
  0D4E:  1A            DB 0x1A                       
  0D4F:  9E            DB 0x9E                       
  0D50:  12            DB 0x12                       
  0D51:  13            INC DE                        
  0D52:  23            INC HL                        
  0D53:  0D            DEC C                         
  0D54:  20 F8         JR NZ,0x0D4E                    ; -> 0x0D4E
  0D56:  C9            RET                           
  0D57:  7E            LD A,(HL)                     
  0D58:  2F            CPL                           
  0D59:  77            LD (HL),A                     
  0D5A:  21 1C 41      LD HL,0x411C                    ; ← RAM sistema
  0D5D:  06 08         LD B,0x08                     
  0D5F:  AF            XOR A                         
  0D60:  4F            LD C,A                        
  0D61:  79            LD A,C                        
  0D62:  9E            DB 0x9E                       
  0D63:  77            LD (HL),A                     
  0D64:  23            INC HL                        
  0D65:  05            DEC B                         
  0D66:  20 F9         JR NZ,0x0D61                    ; -> 0x0D61
  0D68:  C9            RET                           
  0D69:  71            LD (HL),C                     
  0D6A:  E5            PUSH HL                       
  0D6B:  D6 08         SUB 0x08                      
  0D6D:  38 0E         JR C,0x0D7D                     ; -> 0x0D7D
  0D6F:  E1            POP HL                        
  0D70:  E5            PUSH HL                       
  0D71:  11 00 08      LD DE,0x0800                  
  0D74:  4E            DB 0x4E                         ; 'N'
  0D75:  73            LD (HL),E                     
  0D76:  59            LD E,C                        
  0D77:  2B            DEC HL                        
  0D78:  15            DEC D                         
  0D79:  20 F9         JR NZ,0x0D74                    ; -> 0x0D74
  0D7B:  18 EE         JR 0x0D6B                       ; -> 0x0D6B
  0D7D:  C6 09         ADD A,0x09                    
  0D7F:  57            LD D,A                        
  0D80:  AF            XOR A                         
  0D81:  E1            POP HL                        
  0D82:  15            DEC D                         
  0D83:  C8            RET Z                         
  0D84:  E5            PUSH HL                       
  0D85:  1E 08         LD E,0x08                     
  0D87:  7E            LD A,(HL)                     
  0D88:  1F            RRA                           
  0D89:  77            LD (HL),A                     
  0D8A:  2B            DEC HL                        
  0D8B:  1D            DEC E                         
  0D8C:  20 F9         JR NZ,0x0D87                    ; -> 0x0D87
  0D8E:  18 F0         JR 0x0D80                       ; -> 0x0D80
  0D90:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0D93:  16 01         LD D,0x01                     
  0D95:  18 ED         JR 0x0D84                       ; -> 0x0D84
  0D97:  0E 08         LD C,0x08                     
  0D99:  7E            LD A,(HL)                     
  0D9A:  17            RLA                           
  0D9B:  77            LD (HL),A                     
  0D9C:  23            INC HL                        
  0D9D:  0D            DEC C                         
  0D9E:  20 F9         JR NZ,0x0D99                    ; -> 0x0D99
  0DA0:  C9            RET                           
  0DA1:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  0DA4:  C8            RET Z                         
  0DA5:  CD 0A 09      CALL 0x090A                   
  0DA8:  CD 39 0E      CALL 0x0E39                   
  0DAB:  71            LD (HL),C                     
  0DAC:  13            INC DE                        
  0DAD:  06 07         LD B,0x07                     
  0DAF:  1A            DB 0x1A                       
  0DB0:  13            INC DE                        
  0DB1:  B7            OR A                          
  0DB2:  D5            PUSH DE                       
  0DB3:  28 17         JR Z,0x0DCC                     ; -> 0x0DCC
  0DB5:  0E 08         LD C,0x08                     
  0DB7:  C5            PUSH BC                       
  0DB8:  1F            RRA                           
  0DB9:  47            LD B,A                        
  0DBA:  DC 33 0D      CALL C,0x0D33                 
  0DBD:  CD 90 0D      CALL 0x0D90                   
  0DC0:  78            LD A,B                        
  0DC1:  C1            POP BC                        
  0DC2:  0D            DEC C                         
  0DC3:  20 F2         JR NZ,0x0DB7                    ; -> 0x0DB7
  0DC5:  D1            POP DE                        
  0DC6:  05            DEC B                         
  0DC7:  20 E6         JR NZ,0x0DAF                    ; -> 0x0DAF
  0DC9:  C3 D8 0C      JP 0x0CD8                     
  0DCC:  21 23 41      LD HL,0x4123                    ; ← RAM sistema
  0DCF:  CD 70 0D      CALL 0x0D70                   
  0DD2:  18 F1         JR 0x0DC5                       ; -> 0x0DC5
  0DD4:  00            NOP                           
  0DD5:  00            NOP                           
  0DD6:  00            NOP                           
  0DD7:  00            NOP                           
  0DD8:  00            NOP                           
  0DD9:  00            NOP                           
  0DDA:  20 84         JR NZ,0x0D60                    ; -> 0x0D60
  0DDC:  11 D4 0D      LD DE,0x0DD4                  
  0DDF:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0DE2:  CD D3 09      CALL 0x09D3                   
  0DE5:  3A 2E 41      LD A,(0x412E)                 
  0DE8:  B7            OR A                          
  0DE9:  CA 9A 19      JP Z,0x199A                   
  0DEC:  CD 07 09      CALL 0x0907                   
  0DEF:  34            INC (HL)                      
  0DF0:  34            INC (HL)                      
  0DF1:  CD 39 0E      CALL 0x0E39                   
  0DF4:  21 51 41      LD HL,0x4151                    ; ← RAM sistema
  0DF7:  71            LD (HL),C                     
  0DF8:  41            LD B,C                        
  0DF9:  11 4A 41      LD DE,0x414A                    ; ← RAM sistema
  0DFC:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0DFF:  CD 4B 0D      CALL 0x0D4B                   
  0E02:  1A            DB 0x1A                       
  0E03:  99            DB 0x99                       
  0E04:  3F            CCF                           
  0E05:  38 0B         JR C,0x0E12                     ; -> 0x0E12
  0E07:  11 4A 41      LD DE,0x414A                    ; ← RAM sistema
  0E0A:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  0E0D:  CD 39 0D      CALL 0x0D39                   
  0E10:  AF            XOR A                         
  0E11:  DA 12 04      JP C,0x0412                   
  0E14:  3A 23 41      LD A,(0x4123)                 
  0E17:  3C            INC A                         
  0E18:  3D            DEC A                         
  0E19:  1F            RRA                           
  0E1A:  FA 11 0D      JP M,0x0D11                   
  0E1D:  17            RLA                           
  0E1E:  21 1D 41      LD HL,0x411D                    ; ← RAM sistema
  0E21:  0E 07         LD C,0x07                     
  0E23:  CD 99 0D      CALL 0x0D99                   
  0E26:  21 4A 41      LD HL,0x414A                    ; ← RAM sistema
  0E29:  CD 97 0D      CALL 0x0D97                   
  0E2C:  78            LD A,B                        
  0E2D:  B7            OR A                          
  0E2E:  20 C9         JR NZ,0x0DF9                    ; -> 0x0DF9
  0E30:  21 24 41      LD HL,0x4124                    ; ← RAM sistema
  0E33:  35            DEC (HL)                      
  0E34:  20 C3         JR NZ,0x0DF9                    ; -> 0x0DF9
  0E36:  C3 B2 07      JP 0x07B2                     
  0E39:  79            LD A,C                        
  0E3A:  32 2D 41      LD (0x412D),A                   ; → RAM sistema
  0E3D:  2B            DEC HL                        
  0E3E:  11 50 41      LD DE,0x4150                    ; ← RAM sistema
  0E41:  01 00 07      LD BC,0x0700                  
  0E44:  7E            LD A,(HL)                     
  0E45:  12            DB 0x12                       
  0E46:  71            LD (HL),C                     
  0E47:  1B            DEC DE                        
  0E48:  2B            DEC HL                        
  0E49:  05            DEC B                         
  0E4A:  20 F8         JR NZ,0x0E44                    ; -> 0x0E44
  0E4C:  C9            RET                           
  0E4D:  CD FC 09      CALL 0x09FC                   
  0E50:  EB            EX DE,HL                      
  0E51:  2B            DEC HL                        
  0E52:  7E            LD A,(HL)                     
  0E53:  B7            OR A                          
  0E54:  C8            RET Z                         
  0E55:  C6 02         ADD A,0x02                    
  0E57:  DA B2 07      JP C,0x07B2                   
  0E5A:  77            LD (HL),A                     
  0E5B:  E5            PUSH HL                       
  0E5C:  CD 77 0C      CALL 0x0C77                   
  0E5F:  E1            POP HL                        
  0E60:  34            INC (HL)                      
  0E61:  C0            RET NZ                        
  0E62:  C3 B2 07      JP 0x07B2                     
  0E65:  CD 78 07      CALL 0x0778                   
  0E68:  CD EC 0A      CALL 0x0AEC                   
  0E6B:  F6 AF         OR 0xAF                       
  0E6D:  EB            EX DE,HL                      
  0E6E:  01 FF 00      LD BC,0x00FF                  
  0E71:  60            LD H,B                        
  0E72:  68            LD L,B                        
  0E73:  CC 9A 0A      CALL Z,0x0A9A                 
  0E76:  EB            EX DE,HL                      
  0E77:  7E            LD A,(HL)                     
  0E78:  FE 2D         CP 0x2D                       
  0E7A:  F5            PUSH AF                       
  0E7B:  CA 83 0E      JP Z,0x0E83                   
  0E7E:  FE 2B         CP 0x2B                       
  0E80:  28 01         JR Z,0x0E83                     ; -> 0x0E83
  0E82:  2B            DEC HL                        
  0E83:  D7            RST 10h                       
  0E84:  DA 29 0F      JP C,0x0F29                   
  0E87:  FE 2E         CP 0x2E                       
  0E89:  CA E4 0E      JP Z,0x0EE4                   
  0E8C:  FE 45         CP 0x45                       
  0E8E:  28 14         JR Z,0x0EA4                     ; -> 0x0EA4
  0E90:  FE 25         CP 0x25                       
  0E92:  CA EE 0E      JP Z,0x0EEE                   
  0E95:  FE 23         CP 0x23                       
  0E97:  CA F5 0E      JP Z,0x0EF5                   
  0E9A:  FE 21         CP 0x21                       
  0E9C:  CA F6 0E      JP Z,0x0EF6                   
  0E9F:  FE 44         CP 0x44                       
  0EA1:  20 24         JR NZ,0x0EC7                    ; -> 0x0EC7
  0EA3:  B7            OR A                          
  0EA4:  CD FB 0E      CALL 0x0EFB                   
  0EA7:  E5            PUSH HL                       
  0EA8:  21 BD 0E      LD HL,0x0EBD                  
  0EAB:  E3            EX (SP),HL                    
  0EAC:  D7            RST 10h                       
  0EAD:  15            DEC D                         
  0EAE:  FE CE         CP 0xCE                       
  0EB0:  C8            RET Z                         
  0EB1:  FE 2D         CP 0x2D                       
  0EB3:  C8            RET Z                         
  0EB4:  14            INC D                         
  0EB5:  FE CD         CP 0xCD                       
  0EB7:  C8            RET Z                         
  0EB8:  FE 2B         CP 0x2B                       
  0EBA:  C8            RET Z                         
  0EBB:  2B            DEC HL                        
  0EBC:  F1            POP AF                        
  0EBD:  D7            RST 10h                       
  0EBE:  DA 94 0F      JP C,0x0F94                   
  0EC1:  14            INC D                         
  0EC2:  20 03         JR NZ,0x0EC7                    ; -> 0x0EC7
  0EC4:  AF            XOR A                         
  0EC5:  93            DB 0x93                       
  0EC6:  5F            LD E,A                        
  0EC7:  E5            PUSH HL                       
  0EC8:  7B            LD A,E                        
  0EC9:  90            SUB B                         
  0ECA:  F4 0A 0F      CALL P,0x0F0A                 
  0ECD:  FC 18 0F      CALL M,0x0F18                 
  0ED0:  20 F8         JR NZ,0x0ECA                    ; -> 0x0ECA
  0ED2:  E1            POP HL                        
  0ED3:  F1            POP AF                        
  0ED4:  E5            PUSH HL                       
  0ED5:  CC 7B 09      CALL Z,0x097B                 
  0ED8:  E1            POP HL                        
  0ED9:  E7            RST 20h                       
  0EDA:  E8            RET PE                        
  0EDB:  E5            PUSH HL                       
  0EDC:  21 90 08      LD HL,0x0890                  
  0EDF:  E5            PUSH HL                       
  0EE0:  CD A3 0A      CALL 0x0AA3                   
  0EE3:  C9            RET                           
  0EE4:  E7            RST 20h                       
  0EE5:  0C            INC C                         
  0EE6:  20 DF         JR NZ,0x0EC7                    ; -> 0x0EC7
  0EE8:  DC FB 0E      CALL C,0x0EFB                 
  0EEB:  C3 83 0E      JP 0x0E83                     
  0EEE:  E7            RST 20h                       
  0EEF:  F2 97 19      JP P,0x1997                   
  0EF2:  23            INC HL                        
  0EF3:  18 D2         JR 0x0EC7                       ; -> 0x0EC7
  0EF5:  B7            OR A                          
  0EF6:  CD FB 0E      CALL 0x0EFB                   
  0EF9:  18 F7         JR 0x0EF2                       ; -> 0x0EF2
  0EFB:  E5            PUSH HL                       
  0EFC:  D5            PUSH DE                       
  0EFD:  C5            PUSH BC                       
  0EFE:  F5            PUSH AF                       
  0EFF:  CC B1 0A      CALL Z,0x0AB1                 
  0F02:  F1            POP AF                        
  0F03:  C4 DB 0A      CALL NZ,0x0ADB                
  0F06:  C1            POP BC                        
  0F07:  D1            POP DE                        
  0F08:  E1            POP HL                        
  0F09:  C9            RET                           
  0F0A:  C8            RET Z                         
  0F0B:  F5            PUSH AF                       
  0F0C:  E7            RST 20h                       
  0F0D:  F5            PUSH AF                       
  0F0E:  E4 3E 09      CALL PO,0x093E                
  0F11:  F1            POP AF                        
  0F12:  EC 4D 0E      CALL PE,0x0E4D                
  0F15:  F1            POP AF                        
  0F16:  3D            DEC A                         
  0F17:  C9            RET                           
  0F18:  D5            PUSH DE                       
  0F19:  E5            PUSH HL                       
  0F1A:  F5            PUSH AF                       
  0F1B:  E7            RST 20h                       
  0F1C:  F5            PUSH AF                       
  0F1D:  E4 97 08      CALL PO,0x0897                
  0F20:  F1            POP AF                        
  0F21:  EC DC 0D      CALL PE,0x0DDC                
  0F24:  F1            POP AF                        
  0F25:  E1            POP HL                        
  0F26:  D1            POP DE                        
  0F27:  3C            INC A                         
  0F28:  C9            RET                           
  0F29:  D5            PUSH DE                       
  0F2A:  78            LD A,B                        
  0F2B:  89            ADC A,C                       
  0F2C:  47            LD B,A                        
  0F2D:  C5            PUSH BC                       
  0F2E:  E5            PUSH HL                       
  0F2F:  7E            LD A,(HL)                     
  0F30:  D6 30         SUB 0x30                      
  0F32:  F5            PUSH AF                       
  0F33:  E7            RST 20h                       
  0F34:  F2 5D 0F      JP P,0x0F5D                   
  0F37:  2A 21 41      LD HL,(0x4121)                
  0F3A:  11 CD 0C      LD DE,0x0CCD                  
  0F3D:  DF            RST 18h                       
  0F3E:  30 19         JR NC,0x0F59                    ; -> 0x0F59
  0F40:  54            LD D,H                        
  0F41:  5D            LD E,L                        
  0F42:  29            ADD HL,HL                     
  0F43:  29            ADD HL,HL                     
  0F44:  19            ADD HL,DE                     
  0F45:  29            ADD HL,HL                     
  0F46:  F1            POP AF                        
  0F47:  4F            LD C,A                        
  0F48:  09            ADD HL,BC                     
  0F49:  7C            LD A,H                        
  0F4A:  B7            OR A                          
  0F4B:  FA 57 0F      JP M,0x0F57                   
  0F4E:  22 21 41      LD (0x4121),HL                
  0F51:  E1            POP HL                        
  0F52:  C1            POP BC                        
  0F53:  D1            POP DE                        
  0F54:  C3 83 0E      JP 0x0E83                     
  0F57:  79            LD A,C                        
  0F58:  F5            PUSH AF                       
  0F59:  CD CC 0A      CALL 0x0ACC                   
  0F5C:  37            SCF                           
  0F5D:  30 18         JR NC,0x0F77                    ; -> 0x0F77
  0F5F:  01 74 94      LD BC,0x9474                  
  0F62:  11 00 24      LD DE,0x2400                  
  0F65:  CD 0C 0A      CALL 0x0A0C                   
  0F68:  F2 74 0F      JP P,0x0F74                   
  0F6B:  CD 3E 09      CALL 0x093E                   
  0F6E:  F1            POP AF                        
  0F6F:  CD 89 0F      CALL 0x0F89                   
  0F72:  18 DD         JR 0x0F51                       ; -> 0x0F51
  0F74:  CD E3 0A      CALL 0x0AE3                   
  0F77:  CD 4D 0E      CALL 0x0E4D                   
  0F7A:  CD FC 09      CALL 0x09FC                   
  0F7D:  F1            POP AF                        
  0F7E:  CD 64 09      CALL 0x0964                   
  0F81:  CD E3 0A      CALL 0x0AE3                   
  0F84:  CD 77 0C      CALL 0x0C77                   
  0F87:  18 C8         JR 0x0F51                       ; -> 0x0F51
  0F89:  CD A4 09      CALL BASIC_EVAL_EXPR          
  0F8C:  CD 64 09      CALL 0x0964                   
  0F8F:  C1            POP BC                        
  0F90:  D1            POP DE                        
  0F91:  C3 16 07      JP 0x0716                     
  0F94:  7B            LD A,E                        
  0F95:  FE 0A         CP 0x0A                       
  0F97:  30 09         JR NC,0x0FA2                    ; -> 0x0FA2
  0F99:  07            RLCA                          
  0F9A:  07            RLCA                          
  0F9B:  83            ADD A,E                       
  0F9C:  07            RLCA                          
  0F9D:  86            DB 0x86                       
  0F9E:  D6 30         SUB 0x30                      
  0FA0:  5F            LD E,A                        
  0FA1:  FA 1E 32      JP M,0x321E                   
  0FA4:  C3 BD 0E      JP 0x0EBD                     
  0FA7:  E5            PUSH HL                       
  0FA8:  21 24 19      LD HL,0x1924                  
  0FAB:  CD A7 28      CALL PRINT_STRING             
  0FAE:  E1            POP HL                        
  0FAF:  CD 9A 0A      CALL 0x0A9A                   
  0FB2:  AF            XOR A                         
  0FB3:  CD 34 10      CALL 0x1034                   
  0FB6:  B6            DB 0xB6                       
  0FB7:  CD D9 0F      CALL 0x0FD9                   
  0FBA:  C3 A6 28      JP 0x28A6                     
  0FBD:  AF            XOR A                         
  0FBE:  CD 34 10      CALL 0x1034                   
  0FC1:  E6 08         AND 0x08                      
  0FC3:  28 02         JR Z,0x0FC7                     ; -> 0x0FC7
  0FC5:  36 2B         LD (HL),0x2B                  
  0FC7:  EB            EX DE,HL                      
  0FC8:  CD 94 09      CALL 0x0994                   
  0FCB:  EB            EX DE,HL                      
  0FCC:  F2 D9 0F      JP P,0x0FD9                   
  0FCF:  36 2D         LD (HL),0x2D                  
  0FD1:  C5            PUSH BC                       
  0FD2:  E5            PUSH HL                       
  0FD3:  CD 7B 09      CALL 0x097B                   
  0FD6:  E1            POP HL                        
  0FD7:  C1            POP BC                        
  0FD8:  B4            OR H                          
  0FD9:  23            INC HL                        
  0FDA:  36 30         LD (HL),0x30                  
  0FDC:  3A D8 40      LD A,(0x40D8)                 
  0FDF:  57            LD D,A                        
  0FE0:  17            RLA                           
  0FE1:  3A AF 40      LD A,(ptr_mem_low)            
  0FE4:  DA 9A 10      JP C,0x109A                   
  0FE7:  CA 92 10      JP Z,0x1092                   
  0FEA:  FE 04         CP 0x04                       
  0FEC:  D2 3D 10      JP NC,0x103D                  
  0FEF:  01 00 00      LD BC,0x0000                  
  0FF2:  CD 2F 13      CALL 0x132F                   
  0FF5:  21 30 41      LD HL,0x4130                    ; ← RAM sistema
  0FF8:  46            DB 0x46                         ; 'F'
  0FF9:  0E 20         LD C,0x20                     
  0FFB:  3A D8 40      LD A,(0x40D8)                 
  0FFE:  5F            LD E,A                        
  0FFF:  E6 20         AND 0x20                      
  1001:  28 07         JR Z,0x100A                     ; -> 0x100A
  1003:  78            LD A,B                        
  1004:  B9            CP C                          
  1005:  0E 2A         LD C,0x2A                     
  1007:  20 01         JR NZ,0x100A                    ; -> 0x100A
  1009:  41            LD B,C                        
  100A:  71            LD (HL),C                     
  100B:  D7            RST 10h                       
  100C:  28 14         JR Z,0x1022                     ; -> 0x1022
  100E:  FE 45         CP 0x45                       
  1010:  28 10         JR Z,0x1022                     ; -> 0x1022
  1012:  FE 44         CP 0x44                       
  1014:  28 0C         JR Z,0x1022                     ; -> 0x1022
  1016:  FE 30         CP 0x30                       
  1018:  28 F0         JR Z,0x100A                     ; -> 0x100A
  101A:  FE 2C         CP 0x2C                       
  101C:  28 EC         JR Z,0x100A                     ; -> 0x100A
  101E:  FE 2E         CP 0x2E                       
  1020:  20 03         JR NZ,0x1025                    ; -> 0x1025
  1022:  2B            DEC HL                        
  1023:  36 30         LD (HL),0x30                  
  1025:  7B            LD A,E                        
  1026:  E6 10         AND 0x10                      
  1028:  28 03         JR Z,0x102D                     ; -> 0x102D
  102A:  2B            DEC HL                        
  102B:  36 24         LD (HL),0x24                  
  102D:  7B            LD A,E                        
  102E:  E6 04         AND 0x04                      
  1030:  C0            RET NZ                        
  1031:  2B            DEC HL                        
  1032:  70            LD (HL),B                     
  1033:  C9            RET                           
  1034:  32 D8 40      LD (0x40D8),A                   ; → RAM sistema
  1037:  21 30 41      LD HL,0x4130                    ; ← RAM sistema
  103A:  36 20         LD (HL),0x20                  
  103C:  C9            RET                           
  103D:  FE 05         CP 0x05                       
  103F:  E5            PUSH HL                       
  1040:  DE 00         SBC A,0x00                    
  1042:  17            RLA                           
  1043:  57            LD D,A                        
  1044:  14            INC D                         
  1045:  CD 01 12      CALL 0x1201                   
  1048:  01 00 03      LD BC,0x0300                  
  104B:  82            ADD A,D                       
  104C:  FA 57 10      JP M,0x1057                   
  104F:  14            INC D                         
  1050:  FA 30 04      JP M,0x0430                   
  1053:  3C            INC A                         
  1054:  47            LD B,A                        
  1055:  3E 02         LD A,0x02                     
  1057:  D6 02         SUB 0x02                      
  1059:  E1            POP HL                        
  105A:  F5            PUSH AF                       
  105B:  CD 91 12      CALL 0x1291                   
  105E:  36 30         LD (HL),0x30                  
  1060:  CC C9 09      CALL Z,0x09C9                 
  1063:  CD A4 12      CALL 0x12A4                   
  1066:  2B            DEC HL                        
  1067:  7E            LD A,(HL)                     
  1068:  FE 30         CP 0x30                       
  106A:  28 FA         JR Z,0x1066                     ; -> 0x1066
  106C:  FE 2E         CP 0x2E                       
  106E:  C4 C9 09      CALL NZ,0x09C9                
  1071:  F1            POP AF                        
  1072:  28 1F         JR Z,0x1093                     ; -> 0x1093
  1074:  F5            PUSH AF                       
  1075:  E7            RST 20h                       
  1076:  3E 22         LD A,0x22                     
  1078:  8F            ADC A,A                       
  1079:  77            LD (HL),A                     
  107A:  23            INC HL                        
  107B:  F1            POP AF                        
  107C:  36 2B         LD (HL),0x2B                  
  107E:  F2 85 10      JP P,0x1085                   
  1081:  36 2D         LD (HL),0x2D                  
  1083:  2F            CPL                           
  1084:  3C            INC A                         
  1085:  06 2F         LD B,0x2F                     
  1087:  04            INC B                         
  1088:  D6 0A         SUB 0x0A                      
  108A:  30 FB         JR NC,0x1087                    ; -> 0x1087
  108C:  C6 3A         ADD A,0x3A                    
  108E:  23            INC HL                        
  108F:  70            LD (HL),B                     
  1090:  23            INC HL                        
  1091:  77            LD (HL),A                     
  1092:  23            INC HL                        
  1093:  36 00         LD (HL),0x00                  
  1095:  EB            EX DE,HL                      
  1096:  21 30 41      LD HL,0x4130                    ; ← RAM sistema
  1099:  C9            RET                           
  109A:  23            INC HL                        
  109B:  C5            PUSH BC                       
  109C:  FE 04         CP 0x04                       
  109E:  7A            LD A,D                        
  109F:  D2 09 11      JP NC,0x1109                  
  10A2:  1F            RRA                           
  10A3:  DA A3 11      JP C,0x11A3                   
  10A6:  01 03 06      LD BC,0x0603                  
  10A9:  CD 89 12      CALL 0x1289                   
  10AC:  D1            POP DE                        
  10AD:  7A            LD A,D                        
  10AE:  D6 05         SUB 0x05                      
  10B0:  F4 69 12      CALL P,0x1269                 
  10B3:  CD 2F 13      CALL 0x132F                   
  10B6:  7B            LD A,E                        
  10B7:  B7            OR A                          
  10B8:  CC 2F 09      CALL Z,0x092F                 
  10BB:  3D            DEC A                         
  10BC:  F4 69 12      CALL P,0x1269                 
  10BF:  E5            PUSH HL                       
  10C0:  CD F5 0F      CALL 0x0FF5                   
  10C3:  E1            POP HL                        
  10C4:  28 02         JR Z,0x10C8                     ; -> 0x10C8
  10C6:  70            LD (HL),B                     
  10C7:  23            INC HL                        
  10C8:  36 00         LD (HL),0x00                  
  10CA:  21 2F 41      LD HL,0x412F                    ; ← RAM sistema
  10CD:  23            INC HL                        
  10CE:  3A F3 40      LD A,(0x40F3)                 
  10D1:  95            DB 0x95                       
  10D2:  92            DB 0x92                       
  10D3:  C8            RET Z                         
  10D4:  7E            LD A,(HL)                     
  10D5:  FE 20         CP 0x20                       
  10D7:  28 F4         JR Z,0x10CD                     ; -> 0x10CD
  10D9:  FE 2A         CP 0x2A                       
  10DB:  28 F0         JR Z,0x10CD                     ; -> 0x10CD
  10DD:  2B            DEC HL                        
  10DE:  E5            PUSH HL                       
  10DF:  F5            PUSH AF                       
  10E0:  01 DF 10      LD BC,0x10DF                  
  10E3:  C5            PUSH BC                       
  10E4:  D7            RST 10h                       
  10E5:  FE 2D         CP 0x2D                       
  10E7:  C8            RET Z                         
  10E8:  FE 2B         CP 0x2B                       
  10EA:  C8            RET Z                         
  10EB:  FE 24         CP 0x24                       
  10ED:  C8            RET Z                         
  10EE:  C1            POP BC                        
  10EF:  FE 30         CP 0x30                       
  10F1:  20 0F         JR NZ,0x1102                    ; -> 0x1102
  10F3:  23            INC HL                        
  10F4:  D7            RST 10h                       
  10F5:  30 0B         JR NC,0x1102                    ; -> 0x1102
  10F7:  2B            DEC HL                        
  10F8:  01 2B 77      LD BC,0x772B                  
  10FB:  F1            POP AF                        
  10FC:  28 FB         JR Z,0x10F9                     ; -> 0x10F9
  10FE:  C1            POP BC                        
  10FF:  C3 CE 10      JP 0x10CE                     
  1102:  F1            POP AF                        
  1103:  28 FD         JR Z,0x1102                     ; -> 0x1102
  1105:  E1            POP HL                        
  1106:  36 25         LD (HL),0x25                  
  1108:  C9            RET                           
  1109:  E5            PUSH HL                       
  110A:  1F            RRA                           
  110B:  DA AA 11      JP C,0x11AA                   
  110E:  28 14         JR Z,0x1124                     ; -> 0x1124
  1110:  11 84 13      LD DE,0x1384                  
  1113:  CD 49 0A      CALL 0x0A49                   
  1116:  16 10         LD D,0x10                     
  1118:  FA 32 11      JP M,0x1132                   
  111B:  E1            POP HL                        
  111C:  C1            POP BC                        
  111D:  CD BD 8F      CALL 0x8FBD                   
  1120:  2B            DEC HL                        
  1121:  36 25         LD (HL),0x25                  
  1123:  C9            RET                           
  1124:  01 0E B6      LD BC,0xB60E                  
  1127:  11 CA 1B      LD DE,0x1BCA                  
  112A:  CD 0C 0A      CALL 0x0A0C                   
  112D:  F2 1B 11      JP P,0x111B                   
  1130:  16 06         LD D,0x06                     
  1132:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  1135:  C4 01 12      CALL NZ,0x1201                
  1138:  E1            POP HL                        
  1139:  C1            POP BC                        
  113A:  FA 57 11      JP M,0x1157                   
  113D:  C5            PUSH BC                       
  113E:  5F            LD E,A                        
  113F:  78            LD A,B                        
  1140:  92            DB 0x92                       
  1141:  93            DB 0x93                       
  1142:  F4 69 12      CALL P,0x1269                 
  1145:  CD 7D 12      CALL 0x127D                   
  1148:  CD A4 12      CALL 0x12A4                   
  114B:  B3            OR E                          
  114C:  C4 77 12      CALL NZ,0x1277                
  114F:  B3            OR E                          
  1150:  C4 91 12      CALL NZ,0x1291                
  1153:  D1            POP DE                        
  1154:  C3 B6 10      JP 0x10B6                     
  1157:  5F            LD E,A                        
  1158:  79            LD A,C                        
  1159:  F7            RST 30h                       
  115A:  C4 16 0F      CALL NZ,0x0F16                
  115D:  83            ADD A,E                       
  115E:  FA 62 11      JP M,0x1162                   
  1161:  AF            XOR A                         
  1162:  C5            PUSH BC                       
  1163:  F5            PUSH AF                       
  1164:  FC 18 0F      CALL M,0x0F18                 
  1167:  FA 64 11      JP M,0x1164                   
  116A:  C1            POP BC                        
  116B:  7B            LD A,E                        
  116C:  90            SUB B                         
  116D:  C1            POP BC                        
  116E:  5F            LD E,A                        
  116F:  82            ADD A,D                       
  1170:  78            LD A,B                        
  1171:  FA 7F 11      JP M,0x117F                   
  1174:  92            DB 0x92                       
  1175:  93            DB 0x93                       
  1176:  F4 69 12      CALL P,0x1269                 
  1179:  C5            PUSH BC                       
  117A:  CD 7D 12      CALL 0x127D                   
  117D:  18 11         JR 0x1190                       ; -> 0x1190
  117F:  CD 69 12      CALL 0x1269                   
  1182:  79            LD A,C                        
  1183:  CD 94 12      CALL 0x1294                   
  1186:  4F            LD C,A                        
  1187:  AF            XOR A                         
  1188:  92            DB 0x92                       
  1189:  93            DB 0x93                       
  118A:  CD 69 12      CALL 0x1269                   
  118D:  C5            PUSH BC                       
  118E:  47            LD B,A                        
  118F:  4F            LD C,A                        
  1190:  CD A4 12      CALL 0x12A4                   
  1193:  C1            POP BC                        
  1194:  B1            OR C                          
  1195:  20 03         JR NZ,0x119A                    ; -> 0x119A
  1197:  2A F3 40      LD HL,(0x40F3)                
  119A:  83            ADD A,E                       
  119B:  3D            DEC A                         
  119C:  F4 69 52      CALL P,0x5269                 
  119F:  D0            RET NC                        
  11A0:  C3 BF 10      JP 0x10BF                     
  11A3:  E5            PUSH HL                       
  11A4:  D5            PUSH DE                       
  11A5:  CD CC 0A      CALL 0x0ACC                   
  11A8:  D1            POP DE                        
  11A9:  AF            XOR A                         
  11AA:  CA B0 11      JP Z,0x11B0                   
  11AD:  1E 10         LD E,0x10                     
  11AF:  01 1E 06      LD BC,0x061E                  
  11B2:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  11B5:  37            SCF                           
  11B6:  C4 01 12      CALL NZ,0x1201                
  11B9:  E1            POP HL                        
  11BA:  C1            POP BC                        
  11BB:  F5            PUSH AF                       
  11BC:  79            LD A,C                        
  11BD:  B7            OR A                          
  11BE:  F5            PUSH AF                       
  11BF:  C4 16 0F      CALL NZ,0x0F16                
  11C2:  80            ADD A,B                       
  11C3:  4F            LD C,A                        
  11C4:  7A            LD A,D                        
  11C5:  E6 04         AND 0x04                      
  11C7:  FE 01         CP 0x01                       
  11C9:  9F            SBC A,A                       
  11CA:  57            LD D,A                        
  11CB:  81            ADD A,C                       
  11CC:  4F            LD C,A                        
  11CD:  93            DB 0x93                       
  11CE:  F5            PUSH AF                       
  11CF:  C5            PUSH BC                       
  11D0:  FC 18 0F      CALL M,0x0F18                 
  11D3:  FA D0 11      JP M,0x11D0                   
  11D6:  C1            POP BC                        
  11D7:  F1            POP AF                        
  11D8:  C5            PUSH BC                       
  11D9:  F5            PUSH AF                       
  11DA:  FA DE 11      JP M,0x11DE                   
  11DD:  AF            XOR A                         
  11DE:  2F            CPL                           
  11DF:  3C            INC A                         
  11E0:  80            ADD A,B                       
  11E1:  3C            INC A                         
  11E2:  82            ADD A,D                       
  11E3:  47            LD B,A                        
  11E4:  0E 00         LD C,0x00                     
  11E6:  CD A4 12      CALL 0x12A4                   
  11E9:  F1            POP AF                        
  11EA:  F4 71 12      CALL P,0x1271                 
  11ED:  C1            POP BC                        
  11EE:  F1            POP AF                        
  11EF:  CC 2F 09      CALL Z,0x092F                 
  11F2:  F1            POP AF                        
  11F3:  38 03         JR C,0x11F8                     ; -> 0x11F8
  11F5:  83            ADD A,E                       
  11F6:  90            SUB B                         
  11F7:  92            DB 0x92                       
  11F8:  C5            PUSH BC                       
  11F9:  CD 74 10      CALL 0x1074                   
  11FC:  EB            EX DE,HL                      
  11FD:  D1            POP DE                        
  11FE:  C3 FF 10      JP 0x10FF                     
  1201:  D5            PUSH DE                       
  1202:  AF            XOR A                         
  1203:  F5            PUSH AF                       
  1204:  E7            RST 20h                       
  1205:  E2 22 12      JP PO,0x1222                  
  1208:  3A 24 41      LD A,(0x4124)                 
  120B:  FE 91         CP 0x91                       
  120D:  D2 22 12      JP NC,0x1222                  
  1210:  11 64 13      LD DE,0x1364                  
  1213:  21 27 41      LD HL,0x4127                    ; ← RAM sistema
  1216:  CD D3 09      CALL 0x09D3                   
  1219:  CD A1 0D      CALL 0x0DA1                   
  121C:  F1            POP AF                        
  121D:  D6 4A         SUB 0x4A                      
  121F:  F5            PUSH AF                       
  1220:  18 E6         JR 0x1208                       ; -> 0x1208
  1222:  CD 4F 12      CALL 0x124F                   
  1225:  E7            RST 20h                       
  1226:  30 0B         JR NC,0x1233                    ; -> 0x1233
  1228:  01 43 91      LD BC,0x9143                  
  122B:  11 F9 4F      LD DE,0x4FF9                  
  122E:  CD 0C 0A      CALL 0x0A0C                   
  1231:  18 06         JR 0x1239                       ; -> 0x1239
  1233:  11 6C 13      LD DE,0x136C                  
  1236:  CD 49 0A      CALL 0x0A49                   
  1239:  F2 4B 12      JP P,0x124B                   
  123C:  F1            POP AF                        
  123D:  CD 0B 0F      CALL 0x0F0B                   
  1240:  F5            PUSH AF                       
  1241:  18 E2         JR 0x1225                       ; -> 0x1225
  1243:  F1            POP AF                        
  1244:  CD 18 0F      CALL 0x0F18                   
  1247:  F5            PUSH AF                       
  1248:  CD 4F 12      CALL 0x124F                   
  124B:  F1            POP AF                        
  124C:  D1            POP DE                        
  124D:  B7            OR A                          
  124E:  C9            RET                           
  124F:  E7            RST 20h                       
  1250:  EA 5E 12      JP PE,0x125E                  
  1253:  01 74 94      LD BC,0x9474                  
  1256:  11 F8 23      LD DE,0x23F8                  
  1259:  CD 0C 0A      CALL 0x0A0C                   
  125C:  18 06         JR 0x1264                       ; -> 0x1264
  125E:  11 74 13      LD DE,0x1374                  
  1261:  CD 49 0A      CALL 0x0A49                   
  1264:  E1            POP HL                        
  1265:  F2 43 12      JP P,0x1243                   
  1268:  E9            JP (HL)                       
  1269:  B7            OR A                          
  126A:  C8            RET Z                         
  126B:  3D            DEC A                         
  126C:  36 30         LD (HL),0x30                  
  126E:  23            INC HL                        
  126F:  18 F9         JR 0x126A                       ; -> 0x126A
  1271:  20 04         JR NZ,0x1277                    ; -> 0x1277
  1273:  C8            RET Z                         
  1274:  CD 91 12      CALL 0x1291                   
  1277:  36 30         LD (HL),0x30                  
  1279:  23            INC HL                        
  127A:  3D            DEC A                         
  127B:  18 F6         JR 0x1273                       ; -> 0x1273
  127D:  7B            LD A,E                        
  127E:  82            ADD A,D                       
  127F:  3C            INC A                         
  1280:  47            LD B,A                        
  1281:  3C            INC A                         
  1282:  D6 03         SUB 0x03                      
  1284:  30 FC         JR NC,0x1282                    ; -> 0x1282
  1286:  C6 05         ADD A,0x05                    
  1288:  4F            LD C,A                        
  1289:  3A D8 40      LD A,(0x40D8)                 
  128C:  E6 40         AND 0x40                      
  128E:  C0            RET NZ                        
  128F:  4F            LD C,A                        
  1290:  C9            RET                           
  1291:  05            DEC B                         
  1292:  20 08         JR NZ,0x129C                    ; -> 0x129C
  1294:  36 2E         LD (HL),0x2E                  
  1296:  22 F3 40      LD (0x40F3),HL                
  1299:  23            INC HL                        
  129A:  48            LD C,B                        
  129B:  C9            RET                           
  129C:  0D            DEC C                         
  129D:  C0            RET NZ                        
  129E:  36 2C         LD (HL),0x2C                  
  12A0:  23            INC HL                        
  12A1:  0E 03         LD C,0x03                     
  12A3:  C9            RET                           
  12A4:  D5            PUSH DE                       
  12A5:  E7            RST 20h                       
  12A6:  E2 EA 12      JP PO,0x12EA                  
  12A9:  C5            PUSH BC                       
  12AA:  E5            PUSH HL                       
  12AB:  CD FC 09      CALL 0x09FC                   
  12AE:  21 7C 13      LD HL,0x137C                  
  12B1:  CD F7 09      CALL 0x09F7                   
  12B4:  CD 77 0C      CALL 0x0C77                   
  12B7:  AF            XOR A                         
  12B8:  CD 7B 0B      CALL 0x0B7B                   
  12BB:  E1            POP HL                        
  12BC:  C1            POP BC                        
  12BD:  11 CC 13      LD DE,0x13CC                  
  12C0:  3E 0A         LD A,0x0A                     
  12C2:  CD 91 12      CALL 0x1291                   
  12C5:  C5            PUSH BC                       
  12C6:  F5            PUSH AF                       
  12C7:  E5            PUSH HL                       
  12C8:  D5            PUSH DE                       
  12C9:  06 2F         LD B,0x2F                     
  12CB:  04            INC B                         
  12CC:  E1            POP HL                        
  12CD:  E5            PUSH HL                       
  12CE:  CD 48 0D      CALL 0x0D48                   
  12D1:  30 F8         JR NC,0x12CB                    ; -> 0x12CB
  12D3:  E1            POP HL                        
  12D4:  CD 36 0D      CALL 0x0D36                   
  12D7:  EB            EX DE,HL                      
  12D8:  E1            POP HL                        
  12D9:  70            LD (HL),B                     
  12DA:  23            INC HL                        
  12DB:  F1            POP AF                        
  12DC:  C1            POP BC                        
  12DD:  3D            DEC A                         
  12DE:  20 E2         JR NZ,0x12C2                    ; -> 0x12C2
  12E0:  C5            PUSH BC                       
  12E1:  E5            PUSH HL                       
  12E2:  21 1D 41      LD HL,0x411D                    ; ← RAM sistema
  12E5:  CD B1 09      CALL 0x09B1                   
  12E8:  18 0C         JR 0x12F6                       ; -> 0x12F6
  12EA:  C5            PUSH BC                       
  12EB:  E5            PUSH HL                       
  12EC:  CD 08 07      CALL 0x0708                   
  12EF:  3C            INC A                         
  12F0:  CD FB 0A      CALL 0x0AFB                   
  12F3:  CD B4 09      CALL 0x09B4                   
  12F6:  E1            POP HL                        
  12F7:  C1            POP BC                        
  12F8:  AF            XOR A                         
  12F9:  11 D2 13      LD DE,0x13D2                  
  12FC:  3F            CCF                           
  12FD:  CD 91 12      CALL 0x1291                   
  1300:  C5            PUSH BC                       
  1301:  F5            PUSH AF                       
  1302:  E5            PUSH HL                       
  1303:  D5            PUSH DE                       
  1304:  CD BF 09      CALL 0x09BF                   
  1307:  E1            POP HL                        
  1308:  06 2F         LD B,0x2F                     
  130A:  04            INC B                         
  130B:  7B            LD A,E                        
  130C:  96            DB 0x96                       
  130D:  5F            LD E,A                        
  130E:  23            INC HL                        
  130F:  7A            LD A,D                        
  1310:  DE 57         SBC A,0x57                    
  1312:  23            INC HL                        
  1313:  79            LD A,C                        
  1314:  9E            DB 0x9E                       
  1315:  4F            LD C,A                        
  1316:  2B            DEC HL                        
  1317:  2B            DEC HL                        
  1318:  30 F0         JR NC,0x130A                    ; -> 0x130A
  131A:  CD B7 07      CALL 0x07B7                   
  131D:  23            INC HL                        
  131E:  CD B4 09      CALL 0x09B4                   
  1321:  EB            EX DE,HL                      
  1322:  E1            POP HL                        
  1323:  70            LD (HL),B                     
  1324:  23            INC HL                        
  1325:  F1            POP AF                        
  1326:  C1            POP BC                        
  1327:  38 D3         JR C,0x12FC                     ; -> 0x12FC
  1329:  13            INC DE                        
  132A:  13            INC DE                        
  132B:  3E 04         LD A,0x04                     
  132D:  18 06         JR 0x1335                       ; -> 0x1335
  132F:  D5            PUSH DE                       
  1330:  11 D8 13      LD DE,0x13D8                  
  1333:  3E 05         LD A,0x05                     
  1335:  CD 91 12      CALL 0x1291                   
  1338:  C5            PUSH BC                       
  1339:  F5            PUSH AF                       
  133A:  E5            PUSH HL                       
  133B:  EB            EX DE,HL                      
  133C:  4E            DB 0x4E                         ; 'N'
  133D:  23            INC HL                        
  133E:  46            DB 0x46                         ; 'F'
  133F:  C5            PUSH BC                       
  1340:  23            INC HL                        
  1341:  E3            EX (SP),HL                    
  1342:  EB            EX DE,HL                      
  1343:  2A 21 41      LD HL,(0x4121)                
  1346:  06 2F         LD B,0x2F                     
  1348:  04            INC B                         
  1349:  7D            LD A,L                        
  134A:  93            DB 0x93                       
  134B:  6F            LD L,A                        
  134C:  7C            LD A,H                        
  134D:  9A            DB 0x9A                       
  134E:  67            LD H,A                        
  134F:  30 F7         JR NC,0x1348                    ; -> 0x1348
  1351:  19            ADD HL,DE                     
  1352:  22 21 41      LD (0x4121),HL                
  1355:  D1            POP DE                        
  1356:  E1            POP HL                        
  1357:  70            LD (HL),B                     
  1358:  23            INC HL                        
  1359:  F1            POP AF                        
  135A:  C1            POP BC                        
  135B:  3D            DEC A                         
  135C:  20 D7         JR NZ,0x1335                    ; -> 0x1335
  135E:  CD 91 12      CALL 0x1291                   
  1361:  77            LD (HL),A                     
  1362:  D1            POP DE                        
  1363:  C9            RET                           
  1364:  00            NOP                           
  1365:  00            NOP                           
  1366:  00            NOP                           
  1367:  00            NOP                           
  1368:  F9            LD SP,HL                      
  1369:  02            DB 0x02                       
  136A:  15            DEC D                         
  136B:  A2            AND D                         
  136C:  FD FF         DB 0xFD,0xFF                    ; instrução IY
  136E:  9F            SBC A,A                       
  136F:  31 A9 5F      LD SP,0x5FA9                  
  1372:  63            LD H,E                        
  1373:  B2            OR D                          
  1374:  FE FF         CP 0xFF                       
  1376:  03            INC BC                        
  1377:  FF            RST 38h                       
  1378:  C9            RET                           
  1379:  1B            DEC DE                        
  137A:  0E F6         LD C,0xF6                     
  137C:  00            NOP                           
  137D:  00            NOP                           
  137E:  00            NOP                           
  137F:  00            NOP                           
  1380:  00            NOP                           
  1381:  00            NOP                           
  1382:  00            NOP                           
  1383:  80            ADD A,B                       
  1384:  00            NOP                           
  1385:  00            NOP                           
  1386:  04            INC B                         
  1387:  BF            CP A                          
  1388:  C9            RET                           
  1389:  1B            DEC DE                        
  138A:  0E B6         LD C,0xB6                     
  138C:  00            NOP                           
  138D:  80            ADD A,B                       
  138E:  C6 A4         ADD A,0xA4                    
  1390:  7E            LD A,(HL)                     
  1391:  8D            DB 0x8D                       
  1392:  03            INC BC                        
  1393:  00            NOP                           
  1394:  40            LD B,B                        
  1395:  7A            LD A,D                        
  1396:  10 F3         DJNZ 0x138B                     ; loop para 0x138B
  1398:  5A            LD E,D                        
  1399:  00            NOP                           
  139A:  00            NOP                           
  139B:  E0            RET PO                        
  139C:  72            LD (HL),D                     
  139D:  4E            DB 0x4E                         ; 'N'
  139E:  18 89         JR 0x1329                       ; -> 0x1329
  13A0:  00            NOP                           
  13A1:  00            NOP                           
  13A2:  10 A5         DJNZ 0x1349                     ; loop para 0x1349
  13A4:  D4 E8 00      CALL NC,0x00E8                
  13A7:  00            NOP                           
  13A8:  00            NOP                           
  13A9:  E8            RET PE                        
  13AA:  76            HALT                          
  13AB:  48            LD C,B                        
  13AC:  17            RLA                           
  13AD:  00            NOP                           
  13AE:  00            NOP                           
  13AF:  00            NOP                           
  13B0:  E4 0B 54      CALL PO,0x540B                
  13B3:  02            DB 0x02                       
  13B4:  00            NOP                           
  13B5:  00            NOP                           
  13B6:  00            NOP                           
  13B7:  CA 9A 3B      JP Z,0x3B9A                   
  13BA:  00            NOP                           
  13BB:  00            NOP                           
  13BC:  00            NOP                           
  13BD:  00            NOP                           
  13BE:  E1            POP HL                        
  13BF:  F5            PUSH AF                       
  13C0:  05            DEC B                         
  13C1:  00            NOP                           
  13C2:  00            NOP                           
  13C3:  00            NOP                           
  13C4:  80            ADD A,B                       
  13C5:  96            DB 0x96                       
  13C6:  98            SBC A,B                       
  13C7:  00            NOP                           
  13C8:  00            NOP                           
  13C9:  00            NOP                           
  13CA:  00            NOP                           
  13CB:  40            LD B,B                        
  13CC:  42            LD B,D                        
  13CD:  0F            RRCA                          
  13CE:  00            NOP                           
  13CF:  00            NOP                           
  13D0:  00            NOP                           
  13D1:  00            NOP                           
  13D2:  E0            RET PO                        
  13D3:  86            DB 0x86                       
  13D4:  01 10 27      LD BC,0x2710                  
  13D7:  00            NOP                           
  13D8:  10 27         DJNZ 0x1401                     ; loop para 0x1401
  13DA:  E8            RET PE                        
  13DB:  03            INC BC                        
  13DC:  64            LD H,H                        
  13DD:  00            NOP                           
  13DE:  0A            DB 0x0A                       
  13DF:  C0            RET NZ                        
  13E0:  01 00 21      LD BC,0x2100                  
  13E3:  82            ADD A,D                       
  13E4:  09            ADD HL,BC                     
  13E5:  E3            EX (SP),HL                    
  13E6:  E9            JP (HL)                       
  13E7:  CD A4 09      CALL BASIC_EVAL_EXPR          
  13EA:  21 80 13      LD HL,0x1380                  
  13ED:  CD B1 09      CALL 0x09B1                   
  13F0:  18 03         JR 0x13F5                       ; -> 0x13F5
  13F2:  CD B1 0A      CALL 0x0AB1                   
  13F5:  C1            POP BC                        
  13F6:  D1            POP DE                        
  13F7:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  13FA:  78            LD A,B                        
  13FB:  28 3C         JR Z,0x1439                     ; -> 0x1439
  13FD:  F2 04 14      JP P,0x1404                   
  1400:  B7            OR A                          
  1401:  CA 9A 19      JP Z,0x199A                   
  1404:  B7            OR A                          
  1405:  CA 79 07      JP Z,0x0779                   
  1408:  D5            PUSH DE                       
  1409:  C5            PUSH BC                       
  140A:  79            LD A,C                        
  140B:  F6 7F         OR 0x7F                       
  140D:  CD BF 09      CALL 0x09BF                   
  1410:  F2 21 14      JP P,0x1421                   
  1413:  D5            PUSH DE                       
  1414:  C5            PUSH BC                       
  1415:  CD 40 0B      CALL 0x0B40                   
  1418:  C1            POP BC                        
  1419:  D1            POP DE                        
  141A:  F5            PUSH AF                       
  141B:  CD 0C 0A      CALL 0x0A0C                   
  141E:  E1            POP HL                        
  141F:  7C            LD A,H                        
  1420:  1F            RRA                           
  1421:  E1            POP HL                        
  1422:  22 23 41      LD (0x4123),HL                
  1425:  E1            POP HL                        
  1426:  22 21 41      LD (0x4121),HL                
  1429:  DC E2 13      CALL C,0x13E2                 
  142C:  CC 82 09      CALL Z,0x0982                 
  142F:  D5            PUSH DE                       
  1430:  C5            PUSH BC                       
  1431:  CD 09 08      CALL 0x0809                   
  1434:  C1            POP BC                        
  1435:  D1            POP DE                        
  1436:  CD 47 08      CALL 0x0847                   
  1439:  CD A4 09      CALL BASIC_EVAL_EXPR          
  143C:  01 38 81      LD BC,0x8138                  
  143F:  11 3B AA      LD DE,0xAA3B                  
  1442:  CD 47 08      CALL 0x0847                   
  1445:  3A 24 41      LD A,(0x4124)                 
  1448:  FE 88         CP 0x88                       
  144A:  D2 31 09      JP NC,0x0931                  
  144D:  CD 40 0B      CALL 0x0B40                   
  1450:  C6 80         ADD A,0x80                    
  1452:  C6 02         ADD A,0x02                    
  1454:  DA 31 09      JP C,0x0931                   
  1457:  F5            PUSH AF                       
  1458:  21 F8 07      LD HL,0x07F8                  
  145B:  CD 0B 07      CALL 0x070B                   
  145E:  CD 41 08      CALL 0x0841                   
  1461:  F1            POP AF                        
  1462:  C1            POP BC                        
  1463:  D1            POP DE                        
  1464:  F5            PUSH AF                       
  1465:  CD 13 07      CALL 0x0713                   
  1468:  CD 82 09      CALL 0x0982                   
  146B:  21 79 14      LD HL,0x1479                  
  146E:  CD A9 14      CALL 0x14A9                   
  1471:  11 00 00      LD DE,0x0000                  
  1474:  C1            POP BC                        
  1475:  4A            LD C,D                        
  1476:  C3 47 08      JP 0x0847                     
  1479:  08            EX AF,AF'                     
  147A:  40            LD B,B                        
  147B:  2E 94         LD L,0x94                     
  147D:  74            LD (HL),H                     
  147E:  70            LD (HL),B                     
  147F:  4F            LD C,A                        
  1480:  2E 77         LD L,0x77                     
  1482:  6E            DB 0x6E                         ; 'n'
  1483:  02            DB 0x02                       
  1484:  88            ADC A,B                       
  1485:  7A            LD A,D                        
  1486:  E6 A0         AND 0xA0                      
  1488:  2A 7C 50      LD HL,(0x507C)                
  148B:  AA            XOR D                         
  148C:  AA            XOR D                         
  148D:  7E            LD A,(HL)                     
  148E:  FF            RST 38h                       
  148F:  FF            RST 38h                       
  1490:  7F            LD A,A                        
  1491:  7F            LD A,A                        
  1492:  00            NOP                           
  1493:  00            NOP                           
  1494:  80            ADD A,B                       
  1495:  81            ADD A,C                       
  1496:  00            NOP                           
  1497:  00            NOP                           
  1498:  00            NOP                           
  1499:  81            ADD A,C                       
  149A:  CD A4 09      CALL BASIC_EVAL_EXPR          
  149D:  11 32 0C      LD DE,0x0C32                  
  14A0:  D5            PUSH DE                       
  14A1:  E5            PUSH HL                       
  14A2:  CD BF 09      CALL 0x09BF                   
  14A5:  CD 47 08      CALL 0x0847                   
  14A8:  E1            POP HL                        
  14A9:  CD A4 09      CALL BASIC_EVAL_EXPR          
  14AC:  7E            LD A,(HL)                     
  14AD:  23            INC HL                        
  14AE:  CD B1 09      CALL 0x09B1                   
  14B1:  06 F1         LD B,0xF1                     
  14B3:  C1            POP BC                        
  14B4:  D1            POP DE                        
  14B5:  3D            DEC A                         
  14B6:  C8            RET Z                         
  14B7:  D5            PUSH DE                       
  14B8:  C5            PUSH BC                       
  14B9:  F5            PUSH AF                       
  14BA:  E5            PUSH HL                       
  14BB:  CD 47 08      CALL 0x0847                   
  14BE:  E1            POP HL                        
  14BF:  CD C2 09      CALL 0x09C2                   
  14C2:  E5            PUSH HL                       
  14C3:  CD 16 07      CALL 0x0716                   
  14C6:  E1            POP HL                        
  14C7:  18 E9         JR 0x14B2                       ; -> 0x14B2
  14C9:  CD 7F 0A      CALL 0x0A7F                   
  14CC:  7C            LD A,H                        
  14CD:  B7            OR A                          
  14CE:  FA 4A 1E      JP M,0x1E4A                   
  14D1:  B5            OR L                          
  14D2:  CA F0 14      JP Z,0x14F0                   
  14D5:  E5            PUSH HL                       
  14D6:  CD F0 14      CALL 0x14F0                   
  14D9:  CD BF 09      CALL 0x09BF                   
  14DC:  EB            EX DE,HL                      
  14DD:  E3            EX (SP),HL                    
  14DE:  C5            PUSH BC                       
  14DF:  CD CF 0A      CALL 0x0ACF                   
  14E2:  C1            POP BC                        
  14E3:  D1            POP DE                        
  14E4:  CD 47 08      CALL 0x0847                   
  14E7:  21 F8 07      LD HL,0x07F8                  
  14EA:  CD 0B 07      CALL 0x070B                   
  14ED:  C3 40 0B      JP 0x0B40                     
  14F0:  21 90 40      LD HL,0x4090                    ; ← RAM sistema
  14F3:  E5            PUSH HL                       
  14F4:  11 00 00      LD DE,0x0000                  
  14F7:  4B            LD C,E                        
  14F8:  26 03         LD H,0x03                     
  14FA:  2E 08         LD L,0x08                     
  14FC:  EB            EX DE,HL                      
  14FD:  29            ADD HL,HL                     
  14FE:  EB            EX DE,HL                      
  14FF:  79            LD A,C                        
  1500:  17            RLA                           
  1501:  4F            LD C,A                        
  1502:  E3            EX (SP),HL                    
  1503:  7E            LD A,(HL)                     
  1504:  07            RLCA                          
  1505:  77            LD (HL),A                     
  1506:  E3            EX (SP),HL                    
  1507:  D2 16 15      JP NC,0x1516                  
  150A:  E5            PUSH HL                       
  150B:  2A AA 40      LD HL,(0x40AA)                
  150E:  19            ADD HL,DE                     
  150F:  EB            EX DE,HL                      
  1510:  3A EC 40      LD A,(0x40EC)                 
  1513:  89            ADC A,C                       
  1514:  4F            LD C,A                        
  1515:  E1            POP HL                        
  1516:  2D            DEC L                         
  1517:  C2 FC 14      JP NZ,0x14FC                  
  151A:  E3            EX (SP),HL                    
  151B:  23            INC HL                        
  151C:  E3            EX (SP),HL                    
  151D:  25            DEC H                         
  151E:  C2 FA 14      JP NZ,0x14FA                  
  1521:  E1            POP HL                        
  1522:  21 65 B0      LD HL,0xB065                  
  1525:  19            ADD HL,DE                     
  1526:  22 AA 40      LD (0x40AA),HL                
  1529:  CD EF 0A      CALL 0x0AEF                   
  152C:  3E 05         LD A,0x05                     
  152E:  89            ADC A,C                       
  152F:  32 AC 40      LD (0x40AC),A                   ; → RAM sistema
  1532:  EB            EX DE,HL                      
  1533:  06 80         LD B,0x80                     
  1535:  21 25 41      LD HL,0x4125                    ; ← RAM sistema
  1538:  70            LD (HL),B                     
  1539:  2B            DEC HL                        
  153A:  70            LD (HL),B                     
  153B:  4F            LD C,A                        
  153C:  06 00         LD B,0x00                     
  153E:  C3 65 07      JP 0x0765                     
  1541:  21 8B 15      LD HL,0x158B                  
  1544:  CD 0B 07      CALL 0x070B                   
  1547:  CD A4 09      CALL BASIC_EVAL_EXPR          
  154A:  01 49 83      LD BC,0x8349                  
  154D:  11 DB 0F      LD DE,0x0FDB                  
  1550:  CD B4 09      CALL 0x09B4                   
  1553:  C1            POP BC                        
  1554:  D1            POP DE                        
  1555:  CD A2 08      CALL 0x08A2                   
  1558:  CD A4 09      CALL BASIC_EVAL_EXPR          
  155B:  CD 40 0B      CALL 0x0B40                   
  155E:  C1            POP BC                        
  155F:  D1            POP DE                        
  1560:  CD 13 07      CALL 0x0713                   
  1563:  21 8F 15      LD HL,0x158F                  
  1566:  CD 10 07      CALL 0x0710                   
  1569:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  156C:  37            SCF                           
  156D:  F2 77 15      JP P,0x1577                   
  1570:  CD 08 07      CALL 0x0708                   
  1573:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  1576:  B7            OR A                          
  1577:  F5            PUSH AF                       
  1578:  F4 82 09      CALL P,0x0982                 
  157B:  21 8F 15      LD HL,0x158F                  
  157E:  CD 0B 07      CALL 0x070B                   
  1581:  F1            POP AF                        
  1582:  D4 82 09      CALL NC,0x0982                
  1585:  21 93 15      LD HL,0x1593                  
  1588:  C3 9A 14      JP 0x149A                     
  158B:  DB 0F         IN A,(port_status)            
  158D:  49            LD C,C                        
  158E:  81            ADD A,C                       
  158F:  00            NOP                           
  1590:  00            NOP                           
  1591:  00            NOP                           
  1592:  7F            LD A,A                        
  1593:  05            DEC B                         
  1594:  FA D7 1E      JP M,0x1ED7                   
  1597:  C6 64         ADD A,0x64                    
  1599:  26 D9         LD H,0xD9                     
  159B:  87            ADD A,A                       
  159C:  58            LD E,B                        
  159D:  34            INC (HL)                      
  159E:  23            INC HL                        
  159F:  87            ADD A,A                       
  15A0:  E0            RET PO                        
  15A1:  5D            LD E,L                        
  15A2:  A5            AND L                         
  15A3:  86            DB 0x86                       
  15A4:  DA 0F 49      JP C,0x490F                   
  15A7:  83            ADD A,E                       
  15A8:  CD A4 09      CALL BASIC_EVAL_EXPR          
  15AB:  CD 47 15      CALL 0x1547                   
  15AE:  C1            POP BC                        
  15AF:  E1            POP HL                        
  15B0:  CD A4 09      CALL BASIC_EVAL_EXPR          
  15B3:  EB            EX DE,HL                      
  15B4:  CD B4 09      CALL 0x09B4                   
  15B7:  CD 41 15      CALL 0x1541                   
  15BA:  C3 A0 08      JP 0x08A0                     
  15BD:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  15C0:  FC E2 13      CALL M,0x13E2                 
  15C3:  FC 82 09      CALL M,0x0982                 
  15C6:  3A 24 41      LD A,(0x4124)                 
  15C9:  FE 81         CP 0x81                       
  15CB:  38 0C         JR C,0x15D9                     ; -> 0x15D9
  15CD:  01 00 81      LD BC,0x8100                  
  15D0:  51            LD D,C                        
  15D1:  59            LD E,C                        
  15D2:  CD A2 08      CALL 0x08A2                   
  15D5:  21 10 07      LD HL,0x0710                  
  15D8:  E5            PUSH HL                       
  15D9:  21 E3 15      LD HL,0x15E3                  
  15DC:  CD 9A 14      CALL 0x149A                   
  15DF:  21 8B 15      LD HL,0x158B                  
  15E2:  C9            RET                           
  15E3:  09            ADD HL,BC                     
  15E4:  4A            LD C,D                        
  15E5:  D7            RST 10h                       
  15E6:  3B            DEC SP                        
  15E7:  78            LD A,B                        
  15E8:  02            DB 0x02                       
  15E9:  6E            DB 0x6E                         ; 'n'
  15EA:  84            ADD A,H                       
  15EB:  7B            LD A,E                        
  15EC:  FE C1         CP 0xC1                       
  15EE:  2F            CPL                           
  15EF:  7C            LD A,H                        
  15F0:  74            LD (HL),H                     
  15F1:  31 DA 7D      LD SP,0x7DDA                  
  15F4:  84            ADD A,H                       
  15F5:  3D            DEC A                         
  15F6:  5A            LD E,D                        
  15F7:  7D            LD A,L                        
  15F8:  C8            RET Z                         
  15F9:  7F            LD A,A                        
  15FA:  91            DB 0x91                       
  15FB:  7E            LD A,(HL)                     
  15FC:  E4 BB 4C      CALL PO,0x4CBB                
  15FF:  7E            LD A,(HL)                     
  1600:  6C            LD L,H                        
  1601:  AA            XOR D                         
  1602:  AA            XOR D                         
  1603:  7F            LD A,A                        
  1604:  00            NOP                           
  1605:  00            NOP                           
  1606:  00            NOP                           
  1607:  81            ADD A,C                       
  1608:  8A            DB 0x8A                       
  1609:  09            ADD HL,BC                     
  160A:  37            SCF                           
  160B:  0B            DEC BC                        
  160C:  77            LD (HL),A                     
  160D:  09            ADD HL,BC                     
  160E:  D4 27 EF      CALL NC,0xEF27                
  1611:  2A F5 27      LD HL,(0x27F5)                
  1614:  E7            RST 20h                       
  1615:  13            INC DE                        
  1616:  C9            RET                           
  1617:  14            INC D                         
  1618:  09            ADD HL,BC                     
  1619:  08            EX AF,AF'                     
  161A:  39            ADD HL,SP                     
  161B:  14            INC D                         
  161C:  41            LD B,C                        
  161D:  15            DEC D                         
  161E:  47            LD B,A                        
  161F:  15            DEC D                         
  1620:  A8            XOR B                         
  1621:  15            DEC D                         
  1622:  BD            CP L                          
  1623:  15            DEC D                         
  1624:  AA            XOR D                         
  1625:  2C            INC L                         
  1626:  52            LD D,D                        
  1627:  41            LD B,C                        
  1628:  58            LD E,B                        
  1629:  41            LD B,C                        
  162A:  5E            DB 0x5E                         ; '^'
  162B:  41            LD B,C                        
  162C:  61            LD H,C                        
  162D:  41            LD B,C                        
  162E:  64            LD H,H                        
  162F:  41            LD B,C                        
  1630:  67            LD H,A                        
  1631:  41            LD B,C                        
  1632:  6A            LD L,D                        
  1633:  41            LD B,C                        
  1634:  6D            LD L,L                        
  1635:  41            LD B,C                        
  1636:  70            LD (HL),B                     
  1637:  41            LD B,C                        
  1638:  7F            LD A,A                        
  1639:  0A            DB 0x0A                       
  163A:  F1            POP AF                        
  163B:  0A            DB 0x0A                       
  163C:  DB 0A         IN A,(port_keyboard)            ; lê teclado
  163E:  26 0B         LD H,0x0B                     
  1640:  03            INC BC                        
  1641:  2A 36 28      LD HL,(0x2836)                
  1644:  C5            PUSH BC                       
  1645:  2A 0F 2A      LD HL,(0x2A0F)                
  1648:  1F            RRA                           
  1649:  2A 61 2A      LD HL,(0x2A61)                
  164C:  91            DB 0x91                       
  164D:  2A 9A 2A      LD HL,(0x2A9A)                
  1650:  C5            PUSH BC                       
  1651:  4E            DB 0x4E                         ; 'N'
  1652:  44            LD B,H                        
  1653:  C6 4F         ADD A,0x4F                    
  1655:  52            LD D,D                        
  1656:  D2 45 53      JP NC,0x5345                  
  1659:  45            LD B,L                        
  165A:  54            LD D,H                        
  165B:  D3 45         OUT (0x45),A                  
  165D:  54            LD D,H                        
  165E:  C3 4C 53      JP 0x534C                     
  1661:  C3 4D 44      JP 0x444D                     
  1664:  D2 41 4E      JP NC,0x4E41                  
  1667:  44            LD B,H                        
  1668:  4F            LD C,A                        
  1669:  4D            LD C,L                        
  166A:  CE 45         ADC A,0x45                    
  166C:  58            LD E,B                        
  166D:  54            LD D,H                        
  166E:  C4 41 54      CALL NZ,0x5441                
  1671:  41            LD B,C                        
  1672:  C9            RET                           
  1673:  4E            DB 0x4E                         ; 'N'
  1674:  50            LD D,B                        
  1675:  55            LD D,L                        
  1676:  54            LD D,H                        
  1677:  C4 49 4D      CALL NZ,0x4D49                
  167A:  D2 45 41      JP NC,0x4145                  
  167D:  44            LD B,H                        
  167E:  CC 45 54      CALL Z,0x5445                 
  1681:  C7            RST 00h                       
  1682:  4F            LD C,A                        
  1683:  54            LD D,H                        
  1684:  4F            LD C,A                        
  1685:  D2 55 4E      JP NC,0x4E55                  
  1688:  C9            RET                           
  1689:  46            DB 0x46                         ; 'F'
  168A:  D2 45 53      JP NC,0x5345                  
  168D:  54            LD D,H                        
  168E:  4F            LD C,A                        
  168F:  52            LD D,D                        
  1690:  45            LD B,L                        
  1691:  C7            RST 00h                       
  1692:  4F            LD C,A                        
  1693:  53            LD D,E                        
  1694:  55            LD D,L                        
  1695:  42            LD B,D                        
  1696:  D2 45 54      JP NC,0x5445                  
  1699:  55            LD D,L                        
  169A:  52            LD D,D                        
  169B:  4E            DB 0x4E                         ; 'N'
  169C:  D2 45 4D      JP NC,0x4D45                  
  169F:  D3 54         OUT (0x54),A                  
  16A1:  4F            LD C,A                        
  16A2:  50            LD D,B                        
  16A3:  C5            PUSH BC                       
  16A4:  4C            LD C,H                        
  16A5:  53            LD D,E                        
  16A6:  45            LD B,L                        
  16A7:  D4 52 4F      CALL NC,0x4F52                
  16AA:  4E            DB 0x4E                         ; 'N'
  16AB:  D4 52 4F      CALL NC,0x4F52                
  16AE:  46            DB 0x46                         ; 'F'
  16AF:  46            DB 0x46                         ; 'F'
  16B0:  C4 45 46      CALL NZ,0x4645                
  16B3:  53            LD D,E                        
  16B4:  54            LD D,H                        
  16B5:  52            LD D,D                        
  16B6:  C4 45 46      CALL NZ,0x4645                
  16B9:  49            LD C,C                        
  16BA:  4E            DB 0x4E                         ; 'N'
  16BB:  54            LD D,H                        
  16BC:  C4 45 46      CALL NZ,0x4645                
  16BF:  53            LD D,E                        
  16C0:  4E            DB 0x4E                         ; 'N'
  16C1:  47            LD B,A                        
  16C2:  C4 45 46      CALL NZ,0x4645                
  16C5:  44            LD B,H                        
  16C6:  42            LD B,D                        
  16C7:  4C            LD C,H                        
  16C8:  CC 49 4E      CALL Z,0x4E49                 
  16CB:  45            LD B,L                        
  16CC:  C5            PUSH BC                       
  16CD:  44            LD B,H                        
  16CE:  49            LD C,C                        
  16CF:  54            LD D,H                        
  16D0:  C5            PUSH BC                       
  16D1:  52            LD D,D                        
  16D2:  52            LD D,D                        
  16D3:  4F            LD C,A                        
  16D4:  52            LD D,D                        
  16D5:  D2 45 53      JP NC,0x5345                  
  16D8:  55            LD D,L                        
  16D9:  4D            LD C,L                        
  16DA:  45            LD B,L                        
  16DB:  CF            RST 08h                       
  16DC:  55            LD D,L                        
  16DD:  54            LD D,H                        
  16DE:  CF            RST 08h                       
  16DF:  4E            DB 0x4E                         ; 'N'
  16E0:  CF            RST 08h                       
  16E1:  50            LD D,B                        
  16E2:  45            LD B,L                        
  16E3:  4E            DB 0x4E                         ; 'N'
  16E4:  C6 49         ADD A,0x49                    
  16E6:  45            LD B,L                        
  16E7:  4C            LD C,H                        
  16E8:  44            LD B,H                        
  16E9:  C7            RST 00h                       
  16EA:  45            LD B,L                        
  16EB:  54            LD D,H                        
  16EC:  D0            RET NC                        
  16ED:  55            LD D,L                        
  16EE:  54            LD D,H                        
  16EF:  C3 4C 4F      JP 0x4F4C                     
  16F2:  53            LD D,E                        
  16F3:  45            LD B,L                        
  16F4:  CC 4F 41      CALL Z,0x414F                 
  16F7:  44            LD B,H                        
  16F8:  CD 45 52      CALL 0x5245                   
  16FB:  47            LD B,A                        
  16FC:  45            LD B,L                        
  16FD:  CE 41         ADC A,0x41                    
  16FF:  4D            LD C,L                        
  1700:  45            LD B,L                        
  1701:  CB 49         DB 0xCB,0x49                  
  1703:  4C            LD C,H                        
  1704:  4C            LD C,H                        
  1705:  CC 53 45      CALL Z,0x4553                 
  1708:  54            LD D,H                        
  1709:  D2 53 45      JP NC,0x4553                  
  170C:  54            LD D,H                        
  170D:  D3 41         OUT (port_video_aux),A          ; vídeo auxiliar
  170F:  56            DB 0x56                         ; 'V'
  1710:  45            LD B,L                        
  1711:  D3 59         OUT (0x59),A                  
  1713:  53            LD D,E                        
  1714:  54            LD D,H                        
  1715:  45            LD B,L                        
  1716:  4D            LD C,L                        
  1717:  CC 50 52      CALL Z,0x5250                 
  171A:  49            LD C,C                        
  171B:  4E            DB 0x4E                         ; 'N'
  171C:  54            LD D,H                        
  171D:  C4 45 46      CALL NZ,0x4645                
  1720:  D0            RET NC                        
  1721:  4F            LD C,A                        
  1722:  4B            LD C,E                        
  1723:  45            LD B,L                        
  1724:  D0            RET NC                        
  1725:  52            LD D,D                        
  1726:  49            LD C,C                        
  1727:  4E            DB 0x4E                         ; 'N'
  1728:  54            LD D,H                        
  1729:  C3 4F 4E      JP 0x4E4F                     
  172C:  54            LD D,H                        
  172D:  CC 49 53      CALL Z,0x5349                 
  1730:  54            LD D,H                        
  1731:  CC 4C 49      CALL Z,0x494C                 
  1734:  53            LD D,E                        
  1735:  54            LD D,H                        
  1736:  C4 45 4C      CALL NZ,0x4C45                
  1739:  45            LD B,L                        
  173A:  54            LD D,H                        
  173B:  45            LD B,L                        
  173C:  C1            POP BC                        
  173D:  55            LD D,L                        
  173E:  54            LD D,H                        
  173F:  4F            LD C,A                        
  1740:  C3 4C 45      JP 0x454C                     
  1743:  41            LD B,C                        
  1744:  52            LD D,D                        
  1745:  C3 4C 4F      JP 0x4F4C                     
  1748:  41            LD B,C                        
  1749:  44            LD B,H                        
  174A:  C3 53 41      JP 0x4153                     
  174D:  56            DB 0x56                         ; 'V'
  174E:  45            LD B,L                        
  174F:  CE 45         ADC A,0x45                    
  1751:  57            LD D,A                        
  1752:  D4 41 42      CALL NC,0x4241                
  1755:  28 D4         JR Z,0x172B                     ; -> 0x172B
  1757:  4F            LD C,A                        
  1758:  C6 4E         ADD A,0x4E                    
  175A:  D5            PUSH DE                       
  175B:  53            LD D,E                        
  175C:  49            LD C,C                        
  175D:  4E            DB 0x4E                         ; 'N'
  175E:  47            LD B,A                        
  175F:  D6 41         SUB 0x41                      
  1761:  52            LD D,D                        
  1762:  50            LD D,B                        
  1763:  54            LD D,H                        
  1764:  52            LD D,D                        
  1765:  D5            PUSH DE                       
  1766:  53            LD D,E                        
  1767:  52            LD D,D                        
  1768:  C5            PUSH BC                       
  1769:  52            LD D,D                        
  176A:  4C            LD C,H                        
  176B:  C5            PUSH BC                       
  176C:  52            LD D,D                        
  176D:  52            LD D,D                        
  176E:  D3 54         OUT (0x54),A                  
  1770:  52            LD D,D                        
  1771:  49            LD C,C                        
  1772:  4E            DB 0x4E                         ; 'N'
  1773:  47            LD B,A                        
  1774:  24            INC H                         
  1775:  C9            RET                           
  1776:  4E            DB 0x4E                         ; 'N'
  1777:  53            LD D,E                        
  1778:  54            LD D,H                        
  1779:  52            LD D,D                        
  177A:  D0            RET NC                        
  177B:  4F            LD C,A                        
  177C:  49            LD C,C                        
  177D:  4E            DB 0x4E                         ; 'N'
  177E:  54            LD D,H                        
  177F:  D4 49 4D      CALL NC,0x4D49                
  1782:  45            LD B,L                        
  1783:  24            INC H                         
  1784:  CD 45 4D      CALL 0x4D45                   
  1787:  C9            RET                           
  1788:  4E            DB 0x4E                         ; 'N'
  1789:  4B            LD C,E                        
  178A:  45            LD B,L                        
  178B:  59            LD E,C                        
  178C:  24            INC H                         
  178D:  D4 48 45      CALL NC,0x4548                
  1790:  4E            DB 0x4E                         ; 'N'
  1791:  CE 4F         ADC A,0x4F                    
  1793:  54            LD D,H                        
  1794:  D3 54         OUT (0x54),A                  
  1796:  45            LD B,L                        
  1797:  50            LD D,B                        
  1798:  AB            XOR E                         
  1799:  AD            XOR L                         
  179A:  AA            XOR D                         
  179B:  AF            XOR A                         
  179C:  DB C1         IN A,(0xC1)                   
  179E:  4E            DB 0x4E                         ; 'N'
  179F:  44            LD B,H                        
  17A0:  CF            RST 08h                       
  17A1:  52            LD D,D                        
  17A2:  BE            DB 0xBE                       
  17A3:  BD            CP L                          
  17A4:  BC            CP H                          
  17A5:  D3 47         OUT (0x47),A                  
  17A7:  4E            DB 0x4E                         ; 'N'
  17A8:  C9            RET                           
  17A9:  4E            DB 0x4E                         ; 'N'
  17AA:  54            LD D,H                        
  17AB:  C1            POP BC                        
  17AC:  42            LD B,D                        
  17AD:  53            LD D,E                        
  17AE:  C6 52         ADD A,0x52                    
  17B0:  45            LD B,L                        
  17B1:  C9            RET                           
  17B2:  4E            DB 0x4E                         ; 'N'
  17B3:  50            LD D,B                        
  17B4:  D0            RET NC                        
  17B5:  4F            LD C,A                        
  17B6:  53            LD D,E                        
  17B7:  D3 51         OUT (0x51),A                  
  17B9:  52            LD D,D                        
  17BA:  D2 4E 44      JP NC,0x444E                  
  17BD:  CC 4F 47      CALL Z,0x474F                 
  17C0:  C5            PUSH BC                       
  17C1:  58            LD E,B                        
  17C2:  50            LD D,B                        
  17C3:  C3 4F 53      JP 0x534F                     
  17C6:  D3 49         OUT (0x49),A                  
  17C8:  4E            DB 0x4E                         ; 'N'
  17C9:  D4 41 4E      CALL NC,0x4E41                
  17CC:  C1            POP BC                        
  17CD:  54            LD D,H                        
  17CE:  4E            DB 0x4E                         ; 'N'
  17CF:  D0            RET NC                        
  17D0:  45            LD B,L                        
  17D1:  45            LD B,L                        
  17D2:  4B            LD C,E                        
  17D3:  C3 56 49      JP 0x4956                     
  17D6:  C3 56 53      JP 0x5356                     
  17D9:  C3 56 44      JP 0x4456                     
  17DC:  C5            PUSH BC                       
  17DD:  4F            LD C,A                        
  17DE:  46            DB 0x46                         ; 'F'
  17DF:  CC 4F 43      CALL Z,0x434F                 
  17E2:  CC 4F 46      CALL Z,0x464F                 
  17E5:  CD 4B 49      CALL 0x494B                   
  17E8:  24            INC H                         
  17E9:  CD 4B 53      CALL 0x534B                   
  17EC:  24            INC H                         
  17ED:  CD 4B 44      CALL 0x444B                   
  17F0:  24            INC H                         
  17F1:  C3 49 4E      JP 0x4E49                     
  17F4:  54            LD D,H                        
  17F5:  C3 53 4E      JP 0x4E53                     
  17F8:  47            LD B,A                        
  17F9:  C3 44 42      JP 0x4244                     
  17FC:  4C            LD C,H                        
  17FD:  C6 49         ADD A,0x49                    
  17FF:  58            LD E,B                        
  1800:  CC 45 4E      CALL Z,0x4E45                 
  1803:  D3 54         OUT (0x54),A                  
  1805:  52            LD D,D                        
  1806:  24            INC H                         
  1807:  D6 41         SUB 0x41                      
  1809:  4C            LD C,H                        
  180A:  C1            POP BC                        
  180B:  53            LD D,E                        
  180C:  43            LD B,E                        
  180D:  C3 48 52      JP 0x5248                     
  1810:  24            INC H                         
  1811:  CC 45 46      CALL Z,0x4645                 
  1814:  54            LD D,H                        
  1815:  24            INC H                         
  1816:  D2 49 47      JP NC,0x4749                  
  1819:  48            LD C,B                        
  181A:  54            LD D,H                        
  181B:  24            INC H                         
  181C:  CD 49 44      CALL 0x4449                   
  181F:  24            INC H                         
  1820:  A7            AND A                         
  1821:  80            ADD A,B                       
  1822:  AE            DB 0xAE                       
  1823:  1D            DEC E                         
  1824:  A1            AND C                         
  1825:  1C            INC E                         
  1826:  38 01         JR C,0x1829                     ; -> 0x1829
  1828:  35            DEC (HL)                      
  1829:  01 C9 01      LD BC,0x01C9                  
  182C:  73            LD (HL),E                     
  182D:  41            LD B,C                        
  182E:  D3 01         OUT (0x01),A                  
  1830:  B6            DB 0xB6                       
  1831:  22 05 1F      LD (0x1F05),HL                
  1834:  9A            DB 0x9A                       
  1835:  21 08 26      LD HL,0x2608                  
  1838:  EF            RST 28h                       
  1839:  21 21 1F      LD HL,0x1F21                  
  183C:  C2 1E A3      JP NZ,0xA31E                  
  183F:  1E 39         LD E,0x39                     
  1841:  20 91         JR NZ,0x17D4                    ; -> 0x17D4
  1843:  1D            DEC E                         
  1844:  B1            OR C                          
  1845:  1E DE         LD E,0xDE                     
  1847:  1E 07         LD E,0x07                     
  1849:  1F            RRA                           
  184A:  A9            XOR C                         
  184B:  1D            DEC E                         
  184C:  07            RLCA                          
  184D:  1F            RRA                           
  184E:  F7            RST 30h                       
  184F:  1D            DEC E                         
  1850:  F8            RET M                         
  1851:  1D            DEC E                         
  1852:  00            NOP                           
  1853:  1E 03         LD E,0x03                     
  1855:  1E 06         LD E,0x06                     
  1857:  1E 09         LD E,0x09                     
  1859:  1E A3         LD E,0xA3                     
  185B:  41            LD B,C                        
  185C:  60            LD H,B                        
  185D:  2E F4         LD L,0xF4                     
  185F:  1F            RRA                           
  1860:  AF            XOR A                         
  1861:  1F            RRA                           
  1862:  FB            EI                            
  1863:  2A 6C 1F      LD HL,(0x1F6C)                
  1866:  79            LD A,C                        
  1867:  41            LD B,C                        
  1868:  7C            LD A,H                        
  1869:  41            LD B,C                        
  186A:  7F            LD A,A                        
  186B:  41            LD B,C                        
  186C:  82            ADD A,D                       
  186D:  41            LD B,C                        
  186E:  85            ADD A,L                       
  186F:  41            LD B,C                        
  1870:  88            ADC A,B                       
  1871:  41            LD B,C                        
  1872:  8B            DB 0x8B                       
  1873:  41            LD B,C                        
  1874:  8E            DB 0x8E                       
  1875:  41            LD B,C                        
  1876:  91            DB 0x91                       
  1877:  41            LD B,C                        
  1878:  97            SUB A                         
  1879:  41            LD B,C                        
  187A:  9A            DB 0x9A                       
  187B:  41            LD B,C                        
  187C:  A0            AND B                         
  187D:  41            LD B,C                        
  187E:  B2            OR D                          
  187F:  02            DB 0x02                       
  1880:  67            LD H,A                        
  1881:  20 5B         JR NZ,0x18DE                    ; -> 0x18DE
  1883:  41            LD B,C                        
  1884:  B1            OR C                          
  1885:  2C            INC L                         
  1886:  6F            LD L,A                        
  1887:  20 E4         JR NZ,0x186D                    ; -> 0x186D
  1889:  1D            DEC E                         
  188A:  2E 2B         LD L,0x2B                     
  188C:  29            ADD HL,HL                     
  188D:  2B            DEC HL                        
  188E:  C6 2B         ADD A,0x2B                    
  1890:  08            EX AF,AF'                     
  1891:  20 7A         JR NZ,0x190D                    ; -> 0x190D
  1893:  1E 1F         LD E,0x1F                     
  1895:  2C            INC L                         
  1896:  F5            PUSH AF                       
  1897:  2B            DEC HL                        
  1898:  49            LD C,C                        
  1899:  1B            DEC DE                        
  189A:  79            LD A,C                        
  189B:  79            LD A,C                        
  189C:  7C            LD A,H                        
  189D:  7C            LD A,H                        
  189E:  7F            LD A,A                        
  189F:  50            LD D,B                        
  18A0:  46            DB 0x46                         ; 'F'
  18A1:  DB 0A         IN A,(port_keyboard)            ; lê teclado
  18A3:  00            NOP                           
  18A4:  00            NOP                           
  18A5:  7F            LD A,A                        
  18A6:  0A            DB 0x0A                       
  18A7:  F4 0A B1      CALL P,0xB10A                 
  18AA:  0A            DB 0x0A                       
  18AB:  77            LD (HL),A                     
  18AC:  0C            INC C                         
  18AD:  70            LD (HL),B                     
  18AE:  0C            INC C                         
  18AF:  A1            AND C                         
  18B0:  0D            DEC C                         
  18B1:  E5            PUSH HL                       
  18B2:  0D            DEC C                         
  18B3:  78            LD A,B                        
  18B4:  0A            DB 0x0A                       
  18B5:  16 07         LD D,0x07                     
  18B7:  13            INC DE                        
  18B8:  07            RLCA                          
  18B9:  47            LD B,A                        
  18BA:  08            EX AF,AF'                     
  18BB:  A2            AND D                         
  18BC:  08            EX AF,AF'                     
  18BD:  0C            INC C                         
  18BE:  0A            DB 0x0A                       
  18BF:  D2 0B C7      JP NC,0xC70B                  
  18C2:  0B            DEC BC                        
  18C3:  F2 0B 90      JP P,0x900B                   
  18C6:  24            INC H                         
  18C7:  39            ADD HL,SP                     
  18C8:  0A            DB 0x0A                       

;
; ─── TABELA DE ERROS BASIC ─────────────────────────────────────────

BASIC_ERROR_TABLE:
  18C9:  4E            DB 0x4E                         ; 'N'
  18CA:  46            DB 0x46                         ; 'F'
  18CB:  53            LD D,E                        
  18CC:  4E            DB 0x4E                         ; 'N'
  18CD:  52            LD D,D                        
  18CE:  47            LD B,A                        
  18CF:  46            DB 0x46                         ; 'F'
  18D0:  44            LD B,H                        
  18D1:  50            LD D,B                        
  18D2:  49            LD C,C                        
  18D3:  4F            LD C,A                        
  18D4:  56            DB 0x56                         ; 'V'
  18D5:  46            DB 0x46                         ; 'F'
  18D6:  4D            LD C,L                        
  18D7:  4C            LD C,H                        
  18D8:  49            LD C,C                        
  18D9:  49            LD C,C                        
  18DA:  41            LD B,C                        
  18DB:  41            LD B,C                        
  18DC:  52            LD D,D                        
  18DD:  2F            CPL                           
  18DE:  30 43         JR NC,0x1923                    ; -> 0x1923
  18E0:  54            LD D,H                        
  18E1:  56            DB 0x56                         ; 'V'
  18E2:  49            LD C,C                        
  18E3:  4F            LD C,A                        
  18E4:  53            LD D,E                        
  18E5:  53            LD D,E                        
  18E6:  47            LD B,A                        
  18E7:  46            DB 0x46                         ; 'F'
  18E8:  43            LD B,E                        
  18E9:  49            LD C,C                        
  18EA:  43            LD B,E                        
  18EB:  4E            DB 0x4E                         ; 'N'
  18EC:  52            LD D,D                        
  18ED:  52            LD D,D                        
  18EE:  45            LD B,L                        
  18EF:  43            LD B,E                        
  18F0:  4E            DB 0x4E                         ; 'N'
  18F1:  46            DB 0x46                         ; 'F'
  18F2:  4F            LD C,A                        
  18F3:  41            LD B,C                        
  18F4:  49            LD C,C                        
  18F5:  43            LD B,E                        
  18F6:  44            LD B,H                        
  18F7:  D6 00         SUB 0x00                      
  18F9:  6F            LD L,A                        
  18FA:  7C            LD A,H                        
  18FB:  DE 00         SBC A,0x00                    
  18FD:  67            LD H,A                        
  18FE:  78            LD A,B                        
  18FF:  DE 00         SBC A,0x00                    
  1901:  47            LD B,A                        
  1902:  3E 00         LD A,0x00                     
  1904:  C9            RET                           
  1905:  4A            LD C,D                        
  1906:  1E 40         LD E,0x40                     
  1908:  E6 4D         AND 0x4D                      
  190A:  DB 00         IN A,(port_misc_00)           
  190C:  C9            RET                           
  190D:  D3 00         OUT (port_misc_00),A          
  190F:  C9            RET                           
  1910:  00            NOP                           
  1911:  00            NOP                           
  1912:  00            NOP                           
  1913:  00            NOP                           
  1914:  40            LD B,B                        
  1915:  30 00         JR NC,0x1917                    ; -> 0x1917
  1917:  4C            LD C,H                        
  1918:  43            LD B,E                        
STR_B_ERRO:
  1919:  FE FF         CP 0xFF                       
  191B:  E9            JP (HL)                       
  191C:  42            LD B,D                        
  191D:  20 45         JR NZ,0x1964                    ; -> 0x1964
  191F:  72            LD (HL),D                     
  1920:  72            LD (HL),D                     
  1921:  6F            LD L,A                        
  1922:  00            NOP                           
  1923:  00            NOP                           
STR_NA:
  1924:  20 6E         JR NZ,0x1994                    ; -> 0x1994
  1926:  61            LD H,C                        
  1927:  20 00         JR NZ,STR_READY                 ; -> 0x1929
STR_READY:
  1929:  52            LD D,D                        
  192A:  65            LD H,L                        
  192B:  61            LD H,C                        
  192C:  64            LD H,H                        
  192D:  79            LD A,C                        
  192E:  0D            DEC C                         
  192F:  00            NOP                           
STR_BREAK:
  1930:  42            LD B,D                        
  1931:  72            LD (HL),D                     
  1932:  65            LD H,L                        
  1933:  61            LD H,C                        
  1934:  6B            LD L,E                        
  1935:  00            NOP                           
  1936:  21 04 00      LD HL,0x0004                  
  1939:  39            ADD HL,SP                     
  193A:  7E            LD A,(HL)                     
  193B:  23            INC HL                        
  193C:  FE 81         CP 0x81                       
  193E:  C0            RET NZ                        
  193F:  4E            DB 0x4E                         ; 'N'
  1940:  23            INC HL                        
  1941:  46            DB 0x46                         ; 'F'
  1942:  23            INC HL                        
  1943:  E5            PUSH HL                       
  1944:  69            LD L,C                        
  1945:  60            LD H,B                        
  1946:  7A            LD A,D                        
  1947:  B3            OR E                          
  1948:  EB            EX DE,HL                      
  1949:  28 02         JR Z,0x194D                     ; -> 0x194D
  194B:  EB            EX DE,HL                      
  194C:  DF            RST 18h                       
  194D:  01 0E 00      LD BC,0x000E                  
  1950:  E1            POP HL                        
  1951:  C8            RET Z                         
  1952:  09            ADD HL,BC                     
  1953:  18 E5         JR 0x193A                       ; -> 0x193A
  1955:  CD 6C 19      CALL 0x196C                   
  1958:  C5            PUSH BC                       
  1959:  E3            EX (SP),HL                    
  195A:  C1            POP BC                        
  195B:  DF            RST 18h                       
  195C:  7E            LD A,(HL)                     
  195D:  02            DB 0x02                       
  195E:  C8            RET Z                         
  195F:  0B            DEC BC                        
  1960:  2B            DEC HL                        
  1961:  18 F8         JR 0x195B                       ; -> 0x195B
  1963:  E5            PUSH HL                       
  1964:  2A FD 40      LD HL,(0x40FD)                
  1967:  06 00         LD B,0x00                     
  1969:  09            ADD HL,BC                     
  196A:  09            ADD HL,BC                     
  196B:  3E E5         LD A,0xE5                     
  196D:  3E C6         LD A,0xC6                     
  196F:  95            DB 0x95                       
  1970:  6F            LD L,A                        
  1971:  3E FF         LD A,0xFF                     
  1973:  9C            DB 0x9C                       
  1974:  38 04         JR C,0x197A                     ; -> 0x197A
  1976:  67            LD H,A                        
  1977:  39            ADD HL,SP                     
  1978:  E1            POP HL                        
  1979:  D8            RET C                         
  197A:  1E 0C         LD E,0x0C                     
  197C:  18 24         JR 0x19A2                       ; -> 0x19A2
  197E:  2A A2 40      LD HL,(0x40A2)                
  1981:  7C            LD A,H                        
  1982:  A5            AND L                         
  1983:  3C            INC A                         
  1984:  28 08         JR Z,0x198E                     ; -> 0x198E
  1986:  3A F2 40      LD A,(0x40F2)                 
  1989:  B7            OR A                          
  198A:  1E 22         LD E,0x22                     
  198C:  20 14         JR NZ,0x19A2                    ; -> 0x19A2
  198E:  C3 C1 1D      JP 0x1DC1                     
  1991:  2A DA 40      LD HL,(0x40DA)                
  1994:  22 A2 40      LD (0x40A2),HL                
  1997:  1E 02         LD E,0x02                     
  1999:  01 1E 14      LD BC,0x141E                  
  199C:  01 1E 00      LD BC,0x001E                  
  199F:  01 1E 24      LD BC,0x241E                  
  19A2:  2A A2 40      LD HL,(0x40A2)                
  19A5:  22 EA 40      LD (0x40EA),HL                
  19A8:  22 EC 40      LD (0x40EC),HL                
  19AB:  01 B4 19      LD BC,0x19B4                  
  19AE:  2A E8 40      LD HL,(0x40E8)                
  19B1:  C3 9A 1B      JP 0x1B9A                     
  19B4:  C1            POP BC                        
  19B5:  7B            LD A,E                        
  19B6:  4B            LD C,E                        
  19B7:  32 9A 40      LD (0x409A),A                   ; → RAM sistema
  19BA:  2A E6 40      LD HL,(0x40E6)                
  19BD:  22 EE 40      LD (0x40EE),HL                
  19C0:  EB            EX DE,HL                      
  19C1:  2A EA 40      LD HL,(0x40EA)                
  19C4:  7C            LD A,H                        
  19C5:  A5            AND L                         
  19C6:  3C            INC A                         
  19C7:  28 07         JR Z,0x19D0                     ; -> 0x19D0
  19C9:  22 F5 40      LD (0x40F5),HL                
  19CC:  EB            EX DE,HL                      
  19CD:  22 F7 40      LD (0x40F7),HL                
  19D0:  2A F0 40      LD HL,(0x40F0)                
  19D3:  7C            LD A,H                        
  19D4:  B5            OR L                          
  19D5:  EB            EX DE,HL                      
  19D6:  21 F2 40      LD HL,0x40F2                    ; ← RAM sistema
  19D9:  28 08         JR Z,0x19E3                     ; -> 0x19E3
  19DB:  A6            DB 0xA6                       
  19DC:  20 05         JR NZ,0x19E3                    ; -> 0x19E3
  19DE:  35            DEC (HL)                      
  19DF:  EB            EX DE,HL                      
  19E0:  C3 36 1D      JP 0x1D36                     
  19E3:  AF            XOR A                         
  19E4:  77            LD (HL),A                     
  19E5:  59            LD E,C                        
  19E6:  CD F9 20      CALL 0x20F9                   
  19E9:  21 C9 18      LD HL,0x18C9                  
  19EC:  CD A6 41      CALL 0x41A6                   
  19EF:  57            LD D,A                        
  19F0:  3E 3F         LD A,0x3F                     
  19F2:  CD 2A 03      CALL DISPLAY_CHAR             
  19F5:  19            ADD HL,DE                     
  19F6:  7E            LD A,(HL)                     
  19F7:  CD 2A 03      CALL DISPLAY_CHAR             
  19FA:  D7            RST 10h                       
  19FB:  CD 2A 03      CALL DISPLAY_CHAR             
  19FE:  21 1D 19      LD HL,0x191D                  
  1A01:  E5            PUSH HL                       
  1A02:  2A EA 40      LD HL,(0x40EA)                
  1A05:  E3            EX (SP),HL                    
  1A06:  CD A7 28      CALL PRINT_STRING             
  1A09:  E1            POP HL                        
  1A0A:  11 FE FF      LD DE,0xFFFE                  
  1A0D:  DF            RST 18h                       
  1A0E:  CA 74 06      JP Z,BOOT_HW_INIT             
  1A11:  7C            LD A,H                        
  1A12:  A5            AND L                         
  1A13:  3C            INC A                         
  1A14:  C4 A7 0F      CALL NZ,0x0FA7                
  1A17:  3E C1         LD A,0xC1                     
BASIC_MAIN_LOOP:
  1A19:  CD 8B 03      CALL 0x038B                   
  1A1C:  CD AC 41      CALL 0x41AC                   
  1A1F:  CD F8 01      CALL 0x01F8                   
  1A22:  CD F9 20      CALL 0x20F9                   
  1A25:  21 29 19      LD HL,0x1929                  
  1A28:  CD A7 28      CALL PRINT_STRING             
  1A2B:  3A 9A 40      LD A,(0x409A)                 
  1A2E:  D6 02         SUB 0x02                      
  1A30:  CC 53 2E      CALL Z,0x2E53                 
  1A33:  21 FF FF      LD HL,0xFFFF                  
  1A36:  22 A2 40      LD (0x40A2),HL                
  1A39:  3A E1 40      LD A,(0x40E1)                 
  1A3C:  B7            OR A                          
  1A3D:  28 37         JR Z,0x1A76                     ; -> 0x1A76
  1A3F:  2A E2 40      LD HL,(0x40E2)                
  1A42:  E5            PUSH HL                       
  1A43:  CD AF 0F      CALL 0x0FAF                   
  1A46:  D1            POP DE                        
  1A47:  D5            PUSH DE                       
  1A48:  CD 2C 1B      CALL 0x1B2C                   
  1A4B:  3E 2A         LD A,0x2A                     
  1A4D:  38 02         JR C,0x1A51                     ; -> 0x1A51
  1A4F:  3E 20         LD A,0x20                     
  1A51:  CD 2A 03      CALL DISPLAY_CHAR             
  1A54:  CD 61 03      CALL 0x0361                   
  1A57:  D1            POP DE                        
  1A58:  30 06         JR NC,0x1A60                    ; -> 0x1A60
  1A5A:  AF            XOR A                         
  1A5B:  32 E1 40      LD (0x40E1),A                   ; → RAM sistema
  1A5E:  18 B9         JR BASIC_MAIN_LOOP              ; -> 0x1A19
  1A60:  2A E4 40      LD HL,(0x40E4)                
  1A63:  19            ADD HL,DE                     
  1A64:  38 F4         JR C,0x1A5A                     ; -> 0x1A5A
  1A66:  D5            PUSH DE                       
  1A67:  11 F9 FF      LD DE,0xFFF9                  
  1A6A:  DF            RST 18h                       
  1A6B:  D1            POP DE                        
  1A6C:  30 EC         JR NC,0x1A5A                    ; -> 0x1A5A
  1A6E:  22 E2 40      LD (0x40E2),HL                
  1A71:  F6 FF         OR 0xFF                       
  1A73:  C3 EB 2F      JP 0x2FEB                     
  1A76:  3E 3E         LD A,0x3E                     
  1A78:  CD 2A 03      CALL DISPLAY_CHAR             
  1A7B:  CD 61 03      CALL 0x0361                   
  1A7E:  DA 33 1A      JP C,0x1A33                   
  1A81:  D7            RST 10h                       
  1A82:  3C            INC A                         
  1A83:  3D            DEC A                         
  1A84:  CA 33 1A      JP Z,0x1A33                   
  1A87:  F5            PUSH AF                       
  1A88:  CD 5A 1E      CALL 0x1E5A                   
  1A8B:  2B            DEC HL                        
  1A8C:  7E            LD A,(HL)                     
  1A8D:  FE 20         CP 0x20                       
  1A8F:  28 FA         JR Z,0x1A8B                     ; -> 0x1A8B
  1A91:  23            INC HL                        
  1A92:  7E            LD A,(HL)                     
  1A93:  FE 20         CP 0x20                       
  1A95:  CC C9 09      CALL Z,0x09C9                 
  1A98:  D5            PUSH DE                       
  1A99:  CD C0 1B      CALL 0x1BC0                   
  1A9C:  D1            POP DE                        
  1A9D:  F1            POP AF                        
  1A9E:  22 E6 40      LD (0x40E6),HL                
  1AA1:  CD B2 41      CALL 0x41B2                   
  1AA4:  D2 5A 1D      JP NC,0x1D5A                  
  1AA7:  D5            PUSH DE                       
  1AA8:  C5            PUSH BC                       
  1AA9:  AF            XOR A                         
  1AAA:  32 DD 40      LD (0x40DD),A                   ; → RAM sistema
  1AAD:  D7            RST 10h                       
  1AAE:  B7            OR A                          
  1AAF:  F5            PUSH AF                       
  1AB0:  EB            EX DE,HL                      
  1AB1:  22 EC 40      LD (0x40EC),HL                
  1AB4:  EB            EX DE,HL                      
  1AB5:  CD 2C 1B      CALL 0x1B2C                   
  1AB8:  C5            PUSH BC                       
  1AB9:  DC E4 2B      CALL C,0x2BE4                 
  1ABC:  D1            POP DE                        
  1ABD:  F1            POP AF                        
  1ABE:  D5            PUSH DE                       
  1ABF:  28 27         JR Z,0x1AE8                     ; -> 0x1AE8
  1AC1:  D1            POP DE                        
  1AC2:  2A F9 40      LD HL,(0x40F9)                
  1AC5:  E3            EX (SP),HL                    
  1AC6:  C1            POP BC                        
  1AC7:  09            ADD HL,BC                     
  1AC8:  E5            PUSH HL                       
  1AC9:  CD 55 19      CALL 0x1955                   
  1ACC:  E1            POP HL                        
  1ACD:  22 F9 40      LD (0x40F9),HL                
  1AD0:  EB            EX DE,HL                      
  1AD1:  74            LD (HL),H                     
  1AD2:  D1            POP DE                        
  1AD3:  E5            PUSH HL                       
  1AD4:  23            INC HL                        
  1AD5:  23            INC HL                        
  1AD6:  73            LD (HL),E                     
  1AD7:  23            INC HL                        
  1AD8:  72            LD (HL),D                     
  1AD9:  23            INC HL                        
  1ADA:  EB            EX DE,HL                      
  1ADB:  2A A7 40      LD HL,(0x40A7)                
  1ADE:  EB            EX DE,HL                      
  1ADF:  1B            DEC DE                        
  1AE0:  1B            DEC DE                        
  1AE1:  1A            DB 0x1A                       
  1AE2:  77            LD (HL),A                     
  1AE3:  23            INC HL                        
  1AE4:  13            INC DE                        
  1AE5:  B7            OR A                          
  1AE6:  20 F9         JR NZ,0x1AE1                    ; -> 0x1AE1
  1AE8:  D1            POP DE                        
  1AE9:  CD FC 1A      CALL 0x1AFC                   
  1AEC:  CD B5 41      CALL 0x41B5                   
  1AEF:  CD 5D 1B      CALL 0x1B5D                   
  1AF2:  CD B8 41      CALL 0x41B8                   
  1AF5:  C3 33 1A      JP 0x1A33                     
  1AF8:  2A A4 40      LD HL,(0x40A4)                
  1AFB:  EB            EX DE,HL                      
  1AFC:  62            LD H,D                        
  1AFD:  6B            LD L,E                        
  1AFE:  7E            LD A,(HL)                     
  1AFF:  23            INC HL                        
  1B00:  B6            DB 0xB6                       
  1B01:  C8            RET Z                         
  1B02:  23            INC HL                        
  1B03:  23            INC HL                        
  1B04:  23            INC HL                        
  1B05:  AF            XOR A                         
  1B06:  BE            DB 0xBE                       
  1B07:  23            INC HL                        
  1B08:  20 FC         JR NZ,0x1B06                    ; -> 0x1B06
  1B0A:  EB            EX DE,HL                      
  1B0B:  73            LD (HL),E                     
  1B0C:  23            INC HL                        
  1B0D:  72            LD (HL),D                     
  1B0E:  18 EC         JR 0x1AFC                       ; -> 0x1AFC
  1B10:  11 00 00      LD DE,0x0000                  
  1B13:  D5            PUSH DE                       
  1B14:  28 09         JR Z,0x1B1F                     ; -> 0x1B1F
  1B16:  D1            POP DE                        
  1B17:  CD 4F 1E      CALL 0x1E4F                   
  1B1A:  D5            PUSH DE                       
  1B1B:  28 0B         JR Z,0x1B28                     ; -> 0x1B28
  1B1D:  CF            RST 08h                       
  1B1E:  CE 11         ADC A,0x11                    
  1B20:  FA FF C4      JP M,0xC4FF                   
  1B23:  4F            LD C,A                        
  1B24:  1E C2         LD E,0xC2                     
  1B26:  97            SUB A                         
  1B27:  19            ADD HL,DE                     
  1B28:  EB            EX DE,HL                      
  1B29:  D1            POP DE                        
  1B2A:  E3            EX (SP),HL                    
  1B2B:  E5            PUSH HL                       
  1B2C:  2A A4 40      LD HL,(0x40A4)                
  1B2F:  44            LD B,H                        
  1B30:  4D            LD C,L                        
  1B31:  7E            LD A,(HL)                     
  1B32:  23            INC HL                        
  1B33:  B6            DB 0xB6                       
  1B34:  2B            DEC HL                        
  1B35:  C8            RET Z                         
  1B36:  23            INC HL                        
  1B37:  23            INC HL                        
  1B38:  7E            LD A,(HL)                     
  1B39:  23            INC HL                        
  1B3A:  66            DB 0x66                         ; 'f'
  1B3B:  6F            LD L,A                        
  1B3C:  DF            RST 18h                       
  1B3D:  60            LD H,B                        
  1B3E:  69            LD L,C                        
  1B3F:  7E            LD A,(HL)                     
  1B40:  23            INC HL                        
  1B41:  66            DB 0x66                         ; 'f'
  1B42:  6F            LD L,A                        
  1B43:  3F            CCF                           
  1B44:  C8            RET Z                         
  1B45:  3F            CCF                           
  1B46:  D0            RET NC                        
  1B47:  18 E6         JR 0x1B2F                       ; -> 0x1B2F
  1B49:  C0            RET NZ                        
  1B4A:  CD C9 01      CALL HW_INIT_2                
HW_INIT_3:
  1B4D:  2A A4 40      LD HL,(0x40A4)                
  1B50:  CD F8 1D      CALL 0x1DF8                   
  1B53:  32 E1 40      LD (0x40E1),A                   ; → RAM sistema
  1B56:  77            LD (HL),A                     
  1B57:  23            INC HL                        
  1B58:  77            LD (HL),A                     
  1B59:  23            INC HL                        
  1B5A:  22 F9 40      LD (0x40F9),HL                
  1B5D:  2A A4 40      LD HL,(0x40A4)                
  1B60:  2B            DEC HL                        
  1B61:  22 DF 40      LD (ptr_program),HL           
  1B64:  06 1A         LD B,0x1A                     
  1B66:  21 01 41      LD HL,0x4101                    ; ← RAM sistema
  1B69:  36 04         LD (HL),0x04                  
  1B6B:  23            INC HL                        
  1B6C:  10 FB         DJNZ 0x1B69                     ; loop para 0x1B69
  1B6E:  AF            XOR A                         
  1B6F:  32 F2 40      LD (0x40F2),A                   ; → RAM sistema
  1B72:  6F            LD L,A                        
  1B73:  67            LD H,A                        
  1B74:  22 F0 40      LD (0x40F0),HL                
  1B77:  22 F7 40      LD (0x40F7),HL                
  1B7A:  2A B1 40      LD HL,(ptr_mem_high)          
  1B7D:  22 D6 40      LD (0x40D6),HL                
  1B80:  CD 91 1D      CALL 0x1D91                   
  1B83:  2A F9 40      LD HL,(0x40F9)                
  1B86:  22 FB 40      LD (0x40FB),HL                
  1B89:  22 FD 40      LD (0x40FD),HL                
  1B8C:  CD BB 41      CALL 0x41BB                   
HW_INIT_1:
  1B8F:  C1            POP BC                        
  1B90:  2A A0 40      LD HL,(0x40A0)                
  1B93:  2B            DEC HL                        
  1B94:  2B            DEC HL                        
  1B95:  22 E8 40      LD (0x40E8),HL                
  1B98:  23            INC HL                        
  1B99:  23            INC HL                        
  1B9A:  F9            LD SP,HL                      
  1B9B:  21 B5 40      LD HL,0x40B5                    ; ← RAM sistema
  1B9E:  22 B3 40      LD (0x40B3),HL                
  1BA1:  CD 8B 03      CALL 0x038B                   
  1BA4:  CD 6D 21      CALL 0x216D                   
  1BA7:  AF            XOR A                         
  1BA8:  67            LD H,A                        
  1BA9:  6F            LD L,A                        
  1BAA:  32 DC 40      LD (0x40DC),A                   ; → RAM sistema
  1BAD:  E5            PUSH HL                       
  1BAE:  C5            PUSH BC                       
  1BAF:  2A DF 40      LD HL,(ptr_program)           
  1BB2:  C9            RET                           
PROTEGER_HW_READ:
  1BB3:  3E 3F         LD A,0x3F                     
  1BB5:  CD 2A 03      CALL DISPLAY_CHAR             
  1BB8:  3E 20         LD A,0x20                     
  1BBA:  CD 2A 03      CALL DISPLAY_CHAR             
  1BBD:  C3 61 03      JP 0x0361                     
  1BC0:  AF            XOR A                         
  1BC1:  32 B0 40      LD (0x40B0),A                   ; → RAM sistema
  1BC4:  4F            LD C,A                        
  1BC5:  EB            EX DE,HL                      
  1BC6:  2A A7 40      LD HL,(0x40A7)                
  1BC9:  2B            DEC HL                        
  1BCA:  2B            DEC HL                        
  1BCB:  EB            EX DE,HL                      
  1BCC:  7E            LD A,(HL)                     
  1BCD:  FE 20         CP 0x20                       
  1BCF:  CA 5B 1C      JP Z,0x1C5B                   
  1BD2:  47            LD B,A                        
  1BD3:  FE 22         CP 0x22                       
  1BD5:  CA 77 1C      JP Z,0x1C77                   
  1BD8:  B7            OR A                          
  1BD9:  CA 7D 1C      JP Z,0x1C7D                   
  1BDC:  3A B0 40      LD A,(0x40B0)                 
  1BDF:  B7            OR A                          
  1BE0:  7E            LD A,(HL)                     
  1BE1:  C2 5B 1C      JP NZ,0x1C5B                  
  1BE4:  FE 3F         CP 0x3F                       
  1BE6:  3E B2         LD A,0xB2                     
  1BE8:  CA 5B 1C      JP Z,0x1C5B                   
  1BEB:  7E            LD A,(HL)                     
  1BEC:  FE 30         CP 0x30                       
  1BEE:  38 05         JR C,0x1BF5                     ; -> 0x1BF5
  1BF0:  FE 3C         CP 0x3C                       
  1BF2:  DA 5B 1C      JP C,0x1C5B                   
  1BF5:  D5            PUSH DE                       
  1BF6:  11 4F 16      LD DE,0x164F                  
  1BF9:  C5            PUSH BC                       
  1BFA:  01 3D 1C      LD BC,0x1C3D                  
  1BFD:  C5            PUSH BC                       
  1BFE:  06 7F         LD B,0x7F                     
  1C00:  7E            LD A,(HL)                     
  1C01:  FE 61         CP 0x61                       
  1C03:  38 07         JR C,0x1C0C                     ; -> 0x1C0C
  1C05:  FE 7B         CP 0x7B                       
  1C07:  30 03         JR NC,0x1C0C                    ; -> 0x1C0C
  1C09:  E6 5F         AND 0x5F                      
  1C0B:  77            LD (HL),A                     
  1C0C:  4E            DB 0x4E                         ; 'N'
  1C0D:  EB            EX DE,HL                      
  1C0E:  23            INC HL                        
  1C0F:  B6            DB 0xB6                       
  1C10:  F2 0E 1C      JP P,0x1C0E                   
  1C13:  04            INC B                         
  1C14:  7E            LD A,(HL)                     
  1C15:  E6 7F         AND 0x7F                      
  1C17:  C8            RET Z                         
  1C18:  B9            CP C                          
  1C19:  20 F3         JR NZ,0x1C0E                    ; -> 0x1C0E
  1C1B:  EB            EX DE,HL                      
  1C1C:  E5            PUSH HL                       
  1C1D:  13            INC DE                        
  1C1E:  1A            DB 0x1A                       
  1C1F:  B7            OR A                          
  1C20:  FA 39 1C      JP M,0x1C39                   
  1C23:  4F            LD C,A                        
  1C24:  78            LD A,B                        
  1C25:  FE 8D         CP 0x8D                       
  1C27:  20 02         JR NZ,0x1C2B                    ; -> 0x1C2B
  1C29:  D7            RST 10h                       
  1C2A:  2B            DEC HL                        
  1C2B:  23            INC HL                        
  1C2C:  7E            LD A,(HL)                     
  1C2D:  FE 61         CP 0x61                       
  1C2F:  38 02         JR C,0x1C33                     ; -> 0x1C33
  1C31:  E6 5F         AND 0x5F                      
  1C33:  B9            CP C                          
  1C34:  28 E7         JR Z,0x1C1D                     ; -> 0x1C1D
  1C36:  E1            POP HL                        
  1C37:  18 D3         JR 0x1C0C                       ; -> 0x1C0C
  1C39:  48            LD C,B                        
  1C3A:  F1            POP AF                        
  1C3B:  EB            EX DE,HL                      
  1C3C:  C9            RET                           
  1C3D:  EB            EX DE,HL                      
  1C3E:  79            LD A,C                        
  1C3F:  C1            POP BC                        
  1C40:  D1            POP DE                        
  1C41:  EB            EX DE,HL                      
  1C42:  FE 95         CP 0x95                       
  1C44:  36 3A         LD (HL),0x3A                  
  1C46:  20 02         JR NZ,0x1C4A                    ; -> 0x1C4A
  1C48:  0C            INC C                         
  1C49:  23            INC HL                        
  1C4A:  FE FB         CP 0xFB                       
  1C4C:  20 0C         JR NZ,0x1C5A                    ; -> 0x1C5A
  1C4E:  36 3A         LD (HL),0x3A                  
  1C50:  23            INC HL                        
  1C51:  06 93         LD B,0x93                     
  1C53:  70            LD (HL),B                     
  1C54:  23            INC HL                        
  1C55:  EB            EX DE,HL                      
  1C56:  0C            INC C                         
  1C57:  0C            INC C                         
  1C58:  18 1D         JR 0x1C77                       ; -> 0x1C77
  1C5A:  EB            EX DE,HL                      
  1C5B:  23            INC HL                        
  1C5C:  12            DB 0x12                       
  1C5D:  13            INC DE                        
  1C5E:  0C            INC C                         
  1C5F:  D6 3A         SUB 0x3A                      
  1C61:  28 04         JR Z,0x1C67                     ; -> 0x1C67
  1C63:  FE 4E         CP 0x4E                       
  1C65:  20 03         JR NZ,0x1C6A                    ; -> 0x1C6A
  1C67:  32 B0 40      LD (0x40B0),A                   ; → RAM sistema
  1C6A:  D6 59         SUB 0x59                      
  1C6C:  C2 CC 1B      JP NZ,0x1BCC                  
  1C6F:  47            LD B,A                        
  1C70:  7E            LD A,(HL)                     
  1C71:  B7            OR A                          
  1C72:  28 09         JR Z,0x1C7D                     ; -> 0x1C7D
  1C74:  B8            CP B                          
  1C75:  28 E4         JR Z,0x1C5B                     ; -> 0x1C5B
  1C77:  23            INC HL                        
  1C78:  12            DB 0x12                       
  1C79:  0C            INC C                         
  1C7A:  13            INC DE                        
  1C7B:  18 F3         JR 0x1C70                       ; -> 0x1C70
  1C7D:  21 05 00      LD HL,0x0005                  
  1C80:  44            LD B,H                        
  1C81:  09            ADD HL,BC                     
  1C82:  44            LD B,H                        
  1C83:  4D            LD C,L                        
  1C84:  2A A7 40      LD HL,(0x40A7)                
  1C87:  2B            DEC HL                        
  1C88:  2B            DEC HL                        
  1C89:  2B            DEC HL                        
  1C8A:  12            DB 0x12                       
  1C8B:  13            INC DE                        
  1C8C:  12            DB 0x12                       
  1C8D:  13            INC DE                        
  1C8E:  12            DB 0x12                       
  1C8F:  C9            RET                           
RST3_DISPLAY:
  1C90:  7C            LD A,H                        
  1C91:  92            DB 0x92                       
  1C92:  C0            RET NZ                        
  1C93:  7D            LD A,L                        
  1C94:  93            DB 0x93                       
  1C95:  C9            RET                           
RST1_DISPLAY:
  1C96:  7E            LD A,(HL)                     
  1C97:  E3            EX (SP),HL                    
  1C98:  BE            DB 0xBE                       
  1C99:  23            INC HL                        
  1C9A:  E3            EX (SP),HL                    
  1C9B:  CA 78 1D      JP Z,RST2_DISPLAY             
  1C9E:  C3 97 19      JP 0x1997                     
  1CA1:  3E 64         LD A,0x64                     
  1CA3:  32 DC 40      LD (0x40DC),A                   ; → RAM sistema
  1CA6:  CD 21 1F      CALL 0x1F21                   
  1CA9:  E3            EX (SP),HL                    
  1CAA:  CD 36 19      CALL 0x1936                   
  1CAD:  D1            POP DE                        
  1CAE:  20 05         JR NZ,0x1CB5                    ; -> 0x1CB5
  1CB0:  09            ADD HL,BC                     
  1CB1:  F9            LD SP,HL                      
  1CB2:  22 E8 40      LD (0x40E8),HL                
  1CB5:  EB            EX DE,HL                      
  1CB6:  0E 08         LD C,0x08                     
  1CB8:  CD 63 19      CALL 0x1963                   
  1CBB:  E5            PUSH HL                       
  1CBC:  CD 05 1F      CALL 0x1F05                   
  1CBF:  E3            EX (SP),HL                    
  1CC0:  E5            PUSH HL                       
  1CC1:  2A A2 40      LD HL,(0x40A2)                
  1CC4:  E3            EX (SP),HL                    
  1CC5:  CF            RST 08h                       
  1CC6:  BD            CP L                          
  1CC7:  E7            RST 20h                       
  1CC8:  CA F6 0A      JP Z,0x0AF6                   
  1CCB:  D2 F6 0A      JP NC,0x0AF6                  
  1CCE:  F5            PUSH AF                       
  1CCF:  CD 37 23      CALL BASIC_ARITH              
  1CD2:  F1            POP AF                        
  1CD3:  E5            PUSH HL                       
  1CD4:  F2 EC 1C      JP P,0x1CEC                   
  1CD7:  CD 7F 0A      CALL 0x0A7F                   
  1CDA:  E3            EX (SP),HL                    
  1CDB:  11 01 00      LD DE,0x0001                  
  1CDE:  7E            LD A,(HL)                     
  1CDF:  FE CC         CP 0xCC                       
  1CE1:  CC 01 2B      CALL Z,0x2B01                 
  1CE4:  D5            PUSH DE                       
  1CE5:  E5            PUSH HL                       
  1CE6:  EB            EX DE,HL                      
  1CE7:  CD 9E 09      CALL 0x099E                   
  1CEA:  18 22         JR 0x1D0E                       ; -> 0x1D0E
  1CEC:  CD B1 0A      CALL 0x0AB1                   
  1CEF:  CD BF 09      CALL 0x09BF                   
  1CF2:  E1            POP HL                        
  1CF3:  C5            PUSH BC                       
  1CF4:  D5            PUSH DE                       
  1CF5:  01 00 81      LD BC,0x8100                  
  1CF8:  51            LD D,C                        
  1CF9:  5A            LD E,D                        
  1CFA:  7E            LD A,(HL)                     
  1CFB:  FE CC         CP 0xCC                       
  1CFD:  3E 01         LD A,0x01                     
  1CFF:  20 0E         JR NZ,0x1D0F                    ; -> 0x1D0F
  1D01:  CD 38 23      CALL 0x2338                   
  1D04:  E5            PUSH HL                       
  1D05:  CD B1 0A      CALL 0x0AB1                   
  1D08:  CD BF 09      CALL 0x09BF                   
  1D0B:  CD 55 09      CALL BASIC_EVAL_TOKEN         
  1D0E:  E1            POP HL                        
  1D0F:  C5            PUSH BC                       
  1D10:  D5            PUSH DE                       
  1D11:  4F            LD C,A                        
  1D12:  E7            RST 20h                       
  1D13:  47            LD B,A                        
  1D14:  C5            PUSH BC                       
  1D15:  E5            PUSH HL                       
  1D16:  2A DF 40      LD HL,(ptr_program)           
  1D19:  E3            EX (SP),HL                    
  1D1A:  06 81         LD B,0x81                     
  1D1C:  C5            PUSH BC                       
  1D1D:  33            INC SP                        
  1D1E:  CD 58 03      CALL 0x0358                   
  1D21:  B7            OR A                          
  1D22:  C4 A0 1D      CALL NZ,0x1DA0                
  1D25:  22 E6 40      LD (0x40E6),HL                
  1D28:  ED 73 E8 40   LD (0x40E8),SP                
  1D2C:  7E            LD A,(HL)                     
  1D2D:  FE 3A         CP 0x3A                       
  1D2F:  28 29         JR Z,0x1D5A                     ; -> 0x1D5A
  1D31:  B7            OR A                          
  1D32:  C2 97 19      JP NZ,0x1997                  
  1D35:  23            INC HL                        
  1D36:  7E            LD A,(HL)                     
  1D37:  23            INC HL                        
  1D38:  B6            DB 0xB6                       
  1D39:  CA 7E 19      JP Z,0x197E                   
  1D3C:  23            INC HL                        
  1D3D:  5E            DB 0x5E                         ; '^'
  1D3E:  23            INC HL                        
  1D3F:  56            DB 0x56                         ; 'V'
  1D40:  EB            EX DE,HL                      
  1D41:  22 A2 40      LD (0x40A2),HL                
  1D44:  3A 1B 41      LD A,(0x411B)                 
  1D47:  B7            OR A                          
  1D48:  28 0F         JR Z,0x1D59                     ; -> 0x1D59
  1D4A:  D5            PUSH DE                       
  1D4B:  3E 3C         LD A,0x3C                     
  1D4D:  CD 2A 03      CALL DISPLAY_CHAR             
  1D50:  CD AF 0F      CALL 0x0FAF                   
  1D53:  3E 3E         LD A,0x3E                     
  1D55:  CD 2A 03      CALL DISPLAY_CHAR             
  1D58:  D1            POP DE                        
  1D59:  EB            EX DE,HL                      
  1D5A:  D7            RST 10h                       
  1D5B:  11 1E 1D      LD DE,0x1D1E                  
  1D5E:  D5            PUSH DE                       
  1D5F:  C8            RET Z                         
  1D60:  D6 80         SUB 0x80                      
  1D62:  DA 21 1F      JP C,0x1F21                   
  1D65:  FE 3C         CP 0x3C                       
  1D67:  D2 E7 2A      JP NC,0x2AE7                  
  1D6A:  07            RLCA                          
  1D6B:  4F            LD C,A                        
  1D6C:  06 00         LD B,0x00                     
  1D6E:  EB            EX DE,HL                      
  1D6F:  21 22 18      LD HL,0x1822                  
  1D72:  09            ADD HL,BC                     
  1D73:  4E            DB 0x4E                         ; 'N'
  1D74:  23            INC HL                        
  1D75:  46            DB 0x46                         ; 'F'
  1D76:  C5            PUSH BC                       
  1D77:  EB            EX DE,HL                      
RST2_DISPLAY:
  1D78:  23            INC HL                        
  1D79:  7E            LD A,(HL)                     
  1D7A:  FE 3A         CP 0x3A                       
  1D7C:  D0            RET NC                        
  1D7D:  FE 20         CP 0x20                       
  1D7F:  CA 78 1D      JP Z,RST2_DISPLAY             
  1D82:  FE 0B         CP 0x0B                       
  1D84:  30 05         JR NC,0x1D8B                    ; -> 0x1D8B
  1D86:  FE 09         CP 0x09                       
  1D88:  D2 78 1D      JP NC,RST2_DISPLAY            
  1D8B:  FE 30         CP 0x30                       
  1D8D:  3F            CCF                           
  1D8E:  3C            INC A                         
  1D8F:  3D            DEC A                         
  1D90:  C9            RET                           
  1D91:  EB            EX DE,HL                      
  1D92:  2A A4 40      LD HL,(0x40A4)                
  1D95:  2B            DEC HL                        
  1D96:  22 FF 40      LD (0x40FF),HL                
  1D99:  EB            EX DE,HL                      
  1D9A:  C9            RET                           
  1D9B:  CD 58 03      CALL 0x0358                   
  1D9E:  B7            OR A                          
  1D9F:  C8            RET Z                         
  1DA0:  FE 60         CP 0x60                       
  1DA2:  CC 84 03      CALL Z,0x0384                 
  1DA5:  32 99 40      LD (0x4099),A                   ; → RAM sistema
  1DA8:  3D            DEC A                         
  1DA9:  C0            RET NZ                        
  1DAA:  3C            INC A                         
  1DAB:  C3 B4 1D      JP 0x1DB4                     
  1DAE:  C0            RET NZ                        
  1DAF:  F5            PUSH AF                       
  1DB0:  CC BB 41      CALL Z,0x41BB                 
  1DB3:  F1            POP AF                        
  1DB4:  22 E6 40      LD (0x40E6),HL                
  1DB7:  21 B5 40      LD HL,0x40B5                    ; ← RAM sistema
  1DBA:  22 B3 40      LD (0x40B3),HL                
  1DBD:  21 F6 FF      LD HL,0xFFF6                  
  1DC0:  C1            POP BC                        
  1DC1:  2A A2 40      LD HL,(0x40A2)                
  1DC4:  E5            PUSH HL                       
  1DC5:  F5            PUSH AF                       
  1DC6:  7D            LD A,L                        
  1DC7:  A4            AND H                         
  1DC8:  3C            INC A                         
  1DC9:  28 09         JR Z,0x1DD4                     ; -> 0x1DD4
  1DCB:  22 F5 40      LD (0x40F5),HL                
  1DCE:  2A E6 40      LD HL,(0x40E6)                
  1DD1:  22 F7 40      LD (0x40F7),HL                
  1DD4:  CD 8B 03      CALL 0x038B                   
  1DD7:  CD F9 20      CALL 0x20F9                   
  1DDA:  F1            POP AF                        
  1DDB:  21 30 19      LD HL,0x1930                  
  1DDE:  C2 06 1A      JP NZ,0x1A06                  
  1DE1:  C3 18 1A      JP 0x1A18                     
  1DE4:  2A F7 40      LD HL,(0x40F7)                
  1DE7:  7C            LD A,H                        
  1DE8:  B5            OR L                          
  1DE9:  1E 20         LD E,0x20                     
  1DEB:  CA A2 19      JP Z,0x19A2                   
  1DEE:  EB            EX DE,HL                      
  1DEF:  2A F5 40      LD HL,(0x40F5)                
  1DF2:  22 A2 40      LD (0x40A2),HL                
  1DF5:  EB            EX DE,HL                      
  1DF6:  C9            RET                           
  1DF7:  3E AF         LD A,0xAF                     
  1DF9:  32 1B 41      LD (0x411B),A                   ; → RAM sistema
  1DFC:  C9            RET                           
  1DFD:  F1            POP AF                        
  1DFE:  E1            POP HL                        
  1DFF:  C9            RET                           
  1E00:  1E 03         LD E,0x03                     
  1E02:  01 1E 02      LD BC,0x021E                  
  1E05:  01 1E 04      LD BC,0x041E                  
  1E08:  01 1E 08      LD BC,0x081E                  
  1E0B:  CD 3D 1E      CALL 0x1E3D                   
  1E0E:  01 97 19      LD BC,0x1997                  
  1E11:  C5            PUSH BC                       
  1E12:  D8            RET C                         
  1E13:  D6 41         SUB 0x41                      
  1E15:  4F            LD C,A                        
  1E16:  47            LD B,A                        
  1E17:  D7            RST 10h                       
  1E18:  FE CE         CP 0xCE                       
  1E1A:  20 09         JR NZ,0x1E25                    ; -> 0x1E25
  1E1C:  D7            RST 10h                       
  1E1D:  CD 3D 1E      CALL 0x1E3D                   
  1E20:  D8            RET C                         
  1E21:  D6 41         SUB 0x41                      
  1E23:  47            LD B,A                        
  1E24:  D7            RST 10h                       
  1E25:  78            LD A,B                        
  1E26:  91            DB 0x91                       
  1E27:  D8            RET C                         
  1E28:  3C            INC A                         
  1E29:  E3            EX (SP),HL                    
  1E2A:  21 01 41      LD HL,0x4101                    ; ← RAM sistema
  1E2D:  06 00         LD B,0x00                     
  1E2F:  09            ADD HL,BC                     
  1E30:  73            LD (HL),E                     
  1E31:  23            INC HL                        
  1E32:  3D            DEC A                         
  1E33:  20 FB         JR NZ,0x1E30                    ; -> 0x1E30
  1E35:  E1            POP HL                        
  1E36:  7E            LD A,(HL)                     
  1E37:  FE 2C         CP 0x2C                       
  1E39:  C0            RET NZ                        
  1E3A:  D7            RST 10h                       
  1E3B:  18 CE         JR 0x1E0B                       ; -> 0x1E0B
  1E3D:  7E            LD A,(HL)                     
  1E3E:  FE 41         CP 0x41                       
  1E40:  D8            RET C                         
  1E41:  FE 5B         CP 0x5B                       
  1E43:  3F            CCF                           
  1E44:  C9            RET                           
  1E45:  D7            RST 10h                       
  1E46:  CD 02 2B      CALL 0x2B02                   
  1E49:  F0            RET P                         
  1E4A:  1E 08         LD E,0x08                     
  1E4C:  C3 A2 19      JP 0x19A2                     
  1E4F:  7E            LD A,(HL)                     
  1E50:  FE 2E         CP 0x2E                       
  1E52:  EB            EX DE,HL                      
  1E53:  2A EC 40      LD HL,(0x40EC)                
  1E56:  EB            EX DE,HL                      
  1E57:  CA 78 1D      JP Z,RST2_DISPLAY             
  1E5A:  2B            DEC HL                        
  1E5B:  11 00 00      LD DE,0x0000                  
  1E5E:  D7            RST 10h                       
  1E5F:  D0            RET NC                        
  1E60:  E5            PUSH HL                       
  1E61:  F5            PUSH AF                       
  1E62:  21 98 19      LD HL,0x1998                  
  1E65:  DF            RST 18h                       
  1E66:  DA 97 19      JP C,0x1997                   
  1E69:  62            LD H,D                        
  1E6A:  6B            LD L,E                        
  1E6B:  19            ADD HL,DE                     
  1E6C:  29            ADD HL,HL                     
  1E6D:  19            ADD HL,DE                     
  1E6E:  29            ADD HL,HL                     
  1E6F:  F1            POP AF                        
  1E70:  D6 30         SUB 0x30                      
  1E72:  5F            LD E,A                        
  1E73:  16 00         LD D,0x00                     
  1E75:  19            ADD HL,DE                     
  1E76:  EB            EX DE,HL                      
  1E77:  E1            POP HL                        
  1E78:  18 E4         JR 0x1E5E                       ; -> 0x1E5E
  1E7A:  CA 61 1B      JP Z,0x1B61                   
  1E7D:  CD 46 1E      CALL 0x1E46                   
  1E80:  2B            DEC HL                        
  1E81:  D7            RST 10h                       
  1E82:  C0            RET NZ                        
  1E83:  E5            PUSH HL                       
  1E84:  2A B1 40      LD HL,(ptr_mem_high)          
  1E87:  7D            LD A,L                        
  1E88:  93            DB 0x93                       
  1E89:  5F            LD E,A                        
  1E8A:  7C            LD A,H                        
  1E8B:  9A            DB 0x9A                       
  1E8C:  57            LD D,A                        
  1E8D:  DA 7A 19      JP C,0x197A                   
  1E90:  2A F9 40      LD HL,(0x40F9)                
  1E93:  01 28 00      LD BC,0x0028                  
  1E96:  09            ADD HL,BC                     
  1E97:  DF            RST 18h                       
  1E98:  D2 7A 19      JP NC,0x197A                  
  1E9B:  EB            EX DE,HL                      
  1E9C:  22 A0 40      LD (0x40A0),HL                
  1E9F:  E1            POP HL                        
  1EA0:  C3 61 1B      JP 0x1B61                     
  1EA3:  CA 5D 1B      JP Z,0x1B5D                   
  1EA6:  CD C7 41      CALL 0x41C7                   
  1EA9:  CD 61 1B      CALL 0x1B61                   
  1EAC:  01 1E 1D      LD BC,0x1D1E                  
  1EAF:  18 10         JR 0x1EC1                       ; -> 0x1EC1
  1EB1:  0E 03         LD C,0x03                     
  1EB3:  CD 63 19      CALL 0x1963                   
  1EB6:  C1            POP BC                        
  1EB7:  E5            PUSH HL                       
  1EB8:  E5            PUSH HL                       
  1EB9:  2A A2 40      LD HL,(0x40A2)                
  1EBC:  E3            EX (SP),HL                    
  1EBD:  3E 91         LD A,0x91                     
  1EBF:  F5            PUSH AF                       
  1EC0:  33            INC SP                        
  1EC1:  C5            PUSH BC                       
  1EC2:  CD 5A 1E      CALL 0x1E5A                   
  1EC5:  CD 07 1F      CALL 0x1F07                   
  1EC8:  E5            PUSH HL                       
  1EC9:  2A A2 40      LD HL,(0x40A2)                
  1ECC:  DF            RST 18h                       
  1ECD:  E1            POP HL                        
  1ECE:  23            INC HL                        
  1ECF:  DC 2F 1B      CALL C,0x1B2F                 
  1ED2:  D4 2C 1B      CALL NC,0x1B2C                
  1ED5:  60            LD H,B                        
  1ED6:  69            LD L,C                        
  1ED7:  2B            DEC HL                        
  1ED8:  D8            RET C                         
  1ED9:  1E 0E         LD E,0x0E                     
  1EDB:  C3 A2 19      JP 0x19A2                     
  1EDE:  C0            RET NZ                        
  1EDF:  16 FF         LD D,0xFF                     
  1EE1:  CD 36 19      CALL 0x1936                   
  1EE4:  F9            LD SP,HL                      
  1EE5:  22 E8 40      LD (0x40E8),HL                
  1EE8:  FE 91         CP 0x91                       
  1EEA:  1E 04         LD E,0x04                     
  1EEC:  C2 A2 19      JP NZ,0x19A2                  
  1EEF:  E1            POP HL                        
  1EF0:  22 A2 40      LD (0x40A2),HL                
  1EF3:  23            INC HL                        
  1EF4:  7C            LD A,H                        
  1EF5:  B5            OR L                          
  1EF6:  20 07         JR NZ,0x1EFF                    ; -> 0x1EFF
  1EF8:  3A DD 40      LD A,(0x40DD)                 
  1EFB:  B7            OR A                          
  1EFC:  C2 18 1A      JP NZ,0x1A18                  
  1EFF:  21 1E 1D      LD HL,0x1D1E                  
  1F02:  E3            EX (SP),HL                    
  1F03:  3E E1         LD A,0xE1                     
  1F05:  01 3A 0E      LD BC,0x0E3A                  
  1F08:  00            NOP                           
  1F09:  06 00         LD B,0x00                     
  1F0B:  79            LD A,C                        
  1F0C:  48            LD C,B                        
  1F0D:  47            LD B,A                        
  1F0E:  7E            LD A,(HL)                     
  1F0F:  B7            OR A                          
  1F10:  C8            RET Z                         
  1F11:  B8            CP B                          
  1F12:  C8            RET Z                         
  1F13:  23            INC HL                        
  1F14:  FE 22         CP 0x22                       
  1F16:  28 F3         JR Z,0x1F0B                     ; -> 0x1F0B
  1F18:  D6 8F         SUB 0x8F                      
  1F1A:  20 F2         JR NZ,0x1F0E                    ; -> 0x1F0E
  1F1C:  B8            CP B                          
  1F1D:  8A            DB 0x8A                       
  1F1E:  57            LD D,A                        
  1F1F:  18 ED         JR 0x1F0E                       ; -> 0x1F0E
  1F21:  CD 0D 26      CALL 0x260D                   
  1F24:  CF            RST 08h                       
  1F25:  D5            PUSH DE                       
  1F26:  EB            EX DE,HL                      
  1F27:  22 DF 40      LD (ptr_program),HL           
  1F2A:  EB            EX DE,HL                      
  1F2B:  D5            PUSH DE                       
  1F2C:  E7            RST 20h                       
  1F2D:  F5            PUSH AF                       
  1F2E:  CD 37 23      CALL BASIC_ARITH              
  1F31:  F1            POP AF                        
  1F32:  E3            EX (SP),HL                    
  1F33:  C6 03         ADD A,0x03                    
  1F35:  CD 19 28      CALL 0x2819                   
  1F38:  CD 03 0A      CALL 0x0A03                   
  1F3B:  E5            PUSH HL                       
  1F3C:  20 28         JR NZ,0x1F66                    ; -> 0x1F66
  1F3E:  2A 21 41      LD HL,(0x4121)                
  1F41:  E5            PUSH HL                       
  1F42:  23            INC HL                        
  1F43:  5E            DB 0x5E                         ; '^'
  1F44:  23            INC HL                        
  1F45:  56            DB 0x56                         ; 'V'
  1F46:  2A A4 40      LD HL,(0x40A4)                
  1F49:  DF            RST 18h                       
  1F4A:  30 0E         JR NC,0x1F5A                    ; -> 0x1F5A
  1F4C:  2A A0 40      LD HL,(0x40A0)                
  1F4F:  DF            RST 18h                       
  1F50:  D1            POP DE                        
  1F51:  30 0F         JR NC,0x1F62                    ; -> 0x1F62
  1F53:  2A F9 40      LD HL,(0x40F9)                
  1F56:  DF            RST 18h                       
  1F57:  30 09         JR NC,0x1F62                    ; -> 0x1F62
  1F59:  3E D1         LD A,0xD1                     
  1F5B:  CD F5 29      CALL 0x29F5                   
  1F5E:  EB            EX DE,HL                      
  1F5F:  CD 43 28      CALL 0x2843                   
  1F62:  CD F5 29      CALL 0x29F5                   
  1F65:  E3            EX (SP),HL                    
  1F66:  CD D3 09      CALL 0x09D3                   
  1F69:  D1            POP DE                        
  1F6A:  E1            POP HL                        
  1F6B:  C9            RET                           
  1F6C:  FE 9E         CP 0x9E                       
  1F6E:  20 25         JR NZ,0x1F95                    ; -> 0x1F95
  1F70:  D7            RST 10h                       
  1F71:  CF            RST 08h                       
  1F72:  8D            DB 0x8D                       
  1F73:  CD 5A 1E      CALL 0x1E5A                   
  1F76:  7A            LD A,D                        
  1F77:  B3            OR E                          
  1F78:  28 09         JR Z,0x1F83                     ; -> 0x1F83
  1F7A:  CD 2A 1B      CALL 0x1B2A                   
  1F7D:  50            LD D,B                        
  1F7E:  59            LD E,C                        
  1F7F:  E1            POP HL                        
  1F80:  D2 D9 1E      JP NC,0x1ED9                  
  1F83:  EB            EX DE,HL                      
  1F84:  22 F0 40      LD (0x40F0),HL                
  1F87:  EB            EX DE,HL                      
  1F88:  D8            RET C                         
  1F89:  3A F2 40      LD A,(0x40F2)                 
  1F8C:  B7            OR A                          
  1F8D:  C8            RET Z                         
  1F8E:  3A 9A 40      LD A,(0x409A)                 
  1F91:  5F            LD E,A                        
  1F92:  C3 AB 19      JP 0x19AB                     
  1F95:  CD 1C 2B      CALL 0x2B1C                   
  1F98:  7E            LD A,(HL)                     
  1F99:  47            LD B,A                        
  1F9A:  FE 91         CP 0x91                       
  1F9C:  28 03         JR Z,0x1FA1                     ; -> 0x1FA1
  1F9E:  CF            RST 08h                       
  1F9F:  8D            DB 0x8D                       
  1FA0:  2B            DEC HL                        
  1FA1:  4B            LD C,E                        
  1FA2:  0D            DEC C                         
  1FA3:  78            LD A,B                        
  1FA4:  CA 60 1D      JP Z,0x1D60                   
  1FA7:  CD 5B 1E      CALL 0x1E5B                   
  1FAA:  FE 2C         CP 0x2C                       
  1FAC:  C0            RET NZ                        
  1FAD:  18 F3         JR 0x1FA2                       ; -> 0x1FA2
  1FAF:  11 F2 40      LD DE,0x40F2                    ; ← RAM sistema
  1FB2:  1A            DB 0x1A                       
  1FB3:  B7            OR A                          
  1FB4:  CA A0 19      JP Z,0x19A0                   
  1FB7:  3C            INC A                         
  1FB8:  32 9A 40      LD (0x409A),A                   ; → RAM sistema
  1FBB:  12            DB 0x12                       
  1FBC:  7E            LD A,(HL)                     
  1FBD:  FE 87         CP 0x87                       
  1FBF:  28 0C         JR Z,0x1FCD                     ; -> 0x1FCD
  1FC1:  CD 5A 1E      CALL 0x1E5A                   
  1FC4:  C0            RET NZ                        
  1FC5:  7A            LD A,D                        
  1FC6:  B3            OR E                          
  1FC7:  C2 C5 1E      JP NZ,0x1EC5                  
  1FCA:  3C            INC A                         
  1FCB:  18 02         JR 0x1FCF                       ; -> 0x1FCF
  1FCD:  D7            RST 10h                       
  1FCE:  C0            RET NZ                        
  1FCF:  2A EE 40      LD HL,(0x40EE)                
  1FD2:  EB            EX DE,HL                      
  1FD3:  2A EA 40      LD HL,(0x40EA)                
  1FD6:  22 A2 40      LD (0x40A2),HL                
  1FD9:  EB            EX DE,HL                      
  1FDA:  C0            RET NZ                        
  1FDB:  7E            LD A,(HL)                     
  1FDC:  B7            OR A                          
  1FDD:  20 04         JR NZ,0x1FE3                    ; -> 0x1FE3
  1FDF:  23            INC HL                        
  1FE0:  23            INC HL                        
  1FE1:  23            INC HL                        
  1FE2:  23            INC HL                        
  1FE3:  23            INC HL                        
  1FE4:  7A            LD A,D                        
  1FE5:  A3            AND E                         
  1FE6:  3C            INC A                         
  1FE7:  C2 05 1F      JP NZ,0x1F05                  
  1FEA:  3A DD 40      LD A,(0x40DD)                 
  1FED:  3D            DEC A                         
  1FEE:  CA BE 1D      JP Z,0x1DBE                   
  1FF1:  C3 05 1F      JP 0x1F05                     
  1FF4:  CD 1C 2B      CALL 0x2B1C                   
  1FF7:  C0            RET NZ                        
  1FF8:  B7            OR A                          
  1FF9:  CA 4A 1E      JP Z,0x1E4A                   
  1FFC:  3D            DEC A                         
  1FFD:  87            ADD A,A                       
  1FFE:  5F            LD E,A                        
  1FFF:  FE 2D         CP 0x2D                       
  2001:  38 02         JR C,0x2005                     ; -> 0x2005
  2003:  1E 26         LD E,0x26                     
  2005:  C3 A2 19      JP 0x19A2                     
  2008:  11 0A 00      LD DE,0x000A                  
  200B:  D5            PUSH DE                       
  200C:  28 17         JR Z,0x2025                     ; -> 0x2025
  200E:  CD 4F 1E      CALL 0x1E4F                   
  2011:  EB            EX DE,HL                      
  2012:  E3            EX (SP),HL                    
  2013:  28 11         JR Z,0x2026                     ; -> 0x2026
  2015:  EB            EX DE,HL                      
  2016:  CF            RST 08h                       
  2017:  2C            INC L                         
  2018:  EB            EX DE,HL                      
  2019:  2A E4 40      LD HL,(0x40E4)                
  201C:  EB            EX DE,HL                      
  201D:  28 06         JR Z,0x2025                     ; -> 0x2025
  201F:  CD 5A 1E      CALL 0x1E5A                   
  2022:  C2 97 19      JP NZ,0x1997                  
  2025:  EB            EX DE,HL                      
  2026:  7C            LD A,H                        
  2027:  B5            OR L                          
  2028:  CA 4A 1E      JP Z,0x1E4A                   
  202B:  22 E4 40      LD (0x40E4),HL                
  202E:  32 E1 40      LD (0x40E1),A                   ; → RAM sistema
  2031:  E1            POP HL                        
  2032:  22 E2 40      LD (0x40E2),HL                
  2035:  C1            POP BC                        
  2036:  C3 33 1A      JP 0x1A33                     
  2039:  CD 37 23      CALL BASIC_ARITH              
  203C:  7E            LD A,(HL)                     
  203D:  FE 2C         CP 0x2C                       
  203F:  CC 78 1D      CALL Z,RST2_DISPLAY           
  2042:  FE CA         CP 0xCA                       
  2044:  CC 78 1D      CALL Z,RST2_DISPLAY           
  2047:  2B            DEC HL                        
  2048:  E5            PUSH HL                       
  2049:  CD 94 09      CALL 0x0994                   
  204C:  E1            POP HL                        
  204D:  28 07         JR Z,0x2056                     ; -> 0x2056
  204F:  D7            RST 10h                       
  2050:  DA C2 1E      JP C,0x1EC2                   
  2053:  C3 5F 1D      JP 0x1D5F                     
  2056:  16 01         LD D,0x01                     
  2058:  CD 05 1F      CALL 0x1F05                   
  205B:  B7            OR A                          
  205C:  C8            RET Z                         
  205D:  D7            RST 10h                       
  205E:  FE 95         CP 0x95                       
  2060:  20 F6         JR NZ,0x2058                    ; -> 0x2058
  2062:  15            DEC D                         
  2063:  20 F3         JR NZ,0x2058                    ; -> 0x2058
  2065:  18 E8         JR 0x204F                       ; -> 0x204F
  2067:  3E 01         LD A,0x01                     
  2069:  32 9C 40      LD (0x409C),A                   ; → RAM sistema
  206C:  C3 7C 20      JP 0x207C                     
  206F:  CD CA 41      CALL 0x41CA                   
  2072:  FE 23         CP 0x23                       
  2074:  20 06         JR NZ,0x207C                    ; -> 0x207C
  2076:  CD B3 35      CALL 0x35B3                   
  2079:  32 9C 40      LD (0x409C),A                   ; → RAM sistema
  207C:  2B            DEC HL                        
  207D:  D7            RST 10h                       
  207E:  CC FE 20      CALL Z,BASIC_PROMPT_LOOP      
  2081:  CA 69 21      JP Z,0x2169                   
  2084:  F6 20         OR 0x20                       
  2086:  FE 60         CP 0x60                       
  2088:  20 1B         JR NZ,0x20A5                    ; -> 0x20A5
  208A:  CD 01 2B      CALL 0x2B01                   
  208D:  FE 04         CP 0x04                       
  208F:  D2 4A 1E      JP NC,0x1E4A                  
  2092:  E5            PUSH HL                       
  2093:  21 00 3C      LD HL,VRAM_BASE                 ; ← VRAM
  2096:  19            ADD HL,DE                     
  2097:  22 20 40      LD (0x4020),HL                
  209A:  7B            LD A,E                        
  209B:  E6 3F         AND 0x3F                      
  209D:  32 A6 40      LD (sys_ctrl_main),A            ; → RAM sistema
  20A0:  E1            POP HL                        
  20A1:  CF            RST 08h                       
  20A2:  2C            INC L                         
  20A3:  18 C7         JR 0x206C                       ; -> 0x206C
  20A5:  7E            LD A,(HL)                     
  20A6:  FE BF         CP 0xBF                       
  20A8:  CA BD 2C      JP Z,0x2CBD                   
  20AB:  FE BC         CP 0xBC                       
  20AD:  CA 37 21      JP Z,0x2137                   
  20B0:  E5            PUSH HL                       
  20B1:  FE 2C         CP 0x2C                       
  20B3:  28 53         JR Z,0x2108                     ; -> 0x2108
  20B5:  FE 3B         CP 0x3B                       
  20B7:  28 5E         JR Z,0x2117                     ; -> 0x2117
  20B9:  CD 37 23      CALL BASIC_ARITH              
  20BC:  E3            EX (SP),HL                    
  20BD:  E7            RST 20h                       
  20BE:  28 32         JR Z,0x20F2                     ; -> 0x20F2
  20C0:  CD BD 0F      CALL 0x0FBD                   
  20C3:  CD 65 28      CALL 0x2865                   
  20C6:  CD CD 41      CALL 0x41CD                   
  20C9:  2A 21 41      LD HL,(0x4121)                
  20CC:  3A 9C 40      LD A,(0x409C)                 
  20CF:  B7            OR A                          
  20D0:  FA E9 20      JP M,0x20E9                   
  20D3:  28 08         JR Z,0x20DD                     ; -> 0x20DD
  20D5:  3A 9B 40      LD A,(0x409B)                 
  20D8:  86            DB 0x86                       
  20D9:  FE 84         CP 0x84                       
  20DB:  18 09         JR 0x20E6                       ; -> 0x20E6
  20DD:  3A 9D 40      LD A,(0x409D)                 
  20E0:  47            LD B,A                        
  20E1:  3A A6 40      LD A,(sys_ctrl_main)          
  20E4:  86            DB 0x86                       
  20E5:  B8            CP B                          
  20E6:  D4 FE 20      CALL NC,BASIC_PROMPT_LOOP     
  20E9:  CD AA 28      CALL 0x28AA                   
  20EC:  3E 20         LD A,0x20                     
  20EE:  CD 2A 03      CALL DISPLAY_CHAR             
  20F1:  B7            OR A                          
  20F2:  CC AA 28      CALL Z,0x28AA                 
  20F5:  E1            POP HL                        
  20F6:  C3 7C 20      JP 0x207C                     
  20F9:  3A A6 40      LD A,(sys_ctrl_main)          
  20FC:  B7            OR A                          
  20FD:  C8            RET Z                         
BASIC_PROMPT_LOOP:
  20FE:  3E 0D         LD A,0x0D                     
  2100:  CD CF 35      CALL 0x35CF                   
  2103:  CD D0 41      CALL 0x41D0                   
  2106:  AF            XOR A                         
  2107:  C9            RET                           
  2108:  CD D3 41      CALL 0x41D3                   
  210B:  3A 9C 40      LD A,(0x409C)                 
  210E:  B7            OR A                          
  210F:  F2 19 21      JP P,0x2119                   
  2112:  3E 2C         LD A,0x2C                     
  2114:  CD 2A 03      CALL DISPLAY_CHAR             
  2117:  18 4B         JR 0x2164                       ; -> 0x2164
  2119:  28 08         JR Z,0x2123                     ; -> 0x2123
  211B:  3A 9B 40      LD A,(0x409B)                 
  211E:  FE 70         CP 0x70                       
  2120:  C3 2B 21      JP 0x212B                     
  2123:  3A 9E 40      LD A,(0x409E)                 
  2126:  47            LD B,A                        
  2127:  3A A6 40      LD A,(sys_ctrl_main)          
  212A:  B8            CP B                          
  212B:  D4 FE 20      CALL NC,BASIC_PROMPT_LOOP     
  212E:  30 34         JR NC,0x2164                    ; -> 0x2164
  2130:  D6 10         SUB 0x10                      
  2132:  30 FC         JR NC,0x2130                    ; -> 0x2130
  2134:  2F            CPL                           
  2135:  18 23         JR 0x215A                       ; -> 0x215A
  2137:  CD 1B 2B      CALL 0x2B1B                   
  213A:  E6 7F         AND 0x7F                      
  213C:  5F            LD E,A                        
  213D:  CF            RST 08h                       
  213E:  29            ADD HL,HL                     
  213F:  2B            DEC HL                        
  2140:  E5            PUSH HL                       
  2141:  CD D3 41      CALL 0x41D3                   
  2144:  3A 9C 40      LD A,(0x409C)                 
  2147:  B7            OR A                          
  2148:  FA 4A 1E      JP M,0x1E4A                   
  214B:  CA 53 21      JP Z,0x2153                   
  214E:  3A 9B 40      LD A,(0x409B)                 
  2151:  18 03         JR 0x2156                       ; -> 0x2156
  2153:  3A A6 40      LD A,(sys_ctrl_main)          
  2156:  2F            CPL                           
  2157:  83            ADD A,E                       
  2158:  30 0A         JR NC,0x2164                    ; -> 0x2164
  215A:  3C            INC A                         
  215B:  47            LD B,A                        
  215C:  3E 20         LD A,0x20                     
  215E:  CD 2A 03      CALL DISPLAY_CHAR             
  2161:  05            DEC B                         
  2162:  20 FA         JR NZ,0x215E                    ; -> 0x215E
  2164:  E1            POP HL                        
  2165:  D7            RST 10h                       
  2166:  C3 81 20      JP 0x2081                     
  2169:  3A 9C 40      LD A,(0x409C)                 
  216C:  B7            OR A                          
  216D:  CD F8 01      CALL 0x01F8                   
  2170:  AF            XOR A                         
  2171:  32 9C 40      LD (0x409C),A                   ; → RAM sistema
  2174:  CD BE 41      CALL 0x41BE                   
  2177:  C9            RET                           
STR_REDO:
  2178:  3F            CCF                           
  2179:  52            LD D,D                        
  217A:  45            LD B,L                        
  217B:  44            LD B,H                        
  217C:  4F            LD C,A                        
  217D:  0D            DEC C                         
  217E:  00            NOP                           
  217F:  3A DE 40      LD A,(0x40DE)                 
  2182:  B7            OR A                          
  2183:  C2 91 19      JP NZ,0x1991                  
  2186:  3A A9 40      LD A,(0x40A9)                 
  2189:  B7            OR A                          
  218A:  1E 2A         LD E,0x2A                     
  218C:  CA A2 19      JP Z,0x19A2                   
  218F:  C1            POP BC                        
  2190:  21 78 21      LD HL,0x2178                  
  2193:  CD A7 28      CALL PRINT_STRING             
  2196:  2A E6 40      LD HL,(0x40E6)                
  2199:  C9            RET                           
  219A:  CD 28 28      CALL 0x2828                   
  219D:  7E            LD A,(HL)                     
  219E:  CD D6 41      CALL 0x41D6                   
  21A1:  D6 23         SUB 0x23                      
  21A3:  32 A9 40      LD (0x40A9),A                   ; → RAM sistema
  21A6:  7E            LD A,(HL)                     
  21A7:  20 20         JR NZ,0x21C9                    ; -> 0x21C9
  21A9:  CD 93 02      CALL 0x0293                   
  21AC:  E5            PUSH HL                       
  21AD:  06 FA         LD B,0xFA                     
  21AF:  2A A7 40      LD HL,(0x40A7)                
  21B2:  CD 35 02      CALL SERIAL_SEND_8BITS        
  21B5:  77            LD (HL),A                     
  21B6:  23            INC HL                        
  21B7:  FE 0D         CP 0x0D                       
  21B9:  28 02         JR Z,0x21BD                     ; -> 0x21BD
  21BB:  10 F5         DJNZ 0x21B2                     ; loop para 0x21B2
  21BD:  2B            DEC HL                        
  21BE:  36 00         LD (HL),0x00                  
  21C0:  CD F8 01      CALL 0x01F8                   
  21C3:  2A A7 40      LD HL,(0x40A7)                
  21C6:  2B            DEC HL                        
  21C7:  18 22         JR 0x21EB                       ; -> 0x21EB
  21C9:  01 DB 21      LD BC,0x21DB                  
  21CC:  C5            PUSH BC                       
  21CD:  FE 22         CP 0x22                       
  21CF:  C0            RET NZ                        
  21D0:  CD 66 28      CALL 0x2866                   
  21D3:  CF            RST 08h                       
  21D4:  3B            DEC SP                        
  21D5:  E5            PUSH HL                       
  21D6:  CD AA 28      CALL 0x28AA                   
  21D9:  E1            POP HL                        
  21DA:  C9            RET                           
  21DB:  E5            PUSH HL                       
  21DC:  CD B3 1B      CALL PROTEGER_HW_READ         
  21DF:  C1            POP BC                        
  21E0:  DA BE 1D      JP C,0x1DBE                   
  21E3:  23            INC HL                        
  21E4:  7E            LD A,(HL)                     
  21E5:  B7            OR A                          
  21E6:  2B            DEC HL                        
  21E7:  C5            PUSH BC                       
  21E8:  CA 04 1F      JP Z,0x1F04                   
  21EB:  36 2C         LD (HL),0x2C                  
  21ED:  18 05         JR 0x21F4                       ; -> 0x21F4
  21EF:  E5            PUSH HL                       
  21F0:  2A FF 40      LD HL,(0x40FF)                
  21F3:  F6 AF         OR 0xAF                       
  21F5:  32 DE 40      LD (0x40DE),A                   ; → RAM sistema
  21F8:  E3            EX (SP),HL                    
  21F9:  18 02         JR 0x21FD                       ; -> 0x21FD
  21FB:  CF            RST 08h                       
  21FC:  2C            INC L                         
  21FD:  CD 0D 26      CALL 0x260D                   
  2200:  E3            EX (SP),HL                    
  2201:  D5            PUSH DE                       
  2202:  7E            LD A,(HL)                     
  2203:  FE 2C         CP 0x2C                       
  2205:  28 26         JR Z,0x222D                     ; -> 0x222D
  2207:  3A DE 40      LD A,(0x40DE)                 
  220A:  B7            OR A                          
  220B:  C2 96 22      JP NZ,0x2296                  
  220E:  3A A9 40      LD A,(0x40A9)                 
  2211:  B7            OR A                          
  2212:  1E 06         LD E,0x06                     
  2214:  CA A2 19      JP Z,0x19A2                   
  2217:  3E 3F         LD A,0x3F                     
  2219:  CD 2A 03      CALL DISPLAY_CHAR             
  221C:  CD B3 1B      CALL PROTEGER_HW_READ         
  221F:  D1            POP DE                        
  2220:  C1            POP BC                        
  2221:  DA BE 1D      JP C,0x1DBE                   
  2224:  23            INC HL                        
  2225:  7E            LD A,(HL)                     
  2226:  B7            OR A                          
  2227:  2B            DEC HL                        
  2228:  C5            PUSH BC                       
  2229:  CA 04 1F      JP Z,0x1F04                   
  222C:  D5            PUSH DE                       
  222D:  CD DC 41      CALL 0x41DC                   
  2230:  E7            RST 20h                       
  2231:  F5            PUSH AF                       
  2232:  20 19         JR NZ,0x224D                    ; -> 0x224D
  2234:  D7            RST 10h                       
  2235:  57            LD D,A                        
  2236:  47            LD B,A                        
  2237:  FE 22         CP 0x22                       
  2239:  28 05         JR Z,0x2240                     ; -> 0x2240
  223B:  16 3A         LD D,0x3A                     
  223D:  06 2C         LD B,0x2C                     
  223F:  2B            DEC HL                        
  2240:  CD 69 28      CALL 0x2869                   
  2243:  F1            POP AF                        
  2244:  EB            EX DE,HL                      
  2245:  21 5A 22      LD HL,0x225A                  
  2248:  E3            EX (SP),HL                    
  2249:  D5            PUSH DE                       
  224A:  C3 33 1F      JP 0x1F33                     
  224D:  D7            RST 10h                       
  224E:  F1            POP AF                        
  224F:  F5            PUSH AF                       
  2250:  01 43 22      LD BC,0x2243                  
  2253:  C5            PUSH BC                       
  2254:  DA 6C 0E      JP C,0x0E6C                   
  2257:  D2 65 0E      JP NC,0x0E65                  
  225A:  2B            DEC HL                        
  225B:  D7            RST 10h                       
  225C:  28 05         JR Z,0x2263                     ; -> 0x2263
  225E:  FE 2C         CP 0x2C                       
  2260:  C2 7F 21      JP NZ,0x217F                  
  2263:  E3            EX (SP),HL                    
  2264:  2B            DEC HL                        
  2265:  D7            RST 10h                       
  2266:  C2 FB 21      JP NZ,0x21FB                  
  2269:  D1            POP DE                        
  226A:  3A DE 40      LD A,(0x40DE)                 
  226D:  B7            OR A                          
  226E:  EB            EX DE,HL                      
  226F:  C2 96 1D      JP NZ,0x1D96                  
  2272:  D5            PUSH DE                       
  2273:  CD DF 41      CALL 0x41DF                   
  2276:  B6            DB 0xB6                       
  2277:  21 81 22      LD HL,0x2281                  
  227A:  C4 A7 28      CALL NZ,PRINT_STRING          
  227D:  E1            POP HL                        
  227E:  C3 6D 21      JP 0x216D                     
  2281:  3F            CCF                           
  2282:  45            LD B,L                        
  2283:  78            LD A,B                        
  2284:  63            LD H,E                        
  2285:  65            LD H,L                        
  2286:  73            LD (HL),E                     
  2287:  73            LD (HL),E                     
  2288:  6F            LD L,A                        
  2289:  20 64         JR NZ,0x22EF                    ; -> 0x22EF
  228B:  65            LD H,L                        
  228C:  20 64         JR NZ,0x22F2                    ; -> 0x22F2
  228E:  61            LD H,C                        
  228F:  64            LD H,H                        
  2290:  6F            LD L,A                        
  2291:  73            LD (HL),E                     
  2292:  0D            DEC C                         
  2293:  00            NOP                           
  2294:  00            NOP                           
  2295:  00            NOP                           
  2296:  CD 05 1F      CALL 0x1F05                   
  2299:  B7            OR A                          
  229A:  20 12         JR NZ,0x22AE                    ; -> 0x22AE
  229C:  23            INC HL                        
  229D:  7E            LD A,(HL)                     
  229E:  23            INC HL                        
  229F:  B6            DB 0xB6                       
  22A0:  1E 06         LD E,0x06                     
  22A2:  CA A2 19      JP Z,0x19A2                   
  22A5:  23            INC HL                        
  22A6:  5E            DB 0x5E                         ; '^'
  22A7:  23            INC HL                        
  22A8:  56            DB 0x56                         ; 'V'
  22A9:  EB            EX DE,HL                      
  22AA:  22 DA 40      LD (0x40DA),HL                
  22AD:  EB            EX DE,HL                      
  22AE:  D7            RST 10h                       
  22AF:  FE 88         CP 0x88                       
  22B1:  20 E3         JR NZ,0x2296                    ; -> 0x2296
  22B3:  C3 2D 22      JP 0x222D                     
  22B6:  11 00 00      LD DE,0x0000                  
  22B9:  C4 0D 26      CALL NZ,0x260D                
  22BC:  22 DF 40      LD (ptr_program),HL           
  22BF:  CD 36 19      CALL 0x1936                   
  22C2:  C2 9D 19      JP NZ,0x199D                  
  22C5:  F9            LD SP,HL                      
  22C6:  22 E8 40      LD (0x40E8),HL                
  22C9:  D5            PUSH DE                       
  22CA:  7E            LD A,(HL)                     
  22CB:  23            INC HL                        
  22CC:  F5            PUSH AF                       
  22CD:  D5            PUSH DE                       
  22CE:  7E            LD A,(HL)                     
  22CF:  23            INC HL                        
  22D0:  B7            OR A                          
  22D1:  FA EA 22      JP M,0x22EA                   
  22D4:  CD B1 09      CALL 0x09B1                   
  22D7:  E3            EX (SP),HL                    
  22D8:  E5            PUSH HL                       
  22D9:  CD 0B 07      CALL 0x070B                   
  22DC:  E1            POP HL                        
  22DD:  CD CB 09      CALL 0x09CB                   
  22E0:  E1            POP HL                        
  22E1:  CD C2 09      CALL 0x09C2                   
  22E4:  E5            PUSH HL                       
  22E5:  CD 0C 0A      CALL 0x0A0C                   
  22E8:  18 29         JR 0x2313                       ; -> 0x2313
  22EA:  23            INC HL                        
  22EB:  23            INC HL                        
  22EC:  23            INC HL                        
  22ED:  23            INC HL                        
  22EE:  4E            DB 0x4E                         ; 'N'
  22EF:  23            INC HL                        
  22F0:  46            DB 0x46                         ; 'F'
  22F1:  23            INC HL                        
  22F2:  E3            EX (SP),HL                    
  22F3:  5E            DB 0x5E                         ; '^'
  22F4:  23            INC HL                        
  22F5:  56            DB 0x56                         ; 'V'
  22F6:  E5            PUSH HL                       
  22F7:  69            LD L,C                        
  22F8:  60            LD H,B                        
  22F9:  CD D2 0B      CALL 0x0BD2                   
  22FC:  3A AF 40      LD A,(ptr_mem_low)            
  22FF:  FE 04         CP 0x04                       
  2301:  CA B2 07      JP Z,0x07B2                   
  2304:  EB            EX DE,HL                      
  2305:  E1            POP HL                        
  2306:  72            LD (HL),D                     
  2307:  2B            DEC HL                        
  2308:  73            LD (HL),E                     
  2309:  E1            POP HL                        
  230A:  D5            PUSH DE                       
  230B:  5E            DB 0x5E                         ; '^'
  230C:  23            INC HL                        
  230D:  56            DB 0x56                         ; 'V'
  230E:  23            INC HL                        
  230F:  E3            EX (SP),HL                    
  2310:  CD 39 0A      CALL 0x0A39                   
  2313:  E1            POP HL                        
  2314:  C1            POP BC                        
  2315:  90            SUB B                         
  2316:  CD C2 09      CALL 0x09C2                   
  2319:  28 09         JR Z,0x2324                     ; -> 0x2324
  231B:  EB            EX DE,HL                      
  231C:  22 A2 40      LD (0x40A2),HL                
  231F:  69            LD L,C                        
  2320:  60            LD H,B                        
  2321:  C3 1A 1D      JP 0x1D1A                     
  2324:  F9            LD SP,HL                      
  2325:  22 E8 40      LD (0x40E8),HL                
  2328:  2A DF 40      LD HL,(ptr_program)           
  232B:  7E            LD A,(HL)                     
  232C:  FE 2C         CP 0x2C                       
  232E:  C2 1E 1D      JP NZ,0x1D1E                  
  2331:  D7            RST 10h                       
  2332:  CD B9 22      CALL 0x22B9                   
  2335:  CF            RST 08h                       
  2336:  28 2B         JR Z,0x2363                     ; -> 0x2363
  2338:  16 00         LD D,0x00                     
  233A:  D5            PUSH DE                       
  233B:  0E 01         LD C,0x01                     
  233D:  CD 63 19      CALL 0x1963                   
  2340:  CD 9F 24      CALL 0x249F                   
  2343:  22 F3 40      LD (0x40F3),HL                
  2346:  2A F3 40      LD HL,(0x40F3)                
  2349:  C1            POP BC                        
  234A:  7E            LD A,(HL)                     
  234B:  16 00         LD D,0x00                     
  234D:  D6 D4         SUB 0xD4                      
  234F:  38 13         JR C,0x2364                     ; -> 0x2364
  2351:  FE 03         CP 0x03                       
  2353:  30 0F         JR NC,0x2364                    ; -> 0x2364
  2355:  FE 01         CP 0x01                       
  2357:  17            RLA                           
  2358:  AA            XOR D                         
  2359:  BA            CP D                          
  235A:  57            LD D,A                        
  235B:  DA 97 19      JP C,0x1997                   
  235E:  22 D8 40      LD (0x40D8),HL                
  2361:  D7            RST 10h                       
  2362:  18 E9         JR 0x234D                       ; -> 0x234D
  2364:  7A            LD A,D                        
  2365:  B7            OR A                          
  2366:  C2 EC 23      JP NZ,0x23EC                  
  2369:  7E            LD A,(HL)                     
  236A:  22 D8 40      LD (0x40D8),HL                
  236D:  D6 CD         SUB 0xCD                      
  236F:  D8            RET C                         
  2370:  FE 07         CP 0x07                       
  2372:  D0            RET NC                        
  2373:  5F            LD E,A                        
  2374:  3A AF 40      LD A,(ptr_mem_low)            
  2377:  D6 03         SUB 0x03                      
  2379:  B3            OR E                          
  237A:  CA 8F 29      JP Z,0x298F                   
  237D:  21 9A 18      LD HL,0x189A                  
  2380:  19            ADD HL,DE                     
  2381:  78            LD A,B                        
  2382:  56            DB 0x56                         ; 'V'
  2383:  BA            CP D                          
  2384:  D0            RET NC                        
  2385:  C5            PUSH BC                       
  2386:  01 46 23      LD BC,0x2346                  
  2389:  C5            PUSH BC                       
  238A:  7A            LD A,D                        
  238B:  FE 7F         CP 0x7F                       
  238D:  CA D4 23      JP Z,0x23D4                   
  2390:  FE 51         CP 0x51                       
  2392:  DA E1 23      JP C,0x23E1                   
  2395:  21 21 41      LD HL,0x4121                    ; ← RAM sistema
  2398:  B7            OR A                          
  2399:  3A AF 40      LD A,(ptr_mem_low)            
  239C:  3D            DEC A                         
  239D:  3D            DEC A                         
  239E:  3D            DEC A                         
  239F:  CA F6 0A      JP Z,0x0AF6                   
  23A2:  4E            DB 0x4E                         ; 'N'
  23A3:  23            INC HL                        
  23A4:  46            DB 0x46                         ; 'F'
  23A5:  C5            PUSH BC                       
  23A6:  FA C5 23      JP M,0x23C5                   
  23A9:  23            INC HL                        
  23AA:  4E            DB 0x4E                         ; 'N'
  23AB:  23            INC HL                        
  23AC:  46            DB 0x46                         ; 'F'
  23AD:  C5            PUSH BC                       
  23AE:  F5            PUSH AF                       
  23AF:  B7            OR A                          
  23B0:  E2 C4 23      JP PO,0x23C4                  
  23B3:  F1            POP AF                        
  23B4:  23            INC HL                        
  23B5:  38 03         JR C,0x23BA                     ; -> 0x23BA
  23B7:  21 1D 41      LD HL,0x411D                    ; ← RAM sistema
  23BA:  4E            DB 0x4E                         ; 'N'
  23BB:  23            INC HL                        
  23BC:  46            DB 0x46                         ; 'F'
  23BD:  23            INC HL                        
  23BE:  C5            PUSH BC                       
  23BF:  4E            DB 0x4E                         ; 'N'
  23C0:  23            INC HL                        
  23C1:  46            DB 0x46                         ; 'F'
  23C2:  C5            PUSH BC                       
  23C3:  06 F1         LD B,0xF1                     
  23C5:  C6 03         ADD A,0x03                    
  23C7:  4B            LD C,E                        
  23C8:  47            LD B,A                        
  23C9:  C5            PUSH BC                       
  23CA:  01 06 24      LD BC,0x2406                  
  23CD:  C5            PUSH BC                       
  23CE:  2A D8 40      LD HL,(0x40D8)                
  23D1:  C3 3A 23      JP 0x233A                     
  23D4:  CD B1 0A      CALL 0x0AB1                   
  23D7:  CD A4 09      CALL BASIC_EVAL_EXPR          
  23DA:  01 F2 13      LD BC,0x13F2                  
  23DD:  16 7F         LD D,0x7F                     
  23DF:  18 EC         JR 0x23CD                       ; -> 0x23CD
  23E1:  D5            PUSH DE                       
  23E2:  CD 7F 0A      CALL 0x0A7F                   
  23E5:  D1            POP DE                        
  23E6:  E5            PUSH HL                       
  23E7:  01 E9 25      LD BC,0x25E9                  
  23EA:  18 E1         JR 0x23CD                       ; -> 0x23CD
  23EC:  78            LD A,B                        
  23ED:  FE 64         CP 0x64                       
  23EF:  D0            RET NC                        
  23F0:  C5            PUSH BC                       
  23F1:  D5            PUSH DE                       
  23F2:  11 04 64      LD DE,0x6404                  
  23F5:  21 B8 25      LD HL,0x25B8                  
  23F8:  E5            PUSH HL                       
  23F9:  E7            RST 20h                       
  23FA:  C2 95 23      JP NZ,0x2395                  
  23FD:  2A 21 41      LD HL,(0x4121)                
  2400:  E5            PUSH HL                       
  2401:  01 8C 25      LD BC,0x258C                  
  2404:  18 C7         JR 0x23CD                       ; -> 0x23CD
  2406:  C1            POP BC                        
  2407:  79            LD A,C                        
  2408:  32 B0 40      LD (0x40B0),A                   ; → RAM sistema
  240B:  78            LD A,B                        
  240C:  FE 08         CP 0x08                       
  240E:  28 28         JR Z,0x2438                     ; -> 0x2438
  2410:  3A AF 40      LD A,(ptr_mem_low)            
  2413:  FE 08         CP 0x08                       
  2415:  CA 60 24      JP Z,0x2460                   
  2418:  57            LD D,A                        
  2419:  78            LD A,B                        
  241A:  FE 04         CP 0x04                       
  241C:  CA 72 24      JP Z,0x2472                   
  241F:  7A            LD A,D                        
  2420:  FE 03         CP 0x03                       
  2422:  CA F6 0A      JP Z,0x0AF6                   
  2425:  D2 7C 24      JP NC,0x247C                  
  2428:  21 BF 18      LD HL,0x18BF                  
  242B:  06 00         LD B,0x00                     
  242D:  09            ADD HL,BC                     
  242E:  09            ADD HL,BC                     
  242F:  4E            DB 0x4E                         ; 'N'
  2430:  23            INC HL                        
  2431:  46            DB 0x46                         ; 'F'
  2432:  D1            POP DE                        
  2433:  2A 21 41      LD HL,(0x4121)                
  2436:  C5            PUSH BC                       
  2437:  C9            RET                           
  2438:  CD DB 0A      CALL 0x0ADB                   
  243B:  CD FC 09      CALL 0x09FC                   
  243E:  E1            POP HL                        
  243F:  22 1F 41      LD (0x411F),HL                
  2442:  E1            POP HL                        
  2443:  22 1D 41      LD (0x411D),HL                
  2446:  C1            POP BC                        
  2447:  D1            POP DE                        
  2448:  CD B4 09      CALL 0x09B4                   
  244B:  CD DB 0A      CALL 0x0ADB                   
  244E:  21 AB 18      LD HL,0x18AB                  
  2451:  3A B0 40      LD A,(0x40B0)                 
  2454:  07            RLCA                          
  2455:  C5            PUSH BC                       
  2456:  4F            LD C,A                        
  2457:  06 00         LD B,0x00                     
  2459:  09            ADD HL,BC                     
  245A:  C1            POP BC                        
  245B:  7E            LD A,(HL)                     
  245C:  23            INC HL                        
  245D:  66            DB 0x66                         ; 'f'
  245E:  6F            LD L,A                        
  245F:  E9            JP (HL)                       
  2460:  C5            PUSH BC                       
  2461:  CD FC 09      CALL 0x09FC                   
  2464:  F1            POP AF                        
  2465:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  2468:  FE 04         CP 0x04                       
  246A:  28 DA         JR Z,0x2446                     ; -> 0x2446
  246C:  E1            POP HL                        
  246D:  22 21 41      LD (0x4121),HL                
  2470:  18 D9         JR 0x244B                       ; -> 0x244B
  2472:  CD B1 0A      CALL 0x0AB1                   
  2475:  C1            POP BC                        
  2476:  D1            POP DE                        
  2477:  21 B5 18      LD HL,0x18B5                  
  247A:  18 D5         JR 0x2451                       ; -> 0x2451
  247C:  E1            POP HL                        
  247D:  CD A4 09      CALL BASIC_EVAL_EXPR          
  2480:  CD CF 0A      CALL 0x0ACF                   
  2483:  CD BF 09      CALL 0x09BF                   
  2486:  E1            POP HL                        
  2487:  22 23 41      LD (0x4123),HL                
  248A:  E1            POP HL                        
  248B:  22 21 41      LD (0x4121),HL                
  248E:  18 E7         JR 0x2477                       ; -> 0x2477
  2490:  E5            PUSH HL                       
  2491:  EB            EX DE,HL                      
  2492:  CD CF 0A      CALL 0x0ACF                   
  2495:  E1            POP HL                        
  2496:  CD A4 09      CALL BASIC_EVAL_EXPR          
  2499:  CD CF 0A      CALL 0x0ACF                   
  249C:  C3 A0 08      JP 0x08A0                     
  249F:  D7            RST 10h                       
  24A0:  1E 28         LD E,0x28                     
  24A2:  CA A2 19      JP Z,0x19A2                   
  24A5:  DA 6C 0E      JP C,0x0E6C                   
  24A8:  CD 3D 1E      CALL 0x1E3D                   
  24AB:  D2 40 25      JP NC,0x2540                  
  24AE:  FE CD         CP 0xCD                       
  24B0:  28 ED         JR Z,0x249F                     ; -> 0x249F
  24B2:  FE 2E         CP 0x2E                       
  24B4:  CA 6C 0E      JP Z,0x0E6C                   
  24B7:  FE CE         CP 0xCE                       
  24B9:  CA 32 25      JP Z,0x2532                   
  24BC:  FE 22         CP 0x22                       
  24BE:  CA 66 28      JP Z,0x2866                   
  24C1:  FE CB         CP 0xCB                       
  24C3:  CA C4 25      JP Z,0x25C4                   
  24C6:  FE 26         CP 0x26                       
  24C8:  CA 94 41      JP Z,0x4194                   
  24CB:  FE C3         CP 0xC3                       
  24CD:  20 0A         JR NZ,0x24D9                    ; -> 0x24D9
  24CF:  D7            RST 10h                       
  24D0:  3A 9A 40      LD A,(0x409A)                 
  24D3:  E5            PUSH HL                       
  24D4:  CD F8 27      CALL 0x27F8                   
  24D7:  E1            POP HL                        
  24D8:  C9            RET                           
  24D9:  FE C2         CP 0xC2                       
  24DB:  20 0A         JR NZ,0x24E7                    ; -> 0x24E7
  24DD:  D7            RST 10h                       
  24DE:  E5            PUSH HL                       
  24DF:  2A EA 40      LD HL,(0x40EA)                
  24E2:  CD 66 0C      CALL 0x0C66                   
  24E5:  E1            POP HL                        
  24E6:  C9            RET                           
  24E7:  FE C0         CP 0xC0                       
  24E9:  20 14         JR NZ,0x24FF                    ; -> 0x24FF
  24EB:  D7            RST 10h                       
  24EC:  CF            RST 08h                       
  24ED:  28 CD         JR Z,0x24BC                     ; -> 0x24BC
  24EF:  0D            DEC C                         
  24F0:  26 CF         LD H,0xCF                     
  24F2:  29            ADD HL,HL                     
  24F3:  E5            PUSH HL                       
  24F4:  EB            EX DE,HL                      
  24F5:  7C            LD A,H                        
  24F6:  B5            OR L                          
  24F7:  CA 4A 1E      JP Z,0x1E4A                   
  24FA:  CD 9A 0A      CALL 0x0A9A                   
  24FD:  E1            POP HL                        
  24FE:  C9            RET                           
  24FF:  FE C1         CP 0xC1                       
  2501:  CA FE 27      JP Z,0x27FE                   
  2504:  FE C5         CP 0xC5                       
  2506:  CA 9D 41      JP Z,0x419D                   
  2509:  FE C8         CP 0xC8                       
  250B:  CA C9 27      JP Z,0x27C9                   
  250E:  FE C7         CP 0xC7                       
  2510:  CA 76 41      JP Z,0x4176                   
  2513:  FE C6         CP 0xC6                       
  2515:  CA 32 01      JP Z,0x0132                   
  2518:  FE C9         CP 0xC9                       
  251A:  CA 9D 01      JP Z,0x019D                   
  251D:  FE C4         CP 0xC4                       
  251F:  CA 2F 2A      JP Z,0x2A2F                   
  2522:  FE BE         CP 0xBE                       
  2524:  CA 55 41      JP Z,0x4155                   
  2527:  D6 D7         SUB 0xD7                      
  2529:  D2 4E 25      JP NC,0x254E                  
  252C:  CD 35 23      CALL 0x2335                   
  252F:  CF            RST 08h                       
  2530:  29            ADD HL,HL                     
  2531:  C9            RET                           
  2532:  16 7D         LD D,0x7D                     
  2534:  CD 3A 23      CALL 0x233A                   
  2537:  2A F3 40      LD HL,(0x40F3)                
  253A:  E5            PUSH HL                       
  253B:  CD 7B 09      CALL 0x097B                   
  253E:  E1            POP HL                        
  253F:  C9            RET                           
  2540:  CD 0D 26      CALL 0x260D                   
  2543:  E5            PUSH HL                       
  2544:  EB            EX DE,HL                      
  2545:  22 21 41      LD (0x4121),HL                
  2548:  E7            RST 20h                       
  2549:  C4 F7 09      CALL NZ,0x09F7                
  254C:  E1            POP HL                        
  254D:  C9            RET                           
  254E:  06 00         LD B,0x00                     
  2550:  07            RLCA                          
  2551:  4F            LD C,A                        
  2552:  C5            PUSH BC                       
  2553:  D7            RST 10h                       
  2554:  79            LD A,C                        
  2555:  FE 41         CP 0x41                       
  2557:  38 16         JR C,0x256F                     ; -> 0x256F
  2559:  CD 35 23      CALL 0x2335                   
  255C:  CF            RST 08h                       
  255D:  2C            INC L                         
  255E:  CD F4 0A      CALL 0x0AF4                   
  2561:  EB            EX DE,HL                      
  2562:  2A 21 41      LD HL,(0x4121)                
  2565:  E3            EX (SP),HL                    
  2566:  E5            PUSH HL                       
  2567:  EB            EX DE,HL                      
  2568:  CD 1C 2B      CALL 0x2B1C                   
  256B:  EB            EX DE,HL                      
  256C:  E3            EX (SP),HL                    
  256D:  18 14         JR 0x2583                       ; -> 0x2583
  256F:  CD 2C 25      CALL 0x252C                   
  2572:  E3            EX (SP),HL                    
  2573:  7D            LD A,L                        
  2574:  FE 0C         CP 0x0C                       
  2576:  38 07         JR C,0x257F                     ; -> 0x257F
  2578:  FE 1B         CP 0x1B                       
  257A:  E5            PUSH HL                       
  257B:  DC B1 0A      CALL C,0x0AB1                 
  257E:  E1            POP HL                        
  257F:  11 3E 25      LD DE,0x253E                  
  2582:  D5            PUSH DE                       
  2583:  01 08 16      LD BC,0x1608                  
  2586:  09            ADD HL,BC                     
  2587:  4E            DB 0x4E                         ; 'N'
  2588:  23            INC HL                        
  2589:  66            DB 0x66                         ; 'f'
  258A:  69            LD L,C                        
  258B:  E9            JP (HL)                       
  258C:  CD D7 29      CALL 0x29D7                   
  258F:  7E            LD A,(HL)                     
  2590:  23            INC HL                        
  2591:  4E            DB 0x4E                         ; 'N'
  2592:  23            INC HL                        
  2593:  46            DB 0x46                         ; 'F'
  2594:  D1            POP DE                        
  2595:  C5            PUSH BC                       
  2596:  F5            PUSH AF                       
  2597:  CD DE 29      CALL 0x29DE                   
  259A:  D1            POP DE                        
  259B:  5E            DB 0x5E                         ; '^'
  259C:  23            INC HL                        
  259D:  4E            DB 0x4E                         ; 'N'
  259E:  23            INC HL                        
  259F:  46            DB 0x46                         ; 'F'
  25A0:  E1            POP HL                        
  25A1:  7B            LD A,E                        
  25A2:  B2            OR D                          
  25A3:  C8            RET Z                         
  25A4:  7A            LD A,D                        
  25A5:  D6 01         SUB 0x01                      
  25A7:  D8            RET C                         
  25A8:  AF            XOR A                         
  25A9:  BB            CP E                          
  25AA:  3C            INC A                         
  25AB:  D0            RET NC                        
  25AC:  15            DEC D                         
  25AD:  1D            DEC E                         
  25AE:  0A            DB 0x0A                       
  25AF:  BE            DB 0xBE                       
  25B0:  23            INC HL                        
  25B1:  03            INC BC                        
  25B2:  28 ED         JR Z,0x25A1                     ; -> 0x25A1
  25B4:  3F            CCF                           
  25B5:  C3 60 09      JP 0x0960                     
  25B8:  3C            INC A                         
  25B9:  8F            ADC A,A                       
  25BA:  C1            POP BC                        
  25BB:  A0            AND B                         
  25BC:  C6 FF         ADD A,0xFF                    
  25BE:  9F            SBC A,A                       
  25BF:  CD 8D 09      CALL 0x098D                   
  25C2:  18 12         JR 0x25D6                       ; -> 0x25D6
  25C4:  16 5A         LD D,0x5A                     
  25C6:  CD 3A 23      CALL 0x233A                   
  25C9:  CD 7F 0A      CALL 0x0A7F                   
  25CC:  7D            LD A,L                        
  25CD:  2F            CPL                           
  25CE:  6F            LD L,A                        
  25CF:  7C            LD A,H                        
  25D0:  2F            CPL                           
  25D1:  67            LD H,A                        
  25D2:  22 21 41      LD (0x4121),HL                
  25D5:  C1            POP BC                        
  25D6:  C3 46 23      JP 0x2346                     
RST4_IO:
  25D9:  3A AF 40      LD A,(ptr_mem_low)            
  25DC:  FE 08         CP 0x08                       
  25DE:  30 05         JR NC,0x25E5                    ; -> 0x25E5
  25E0:  D6 03         SUB 0x03                      
  25E2:  B7            OR A                          
  25E3:  37            SCF                           
  25E4:  C9            RET                           
  25E5:  D6 03         SUB 0x03                      
  25E7:  B7            OR A                          
  25E8:  C9            RET                           
  25E9:  C5            PUSH BC                       
  25EA:  CD 7F 0A      CALL 0x0A7F                   
  25ED:  F1            POP AF                        
  25EE:  D1            POP DE                        
  25EF:  01 FA 27      LD BC,0x27FA                  
  25F2:  C5            PUSH BC                       
  25F3:  FE 46         CP 0x46                       
  25F5:  20 06         JR NZ,0x25FD                    ; -> 0x25FD
  25F7:  7B            LD A,E                        
  25F8:  B5            OR L                          
  25F9:  6F            LD L,A                        
  25FA:  7C            LD A,H                        
  25FB:  B2            OR D                          
  25FC:  C9            RET                           
  25FD:  7B            LD A,E                        
  25FE:  A5            AND L                         
  25FF:  6F            LD L,A                        
  2600:  7C            LD A,H                        
  2601:  A2            AND D                         
  2602:  C9            RET                           
  2603:  2B            DEC HL                        
  2604:  D7            RST 10h                       
  2605:  C8            RET Z                         
  2606:  CF            RST 08h                       
  2607:  2C            INC L                         
  2608:  01 03 26      LD BC,0x2603                  
  260B:  C5            PUSH BC                       
  260C:  F6 AF         OR 0xAF                       
  260E:  32 AE 40      LD (0x40AE),A                   ; → RAM sistema
  2611:  46            DB 0x46                         ; 'F'
  2612:  CD 3D 1E      CALL 0x1E3D                   
  2615:  DA 97 19      JP C,0x1997                   
  2618:  AF            XOR A                         
  2619:  4F            LD C,A                        
  261A:  D7            RST 10h                       
  261B:  38 05         JR C,0x2622                     ; -> 0x2622
  261D:  CD 3D 1E      CALL 0x1E3D                   
  2620:  38 09         JR C,0x262B                     ; -> 0x262B
  2622:  4F            LD C,A                        
  2623:  D7            RST 10h                       
  2624:  38 FD         JR C,0x2623                     ; -> 0x2623
  2626:  CD 3D 1E      CALL 0x1E3D                   
  2629:  30 F8         JR NC,0x2623                    ; -> 0x2623
  262B:  11 52 26      LD DE,0x2652                  
  262E:  D5            PUSH DE                       
  262F:  16 02         LD D,0x02                     
  2631:  FE 25         CP 0x25                       
  2633:  C8            RET Z                         
  2634:  14            INC D                         
  2635:  FE 24         CP 0x24                       
  2637:  C8            RET Z                         
  2638:  14            INC D                         
  2639:  FE 21         CP 0x21                       
  263B:  C8            RET Z                         
  263C:  16 08         LD D,0x08                     
  263E:  FE 23         CP 0x23                       
  2640:  C8            RET Z                         
  2641:  78            LD A,B                        
  2642:  D6 41         SUB 0x41                      
  2644:  E6 7F         AND 0x7F                      
  2646:  5F            LD E,A                        
  2647:  16 00         LD D,0x00                     
  2649:  E5            PUSH HL                       
  264A:  21 01 41      LD HL,0x4101                    ; ← RAM sistema
  264D:  19            ADD HL,DE                     
  264E:  56            DB 0x56                         ; 'V'
  264F:  E1            POP HL                        
  2650:  2B            DEC HL                        
  2651:  C9            RET                           
  2652:  7A            LD A,D                        
  2653:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  2656:  D7            RST 10h                       
  2657:  3A DC 40      LD A,(0x40DC)                 
  265A:  B7            OR A                          
  265B:  C2 64 26      JP NZ,0x2664                  
  265E:  7E            LD A,(HL)                     
  265F:  D6 28         SUB 0x28                      
  2661:  CA E9 26      JP Z,0x26E9                   
  2664:  AF            XOR A                         
  2665:  32 DC 40      LD (0x40DC),A                   ; → RAM sistema
  2668:  E5            PUSH HL                       
  2669:  D5            PUSH DE                       
  266A:  2A F9 40      LD HL,(0x40F9)                
  266D:  EB            EX DE,HL                      
  266E:  2A FB 40      LD HL,(0x40FB)                
  2671:  DF            RST 18h                       
  2672:  E1            POP HL                        
  2673:  28 19         JR Z,0x268E                     ; -> 0x268E
  2675:  1A            DB 0x1A                       
  2676:  6F            LD L,A                        
  2677:  BC            CP H                          
  2678:  13            INC DE                        
  2679:  20 0B         JR NZ,0x2686                    ; -> 0x2686
  267B:  1A            DB 0x1A                       
  267C:  B9            CP C                          
  267D:  20 07         JR NZ,0x2686                    ; -> 0x2686
  267F:  13            INC DE                        
  2680:  1A            DB 0x1A                       
  2681:  B8            CP B                          
  2682:  CA CC 26      JP Z,0x26CC                   
  2685:  3E 13         LD A,0x13                     
  2687:  13            INC DE                        
  2688:  E5            PUSH HL                       
  2689:  26 00         LD H,0x00                     
  268B:  19            ADD HL,DE                     
  268C:  18 DF         JR 0x266D                       ; -> 0x266D
  268E:  7C            LD A,H                        
  268F:  E1            POP HL                        
  2690:  E3            EX (SP),HL                    
  2691:  F5            PUSH AF                       
  2692:  D5            PUSH DE                       
  2693:  11 F1 24      LD DE,0x24F1                  
  2696:  DF            RST 18h                       
  2697:  28 36         JR Z,0x26CF                     ; -> 0x26CF
  2699:  11 43 25      LD DE,0x2543                  
  269C:  DF            RST 18h                       
  269D:  D1            POP DE                        
  269E:  28 35         JR Z,0x26D5                     ; -> 0x26D5
  26A0:  F1            POP AF                        
  26A1:  E3            EX (SP),HL                    
  26A2:  E5            PUSH HL                       
  26A3:  C5            PUSH BC                       
  26A4:  4F            LD C,A                        
  26A5:  06 00         LD B,0x00                     
  26A7:  C5            PUSH BC                       
  26A8:  03            INC BC                        
  26A9:  03            INC BC                        
  26AA:  03            INC BC                        
  26AB:  2A FD 40      LD HL,(0x40FD)                
  26AE:  E5            PUSH HL                       
  26AF:  09            ADD HL,BC                     
  26B0:  C1            POP BC                        
  26B1:  E5            PUSH HL                       
  26B2:  CD 55 19      CALL 0x1955                   
  26B5:  E1            POP HL                        
  26B6:  22 FD 40      LD (0x40FD),HL                
  26B9:  60            LD H,B                        
  26BA:  69            LD L,C                        
  26BB:  22 FB 40      LD (0x40FB),HL                
  26BE:  2B            DEC HL                        
  26BF:  36 00         LD (HL),0x00                  
  26C1:  DF            RST 18h                       
  26C2:  20 FA         JR NZ,0x26BE                    ; -> 0x26BE
  26C4:  D1            POP DE                        
  26C5:  73            LD (HL),E                     
  26C6:  23            INC HL                        
  26C7:  D1            POP DE                        
  26C8:  73            LD (HL),E                     
  26C9:  23            INC HL                        
  26CA:  72            LD (HL),D                     
  26CB:  EB            EX DE,HL                      
  26CC:  13            INC DE                        
  26CD:  E1            POP HL                        
  26CE:  C9            RET                           
  26CF:  57            LD D,A                        
  26D0:  5F            LD E,A                        
  26D1:  F1            POP AF                        
  26D2:  F1            POP AF                        
  26D3:  E3            EX (SP),HL                    
  26D4:  C9            RET                           
  26D5:  32 24 41      LD (0x4124),A                   ; → RAM sistema
  26D8:  C1            POP BC                        
  26D9:  67            LD H,A                        
  26DA:  6F            LD L,A                        
  26DB:  22 21 41      LD (0x4121),HL                
  26DE:  E7            RST 20h                       
  26DF:  20 06         JR NZ,0x26E7                    ; -> 0x26E7
  26E1:  21 28 19      LD HL,0x1928                  
  26E4:  22 21 41      LD (0x4121),HL                
  26E7:  E1            POP HL                        
  26E8:  C9            RET                           
  26E9:  E5            PUSH HL                       
  26EA:  2A AE 40      LD HL,(0x40AE)                
  26ED:  E3            EX (SP),HL                    
  26EE:  57            LD D,A                        
  26EF:  D5            PUSH DE                       
  26F0:  C5            PUSH BC                       
  26F1:  CD 45 1E      CALL 0x1E45                   
  26F4:  C1            POP BC                        
  26F5:  F1            POP AF                        
  26F6:  EB            EX DE,HL                      
  26F7:  E3            EX (SP),HL                    
  26F8:  E5            PUSH HL                       
  26F9:  EB            EX DE,HL                      
  26FA:  3C            INC A                         
  26FB:  57            LD D,A                        
  26FC:  7E            LD A,(HL)                     
  26FD:  FE 2C         CP 0x2C                       
  26FF:  28 EE         JR Z,0x26EF                     ; -> 0x26EF
  2701:  CF            RST 08h                       
  2702:  29            ADD HL,HL                     
  2703:  22 F3 40      LD (0x40F3),HL                
  2706:  E1            POP HL                        
  2707:  22 AE 40      LD (0x40AE),HL                
  270A:  D5            PUSH DE                       
  270B:  2A FB 40      LD HL,(0x40FB)                
  270E:  3E 19         LD A,0x19                     
  2710:  EB            EX DE,HL                      
  2711:  2A FD 40      LD HL,(0x40FD)                
  2714:  EB            EX DE,HL                      
  2715:  DF            RST 18h                       
  2716:  3A AF 40      LD A,(ptr_mem_low)            
  2719:  28 27         JR Z,0x2742                     ; -> 0x2742
  271B:  BE            DB 0xBE                       
  271C:  23            INC HL                        
  271D:  20 08         JR NZ,0x2727                    ; -> 0x2727
  271F:  7E            LD A,(HL)                     
  2720:  B9            CP C                          
  2721:  23            INC HL                        
  2722:  20 04         JR NZ,0x2728                    ; -> 0x2728
  2724:  7E            LD A,(HL)                     
  2725:  B8            CP B                          
  2726:  3E 23         LD A,0x23                     
  2728:  23            INC HL                        
  2729:  5E            DB 0x5E                         ; '^'
  272A:  23            INC HL                        
  272B:  56            DB 0x56                         ; 'V'
  272C:  23            INC HL                        
  272D:  20 E0         JR NZ,0x270F                    ; -> 0x270F
  272F:  3A AE 40      LD A,(0x40AE)                 
  2732:  B7            OR A                          
  2733:  1E 12         LD E,0x12                     
  2735:  C2 A2 19      JP NZ,0x19A2                  
  2738:  F1            POP AF                        
  2739:  96            DB 0x96                       
  273A:  CA 95 27      JP Z,0x2795                   
  273D:  1E 10         LD E,0x10                     
  273F:  C3 A2 19      JP 0x19A2                     
  2742:  77            LD (HL),A                     
  2743:  23            INC HL                        
  2744:  5F            LD E,A                        
  2745:  16 00         LD D,0x00                     
  2747:  F1            POP AF                        
  2748:  71            LD (HL),C                     
  2749:  23            INC HL                        
  274A:  70            LD (HL),B                     
  274B:  23            INC HL                        
  274C:  4F            LD C,A                        
  274D:  CD 63 19      CALL 0x1963                   
  2750:  23            INC HL                        
  2751:  23            INC HL                        
  2752:  22 D8 40      LD (0x40D8),HL                
  2755:  71            LD (HL),C                     
  2756:  23            INC HL                        
  2757:  3A AE 40      LD A,(0x40AE)                 
  275A:  17            RLA                           
  275B:  79            LD A,C                        
  275C:  01 0B 00      LD BC,0x000B                  
  275F:  30 02         JR NC,0x2763                    ; -> 0x2763
  2761:  C1            POP BC                        
  2762:  03            INC BC                        
  2763:  71            LD (HL),C                     
  2764:  23            INC HL                        
  2765:  70            LD (HL),B                     
  2766:  23            INC HL                        
  2767:  F5            PUSH AF                       
  2768:  CD AA 0B      CALL 0x0BAA                   
  276B:  F1            POP AF                        
  276C:  3D            DEC A                         
  276D:  20 ED         JR NZ,0x275C                    ; -> 0x275C
  276F:  F5            PUSH AF                       
  2770:  42            LD B,D                        
  2771:  4B            LD C,E                        
  2772:  EB            EX DE,HL                      
  2773:  19            ADD HL,DE                     
  2774:  38 C7         JR C,0x273D                     ; -> 0x273D
  2776:  CD 6C 19      CALL 0x196C                   
  2779:  22 FD 40      LD (0x40FD),HL                
  277C:  2B            DEC HL                        
  277D:  36 00         LD (HL),0x00                  
  277F:  DF            RST 18h                       
  2780:  20 FA         JR NZ,0x277C                    ; -> 0x277C
  2782:  03            INC BC                        
  2783:  57            LD D,A                        
  2784:  2A D8 40      LD HL,(0x40D8)                
  2787:  5E            DB 0x5E                         ; '^'
  2788:  EB            EX DE,HL                      
  2789:  29            ADD HL,HL                     
  278A:  09            ADD HL,BC                     
  278B:  EB            EX DE,HL                      
  278C:  2B            DEC HL                        
  278D:  2B            DEC HL                        
  278E:  73            LD (HL),E                     
  278F:  23            INC HL                        
  2790:  72            LD (HL),D                     
  2791:  23            INC HL                        
  2792:  F1            POP AF                        
  2793:  38 30         JR C,0x27C5                     ; -> 0x27C5
  2795:  47            LD B,A                        
  2796:  4F            LD C,A                        
  2797:  7E            LD A,(HL)                     
  2798:  23            INC HL                        
  2799:  16 E1         LD D,0xE1                     
  279B:  5E            DB 0x5E                         ; '^'
  279C:  23            INC HL                        
  279D:  56            DB 0x56                         ; 'V'
  279E:  23            INC HL                        
  279F:  E3            EX (SP),HL                    
  27A0:  F5            PUSH AF                       
  27A1:  DF            RST 18h                       
  27A2:  D2 3D 27      JP NC,0x273D                  
  27A5:  CD AA 0B      CALL 0x0BAA                   
  27A8:  19            ADD HL,DE                     
  27A9:  F1            POP AF                        
  27AA:  3D            DEC A                         
  27AB:  44            LD B,H                        
  27AC:  4D            LD C,L                        
  27AD:  20 EB         JR NZ,0x279A                    ; -> 0x279A
  27AF:  3A AF 40      LD A,(ptr_mem_low)            
  27B2:  44            LD B,H                        
  27B3:  4D            LD C,L                        
  27B4:  29            ADD HL,HL                     
  27B5:  D6 04         SUB 0x04                      
  27B7:  38 04         JR C,0x27BD                     ; -> 0x27BD
  27B9:  29            ADD HL,HL                     
  27BA:  28 06         JR Z,0x27C2                     ; -> 0x27C2
  27BC:  29            ADD HL,HL                     
  27BD:  B7            OR A                          
  27BE:  E2 C2 27      JP PO,0x27C2                  
  27C1:  09            ADD HL,BC                     
  27C2:  C1            POP BC                        
  27C3:  09            ADD HL,BC                     
  27C4:  EB            EX DE,HL                      
  27C5:  2A F3 40      LD HL,(0x40F3)                
  27C8:  C9            RET                           
  27C9:  AF            XOR A                         
  27CA:  E5            PUSH HL                       
  27CB:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  27CE:  CD D4 27      CALL 0x27D4                   
  27D1:  E1            POP HL                        
  27D2:  D7            RST 10h                       
  27D3:  C9            RET                           
  27D4:  2A FD 40      LD HL,(0x40FD)                
  27D7:  EB            EX DE,HL                      
  27D8:  21 00 00      LD HL,0x0000                  
  27DB:  39            ADD HL,SP                     
  27DC:  E7            RST 20h                       
  27DD:  20 0D         JR NZ,0x27EC                    ; -> 0x27EC
  27DF:  CD DA 29      CALL 0x29DA                   
  27E2:  CD E6 28      CALL 0x28E6                   
  27E5:  2A A0 40      LD HL,(0x40A0)                
  27E8:  EB            EX DE,HL                      
  27E9:  2A D6 40      LD HL,(0x40D6)                
  27EC:  7D            LD A,L                        
  27ED:  93            DB 0x93                       
  27EE:  6F            LD L,A                        
  27EF:  7C            LD A,H                        
  27F0:  9A            DB 0x9A                       
  27F1:  67            LD H,A                        
  27F2:  C3 66 0C      JP 0x0C66                     
  27F5:  3A A6 40      LD A,(sys_ctrl_main)          
  27F8:  6F            LD L,A                        
  27F9:  AF            XOR A                         
  27FA:  67            LD H,A                        
  27FB:  C3 9A 0A      JP 0x0A9A                     
  27FE:  CD A9 41      CALL 0x41A9                   
  2801:  D7            RST 10h                       
  2802:  CD 2C 25      CALL 0x252C                   
  2805:  E5            PUSH HL                       
  2806:  21 90 08      LD HL,0x0890                  
  2809:  E5            PUSH HL                       
  280A:  3A AF 40      LD A,(ptr_mem_low)            
  280D:  F5            PUSH AF                       
  280E:  FE 03         CP 0x03                       
  2810:  CC DA 29      CALL Z,0x29DA                 
  2813:  F1            POP AF                        
  2814:  EB            EX DE,HL                      
  2815:  2A 8E 40      LD HL,(0x408E)                
  2818:  E9            JP (HL)                       
  2819:  E5            PUSH HL                       
  281A:  E6 07         AND 0x07                      
  281C:  21 A1 18      LD HL,0x18A1                  
  281F:  4F            LD C,A                        
  2820:  06 00         LD B,0x00                     
  2822:  09            ADD HL,BC                     
  2823:  CD 86 25      CALL 0x2586                   
  2826:  E1            POP HL                        
  2827:  C9            RET                           
  2828:  E5            PUSH HL                       
  2829:  2A A2 40      LD HL,(0x40A2)                
  282C:  23            INC HL                        
  282D:  7C            LD A,H                        
  282E:  B5            OR L                          
  282F:  E1            POP HL                        
  2830:  C0            RET NZ                        
  2831:  1E 16         LD E,0x16                     
  2833:  C3 A2 19      JP 0x19A2                     
  2836:  CD BD 0F      CALL 0x0FBD                   
  2839:  CD 65 28      CALL 0x2865                   
  283C:  CD DA 29      CALL 0x29DA                   
  283F:  01 2B 2A      LD BC,0x2A2B                  
  2842:  C5            PUSH BC                       
  2843:  7E            LD A,(HL)                     
  2844:  23            INC HL                        
  2845:  E5            PUSH HL                       
  2846:  CD BF 28      CALL 0x28BF                   
  2849:  E1            POP HL                        
  284A:  4E            DB 0x4E                         ; 'N'
  284B:  23            INC HL                        
  284C:  46            DB 0x46                         ; 'F'
  284D:  CD 5A 28      CALL 0x285A                   
  2850:  E5            PUSH HL                       
  2851:  6F            LD L,A                        
  2852:  CD CE 29      CALL 0x29CE                   
  2855:  D1            POP DE                        
  2856:  C9            RET                           
  2857:  CD BF 28      CALL 0x28BF                   
  285A:  21 D3 40      LD HL,0x40D3                    ; ← RAM sistema
  285D:  E5            PUSH HL                       
  285E:  77            LD (HL),A                     
  285F:  23            INC HL                        
  2860:  73            LD (HL),E                     
  2861:  23            INC HL                        
  2862:  72            LD (HL),D                     
  2863:  E1            POP HL                        
  2864:  C9            RET                           
  2865:  2B            DEC HL                        
  2866:  06 22         LD B,0x22                     
  2868:  50            LD D,B                        
  2869:  E5            PUSH HL                       
  286A:  0E FF         LD C,0xFF                     
  286C:  23            INC HL                        
  286D:  7E            LD A,(HL)                     
  286E:  0C            INC C                         
  286F:  B7            OR A                          
  2870:  28 06         JR Z,0x2878                     ; -> 0x2878
  2872:  BA            CP D                          
  2873:  28 03         JR Z,0x2878                     ; -> 0x2878
  2875:  B8            CP B                          
  2876:  20 F4         JR NZ,0x286C                    ; -> 0x286C
  2878:  FE 22         CP 0x22                       
  287A:  CC 78 1D      CALL Z,RST2_DISPLAY           
  287D:  E3            EX (SP),HL                    
  287E:  23            INC HL                        
  287F:  EB            EX DE,HL                      
  2880:  79            LD A,C                        
  2881:  CD 5A 28      CALL 0x285A                   
  2884:  11 D3 40      LD DE,0x40D3                    ; ← RAM sistema
  2887:  3E D5         LD A,0xD5                     
  2889:  2A B3 40      LD HL,(0x40B3)                
  288C:  22 21 41      LD (0x4121),HL                
  288F:  3E 03         LD A,0x03                     
  2891:  32 AF 40      LD (ptr_mem_low),A              ; → RAM sistema
  2894:  CD D3 09      CALL 0x09D3                   
  2897:  11 D6 40      LD DE,0x40D6                    ; ← RAM sistema
  289A:  DF            RST 18h                       
  289B:  22 B3 40      LD (0x40B3),HL                
  289E:  E1            POP HL                        
  289F:  7E            LD A,(HL)                     
  28A0:  C0            RET NZ                        
  28A1:  1E 1E         LD E,0x1E                     
  28A3:  C3 A2 19      JP 0x19A2                     
  28A6:  23            INC HL                        
PRINT_STRING:
  28A7:  CD 65 28      CALL 0x2865                   
  28AA:  CD DA 29      CALL 0x29DA                   
  28AD:  CD C4 09      CALL 0x09C4                   
  28B0:  14            INC D                         
  28B1:  15            DEC D                         
  28B2:  C8            RET Z                         
  28B3:  0A            DB 0x0A                       
  28B4:  CD 2A 03      CALL DISPLAY_CHAR             
  28B7:  FE 0D         CP 0x0D                       
  28B9:  CC 03 21      CALL Z,0x2103                 
  28BC:  03            INC BC                        
  28BD:  18 F2         JR 0x28B1                       ; -> 0x28B1
  28BF:  B7            OR A                          
  28C0:  0E F1         LD C,0xF1                     
  28C2:  F5            PUSH AF                       
  28C3:  2A A0 40      LD HL,(0x40A0)                
  28C6:  EB            EX DE,HL                      
  28C7:  2A D6 40      LD HL,(0x40D6)                
  28CA:  2F            CPL                           
  28CB:  4F            LD C,A                        
  28CC:  06 FF         LD B,0xFF                     
  28CE:  09            ADD HL,BC                     
  28CF:  23            INC HL                        
  28D0:  DF            RST 18h                       
  28D1:  38 07         JR C,0x28DA                     ; -> 0x28DA
  28D3:  22 D6 40      LD (0x40D6),HL                
  28D6:  23            INC HL                        
  28D7:  EB            EX DE,HL                      
  28D8:  F1            POP AF                        
  28D9:  C9            RET                           
  28DA:  F1            POP AF                        
  28DB:  1E 1A         LD E,0x1A                     
  28DD:  CA A2 19      JP Z,0x19A2                   
  28E0:  BF            CP A                          
  28E1:  F5            PUSH AF                       
  28E2:  01 C1 28      LD BC,0x28C1                  
  28E5:  C5            PUSH BC                       
  28E6:  2A B1 40      LD HL,(ptr_mem_high)          
  28E9:  22 D6 40      LD (0x40D6),HL                
  28EC:  21 00 00      LD HL,0x0000                  
  28EF:  E5            PUSH HL                       
  28F0:  2A A0 40      LD HL,(0x40A0)                
  28F3:  E5            PUSH HL                       
  28F4:  21 B5 40      LD HL,0x40B5                    ; ← RAM sistema
  28F7:  EB            EX DE,HL                      
  28F8:  2A B3 40      LD HL,(0x40B3)                
  28FB:  EB            EX DE,HL                      
  28FC:  DF            RST 18h                       
  28FD:  01 F7 28      LD BC,0x28F7                  
  2900:  C2 4A 29      JP NZ,0x294A                  
  2903:  2A F9 40      LD HL,(0x40F9)                
  2906:  EB            EX DE,HL                      
  2907:  2A FB 40      LD HL,(0x40FB)                
  290A:  EB            EX DE,HL                      
  290B:  DF            RST 18h                       
  290C:  28 13         JR Z,0x2921                     ; -> 0x2921
  290E:  7E            LD A,(HL)                     
  290F:  23            INC HL                        
  2910:  23            INC HL                        
  2911:  23            INC HL                        
  2912:  FE 03         CP 0x03                       
  2914:  20 04         JR NZ,0x291A                    ; -> 0x291A
  2916:  CD 4B 29      CALL 0x294B                   
  2919:  AF            XOR A                         
  291A:  5F            LD E,A                        
  291B:  16 00         LD D,0x00                     
  291D:  19            ADD HL,DE                     
  291E:  18 E6         JR 0x2906                       ; -> 0x2906
  2920:  C1            POP BC                        
  2921:  EB            EX DE,HL                      
  2922:  2A FD 40      LD HL,(0x40FD)                
  2925:  EB            EX DE,HL                      
  2926:  DF            RST 18h                       
  2927:  CA 6B 29      JP Z,0x296B                   
  292A:  7E            LD A,(HL)                     
  292B:  23            INC HL                        
  292C:  CD C2 09      CALL 0x09C2                   
  292F:  E5            PUSH HL                       
  2930:  09            ADD HL,BC                     
  2931:  FE 03         CP 0x03                       
  2933:  20 EB         JR NZ,0x2920                    ; -> 0x2920
  2935:  22 D8 40      LD (0x40D8),HL                
  2938:  E1            POP HL                        
  2939:  4E            DB 0x4E                         ; 'N'
  293A:  06 00         LD B,0x00                     
  293C:  09            ADD HL,BC                     
  293D:  09            ADD HL,BC                     
  293E:  23            INC HL                        
  293F:  EB            EX DE,HL                      
  2940:  2A D8 40      LD HL,(0x40D8)                
  2943:  EB            EX DE,HL                      
  2944:  DF            RST 18h                       
  2945:  28 DA         JR Z,0x2921                     ; -> 0x2921
  2947:  01 3F 29      LD BC,0x293F                  
  294A:  C5            PUSH BC                       
  294B:  AF            XOR A                         
  294C:  B6            DB 0xB6                       
  294D:  23            INC HL                        
  294E:  5E            DB 0x5E                         ; '^'
  294F:  23            INC HL                        
  2950:  56            DB 0x56                         ; 'V'
  2951:  23            INC HL                        
  2952:  C8            RET Z                         
  2953:  44            LD B,H                        
  2954:  4D            LD C,L                        
  2955:  2A D6 40      LD HL,(0x40D6)                
  2958:  DF            RST 18h                       
  2959:  60            LD H,B                        
  295A:  69            LD L,C                        
  295B:  D8            RET C                         
  295C:  E1            POP HL                        
  295D:  E3            EX (SP),HL                    
  295E:  DF            RST 18h                       
  295F:  E3            EX (SP),HL                    
  2960:  E5            PUSH HL                       
  2961:  60            LD H,B                        
  2962:  69            LD L,C                        
  2963:  D0            RET NC                        
  2964:  C1            POP BC                        
  2965:  F1            POP AF                        
  2966:  F1            POP AF                        
  2967:  E5            PUSH HL                       
  2968:  D5            PUSH DE                       
  2969:  C5            PUSH BC                       
  296A:  C9            RET                           
  296B:  D1            POP DE                        
  296C:  E1            POP HL                        
  296D:  7D            LD A,L                        
  296E:  B4            OR H                          
  296F:  C8            RET Z                         
  2970:  2B            DEC HL                        
  2971:  46            DB 0x46                         ; 'F'
  2972:  2B            DEC HL                        
  2973:  4E            DB 0x4E                         ; 'N'
  2974:  E5            PUSH HL                       
  2975:  2B            DEC HL                        
  2976:  6E            DB 0x6E                         ; 'n'
  2977:  26 00         LD H,0x00                     
  2979:  09            ADD HL,BC                     
  297A:  50            LD D,B                        
  297B:  59            LD E,C                        
  297C:  2B            DEC HL                        
  297D:  44            LD B,H                        
  297E:  4D            LD C,L                        
  297F:  2A D6 40      LD HL,(0x40D6)                
  2982:  CD 58 19      CALL 0x1958                   
  2985:  E1            POP HL                        
  2986:  71            LD (HL),C                     
  2987:  23            INC HL                        
  2988:  70            LD (HL),B                     
  2989:  69            LD L,C                        
  298A:  60            LD H,B                        
  298B:  2B            DEC HL                        
  298C:  C3 E9 28      JP 0x28E9                     
  298F:  C5            PUSH BC                       
  2990:  E5            PUSH HL                       
  2991:  2A 21 41      LD HL,(0x4121)                
  2994:  E3            EX (SP),HL                    
  2995:  CD 9F 24      CALL 0x249F                   
  2998:  E3            EX (SP),HL                    
  2999:  CD F4 0A      CALL 0x0AF4                   
  299C:  7E            LD A,(HL)                     
  299D:  E5            PUSH HL                       
  299E:  2A 21 41      LD HL,(0x4121)                
  29A1:  E5            PUSH HL                       
  29A2:  86            DB 0x86                       
  29A3:  1E 1C         LD E,0x1C                     
  29A5:  DA A2 19      JP C,0x19A2                   
  29A8:  CD 57 28      CALL 0x2857                   
  29AB:  D1            POP DE                        
  29AC:  CD DE 29      CALL 0x29DE                   
  29AF:  E3            EX (SP),HL                    
  29B0:  CD DD 29      CALL 0x29DD                   
  29B3:  E5            PUSH HL                       
  29B4:  2A D4 40      LD HL,(0x40D4)                
  29B7:  EB            EX DE,HL                      
  29B8:  CD C6 29      CALL 0x29C6                   
  29BB:  CD C6 29      CALL 0x29C6                   
  29BE:  21 49 23      LD HL,0x2349                  
  29C1:  E3            EX (SP),HL                    
  29C2:  E5            PUSH HL                       
  29C3:  C3 84 28      JP 0x2884                     
  29C6:  E1            POP HL                        
  29C7:  E3            EX (SP),HL                    
  29C8:  7E            LD A,(HL)                     
  29C9:  23            INC HL                        
  29CA:  4E            DB 0x4E                         ; 'N'
  29CB:  23            INC HL                        
  29CC:  46            DB 0x46                         ; 'F'
  29CD:  6F            LD L,A                        
  29CE:  2C            INC L                         
  29CF:  2D            DEC L                         
  29D0:  C8            RET Z                         
  29D1:  0A            DB 0x0A                       
  29D2:  12            DB 0x12                       
  29D3:  03            INC BC                        
  29D4:  13            INC DE                        
  29D5:  18 F8         JR 0x29CF                       ; -> 0x29CF
  29D7:  CD F4 0A      CALL 0x0AF4                   
  29DA:  2A 21 41      LD HL,(0x4121)                
  29DD:  EB            EX DE,HL                      
  29DE:  CD F5 29      CALL 0x29F5                   
  29E1:  EB            EX DE,HL                      
  29E2:  C0            RET NZ                        
  29E3:  D5            PUSH DE                       
  29E4:  50            LD D,B                        
  29E5:  59            LD E,C                        
  29E6:  1B            DEC DE                        
  29E7:  4E            DB 0x4E                         ; 'N'
  29E8:  2A D6 40      LD HL,(0x40D6)                
  29EB:  DF            RST 18h                       
  29EC:  20 05         JR NZ,0x29F3                    ; -> 0x29F3
  29EE:  47            LD B,A                        
  29EF:  09            ADD HL,BC                     
  29F0:  22 D6 40      LD (0x40D6),HL                
  29F3:  E1            POP HL                        
  29F4:  C9            RET                           
  29F5:  2A B3 40      LD HL,(0x40B3)                
  29F8:  2B            DEC HL                        
  29F9:  46            DB 0x46                         ; 'F'
  29FA:  2B            DEC HL                        
  29FB:  4E            DB 0x4E                         ; 'N'
  29FC:  2B            DEC HL                        
  29FD:  DF            RST 18h                       
  29FE:  C0            RET NZ                        
  29FF:  22 B3 40      LD (0x40B3),HL                
  2A02:  C9            RET                           
  2A03:  01 F8 27      LD BC,0x27F8                  
  2A06:  C5            PUSH BC                       
  2A07:  CD D7 29      CALL 0x29D7                   
  2A0A:  AF            XOR A                         
  2A0B:  57            LD D,A                        
  2A0C:  7E            LD A,(HL)                     
  2A0D:  B7            OR A                          
  2A0E:  C9            RET                           
  2A0F:  01 F8 27      LD BC,0x27F8                  
  2A12:  C5            PUSH BC                       
  2A13:  CD 07 2A      CALL 0x2A07                   
  2A16:  CA 4A 1E      JP Z,0x1E4A                   
  2A19:  23            INC HL                        
  2A1A:  5E            DB 0x5E                         ; '^'
  2A1B:  23            INC HL                        
  2A1C:  56            DB 0x56                         ; 'V'
  2A1D:  1A            DB 0x1A                       
  2A1E:  C9            RET                           
  2A1F:  3E 01         LD A,0x01                     
  2A21:  CD 57 28      CALL 0x2857                   
  2A24:  CD 1F 2B      CALL 0x2B1F                   
  2A27:  2A D4 40      LD HL,(0x40D4)                
  2A2A:  73            LD (HL),E                     
  2A2B:  C1            POP BC                        
  2A2C:  C3 84 28      JP 0x2884                     
  2A2F:  D7            RST 10h                       
  2A30:  CF            RST 08h                       
  2A31:  28 CD         JR Z,0x2A00                     ; -> 0x2A00
  2A33:  1C            INC E                         
  2A34:  2B            DEC HL                        
  2A35:  D5            PUSH DE                       
  2A36:  CF            RST 08h                       
  2A37:  2C            INC L                         
  2A38:  CD 37 23      CALL BASIC_ARITH              
  2A3B:  CF            RST 08h                       
  2A3C:  29            ADD HL,HL                     
  2A3D:  E3            EX (SP),HL                    
  2A3E:  E5            PUSH HL                       
  2A3F:  E7            RST 20h                       
  2A40:  28 05         JR Z,0x2A47                     ; -> 0x2A47
  2A42:  CD 1F 2B      CALL 0x2B1F                   
  2A45:  18 03         JR 0x2A4A                       ; -> 0x2A4A
  2A47:  CD 13 2A      CALL 0x2A13                   
  2A4A:  D1            POP DE                        
  2A4B:  F5            PUSH AF                       
  2A4C:  F5            PUSH AF                       
  2A4D:  7B            LD A,E                        
  2A4E:  CD 57 28      CALL 0x2857                   
  2A51:  5F            LD E,A                        
  2A52:  F1            POP AF                        
  2A53:  1C            INC E                         
  2A54:  1D            DEC E                         
  2A55:  28 D4         JR Z,0x2A2B                     ; -> 0x2A2B
  2A57:  2A D4 40      LD HL,(0x40D4)                
  2A5A:  77            LD (HL),A                     
  2A5B:  23            INC HL                        
  2A5C:  1D            DEC E                         
  2A5D:  20 FB         JR NZ,0x2A5A                    ; -> 0x2A5A
  2A5F:  18 CA         JR 0x2A2B                       ; -> 0x2A2B
  2A61:  CD DF 2A      CALL 0x2ADF                   
  2A64:  AF            XOR A                         
  2A65:  E3            EX (SP),HL                    
  2A66:  4F            LD C,A                        
  2A67:  3E E5         LD A,0xE5                     
  2A69:  E5            PUSH HL                       
  2A6A:  7E            LD A,(HL)                     
  2A6B:  B8            CP B                          
  2A6C:  38 02         JR C,0x2A70                     ; -> 0x2A70
  2A6E:  78            LD A,B                        
  2A6F:  11 0E 00      LD DE,0x000E                  
  2A72:  C5            PUSH BC                       
  2A73:  CD BF 28      CALL 0x28BF                   
  2A76:  C1            POP BC                        
  2A77:  E1            POP HL                        
  2A78:  E5            PUSH HL                       
  2A79:  23            INC HL                        
  2A7A:  46            DB 0x46                         ; 'F'
  2A7B:  23            INC HL                        
  2A7C:  66            DB 0x66                         ; 'f'
  2A7D:  68            LD L,B                        
  2A7E:  06 00         LD B,0x00                     
  2A80:  09            ADD HL,BC                     
  2A81:  44            LD B,H                        
  2A82:  4D            LD C,L                        
  2A83:  CD 5A 28      CALL 0x285A                   
  2A86:  6F            LD L,A                        
  2A87:  CD CE 29      CALL 0x29CE                   
  2A8A:  D1            POP DE                        
  2A8B:  CD DE 29      CALL 0x29DE                   
  2A8E:  C3 84 28      JP 0x2884                     
  2A91:  CD DF 2A      CALL 0x2ADF                   
  2A94:  D1            POP DE                        
  2A95:  D5            PUSH DE                       
  2A96:  1A            DB 0x1A                       
  2A97:  90            SUB B                         
  2A98:  18 CB         JR 0x2A65                       ; -> 0x2A65
  2A9A:  EB            EX DE,HL                      
  2A9B:  7E            LD A,(HL)                     
  2A9C:  CD E2 2A      CALL 0x2AE2                   
  2A9F:  04            INC B                         
  2AA0:  05            DEC B                         
  2AA1:  CA 4A 1E      JP Z,0x1E4A                   
  2AA4:  C5            PUSH BC                       
  2AA5:  1E FF         LD E,0xFF                     
  2AA7:  FE 29         CP 0x29                       
  2AA9:  28 05         JR Z,0x2AB0                     ; -> 0x2AB0
  2AAB:  CF            RST 08h                       
  2AAC:  2C            INC L                         
  2AAD:  CD 1C 2B      CALL 0x2B1C                   
  2AB0:  CF            RST 08h                       
  2AB1:  29            ADD HL,HL                     
  2AB2:  F1            POP AF                        
  2AB3:  E3            EX (SP),HL                    
  2AB4:  01 69 2A      LD BC,0x2A69                  
  2AB7:  C5            PUSH BC                       
  2AB8:  3D            DEC A                         
  2AB9:  BE            DB 0xBE                       
  2ABA:  06 00         LD B,0x00                     
  2ABC:  D0            RET NC                        
  2ABD:  4F            LD C,A                        
  2ABE:  7E            LD A,(HL)                     
  2ABF:  91            DB 0x91                       
  2AC0:  BB            CP E                          
  2AC1:  47            LD B,A                        
  2AC2:  D8            RET C                         
  2AC3:  43            LD B,E                        
  2AC4:  C9            RET                           
  2AC5:  CD 07 2A      CALL 0x2A07                   
  2AC8:  CA F8 27      JP Z,0x27F8                   
  2ACB:  5F            LD E,A                        
  2ACC:  23            INC HL                        
  2ACD:  7E            LD A,(HL)                     
  2ACE:  23            INC HL                        
  2ACF:  66            DB 0x66                         ; 'f'
  2AD0:  6F            LD L,A                        
  2AD1:  E5            PUSH HL                       
  2AD2:  19            ADD HL,DE                     
  2AD3:  46            DB 0x46                         ; 'F'
  2AD4:  72            LD (HL),D                     
  2AD5:  E3            EX (SP),HL                    
  2AD6:  C5            PUSH BC                       
  2AD7:  7E            LD A,(HL)                     
  2AD8:  CD 65 0E      CALL 0x0E65                   
  2ADB:  C1            POP BC                        
  2ADC:  E1            POP HL                        
  2ADD:  70            LD (HL),B                     
  2ADE:  C9            RET                           
  2ADF:  EB            EX DE,HL                      
  2AE0:  CF            RST 08h                       
  2AE1:  29            ADD HL,HL                     
  2AE2:  C1            POP BC                        
  2AE3:  D1            POP DE                        
  2AE4:  C5            PUSH BC                       
  2AE5:  43            LD B,E                        
  2AE6:  C9            RET                           
  2AE7:  FE 7A         CP 0x7A                       
  2AE9:  C2 97 19      JP NZ,0x1997                  
  2AEC:  C3 D9 41      JP 0x41D9                     
  2AEF:  CD 1F 2B      CALL 0x2B1F                   
  2AF2:  32 94 40      LD (0x4094),A                   ; → RAM sistema
  2AF5:  CD 93 40      CALL 0x4093                   
  2AF8:  C3 F8 27      JP 0x27F8                     
  2AFB:  CD 0E 2B      CALL 0x2B0E                   
  2AFE:  C3 96 40      JP 0x4096                     
  2B01:  D7            RST 10h                       
  2B02:  CD 37 23      CALL BASIC_ARITH              
  2B05:  E5            PUSH HL                       
  2B06:  CD 7F 0A      CALL 0x0A7F                   
  2B09:  EB            EX DE,HL                      
  2B0A:  E1            POP HL                        
  2B0B:  7A            LD A,D                        
  2B0C:  B7            OR A                          
  2B0D:  C9            RET                           
  2B0E:  CD 1C 2B      CALL 0x2B1C                   
  2B11:  32 94 40      LD (0x4094),A                   ; → RAM sistema
  2B14:  32 97 40      LD (0x4097),A                   ; → RAM sistema
  2B17:  CF            RST 08h                       
  2B18:  2C            INC L                         
  2B19:  18 01         JR 0x2B1C                       ; -> 0x2B1C
  2B1B:  D7            RST 10h                       
  2B1C:  CD 37 23      CALL BASIC_ARITH              
  2B1F:  CD 05 2B      CALL 0x2B05                   
  2B22:  C2 4A 1E      JP NZ,0x1E4A                  
  2B25:  2B            DEC HL                        
  2B26:  D7            RST 10h                       
  2B27:  7B            LD A,E                        
  2B28:  C9            RET                           
  2B29:  3E 01         LD A,0x01                     
  2B2B:  32 9C 40      LD (0x409C),A                   ; → RAM sistema
  2B2E:  C1            POP BC                        
  2B2F:  CD 10 1B      CALL 0x1B10                   
  2B32:  C5            PUSH BC                       
  2B33:  21 FF FF      LD HL,0xFFFF                  
  2B36:  22 A2 40      LD (0x40A2),HL                
  2B39:  E1            POP HL                        
  2B3A:  D1            POP DE                        
  2B3B:  4E            DB 0x4E                         ; 'N'
  2B3C:  23            INC HL                        
  2B3D:  46            DB 0x46                         ; 'F'
  2B3E:  23            INC HL                        
  2B3F:  78            LD A,B                        
  2B40:  B1            OR C                          
  2B41:  CA 19 1A      JP Z,BASIC_MAIN_LOOP          
  2B44:  CD DF 41      CALL 0x41DF                   
  2B47:  CD 9B 1D      CALL 0x1D9B                   
  2B4A:  C5            PUSH BC                       
  2B4B:  4E            DB 0x4E                         ; 'N'
  2B4C:  23            INC HL                        
  2B4D:  46            DB 0x46                         ; 'F'
  2B4E:  23            INC HL                        
  2B4F:  C5            PUSH BC                       
  2B50:  E3            EX (SP),HL                    
  2B51:  EB            EX DE,HL                      
  2B52:  DF            RST 18h                       
  2B53:  C1            POP BC                        
  2B54:  DA 18 1A      JP C,0x1A18                   
  2B57:  E3            EX (SP),HL                    
  2B58:  E5            PUSH HL                       
  2B59:  C5            PUSH BC                       
  2B5A:  EB            EX DE,HL                      
  2B5B:  22 EC 40      LD (0x40EC),HL                
  2B5E:  CD AF 0F      CALL 0x0FAF                   
  2B61:  3E 20         LD A,0x20                     
  2B63:  E1            POP HL                        
  2B64:  CD 2A 03      CALL DISPLAY_CHAR             
  2B67:  CD 7E 2B      CALL 0x2B7E                   
  2B6A:  2A A7 40      LD HL,(0x40A7)                
  2B6D:  CD 75 2B      CALL 0x2B75                   
  2B70:  CD FE 20      CALL BASIC_PROMPT_LOOP        
  2B73:  18 BE         JR 0x2B33                       ; -> 0x2B33
  2B75:  7E            LD A,(HL)                     
  2B76:  B7            OR A                          
  2B77:  C8            RET Z                         
  2B78:  CD 2A 03      CALL DISPLAY_CHAR             
  2B7B:  23            INC HL                        
  2B7C:  18 F7         JR 0x2B75                       ; -> 0x2B75
  2B7E:  E5            PUSH HL                       
  2B7F:  2A A7 40      LD HL,(0x40A7)                
  2B82:  44            LD B,H                        
  2B83:  4D            LD C,L                        
  2B84:  E1            POP HL                        
  2B85:  16 FF         LD D,0xFF                     
  2B87:  18 03         JR 0x2B8C                       ; -> 0x2B8C
  2B89:  03            INC BC                        
  2B8A:  15            DEC D                         
  2B8B:  C8            RET Z                         
  2B8C:  7E            LD A,(HL)                     
  2B8D:  B7            OR A                          
  2B8E:  23            INC HL                        
  2B8F:  02            DB 0x02                       
  2B90:  C8            RET Z                         
  2B91:  F2 89 2B      JP P,0x2B89                   
  2B94:  FE FB         CP 0xFB                       
  2B96:  20 08         JR NZ,0x2BA0                    ; -> 0x2BA0
  2B98:  0B            DEC BC                        
  2B99:  0B            DEC BC                        
  2B9A:  0B            DEC BC                        
  2B9B:  0B            DEC BC                        
  2B9C:  14            INC D                         
  2B9D:  14            INC D                         
  2B9E:  14            INC D                         
  2B9F:  14            INC D                         
  2BA0:  FE 95         CP 0x95                       
  2BA2:  CC 24 0B      CALL Z,0x0B24                 
  2BA5:  D6 7F         SUB 0x7F                      
  2BA7:  E5            PUSH HL                       
  2BA8:  5F            LD E,A                        
  2BA9:  21 50 16      LD HL,0x1650                  
  2BAC:  7E            LD A,(HL)                     
  2BAD:  B7            OR A                          
  2BAE:  23            INC HL                        
  2BAF:  F2 AC 2B      JP P,0x2BAC                   
  2BB2:  1D            DEC E                         
  2BB3:  20 F7         JR NZ,0x2BAC                    ; -> 0x2BAC
  2BB5:  E6 7F         AND 0x7F                      
  2BB7:  02            DB 0x02                       
  2BB8:  03            INC BC                        
  2BB9:  15            DEC D                         
  2BBA:  CA D8 28      JP Z,0x28D8                   
  2BBD:  7E            LD A,(HL)                     
  2BBE:  23            INC HL                        
  2BBF:  B7            OR A                          
  2BC0:  F2 B7 2B      JP P,0x2BB7                   
  2BC3:  E1            POP HL                        
  2BC4:  18 C6         JR 0x2B8C                       ; -> 0x2B8C
  2BC6:  CD 10 1B      CALL 0x1B10                   
  2BC9:  D1            POP DE                        
  2BCA:  C5            PUSH BC                       
  2BCB:  C5            PUSH BC                       
  2BCC:  CD 2C 1B      CALL 0x1B2C                   
  2BCF:  30 05         JR NC,0x2BD6                    ; -> 0x2BD6
  2BD1:  54            LD D,H                        
  2BD2:  5D            LD E,L                        
  2BD3:  E3            EX (SP),HL                    
  2BD4:  E5            PUSH HL                       
  2BD5:  DF            RST 18h                       
  2BD6:  D2 4A 1E      JP NC,0x1E4A                  
  2BD9:  21 29 19      LD HL,0x1929                  
  2BDC:  CD A7 28      CALL PRINT_STRING             
  2BDF:  C1            POP BC                        
  2BE0:  21 E8 1A      LD HL,0x1AE8                  
  2BE3:  E3            EX (SP),HL                    
  2BE4:  EB            EX DE,HL                      
  2BE5:  2A F9 40      LD HL,(0x40F9)                
  2BE8:  1A            DB 0x1A                       
  2BE9:  02            DB 0x02                       
  2BEA:  03            INC BC                        
  2BEB:  13            INC DE                        
  2BEC:  DF            RST 18h                       
  2BED:  20 F9         JR NZ,0x2BE8                    ; -> 0x2BE8
  2BEF:  60            LD H,B                        
  2BF0:  69            LD L,C                        
  2BF1:  22 F9 40      LD (0x40F9),HL                
  2BF4:  C9            RET                           
  2BF5:  CD 84 02      CALL 0x0284                   
  2BF8:  CD 37 23      CALL BASIC_ARITH              
  2BFB:  E5            PUSH HL                       
  2BFC:  CD 13 2A      CALL 0x2A13                   
  2BFF:  3E D3         LD A,0xD3                     
  2C01:  CD 64 02      CALL SERIAL_SEND_1BIT         
  2C04:  CD 61 02      CALL 0x0261                   
  2C07:  1A            DB 0x1A                       
  2C08:  CD 64 02      CALL SERIAL_SEND_1BIT         
  2C0B:  2A A4 40      LD HL,(0x40A4)                
  2C0E:  EB            EX DE,HL                      
  2C0F:  2A F9 40      LD HL,(0x40F9)                
  2C12:  1A            DB 0x1A                       
  2C13:  13            INC DE                        
  2C14:  CD 64 02      CALL SERIAL_SEND_1BIT         
  2C17:  DF            RST 18h                       
  2C18:  20 F8         JR NZ,0x2C12                    ; -> 0x2C12
  2C1A:  CD F8 01      CALL 0x01F8                   
  2C1D:  E1            POP HL                        
  2C1E:  C9            RET                           
  2C1F:  D6 B2         SUB 0xB2                      
  2C21:  28 02         JR Z,0x2C25                     ; -> 0x2C25
  2C23:  AF            XOR A                         
  2C24:  01 2F 23      LD BC,0x232F                  
  2C27:  F5            PUSH AF                       
  2C28:  7E            LD A,(HL)                     
  2C29:  B7            OR A                          
  2C2A:  28 07         JR Z,0x2C33                     ; -> 0x2C33
  2C2C:  CD 37 23      CALL BASIC_ARITH              
  2C2F:  CD 13 2A      CALL 0x2A13                   
  2C32:  1A            DB 0x1A                       
  2C33:  6F            LD L,A                        
  2C34:  F1            POP AF                        
  2C35:  B7            OR A                          
  2C36:  67            LD H,A                        
  2C37:  22 21 41      LD (0x4121),HL                
  2C3A:  CC 4D 1B      CALL Z,HW_INIT_3              
  2C3D:  21 00 00      LD HL,0x0000                  
  2C40:  CD 93 02      CALL 0x0293                   
  2C43:  2A 21 41      LD HL,(0x4121)                
  2C46:  EB            EX DE,HL                      
  2C47:  06 03         LD B,0x03                     
  2C49:  CD 35 02      CALL SERIAL_SEND_8BITS        
  2C4C:  D6 D3         SUB 0xD3                      
  2C4E:  20 F7         JR NZ,0x2C47                    ; -> 0x2C47
  2C50:  10 F7         DJNZ 0x2C49                     ; loop para 0x2C49
  2C52:  CD 35 02      CALL SERIAL_SEND_8BITS        
  2C55:  1C            INC E                         
  2C56:  1D            DEC E                         
  2C57:  28 03         JR Z,0x2C5C                     ; -> 0x2C5C
  2C59:  BB            CP E                          
  2C5A:  20 37         JR NZ,0x2C93                    ; -> 0x2C93
  2C5C:  2A A4 40      LD HL,(0x40A4)                
  2C5F:  06 03         LD B,0x03                     
  2C61:  CD 35 02      CALL SERIAL_SEND_8BITS        
  2C64:  5F            LD E,A                        
  2C65:  96            DB 0x96                       
  2C66:  A2            AND D                         
  2C67:  20 21         JR NZ,0x2C8A                    ; -> 0x2C8A
  2C69:  73            LD (HL),E                     
  2C6A:  CD 6C 19      CALL 0x196C                   
  2C6D:  7E            LD A,(HL)                     
  2C6E:  B7            OR A                          
  2C6F:  23            INC HL                        
  2C70:  20 ED         JR NZ,0x2C5F                    ; -> 0x2C5F
  2C72:  CD 2C 02      CALL 0x022C                   
  2C75:  10 EA         DJNZ 0x2C61                     ; loop para 0x2C61
  2C77:  22 F9 40      LD (0x40F9),HL                
  2C7A:  21 29 19      LD HL,0x1929                  
  2C7D:  CD A7 28      CALL PRINT_STRING             
  2C80:  CD F8 01      CALL 0x01F8                   
  2C83:  2A A4 40      LD HL,(0x40A4)                
  2C86:  E5            PUSH HL                       
  2C87:  C3 E8 1A      JP 0x1AE8                     
  2C8A:  21 A5 2C      LD HL,0x2CA5                  
  2C8D:  CD A7 28      CALL PRINT_STRING             
  2C90:  C3 18 1A      JP 0x1A18                     
  2C93:  32 3E 3C      LD (vram_post_flag1),A          ; → VRAM
  2C96:  06 03         LD B,0x03                     
  2C98:  CD 35 02      CALL SERIAL_SEND_8BITS        
  2C9B:  B7            OR A                          
  2C9C:  20 F8         JR NZ,0x2C96                    ; -> 0x2C96
  2C9E:  10 F8         DJNZ 0x2C98                     ; loop para 0x2C98
  2CA0:  CD 96 02      CALL 0x0296                   
  2CA3:  18 A2         JR 0x2C47                       ; -> 0x2C47
  2CA5:  6E            DB 0x6E                         ; 'n'
  2CA6:  61            LD H,C                        
  2CA7:  6F            LD L,A                        
  2CA8:  0D            DEC C                         
  2CA9:  00            NOP                           
  2CAA:  CD 7F 0A      CALL 0x0A7F                   
  2CAD:  7E            LD A,(HL)                     
  2CAE:  C3 F8 27      JP 0x27F8                     
  2CB1:  CD 02 2B      CALL 0x2B02                   
  2CB4:  D5            PUSH DE                       
  2CB5:  CF            RST 08h                       
  2CB6:  2C            INC L                         
  2CB7:  CD 1C 2B      CALL 0x2B1C                   
  2CBA:  D1            POP DE                        
  2CBB:  12            DB 0x12                       
  2CBC:  C9            RET                           
  2CBD:  CD 38 23      CALL 0x2338                   
  2CC0:  CD F4 0A      CALL 0x0AF4                   
  2CC3:  CF            RST 08h                       
  2CC4:  3B            DEC SP                        
  2CC5:  EB            EX DE,HL                      
  2CC6:  2A 21 41      LD HL,(0x4121)                
  2CC9:  18 08         JR 0x2CD3                       ; -> 0x2CD3
  2CCB:  3A DE 40      LD A,(0x40DE)                 
  2CCE:  B7            OR A                          
  2CCF:  28 0C         JR Z,0x2CDD                     ; -> 0x2CDD
  2CD1:  D1            POP DE                        
  2CD2:  EB            EX DE,HL                      
  2CD3:  E5            PUSH HL                       
  2CD4:  AF            XOR A                         
  2CD5:  32 DE 40      LD (0x40DE),A                   ; → RAM sistema
  2CD8:  BA            CP D                          
  2CD9:  F5            PUSH AF                       
  2CDA:  D5            PUSH DE                       
  2CDB:  46            DB 0x46                         ; 'F'
  2CDC:  B0            OR B                          
  2CDD:  CA 4A 1E      JP Z,0x1E4A                   
  2CE0:  23            INC HL                        
  2CE1:  4E            DB 0x4E                         ; 'N'
  2CE2:  23            INC HL                        
  2CE3:  66            DB 0x66                         ; 'f'
  2CE4:  69            LD L,C                        
  2CE5:  18 1C         JR 0x2D03                       ; -> 0x2D03
  2CE7:  58            LD E,B                        
  2CE8:  E5            PUSH HL                       
  2CE9:  0E 02         LD C,0x02                     
  2CEB:  7E            LD A,(HL)                     
  2CEC:  23            INC HL                        
  2CED:  FE 25         CP 0x25                       
  2CEF:  CA 17 2E      JP Z,0x2E17                   
  2CF2:  FE 20         CP 0x20                       
  2CF4:  20 03         JR NZ,0x2CF9                    ; -> 0x2CF9
  2CF6:  0C            INC C                         
  2CF7:  10 F2         DJNZ 0x2CEB                     ; loop para 0x2CEB
  2CF9:  E1            POP HL                        
  2CFA:  43            LD B,E                        
  2CFB:  3E 25         LD A,0x25                     
  2CFD:  CD 49 2E      CALL 0x2E49                   
  2D00:  CD 2A 03      CALL DISPLAY_CHAR             
  2D03:  AF            XOR A                         
  2D04:  5F            LD E,A                        
  2D05:  57            LD D,A                        
  2D06:  CD 49 2E      CALL 0x2E49                   
  2D09:  57            LD D,A                        
  2D0A:  7E            LD A,(HL)                     
  2D0B:  23            INC HL                        
  2D0C:  FE 21         CP 0x21                       
  2D0E:  CA 14 2E      JP Z,0x2E14                   
  2D11:  FE 23         CP 0x23                       
  2D13:  28 37         JR Z,0x2D4C                     ; -> 0x2D4C
  2D15:  05            DEC B                         
  2D16:  CA FE 2D      JP Z,0x2DFE                   
  2D19:  FE 2B         CP 0x2B                       
  2D1B:  3E 08         LD A,0x08                     
  2D1D:  28 E7         JR Z,0x2D06                     ; -> 0x2D06
  2D1F:  2B            DEC HL                        
  2D20:  7E            LD A,(HL)                     
  2D21:  23            INC HL                        
  2D22:  FE 2E         CP 0x2E                       
  2D24:  28 40         JR Z,0x2D66                     ; -> 0x2D66
  2D26:  FE 25         CP 0x25                       
  2D28:  28 BD         JR Z,0x2CE7                     ; -> 0x2CE7
  2D2A:  BE            DB 0xBE                       
  2D2B:  20 D0         JR NZ,0x2CFD                    ; -> 0x2CFD
  2D2D:  FE 24         CP 0x24                       
  2D2F:  28 14         JR Z,0x2D45                     ; -> 0x2D45
  2D31:  FE 2A         CP 0x2A                       
  2D33:  20 C8         JR NZ,0x2CFD                    ; -> 0x2CFD
  2D35:  78            LD A,B                        
  2D36:  FE 02         CP 0x02                       
  2D38:  23            INC HL                        
  2D39:  38 03         JR C,0x2D3E                     ; -> 0x2D3E
  2D3B:  7E            LD A,(HL)                     
  2D3C:  FE 24         CP 0x24                       
  2D3E:  3E 20         LD A,0x20                     
  2D40:  20 07         JR NZ,0x2D49                    ; -> 0x2D49
  2D42:  05            DEC B                         
  2D43:  1C            INC E                         
  2D44:  FE AF         CP 0xAF                       
  2D46:  C6 10         ADD A,0x10                    
  2D48:  23            INC HL                        
  2D49:  1C            INC E                         
  2D4A:  82            ADD A,D                       
  2D4B:  57            LD D,A                        
  2D4C:  1C            INC E                         
  2D4D:  0E 00         LD C,0x00                     
  2D4F:  05            DEC B                         
  2D50:  28 47         JR Z,0x2D99                     ; -> 0x2D99
  2D52:  7E            LD A,(HL)                     
  2D53:  23            INC HL                        
  2D54:  FE 2E         CP 0x2E                       
  2D56:  28 18         JR Z,0x2D70                     ; -> 0x2D70
  2D58:  FE 23         CP 0x23                       
  2D5A:  28 F0         JR Z,0x2D4C                     ; -> 0x2D4C
  2D5C:  FE 2C         CP 0x2C                       
  2D5E:  20 1A         JR NZ,0x2D7A                    ; -> 0x2D7A
  2D60:  7A            LD A,D                        
  2D61:  F6 40         OR 0x40                       
  2D63:  57            LD D,A                        
  2D64:  18 E6         JR 0x2D4C                       ; -> 0x2D4C
  2D66:  7E            LD A,(HL)                     
  2D67:  FE 23         CP 0x23                       
  2D69:  3E 2E         LD A,0x2E                     
  2D6B:  20 90         JR NZ,0x2CFD                    ; -> 0x2CFD
  2D6D:  0E 01         LD C,0x01                     
  2D6F:  23            INC HL                        
  2D70:  0C            INC C                         
  2D71:  05            DEC B                         
  2D72:  28 25         JR Z,0x2D99                     ; -> 0x2D99
  2D74:  7E            LD A,(HL)                     
  2D75:  23            INC HL                        
  2D76:  FE 23         CP 0x23                       
  2D78:  28 F6         JR Z,0x2D70                     ; -> 0x2D70
  2D7A:  D5            PUSH DE                       
  2D7B:  11 97 2D      LD DE,0x2D97                  
  2D7E:  D5            PUSH DE                       
  2D7F:  54            LD D,H                        
  2D80:  5D            LD E,L                        
  2D81:  FE 5B         CP 0x5B                       
  2D83:  C0            RET NZ                        
  2D84:  BE            DB 0xBE                       
  2D85:  C0            RET NZ                        
  2D86:  23            INC HL                        
  2D87:  BE            DB 0xBE                       
  2D88:  C0            RET NZ                        
  2D89:  23            INC HL                        
  2D8A:  BE            DB 0xBE                       
  2D8B:  C0            RET NZ                        
  2D8C:  23            INC HL                        
  2D8D:  78            LD A,B                        
  2D8E:  D6 04         SUB 0x04                      
  2D90:  D8            RET C                         
  2D91:  D1            POP DE                        
  2D92:  D1            POP DE                        
  2D93:  47            LD B,A                        
  2D94:  14            INC D                         
  2D95:  23            INC HL                        
  2D96:  CA EB D1      JP Z,0xD1EB                   
  2D99:  7A            LD A,D                        
  2D9A:  2B            DEC HL                        
  2D9B:  1C            INC E                         
  2D9C:  E6 08         AND 0x08                      
  2D9E:  20 15         JR NZ,0x2DB5                    ; -> 0x2DB5
  2DA0:  1D            DEC E                         
  2DA1:  78            LD A,B                        
  2DA2:  B7            OR A                          
  2DA3:  28 10         JR Z,0x2DB5                     ; -> 0x2DB5
  2DA5:  7E            LD A,(HL)                     
  2DA6:  D6 2D         SUB 0x2D                      
  2DA8:  28 06         JR Z,0x2DB0                     ; -> 0x2DB0
  2DAA:  FE FE         CP 0xFE                       
  2DAC:  20 07         JR NZ,0x2DB5                    ; -> 0x2DB5
  2DAE:  3E 08         LD A,0x08                     
  2DB0:  C6 04         ADD A,0x04                    
  2DB2:  82            ADD A,D                       
  2DB3:  57            LD D,A                        
  2DB4:  05            DEC B                         
  2DB5:  E1            POP HL                        
  2DB6:  F1            POP AF                        
  2DB7:  28 50         JR Z,0x2E09                     ; -> 0x2E09
  2DB9:  C5            PUSH BC                       
  2DBA:  D5            PUSH DE                       
  2DBB:  CD 37 23      CALL BASIC_ARITH              
  2DBE:  D1            POP DE                        
  2DBF:  C1            POP BC                        
  2DC0:  C5            PUSH BC                       
  2DC1:  E5            PUSH HL                       
  2DC2:  43            LD B,E                        
  2DC3:  78            LD A,B                        
  2DC4:  81            ADD A,C                       
  2DC5:  FE 19         CP 0x19                       
  2DC7:  D2 4A 1E      JP NC,0x1E4A                  
  2DCA:  7A            LD A,D                        
  2DCB:  F6 80         OR 0x80                       
  2DCD:  CD BE 0F      CALL 0x0FBE                   
  2DD0:  CD A7 28      CALL PRINT_STRING             
  2DD3:  E1            POP HL                        
  2DD4:  2B            DEC HL                        
  2DD5:  D7            RST 10h                       
  2DD6:  37            SCF                           
  2DD7:  28 0D         JR Z,0x2DE6                     ; -> 0x2DE6
  2DD9:  32 DE 40      LD (0x40DE),A                   ; → RAM sistema
  2DDC:  FE 3B         CP 0x3B                       
  2DDE:  28 05         JR Z,0x2DE5                     ; -> 0x2DE5
  2DE0:  FE 2C         CP 0x2C                       
  2DE2:  C2 97 19      JP NZ,0x1997                  
  2DE5:  D7            RST 10h                       
  2DE6:  C1            POP BC                        
  2DE7:  EB            EX DE,HL                      
  2DE8:  E1            POP HL                        
  2DE9:  E5            PUSH HL                       
  2DEA:  F5            PUSH AF                       
  2DEB:  D5            PUSH DE                       
  2DEC:  7E            LD A,(HL)                     
  2DED:  90            SUB B                         
  2DEE:  23            INC HL                        
  2DEF:  4E            DB 0x4E                         ; 'N'
  2DF0:  23            INC HL                        
  2DF1:  66            DB 0x66                         ; 'f'
  2DF2:  69            LD L,C                        
  2DF3:  16 00         LD D,0x00                     
  2DF5:  5F            LD E,A                        
  2DF6:  19            ADD HL,DE                     
  2DF7:  78            LD A,B                        
  2DF8:  B7            OR A                          
  2DF9:  C2 03 2D      JP NZ,0x2D03                  
  2DFC:  18 06         JR 0x2E04                       ; -> 0x2E04
  2DFE:  CD 49 2E      CALL 0x2E49                   
  2E01:  CD 2A 03      CALL DISPLAY_CHAR             
  2E04:  E1            POP HL                        
  2E05:  F1            POP AF                        
  2E06:  C2 CB 2C      JP NZ,0x2CCB                  
  2E09:  DC FE 20      CALL C,BASIC_PROMPT_LOOP      
  2E0C:  E3            EX (SP),HL                    
  2E0D:  CD DD 29      CALL 0x29DD                   
  2E10:  E1            POP HL                        
  2E11:  C3 69 21      JP 0x2169                     
  2E14:  0E 01         LD C,0x01                     
  2E16:  3E F1         LD A,0xF1                     
  2E18:  05            DEC B                         
  2E19:  CD 49 2E      CALL 0x2E49                   
  2E1C:  E1            POP HL                        
  2E1D:  F1            POP AF                        
  2E1E:  28 E9         JR Z,0x2E09                     ; -> 0x2E09
  2E20:  C5            PUSH BC                       
  2E21:  CD 37 23      CALL BASIC_ARITH              
  2E24:  CD F4 0A      CALL 0x0AF4                   
  2E27:  C1            POP BC                        
  2E28:  C5            PUSH BC                       
  2E29:  E5            PUSH HL                       
  2E2A:  2A 21 41      LD HL,(0x4121)                
  2E2D:  41            LD B,C                        
  2E2E:  0E 00         LD C,0x00                     
  2E30:  C5            PUSH BC                       
  2E31:  CD 68 2A      CALL 0x2A68                   
  2E34:  CD AA 28      CALL 0x28AA                   
  2E37:  2A 21 41      LD HL,(0x4121)                
  2E3A:  F1            POP AF                        
  2E3B:  96            DB 0x96                       
  2E3C:  47            LD B,A                        
  2E3D:  3E 20         LD A,0x20                     
  2E3F:  04            INC B                         
  2E40:  05            DEC B                         
  2E41:  CA D3 2D      JP Z,0x2DD3                   
  2E44:  CD 2A 03      CALL DISPLAY_CHAR             
  2E47:  18 F7         JR 0x2E40                       ; -> 0x2E40
  2E49:  F5            PUSH AF                       
  2E4A:  7A            LD A,D                        
  2E4B:  B7            OR A                          
  2E4C:  3E 2B         LD A,0x2B                     
  2E4E:  C4 2A 03      CALL NZ,DISPLAY_CHAR          
  2E51:  F1            POP AF                        
  2E52:  C9            RET                           
  2E53:  32 9A 40      LD (0x409A),A                   ; → RAM sistema
  2E56:  2A EA 40      LD HL,(0x40EA)                
  2E59:  B4            OR H                          
  2E5A:  A5            AND L                         
  2E5B:  3C            INC A                         
  2E5C:  EB            EX DE,HL                      
  2E5D:  C8            RET Z                         
  2E5E:  18 04         JR 0x2E64                       ; -> 0x2E64
  2E60:  CD 4F 1E      CALL 0x1E4F                   
  2E63:  C0            RET NZ                        
  2E64:  E1            POP HL                        
  2E65:  EB            EX DE,HL                      
  2E66:  22 EC 40      LD (0x40EC),HL                
  2E69:  EB            EX DE,HL                      
  2E6A:  CD 2C 1B      CALL 0x1B2C                   
  2E6D:  D2 D9 1E      JP NC,0x1ED9                  
  2E70:  60            LD H,B                        
  2E71:  69            LD L,C                        
  2E72:  23            INC HL                        
  2E73:  23            INC HL                        
  2E74:  4E            DB 0x4E                         ; 'N'
  2E75:  23            INC HL                        
  2E76:  46            DB 0x46                         ; 'F'
  2E77:  23            INC HL                        
  2E78:  C5            PUSH BC                       
  2E79:  CD 7E 2B      CALL 0x2B7E                   
  2E7C:  E1            POP HL                        
  2E7D:  E5            PUSH HL                       
  2E7E:  CD AF 0F      CALL 0x0FAF                   
  2E81:  3E 20         LD A,0x20                     
  2E83:  CD 2A 03      CALL DISPLAY_CHAR             
  2E86:  2A A7 40      LD HL,(0x40A7)                
  2E89:  3E 0E         LD A,0x0E                     
  2E8B:  CD 2A 03      CALL DISPLAY_CHAR             
  2E8E:  E5            PUSH HL                       
  2E8F:  0E FF         LD C,0xFF                     
  2E91:  0C            INC C                         
  2E92:  7E            LD A,(HL)                     
  2E93:  B7            OR A                          
  2E94:  23            INC HL                        
  2E95:  20 FA         JR NZ,0x2E91                    ; -> 0x2E91
  2E97:  E1            POP HL                        
  2E98:  47            LD B,A                        
  2E99:  16 00         LD D,0x00                     
  2E9B:  CD 84 03      CALL 0x0384                   
  2E9E:  D6 30         SUB 0x30                      
  2EA0:  38 0E         JR C,0x2EB0                     ; -> 0x2EB0
  2EA2:  FE 0A         CP 0x0A                       
  2EA4:  30 0A         JR NC,0x2EB0                    ; -> 0x2EB0
  2EA6:  5F            LD E,A                        
  2EA7:  7A            LD A,D                        
  2EA8:  07            RLCA                          
  2EA9:  07            RLCA                          
  2EAA:  82            ADD A,D                       
  2EAB:  07            RLCA                          
  2EAC:  83            ADD A,E                       
  2EAD:  57            LD D,A                        
  2EAE:  18 EB         JR 0x2E9B                       ; -> 0x2E9B
  2EB0:  E5            PUSH HL                       
  2EB1:  21 99 2E      LD HL,0x2E99                  
  2EB4:  E3            EX (SP),HL                    
  2EB5:  15            DEC D                         
  2EB6:  14            INC D                         
  2EB7:  C2 BB 2E      JP NZ,0x2EBB                  
  2EBA:  14            INC D                         
  2EBB:  FE D8         CP 0xD8                       
  2EBD:  CA D2 2F      JP Z,0x2FD2                   
  2EC0:  FE DD         CP 0xDD                       
  2EC2:  CA E0 2F      JP Z,0x2FE0                   
  2EC5:  FE F0         CP 0xF0                       
  2EC7:  28 41         JR Z,0x2F0A                     ; -> 0x2F0A
  2EC9:  FE 31         CP 0x31                       
  2ECB:  38 02         JR C,0x2ECF                     ; -> 0x2ECF
  2ECD:  D6 20         SUB 0x20                      
  2ECF:  FE 21         CP 0x21                       
  2ED1:  CA F6 2F      JP Z,0x2FF6                   
  2ED4:  FE 1C         CP 0x1C                       
  2ED6:  CA 40 2F      JP Z,0x2F40                   
  2ED9:  FE 23         CP 0x23                       
  2EDB:  28 3F         JR Z,0x2F1C                     ; -> 0x2F1C
  2EDD:  FE 19         CP 0x19                       
  2EDF:  CA 7D 2F      JP Z,0x2F7D                   
  2EE2:  FE 14         CP 0x14                       
  2EE4:  CA 4A 2F      JP Z,0x2F4A                   
  2EE7:  FE 13         CP 0x13                       
  2EE9:  CA 65 2F      JP Z,0x2F65                   
  2EEC:  FE 15         CP 0x15                       
  2EEE:  CA E3 2F      JP Z,0x2FE3                   
  2EF1:  FE 28         CP 0x28                       
  2EF3:  CA 78 2F      JP Z,0x2F78                   
  2EF6:  FE 1B         CP 0x1B                       
  2EF8:  28 1C         JR Z,0x2F16                     ; -> 0x2F16
  2EFA:  FE 18         CP 0x18                       
  2EFC:  CA 75 2F      JP Z,0x2F75                   
  2EFF:  FE 11         CP 0x11                       
  2F01:  C0            RET NZ                        
  2F02:  C1            POP BC                        
  2F03:  D1            POP DE                        
  2F04:  CD FE 20      CALL BASIC_PROMPT_LOOP        
  2F07:  C3 65 2E      JP 0x2E65                     
  2F0A:  7E            LD A,(HL)                     
  2F0B:  B7            OR A                          
  2F0C:  C8            RET Z                         
  2F0D:  04            INC B                         
  2F0E:  CD 2A 03      CALL DISPLAY_CHAR             
  2F11:  23            INC HL                        
  2F12:  15            DEC D                         
  2F13:  20 F5         JR NZ,0x2F0A                    ; -> 0x2F0A
  2F15:  C9            RET                           
  2F16:  E5            PUSH HL                       
  2F17:  21 5F 2F      LD HL,0x2F5F                  
  2F1A:  E3            EX (SP),HL                    
  2F1B:  37            SCF                           
  2F1C:  F5            PUSH AF                       
  2F1D:  CD 84 03      CALL 0x0384                   
  2F20:  5F            LD E,A                        
  2F21:  F1            POP AF                        
  2F22:  F5            PUSH AF                       
  2F23:  DC 5F 2F      CALL C,0x2F5F                 
  2F26:  7E            LD A,(HL)                     
  2F27:  B7            OR A                          
  2F28:  CA 3E 2F      JP Z,0x2F3E                   
  2F2B:  CD 2A 03      CALL DISPLAY_CHAR             
  2F2E:  F1            POP AF                        
  2F2F:  F5            PUSH AF                       
  2F30:  DC A1 2F      CALL C,0x2FA1                 
  2F33:  38 02         JR C,0x2F37                     ; -> 0x2F37
  2F35:  23            INC HL                        
  2F36:  04            INC B                         
  2F37:  7E            LD A,(HL)                     
  2F38:  BB            CP E                          
  2F39:  20 EB         JR NZ,0x2F26                    ; -> 0x2F26
  2F3B:  15            DEC D                         
  2F3C:  20 E8         JR NZ,0x2F26                    ; -> 0x2F26
  2F3E:  F1            POP AF                        
  2F3F:  C9            RET                           
  2F40:  CD 75 2B      CALL 0x2B75                   
  2F43:  CD FE 20      CALL BASIC_PROMPT_LOOP        
  2F46:  C1            POP BC                        
  2F47:  C3 7C 2E      JP 0x2E7C                     
  2F4A:  7E            LD A,(HL)                     
  2F4B:  B7            OR A                          
  2F4C:  C8            RET Z                         
  2F4D:  3E 21         LD A,0x21                     
  2F4F:  CD 2A 03      CALL DISPLAY_CHAR             
  2F52:  7E            LD A,(HL)                     
  2F53:  B7            OR A                          
  2F54:  28 09         JR Z,0x2F5F                     ; -> 0x2F5F
  2F56:  CD 2A 03      CALL DISPLAY_CHAR             
  2F59:  CD A1 2F      CALL 0x2FA1                   
  2F5C:  15            DEC D                         
  2F5D:  20 F3         JR NZ,0x2F52                    ; -> 0x2F52
  2F5F:  3E 21         LD A,0x21                     
  2F61:  CD 2A 03      CALL DISPLAY_CHAR             
  2F64:  C9            RET                           
  2F65:  7E            LD A,(HL)                     
  2F66:  B7            OR A                          
  2F67:  C8            RET Z                         
  2F68:  CD 84 03      CALL 0x0384                   
  2F6B:  77            LD (HL),A                     
  2F6C:  CD 2A 03      CALL DISPLAY_CHAR             
  2F6F:  23            INC HL                        
  2F70:  04            INC B                         
  2F71:  15            DEC D                         
  2F72:  20 F1         JR NZ,0x2F65                    ; -> 0x2F65
  2F74:  C9            RET                           
  2F75:  36 00         LD (HL),0x00                  
  2F77:  48            LD C,B                        
  2F78:  16 FF         LD D,0xFF                     
  2F7A:  CD 0A 2F      CALL 0x2F0A                   
  2F7D:  CD 84 03      CALL 0x0384                   
  2F80:  B7            OR A                          
  2F81:  CA 7D 2F      JP Z,0x2F7D                   
  2F84:  FE 08         CP 0x08                       
  2F86:  28 0A         JR Z,0x2F92                     ; -> 0x2F92
  2F88:  FE 0D         CP 0x0D                       
  2F8A:  CA E0 2F      JP Z,0x2FE0                   
  2F8D:  FE 1B         CP 0x1B                       
  2F8F:  C8            RET Z                         
  2F90:  20 1E         JR NZ,0x2FB0                    ; -> 0x2FB0
  2F92:  3E 08         LD A,0x08                     
  2F94:  05            DEC B                         
  2F95:  04            INC B                         
  2F96:  28 1F         JR Z,0x2FB7                     ; -> 0x2FB7
  2F98:  CD 2A 03      CALL DISPLAY_CHAR             
  2F9B:  2B            DEC HL                        
  2F9C:  05            DEC B                         
  2F9D:  11 7D 2F      LD DE,0x2F7D                  
  2FA0:  D5            PUSH DE                       
  2FA1:  E5            PUSH HL                       
  2FA2:  0D            DEC C                         
  2FA3:  7E            LD A,(HL)                     
  2FA4:  B7            OR A                          
  2FA5:  37            SCF                           
  2FA6:  CA 90 08      JP Z,0x0890                   
  2FA9:  23            INC HL                        
  2FAA:  7E            LD A,(HL)                     
  2FAB:  2B            DEC HL                        
  2FAC:  77            LD (HL),A                     
  2FAD:  23            INC HL                        
  2FAE:  18 F3         JR 0x2FA3                       ; -> 0x2FA3
  2FB0:  F5            PUSH AF                       
  2FB1:  79            LD A,C                        
  2FB2:  FE FF         CP 0xFF                       
  2FB4:  38 03         JR C,0x2FB9                     ; -> 0x2FB9
  2FB6:  F1            POP AF                        
  2FB7:  18 C4         JR 0x2F7D                       ; -> 0x2F7D
  2FB9:  90            SUB B                         
  2FBA:  0C            INC C                         
  2FBB:  04            INC B                         
  2FBC:  C5            PUSH BC                       
  2FBD:  EB            EX DE,HL                      
  2FBE:  6F            LD L,A                        
  2FBF:  26 00         LD H,0x00                     
  2FC1:  19            ADD HL,DE                     
  2FC2:  44            LD B,H                        
  2FC3:  4D            LD C,L                        
  2FC4:  23            INC HL                        
  2FC5:  CD 58 19      CALL 0x1958                   
  2FC8:  C1            POP BC                        
  2FC9:  F1            POP AF                        
  2FCA:  77            LD (HL),A                     
  2FCB:  CD 2A 03      CALL DISPLAY_CHAR             
  2FCE:  23            INC HL                        
  2FCF:  C3 7D 2F      JP 0x2F7D                     
  2FD2:  78            LD A,B                        
  2FD3:  B7            OR A                          
  2FD4:  C8            RET Z                         
  2FD5:  05            DEC B                         
  2FD6:  2B            DEC HL                        
  2FD7:  3E 08         LD A,0x08                     
  2FD9:  CD 2A 03      CALL DISPLAY_CHAR             
  2FDC:  15            DEC D                         
  2FDD:  20 F3         JR NZ,0x2FD2                    ; -> 0x2FD2
  2FDF:  C9            RET                           
  2FE0:  CD 75 2B      CALL 0x2B75                   
  2FE3:  CD FE 20      CALL BASIC_PROMPT_LOOP        
  2FE6:  C1            POP BC                        
  2FE7:  D1            POP DE                        
  2FE8:  7A            LD A,D                        
  2FE9:  A3            AND E                         
  2FEA:  3C            INC A                         
  2FEB:  2A A7 40      LD HL,(0x40A7)                
  2FEE:  2B            DEC HL                        
  2FEF:  C8            RET Z                         
  2FF0:  37            SCF                           
  2FF1:  23            INC HL                        
  2FF2:  F5            PUSH AF                       
  2FF3:  C3 98 1A      JP 0x1A98                     
  2FF6:  C1            POP BC                        
  2FF7:  D1            POP DE                        
  2FF8:  C3 19 1A      JP BASIC_MAIN_LOOP            
  2FFB:  DE C3         SBC A,0xC3                    
  2FFD:  C3 44 B2      JP 0xB244                     
  3000:  C3 36 30      JP 0x3036                     
  3003:  AE            DB 0xAE                       
  3004:  A3            AND E                         
  3005:  73            LD (HL),E                     
  3006:  28 05         JR Z,0x300D                     ; -> 0x300D
  3008:  DD 36 05 00   LD (IX+5),0x00                
  300C:  C9            RET                           
  300D:  B3            OR E                          
  300E:  C8            RET Z                         
  300F:  3A 99 40      LD A,(0x4099)                 
  3012:  B7            OR A                          
  3013:  28 02         JR Z,0x3017                     ; -> 0x3017
  3015:  AF            XOR A                         
  3016:  C9            RET                           
  3017:  3D            DEC A                         
  3018:  20 FD         JR NZ,0x3017                    ; -> 0x3017
  301A:  DD 35 05      DEC (IX+5)                    
  301D:  20 F6         JR NZ,0x3015                    ; -> 0x3015
  301F:  DD 34 05      INC (IX+5)                    
  3022:  B3            OR E                          
  3023:  C9            RET                           
  3024:  C3 95 30      JP 0x3095                     
  3027:  C3 8F 30      JP 0x308F                     
  302A:  C3 A7 35      JP 0x35A7                     
  302D:  C3 AE 35      JP 0x35AE                     
  3030:  C3 0D 34      JP 0x340D                     
  3033:  C3 EA 30      JP 0x30EA                     
  3036:  21 24 30      LD HL,0x3024                  
  3039:  11 00 40      LD DE,RST_JTABLE                ; ← RAM sistema
  303C:  01 12 00      LD BC,0x0012                  
  303F:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  3041:  31 C7 42      LD SP,0x42C7                  
  3044:  ED 73 DB 42   LD (0x42DB),SP                
  3048:  21 E0 34      LD HL,0x34E0                  
  304B:  CD 9D 30      CALL STORAGE_ACCESS           
  304E:  F3            DI                            
  304F:  21 4E 30      LD HL,0x304E                  
  3052:  22 0D 40      LD (0x400D),HL                
  3055:  31 C7 42      LD SP,0x42C7                  
  3058:  CD F8 01      CALL 0x01F8                   
  305B:  21 E4 34      LD HL,0x34E4                  
  305E:  CD 9D 30      CALL STORAGE_ACCESS           
  3061:  D7            RST 10h                       
  3062:  FE 1F         CP 0x1F                       
  3064:  28 D0         JR Z,0x3036                     ; -> 0x3036
  3066:  FE 41         CP 0x41                       
  3068:  38 F7         JR C,0x3061                     ; -> 0x3061
  306A:  E6 DF         AND 0xDF                      
  306C:  FE 5B         CP 0x5B                       
  306E:  30 F1         JR NC,0x3061                    ; -> 0x3061
  3070:  CF            RST 08h                       
  3071:  D6 41         SUB 0x41                      
  3073:  07            RLCA                          
  3074:  21 4E 30      LD HL,0x304E                  
  3077:  E5            PUSH HL                       
  3078:  21 6F 35      LD HL,0x356F                  
  307B:  85            ADD A,L                       
  307C:  6F            LD L,A                        
  307D:  7C            LD A,H                        
  307E:  CE 00         ADC A,0x00                    
  3080:  67            LD H,A                        
  3081:  5E            DB 0x5E                         ; '^'
  3082:  23            INC HL                        
  3083:  66            DB 0x66                         ; 'f'
  3084:  6B            LD L,E                        
  3085:  3E C1         LD A,0xC1                     
  3087:  CF            RST 08h                       
  3088:  E9            JP (HL)                       
  3089:  CD 5B 03      CALL 0x035B                   
  308C:  FE 60         CP 0x60                       
  308E:  C0            RET NZ                        
  308F:  D5            PUSH DE                       
  3090:  CD 49 00      CALL 0x0049                   
  3093:  D1            POP DE                        
  3094:  C9            RET                           
  3095:  D5            PUSH DE                       
  3096:  F5            PUSH AF                       
  3097:  CD 33 00      CALL 0x0033                   
  309A:  F1            POP AF                        
  309B:  D1            POP DE                        
  309C:  C9            RET                           
STORAGE_ACCESS:
  309D:  E5            PUSH HL                       
  309E:  7E            LD A,(HL)                     
  309F:  23            INC HL                        
  30A0:  CF            RST 08h                       
  30A1:  B7            OR A                          
  30A2:  20 FA         JR NZ,0x309E                    ; -> 0x309E
  30A4:  E1            POP HL                        
  30A5:  C9            RET                           
  30A6:  7C            LD A,H                        
  30A7:  CD AB 30      CALL 0x30AB                   
  30AA:  7D            LD A,L                        
  30AB:  F5            PUSH AF                       
  30AC:  0F            RRCA                          
  30AD:  0F            RRCA                          
  30AE:  0F            RRCA                          
  30AF:  0F            RRCA                          
  30B0:  CD B4 30      CALL 0x30B4                   
  30B3:  F1            POP AF                        
  30B4:  E6 0F         AND 0x0F                      
  30B6:  C6 90         ADD A,0x90                    
  30B8:  27            DAA                           
  30B9:  CE 40         ADC A,0x40                    
  30BB:  27            DAA                           
  30BC:  CF            RST 08h                       
  30BD:  C9            RET                           
  30BE:  06 07         LD B,0x07                     
  30C0:  21 E8 41      LD HL,0x41E8                    ; ← RAM sistema
  30C3:  CD D9 05      CALL 0x05D9                   
  30C6:  3E 0E         LD A,0x0E                     
  30C8:  CF            RST 08h                       
  30C9:  C9            RET                           
  30CA:  11 00 40      LD DE,RST_JTABLE                ; ← RAM sistema
  30CD:  01 12 00      LD BC,0x0012                  
  30D0:  21 D2 06      LD HL,0x06D2                  
  30D3:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  30D5:  CD C9 01      CALL HW_INIT_2                
  30D8:  C3 CC 06      JP 0x06CC                     
  30DB:  CD 38 31      CALL 0x3138                   
  30DE:  F5            PUSH AF                       
  30DF:  EB            EX DE,HL                      
  30E0:  CD 38 31      CALL 0x3138                   
  30E3:  EB            EX DE,HL                      
  30E4:  E3            EX (SP),HL                    
  30E5:  BC            CP H                          
  30E6:  E1            POP HL                        
  30E7:  C8            RET Z                         
  30E8:  18 56         JR 0x3140                       ; -> 0x3140
  30EA:  E5            PUSH HL                       
  30EB:  C5            PUSH BC                       
  30EC:  AF            XOR A                         
  30ED:  47            LD B,A                        
  30EE:  6F            LD L,A                        
  30EF:  67            LD H,A                        
  30F0:  D7            RST 10h                       
  30F1:  FE 20         CP 0x20                       
  30F3:  28 20         JR Z,0x3115                     ; -> 0x3115
  30F5:  D6 30         SUB 0x30                      
  30F7:  38 F7         JR C,0x30F0                     ; -> 0x30F0
  30F9:  FE 0A         CP 0x0A                       
  30FB:  38 0C         JR C,0x3109                     ; -> 0x3109
  30FD:  E6 DF         AND 0xDF                      
  30FF:  D6 07         SUB 0x07                      
  3101:  FE 0A         CP 0x0A                       
  3103:  38 EB         JR C,0x30F0                     ; -> 0x30F0
  3105:  FE 10         CP 0x10                       
  3107:  30 E7         JR NC,0x30F0                    ; -> 0x30F0
  3109:  04            INC B                         
  310A:  29            ADD HL,HL                     
  310B:  29            ADD HL,HL                     
  310C:  29            ADD HL,HL                     
  310D:  29            ADD HL,HL                     
  310E:  85            ADD A,L                       
  310F:  6F            LD L,A                        
  3110:  CD B4 30      CALL 0x30B4                   
  3113:  18 DB         JR 0x30F0                       ; -> 0x30F0
  3115:  CF            RST 08h                       
  3116:  AF            XOR A                         
  3117:  B8            CP B                          
  3118:  C1            POP BC                        
  3119:  E3            EX (SP),HL                    
  311A:  22 E4 42      LD (0x42E4),HL                
  311D:  E1            POP HL                        
  311E:  E3            EX (SP),HL                    
  311F:  E5            PUSH HL                       
  3120:  2A E4 42      LD HL,(0x42E4)                
  3123:  C9            RET                           
  3124:  C5            PUSH BC                       
  3125:  F5            PUSH AF                       
  3126:  06 08         LD B,0x08                     
  3128:  07            RLCA                          
  3129:  4F            LD C,A                        
  312A:  E6 01         AND 0x01                      
  312C:  C6 30         ADD A,0x30                    
  312E:  CF            RST 08h                       
  312F:  79            LD A,C                        
  3130:  10 F6         DJNZ 0x3128                     ; loop para 0x3128
  3132:  3E C2         LD A,0xC2                     
  3134:  CF            RST 08h                       
  3135:  F1            POP AF                        
  3136:  C1            POP BC                        
  3137:  C9            RET                           
  3138:  3E 42         LD A,0x42                     
  313A:  BC            CP H                          
  313B:  D8            RET C                         
  313C:  3E 3F         LD A,0x3F                     
  313E:  BC            CP H                          
  313F:  D0            RET NC                        
  3140:  21 EE 34      LD HL,0x34EE                  
  3143:  CD 9D 30      CALL STORAGE_ACCESS           
  3146:  C3 4E 30      JP 0x304E                     
  3149:  7C            LD A,H                        
  314A:  BA            CP D                          
  314B:  D8            RET C                         
  314C:  28 02         JR Z,0x3150                     ; -> 0x3150
  314E:  EB            EX DE,HL                      
  314F:  C9            RET                           
  3150:  7D            LD A,L                        
  3151:  BB            CP E                          
  3152:  D8            RET C                         
  3153:  EB            EX DE,HL                      
  3154:  C9            RET                           
  3155:  06 04         LD B,0x04                     
  3157:  5E            DB 0x5E                         ; '^'
  3158:  23            INC HL                        
  3159:  56            DB 0x56                         ; 'V'
  315A:  23            INC HL                        
  315B:  EB            EX DE,HL                      
  315C:  DF            RST 18h                       
  315D:  3E 20         LD A,0x20                     
  315F:  CF            RST 08h                       
  3160:  EB            EX DE,HL                      
  3161:  10 F4         DJNZ 0x3157                     ; loop para 0x3157
  3163:  C9            RET                           
  3164:  F7            RST 30h                       
  3165:  3E 0D         LD A,0x0D                     
  3167:  CF            RST 08h                       
  3168:  E1            POP HL                        
  3169:  CD 38 31      CALL 0x3138                   
  316C:  DF            RST 18h                       
  316D:  06 FE         LD B,0xFE                     
  316F:  C3 C3 30      JP 0x30C3                     
  3172:  F7            RST 30h                       
  3173:  E1            POP HL                        
  3174:  CD 38 31      CALL 0x3138                   
  3177:  3A DF 42      LD A,(0x42DF)                 
  317A:  B7            OR A                          
  317B:  28 09         JR Z,0x3186                     ; -> 0x3186
  317D:  E5            PUSH HL                       
  317E:  2A E0 42      LD HL,(0x42E0)                
  3181:  3A E2 42      LD A,(0x42E2)                 
  3184:  77            LD (HL),A                     
  3185:  E1            POP HL                        
  3186:  7E            LD A,(HL)                     
  3187:  32 E2 42      LD (0x42E2),A                 
  318A:  22 E0 42      LD (0x42E0),HL                
  318D:  3E EF         LD A,0xEF                     
  318F:  77            LD (HL),A                     
  3190:  32 DF 42      LD (0x42DF),A                 
  3193:  C9            RET                           
  3194:  CD F5 31      CALL 0x31F5                   
  3197:  CD 96 02      CALL 0x0296                   
  319A:  CD 35 02      CALL SERIAL_SEND_8BITS        
  319D:  FE 55         CP 0x55                       
  319F:  20 1C         JR NZ,0x31BD                    ; -> 0x31BD
  31A1:  11 00 3C      LD DE,VRAM_BASE                 ; ← VRAM
  31A4:  0E 06         LD C,0x06                     
  31A6:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31A9:  12            DB 0x12                       
  31AA:  1C            INC E                         
  31AB:  0D            DEC C                         
  31AC:  20 F8         JR NZ,0x31A6                    ; -> 0x31A6
  31AE:  C9            RET                           
  31AF:  CD 94 31      CALL 0x3194                   
  31B2:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31B5:  FE 78         CP 0x78                       
  31B7:  28 0C         JR Z,0x31C5                     ; -> 0x31C5
  31B9:  FE 3C         CP 0x3C                       
  31BB:  28 1F         JR Z,0x31DC                     ; -> 0x31DC
  31BD:  21 FE 34      LD HL,0x34FE                  
  31C0:  CD 9D 30      CALL STORAGE_ACCESS           
  31C3:  18 04         JR 0x31C9                       ; -> 0x31C9
  31C5:  CD D1 31      CALL 0x31D1                   
  31C8:  DF            RST 18h                       
  31C9:  CD F8 01      CALL 0x01F8                   
  31CC:  C9            RET                           
  31CD:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31D0:  47            LD B,A                        
  31D1:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31D4:  6F            LD L,A                        
  31D5:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31D8:  67            LD H,A                        
  31D9:  85            ADD A,L                       
  31DA:  4F            LD C,A                        
  31DB:  C9            RET                           
  31DC:  CD 2C 02      CALL 0x022C                   
  31DF:  CD CD 31      CALL 0x31CD                   
  31E2:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31E5:  BE            DB 0xBE                       
  31E6:  20 D5         JR NZ,0x31BD                    ; -> 0x31BD
  31E8:  81            ADD A,C                       
  31E9:  4F            LD C,A                        
  31EA:  23            INC HL                        
  31EB:  10 F5         DJNZ 0x31E2                     ; loop para 0x31E2
  31ED:  CD 35 02      CALL SERIAL_SEND_8BITS        
  31F0:  B9            CP C                          
  31F1:  20 CA         JR NZ,0x31BD                    ; -> 0x31BD
  31F3:  18 BD         JR 0x31B2                       ; -> 0x31B2
  31F5:  F7            RST 30h                       
  31F6:  E1            POP HL                        
  31F7:  7D            LD A,L                        
  31F8:  CD 11 02      CALL 0x0211                   
  31FB:  E5            PUSH HL                       
  31FC:  21 A3 35      LD HL,0x35A3                  
  31FF:  CD 9D 30      CALL STORAGE_ACCESS           
  3202:  E1            POP HL                        
  3203:  C9            RET                           
  3204:  F7            RST 30h                       
  3205:  F7            RST 30h                       
  3206:  D1            POP DE                        
  3207:  E1            POP HL                        
  3208:  3E 0D         LD A,0x0D                     
  320A:  CF            RST 08h                       
  320B:  06 10         LD B,0x10                     
  320D:  DF            RST 18h                       
  320E:  3E C4         LD A,0xC4                     
  3210:  CF            RST 08h                       
  3211:  7E            LD A,(HL)                     
  3212:  E7            RST 20h                       
  3213:  E5            PUSH HL                       
  3214:  B7            OR A                          
  3215:  ED 52         SBC HL,DE                     
  3217:  E1            POP HL                        
  3218:  23            INC HL                        
  3219:  C8            RET Z                         
  321A:  10 F5         DJNZ 0x3211                     ; loop para 0x3211
  321C:  CD 89 30      CALL 0x3089                   
  321F:  18 E7         JR 0x3208                       ; -> 0x3208
  3221:  F7            RST 30h                       
  3222:  E1            POP HL                        
  3223:  3E 0D         LD A,0x0D                     
  3225:  CF            RST 08h                       
  3226:  DF            RST 18h                       
  3227:  7E            LD A,(HL)                     
  3228:  E7            RST 20h                       
  3229:  F7            RST 30h                       
  322A:  30 05         JR NC,0x3231                    ; -> 0x3231
  322C:  CD 38 31      CALL 0x3138                   
  322F:  D1            POP DE                        
  3230:  73            LD (HL),E                     
  3231:  23            INC HL                        
  3232:  18 EF         JR 0x3223                       ; -> 0x3223
  3234:  F7            RST 30h                       
  3235:  F7            RST 30h                       
  3236:  F7            RST 30h                       
  3237:  E1            POP HL                        
  3238:  D1            POP DE                        
  3239:  CD DB 30      CALL 0x30DB                   
  323C:  CD 49 31      CALL 0x3149                   
  323F:  C1            POP BC                        
  3240:  2B            DEC HL                        
  3241:  23            INC HL                        
  3242:  71            LD (HL),C                     
  3243:  7A            LD A,D                        
  3244:  BC            CP H                          
  3245:  20 FA         JR NZ,0x3241                    ; -> 0x3241
  3247:  7B            LD A,E                        
  3248:  BD            CP L                          
  3249:  20 F6         JR NZ,0x3241                    ; -> 0x3241
  324B:  C9            RET                           
  324C:  F7            RST 30h                       
  324D:  21 0D 34      LD HL,0x340D                  
  3250:  22 0D 40      LD (0x400D),HL                
  3253:  E1            POP HL                        
  3254:  30 03         JR NC,0x3259                    ; -> 0x3259
  3256:  22 DD 42      LD (0x42DD),HL                
  3259:  2A DB 42      LD HL,(0x42DB)                
  325C:  ED 5B DD 42   LD DE,(0x42DD)                
  3260:  2B            DEC HL                        
  3261:  72            LD (HL),D                     
  3262:  2B            DEC HL                        
  3263:  22 DB 42      LD (0x42DB),HL                
  3266:  73            LD (HL),E                     
  3267:  E1            POP HL                        
  3268:  E1            POP HL                        
  3269:  D1            POP DE                        
  326A:  C1            POP BC                        
  326B:  F1            POP AF                        
  326C:  D9            EXX                           
  326D:  08            EX AF,AF'                     
  326E:  E1            POP HL                        
  326F:  D1            POP DE                        
  3270:  C1            POP BC                        
  3271:  F1            POP AF                        
  3272:  FD E1         POP IY                        
  3274:  DD E1         POP IX                        
  3276:  ED 7B DB 42   LD SP,(0x42DB)                
  327A:  E5            PUSH HL                       
  327B:  2A DB 42      LD HL,(0x42DB)                
  327E:  23            INC HL                        
  327F:  23            INC HL                        
  3280:  22 DB 42      LD (0x42DB),HL                
  3283:  E1            POP HL                        
  3284:  C9            RET                           
  3285:  F7            RST 30h                       
  3286:  F7            RST 30h                       
  3287:  3E 0D         LD A,0x0D                     
  3289:  CF            RST 08h                       
  328A:  21 03 35      LD HL,0x3503                  
  328D:  CD 9D 30      CALL STORAGE_ACCESS           
  3290:  E1            POP HL                        
  3291:  DF            RST 18h                       
  3292:  EB            EX DE,HL                      
  3293:  E1            POP HL                        
  3294:  DF            RST 18h                       
  3295:  E5            PUSH HL                       
  3296:  D5            PUSH DE                       
  3297:  19            ADD HL,DE                     
  3298:  DF            RST 18h                       
  3299:  E1            POP HL                        
  329A:  D1            POP DE                        
  329B:  B7            OR A                          
  329C:  ED 52         SBC HL,DE                     
  329E:  DF            RST 18h                       
  329F:  EB            EX DE,HL                      
  32A0:  AF            XOR A                         
  32A1:  6F            LD L,A                        
  32A2:  67            LD H,A                        
  32A3:  ED 52         SBC HL,DE                     
  32A5:  DF            RST 18h                       
  32A6:  C9            RET                           
  32A7:  F7            RST 30h                       
  32A8:  3E 0D         LD A,0x0D                     
  32AA:  CF            RST 08h                       
  32AB:  C1            POP BC                        
  32AC:  79            LD A,C                        
  32AD:  E7            RST 20h                       
  32AE:  3E C4         LD A,0xC4                     
  32B0:  CF            RST 08h                       
  32B1:  ED 78         DB 0xED,0x78                    ; instrução ED estendida
  32B3:  CD 24 31      CALL 0x3124                   
  32B6:  E7            RST 20h                       
  32B7:  C9            RET                           
  32B8:  21 2D 35      LD HL,0x352D                  
  32BB:  CD 9D 30      CALL STORAGE_ACCESS           
  32BE:  21 C7 42      LD HL,0x42C7                  
  32C1:  CD 55 31      CALL 0x3155                   
  32C4:  7B            LD A,E                        
  32C5:  CD 24 31      CALL 0x3124                   
  32C8:  E5            PUSH HL                       
  32C9:  21 15 35      LD HL,0x3515                  
  32CC:  CD 9D 30      CALL STORAGE_ACCESS           
  32CF:  E1            POP HL                        
  32D0:  CD 55 31      CALL 0x3155                   
  32D3:  7B            LD A,E                        
  32D4:  CD 24 31      CALL 0x3124                   
  32D7:  E5            PUSH HL                       
  32D8:  21 49 35      LD HL,0x3549                  
  32DB:  CD 9D 30      CALL STORAGE_ACCESS           
  32DE:  E1            POP HL                        
  32DF:  CD 55 31      CALL 0x3155                   
  32E2:  C9            RET                           
  32E3:  21 58 35      LD HL,0x3558                  
  32E6:  CD 9D 30      CALL STORAGE_ACCESS           
  32E9:  C9            RET                           
  32EA:  F7            RST 30h                       
  32EB:  F7            RST 30h                       
  32EC:  F7            RST 30h                       
  32ED:  C1            POP BC                        
  32EE:  D1            POP DE                        
  32EF:  E1            POP HL                        
  32F0:  E5            PUSH HL                       
  32F1:  D5            PUSH DE                       
  32F2:  C5            PUSH BC                       
  32F3:  19            ADD HL,DE                     
  32F4:  2B            DEC HL                        
  32F5:  CD DB 30      CALL 0x30DB                   
  32F8:  D1            POP DE                        
  32F9:  E1            POP HL                        
  32FA:  CD 49 31      CALL 0x3149                   
  32FD:  30 05         JR NC,0x3304                    ; -> 0x3304
  32FF:  C1            POP BC                        
  3300:  EB            EX DE,HL                      
  3301:  ED B0         LDIR                            ; copia bloco BC bytes: (HL)→(DE)
  3303:  C9            RET                           
  3304:  C1            POP BC                        
  3305:  09            ADD HL,BC                     
  3306:  2B            DEC HL                        
  3307:  EB            EX DE,HL                      
  3308:  09            ADD HL,BC                     
  3309:  2B            DEC HL                        
  330A:  EB            EX DE,HL                      
  330B:  ED B8         LDDR                            ; copia bloco BC bytes ao contrário
  330D:  C9            RET                           
  330E:  F7            RST 30h                       
  330F:  F7            RST 30h                       
  3310:  3E 0D         LD A,0x0D                     
  3312:  CF            RST 08h                       
  3313:  E1            POP HL                        
  3314:  D1            POP DE                        
  3315:  CD 49 31      CALL 0x3149                   
  3318:  E5            PUSH HL                       
  3319:  E1            POP HL                        
  331A:  E5            PUSH HL                       
  331B:  CD 89 30      CALL 0x3089                   
  331E:  7E            LD A,(HL)                     
  331F:  47            LD B,A                        
  3320:  2F            CPL                           
  3321:  77            LD (HL),A                     
  3322:  7E            LD A,(HL)                     
  3323:  2F            CPL                           
  3324:  77            LD (HL),A                     
  3325:  A8            XOR B                         
  3326:  C4 33 33      CALL NZ,0x3333                
  3329:  E5            PUSH HL                       
  332A:  B7            OR A                          
  332B:  ED 52         SBC HL,DE                     
  332D:  E1            POP HL                        
  332E:  23            INC HL                        
  332F:  38 ED         JR C,0x331E                     ; -> 0x331E
  3331:  18 E6         JR 0x3319                       ; -> 0x3319
  3333:  F5            PUSH AF                       
  3334:  DF            RST 18h                       
  3335:  F1            POP AF                        
  3336:  CD 24 31      CALL 0x3124                   
  3339:  E7            RST 20h                       
  333A:  3E 0D         LD A,0x0D                     
  333C:  CF            RST 08h                       
  333D:  C9            RET                           
  333E:  F7            RST 30h                       
  333F:  F7            RST 30h                       
  3340:  D1            POP DE                        
  3341:  C1            POP BC                        
  3342:  ED 59         DB 0xED,0x59                    ; instrução ED estendida
  3344:  C9            RET                           
  3345:  CD 94 31      CALL 0x3194                   
  3348:  2A E2 41      LD HL,(0x41E2)                
  334B:  E5            PUSH HL                       
  334C:  3A E4 41      LD A,(0x41E4)                 
  334F:  F5            PUSH AF                       
  3350:  3E C3         LD A,0xC3                     
  3352:  32 E2 41      LD (0x41E2),A                   ; → RAM sistema
  3355:  21 5E 33      LD HL,0x335E                  
  3358:  22 E3 41      LD (0x41E3),HL                
  335B:  C3 E7 02      JP 0x02E7                     
  335E:  F1            POP AF                        
  335F:  DF            RST 18h                       
  3360:  F1            POP AF                        
  3361:  E1            POP HL                        
  3362:  32 E4 41      LD (0x41E4),A                   ; → RAM sistema
  3365:  22 E2 41      LD (0x41E2),HL                
  3368:  C9            RET                           
  3369:  F7            RST 30h                       
  336A:  F7            RST 30h                       
  336B:  F7            RST 30h                       
  336C:  3E 0D         LD A,0x0D                     
  336E:  CF            RST 08h                       
  336F:  E1            POP HL                        
  3370:  D1            POP DE                        
  3371:  C1            POP BC                        
  3372:  CD 5B 03      CALL 0x035B                   
  3375:  1A            DB 0x1A                       
  3376:  13            INC DE                        
  3377:  AE            DB 0xAE                       
  3378:  C4 33 33      CALL NZ,0x3333                
  337B:  23            INC HL                        
  337C:  0B            DEC BC                        
  337D:  78            LD A,B                        
  337E:  B1            OR C                          
  337F:  20 F4         JR NZ,0x3375                    ; -> 0x3375
  3381:  C9            RET                           
  3382:  CD BE 30      CALL 0x30BE                   
  3385:  E5            PUSH HL                       
  3386:  41            LD B,C                        
  3387:  7E            LD A,(HL)                     
  3388:  FE 0D         CP 0x0D                       
  338A:  28 05         JR Z,0x3391                     ; -> 0x3391
  338C:  23            INC HL                        
  338D:  10 F8         DJNZ 0x3387                     ; loop para 0x3387
  338F:  18 05         JR 0x3396                       ; -> 0x3396
  3391:  36 20         LD (HL),0x20                  
  3393:  23            INC HL                        
  3394:  10 FB         DJNZ 0x3391                     ; loop para 0x3391
  3396:  E1            POP HL                        
  3397:  3E C2         LD A,0xC2                     
  3399:  CF            RST 08h                       
  339A:  F7            RST 30h                       
  339B:  F7            RST 30h                       
  339C:  F7            RST 30h                       
  339D:  EB            EX DE,HL                      
  339E:  E1            POP HL                        
  339F:  22 E4 42      LD (0x42E4),HL                
  33A2:  F7            RST 30h                       
  33A3:  21 5B 35      LD HL,0x355B                  
  33A6:  CD 9D 30      CALL STORAGE_ACCESS           
  33A9:  D7            RST 10h                       
  33AA:  E1            POP HL                        
  33AB:  7D            LD A,L                        
  33AC:  CD F8 31      CALL 0x31F8                   
  33AF:  EB            EX DE,HL                      
  33B0:  CD 87 02      CALL 0x0287                   
  33B3:  06 06         LD B,0x06                     
  33B5:  3E 55         LD A,0x55                     
  33B7:  CD FF 33      CALL 0x33FF                   
  33BA:  E1            POP HL                        
  33BB:  D1            POP DE                        
  33BC:  B7            OR A                          
  33BD:  ED 52         SBC HL,DE                     
  33BF:  23            INC HL                        
  33C0:  EB            EX DE,HL                      
  33C1:  06 00         LD B,0x00                     
  33C3:  7A            LD A,D                        
  33C4:  D6 01         SUB 0x01                      
  33C6:  57            LD D,A                        
  33C7:  3E 3C         LD A,0x3C                     
  33C9:  38 09         JR C,0x33D4                     ; -> 0x33D4
  33CB:  CD EF 33      CALL 0x33EF                   
  33CE:  79            LD A,C                        
  33CF:  CD 64 02      CALL SERIAL_SEND_1BIT         
  33D2:  18 ED         JR 0x33C1                       ; -> 0x33C1
  33D4:  4F            LD C,A                        
  33D5:  7B            LD A,E                        
  33D6:  B7            OR A                          
  33D7:  28 09         JR Z,0x33E2                     ; -> 0x33E2
  33D9:  43            LD B,E                        
  33DA:  79            LD A,C                        
  33DB:  CD EF 33      CALL 0x33EF                   
  33DE:  79            LD A,C                        
  33DF:  CD 64 02      CALL SERIAL_SEND_1BIT         
  33E2:  21 E4 42      LD HL,0x42E4                  
  33E5:  06 02         LD B,0x02                     
  33E7:  3E 78         LD A,0x78                     
  33E9:  CD FF 33      CALL 0x33FF                   
  33EC:  C3 F8 01      JP 0x01F8                     
  33EF:  CD 64 02      CALL SERIAL_SEND_1BIT         
  33F2:  78            LD A,B                        
  33F3:  CD 64 02      CALL SERIAL_SEND_1BIT         
  33F6:  7D            LD A,L                        
  33F7:  4D            LD C,L                        
  33F8:  CD 64 02      CALL SERIAL_SEND_1BIT         
  33FB:  7C            LD A,H                        
  33FC:  81            ADD A,C                       
  33FD:  4F            LD C,A                        
  33FE:  7C            LD A,H                        
  33FF:  CD 64 02      CALL SERIAL_SEND_1BIT         
  3402:  7E            LD A,(HL)                     
  3403:  81            ADD A,C                       
  3404:  4F            LD C,A                        
  3405:  7E            LD A,(HL)                     
  3406:  23            INC HL                        
  3407:  CD 64 02      CALL SERIAL_SEND_1BIT         
  340A:  10 F6         DJNZ 0x3402                     ; loop para 0x3402
  340C:  C9            RET                           
  340D:  22 CF 42      LD (0x42CF),HL                
  3410:  F5            PUSH AF                       
  3411:  E1            POP HL                        
  3412:  22 D5 42      LD (0x42D5),HL                
  3415:  ED 53 D1 42   LD (0x42D1),DE                
  3419:  E1            POP HL                        
  341A:  ED 73 DB 42   LD (0x42DB),SP                
  341E:  31 DB 42      LD SP,0x42DB                  
  3421:  22 DD 42      LD (0x42DD),HL                
  3424:  3A DF 42      LD A,(0x42DF)                 
  3427:  B7            OR A                          
  3428:  28 27         JR Z,0x3451                     ; -> 0x3451
  342A:  2B            DEC HL                        
  342B:  BE            DB 0xBE                       
  342C:  20 23         JR NZ,0x3451                    ; -> 0x3451
  342E:  ED 5B E0 42   LD DE,(0x42E0)                
  3432:  7A            LD A,D                        
  3433:  BC            CP H                          
  3434:  20 1B         JR NZ,0x3451                    ; -> 0x3451
  3436:  7B            LD A,E                        
  3437:  BD            CP L                          
  3438:  20 17         JR NZ,0x3451                    ; -> 0x3451
  343A:  3A E2 42      LD A,(0x42E2)                 
  343D:  77            LD (HL),A                     
  343E:  22 DD 42      LD (0x42DD),HL                
  3441:  AF            XOR A                         
  3442:  32 DF 42      LD (0x42DF),A                 
  3445:  ED 5B D1 42   LD DE,(0x42D1)                
  3449:  2A D5 42      LD HL,(0x42D5)                
  344C:  E5            PUSH HL                       
  344D:  F1            POP AF                        
  344E:  2A CF 42      LD HL,(0x42CF)                
  3451:  DD E5         PUSH IX                       
  3453:  FD E5         PUSH IY                       
  3455:  F5            PUSH AF                       
  3456:  C5            PUSH BC                       
  3457:  D5            PUSH DE                       
  3458:  E5            PUSH HL                       
  3459:  08            EX AF,AF'                     
  345A:  D9            EXX                           
  345B:  F5            PUSH AF                       
  345C:  C5            PUSH BC                       
  345D:  D5            PUSH DE                       
  345E:  E5            PUSH HL                       
  345F:  21 4E 30      LD HL,0x304E                  
  3462:  E5            PUSH HL                       
  3463:  C3 B8 32      JP 0x32B8                     
  3466:  CD B8 32      CALL 0x32B8                   
  3469:  3E 0D         LD A,0x0D                     
  346B:  CF            RST 08h                       
  346C:  CD BE 30      CALL 0x30BE                   
  346F:  06 00         LD B,0x00                     
  3471:  7E            LD A,(HL)                     
  3472:  FE 0D         CP 0x0D                       
  3474:  28 05         JR Z,0x347B                     ; -> 0x347B
  3476:  80            ADD A,B                       
  3477:  47            LD B,A                        
  3478:  23            INC HL                        
  3479:  18 F6         JR 0x3471                       ; -> 0x3471
  347B:  CF            RST 08h                       
  347C:  F7            RST 30h                       
  347D:  E1            POP HL                        
  347E:  78            LD A,B                        
  347F:  FE 87         CP 0x87                       
  3481:  20 04         JR NZ,0x3487                    ; -> 0x3487
  3483:  22 D5 42      LD (0x42D5),HL                
  3486:  C9            RET                           
  3487:  FE 85         CP 0x85                       
  3489:  20 04         JR NZ,0x348F                    ; -> 0x348F
  348B:  22 D3 42      LD (0x42D3),HL                
  348E:  C9            RET                           
  348F:  FE 89         CP 0x89                       
  3491:  20 04         JR NZ,0x3497                    ; -> 0x3497
  3493:  22 D1 42      LD (0x42D1),HL                
  3496:  C9            RET                           
  3497:  FE 94         CP 0x94                       
  3499:  20 04         JR NZ,0x349F                    ; -> 0x349F
  349B:  22 CF 42      LD (0x42CF),HL                
  349E:  C9            RET                           
  349F:  FE AE         CP 0xAE                       
  34A1:  20 04         JR NZ,0x34A7                    ; -> 0x34A7
  34A3:  22 CD 42      LD (0x42CD),HL                
  34A6:  C9            RET                           
  34A7:  FE AC         CP 0xAC                       
  34A9:  20 04         JR NZ,0x34AF                    ; -> 0x34AF
  34AB:  22 CB 42      LD (0x42CB),HL                
  34AE:  C9            RET                           
  34AF:  FE B0         CP 0xB0                       
  34B1:  20 04         JR NZ,0x34B7                    ; -> 0x34B7
  34B3:  22 C9 42      LD (0x42C9),HL                
  34B6:  C9            RET                           
  34B7:  FE BB         CP 0xBB                       
  34B9:  20 04         JR NZ,0x34BF                    ; -> 0x34BF
  34BB:  22 C7 42      LD (0x42C7),HL                
  34BE:  C9            RET                           
  34BF:  FE A1         CP 0xA1                       
  34C1:  20 04         JR NZ,0x34C7                    ; -> 0x34C7
  34C3:  22 D9 42      LD (0x42D9),HL                
  34C6:  C9            RET                           
  34C7:  FE A2         CP 0xA2                       
  34C9:  20 04         JR NZ,0x34CF                    ; -> 0x34CF
  34CB:  22 D7 42      LD (0x42D7),HL                
  34CE:  C9            RET                           
  34CF:  FE A3         CP 0xA3                       
  34D1:  20 04         JR NZ,0x34D7                    ; -> 0x34D7
  34D3:  22 DB 42      LD (0x42DB),HL                
  34D6:  C9            RET                           
  34D7:  FE 93         CP 0x93                       
  34D9:  C2 BD 31      JP NZ,0x31BD                  
  34DC:  22 DD 42      LD (0x42DD),HL                
  34DF:  C9            RET                           
  34E0:  0E 1C         LD C,0x1C                     
  34E2:  1F            RRA                           
  34E3:  00            NOP                           
  34E4:  0A            DB 0x0A                       

;
; ─── SEÇÃO 7: DIGBUG — MONITOR/DEBUGGER EMBUTIDO ───────────────────
; Prompt: 'DIGBUG >'
; Display de registradores: HL, DE, BC, AF, IX, IY, SP, PC
; Display de flags: 'SZ-H-PNC' (Sign, Zero, Half-carry, Parity, N, Carry)
; Inclui acesso ao cassete: 'Prepare o gravador'
; Comando de ativação: ainda não identificado (possivelmente CMD "BUG")

; NOTA: 0x34E5-0x35FF é região de dados (strings e tabelas do DIGBUG)
DIGBUG_ENTRY:
  34E5:  44            LD B,H                        
  34E6:  49            LD C,C                        
  34E7:  47            LD B,A                        
  34E8:  42            LD B,D                        
  34E9:  55            LD D,L                        
  34EA:  47            LD B,A                        
  34EB:  20 3E         JR NZ,0x352B                    ; -> 0x352B
  34ED:  00            NOP                           
  34EE:  0A            DB 0x0A                       
STR_AREA_PROTEGIDA:
  34EF:  41            LD B,C                        
  34F0:  72            LD (HL),D                     
  34F1:  65            LD H,L                        
  34F2:  61            LD H,C                        
  34F3:  20 50         JR NZ,0x3545                    ; -> 0x3545
  34F5:  72            LD (HL),D                     
  34F6:  6F            LD L,A                        
  34F7:  74            LD (HL),H                     
  34F8:  65            LD H,L                        
  34F9:  67            LD H,A                        
  34FA:  69            LD L,C                        
  34FB:  64            LD H,H                        
  34FC:  61            LD H,C                        
  34FD:  00            NOP                           
  34FE:  45            LD B,L                        
  34FF:  52            LD D,D                        
  3500:  52            LD D,D                        
  3501:  4F            LD C,A                        
  3502:  00            NOP                           
  3503:  C1            POP BC                        
  3504:  41            LD B,C                        
STR_OPS_DIGBUG:
  3505:  C4 42 C3      CALL NZ,0xC342                
  3508:  41            LD B,C                        
  3509:  2B            DEC HL                        
  350A:  42            LD B,D                        
  350B:  C2 41 2D      JP NZ,0x2D41                  
  350E:  42            LD B,D                        
  350F:  C2 42 2D      JP NZ,0x2D42                  
  3512:  41            LD B,C                        
  3513:  0D            DEC C                         
  3514:  00            NOP                           
  3515:  0A            DB 0x0A                       
  3516:  20 48         JR NZ,0x3560                    ; -> 0x3560
  3518:  4C            LD C,H                        
  3519:  C4 44 45      CALL NZ,0x4544                
  351C:  C4 42 43      CALL NZ,0x4342                
  351F:  C4 41 46      CALL NZ,0x4641                
  3522:  C3 53 5A      JP 0x5A53                     
  3525:  2D            DEC L                         
  3526:  48            LD C,B                        
  3527:  2D            DEC L                         
  3528:  50            LD D,B                        
  3529:  4E            DB 0x4E                         ; 'N'
  352A:  43            LD B,E                        
  352B:  0D            DEC C                         
  352C:  00            NOP                           
  352D:  0A            DB 0x0A                       
  352E:  20 48         JR NZ,0x3578                    ; -> 0x3578
  3530:  4C            LD C,H                        
  3531:  27            DAA                           
  3532:  C3 44 45      JP 0x4544                     
  3535:  27            DAA                           
  3536:  C3 42 43      JP 0x4342                     
  3539:  27            DAA                           
  353A:  C3 41 46      JP 0x4641                     
  353D:  27            DAA                           
  353E:  C2 53 5A      JP NZ,0x5A53                  
  3541:  2D            DEC L                         
  3542:  48            LD C,B                        
  3543:  2D            DEC L                         
  3544:  50            LD D,B                        
  3545:  4E            DB 0x4E                         ; 'N'
  3546:  43            LD B,E                        
  3547:  0D            DEC C                         
  3548:  00            NOP                           
  3549:  0A            DB 0x0A                       
  354A:  20 49         JR NZ,0x3595                    ; -> 0x3595
  354C:  59            LD E,C                        
  354D:  C4 49 58      CALL NZ,0x5849                
  3550:  C4 53 50      CALL NZ,0x5053                
  3553:  C4 50 43      CALL NZ,0x4350                
  3556:  0D            DEC C                         
  3557:  00            NOP                           
  3558:  1D            DEC E                         
  3559:  1E 00         LD E,0x00                     
  355B:  0A            DB 0x0A                       
  355C:  50            LD D,B                        
  355D:  72            LD (HL),D                     
  355E:  65            LD H,L                        
  355F:  70            LD (HL),B                     
  3560:  61            LD H,C                        
  3561:  72            LD (HL),D                     
  3562:  65            LD H,L                        
  3563:  20 6F         JR NZ,0x35D4                    ; -> 0x35D4
  3565:  20 67         JR NZ,0x35CE                    ; -> 0x35CE
  3567:  72            LD (HL),D                     
  3568:  61            LD H,C                        
  3569:  76            HALT                          
  356A:  61            LD H,C                        
  356B:  64            LD H,H                        
  356C:  6F            LD L,A                        
  356D:  72            LD (HL),D                     
  356E:  00            NOP                           
  356F:  64            LD H,H                        
  3570:  31 72 31      LD SP,0x3172                  
  3573:  AF            XOR A                         
  3574:  31 04 32      LD SP,0x3204                  
  3577:  21 32 34      LD HL,0x3432                  
  357A:  32 4C 32      LD (0x324C),A                 
  357D:  85            ADD A,L                       
  357E:  32 A7 32      LD (0x32A7),A                 
  3581:  B8            CP B                          
  3582:  32 E3 32      LD (0x32E3),A                 
  3585:  E3            EX (SP),HL                    
  3586:  32 EA 32      LD (0x32EA),A                 
  3589:  0E 33         LD C,0x33                     
  358B:  3E 33         LD A,0x33                     
  358D:  E3            EX (SP),HL                    
  358E:  32 CA 30      LD (0x30CA),A                 
  3591:  45            LD B,L                        
  3592:  33            INC SP                        
  3593:  E3            EX (SP),HL                    
  3594:  32 E3 32      LD (0x32E3),A                 
  3597:  E3            EX (SP),HL                    
  3598:  32 69 33      LD (0x3369),A                 
  359B:  82            ADD A,D                       
  359C:  33            INC SP                        
  359D:  66            DB 0x66                         ; 'f'
  359E:  34            INC (HL)                      
  359F:  E3            EX (SP),HL                    
  35A0:  32 E3 32      LD (0x32E3),A                 
  35A3:  1C            INC E                         
  35A4:  CC 1F 00      CALL Z,0x001F                 
  35A7:  CD A6 30      CALL 0x30A6                   
  35AA:  3E 20         LD A,0x20                     
  35AC:  CF            RST 08h                       
  35AD:  C9            RET                           
  35AE:  CD AB 30      CALL 0x30AB                   
  35B1:  18 F7         JR 0x35AA                       ; -> 0x35AA
  35B3:  CD 28 28      CALL 0x2828                   
  35B6:  CD 01 2B      CALL 0x2B01                   
  35B9:  CF            RST 08h                       
  35BA:  2C            INC L                         
  35BB:  7B            LD A,E                        
  35BC:  A2            AND D                         
  35BD:  F2 4A 1E      JP P,0x1E4A                   
  35C0:  E5            PUSH HL                       
  35C1:  2A A7 40      LD HL,(0x40A7)                
  35C4:  54            LD D,H                        
  35C5:  5D            LD E,L                        
  35C6:  13            INC DE                        
  35C7:  72            LD (HL),D                     
  35C8:  2B            DEC HL                        
  35C9:  73            LD (HL),E                     
  35CA:  2B            DEC HL                        
  35CB:  36 00         LD (HL),0x00                  
  35CD:  E1            POP HL                        
  35CE:  C9            RET                           
  35CF:  CD 2A 03      CALL DISPLAY_CHAR             
  35D2:  3A 9C 40      LD A,(0x409C)                 
  35D5:  B7            OR A                          
  35D6:  F0            RET P                         
  35D7:  CD 0C 02      CALL 0x020C                   
  35DA:  E5            PUSH HL                       
  35DB:  2A A7 40      LD HL,(0x40A7)                
  35DE:  2B            DEC HL                        
  35DF:  2B            DEC HL                        
  35E0:  CD 87 02      CALL 0x0287                   
  35E3:  46            DB 0x46                         ; 'F'
  35E4:  23            INC HL                        
  35E5:  23            INC HL                        
  35E6:  23            INC HL                        
  35E7:  7E            LD A,(HL)                     
  35E8:  CD 64 02      CALL SERIAL_SEND_1BIT         
  35EB:  10 F9         DJNZ 0x35E6                     ; loop para 0x35E6
  35ED:  E1            POP HL                        
  35EE:  C9            RET                           
  35EF:  E5            PUSH HL                       
  35F0:  D5            PUSH DE                       
  35F1:  2A A7 40      LD HL,(0x40A7)                
  35F4:  56            DB 0x56                         ; 'V'
  35F5:  2B            DEC HL                        
  35F6:  5E            DB 0x5E                         ; '^'
  35F7:  2B            DEC HL                        
  35F8:  12            DB 0x12                       
  35F9:  7E            LD A,(HL)                     
  35FA:  FE FA         CP 0xFA                       
  35FC:  30 07         JR NC,0x3605                    ; -> 0x3605
  35FE:  3C            INC A                         
  35FF:  77            LD (HL),A                     
  3600:  13            INC DE                        
  3601:  23            INC HL                        
  3602:  73            LD (HL),E                     
  3603:  23            INC HL                        
  3604:  72            LD (HL),D                     
  3605:  D1            POP DE                        
  3606:  E1            POP HL                        
  3607:  C9            RET                           
  3608:  00            NOP                           
  3609:  00            NOP                           
  360A:  00            NOP                           
  360B:  00            NOP                           
  360C:  00            NOP                           
  360D:  00            NOP                           
  360E:  00            NOP                           
  360F:  00            NOP                           
  3610:  00            NOP                           
  3611:  00            NOP                           
  3612:  00            NOP                           
  3613:  00            NOP                           
  3614:  00            NOP                           
  3615:  00            NOP                           
  3616:  00            NOP                           
  3617:  00            NOP                           
  3618:  00            NOP                           
  3619:  00            NOP                           
  361A:  00            NOP                           
  361B:  00            NOP                           
  361C:  00            NOP                           
  361D:  00            NOP                           
  361E:  00            NOP                           
  361F:  00            NOP                           
  3620:  00            NOP                           
  3621:  00            NOP                           
  3622:  00            NOP                           
  3623:  00            NOP                           
  3624:  00            NOP                           
  3625:  00            NOP                           
  3626:  00            NOP                           
  3627:  00            NOP                           
  3628:  00            NOP                           
  3629:  00            NOP                           
  362A:  00            NOP                           
  362B:  00            NOP                           
  362C:  00            NOP                           
  362D:  00            NOP                           
  362E:  00            NOP                           
  362F:  00            NOP                           
  3630:  00            NOP                           
  3631:  00            NOP                           
  3632:  00            NOP                           
  3633:  00            NOP                           
  3634:  00            NOP                           
  3635:  00            NOP                           
  3636:  00            NOP                           
  3637:  00            NOP                           
  3638:  00            NOP                           
  3639:  00            NOP                           
  363A:  00            NOP                           
  363B:  00            NOP                           
  363C:  00            NOP                           
  363D:  00            NOP                           
  363E:  00            NOP                           
  363F:  00            NOP                           
  3640:  00            NOP                           
  3641:  00            NOP                           
  3642:  00            NOP                           
  3643:  00            NOP                           
  3644:  00            NOP                           
  3645:  00            NOP                           
  3646:  00            NOP                           
  3647:  00            NOP                           
  3648:  00            NOP                           
  3649:  00            NOP                           
  364A:  00            NOP                           
  364B:  00            NOP                           
  364C:  00            NOP                           
  364D:  00            NOP                           
  364E:  00            NOP                           
  364F:  00            NOP                           
  3650:  00            NOP                           
  3651:  00            NOP                           
  3652:  00            NOP                           
  3653:  00            NOP                           
  3654:  00            NOP                           
  3655:  00            NOP                           
  3656:  00            NOP                           
  3657:  00            NOP                           
  3658:  00            NOP                           
  3659:  00            NOP                           
  365A:  00            NOP                           
  365B:  00            NOP                           
  365C:  00            NOP                           
  365D:  00            NOP                           
  365E:  00            NOP                           
  365F:  00            NOP                           
  3660:  00            NOP                           
  3661:  00            NOP                           
  3662:  00            NOP                           
  3663:  00            NOP                           
  3664:  00            NOP                           
  3665:  00            NOP                           
  3666:  00            NOP                           
  3667:  00            NOP                           
  3668:  00            NOP                           
  3669:  00            NOP                           
  366A:  00            NOP                           
  366B:  00            NOP                           
  366C:  00            NOP                           
  366D:  00            NOP                           
  366E:  00            NOP                           
  366F:  00            NOP                           
  3670:  00            NOP                           
  3671:  00            NOP                           
  3672:  00            NOP                           
  3673:  00            NOP                           
  3674:  00            NOP                           
  3675:  00            NOP                           
  3676:  00            NOP                           
  3677:  00            NOP                           
  3678:  00            NOP                           
  3679:  00            NOP                           
  367A:  00            NOP                           
  367B:  00            NOP                           
  367C:  00            NOP                           
  367D:  00            NOP                           
  367E:  00            NOP                           
  367F:  00            NOP                           
  3680:  00            NOP                           
  3681:  00            NOP                           
  3682:  00            NOP                           
  3683:  00            NOP                           
  3684:  00            NOP                           
  3685:  00            NOP                           
  3686:  00            NOP                           
  3687:  00            NOP                           
  3688:  00            NOP                           
  3689:  00            NOP                           
  368A:  00            NOP                           
  368B:  00            NOP                           
  368C:  00            NOP                           
  368D:  00            NOP                           
  368E:  00            NOP                           
  368F:  00            NOP                           
  3690:  00            NOP                           
  3691:  00            NOP                           
  3692:  00            NOP                           
  3693:  00            NOP                           
  3694:  00            NOP                           
  3695:  00            NOP                           
  3696:  00            NOP                           
  3697:  00            NOP                           
  3698:  00            NOP                           
  3699:  00            NOP                           
  369A:  00            NOP                           
  369B:  00            NOP                           
  369C:  00            NOP                           
  369D:  00            NOP                           
  369E:  00            NOP                           
  369F:  00            NOP                           
  36A0:  00            NOP                           
  36A1:  00            NOP                           
  36A2:  00            NOP                           
  36A3:  00            NOP                           
  36A4:  00            NOP                           
  36A5:  00            NOP                           
  36A6:  00            NOP                           
  36A7:  00            NOP                           
  36A8:  00            NOP                           
  36A9:  00            NOP                           
  36AA:  00            NOP                           
  36AB:  00            NOP                           
  36AC:  00            NOP                           
  36AD:  00            NOP                           
  36AE:  00            NOP                           
  36AF:  00            NOP                           
  36B0:  00            NOP                           
  36B1:  00            NOP                           
  36B2:  00            NOP                           
  36B3:  00            NOP                           
  36B4:  00            NOP                           
  36B5:  00            NOP                           
  36B6:  00            NOP                           
  36B7:  00            NOP                           
  36B8:  00            NOP                           
  36B9:  00            NOP                           
  36BA:  00            NOP                           
  36BB:  00            NOP                           
  36BC:  00            NOP                           
  36BD:  00            NOP                           
  36BE:  00            NOP                           
  36BF:  00            NOP                           
  36C0:  00            NOP                           
  36C1:  00            NOP                           
  36C2:  00            NOP                           
  36C3:  00            NOP                           
  36C4:  00            NOP                           
  36C5:  00            NOP                           
  36C6:  00            NOP                           
  36C7:  00            NOP                           
  36C8:  00            NOP                           
  36C9:  00            NOP                           
  36CA:  00            NOP                           
  36CB:  00            NOP                           
  36CC:  00            NOP                           
  36CD:  00            NOP                           
  36CE:  00            NOP                           
  36CF:  00            NOP                           
  36D0:  00            NOP                           
  36D1:  00            NOP                           
  36D2:  00            NOP                           
  36D3:  00            NOP                           
  36D4:  00            NOP                           
  36D5:  00            NOP                           
  36D6:  00            NOP                           
  36D7:  00            NOP                           
  36D8:  00            NOP                           
  36D9:  00            NOP                           
  36DA:  00            NOP                           
  36DB:  00            NOP                           
  36DC:  00            NOP                           
  36DD:  00            NOP                           
  36DE:  00            NOP                           
  36DF:  00            NOP                           
  36E0:  00            NOP                           
  36E1:  00            NOP                           
  36E2:  00            NOP                           
  36E3:  00            NOP                           
  36E4:  00            NOP                           
  36E5:  00            NOP                           
  36E6:  00            NOP                           
  36E7:  00            NOP                           
  36E8:  00            NOP                           
  36E9:  00            NOP                           
  36EA:  00            NOP                           
  36EB:  00            NOP                           
  36EC:  00            NOP                           
  36ED:  00            NOP                           
  36EE:  00            NOP                           
  36EF:  00            NOP                           
  36F0:  00            NOP                           
  36F1:  00            NOP                           
  36F2:  00            NOP                           
  36F3:  00            NOP                           
  36F4:  00            NOP                           
  36F5:  00            NOP                           
  36F6:  00            NOP                           
  36F7:  00            NOP                           
  36F8:  00            NOP                           
  36F9:  00            NOP                           
  36FA:  00            NOP                           
  36FB:  00            NOP                           
  36FC:  00            NOP                           
  36FD:  00            NOP                           
  36FE:  00            NOP                           
  36FF:  00            NOP                           
  3700:  00            NOP                           
  3701:  00            NOP                           
  3702:  00            NOP                           
  3703:  00            NOP                           
  3704:  00            NOP                           
  3705:  00            NOP                           
  3706:  00            NOP                           
  3707:  00            NOP                           
  3708:  00            NOP                           
  3709:  00            NOP                           
  370A:  00            NOP                           
  370B:  00            NOP                           
  370C:  00            NOP                           
  370D:  00            NOP                           
  370E:  00            NOP                           
  370F:  00            NOP                           
  3710:  00            NOP                           
  3711:  00            NOP                           
  3712:  00            NOP                           
  3713:  00            NOP                           
  3714:  00            NOP                           
  3715:  00            NOP                           
  3716:  00            NOP                           
  3717:  00            NOP                           
  3718:  00            NOP                           
  3719:  00            NOP                           
  371A:  00            NOP                           
  371B:  00            NOP                           
  371C:  00            NOP                           
  371D:  00            NOP                           
  371E:  00            NOP                           
  371F:  00            NOP                           
  3720:  00            NOP                           
  3721:  00            NOP                           
  3722:  00            NOP                           
  3723:  00            NOP                           
  3724:  00            NOP                           
  3725:  00            NOP                           
  3726:  00            NOP                           
  3727:  00            NOP                           
  3728:  00            NOP                           
  3729:  00            NOP                           
  372A:  00            NOP                           
  372B:  00            NOP                           
  372C:  00            NOP                           
  372D:  00            NOP                           
  372E:  00            NOP                           
  372F:  00            NOP                           
  3730:  00            NOP                           
  3731:  00            NOP                           
  3732:  00            NOP                           
  3733:  00            NOP                           
  3734:  00            NOP                           
  3735:  00            NOP                           
  3736:  00            NOP                           
  3737:  00            NOP                           
  3738:  00            NOP                           
  3739:  00            NOP                           
  373A:  00            NOP                           
  373B:  00            NOP                           
  373C:  00            NOP                           
  373D:  00            NOP                           
  373E:  00            NOP                           
  373F:  00            NOP                           
  3740:  00            NOP                           
  3741:  00            NOP                           
  3742:  00            NOP                           
  3743:  00            NOP                           
  3744:  00            NOP                           
  3745:  00            NOP                           
  3746:  00            NOP                           
  3747:  00            NOP                           
  3748:  00            NOP                           
  3749:  00            NOP                           
  374A:  00            NOP                           
  374B:  00            NOP                           
  374C:  00            NOP                           
  374D:  00            NOP                           
  374E:  00            NOP                           
  374F:  00            NOP                           
  3750:  00            NOP                           
  3751:  00            NOP                           
  3752:  00            NOP                           
  3753:  00            NOP                           
  3754:  00            NOP                           
  3755:  00            NOP                           
  3756:  00            NOP                           
  3757:  00            NOP                           
  3758:  00            NOP                           
  3759:  00            NOP                           
  375A:  00            NOP                           
  375B:  00            NOP                           
  375C:  00            NOP                           
  375D:  00            NOP                           
  375E:  00            NOP                           
  375F:  00            NOP                           
  3760:  00            NOP                           
  3761:  00            NOP                           
  3762:  00            NOP                           
  3763:  00            NOP                           
  3764:  00            NOP                           
  3765:  00            NOP                           
  3766:  00            NOP                           
  3767:  00            NOP                           
  3768:  00            NOP                           
  3769:  00            NOP                           
  376A:  00            NOP                           
  376B:  00            NOP                           
  376C:  00            NOP                           
  376D:  00            NOP                           
  376E:  00            NOP                           
  376F:  00            NOP                           
  3770:  00            NOP                           
  3771:  00            NOP                           
  3772:  00            NOP                           
  3773:  00            NOP                           
  3774:  00            NOP                           
  3775:  00            NOP                           
  3776:  00            NOP                           
  3777:  00            NOP                           
  3778:  00            NOP                           
  3779:  00            NOP                           
  377A:  00            NOP                           
  377B:  00            NOP                           
  377C:  00            NOP                           
  377D:  00            NOP                           
  377E:  00            NOP                           
  377F:  00            NOP                           
  3780:  00            NOP                           
  3781:  00            NOP                           
  3782:  00            NOP                           
  3783:  00            NOP                           
  3784:  00            NOP                           
  3785:  00            NOP                           
  3786:  00            NOP                           
  3787:  00            NOP                           
  3788:  00            NOP                           
  3789:  00            NOP                           
  378A:  00            NOP                           
  378B:  00            NOP                           
  378C:  00            NOP                           
  378D:  00            NOP                           
  378E:  00            NOP                           
  378F:  00            NOP                           
  3790:  00            NOP                           
  3791:  00            NOP                           
  3792:  00            NOP                           
  3793:  00            NOP                           
  3794:  00            NOP                           
  3795:  00            NOP                           
  3796:  00            NOP                           
  3797:  00            NOP                           
  3798:  00            NOP                           
  3799:  00            NOP                           
  379A:  00            NOP                           
  379B:  00            NOP                           
  379C:  00            NOP                           
  379D:  00            NOP                           
  379E:  00            NOP                           
  379F:  00            NOP                           
  37A0:  00            NOP                           
  37A1:  00            NOP                           
  37A2:  00            NOP                           
  37A3:  00            NOP                           
  37A4:  00            NOP                           
  37A5:  00            NOP                           
  37A6:  00            NOP                           
  37A7:  00            NOP                           
  37A8:  00            NOP                           
  37A9:  00            NOP                           
  37AA:  00            NOP                           
  37AB:  00            NOP                           
  37AC:  00            NOP                           
  37AD:  00            NOP                           
  37AE:  00            NOP                           
  37AF:  00            NOP                           
  37B0:  00            NOP                           
  37B1:  00            NOP                           
  37B2:  00            NOP                           
  37B3:  00            NOP                           
  37B4:  00            NOP                           
  37B5:  00            NOP                           
  37B6:  00            NOP                           
  37B7:  00            NOP                           
  37B8:  00            NOP                           
  37B9:  00            NOP                           
  37BA:  00            NOP                           
  37BB:  00            NOP                           
  37BC:  00            NOP                           
  37BD:  00            NOP                           
  37BE:  00            NOP                           
  37BF:  00            NOP                           
  37C0:  00            NOP                           
  37C1:  00            NOP                           
  37C2:  00            NOP                           
  37C3:  00            NOP                           
  37C4:  00            NOP                           
  37C5:  00            NOP                           
  37C6:  00            NOP                           
  37C7:  00            NOP                           
  37C8:  00            NOP                           
  37C9:  00            NOP                           
  37CA:  00            NOP                           
  37CB:  00            NOP                           
  37CC:  00            NOP                           
  37CD:  00            NOP                           
  37CE:  00            NOP                           
  37CF:  00            NOP                           
  37D0:  00            NOP                           
  37D1:  00            NOP                           
  37D2:  00            NOP                           
  37D3:  00            NOP                           
  37D4:  00            NOP                           
  37D5:  00            NOP                           
  37D6:  00            NOP                           
  37D7:  00            NOP                           
  37D8:  00            NOP                           
  37D9:  00            NOP                           
  37DA:  00            NOP                           
  37DB:  00            NOP                           
  37DC:  00            NOP                           
  37DD:  00            NOP                           
  37DE:  00            NOP                           
  37DF:  00            NOP                           
  37E0:  00            NOP                           
  37E1:  00            NOP                           
  37E2:  00            NOP                           
  37E3:  00            NOP                           
  37E4:  00            NOP                           
  37E5:  00            NOP                           
  37E6:  00            NOP                           
  37E7:  00            NOP                           
  37E8:  00            NOP                           
  37E9:  00            NOP                           
  37EA:  00            NOP                           
  37EB:  00            NOP                           
  37EC:  00            NOP                           
  37ED:  00            NOP                           
  37EE:  00            NOP                           
  37EF:  00            NOP                           
  37F0:  00            NOP                           
  37F1:  00            NOP                           
  37F2:  00            NOP                           
  37F3:  00            NOP                           
  37F4:  00            NOP                           
  37F5:  00            NOP                           
  37F6:  00            NOP                           
  37F7:  00            NOP                           
  37F8:  00            NOP                           
  37F9:  00            NOP                           
  37FA:  00            NOP                           
  37FB:  00            NOP                           
  37FC:  00            NOP                           
  37FD:  00            NOP                           
  37FE:  00            NOP                           
  37FF:  00            NOP                           