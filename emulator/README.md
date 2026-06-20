# DGT-100 Emulador Mínimo

Emulador mínimo do DGT-100 usando **libz80ex** para emular o processador Z80.

## Dependências

```bash
# Ubuntu/Debian
sudo apt-get install -y libz80ex-dev
```

## Compilação

```bash
make
```

## Uso

```bash
./dgt100_emu ../roms/patched/DGT100_EMULATOR.BIN
```

## O que é emulado

- CPU Z80 completo (via libz80ex)
- ROM em `0x0000–0x37FF`
- RAM sobreposta em `0x3700–0x3BFF`
- VRAM em `0x3C00–0x3FFF` (exibida como texto no terminal)
- RAM principal em `0x4000–0xFFFF`
- Stubs de I/O para todas as portas conhecidas

## Saída esperada

```
╔════════════════════════════════════════════════════════════════╗
║By RetroLABS JL Martins & Luiz Pacheco  - 2026                  ║
║DIGBASIC II                                                     ║
║Ready                                                           ║
║>·                                                              ║
╚════════════════════════════════════════════════════════════════╝
```

## Limitações conhecidas

- Teclado não implementado (VRAM só de saída)
- Cassete não implementado
- FDC não implementado (DGP/M não roda)
- CHAR ROM não decodificada (usa ASCII padrão como aproximação)
- Portas de I/O desconhecidas retornam `0xFF` (stub)

## Próximos passos

Para completar o emulador, o esquemático do DGT-100 é necessário para:
1. Identificar e emular o controlador de vídeo
2. Implementar o FDC (porta `0x84` proprietária)
3. Emular o mecanismo de boot de disco (`0x37EC–0x37EF`)
