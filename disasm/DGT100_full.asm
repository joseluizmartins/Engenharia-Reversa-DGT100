; z80dasm 1.1.6
; command line: z80dasm --origin=0x0000 --address /home/claude/dgt100_corrected.bin

	org	00000h

	di			;0000
	xor a			;0001
	jp 00258h		;0002
	jp 04000h		;0005
	jp 04000h		;0008
	pop hl			;000b
	jp (hl)			;000c
	jp 0069fh		;000d
	jp 04003h		;0010
	push bc			;0013
	ld b,001h		;0014
	jr $+48		;0016
	jp 04006h		;0018
	push bc			;001b
	ld b,002h		;001c
	jr $+40		;001e
	jp 04009h		;0020
	push bc			;0023
	ld b,004h		;0024
	jr $+32		;0026
	jp 0400ch		;0028
	ld de,04015h		;002b
	jr $-27		;002e
	jp 0400fh		;0030
	ld de,0401dh		;0033
	jr $-27		;0036
	jp 04012h		;0038
	ld de,04025h		;003b
	jr $-35		;003e
	jp 005d9h		;0040
	ret			;0043
	nop			;0044
	nop			;0045
	jp 003c2h		;0046
	call 0002bh		;0049
	or a			;004c
	ret nz			;004d
	jr $-5		;004e
	dec c			;0050
	dec c			;0051
	rra			;0052
	rra			;0053
	ld bc,05b01h		;0054
	dec de			;0057
	ld a,(bc)			;0058
	nop			;0059
	ex af,af'			;005a
	jr $+11		;005b
	add hl,de			;005d
	jr nz,$+34		;005e
	dec bc			;0060
	ld a,b			;0061
	or c			;0062
	jr nz,$-3		;0063
	ret			;0065
	ld sp,00600h		;0066
	ld a,(037ech)		;0069
	nop			;006c
	cp 080h		;006d
	jp z,00000h		;006f
	jp 03000h		;0072
	ld de,04080h		;0075
	ld hl,018f7h		;0078
	ld bc,00027h		;007b
	ldir		;007e
	ld hl,041e5h		;0080
	ld (hl),03ah		;0083
	inc hl			;0085
	ld (hl),b			;0086
	inc hl			;0087
	ld (hl),02ch		;0088
	inc hl			;008a
	ld (040a7h),hl		;008b
	ld de,0012dh		;008e
	ld b,01ch		;0091
	ld hl,04152h		;0093
	ld (hl),0c3h		;0096
	inc hl			;0098
	ld (hl),e			;0099
	inc hl			;009a
	ld (hl),d			;009b
	inc hl			;009c
	djnz $-7		;009d
	ld b,015h		;009f
	ld (hl),0c9h		;00a1
	inc hl			;00a3
	inc hl			;00a4
	inc hl			;00a5
	djnz $-5		;00a6
	ld hl,042e8h		;00a8
	ld (hl),b			;00ab
	ld sp,041f8h		;00ac
	call 01b8fh		;00af
	call 001c9h		;00b2
	ld hl,00105h		;00b5
	call 028a7h		;00b8
	call 01bb3h		;00bb
	jr c,$-9		;00be
	rst 10h			;00c0
	or a			;00c1
	jr nz,$+20		;00c2
	ld hl,0434ch		;00c4
	inc hl			;00c7
	ld a,h			;00c8
	or l			;00c9
	jr z,$+29		;00ca
	ld a,(hl)			;00cc
	ld b,a			;00cd
	cpl			;00ce
	ld (hl),a			;00cf
	cp (hl)			;00d0
	ld (hl),b			;00d1
	jr z,$-11		;00d2
	jr $+19		;00d4
	call 01e5ah		;00d6
	or a			;00d9
	jp nz,01997h		;00da
	ex de,hl			;00dd
	dec hl			;00de
	ld a,08fh		;00df
	ld b,(hl)			;00e1
	ld (hl),a			;00e2
	cp (hl)			;00e3
	ld (hl),b			;00e4
	jr nz,$-48		;00e5
	dec hl			;00e7
	ld de,04414h		;00e8
	rst 18h			;00eb
	jp c,0197ah		;00ec
	ld de,0ffceh		;00ef
	ld (040b1h),hl		;00f2
	add hl,de			;00f5
	ld (040a0h),hl		;00f6
	call 01b4dh		;00f9
	ld hl,0010eh		;00fc
	call 028a7h		;00ff
	jp 01a19h		;0102
	ld d,b			;0105
	ld d,d			;0106
	ld c,a			;0107
	ld d,h			;0108
	ld b,l			;0109
	ld b,a			;010a
	ld b,l			;010b
	ld d,d			;010c
	nop			;010d
	ld b,h			;010e
	ld c,c			;010f
	ld b,a			;0110
	ld b,d			;0111
	ld b,c			;0112
	ld d,e			;0113
	ld c,c			;0114
	ld b,e			;0115
	jr nz,$+75		;0116
	ld c,c			;0118
	jr nz,$+15		;0119
	nop			;011b
	push bc			;011c
	ld bc,00500h		;011d
	call 00060h		;0120
	pop bc			;0123
	ld a,(bc)			;0124
	and e			;0125
	ret z			;0126
	ld a,d			;0127
	rlca			;0128
	rlca			;0129
	jp 003feh		;012a
	ld e,02ch		;012d
	jp 019a2h		;012f
	rst 10h			;0132
	xor a			;0133
	ld bc,0803eh		;0134
	ld bc,0013eh		;0137
	push af			;013a
	rst 8			;013b
	jr z,$-49		;013c
	inc e			;013e
	dec hl			;013f
	cp 080h		;0140
	jp nc,01e4ah		;0142
	push af			;0145
	rst 8			;0146
	inc l			;0147
	call 02b1ch		;0148
	cp 030h		;014b
	jp nc,01e4ah		;014d
	ld d,0ffh		;0150
	inc d			;0152
	sub 003h		;0153
	jr nc,$-3		;0155
	add a,003h		;0157
	ld c,a			;0159
	pop af			;015a
	add a,a			;015b
	ld e,a			;015c
	ld b,002h		;015d
	ld a,d			;015f
	rra			;0160
	ld d,a			;0161
	ld a,e			;0162
	rra			;0163
	ld e,a			;0164
	djnz $-6		;0165
	ld a,c			;0167
	adc a,a			;0168
	inc a			;0169
	ld b,a			;016a
	xor a			;016b
	scf			;016c
	adc a,a			;016d
	djnz $-1		;016e
	ld c,a			;0170
	ld a,d			;0171
	or 03ch		;0172
	ld d,a			;0174
	ld a,(de)			;0175
	or a			;0176
	jp m,0017ch		;0177
	ld a,080h		;017a
	ld b,a			;017c
	pop af			;017d
	or a			;017e
	ld a,b			;017f
	jr z,$+18		;0180
	ld (de),a			;0182
	jp m,0018fh		;0183
	ld a,c			;0186
	cpl			;0187
	ld c,a			;0188
	ld a,(de)			;0189
	and c			;018a
	ld (de),a			;018b
	rst 8			;018c
	add hl,hl			;018d
	ret			;018e
	or c			;018f
	jr $-5		;0190
	and c			;0192
	add a,0ffh		;0193
	sbc a,a			;0195
	push hl			;0196
	call 0098dh		;0197
	pop hl			;019a
	jr $-15		;019b
	rst 10h			;019d
	push hl			;019e
	ld a,(04099h)		;019f
	or a			;01a2
	jr nz,$+8		;01a3
	call 00358h		;01a5
	or a			;01a8
	jr z,$+19		;01a9
	push af			;01ab
	xor a			;01ac
	ld (04099h),a		;01ad
	inc a			;01b0
	call 02857h		;01b1
	pop af			;01b4
	ld hl,(040d4h)		;01b5
	ld (hl),a			;01b8
	jp 02884h		;01b9
	ld hl,01928h		;01bc
	ld (04121h),hl		;01bf
	ld a,003h		;01c2
	ld (040afh),a		;01c4
	pop hl			;01c7
	ret			;01c8
	ld a,01ch		;01c9
	call 0033ah		;01cb
	ld a,01fh		;01ce
	jp 0033ah		;01d0
	ld a,r		;01d3
	ld (040abh),a		;01d5
	ret			;01d8
	ld a,(0403dh)		;01d9
	xor 001h		;01dc
	out (0ffh),a		;01de
	ld b,b			;01e0
	ld (0403dh),a		;01e1
	ret			;01e4
	call 001d9h		;01e5
	ld a,020h		;01e8
	dec a			;01ea
	jr nz,$-1		;01eb
	ret			;01ed
	ld a,024h		;01ee
	jr $-6		;01f0
	nop			;01f2
	nop			;01f3
	nop			;01f4
	nop			;01f5
	nop			;01f6
	nop			;01f7
	push hl			;01f8
	ld hl,0fb00h		;01f9
	jr $+29		;01fc
	ld a,(hl)			;01fe
	sub 023h		;01ff
	ld a,000h		;0201
	jr nz,$+15		;0203
	call 02b01h		;0205
	rst 8			;0208
	inc l			;0209
	ld a,e			;020a
	and d			;020b
	add a,002h		;020c
	jp nc,01e4ah		;020e
	dec a			;0211
	ld (037e4h),a		;0212
	push hl			;0215
	ld hl,0ff04h		;0216
	call 00221h		;0219
	pop hl			;021c
	ret			;021d
	ld hl,0ff00h		;021e
	ld a,(0403dh)		;0221
	and h			;0224
	or l			;0225
	out (0ffh),a		;0226
	ld (0403dh),a		;0228
	ret			;022b
	ld a,(03c3fh)		;022c
	xor 00ah		;022f
	ld (03c3fh),a		;0231
	ret			;0234
	push bc			;0235
	ld b,008h		;0236
	call 0023fh		;0238
	djnz $-3		;023b
	pop bc			;023d
	ret			;023e
	push bc			;023f
	ld c,a			;0240
	in a,(0ffh)		;0241
	ld b,a			;0243
	in a,(0ffh)		;0244
	xor b			;0246
	jp p,00244h		;0247
	xor b			;024a
	ld b,043h		;024b
	djnz $+0		;024d
	ld b,a			;024f
	in a,(0ffh)		;0250
	xor b			;0252
	rlca			;0253
	ld a,c			;0254
	rla			;0255
	pop bc			;0256
	ret			;0257
	ld hl,037ech		;0258
	ld (hl),0d0h		;025b
	jp 00674h		;025d
	nop			;0260
	call 00264h		;0261
	push bc			;0264
	push af			;0265
	ld b,008h		;0266
	ld c,a			;0268
	call 001e5h		;0269
	rlc c		;026c
	call nc,001eeh		;026e
	call c,001e5h		;0271
	ld a,a			;0274
	djnz $-12		;0275
	ld b,01eh		;0277
	djnz $+0		;0279
	pop af			;027b
	pop bc			;027c
	ret			;027d
	nop			;027e
	nop			;027f
	nop			;0280
	nop			;0281
	nop			;0282
	nop			;0283
	call 001feh		;0284
	ld b,0ffh		;0287
	xor a			;0289
	call 00264h		;028a
	djnz $-3		;028d
	ld a,0a5h		;028f
	jr $-45		;0291
	call 001feh		;0293
	xor a			;0296
	call 0023fh		;0297
	cp 0a5h		;029a
	jr nz,$-5		;029c
	ld a,02ah		;029e
	ld (03c3fh),a		;02a0
	ld (03c3eh),a		;02a3
	ret			;02a6
	nop			;02a7
	nop			;02a8
	call 00314h		;02a9
	ld (040dfh),hl		;02ac
	call 001f8h		;02af
	call 041e2h		;02b2
	ld sp,04288h		;02b5
	call 020feh		;02b8
	ld a,02ah		;02bb
	call 0032ah		;02bd
	call 01bb3h		;02c0
	jp c,006cch		;02c3
	rst 10h			;02c6
	jp z,01997h		;02c7
	cp 02fh		;02ca
	jr z,$+81		;02cc
	call 00293h		;02ce
	call 00235h		;02d1
	cp 055h		;02d4
	jr nz,$-5		;02d6
	ld b,006h		;02d8
	ld a,(hl)			;02da
	or a			;02db
	jr z,$+11		;02dc
	call 00235h		;02de
	cp (hl)			;02e1
	jr nz,$-17		;02e2
	inc hl			;02e4
	djnz $-11		;02e5
	call 0022ch		;02e7
	call 00235h		;02ea
	cp 078h		;02ed
	jr z,$-70		;02ef
	cp 03ch		;02f1
	jr nz,$-9		;02f3
	call 00235h		;02f5
	ld b,a			;02f8
	call 00314h		;02f9
	add a,l			;02fc
	ld c,a			;02fd
	call 00235h		;02fe
	ld (hl),a			;0301
	inc hl			;0302
	add a,c			;0303
	ld c,a			;0304
	djnz $-7		;0305
	call 00235h		;0307
	cp c			;030a
	jr z,$-36		;030b
	ld a,043h		;030d
	ld (03c3eh),a		;030f
	jr $-40		;0312
	call 00235h		;0314
	ld l,a			;0317
	call 00235h		;0318
	ld h,a			;031b
	ret			;031c
	ex de,hl			;031d
	ld hl,(040dfh)		;031e
	ex de,hl			;0321
	rst 10h			;0322
	call nz,01e5ah		;0323
	jr nz,$-116		;0326
	ex de,hl			;0328
	jp (hl)			;0329
	push bc			;032a
	ld c,a			;032b
	call 041c1h		;032c
	ld a,(0409ch)		;032f
	or a			;0332
	ld a,c			;0333
	pop bc			;0334
	jp m,035efh		;0335
	jr nz,$+100		;0338
	push de			;033a
	call 00033h		;033b
	push af			;033e
	call 00348h		;033f
	ld (040a6h),a		;0342
	pop af			;0345
	pop de			;0346
	ret			;0347
	ld a,(0403dh)		;0348
	and 008h		;034b
	ld a,(04020h)		;034d
	jr z,$+5		;0350
	rrca			;0352
	and 01fh		;0353
	and 03fh		;0355
	ret			;0357
	call 041c4h		;0358
	push de			;035b
	call 0002bh		;035c
	pop de			;035f
	ret			;0360
	xor a			;0361
	ld (04099h),a		;0362
	ld (040a6h),a		;0365
	call 041afh		;0368
	push bc			;036b
	ld hl,(040a7h)		;036c
	ld b,0f0h		;036f
	call 005d9h		;0371
	push af			;0374
	ld c,b			;0375
	ld b,000h		;0376
	add hl,bc			;0378
	ld (hl),000h		;0379
	ld hl,(040a7h)		;037b
	pop af			;037e
	pop bc			;037f
	dec hl			;0380
	ret c			;0381
	xor a			;0382
	ret			;0383
	call 00358h		;0384
	or a			;0387
	ret nz			;0388
	jr $-5		;0389
	xor a			;038b
	ld (0409ch),a		;038c
	ld a,(0409bh)		;038f
	or a			;0392
	ret z			;0393
	ld a,00dh		;0394
	push de			;0396
	call 0039ch		;0397
	pop de			;039a
	ret			;039b
	push af			;039c
	push de			;039d
	push bc			;039e
	ld c,a			;039f
	ld e,000h		;03a0
	cp 00ch		;03a2
	jr z,$+18		;03a4
	cp 00ah		;03a6
	jr nz,$+5		;03a8
	ld a,00dh		;03aa
	ld c,a			;03ac
	cp 00dh		;03ad
	jr z,$+7		;03af
	ld a,(0409bh)		;03b1
	inc a			;03b4
	ld e,a			;03b5
	ld a,e			;03b6
	ld (0409bh),a		;03b7
	ld a,c			;03ba
	call 0003bh		;03bb
	pop bc			;03be
	pop de			;03bf
	pop af			;03c0
	ret			;03c1
	push hl			;03c2
	push ix		;03c3
	push de			;03c5
	pop ix		;03c6
	push de			;03c8
	ld hl,003ddh		;03c9
	push hl			;03cc
	ld c,a			;03cd
	ld a,(de)			;03ce
	and b			;03cf
	cp b			;03d0
	jp nz,04033h		;03d1
	cp 002h		;03d4
	ld l,(ix+001h)		;03d6
	ld h,(ix+002h)		;03d9
	jp (hl)			;03dc
	pop de			;03dd
	pop ix		;03de
	pop hl			;03e0
	pop bc			;03e1
	ret			;03e2
	ld hl,04036h		;03e3
	ld bc,03801h		;03e6
	ld d,000h		;03e9
	ld a,(bc)			;03eb
	ld e,a			;03ec
	call 03003h		;03ed
	jr nz,$+10		;03f0
	inc d			;03f2
	inc l			;03f3
	rlc c		;03f4
	jp p,003ebh		;03f6
	ret			;03f9
	ld e,a			;03fa
	jp 0011ch		;03fb
	rlca			;03fe
	ld d,a			;03ff
	ld c,001h		;0400
	ld a,c			;0402
	and e			;0403
	jr nz,$+7		;0404
	inc d			;0406
	rlc c		;0407
	jr $-7		;0409
	ld a,(03880h)		;040b
	ld c,(ix+003h)		;040e
	or c			;0411
	ld b,a			;0412
	ld a,d			;0413
	cp 01eh		;0414
	jr nz,$+11		;0416
	ld a,080h		;0418
	xor c			;041a
	ld (ix+003h),a		;041b
	xor a			;041e
	jr $+55		;041f
	add a,060h		;0421
	cp 080h		;0423
	jr nc,$+22		;0425
	bit 6,b		;0427
	jr nz,$+46		;0429
	cp 060h		;042b
	jr z,$+6		;042d
	bit 7,b		;042f
	jr z,$+4		;0431
	xor 020h		;0433
	srl b		;0435
	jr c,$-4		;0437
	jr $+29		;0439
	sub 090h		;043b
	jr nc,$+16		;043d
	add a,040h		;043f
	cp 03ch		;0441
	jr c,$+4		;0443
	xor 010h		;0445
	srl b		;0447
	jr nc,$+13		;0449
	jr $-6		;044b
	rlca			;044d
	srl b		;044e
	adc a,050h		;0450
	ld l,a			;0452
	ld h,000h		;0453
	ld a,(hl)			;0455
	ld d,a			;0456
	ld b,060h		;0457
	call 001e5h		;0459
	djnz $-3		;045c
	ld a,d			;045e
	cp 001h		;045f
	ret nz			;0461
	rst 28h			;0462
	ret			;0463
	ld l,(ix+003h)		;0464
	ld h,(ix+004h)		;0467
	jr c,$+48		;046a
	ld a,(ix+005h)		;046c
	or a			;046f
	jr z,$+3		;0470
	ld (hl),a			;0472
	ld a,c			;0473
	cp 020h		;0474
	jp c,00506h		;0476
	cp 080h		;0479
	jr nc,$+43		;047b
	call 00541h		;047d
	ld a,h			;0480
	and 003h		;0481
	or 03ch		;0483
	ld h,a			;0485
	ld d,(hl)			;0486
	ld a,(ix+005h)		;0487
	or a			;048a
	jr z,$+7		;048b
	ld (ix+005h),d		;048d
	ld (hl),00dh		;0490
	ld (ix+003h),l		;0492
	ld (ix+004h),h		;0495
	ld a,c			;0498
	ret			;0499
	ld a,(ix+005h)		;049a
	or a			;049d
	ret nz			;049e
	ld a,(hl)			;049f
	ret			;04a0
	ld a,l			;04a1
	and 0c0h		;04a2
	ld l,a			;04a4
	ret			;04a5
	cp 0c0h		;04a6
	jr c,$-43		;04a8
	sub 0c0h		;04aa
	jr z,$-44		;04ac
	ld b,a			;04ae
	ld a,020h		;04af
	call 00541h		;04b1
	djnz $-5		;04b4
	jr $-54		;04b6
	ld a,(hl)			;04b8
	ld (ix+005h),a		;04b9
	ret			;04bc
	xor a			;04bd
	jr $-5		;04be
	ld hl,03c00h		;04c0
	ld a,(0403dh)		;04c3
	and 0f7h		;04c6
	ld (0403dh),a		;04c8
	out (0ffh),a		;04cb
	ret			;04cd
	dec hl			;04ce
	ld a,(0403dh)		;04cf
	and 008h		;04d2
	jr z,$+3		;04d4
	dec hl			;04d6
	ld (hl),020h		;04d7
	ret			;04d9
	ld a,(0403dh)		;04da
	and 008h		;04dd
	call nz,004e2h		;04df
	ld a,l			;04e2
	and 03fh		;04e3
	dec hl			;04e5
	ret nz			;04e6
	ld de,00040h		;04e7
	add hl,de			;04ea
	ret			;04eb
	inc hl			;04ec
	ld a,l			;04ed
	and 03fh		;04ee
	ret nz			;04f0
	ld de,0ffc0h		;04f1
	add hl,de			;04f4
	ret			;04f5
	ld a,(0403dh)		;04f6
	or 008h		;04f9
	ld (0403dh),a		;04fb
	out (0ffh),a		;04fe
	inc hl			;0500
	ld a,l			;0501
	and 0feh		;0502
	ld l,a			;0504
	ret			;0505
	ld de,00480h		;0506
	push de			;0509
	cp 008h		;050a
	jr z,$-62		;050c
	cp 00ah		;050e
	ret c			;0510
	cp 00eh		;0511
	jr c,$+81		;0513
	jr z,$-93		;0515
	cp 00fh		;0517
	jr z,$-92		;0519
	cp 017h		;051b
	jr z,$-39		;051d
	cp 018h		;051f
	jr z,$-71		;0521
	cp 019h		;0523
	jr z,$-57		;0525
	cp 01ah		;0527
	jr z,$-66		;0529
	cp 01bh		;052b
	jr z,$-60		;052d
	cp 01ch		;052f
	jr z,$-113		;0531
	cp 01dh		;0533
	jp z,004a1h		;0535
	cp 01eh		;0538
	jr z,$+57		;053a
	cp 01fh		;053c
	jr z,$+62		;053e
	ret			;0540
	ld (hl),a			;0541
	inc hl			;0542
	ld a,(0403dh)		;0543
	and 008h		;0546
	jr z,$+3		;0548
	inc hl			;054a
	ld a,h			;054b
	cp 040h		;054c
	ret nz			;054e
	ld de,0ffc0h		;054f
	add hl,de			;0552
	push hl			;0553
	ld de,03c00h		;0554
	ld hl,03c40h		;0557
	push bc			;055a
	ld bc,003c0h		;055b
	ldir		;055e
	pop bc			;0560
	ex de,hl			;0561
	jr $+27		;0562
	ld a,l			;0564
	and 0c0h		;0565
	ld l,a			;0567
	push hl			;0568
	ld de,00040h		;0569
	add hl,de			;056c
	ld a,h			;056d
	cp 040h		;056e
	jr z,$-28		;0570
	pop de			;0572
	push hl			;0573
	ld d,h			;0574
	ld a,l			;0575
	or 03fh		;0576
	ld e,a			;0578
	inc de			;0579
	jr $+6		;057a
	push hl			;057c
	ld de,04000h		;057d
	ld (hl),020h		;0580
	inc hl			;0582
	ld a,h			;0583
	cp d			;0584
	jr nz,$-5		;0585
	ld a,l			;0587
	cp e			;0588
	jr nz,$-9		;0589
	pop hl			;058b
	ret			;058c
	ld a,c			;058d
	or a			;058e
	jr z,$+66		;058f
	cp 00bh		;0591
	jr z,$+12		;0593
	cp 00ch		;0595
	jr nz,$+29		;0597
	xor a			;0599
	or (ix+003h)		;059a
	jr z,$+23		;059d
	ld a,(ix+003h)		;059f
	sub (ix+004h)		;05a2
	ld b,a			;05a5
	call 005d1h		;05a6
	jr nz,$-3		;05a9
	ld a,00ah		;05ab
	ld (037e8h),a		;05ad
	djnz $-10		;05b0
	jr $+26		;05b2
	push af			;05b4
	call 005d1h		;05b5
	jr nz,$-3		;05b8
	pop af			;05ba
	ld (037e8h),a		;05bb
	cp 00dh		;05be
	ret nz			;05c0
	inc (ix+004h)		;05c1
	ld a,(ix+004h)		;05c4
	cp (ix+003h)		;05c7
	ld a,c			;05ca
	ret nz			;05cb
	ld (ix+004h),000h		;05cc
	ret			;05d0
	ld a,(037e8h)		;05d1
	and 0f0h		;05d4
	cp 030h		;05d6
	ret			;05d8
	push hl			;05d9
	ld a,00eh		;05da
	call 00033h		;05dc
	ld c,b			;05df
	call 00049h		;05e0
	cp 020h		;05e3
	jr nc,$+39		;05e5
	cp 00dh		;05e7
	jp z,00662h		;05e9
	cp 01fh		;05ec
	jr z,$+43		;05ee
	cp 001h		;05f0
	jr z,$+111		;05f2
	ld de,005e0h		;05f4
	push de			;05f7
	cp 008h		;05f8
	jr z,$+54		;05fa
	cp 018h		;05fc
	jr z,$+45		;05fe
	cp 009h		;0600
	jr z,$+68		;0602
	cp 019h		;0604
	jr z,$+59		;0606
	cp 00ah		;0608
	ret nz			;060a
	pop de			;060b
	ld (hl),a			;060c
	ld a,b			;060d
	or a			;060e
	jr z,$-47		;060f
	ld a,(hl)			;0611
	inc hl			;0612
	call 00033h		;0613
	dec b			;0616
	jr $-55		;0617
	call 001c9h		;0619
	ld b,c			;061c
	pop hl			;061d
	push hl			;061e
	jp 005e0h		;061f
	call 00630h		;0622
	dec hl			;0625
	ld a,(hl)			;0626
	inc hl			;0627
	cp 00ah		;0628
	ret z			;062a
	ld a,b			;062b
	cp c			;062c
	jr nz,$-11		;062d
	ret			;062f
	ld a,b			;0630
	cp c			;0631
	ret z			;0632
	dec hl			;0633
	ld a,(hl)			;0634
	cp 00ah		;0635
	inc hl			;0637
	ret z			;0638
	dec hl			;0639
	ld a,008h		;063a
	call 00033h		;063c
	inc b			;063f
	ret			;0640
	ld a,017h		;0641
	jp 00033h		;0643
	call 00348h		;0646
	and 007h		;0649
	cpl			;064b
	inc a			;064c
	add a,008h		;064d
	ld e,a			;064f
	ld a,b			;0650
	or a			;0651
	ret z			;0652
	ld a,020h		;0653
	ld (hl),a			;0655
	inc hl			;0656
	push de			;0657
	call 00033h		;0658
	pop de			;065b
	dec b			;065c
	dec e			;065d
	ret z			;065e
	jr $-15		;065f
	scf			;0661
	push af			;0662
	ld a,00dh		;0663
	ld (hl),a			;0665
	call 00033h		;0666
	ld a,00fh		;0669
	call 00033h		;066b
	ld a,c			;066e
	sub b			;066f
	ld b,a			;0670
	pop af			;0671
	pop hl			;0672
	ret			;0673
	out (0ffh),a		;0674
	ld hl,006d2h		;0676
	ld de,04000h		;0679
	ld bc,00036h		;067c
	ldir		;067f
	dec a			;0681
	dec a			;0682
	jr nz,$-13		;0683
	ld b,027h		;0685
	ld (de),a			;0687
	inc de			;0688
	djnz $-2		;0689
	ld a,(03840h)		;068b
	and 004h		;068e
	jp nz,00075h		;0690
	ld sp,0407dh		;0693
	ld a,(037ech)		;0696
	nop			;0699
	cp 080h		;069a
	jp nz,00075h		;069c
	ld a,001h		;069f
	ld (037e1h),a		;06a1
	ld hl,037ech		;06a4
	ld de,037efh		;06a7
	ld (hl),003h		;06aa
	ld bc,00000h		;06ac
	call 00060h		;06af
	bit 0,(hl)		;06b2
	jr nz,$-2		;06b4
	xor a			;06b6
	ld (037eeh),a		;06b7
	ld bc,04200h		;06ba
	ld a,08ch		;06bd
	ld (hl),a			;06bf
	bit 1,(hl)		;06c0
	jr z,$-2		;06c2
	ld a,(de)			;06c4
	ld (bc),a			;06c5
	inc c			;06c6
	jr nz,$-7		;06c7
	jp 04200h		;06c9
	ld bc,01a18h		;06cc
	jp 019aeh		;06cf
	jp 01c96h		;06d2
	jp 01d78h		;06d5
	jp 01c90h		;06d8
	jp 025d9h		;06db
	ret			;06de
	nop			;06df
	nop			;06e0
	ret			;06e1
	nop			;06e2
	nop			;06e3
	ei			;06e4
	ret			;06e5
	nop			;06e6
	ld bc,003e3h		;06e7
	nop			;06ea
	nop			;06eb
	nop			;06ec
	ld c,e			;06ed
	ld c,c			;06ee
	rlca			;06ef
	ld h,h			;06f0
	inc b			;06f1
	nop			;06f2
	inc a			;06f3
	nop			;06f4
	ld b,h			;06f5
	ld c,a			;06f6
	ld b,08dh		;06f7
	dec b			;06f9
	ld b,e			;06fa
	nop			;06fb
	nop			;06fc
	ld d,b			;06fd
	ld d,d			;06fe
	jp 05000h		;06ff
	rst 0			;0702
	nop			;0703
	nop			;0704
	ld a,000h		;0705
	ret			;0707
	ld hl,01380h		;0708
	call 009c2h		;070b
	jr $+8		;070e
	call 009c2h		;0710
	call 00982h		;0713
	ld a,b			;0716
	or a			;0717
	ret z			;0718
	ld a,(04124h)		;0719
	or a			;071c
	jp z,009b4h		;071d
	sub b			;0720
	jr nc,$+14		;0721
	cpl			;0723
	inc a			;0724
	ex de,hl			;0725
	call 009a4h		;0726
	ex de,hl			;0729
	call 009b4h		;072a
	pop bc			;072d
	pop de			;072e
	cp 019h		;072f
	ret nc			;0731
	push af			;0732
	call 009dfh		;0733
	ld h,a			;0736
	pop af			;0737
	call 007d7h		;0738
	or h			;073b
	ld hl,04121h		;073c
	jp p,00754h		;073f
	call 007b7h		;0742
	jp nc,00796h		;0745
	inc hl			;0748
	inc (hl)			;0749
	jp z,007b2h		;074a
	ld l,001h		;074d
	call 007ebh		;074f
	jr $+68		;0752
	xor a			;0754
	sub b			;0755
	ld b,a			;0756
	ld a,(hl)			;0757
	sbc a,e			;0758
	ld e,a			;0759
	inc hl			;075a
	ld a,(hl)			;075b
	sbc a,d			;075c
	ld d,a			;075d
	inc hl			;075e
	ld a,(hl)			;075f
	sbc a,c			;0760
	ld c,a			;0761
	call c,007c3h		;0762
	ld l,b			;0765
	ld h,e			;0766
	xor a			;0767
	ld b,a			;0768
	ld a,c			;0769
	or a			;076a
	jr nz,$+26		;076b
	ld c,d			;076d
	ld d,h			;076e
	ld h,l			;076f
	ld l,a			;0770
	ld a,b			;0771
	sub 008h		;0772
	cp 0e0h		;0774
	jr nz,$-14		;0776
	xor a			;0778
	ld (04124h),a		;0779
	ret			;077c
	dec b			;077d
	add hl,hl			;077e
	ld a,d			;077f
	rla			;0780
	ld d,a			;0781
	ld a,c			;0782
	adc a,a			;0783
	ld c,a			;0784
	jp p,0077dh		;0785
	ld a,b			;0788
	ld e,h			;0789
	ld b,l			;078a
	or a			;078b
	jr z,$+10		;078c
	ld hl,04124h		;078e
	add a,(hl)			;0791
	ld (hl),a			;0792
	jr nc,$-27		;0793
	ret z			;0795
	ld a,b			;0796
	ld hl,04124h		;0797
	or a			;079a
	call m,007a8h		;079b
	ld b,(hl)			;079e
	inc hl			;079f
	ld a,(hl)			;07a0
	and 080h		;07a1
	xor c			;07a3
	ld c,a			;07a4
	jp 009b4h		;07a5
	inc e			;07a8
	ret nz			;07a9
	inc d			;07aa
	ret nz			;07ab
	inc c			;07ac
	ret nz			;07ad
	ld c,080h		;07ae
	inc (hl)			;07b0
	ret nz			;07b1
	ld e,00ah		;07b2
	jp 019a2h		;07b4
	ld a,(hl)			;07b7
	add a,e			;07b8
	ld e,a			;07b9
	inc hl			;07ba
	ld a,(hl)			;07bb
	adc a,d			;07bc
	ld d,a			;07bd
	inc hl			;07be
	ld a,(hl)			;07bf
	adc a,c			;07c0
	ld c,a			;07c1
	ret			;07c2
	ld hl,04125h		;07c3
	ld a,(hl)			;07c6
	cpl			;07c7
	ld (hl),a			;07c8
	xor a			;07c9
	ld l,a			;07ca
	sub b			;07cb
	ld b,a			;07cc
	ld a,l			;07cd
	sbc a,e			;07ce
	ld e,a			;07cf
	ld a,l			;07d0
	sbc a,d			;07d1
	ld d,a			;07d2
	ld a,l			;07d3
	sbc a,c			;07d4
	ld c,a			;07d5
	ret			;07d6
	ld b,000h		;07d7
	sub 008h		;07d9
	jr c,$+9		;07db
	ld b,e			;07dd
	ld e,d			;07de
	ld d,c			;07df
	ld c,000h		;07e0
	jr $-9		;07e2
	add a,009h		;07e4
	ld l,a			;07e6
	xor a			;07e7
	dec l			;07e8
	ret z			;07e9
	ld a,c			;07ea
	rra			;07eb
	ld c,a			;07ec
	ld a,d			;07ed
	rra			;07ee
	ld d,a			;07ef
	ld a,e			;07f0
	rra			;07f1
	ld e,a			;07f2
	ld a,b			;07f3
	rra			;07f4
	ld b,a			;07f5
	jr $-15		;07f6
	nop			;07f8
	nop			;07f9
	nop			;07fa
	add a,c			;07fb
	inc bc			;07fc
	xor d			;07fd
	ld d,(hl)			;07fe
	add hl,de			;07ff
	add a,b			;0800
	pop af			;0801
	ld (08076h),hl		;0802
	ld b,l			;0805
	xor d			;0806
	jr c,$-124		;0807
	call 00955h		;0809
	or a			;080c
	jp pe,01e4ah		;080d
	ld hl,04124h		;0810
	ld a,(hl)			;0813
	ld bc,08035h		;0814
	ld de,004f3h		;0817
	sub b			;081a
	push af			;081b
	ld (hl),b			;081c
	push de			;081d
	push bc			;081e
	call 00716h		;081f
	pop bc			;0822
	pop de			;0823
	inc b			;0824
	call 008a2h		;0825
	ld hl,007f8h		;0828
	call 00710h		;082b
	ld hl,007fch		;082e
	call 0149ah		;0831
	ld bc,08080h		;0834
	ld de,00000h		;0837
	call 00716h		;083a
	pop af			;083d
	call 00f89h		;083e
	ld bc,08031h		;0841
	ld de,07218h		;0844
	call 00955h		;0847
	ret z			;084a
	ld l,000h		;084b
	call 00914h		;084d
	ld a,c			;0850
	ld (0414fh),a		;0851
	ex de,hl			;0854
	ld (04150h),hl		;0855
	ld bc,00000h		;0858
	ld d,b			;085b
	ld e,b			;085c
	ld hl,00765h		;085d
	push hl			;0860
	ld hl,00869h		;0861
	push hl			;0864
	push hl			;0865
	ld hl,04121h		;0866
	ld a,(hl)			;0869
	inc hl			;086a
	or a			;086b
	jr z,$+38		;086c
	push hl			;086e
	ld l,008h		;086f
	rra			;0871
	ld h,a			;0872
	ld a,c			;0873
	jr nc,$+13		;0874
	push hl			;0876
	ld hl,(04150h)		;0877
	add hl,de			;087a
	ex de,hl			;087b
	pop hl			;087c
	ld a,(0414fh)		;087d
	adc a,c			;0880
	rra			;0881
	ld c,a			;0882
	ld a,d			;0883
	rra			;0884
	ld d,a			;0885
	ld a,e			;0886
	rra			;0887
	ld e,a			;0888
	ld a,b			;0889
	rra			;088a
	ld b,a			;088b
	dec l			;088c
	ld a,h			;088d
	jr nz,$-29		;088e
	pop hl			;0890
	ret			;0891
	ld b,e			;0892
	ld e,d			;0893
	ld d,c			;0894
	ld c,a			;0895
	ret			;0896
	call 009a4h		;0897
	ld hl,00dd8h		;089a
	call 009b1h		;089d
	pop bc			;08a0
	pop de			;08a1
	call 00955h		;08a2
	jp z,0199ah		;08a5
	ld l,0ffh		;08a8
	call 00914h		;08aa
	inc (hl)			;08ad
	inc (hl)			;08ae
	dec hl			;08af
	ld a,(hl)			;08b0
	ld (04089h),a		;08b1
	dec hl			;08b4
	ld a,(hl)			;08b5
	ld (04085h),a		;08b6
	dec hl			;08b9
	ld a,(hl)			;08ba
	ld (04081h),a		;08bb
	ld b,c			;08be
	ex de,hl			;08bf
	xor a			;08c0
	ld c,a			;08c1
	ld d,a			;08c2
	ld e,a			;08c3
	ld (0408ch),a		;08c4
	push hl			;08c7
	push bc			;08c8
	ld a,l			;08c9
	call 04080h		;08ca
	sbc a,000h		;08cd
	ccf			;08cf
	jr nc,$+9		;08d0
	ld (0408ch),a		;08d2
	pop af			;08d5
	pop af			;08d6
	scf			;08d7
	jp nc,0e1c1h		;08d8
	ld a,c			;08db
	inc a			;08dc
	dec a			;08dd
	rra			;08de
	jp m,00797h		;08df
	rla			;08e2
	ld a,e			;08e3
	rla			;08e4
	ld e,a			;08e5
	ld a,d			;08e6
	rla			;08e7
	ld d,a			;08e8
	ld a,c			;08e9
	rla			;08ea
	ld c,a			;08eb
	add hl,hl			;08ec
	ld a,b			;08ed
	rla			;08ee
	ld b,a			;08ef
	ld a,(0408ch)		;08f0
	rla			;08f3
	ld (0408ch),a		;08f4
	ld a,c			;08f7
	or d			;08f8
	or e			;08f9
	jr nz,$-51		;08fa
	push hl			;08fc
	ld hl,04124h		;08fd
	dec (hl)			;0900
	pop hl			;0901
	jr nz,$-59		;0902
	jp 007b2h		;0904
	ld a,0ffh		;0907
	ld l,0afh		;0909
	ld hl,0412dh		;090b
	ld c,(hl)			;090e
	inc hl			;090f
	xor (hl)			;0910
	ld b,a			;0911
	ld l,000h		;0912
	ld a,b			;0914
	or a			;0915
	jr z,$+33		;0916
	ld a,l			;0918
	ld hl,04124h		;0919
	xor (hl)			;091c
	add a,b			;091d
	ld b,a			;091e
	rra			;091f
	xor b			;0920
	ld a,b			;0921
	jp p,00936h		;0922
	add a,080h		;0925
	ld (hl),a			;0927
	jp z,00890h		;0928
	call 009dfh		;092b
	ld (hl),a			;092e
	dec hl			;092f
	ret			;0930
	call 00955h		;0931
	cpl			;0934
	pop hl			;0935
	or a			;0936
	pop hl			;0937
	jp p,00778h		;0938
	jp 007b2h		;093b
	call 009bfh		;093e
	ld a,b			;0941
	or a			;0942
	ret z			;0943
	add a,002h		;0944
	jp c,007b2h		;0946
	ld b,a			;0949
	call 00716h		;094a
	ld hl,04124h		;094d
	inc (hl)			;0950
	ret nz			;0951
	jp 007b2h		;0952
	ld a,(04124h)		;0955
	or a			;0958
	ret z			;0959
	ld a,(04123h)		;095a
	cp 02fh		;095d
	rla			;095f
	sbc a,a			;0960
	ret nz			;0961
	inc a			;0962
	ret			;0963
	ld b,088h		;0964
	ld de,00000h		;0966
	ld hl,04124h		;0969
	ld c,a			;096c
	ld (hl),b			;096d
	ld b,000h		;096e
	inc hl			;0970
	ld (hl),080h		;0971
	rla			;0973
	jp 00762h		;0974
	call 00994h		;0977
	ret p			;097a
	rst 20h			;097b
	jp m,00c5bh		;097c
	jp z,00af6h		;097f
	ld hl,04123h		;0982
	ld a,(hl)			;0985
	xor 080h		;0986
	ld (hl),a			;0988
	ret			;0989
	call 00994h		;098a
	ld l,a			;098d
	rla			;098e
	sbc a,a			;098f
	ld h,a			;0990
	jp 00a9ah		;0991
	rst 20h			;0994
	jp z,00af6h		;0995
	jp p,00955h		;0998
	ld hl,(04121h)		;099b
	ld a,h			;099e
	or l			;099f
	ret z			;09a0
	ld a,h			;09a1
	jr $-67		;09a2
	ex de,hl			;09a4
	ld hl,(04121h)		;09a5
	ex (sp),hl			;09a8
	push hl			;09a9
	ld hl,(04123h)		;09aa
	ex (sp),hl			;09ad
	push hl			;09ae
	ex de,hl			;09af
	ret			;09b0
	call 009c2h		;09b1
	ex de,hl			;09b4
	ld (04121h),hl		;09b5
	ld h,b			;09b8
	ld l,c			;09b9
	ld (04123h),hl		;09ba
	ex de,hl			;09bd
	ret			;09be
	ld hl,04121h		;09bf
	ld e,(hl)			;09c2
	inc hl			;09c3
	ld d,(hl)			;09c4
	inc hl			;09c5
	ld c,(hl)			;09c6
	inc hl			;09c7
	ld b,(hl)			;09c8
	inc hl			;09c9
	ret			;09ca
	ld de,04121h		;09cb
	ld b,004h		;09ce
	jr $+7		;09d0
	ex de,hl			;09d2
	ld a,(040afh)		;09d3
	ld b,a			;09d6
	ld a,(de)			;09d7
	ld (hl),a			;09d8
	inc de			;09d9
	inc hl			;09da
	dec b			;09db
	jr nz,$-5		;09dc
	ret			;09de
	ld hl,04123h		;09df
	ld a,(hl)			;09e2
	rlca			;09e3
	scf			;09e4
	rra			;09e5
	ld (hl),a			;09e6
	ccf			;09e7
	rra			;09e8
	inc hl			;09e9
	inc hl			;09ea
	ld (hl),a			;09eb
	ld a,c			;09ec
	rlca			;09ed
	scf			;09ee
	rra			;09ef
	ld c,a			;09f0
	rra			;09f1
	xor (hl)			;09f2
	ret			;09f3
	ld hl,04127h		;09f4
	ld de,009d2h		;09f7
	jr $+8		;09fa
	ld hl,04127h		;09fc
	ld de,009d3h		;09ff
	push de			;0a02
	ld de,04121h		;0a03
	rst 20h			;0a06
	ret c			;0a07
	ld de,0411dh		;0a08
	ret			;0a0b
	ld a,b			;0a0c
	or a			;0a0d
	jp z,00955h		;0a0e
	ld hl,0095eh		;0a11
	push hl			;0a14
	call 00955h		;0a15
	ld a,c			;0a18
	ret z			;0a19
	ld hl,04123h		;0a1a
	xor (hl)			;0a1d
	ld a,c			;0a1e
	ret m			;0a1f
	call 00a26h		;0a20
	rra			;0a23
	xor c			;0a24
	ret			;0a25
	inc hl			;0a26
	ld a,b			;0a27
	cp (hl)			;0a28
	ret nz			;0a29
	dec hl			;0a2a
	ld a,c			;0a2b
	cp (hl)			;0a2c
	ret nz			;0a2d
	dec hl			;0a2e
	ld a,d			;0a2f
	cp (hl)			;0a30
	ret nz			;0a31
	dec hl			;0a32
	ld a,e			;0a33
	sub (hl)			;0a34
	ret nz			;0a35
	pop hl			;0a36
	pop hl			;0a37
	ret			;0a38
	ld a,d			;0a39
	xor h			;0a3a
	ld a,h			;0a3b
	jp m,0095fh		;0a3c
	cp d			;0a3f
	jp nz,00960h		;0a40
	ld a,l			;0a43
	sub e			;0a44
	jp nz,00960h		;0a45
	ret			;0a48
	ld hl,04127h		;0a49
	call 009d3h		;0a4c
	ld de,0412eh		;0a4f
	ld a,(de)			;0a52
	or a			;0a53
	jp z,00955h		;0a54
	ld hl,0095eh		;0a57
	push hl			;0a5a
	call 00955h		;0a5b
	dec de			;0a5e
	ld a,(de)			;0a5f
	ld c,a			;0a60
	ret z			;0a61
	ld hl,04123h		;0a62
	xor (hl)			;0a65
	ld a,c			;0a66
	ret m			;0a67
	inc de			;0a68
	inc hl			;0a69
	ld b,008h		;0a6a
	ld a,(de)			;0a6c
	sub (hl)			;0a6d
	jp nz,00a23h		;0a6e
	dec de			;0a71
	dec hl			;0a72
	dec b			;0a73
	jr nz,$-8		;0a74
	pop bc			;0a76
	ret			;0a77
	call 00a4fh		;0a78
	jp nz,0095eh		;0a7b
	ret			;0a7e
	rst 20h			;0a7f
	ld hl,(04121h)		;0a80
	ret m			;0a83
	jp z,00af6h		;0a84
	call nc,00ab9h		;0a87
	ld hl,007b2h		;0a8a
	push hl			;0a8d
	ld a,(04124h)		;0a8e
	cp 090h		;0a91
	jr nc,$+16		;0a93
	call 00afbh		;0a95
	ex de,hl			;0a98
	pop de			;0a99
	ld (04121h),hl		;0a9a
	ld a,002h		;0a9d
	ld (040afh),a		;0a9f
	ret			;0aa2
	ld bc,09080h		;0aa3
	ld de,00000h		;0aa6
	call 00a0ch		;0aa9
	ret nz			;0aac
	ld h,c			;0aad
	ld l,d			;0aae
	jr $-22		;0aaf
	rst 20h			;0ab1
	ret po			;0ab2
	jp m,00acch		;0ab3
	jp z,00af6h		;0ab6
	call 009bfh		;0ab9
	call 00aefh		;0abc
	ld a,b			;0abf
	or a			;0ac0
	ret z			;0ac1
	call 009dfh		;0ac2
	ld hl,04120h		;0ac5
	ld b,(hl)			;0ac8
	jp 00796h		;0ac9
	ld hl,(04121h)		;0acc
	call 00aefh		;0acf
	ld a,h			;0ad2
	ld d,l			;0ad3
	ld e,000h		;0ad4
	ld b,090h		;0ad6
	jp 00969h		;0ad8
	rst 20h			;0adb
	ret nc			;0adc
	jp z,00af6h		;0add
	call m,00acch		;0ae0
	ld hl,00000h		;0ae3
	ld (0411dh),hl		;0ae6
	ld (0411fh),hl		;0ae9
	ld a,008h		;0aec
	ld bc,0043eh		;0aee
	jp 00a9fh		;0af1
	rst 20h			;0af4
	ret z			;0af5
	ld e,018h		;0af6
	jp 019a2h		;0af8
	ld b,a			;0afb
	ld c,a			;0afc
	ld d,a			;0afd
	ld e,a			;0afe
	or a			;0aff
	ret z			;0b00
	push hl			;0b01
	call 009bfh		;0b02
	call 009dfh		;0b05
	xor (hl)			;0b08
	ld h,a			;0b09
	call m,00b1fh		;0b0a
	ld a,098h		;0b0d
	sub b			;0b0f
	call 007d7h		;0b10
	ld a,h			;0b13
	rla			;0b14
	call c,007a8h		;0b15
	ld b,000h		;0b18
	call c,007c3h		;0b1a
	pop hl			;0b1d
	ret			;0b1e
	dec de			;0b1f
	ld a,d			;0b20
	and e			;0b21
	inc a			;0b22
	ret nz			;0b23
	dec bc			;0b24
	ret			;0b25
	rst 20h			;0b26
	ret m			;0b27
	call 00955h		;0b28
	jp p,00b37h		;0b2b
	call 00982h		;0b2e
	call 00b37h		;0b31
	jp 0097bh		;0b34
	rst 20h			;0b37
	ret m			;0b38
	jr nc,$+32		;0b39
	jr z,$-69		;0b3b
	call 00a8eh		;0b3d
	ld hl,04124h		;0b40
	ld a,(hl)			;0b43
	cp 098h		;0b44
	ld a,(04121h)		;0b46
	ret nc			;0b49
	ld a,(hl)			;0b4a
	call 00afbh		;0b4b
	ld (hl),098h		;0b4e
	ld a,e			;0b50
	push af			;0b51
	ld a,c			;0b52
	rla			;0b53
	call 00762h		;0b54
	pop af			;0b57
	ret			;0b58
	ld hl,04124h		;0b59
	ld a,(hl)			;0b5c
	cp 090h		;0b5d
	jp c,00a7fh		;0b5f
	jr nz,$+22		;0b62
	ld c,a			;0b64
	dec hl			;0b65
	ld a,(hl)			;0b66
	xor 080h		;0b67
	ld b,006h		;0b69
	dec hl			;0b6b
	or (hl)			;0b6c
	dec b			;0b6d
	jr nz,$-3		;0b6e
	or a			;0b70
	ld hl,08000h		;0b71
	jp z,00a9ah		;0b74
	ld a,c			;0b77
	cp 0b8h		;0b78
	ret nc			;0b7a
	push af			;0b7b
	call 009bfh		;0b7c
	call 009dfh		;0b7f
	xor (hl)			;0b82
	dec hl			;0b83
	ld (hl),0b8h		;0b84
	push af			;0b86
	call m,00ba0h		;0b87
	ld hl,04123h		;0b8a
	ld a,0b8h		;0b8d
	sub b			;0b8f
	call 00d69h		;0b90
	pop af			;0b93
	call m,00d20h		;0b94
	xor a			;0b97
	ld (0411ch),a		;0b98
	pop af			;0b9b
	ret nc			;0b9c
	jp 00cd8h		;0b9d
	ld hl,0411dh		;0ba0
	ld a,(hl)			;0ba3
	dec (hl)			;0ba4
	or a			;0ba5
	inc hl			;0ba6
	jr z,$-4		;0ba7
	ret			;0ba9
	push hl			;0baa
	ld hl,00000h		;0bab
	ld a,b			;0bae
	or c			;0baf
	jr z,$+20		;0bb0
	ld a,010h		;0bb2
	add hl,hl			;0bb4
	jp c,0273dh		;0bb5
	ex de,hl			;0bb8
	add hl,hl			;0bb9
	ex de,hl			;0bba
	jr nc,$+6		;0bbb
	add hl,bc			;0bbd
	jp c,0273dh		;0bbe
	dec a			;0bc1
	jr nz,$-14		;0bc2
	ex de,hl			;0bc4
	pop hl			;0bc5
	ret			;0bc6
	ld a,h			;0bc7
	rla			;0bc8
	sbc a,a			;0bc9
	ld b,a			;0bca
	call 00c51h		;0bcb
	ld a,c			;0bce
	sbc a,b			;0bcf
	jr $+5		;0bd0
	ld a,h			;0bd2
	rla			;0bd3
	sbc a,a			;0bd4
	ld b,a			;0bd5
	push hl			;0bd6
	ld a,d			;0bd7
	rla			;0bd8
	sbc a,a			;0bd9
	add hl,de			;0bda
	adc a,b			;0bdb
	rrca			;0bdc
	xor h			;0bdd
	jp p,00a99h		;0bde
	push bc			;0be1
	ex de,hl			;0be2
	call 00acfh		;0be3
	pop af			;0be6
	pop hl			;0be7
	call 009a4h		;0be8
	ex de,hl			;0beb
	call 00c6bh		;0bec
	jp 00f8fh		;0bef
	ld a,h			;0bf2
	or l			;0bf3
	jp z,00a9ah		;0bf4
	push hl			;0bf7
	push de			;0bf8
	call 00c45h		;0bf9
	push bc			;0bfc
	ld b,h			;0bfd
	ld c,l			;0bfe
	ld hl,00000h		;0bff
	ld a,010h		;0c02
	add hl,hl			;0c04
	jr c,$+33		;0c05
	ex de,hl			;0c07
	add hl,hl			;0c08
	ex de,hl			;0c09
	jr nc,$+6		;0c0a
	add hl,bc			;0c0c
	jp c,00c26h		;0c0d
	dec a			;0c10
	jr nz,$-13		;0c11
	pop bc			;0c13
	pop de			;0c14
	ld a,h			;0c15
	or a			;0c16
	jp m,00c1fh		;0c17
	pop de			;0c1a
	ld a,b			;0c1b
	jp 00c4dh		;0c1c
	xor 080h		;0c1f
	or l			;0c21
	jr z,$+21		;0c22
	ex de,hl			;0c24
	ld bc,0e1c1h		;0c25
	call 00acfh		;0c28
	pop hl			;0c2b
	call 009a4h		;0c2c
	call 00acfh		;0c2f
	pop bc			;0c32
	pop de			;0c33
	jp 00847h		;0c34
	ld a,b			;0c37
	or a			;0c38
	pop bc			;0c39
	jp m,00a9ah		;0c3a
	push de			;0c3d
	call 00acfh		;0c3e
	pop de			;0c41
	jp 00982h		;0c42
	ld a,h			;0c45
	xor d			;0c46
	ld b,a			;0c47
	call 00c4ch		;0c48
	ex de,hl			;0c4b
	ld a,h			;0c4c
	or a			;0c4d
	jp p,00a9ah		;0c4e
	xor a			;0c51
	ld c,a			;0c52
	sub l			;0c53
	ld l,a			;0c54
	ld a,c			;0c55
	sbc a,h			;0c56
	ld h,a			;0c57
	jp 00a9ah		;0c58
	ld hl,(04121h)		;0c5b
	call 00c51h		;0c5e
	ld a,h			;0c61
	xor 080h		;0c62
	or l			;0c64
	ret nz			;0c65
	ex de,hl			;0c66
	call 00aefh		;0c67
	xor a			;0c6a
	ld b,098h		;0c6b
	jp 00969h		;0c6d
	ld hl,0412dh		;0c70
	ld a,(hl)			;0c73
	xor 080h		;0c74
	ld (hl),a			;0c76
	ld hl,0412eh		;0c77
	ld a,(hl)			;0c7a
	or a			;0c7b
	ret z			;0c7c
	ld b,a			;0c7d
	dec hl			;0c7e
	ld c,(hl)			;0c7f
	ld de,04124h		;0c80
	ld a,(de)			;0c83
	or a			;0c84
	jp z,009f4h		;0c85
	sub b			;0c88
	jr nc,$+24		;0c89
	cpl			;0c8b
	inc a			;0c8c
	push af			;0c8d
	ld c,008h		;0c8e
	inc hl			;0c90
	push hl			;0c91
	ld a,(de)			;0c92
	ld b,(hl)			;0c93
	ld (hl),a			;0c94
	ld a,b			;0c95
	ld (de),a			;0c96
	dec de			;0c97
	dec hl			;0c98
	dec c			;0c99
	jr nz,$-8		;0c9a
	pop hl			;0c9c
	ld b,(hl)			;0c9d
	dec hl			;0c9e
	ld c,(hl)			;0c9f
	pop af			;0ca0
	cp 039h		;0ca1
	ret nc			;0ca3
	push af			;0ca4
	call 009dfh		;0ca5
	inc hl			;0ca8
	ld (hl),000h		;0ca9
	ld b,a			;0cab
	pop af			;0cac
	ld hl,0412dh		;0cad
	call 00d69h		;0cb0
	ld a,(04126h)		;0cb3
	ld (0411ch),a		;0cb6
	ld a,b			;0cb9
	or a			;0cba
	jp p,00ccfh		;0cbb
	call 00d33h		;0cbe
	jp nc,00d0eh		;0cc1
	ex de,hl			;0cc4
	inc (hl)			;0cc5
	jp z,007b2h		;0cc6
	call 00d90h		;0cc9
	jp 00d0eh		;0ccc
	call 00d45h		;0ccf
	ld hl,04125h		;0cd2
	call c,00d57h		;0cd5
	xor a			;0cd8
	ld b,a			;0cd9
	ld a,(04123h)		;0cda
	or a			;0cdd
	jr nz,$+32		;0cde
	ld hl,0411ch		;0ce0
	ld c,008h		;0ce3
	ld d,(hl)			;0ce5
	ld (hl),a			;0ce6
	ld a,d			;0ce7
	inc hl			;0ce8
	dec c			;0ce9
	jr nz,$-5		;0cea
	ld a,b			;0cec
	sub 008h		;0ced
	cp 0c0h		;0cef
	jr nz,$-24		;0cf1
	jp 00778h		;0cf3
	dec b			;0cf6
	ld hl,0411ch		;0cf7
	call 00d97h		;0cfa
	or a			;0cfd
	jp p,00cf6h		;0cfe
	ld a,b			;0d01
	or a			;0d02
	jr z,$+11		;0d03
	ld hl,04124h		;0d05
	add a,(hl)			;0d08
	ld (hl),a			;0d09
	jp nc,00778h		;0d0a
	ret z			;0d0d
	ld a,(0411ch)		;0d0e
	or a			;0d11
	call m,00d20h		;0d12
	ld hl,04125h		;0d15
	ld a,(hl)			;0d18
	and 080h		;0d19
	dec hl			;0d1b
	dec hl			;0d1c
	xor (hl)			;0d1d
	ld (hl),a			;0d1e
	ret			;0d1f
	ld hl,0411dh		;0d20
	ld b,007h		;0d23
	inc (hl)			;0d25
	ret nz			;0d26
	inc hl			;0d27
	dec b			;0d28
	jr nz,$-4		;0d29
	inc (hl)			;0d2b
	jp z,007b2h		;0d2c
	dec hl			;0d2f
	ld (hl),080h		;0d30
	ret			;0d32
	ld hl,04127h		;0d33
	ld de,0411dh		;0d36
	ld c,007h		;0d39
	xor a			;0d3b
	ld a,(de)			;0d3c
	adc a,(hl)			;0d3d
	ld (de),a			;0d3e
	inc de			;0d3f
	inc hl			;0d40
	dec c			;0d41
	jr nz,$-6		;0d42
	ret			;0d44
	ld hl,04127h		;0d45
	ld de,0411dh		;0d48
	ld c,007h		;0d4b
	xor a			;0d4d
	ld a,(de)			;0d4e
	sbc a,(hl)			;0d4f
	ld (de),a			;0d50
	inc de			;0d51
	inc hl			;0d52
	dec c			;0d53
	jr nz,$-6		;0d54
	ret			;0d56
	ld a,(hl)			;0d57
	cpl			;0d58
	ld (hl),a			;0d59
	ld hl,0411ch		;0d5a
	ld b,008h		;0d5d
	xor a			;0d5f
	ld c,a			;0d60
	ld a,c			;0d61
	sbc a,(hl)			;0d62
	ld (hl),a			;0d63
	inc hl			;0d64
	dec b			;0d65
	jr nz,$-5		;0d66
	ret			;0d68
	ld (hl),c			;0d69
	push hl			;0d6a
	sub 008h		;0d6b
	jr c,$+16		;0d6d
	pop hl			;0d6f
	push hl			;0d70
	ld de,00800h		;0d71
	ld c,(hl)			;0d74
	ld (hl),e			;0d75
	ld e,c			;0d76
	dec hl			;0d77
	dec d			;0d78
	jr nz,$-5		;0d79
	jr $-16		;0d7b
	add a,009h		;0d7d
	ld d,a			;0d7f
	xor a			;0d80
	pop hl			;0d81
	dec d			;0d82
	ret z			;0d83
	push hl			;0d84
	ld e,008h		;0d85
	ld a,(hl)			;0d87
	rra			;0d88
	ld (hl),a			;0d89
	dec hl			;0d8a
	dec e			;0d8b
	jr nz,$-5		;0d8c
	jr $-14		;0d8e
	ld hl,04123h		;0d90
	ld d,001h		;0d93
	jr $-17		;0d95
	ld c,008h		;0d97
	ld a,(hl)			;0d99
	rla			;0d9a
	ld (hl),a			;0d9b
	inc hl			;0d9c
	dec c			;0d9d
	jr nz,$-5		;0d9e
	ret			;0da0
	call 00955h		;0da1
	ret z			;0da4
	call 0090ah		;0da5
	call 00e39h		;0da8
	ld (hl),c			;0dab
	inc de			;0dac
	ld b,007h		;0dad
	ld a,(de)			;0daf
	inc de			;0db0
	or a			;0db1
	push de			;0db2
	jr z,$+25		;0db3
	ld c,008h		;0db5
	push bc			;0db7
	rra			;0db8
	ld b,a			;0db9
	call c,00d33h		;0dba
	call 00d90h		;0dbd
	ld a,b			;0dc0
	pop bc			;0dc1
	dec c			;0dc2
	jr nz,$-12		;0dc3
	pop de			;0dc5
	dec b			;0dc6
	jr nz,$-24		;0dc7
	jp 00cd8h		;0dc9
	ld hl,04123h		;0dcc
	call 00d70h		;0dcf
	jr $-13		;0dd2
	nop			;0dd4
	nop			;0dd5
	nop			;0dd6
	nop			;0dd7
	nop			;0dd8
	nop			;0dd9
	jr nz,$-122		;0dda
	ld de,00dd4h		;0ddc
	ld hl,04127h		;0ddf
	call 009d3h		;0de2
	ld a,(0412eh)		;0de5
	or a			;0de8
	jp z,0199ah		;0de9
	call 00907h		;0dec
	inc (hl)			;0def
	inc (hl)			;0df0
	call 00e39h		;0df1
	ld hl,04151h		;0df4
	ld (hl),c			;0df7
	ld b,c			;0df8
	ld de,0414ah		;0df9
	ld hl,04127h		;0dfc
	call 00d4bh		;0dff
	ld a,(de)			;0e02
	sbc a,c			;0e03
	ccf			;0e04
	jr c,$+13		;0e05
	ld de,0414ah		;0e07
	ld hl,04127h		;0e0a
	call 00d39h		;0e0d
	xor a			;0e10
	jp c,00412h		;0e11
	ld a,(04123h)		;0e14
	inc a			;0e17
	dec a			;0e18
	rra			;0e19
	jp m,00d11h		;0e1a
	rla			;0e1d
	ld hl,0411dh		;0e1e
	ld c,007h		;0e21
	call 00d99h		;0e23
	ld hl,0414ah		;0e26
	call 00d97h		;0e29
	ld a,b			;0e2c
	or a			;0e2d
	jr nz,$-53		;0e2e
	ld hl,04124h		;0e30
	dec (hl)			;0e33
	jr nz,$-59		;0e34
	jp 007b2h		;0e36
	ld a,c			;0e39
	ld (0412dh),a		;0e3a
	dec hl			;0e3d
	ld de,04150h		;0e3e
	ld bc,00700h		;0e41
	ld a,(hl)			;0e44
	ld (de),a			;0e45
	ld (hl),c			;0e46
	dec de			;0e47
	dec hl			;0e48
	dec b			;0e49
	jr nz,$-6		;0e4a
	ret			;0e4c
	call 009fch		;0e4d
	ex de,hl			;0e50
	dec hl			;0e51
	ld a,(hl)			;0e52
	or a			;0e53
	ret z			;0e54
	add a,002h		;0e55
	jp c,007b2h		;0e57
	ld (hl),a			;0e5a
	push hl			;0e5b
	call 00c77h		;0e5c
	pop hl			;0e5f
	inc (hl)			;0e60
	ret nz			;0e61
	jp 007b2h		;0e62
	call 00778h		;0e65
	call 00aech		;0e68
	or 0afh		;0e6b
	ex de,hl			;0e6d
	ld bc,000ffh		;0e6e
	ld h,b			;0e71
	ld l,b			;0e72
	call z,00a9ah		;0e73
	ex de,hl			;0e76
	ld a,(hl)			;0e77
	cp 02dh		;0e78
	push af			;0e7a
	jp z,00e83h		;0e7b
	cp 02bh		;0e7e
	jr z,$+3		;0e80
	dec hl			;0e82
	rst 10h			;0e83
	jp c,00f29h		;0e84
	cp 02eh		;0e87
	jp z,00ee4h		;0e89
	cp 045h		;0e8c
	jr z,$+22		;0e8e
	cp 025h		;0e90
	jp z,00eeeh		;0e92
	cp 023h		;0e95
	jp z,00ef5h		;0e97
	cp 021h		;0e9a
	jp z,00ef6h		;0e9c
	cp 044h		;0e9f
	jr nz,$+38		;0ea1
	or a			;0ea3
	call 00efbh		;0ea4
	push hl			;0ea7
	ld hl,00ebdh		;0ea8
	ex (sp),hl			;0eab
	rst 10h			;0eac
	dec d			;0ead
	cp 0ceh		;0eae
	ret z			;0eb0
	cp 02dh		;0eb1
	ret z			;0eb3
	inc d			;0eb4
	cp 0cdh		;0eb5
	ret z			;0eb7
	cp 02bh		;0eb8
	ret z			;0eba
	dec hl			;0ebb
	pop af			;0ebc
	rst 10h			;0ebd
	jp c,00f94h		;0ebe
	inc d			;0ec1
	jr nz,$+5		;0ec2
	xor a			;0ec4
	sub e			;0ec5
	ld e,a			;0ec6
	push hl			;0ec7
	ld a,e			;0ec8
	sub b			;0ec9
	call p,00f0ah		;0eca
	call m,00f18h		;0ecd
	jr nz,$-6		;0ed0
	pop hl			;0ed2
	pop af			;0ed3
	push hl			;0ed4
	call z,0097bh		;0ed5
	pop hl			;0ed8
	rst 20h			;0ed9
	ret pe			;0eda
	push hl			;0edb
	ld hl,00890h		;0edc
	push hl			;0edf
	call 00aa3h		;0ee0
	ret			;0ee3
	rst 20h			;0ee4
	inc c			;0ee5
	jr nz,$-31		;0ee6
	call c,00efbh		;0ee8
	jp 00e83h		;0eeb
	rst 20h			;0eee
	jp p,01997h		;0eef
	inc hl			;0ef2
	jr $-44		;0ef3
	or a			;0ef5
	call 00efbh		;0ef6
	jr $-7		;0ef9
	push hl			;0efb
	push de			;0efc
	push bc			;0efd
	push af			;0efe
	call z,00ab1h		;0eff
	pop af			;0f02
	call nz,00adbh		;0f03
	pop bc			;0f06
	pop de			;0f07
	pop hl			;0f08
	ret			;0f09
	ret z			;0f0a
	push af			;0f0b
	rst 20h			;0f0c
	push af			;0f0d
	call po,0093eh		;0f0e
	pop af			;0f11
	call pe,00e4dh		;0f12
	pop af			;0f15
	dec a			;0f16
	ret			;0f17
	push de			;0f18
	push hl			;0f19
	push af			;0f1a
	rst 20h			;0f1b
	push af			;0f1c
	call po,00897h		;0f1d
	pop af			;0f20
	call pe,00ddch		;0f21
	pop af			;0f24
	pop hl			;0f25
	pop de			;0f26
	inc a			;0f27
	ret			;0f28
	push de			;0f29
	ld a,b			;0f2a
	adc a,c			;0f2b
	ld b,a			;0f2c
	push bc			;0f2d
	push hl			;0f2e
	ld a,(hl)			;0f2f
	sub 030h		;0f30
	push af			;0f32
	rst 20h			;0f33
	jp p,00f5dh		;0f34
	ld hl,(04121h)		;0f37
	ld de,00ccdh		;0f3a
	rst 18h			;0f3d
	jr nc,$+27		;0f3e
	ld d,h			;0f40
	ld e,l			;0f41
	add hl,hl			;0f42
	add hl,hl			;0f43
	add hl,de			;0f44
	add hl,hl			;0f45
	pop af			;0f46
	ld c,a			;0f47
	add hl,bc			;0f48
	ld a,h			;0f49
	or a			;0f4a
	jp m,00f57h		;0f4b
	ld (04121h),hl		;0f4e
	pop hl			;0f51
	pop bc			;0f52
	pop de			;0f53
	jp 00e83h		;0f54
	ld a,c			;0f57
	push af			;0f58
	call 00acch		;0f59
	scf			;0f5c
	jr nc,$+26		;0f5d
	ld bc,09474h		;0f5f
	ld de,02400h		;0f62
	call 00a0ch		;0f65
	jp p,00f74h		;0f68
	call 0093eh		;0f6b
	pop af			;0f6e
	call 00f89h		;0f6f
	jr $-33		;0f72
	call 00ae3h		;0f74
	call 00e4dh		;0f77
	call 009fch		;0f7a
	pop af			;0f7d
	call 00964h		;0f7e
	call 00ae3h		;0f81
	call 00c77h		;0f84
	jr $-54		;0f87
	call 009a4h		;0f89
	call 00964h		;0f8c
	pop bc			;0f8f
	pop de			;0f90
	jp 00716h		;0f91
	ld a,e			;0f94
	cp 00ah		;0f95
	jr nc,$+11		;0f97
	rlca			;0f99
	rlca			;0f9a
	add a,e			;0f9b
	rlca			;0f9c
	add a,(hl)			;0f9d
	sub 030h		;0f9e
	ld e,a			;0fa0
	jp m,0321eh		;0fa1
	jp 00ebdh		;0fa4
	push hl			;0fa7
	ld hl,01924h		;0fa8
	call 028a7h		;0fab
	pop hl			;0fae
	call 00a9ah		;0faf
	xor a			;0fb2
	call 01034h		;0fb3
	or (hl)			;0fb6
	call 00fd9h		;0fb7
	jp 028a6h		;0fba
	xor a			;0fbd
	call 01034h		;0fbe
	and 008h		;0fc1
	jr z,$+4		;0fc3
	ld (hl),02bh		;0fc5
	ex de,hl			;0fc7
	call 00994h		;0fc8
	ex de,hl			;0fcb
	jp p,00fd9h		;0fcc
	ld (hl),02dh		;0fcf
	push bc			;0fd1
	push hl			;0fd2
	call 0097bh		;0fd3
	pop hl			;0fd6
	pop bc			;0fd7
	or h			;0fd8
	inc hl			;0fd9
	ld (hl),030h		;0fda
	ld a,(040d8h)		;0fdc
	ld d,a			;0fdf
	rla			;0fe0
	ld a,(040afh)		;0fe1
	jp c,0109ah		;0fe4
	jp z,01092h		;0fe7
	cp 004h		;0fea
	jp nc,0103dh		;0fec
	ld bc,00000h		;0fef
	call 0132fh		;0ff2
	ld hl,04130h		;0ff5
	ld b,(hl)			;0ff8
	ld c,020h		;0ff9
	ld a,(040d8h)		;0ffb
	ld e,a			;0ffe
	and 020h		;0fff
	jr z,$+9		;1001
	ld a,b			;1003
	cp c			;1004
	ld c,02ah		;1005
	jr nz,$+3		;1007
	ld b,c			;1009
	ld (hl),c			;100a
	rst 10h			;100b
	jr z,$+22		;100c
	cp 045h		;100e
	jr z,$+18		;1010
	cp 044h		;1012
	jr z,$+14		;1014
	cp 030h		;1016
	jr z,$-14		;1018
	cp 02ch		;101a
	jr z,$-18		;101c
	cp 02eh		;101e
	jr nz,$+5		;1020
	dec hl			;1022
	ld (hl),030h		;1023
	ld a,e			;1025
	and 010h		;1026
	jr z,$+5		;1028
	dec hl			;102a
	ld (hl),024h		;102b
	ld a,e			;102d
	and 004h		;102e
	ret nz			;1030
	dec hl			;1031
	ld (hl),b			;1032
	ret			;1033
	ld (040d8h),a		;1034
	ld hl,04130h		;1037
	ld (hl),020h		;103a
	ret			;103c
	cp 005h		;103d
	push hl			;103f
	sbc a,000h		;1040
	rla			;1042
	ld d,a			;1043
	inc d			;1044
	call 01201h		;1045
	ld bc,00300h		;1048
	add a,d			;104b
	jp m,01057h		;104c
	inc d			;104f
	jp m,00430h		;1050
	inc a			;1053
	ld b,a			;1054
	ld a,002h		;1055
	sub 002h		;1057
	pop hl			;1059
	push af			;105a
	call 01291h		;105b
	ld (hl),030h		;105e
	call z,009c9h		;1060
	call 012a4h		;1063
	dec hl			;1066
	ld a,(hl)			;1067
	cp 030h		;1068
	jr z,$-4		;106a
	cp 02eh		;106c
	call nz,009c9h		;106e
	pop af			;1071
	jr z,$+33		;1072
	push af			;1074
	rst 20h			;1075
	ld a,022h		;1076
	adc a,a			;1078
	ld (hl),a			;1079
	inc hl			;107a
	pop af			;107b
	ld (hl),02bh		;107c
	jp p,01085h		;107e
	ld (hl),02dh		;1081
	cpl			;1083
	inc a			;1084
	ld b,02fh		;1085
	inc b			;1087
	sub 00ah		;1088
	jr nc,$-3		;108a
	add a,03ah		;108c
	inc hl			;108e
	ld (hl),b			;108f
	inc hl			;1090
	ld (hl),a			;1091
	inc hl			;1092
	ld (hl),000h		;1093
	ex de,hl			;1095
	ld hl,04130h		;1096
	ret			;1099
	inc hl			;109a
	push bc			;109b
	cp 004h		;109c
	ld a,d			;109e
	jp nc,01109h		;109f
	rra			;10a2
	jp c,011a3h		;10a3
	ld bc,00603h		;10a6
	call 01289h		;10a9
	pop de			;10ac
	ld a,d			;10ad
	sub 005h		;10ae
	call p,01269h		;10b0
	call 0132fh		;10b3
	ld a,e			;10b6
	or a			;10b7
	call z,0092fh		;10b8
	dec a			;10bb
	call p,01269h		;10bc
	push hl			;10bf
	call 00ff5h		;10c0
	pop hl			;10c3
	jr z,$+4		;10c4
	ld (hl),b			;10c6
	inc hl			;10c7
	ld (hl),000h		;10c8
	ld hl,0412fh		;10ca
	inc hl			;10cd
	ld a,(040f3h)		;10ce
	sub l			;10d1
	sub d			;10d2
	ret z			;10d3
	ld a,(hl)			;10d4
	cp 020h		;10d5
	jr z,$-10		;10d7
	cp 02ah		;10d9
	jr z,$-14		;10db
	dec hl			;10dd
	push hl			;10de
	push af			;10df
	ld bc,010dfh		;10e0
	push bc			;10e3
	rst 10h			;10e4
	cp 02dh		;10e5
	ret z			;10e7
	cp 02bh		;10e8
	ret z			;10ea
	cp 024h		;10eb
	ret z			;10ed
	pop bc			;10ee
	cp 030h		;10ef
	jr nz,$+17		;10f1
	inc hl			;10f3
	rst 10h			;10f4
	jr nc,$+13		;10f5
	dec hl			;10f7
	ld bc,0772bh		;10f8
	pop af			;10fb
	jr z,$-3		;10fc
	pop bc			;10fe
	jp 010ceh		;10ff
	pop af			;1102
	jr z,$-1		;1103
	pop hl			;1105
	ld (hl),025h		;1106
	ret			;1108
	push hl			;1109
	rra			;110a
	jp c,011aah		;110b
	jr z,$+22		;110e
	ld de,01384h		;1110
	call 00a49h		;1113
	ld d,010h		;1116
	jp m,01132h		;1118
	pop hl			;111b
	pop bc			;111c
	call 08fbdh		;111d
	dec hl			;1120
	ld (hl),025h		;1121
	ret			;1123
	ld bc,0b60eh		;1124
	ld de,01bcah		;1127
	call 00a0ch		;112a
	jp p,0111bh		;112d
	ld d,006h		;1130
	call 00955h		;1132
	call nz,01201h		;1135
	pop hl			;1138
	pop bc			;1139
	jp m,01157h		;113a
	push bc			;113d
	ld e,a			;113e
	ld a,b			;113f
	sub d			;1140
	sub e			;1141
	call p,01269h		;1142
	call 0127dh		;1145
	call 012a4h		;1148
	or e			;114b
	call nz,01277h		;114c
	or e			;114f
	call nz,01291h		;1150
	pop de			;1153
	jp 010b6h		;1154
	ld e,a			;1157
	ld a,c			;1158
	rst 30h			;1159
	call nz,00f16h		;115a
	add a,e			;115d
	jp m,01162h		;115e
	xor a			;1161
	push bc			;1162
	push af			;1163
	call m,00f18h		;1164
	jp m,01164h		;1167
	pop bc			;116a
	ld a,e			;116b
	sub b			;116c
	pop bc			;116d
	ld e,a			;116e
	add a,d			;116f
	ld a,b			;1170
	jp m,0117fh		;1171
	sub d			;1174
	sub e			;1175
	call p,01269h		;1176
	push bc			;1179
	call 0127dh		;117a
	jr $+19		;117d
	call 01269h		;117f
	ld a,c			;1182
	call 01294h		;1183
	ld c,a			;1186
	xor a			;1187
	sub d			;1188
	sub e			;1189
	call 01269h		;118a
	push bc			;118d
	ld b,a			;118e
	ld c,a			;118f
	call 012a4h		;1190
	pop bc			;1193
	or c			;1194
	jr nz,$+5		;1195
	ld hl,(040f3h)		;1197
	add a,e			;119a
	dec a			;119b
	call p,05269h		;119c
	ret nc			;119f
	jp 010bfh		;11a0
	push hl			;11a3
	push de			;11a4
	call 00acch		;11a5
	pop de			;11a8
	xor a			;11a9
	jp z,011b0h		;11aa
	ld e,010h		;11ad
	ld bc,0061eh		;11af
	call 00955h		;11b2
	scf			;11b5
	call nz,01201h		;11b6
	pop hl			;11b9
	pop bc			;11ba
	push af			;11bb
	ld a,c			;11bc
	or a			;11bd
	push af			;11be
	call nz,00f16h		;11bf
	add a,b			;11c2
	ld c,a			;11c3
	ld a,d			;11c4
	and 004h		;11c5
	cp 001h		;11c7
	sbc a,a			;11c9
	ld d,a			;11ca
	add a,c			;11cb
	ld c,a			;11cc
	sub e			;11cd
	push af			;11ce
	push bc			;11cf
	call m,00f18h		;11d0
	jp m,011d0h		;11d3
	pop bc			;11d6
	pop af			;11d7
	push bc			;11d8
	push af			;11d9
	jp m,011deh		;11da
	xor a			;11dd
	cpl			;11de
	inc a			;11df
	add a,b			;11e0
	inc a			;11e1
	add a,d			;11e2
	ld b,a			;11e3
	ld c,000h		;11e4
	call 012a4h		;11e6
	pop af			;11e9
	call p,01271h		;11ea
	pop bc			;11ed
	pop af			;11ee
	call z,0092fh		;11ef
	pop af			;11f2
	jr c,$+5		;11f3
	add a,e			;11f5
	sub b			;11f6
	sub d			;11f7
	push bc			;11f8
	call 01074h		;11f9
	ex de,hl			;11fc
	pop de			;11fd
	jp 010ffh		;11fe
	push de			;1201
	xor a			;1202
	push af			;1203
	rst 20h			;1204
	jp po,01222h		;1205
	ld a,(04124h)		;1208
	cp 091h		;120b
	jp nc,01222h		;120d
	ld de,01364h		;1210
	ld hl,04127h		;1213
	call 009d3h		;1216
	call 00da1h		;1219
	pop af			;121c
	sub 04ah		;121d
	push af			;121f
	jr $-24		;1220
	call 0124fh		;1222
	rst 20h			;1225
	jr nc,$+13		;1226
	ld bc,09143h		;1228
	ld de,04ff9h		;122b
	call 00a0ch		;122e
	jr $+8		;1231
	ld de,0136ch		;1233
	call 00a49h		;1236
	jp p,0124bh		;1239
	pop af			;123c
	call 00f0bh		;123d
	push af			;1240
	jr $-28		;1241
	pop af			;1243
	call 00f18h		;1244
	push af			;1247
	call 0124fh		;1248
	pop af			;124b
	pop de			;124c
	or a			;124d
	ret			;124e
	rst 20h			;124f
	jp pe,0125eh		;1250
	ld bc,09474h		;1253
	ld de,023f8h		;1256
	call 00a0ch		;1259
	jr $+8		;125c
	ld de,01374h		;125e
	call 00a49h		;1261
	pop hl			;1264
	jp p,01243h		;1265
	jp (hl)			;1268
	or a			;1269
	ret z			;126a
	dec a			;126b
	ld (hl),030h		;126c
	inc hl			;126e
	jr $-5		;126f
	jr nz,$+6		;1271
	ret z			;1273
	call 01291h		;1274
	ld (hl),030h		;1277
	inc hl			;1279
	dec a			;127a
	jr $-8		;127b
	ld a,e			;127d
	add a,d			;127e
	inc a			;127f
	ld b,a			;1280
	inc a			;1281
	sub 003h		;1282
	jr nc,$-2		;1284
	add a,005h		;1286
	ld c,a			;1288
	ld a,(040d8h)		;1289
	and 040h		;128c
	ret nz			;128e
	ld c,a			;128f
	ret			;1290
	dec b			;1291
	jr nz,$+10		;1292
	ld (hl),02eh		;1294
	ld (040f3h),hl		;1296
	inc hl			;1299
	ld c,b			;129a
	ret			;129b
	dec c			;129c
	ret nz			;129d
	ld (hl),02ch		;129e
	inc hl			;12a0
	ld c,003h		;12a1
	ret			;12a3
	push de			;12a4
	rst 20h			;12a5
	jp po,012eah		;12a6
	push bc			;12a9
	push hl			;12aa
	call 009fch		;12ab
	ld hl,0137ch		;12ae
	call 009f7h		;12b1
	call 00c77h		;12b4
	xor a			;12b7
	call 00b7bh		;12b8
	pop hl			;12bb
	pop bc			;12bc
	ld de,013cch		;12bd
	ld a,00ah		;12c0
	call 01291h		;12c2
	push bc			;12c5
	push af			;12c6
	push hl			;12c7
	push de			;12c8
	ld b,02fh		;12c9
	inc b			;12cb
	pop hl			;12cc
	push hl			;12cd
	call 00d48h		;12ce
	jr nc,$-6		;12d1
	pop hl			;12d3
	call 00d36h		;12d4
	ex de,hl			;12d7
	pop hl			;12d8
	ld (hl),b			;12d9
	inc hl			;12da
	pop af			;12db
	pop bc			;12dc
	dec a			;12dd
	jr nz,$-28		;12de
	push bc			;12e0
	push hl			;12e1
	ld hl,0411dh		;12e2
	call 009b1h		;12e5
	jr $+14		;12e8
	push bc			;12ea
	push hl			;12eb
	call 00708h		;12ec
	inc a			;12ef
	call 00afbh		;12f0
	call 009b4h		;12f3
	pop hl			;12f6
	pop bc			;12f7
	xor a			;12f8
	ld de,013d2h		;12f9
	ccf			;12fc
	call 01291h		;12fd
	push bc			;1300
	push af			;1301
	push hl			;1302
	push de			;1303
	call 009bfh		;1304
	pop hl			;1307
	ld b,02fh		;1308
	inc b			;130a
	ld a,e			;130b
	sub (hl)			;130c
	ld e,a			;130d
	inc hl			;130e
	ld a,d			;130f
	sbc a,057h		;1310
	inc hl			;1312
	ld a,c			;1313
	sbc a,(hl)			;1314
	ld c,a			;1315
	dec hl			;1316
	dec hl			;1317
	jr nc,$-14		;1318
	call 007b7h		;131a
	inc hl			;131d
	call 009b4h		;131e
	ex de,hl			;1321
	pop hl			;1322
	ld (hl),b			;1323
	inc hl			;1324
	pop af			;1325
	pop bc			;1326
	jr c,$-43		;1327
	inc de			;1329
	inc de			;132a
	ld a,004h		;132b
	jr $+8		;132d
	push de			;132f
	ld de,013d8h		;1330
	ld a,005h		;1333
	call 01291h		;1335
	push bc			;1338
	push af			;1339
	push hl			;133a
	ex de,hl			;133b
	ld c,(hl)			;133c
	inc hl			;133d
	ld b,(hl)			;133e
	push bc			;133f
	inc hl			;1340
	ex (sp),hl			;1341
	ex de,hl			;1342
	ld hl,(04121h)		;1343
	ld b,02fh		;1346
	inc b			;1348
	ld a,l			;1349
	sub e			;134a
	ld l,a			;134b
	ld a,h			;134c
	sbc a,d			;134d
	ld h,a			;134e
	jr nc,$-7		;134f
	add hl,de			;1351
	ld (04121h),hl		;1352
	pop de			;1355
	pop hl			;1356
	ld (hl),b			;1357
	inc hl			;1358
	pop af			;1359
	pop bc			;135a
	dec a			;135b
	jr nz,$-39		;135c
	call 01291h		;135e
	ld (hl),a			;1361
	pop de			;1362
	ret			;1363
	nop			;1364
	nop			;1365
	nop			;1366
	nop			;1367
	ld sp,hl			;1368
	ld (bc),a			;1369
	dec d			;136a
	and d			;136b
	defb 0fdh,0ffh,09fh	;illegal sequence		;136c
	ld sp,05fa9h		;136f
	ld h,e			;1372
	or d			;1373
	cp 0ffh		;1374
	inc bc			;1376
	rst 38h			;1377
	ret			;1378
	dec de			;1379
	ld c,0f6h		;137a
	nop			;137c
	nop			;137d
	nop			;137e
	nop			;137f
	nop			;1380
	nop			;1381
	nop			;1382
	add a,b			;1383
	nop			;1384
	nop			;1385
	inc b			;1386
	cp a			;1387
	ret			;1388
	dec de			;1389
	ld c,0b6h		;138a
	nop			;138c
	add a,b			;138d
	add a,0a4h		;138e
	ld a,(hl)			;1390
	adc a,l			;1391
	inc bc			;1392
	nop			;1393
	ld b,b			;1394
	ld a,d			;1395
	djnz $-11		;1396
	ld e,d			;1398
	nop			;1399
	nop			;139a
	ret po			;139b
	ld (hl),d			;139c
	ld c,(hl)			;139d
	jr $-117		;139e
	nop			;13a0
	nop			;13a1
	djnz $-89		;13a2
	call nc,000e8h		;13a4
	nop			;13a7
	nop			;13a8
	ret pe			;13a9
	halt			;13aa
	ld c,b			;13ab
	rla			;13ac
	nop			;13ad
	nop			;13ae
	nop			;13af
	call po,0540bh		;13b0
	ld (bc),a			;13b3
	nop			;13b4
	nop			;13b5
	nop			;13b6
	jp z,03b9ah		;13b7
	nop			;13ba
	nop			;13bb
	nop			;13bc
	nop			;13bd
	pop hl			;13be
	push af			;13bf
	dec b			;13c0
	nop			;13c1
	nop			;13c2
	nop			;13c3
	add a,b			;13c4
	sub (hl)			;13c5
	sbc a,b			;13c6
	nop			;13c7
	nop			;13c8
	nop			;13c9
	nop			;13ca
	ld b,b			;13cb
	ld b,d			;13cc
	rrca			;13cd
	nop			;13ce
	nop			;13cf
	nop			;13d0
	nop			;13d1
	ret po			;13d2
	add a,(hl)			;13d3
	ld bc,02710h		;13d4
	nop			;13d7
	djnz $+41		;13d8
	ret pe			;13da
	inc bc			;13db
	ld h,h			;13dc
	nop			;13dd
	ld a,(bc)			;13de
	ret nz			;13df
	ld bc,02100h		;13e0
	add a,d			;13e3
	add hl,bc			;13e4
	ex (sp),hl			;13e5
	jp (hl)			;13e6
	call 009a4h		;13e7
	ld hl,01380h		;13ea
	call 009b1h		;13ed
	jr $+5		;13f0
	call 00ab1h		;13f2
	pop bc			;13f5
	pop de			;13f6
	call 00955h		;13f7
	ld a,b			;13fa
	jr z,$+62		;13fb
	jp p,01404h		;13fd
	or a			;1400
	jp z,0199ah		;1401
	or a			;1404
	jp z,00779h		;1405
	push de			;1408
	push bc			;1409
	ld a,c			;140a
	or 07fh		;140b
	call 009bfh		;140d
	jp p,01421h		;1410
	push de			;1413
	push bc			;1414
	call 00b40h		;1415
	pop bc			;1418
	pop de			;1419
	push af			;141a
	call 00a0ch		;141b
	pop hl			;141e
	ld a,h			;141f
	rra			;1420
	pop hl			;1421
	ld (04123h),hl		;1422
	pop hl			;1425
	ld (04121h),hl		;1426
	call c,013e2h		;1429
	call z,00982h		;142c
	push de			;142f
	push bc			;1430
	call 00809h		;1431
	pop bc			;1434
	pop de			;1435
	call 00847h		;1436
	call 009a4h		;1439
	ld bc,08138h		;143c
	ld de,0aa3bh		;143f
	call 00847h		;1442
	ld a,(04124h)		;1445
	cp 088h		;1448
	jp nc,00931h		;144a
	call 00b40h		;144d
	add a,080h		;1450
	add a,002h		;1452
	jp c,00931h		;1454
	push af			;1457
	ld hl,007f8h		;1458
	call 0070bh		;145b
	call 00841h		;145e
	pop af			;1461
	pop bc			;1462
	pop de			;1463
	push af			;1464
	call 00713h		;1465
	call 00982h		;1468
	ld hl,01479h		;146b
	call 014a9h		;146e
	ld de,00000h		;1471
	pop bc			;1474
	ld c,d			;1475
	jp 00847h		;1476
	ex af,af'			;1479
	ld b,b			;147a
	ld l,094h		;147b
	ld (hl),h			;147d
	ld (hl),b			;147e
	ld c,a			;147f
	ld l,077h		;1480
	ld l,(hl)			;1482
	ld (bc),a			;1483
	adc a,b			;1484
	ld a,d			;1485
	and 0a0h		;1486
	ld hl,(0507ch)		;1488
	xor d			;148b
	xor d			;148c
	ld a,(hl)			;148d
	rst 38h			;148e
	rst 38h			;148f
	ld a,a			;1490
	ld a,a			;1491
	nop			;1492
	nop			;1493
	add a,b			;1494
	add a,c			;1495
	nop			;1496
	nop			;1497
	nop			;1498
	add a,c			;1499
	call 009a4h		;149a
	ld de,00c32h		;149d
	push de			;14a0
	push hl			;14a1
	call 009bfh		;14a2
	call 00847h		;14a5
	pop hl			;14a8
	call 009a4h		;14a9
	ld a,(hl)			;14ac
	inc hl			;14ad
	call 009b1h		;14ae
	ld b,0f1h		;14b1
	pop bc			;14b3
	pop de			;14b4
	dec a			;14b5
	ret z			;14b6
	push de			;14b7
	push bc			;14b8
	push af			;14b9
	push hl			;14ba
	call 00847h		;14bb
	pop hl			;14be
	call 009c2h		;14bf
	push hl			;14c2
	call 00716h		;14c3
	pop hl			;14c6
	jr $-21		;14c7
	call 00a7fh		;14c9
	ld a,h			;14cc
	or a			;14cd
	jp m,01e4ah		;14ce
	or l			;14d1
	jp z,014f0h		;14d2
	push hl			;14d5
	call 014f0h		;14d6
	call 009bfh		;14d9
	ex de,hl			;14dc
	ex (sp),hl			;14dd
	push bc			;14de
	call 00acfh		;14df
	pop bc			;14e2
	pop de			;14e3
	call 00847h		;14e4
	ld hl,007f8h		;14e7
	call 0070bh		;14ea
	jp 00b40h		;14ed
	ld hl,04090h		;14f0
	push hl			;14f3
	ld de,00000h		;14f4
	ld c,e			;14f7
	ld h,003h		;14f8
	ld l,008h		;14fa
	ex de,hl			;14fc
	add hl,hl			;14fd
	ex de,hl			;14fe
	ld a,c			;14ff
	rla			;1500
	ld c,a			;1501
	ex (sp),hl			;1502
	ld a,(hl)			;1503
	rlca			;1504
	ld (hl),a			;1505
	ex (sp),hl			;1506
	jp nc,01516h		;1507
	push hl			;150a
	ld hl,(040aah)		;150b
	add hl,de			;150e
	ex de,hl			;150f
	ld a,(040ech)		;1510
	adc a,c			;1513
	ld c,a			;1514
	pop hl			;1515
	dec l			;1516
	jp nz,014fch		;1517
	ex (sp),hl			;151a
	inc hl			;151b
	ex (sp),hl			;151c
	dec h			;151d
	jp nz,014fah		;151e
	pop hl			;1521
	ld hl,0b065h		;1522
	add hl,de			;1525
	ld (040aah),hl		;1526
	call 00aefh		;1529
	ld a,005h		;152c
	adc a,c			;152e
	ld (040ach),a		;152f
	ex de,hl			;1532
	ld b,080h		;1533
	ld hl,04125h		;1535
	ld (hl),b			;1538
	dec hl			;1539
	ld (hl),b			;153a
	ld c,a			;153b
	ld b,000h		;153c
	jp 00765h		;153e
	ld hl,0158bh		;1541
	call 0070bh		;1544
	call 009a4h		;1547
	ld bc,08349h		;154a
	ld de,00fdbh		;154d
	call 009b4h		;1550
	pop bc			;1553
	pop de			;1554
	call 008a2h		;1555
	call 009a4h		;1558
	call 00b40h		;155b
	pop bc			;155e
	pop de			;155f
	call 00713h		;1560
	ld hl,0158fh		;1563
	call 00710h		;1566
	call 00955h		;1569
	scf			;156c
	jp p,01577h		;156d
	call 00708h		;1570
	call 00955h		;1573
	or a			;1576
	push af			;1577
	call p,00982h		;1578
	ld hl,0158fh		;157b
	call 0070bh		;157e
	pop af			;1581
	call nc,00982h		;1582
	ld hl,01593h		;1585
	jp 0149ah		;1588
	in a,(00fh)		;158b
	ld c,c			;158d
	add a,c			;158e
	nop			;158f
	nop			;1590
	nop			;1591
	ld a,a			;1592
	dec b			;1593
	jp m,01ed7h		;1594
	add a,064h		;1597
	ld h,0d9h		;1599
	add a,a			;159b
	ld e,b			;159c
	inc (hl)			;159d
	inc hl			;159e
	add a,a			;159f
	ret po			;15a0
	ld e,l			;15a1
	and l			;15a2
	add a,(hl)			;15a3
	jp c,0490fh		;15a4
	add a,e			;15a7
	call 009a4h		;15a8
	call 01547h		;15ab
	pop bc			;15ae
	pop hl			;15af
	call 009a4h		;15b0
	ex de,hl			;15b3
	call 009b4h		;15b4
	call 01541h		;15b7
	jp 008a0h		;15ba
	call 00955h		;15bd
	call m,013e2h		;15c0
	call m,00982h		;15c3
	ld a,(04124h)		;15c6
	cp 081h		;15c9
	jr c,$+14		;15cb
	ld bc,08100h		;15cd
	ld d,c			;15d0
	ld e,c			;15d1
	call 008a2h		;15d2
	ld hl,00710h		;15d5
	push hl			;15d8
	ld hl,015e3h		;15d9
	call 0149ah		;15dc
	ld hl,0158bh		;15df
	ret			;15e2
	add hl,bc			;15e3
	ld c,d			;15e4
	rst 10h			;15e5
	dec sp			;15e6
	ld a,b			;15e7
	ld (bc),a			;15e8
	ld l,(hl)			;15e9
	add a,h			;15ea
	ld a,e			;15eb
	cp 0c1h		;15ec
	cpl			;15ee
	ld a,h			;15ef
	ld (hl),h			;15f0
	ld sp,07ddah		;15f1
	add a,h			;15f4
	dec a			;15f5
	ld e,d			;15f6
	ld a,l			;15f7
	ret z			;15f8
	ld a,a			;15f9
	sub c			;15fa
	ld a,(hl)			;15fb
	call po,04cbbh		;15fc
	ld a,(hl)			;15ff
	ld l,h			;1600
	xor d			;1601
	xor d			;1602
	ld a,a			;1603
	nop			;1604
	nop			;1605
	nop			;1606
	add a,c			;1607
	adc a,d			;1608
	add hl,bc			;1609
	scf			;160a
	dec bc			;160b
	ld (hl),a			;160c
	add hl,bc			;160d
	call nc,0ef27h		;160e
	ld hl,(027f5h)		;1611
	rst 20h			;1614
	inc de			;1615
	ret			;1616
	inc d			;1617
	add hl,bc			;1618
	ex af,af'			;1619
	add hl,sp			;161a
	inc d			;161b
	ld b,c			;161c
	dec d			;161d
	ld b,a			;161e
	dec d			;161f
	xor b			;1620
	dec d			;1621
	cp l			;1622
	dec d			;1623
	xor d			;1624
	inc l			;1625
	ld d,d			;1626
	ld b,c			;1627
	ld e,b			;1628
	ld b,c			;1629
	ld e,(hl)			;162a
	ld b,c			;162b
	ld h,c			;162c
	ld b,c			;162d
	ld h,h			;162e
	ld b,c			;162f
	ld h,a			;1630
	ld b,c			;1631
	ld l,d			;1632
	ld b,c			;1633
	ld l,l			;1634
	ld b,c			;1635
	ld (hl),b			;1636
	ld b,c			;1637
	ld a,a			;1638
	ld a,(bc)			;1639
	pop af			;163a
	ld a,(bc)			;163b
	in a,(00ah)		;163c
	ld h,00bh		;163e
	inc bc			;1640
	ld hl,(02836h)		;1641
	push bc			;1644
	ld hl,(02a0fh)		;1645
	rra			;1648
	ld hl,(02a61h)		;1649
	sub c			;164c
	ld hl,(02a9ah)		;164d
	push bc			;1650
	ld c,(hl)			;1651
	ld b,h			;1652
	add a,04fh		;1653
	ld d,d			;1655
	jp nc,05345h		;1656
	ld b,l			;1659
	ld d,h			;165a
	out (045h),a		;165b
	ld d,h			;165d
	jp 0534ch		;165e
	jp 0444dh		;1661
	jp nc,04e41h		;1664
	ld b,h			;1667
	ld c,a			;1668
	ld c,l			;1669
	adc a,045h		;166a
	ld e,b			;166c
	ld d,h			;166d
	call nz,05441h		;166e
	ld b,c			;1671
	ret			;1672
	ld c,(hl)			;1673
	ld d,b			;1674
	ld d,l			;1675
	ld d,h			;1676
	call nz,04d49h		;1677
	jp nc,04145h		;167a
	ld b,h			;167d
	call z,05445h		;167e
	rst 0			;1681
	ld c,a			;1682
	ld d,h			;1683
	ld c,a			;1684
	jp nc,04e55h		;1685
	ret			;1688
	ld b,(hl)			;1689
	jp nc,05345h		;168a
	ld d,h			;168d
	ld c,a			;168e
	ld d,d			;168f
	ld b,l			;1690
	rst 0			;1691
	ld c,a			;1692
	ld d,e			;1693
	ld d,l			;1694
	ld b,d			;1695
	jp nc,05445h		;1696
	ld d,l			;1699
	ld d,d			;169a
	ld c,(hl)			;169b
	jp nc,04d45h		;169c
	out (054h),a		;169f
	ld c,a			;16a1
	ld d,b			;16a2
	push bc			;16a3
	ld c,h			;16a4
	ld d,e			;16a5
	ld b,l			;16a6
	call nc,04f52h		;16a7
	ld c,(hl)			;16aa
	call nc,04f52h		;16ab
	ld b,(hl)			;16ae
	ld b,(hl)			;16af
	call nz,04645h		;16b0
	ld d,e			;16b3
	ld d,h			;16b4
	ld d,d			;16b5
	call nz,04645h		;16b6
	ld c,c			;16b9
	ld c,(hl)			;16ba
	ld d,h			;16bb
	call nz,04645h		;16bc
	ld d,e			;16bf
	ld c,(hl)			;16c0
	ld b,a			;16c1
	call nz,04645h		;16c2
	ld b,h			;16c5
	ld b,d			;16c6
	ld c,h			;16c7
	call z,04e49h		;16c8
	ld b,l			;16cb
	push bc			;16cc
	ld b,h			;16cd
	ld c,c			;16ce
	ld d,h			;16cf
	push bc			;16d0
	ld d,d			;16d1
	ld d,d			;16d2
	ld c,a			;16d3
	ld d,d			;16d4
	jp nc,05345h		;16d5
	ld d,l			;16d8
	ld c,l			;16d9
	ld b,l			;16da
	rst 8			;16db
	ld d,l			;16dc
	ld d,h			;16dd
	rst 8			;16de
	ld c,(hl)			;16df
	rst 8			;16e0
	ld d,b			;16e1
	ld b,l			;16e2
	ld c,(hl)			;16e3
	add a,049h		;16e4
	ld b,l			;16e6
	ld c,h			;16e7
	ld b,h			;16e8
	rst 0			;16e9
	ld b,l			;16ea
	ld d,h			;16eb
	ret nc			;16ec
	ld d,l			;16ed
	ld d,h			;16ee
	jp 04f4ch		;16ef
	ld d,e			;16f2
	ld b,l			;16f3
	call z,0414fh		;16f4
	ld b,h			;16f7
	call 05245h		;16f8
	ld b,a			;16fb
	ld b,l			;16fc
	adc a,041h		;16fd
	ld c,l			;16ff
	ld b,l			;1700
	bit 1,c		;1701
	ld c,h			;1703
	ld c,h			;1704
	call z,04553h		;1705
	ld d,h			;1708
	jp nc,04553h		;1709
	ld d,h			;170c
	out (041h),a		;170d
	ld d,(hl)			;170f
	ld b,l			;1710
	out (059h),a		;1711
	ld d,e			;1713
	ld d,h			;1714
	ld b,l			;1715
	ld c,l			;1716
	call z,05250h		;1717
	ld c,c			;171a
	ld c,(hl)			;171b
	ld d,h			;171c
	call nz,04645h		;171d
	ret nc			;1720
	ld c,a			;1721
	ld c,e			;1722
	ld b,l			;1723
	ret nc			;1724
	ld d,d			;1725
	ld c,c			;1726
	ld c,(hl)			;1727
	ld d,h			;1728
	jp 04e4fh		;1729
	ld d,h			;172c
	call z,05349h		;172d
	ld d,h			;1730
	call z,0494ch		;1731
	ld d,e			;1734
	ld d,h			;1735
	call nz,04c45h		;1736
	ld b,l			;1739
	ld d,h			;173a
	ld b,l			;173b
	pop bc			;173c
	ld d,l			;173d
	ld d,h			;173e
	ld c,a			;173f
	jp 0454ch		;1740
	ld b,c			;1743
	ld d,d			;1744
	jp 04f4ch		;1745
	ld b,c			;1748
	ld b,h			;1749
	jp 04153h		;174a
	ld d,(hl)			;174d
	ld b,l			;174e
	adc a,045h		;174f
	ld d,a			;1751
	call nc,04241h		;1752
	jr z,$-42		;1755
	ld c,a			;1757
	add a,04eh		;1758
	push de			;175a
	ld d,e			;175b
	ld c,c			;175c
	ld c,(hl)			;175d
	ld b,a			;175e
	sub 041h		;175f
	ld d,d			;1761
	ld d,b			;1762
	ld d,h			;1763
	ld d,d			;1764
	push de			;1765
	ld d,e			;1766
	ld d,d			;1767
	push bc			;1768
	ld d,d			;1769
	ld c,h			;176a
	push bc			;176b
	ld d,d			;176c
	ld d,d			;176d
	out (054h),a		;176e
	ld d,d			;1770
	ld c,c			;1771
	ld c,(hl)			;1772
	ld b,a			;1773
	inc h			;1774
	ret			;1775
	ld c,(hl)			;1776
	ld d,e			;1777
	ld d,h			;1778
	ld d,d			;1779
	ret nc			;177a
	ld c,a			;177b
	ld c,c			;177c
	ld c,(hl)			;177d
	ld d,h			;177e
	call nc,04d49h		;177f
	ld b,l			;1782
	inc h			;1783
	call 04d45h		;1784
	ret			;1787
	ld c,(hl)			;1788
	ld c,e			;1789
	ld b,l			;178a
	ld e,c			;178b
	inc h			;178c
	call nc,04548h		;178d
	ld c,(hl)			;1790
	adc a,04fh		;1791
	ld d,h			;1793
	out (054h),a		;1794
	ld b,l			;1796
	ld d,b			;1797
	xor e			;1798
	xor l			;1799
	xor d			;179a
	xor a			;179b
	in a,(0c1h)		;179c
	ld c,(hl)			;179e
	ld b,h			;179f
	rst 8			;17a0
	ld d,d			;17a1
	cp (hl)			;17a2
	cp l			;17a3
	cp h			;17a4
	out (047h),a		;17a5
	ld c,(hl)			;17a7
	ret			;17a8
	ld c,(hl)			;17a9
	ld d,h			;17aa
	pop bc			;17ab
	ld b,d			;17ac
	ld d,e			;17ad
	add a,052h		;17ae
	ld b,l			;17b0
	ret			;17b1
	ld c,(hl)			;17b2
	ld d,b			;17b3
	ret nc			;17b4
	ld c,a			;17b5
	ld d,e			;17b6
	out (051h),a		;17b7
	ld d,d			;17b9
	jp nc,0444eh		;17ba
	call z,0474fh		;17bd
	push bc			;17c0
	ld e,b			;17c1
	ld d,b			;17c2
	jp 0534fh		;17c3
	out (049h),a		;17c6
	ld c,(hl)			;17c8
	call nc,04e41h		;17c9
	pop bc			;17cc
	ld d,h			;17cd
	ld c,(hl)			;17ce
	ret nc			;17cf
	ld b,l			;17d0
	ld b,l			;17d1
	ld c,e			;17d2
	jp 04956h		;17d3
	jp 05356h		;17d6
	jp 04456h		;17d9
	push bc			;17dc
	ld c,a			;17dd
	ld b,(hl)			;17de
	call z,0434fh		;17df
	call z,0464fh		;17e2
	call 0494bh		;17e5
	inc h			;17e8
	call 0534bh		;17e9
	inc h			;17ec
	call 0444bh		;17ed
	inc h			;17f0
	jp 04e49h		;17f1
	ld d,h			;17f4
	jp 04e53h		;17f5
	ld b,a			;17f8
	jp 04244h		;17f9
	ld c,h			;17fc
	add a,049h		;17fd
	ld e,b			;17ff
	call z,04e45h		;1800
	out (054h),a		;1803
	ld d,d			;1805
	inc h			;1806
	sub 041h		;1807
	ld c,h			;1809
	pop bc			;180a
	ld d,e			;180b
	ld b,e			;180c
	jp 05248h		;180d
	inc h			;1810
	call z,04645h		;1811
	ld d,h			;1814
	inc h			;1815
	jp nc,04749h		;1816
	ld c,b			;1819
	ld d,h			;181a
	inc h			;181b
	call 04449h		;181c
	inc h			;181f
	and a			;1820
	add a,b			;1821
	xor (hl)			;1822
	dec e			;1823
	and c			;1824
	inc e			;1825
	jr c,$+3		;1826
	dec (hl)			;1828
	ld bc,001c9h		;1829
	ld (hl),e			;182c
	ld b,c			;182d
	out (001h),a		;182e
	or (hl)			;1830
	ld (01f05h),hl		;1831
	sbc a,d			;1834
	ld hl,02608h		;1835
	rst 28h			;1838
	ld hl,01f21h		;1839
	jp nz,0a31eh		;183c
	ld e,039h		;183f
	jr nz,$-109		;1841
	dec e			;1843
	or c			;1844
	ld e,0deh		;1845
	ld e,007h		;1847
	rra			;1849
	xor c			;184a
	dec e			;184b
	rlca			;184c
	rra			;184d
	rst 30h			;184e
	dec e			;184f
	ret m			;1850
	dec e			;1851
	nop			;1852
	ld e,003h		;1853
	ld e,006h		;1855
	ld e,009h		;1857
	ld e,0a3h		;1859
	ld b,c			;185b
	ld h,b			;185c
	ld l,0f4h		;185d
	rra			;185f
	xor a			;1860
	rra			;1861
	ei			;1862
	ld hl,(01f6ch)		;1863
	ld a,c			;1866
	ld b,c			;1867
	ld a,h			;1868
	ld b,c			;1869
	ld a,a			;186a
	ld b,c			;186b
	add a,d			;186c
	ld b,c			;186d
	add a,l			;186e
	ld b,c			;186f
	adc a,b			;1870
	ld b,c			;1871
	adc a,e			;1872
	ld b,c			;1873
	adc a,(hl)			;1874
	ld b,c			;1875
	sub c			;1876
	ld b,c			;1877
	sub a			;1878
	ld b,c			;1879
	sbc a,d			;187a
	ld b,c			;187b
	and b			;187c
	ld b,c			;187d
	or d			;187e
	ld (bc),a			;187f
	ld h,a			;1880
	jr nz,$+93		;1881
	ld b,c			;1883
	or c			;1884
	inc l			;1885
	ld l,a			;1886
	jr nz,$-26		;1887
	dec e			;1889
	ld l,02bh		;188a
	add hl,hl			;188c
	dec hl			;188d
	add a,02bh		;188e
	ex af,af'			;1890
	jr nz,$+124		;1891
	ld e,01fh		;1893
	inc l			;1895
	push af			;1896
	dec hl			;1897
	ld c,c			;1898
	dec de			;1899
	ld a,c			;189a
	ld a,c			;189b
	ld a,h			;189c
	ld a,h			;189d
	ld a,a			;189e
	ld d,b			;189f
	ld b,(hl)			;18a0
	in a,(00ah)		;18a1
	nop			;18a3
	nop			;18a4
	ld a,a			;18a5
	ld a,(bc)			;18a6
	call p,0b10ah		;18a7
	ld a,(bc)			;18aa
	ld (hl),a			;18ab
	inc c			;18ac
	ld (hl),b			;18ad
	inc c			;18ae
	and c			;18af
	dec c			;18b0
	push hl			;18b1
	dec c			;18b2
	ld a,b			;18b3
	ld a,(bc)			;18b4
	ld d,007h		;18b5
	inc de			;18b7
	rlca			;18b8
	ld b,a			;18b9
	ex af,af'			;18ba
	and d			;18bb
	ex af,af'			;18bc
	inc c			;18bd
	ld a,(bc)			;18be
	jp nc,0c70bh		;18bf
	dec bc			;18c2
	jp p,0900bh		;18c3
	inc h			;18c6
	add hl,sp			;18c7
	ld a,(bc)			;18c8
	ld c,(hl)			;18c9
	ld b,(hl)			;18ca
	ld d,e			;18cb
	ld c,(hl)			;18cc
	ld d,d			;18cd
	ld b,a			;18ce
	ld b,(hl)			;18cf
	ld b,h			;18d0
	ld d,b			;18d1
	ld c,c			;18d2
	ld c,a			;18d3
	ld d,(hl)			;18d4
	ld b,(hl)			;18d5
	ld c,l			;18d6
	ld c,h			;18d7
	ld c,c			;18d8
	ld c,c			;18d9
	ld b,c			;18da
	ld b,c			;18db
	ld d,d			;18dc
	cpl			;18dd
	jr nc,$+69		;18de
	ld d,h			;18e0
	ld d,(hl)			;18e1
	ld c,c			;18e2
	ld c,a			;18e3
	ld d,e			;18e4
	ld d,e			;18e5
	ld b,a			;18e6
	ld b,(hl)			;18e7
	ld b,e			;18e8
	ld c,c			;18e9
	ld b,e			;18ea
	ld c,(hl)			;18eb
	ld d,d			;18ec
	ld d,d			;18ed
	ld b,l			;18ee
	ld b,e			;18ef
	ld c,(hl)			;18f0
	ld b,(hl)			;18f1
	ld c,a			;18f2
	ld b,c			;18f3
	ld c,c			;18f4
	ld b,e			;18f5
	ld b,h			;18f6
	sub 000h		;18f7
	ld l,a			;18f9
	ld a,h			;18fa
	sbc a,000h		;18fb
	ld h,a			;18fd
	ld a,b			;18fe
	sbc a,000h		;18ff
	ld b,a			;1901
	ld a,000h		;1902
	ret			;1904
	ld c,d			;1905
	ld e,040h		;1906
	and 04dh		;1908
	in a,(000h)		;190a
	ret			;190c
	out (000h),a		;190d
	ret			;190f
	nop			;1910
	nop			;1911
	nop			;1912
	nop			;1913
	ld b,b			;1914
	jr nc,$+2		;1915
	ld c,h			;1917
	ld b,e			;1918
	cp 0ffh		;1919
	jp (hl)			;191b
	ld b,d			;191c
	jr nz,$+71		;191d
	ld (hl),d			;191f
	ld (hl),d			;1920
	ld l,a			;1921
	nop			;1922
	nop			;1923
	jr nz,$+112		;1924
	ld h,c			;1926
	jr nz,$+2		;1927
	ld d,d			;1929
	ld h,l			;192a
	ld h,c			;192b
	ld h,h			;192c
	ld a,c			;192d
	dec c			;192e
	nop			;192f
	ld b,d			;1930
	ld (hl),d			;1931
	ld h,l			;1932
	ld h,c			;1933
	ld l,e			;1934
	nop			;1935
	ld hl,00004h		;1936
	add hl,sp			;1939
	ld a,(hl)			;193a
	inc hl			;193b
	cp 081h		;193c
	ret nz			;193e
	ld c,(hl)			;193f
	inc hl			;1940
	ld b,(hl)			;1941
	inc hl			;1942
	push hl			;1943
	ld l,c			;1944
	ld h,b			;1945
	ld a,d			;1946
	or e			;1947
	ex de,hl			;1948
	jr z,$+4		;1949
	ex de,hl			;194b
	rst 18h			;194c
	ld bc,0000eh		;194d
	pop hl			;1950
	ret z			;1951
	add hl,bc			;1952
	jr $-25		;1953
	call 0196ch		;1955
	push bc			;1958
	ex (sp),hl			;1959
	pop bc			;195a
	rst 18h			;195b
	ld a,(hl)			;195c
	ld (bc),a			;195d
	ret z			;195e
	dec bc			;195f
	dec hl			;1960
	jr $-6		;1961
	push hl			;1963
	ld hl,(040fdh)		;1964
	ld b,000h		;1967
	add hl,bc			;1969
	add hl,bc			;196a
	ld a,0e5h		;196b
	ld a,0c6h		;196d
	sub l			;196f
	ld l,a			;1970
	ld a,0ffh		;1971
	sbc a,h			;1973
	jr c,$+6		;1974
	ld h,a			;1976
	add hl,sp			;1977
	pop hl			;1978
	ret c			;1979
	ld e,00ch		;197a
	jr $+38		;197c
	ld hl,(040a2h)		;197e
	ld a,h			;1981
	and l			;1982
	inc a			;1983
	jr z,$+10		;1984
	ld a,(040f2h)		;1986
	or a			;1989
	ld e,022h		;198a
	jr nz,$+22		;198c
	jp 01dc1h		;198e
	ld hl,(040dah)		;1991
	ld (040a2h),hl		;1994
	ld e,002h		;1997
	ld bc,0141eh		;1999
	ld bc,0001eh		;199c
	ld bc,0241eh		;199f
	ld hl,(040a2h)		;19a2
	ld (040eah),hl		;19a5
	ld (040ech),hl		;19a8
	ld bc,019b4h		;19ab
	ld hl,(040e8h)		;19ae
	jp 01b9ah		;19b1
	pop bc			;19b4
	ld a,e			;19b5
	ld c,e			;19b6
	ld (0409ah),a		;19b7
	ld hl,(040e6h)		;19ba
	ld (040eeh),hl		;19bd
	ex de,hl			;19c0
	ld hl,(040eah)		;19c1
	ld a,h			;19c4
	and l			;19c5
	inc a			;19c6
	jr z,$+9		;19c7
	ld (040f5h),hl		;19c9
	ex de,hl			;19cc
	ld (040f7h),hl		;19cd
	ld hl,(040f0h)		;19d0
	ld a,h			;19d3
	or l			;19d4
	ex de,hl			;19d5
	ld hl,040f2h		;19d6
	jr z,$+10		;19d9
	and (hl)			;19db
	jr nz,$+7		;19dc
	dec (hl)			;19de
	ex de,hl			;19df
	jp 01d36h		;19e0
	xor a			;19e3
	ld (hl),a			;19e4
	ld e,c			;19e5
	call 020f9h		;19e6
	ld hl,018c9h		;19e9
	call 041a6h		;19ec
	ld d,a			;19ef
	ld a,03fh		;19f0
	call 0032ah		;19f2
	add hl,de			;19f5
	ld a,(hl)			;19f6
	call 0032ah		;19f7
	rst 10h			;19fa
	call 0032ah		;19fb
	ld hl,0191dh		;19fe
	push hl			;1a01
	ld hl,(040eah)		;1a02
	ex (sp),hl			;1a05
	call 028a7h		;1a06
	pop hl			;1a09
	ld de,0fffeh		;1a0a
	rst 18h			;1a0d
	jp z,00674h		;1a0e
	ld a,h			;1a11
	and l			;1a12
	inc a			;1a13
	call nz,00fa7h		;1a14
	ld a,0c1h		;1a17
	call 0038bh		;1a19
	call 041ach		;1a1c
	call 001f8h		;1a1f
	call 020f9h		;1a22
	ld hl,01929h		;1a25
	call 028a7h		;1a28
	ld a,(0409ah)		;1a2b
	sub 002h		;1a2e
	call z,02e53h		;1a30
	ld hl,0ffffh		;1a33
	ld (040a2h),hl		;1a36
	ld a,(040e1h)		;1a39
	or a			;1a3c
	jr z,$+57		;1a3d
	ld hl,(040e2h)		;1a3f
	push hl			;1a42
	call 00fafh		;1a43
	pop de			;1a46
	push de			;1a47
	call 01b2ch		;1a48
	ld a,02ah		;1a4b
	jr c,$+4		;1a4d
	ld a,020h		;1a4f
	call 0032ah		;1a51
	call 00361h		;1a54
	pop de			;1a57
	jr nc,$+8		;1a58
	xor a			;1a5a
	ld (040e1h),a		;1a5b
	jr $-69		;1a5e
	ld hl,(040e4h)		;1a60
	add hl,de			;1a63
	jr c,$-10		;1a64
	push de			;1a66
	ld de,0fff9h		;1a67
	rst 18h			;1a6a
	pop de			;1a6b
	jr nc,$-18		;1a6c
	ld (040e2h),hl		;1a6e
	or 0ffh		;1a71
	jp 02febh		;1a73
	ld a,03eh		;1a76
	call 0032ah		;1a78
	call 00361h		;1a7b
	jp c,01a33h		;1a7e
	rst 10h			;1a81
	inc a			;1a82
	dec a			;1a83
	jp z,01a33h		;1a84
	push af			;1a87
	call 01e5ah		;1a88
	dec hl			;1a8b
	ld a,(hl)			;1a8c
	cp 020h		;1a8d
	jr z,$-4		;1a8f
	inc hl			;1a91
	ld a,(hl)			;1a92
	cp 020h		;1a93
	call z,009c9h		;1a95
	push de			;1a98
	call 01bc0h		;1a99
	pop de			;1a9c
	pop af			;1a9d
	ld (040e6h),hl		;1a9e
	call 041b2h		;1aa1
	jp nc,01d5ah		;1aa4
	push de			;1aa7
	push bc			;1aa8
	xor a			;1aa9
	ld (040ddh),a		;1aaa
	rst 10h			;1aad
	or a			;1aae
	push af			;1aaf
	ex de,hl			;1ab0
	ld (040ech),hl		;1ab1
	ex de,hl			;1ab4
	call 01b2ch		;1ab5
	push bc			;1ab8
	call c,02be4h		;1ab9
	pop de			;1abc
	pop af			;1abd
	push de			;1abe
	jr z,$+41		;1abf
	pop de			;1ac1
	ld hl,(040f9h)		;1ac2
	ex (sp),hl			;1ac5
	pop bc			;1ac6
	add hl,bc			;1ac7
	push hl			;1ac8
	call 01955h		;1ac9
	pop hl			;1acc
	ld (040f9h),hl		;1acd
	ex de,hl			;1ad0
	ld (hl),h			;1ad1
	pop de			;1ad2
	push hl			;1ad3
	inc hl			;1ad4
	inc hl			;1ad5
	ld (hl),e			;1ad6
	inc hl			;1ad7
	ld (hl),d			;1ad8
	inc hl			;1ad9
	ex de,hl			;1ada
	ld hl,(040a7h)		;1adb
	ex de,hl			;1ade
	dec de			;1adf
	dec de			;1ae0
	ld a,(de)			;1ae1
	ld (hl),a			;1ae2
	inc hl			;1ae3
	inc de			;1ae4
	or a			;1ae5
	jr nz,$-5		;1ae6
	pop de			;1ae8
	call 01afch		;1ae9
	call 041b5h		;1aec
	call 01b5dh		;1aef
	call 041b8h		;1af2
	jp 01a33h		;1af5
	ld hl,(040a4h)		;1af8
	ex de,hl			;1afb
	ld h,d			;1afc
	ld l,e			;1afd
	ld a,(hl)			;1afe
	inc hl			;1aff
	or (hl)			;1b00
	ret z			;1b01
	inc hl			;1b02
	inc hl			;1b03
	inc hl			;1b04
	xor a			;1b05
	cp (hl)			;1b06
	inc hl			;1b07
	jr nz,$-2		;1b08
	ex de,hl			;1b0a
	ld (hl),e			;1b0b
	inc hl			;1b0c
	ld (hl),d			;1b0d
	jr $-18		;1b0e
	ld de,00000h		;1b10
	push de			;1b13
	jr z,$+11		;1b14
	pop de			;1b16
	call 01e4fh		;1b17
	push de			;1b1a
	jr z,$+13		;1b1b
	rst 8			;1b1d
	adc a,011h		;1b1e
	jp m,0c4ffh		;1b20
	ld c,a			;1b23
	ld e,0c2h		;1b24
	sub a			;1b26
	add hl,de			;1b27
	ex de,hl			;1b28
	pop de			;1b29
	ex (sp),hl			;1b2a
	push hl			;1b2b
	ld hl,(040a4h)		;1b2c
	ld b,h			;1b2f
	ld c,l			;1b30
	ld a,(hl)			;1b31
	inc hl			;1b32
	or (hl)			;1b33
	dec hl			;1b34
	ret z			;1b35
	inc hl			;1b36
	inc hl			;1b37
	ld a,(hl)			;1b38
	inc hl			;1b39
	ld h,(hl)			;1b3a
	ld l,a			;1b3b
	rst 18h			;1b3c
	ld h,b			;1b3d
	ld l,c			;1b3e
	ld a,(hl)			;1b3f
	inc hl			;1b40
	ld h,(hl)			;1b41
	ld l,a			;1b42
	ccf			;1b43
	ret z			;1b44
	ccf			;1b45
	ret nc			;1b46
	jr $-24		;1b47
	ret nz			;1b49
	call 001c9h		;1b4a
	ld hl,(040a4h)		;1b4d
	call 01df8h		;1b50
	ld (040e1h),a		;1b53
	ld (hl),a			;1b56
	inc hl			;1b57
	ld (hl),a			;1b58
	inc hl			;1b59
	ld (040f9h),hl		;1b5a
	ld hl,(040a4h)		;1b5d
	dec hl			;1b60
	ld (040dfh),hl		;1b61
	ld b,01ah		;1b64
	ld hl,04101h		;1b66
	ld (hl),004h		;1b69
	inc hl			;1b6b
	djnz $-3		;1b6c
	xor a			;1b6e
	ld (040f2h),a		;1b6f
	ld l,a			;1b72
	ld h,a			;1b73
	ld (040f0h),hl		;1b74
	ld (040f7h),hl		;1b77
	ld hl,(040b1h)		;1b7a
	ld (040d6h),hl		;1b7d
	call 01d91h		;1b80
	ld hl,(040f9h)		;1b83
	ld (040fbh),hl		;1b86
	ld (040fdh),hl		;1b89
	call 041bbh		;1b8c
	pop bc			;1b8f
	ld hl,(040a0h)		;1b90
	dec hl			;1b93
	dec hl			;1b94
	ld (040e8h),hl		;1b95
	inc hl			;1b98
	inc hl			;1b99
	ld sp,hl			;1b9a
	ld hl,040b5h		;1b9b
	ld (040b3h),hl		;1b9e
	call 0038bh		;1ba1
	call 0216dh		;1ba4
	xor a			;1ba7
	ld h,a			;1ba8
	ld l,a			;1ba9
	ld (040dch),a		;1baa
	push hl			;1bad
	push bc			;1bae
	ld hl,(040dfh)		;1baf
	ret			;1bb2
	ld a,03fh		;1bb3
	call 0032ah		;1bb5
	ld a,020h		;1bb8
	call 0032ah		;1bba
	jp 00361h		;1bbd
	xor a			;1bc0
	ld (040b0h),a		;1bc1
	ld c,a			;1bc4
	ex de,hl			;1bc5
	ld hl,(040a7h)		;1bc6
	dec hl			;1bc9
	dec hl			;1bca
	ex de,hl			;1bcb
	ld a,(hl)			;1bcc
	cp 020h		;1bcd
	jp z,01c5bh		;1bcf
	ld b,a			;1bd2
	cp 022h		;1bd3
	jp z,01c77h		;1bd5
	or a			;1bd8
	jp z,01c7dh		;1bd9
	ld a,(040b0h)		;1bdc
	or a			;1bdf
	ld a,(hl)			;1be0
	jp nz,01c5bh		;1be1
	cp 03fh		;1be4
	ld a,0b2h		;1be6
	jp z,01c5bh		;1be8
	ld a,(hl)			;1beb
	cp 030h		;1bec
	jr c,$+7		;1bee
	cp 03ch		;1bf0
	jp c,01c5bh		;1bf2
	push de			;1bf5
	ld de,0164fh		;1bf6
	push bc			;1bf9
	ld bc,01c3dh		;1bfa
	push bc			;1bfd
	ld b,07fh		;1bfe
	ld a,(hl)			;1c00
	cp 061h		;1c01
	jr c,$+9		;1c03
	cp 07bh		;1c05
	jr nc,$+5		;1c07
	and 05fh		;1c09
	ld (hl),a			;1c0b
	ld c,(hl)			;1c0c
	ex de,hl			;1c0d
	inc hl			;1c0e
	or (hl)			;1c0f
	jp p,01c0eh		;1c10
	inc b			;1c13
	ld a,(hl)			;1c14
	and 07fh		;1c15
	ret z			;1c17
	cp c			;1c18
	jr nz,$-11		;1c19
	ex de,hl			;1c1b
	push hl			;1c1c
	inc de			;1c1d
	ld a,(de)			;1c1e
	or a			;1c1f
	jp m,01c39h		;1c20
	ld c,a			;1c23
	ld a,b			;1c24
	cp 08dh		;1c25
	jr nz,$+4		;1c27
	rst 10h			;1c29
	dec hl			;1c2a
	inc hl			;1c2b
	ld a,(hl)			;1c2c
	cp 061h		;1c2d
	jr c,$+4		;1c2f
	and 05fh		;1c31
	cp c			;1c33
	jr z,$-23		;1c34
	pop hl			;1c36
	jr $-43		;1c37
	ld c,b			;1c39
	pop af			;1c3a
	ex de,hl			;1c3b
	ret			;1c3c
	ex de,hl			;1c3d
	ld a,c			;1c3e
	pop bc			;1c3f
	pop de			;1c40
	ex de,hl			;1c41
	cp 095h		;1c42
	ld (hl),03ah		;1c44
	jr nz,$+4		;1c46
	inc c			;1c48
	inc hl			;1c49
	cp 0fbh		;1c4a
	jr nz,$+14		;1c4c
	ld (hl),03ah		;1c4e
	inc hl			;1c50
	ld b,093h		;1c51
	ld (hl),b			;1c53
	inc hl			;1c54
	ex de,hl			;1c55
	inc c			;1c56
	inc c			;1c57
	jr $+31		;1c58
	ex de,hl			;1c5a
	inc hl			;1c5b
	ld (de),a			;1c5c
	inc de			;1c5d
	inc c			;1c5e
	sub 03ah		;1c5f
	jr z,$+6		;1c61
	cp 04eh		;1c63
	jr nz,$+5		;1c65
	ld (040b0h),a		;1c67
	sub 059h		;1c6a
	jp nz,01bcch		;1c6c
	ld b,a			;1c6f
	ld a,(hl)			;1c70
	or a			;1c71
	jr z,$+11		;1c72
	cp b			;1c74
	jr z,$-26		;1c75
	inc hl			;1c77
	ld (de),a			;1c78
	inc c			;1c79
	inc de			;1c7a
	jr $-11		;1c7b
	ld hl,00005h		;1c7d
	ld b,h			;1c80
	add hl,bc			;1c81
	ld b,h			;1c82
	ld c,l			;1c83
	ld hl,(040a7h)		;1c84
	dec hl			;1c87
	dec hl			;1c88
	dec hl			;1c89
	ld (de),a			;1c8a
	inc de			;1c8b
	ld (de),a			;1c8c
	inc de			;1c8d
	ld (de),a			;1c8e
	ret			;1c8f
	ld a,h			;1c90
	sub d			;1c91
	ret nz			;1c92
	ld a,l			;1c93
	sub e			;1c94
	ret			;1c95
	ld a,(hl)			;1c96
	ex (sp),hl			;1c97
	cp (hl)			;1c98
	inc hl			;1c99
	ex (sp),hl			;1c9a
	jp z,01d78h		;1c9b
	jp 01997h		;1c9e
	ld a,064h		;1ca1
	ld (040dch),a		;1ca3
	call 01f21h		;1ca6
	ex (sp),hl			;1ca9
	call 01936h		;1caa
	pop de			;1cad
	jr nz,$+7		;1cae
	add hl,bc			;1cb0
	ld sp,hl			;1cb1
	ld (040e8h),hl		;1cb2
	ex de,hl			;1cb5
	ld c,008h		;1cb6
	call 01963h		;1cb8
	push hl			;1cbb
	call 01f05h		;1cbc
	ex (sp),hl			;1cbf
	push hl			;1cc0
	ld hl,(040a2h)		;1cc1
	ex (sp),hl			;1cc4
	rst 8			;1cc5
	cp l			;1cc6
	rst 20h			;1cc7
	jp z,00af6h		;1cc8
	jp nc,00af6h		;1ccb
	push af			;1cce
	call 02337h		;1ccf
	pop af			;1cd2
	push hl			;1cd3
	jp p,01cech		;1cd4
	call 00a7fh		;1cd7
	ex (sp),hl			;1cda
	ld de,00001h		;1cdb
	ld a,(hl)			;1cde
	cp 0cch		;1cdf
	call z,02b01h		;1ce1
	push de			;1ce4
	push hl			;1ce5
	ex de,hl			;1ce6
	call 0099eh		;1ce7
	jr $+36		;1cea
	call 00ab1h		;1cec
	call 009bfh		;1cef
	pop hl			;1cf2
	push bc			;1cf3
	push de			;1cf4
	ld bc,08100h		;1cf5
	ld d,c			;1cf8
	ld e,d			;1cf9
	ld a,(hl)			;1cfa
	cp 0cch		;1cfb
	ld a,001h		;1cfd
	jr nz,$+16		;1cff
	call 02338h		;1d01
	push hl			;1d04
	call 00ab1h		;1d05
	call 009bfh		;1d08
	call 00955h		;1d0b
	pop hl			;1d0e
	push bc			;1d0f
	push de			;1d10
	ld c,a			;1d11
	rst 20h			;1d12
	ld b,a			;1d13
	push bc			;1d14
	push hl			;1d15
	ld hl,(040dfh)		;1d16
	ex (sp),hl			;1d19
	ld b,081h		;1d1a
	push bc			;1d1c
	inc sp			;1d1d
	call 00358h		;1d1e
	or a			;1d21
	call nz,01da0h		;1d22
	ld (040e6h),hl		;1d25
	ld (040e8h),sp		;1d28
	ld a,(hl)			;1d2c
	cp 03ah		;1d2d
	jr z,$+43		;1d2f
	or a			;1d31
	jp nz,01997h		;1d32
	inc hl			;1d35
	ld a,(hl)			;1d36
	inc hl			;1d37
	or (hl)			;1d38
	jp z,0197eh		;1d39
	inc hl			;1d3c
	ld e,(hl)			;1d3d
	inc hl			;1d3e
	ld d,(hl)			;1d3f
	ex de,hl			;1d40
	ld (040a2h),hl		;1d41
	ld a,(0411bh)		;1d44
	or a			;1d47
	jr z,$+17		;1d48
	push de			;1d4a
	ld a,03ch		;1d4b
	call 0032ah		;1d4d
	call 00fafh		;1d50
	ld a,03eh		;1d53
	call 0032ah		;1d55
	pop de			;1d58
	ex de,hl			;1d59
	rst 10h			;1d5a
	ld de,01d1eh		;1d5b
	push de			;1d5e
	ret z			;1d5f
	sub 080h		;1d60
	jp c,01f21h		;1d62
	cp 03ch		;1d65
	jp nc,02ae7h		;1d67
	rlca			;1d6a
	ld c,a			;1d6b
	ld b,000h		;1d6c
	ex de,hl			;1d6e
	ld hl,01822h		;1d6f
	add hl,bc			;1d72
	ld c,(hl)			;1d73
	inc hl			;1d74
	ld b,(hl)			;1d75
	push bc			;1d76
	ex de,hl			;1d77
	inc hl			;1d78
	ld a,(hl)			;1d79
	cp 03ah		;1d7a
	ret nc			;1d7c
	cp 020h		;1d7d
	jp z,01d78h		;1d7f
	cp 00bh		;1d82
	jr nc,$+7		;1d84
	cp 009h		;1d86
	jp nc,01d78h		;1d88
	cp 030h		;1d8b
	ccf			;1d8d
	inc a			;1d8e
	dec a			;1d8f
	ret			;1d90
	ex de,hl			;1d91
	ld hl,(040a4h)		;1d92
	dec hl			;1d95
	ld (040ffh),hl		;1d96
	ex de,hl			;1d99
	ret			;1d9a
	call 00358h		;1d9b
	or a			;1d9e
	ret z			;1d9f
	cp 060h		;1da0
	call z,00384h		;1da2
	ld (04099h),a		;1da5
	dec a			;1da8
	ret nz			;1da9
	inc a			;1daa
	jp 01db4h		;1dab
	ret nz			;1dae
	push af			;1daf
	call z,041bbh		;1db0
	pop af			;1db3
	ld (040e6h),hl		;1db4
	ld hl,040b5h		;1db7
	ld (040b3h),hl		;1dba
	ld hl,0fff6h		;1dbd
	pop bc			;1dc0
	ld hl,(040a2h)		;1dc1
	push hl			;1dc4
	push af			;1dc5
	ld a,l			;1dc6
	and h			;1dc7
	inc a			;1dc8
	jr z,$+11		;1dc9
	ld (040f5h),hl		;1dcb
	ld hl,(040e6h)		;1dce
	ld (040f7h),hl		;1dd1
	call 0038bh		;1dd4
	call 020f9h		;1dd7
	pop af			;1dda
	ld hl,01930h		;1ddb
	jp nz,01a06h		;1dde
	jp 01a18h		;1de1
	ld hl,(040f7h)		;1de4
	ld a,h			;1de7
	or l			;1de8
	ld e,020h		;1de9
	jp z,019a2h		;1deb
	ex de,hl			;1dee
	ld hl,(040f5h)		;1def
	ld (040a2h),hl		;1df2
	ex de,hl			;1df5
	ret			;1df6
	ld a,0afh		;1df7
	ld (0411bh),a		;1df9
	ret			;1dfc
	pop af			;1dfd
	pop hl			;1dfe
	ret			;1dff
	ld e,003h		;1e00
	ld bc,0021eh		;1e02
	ld bc,0041eh		;1e05
	ld bc,0081eh		;1e08
	call 01e3dh		;1e0b
	ld bc,01997h		;1e0e
	push bc			;1e11
	ret c			;1e12
	sub 041h		;1e13
	ld c,a			;1e15
	ld b,a			;1e16
	rst 10h			;1e17
	cp 0ceh		;1e18
	jr nz,$+11		;1e1a
	rst 10h			;1e1c
	call 01e3dh		;1e1d
	ret c			;1e20
	sub 041h		;1e21
	ld b,a			;1e23
	rst 10h			;1e24
	ld a,b			;1e25
	sub c			;1e26
	ret c			;1e27
	inc a			;1e28
	ex (sp),hl			;1e29
	ld hl,04101h		;1e2a
	ld b,000h		;1e2d
	add hl,bc			;1e2f
	ld (hl),e			;1e30
	inc hl			;1e31
	dec a			;1e32
	jr nz,$-3		;1e33
	pop hl			;1e35
	ld a,(hl)			;1e36
	cp 02ch		;1e37
	ret nz			;1e39
	rst 10h			;1e3a
	jr $-48		;1e3b
	ld a,(hl)			;1e3d
	cp 041h		;1e3e
	ret c			;1e40
	cp 05bh		;1e41
	ccf			;1e43
	ret			;1e44
	rst 10h			;1e45
	call 02b02h		;1e46
	ret p			;1e49
	ld e,008h		;1e4a
	jp 019a2h		;1e4c
	ld a,(hl)			;1e4f
	cp 02eh		;1e50
	ex de,hl			;1e52
	ld hl,(040ech)		;1e53
	ex de,hl			;1e56
	jp z,01d78h		;1e57
	dec hl			;1e5a
	ld de,00000h		;1e5b
	rst 10h			;1e5e
	ret nc			;1e5f
	push hl			;1e60
	push af			;1e61
	ld hl,01998h		;1e62
	rst 18h			;1e65
	jp c,01997h		;1e66
	ld h,d			;1e69
	ld l,e			;1e6a
	add hl,de			;1e6b
	add hl,hl			;1e6c
	add hl,de			;1e6d
	add hl,hl			;1e6e
	pop af			;1e6f
	sub 030h		;1e70
	ld e,a			;1e72
	ld d,000h		;1e73
	add hl,de			;1e75
	ex de,hl			;1e76
	pop hl			;1e77
	jr $-26		;1e78
	jp z,01b61h		;1e7a
	call 01e46h		;1e7d
	dec hl			;1e80
	rst 10h			;1e81
	ret nz			;1e82
	push hl			;1e83
	ld hl,(040b1h)		;1e84
	ld a,l			;1e87
	sub e			;1e88
	ld e,a			;1e89
	ld a,h			;1e8a
	sbc a,d			;1e8b
	ld d,a			;1e8c
	jp c,0197ah		;1e8d
	ld hl,(040f9h)		;1e90
	ld bc,00028h		;1e93
	add hl,bc			;1e96
	rst 18h			;1e97
	jp nc,0197ah		;1e98
	ex de,hl			;1e9b
	ld (040a0h),hl		;1e9c
	pop hl			;1e9f
	jp 01b61h		;1ea0
	jp z,01b5dh		;1ea3
	call 041c7h		;1ea6
	call 01b61h		;1ea9
	ld bc,01d1eh		;1eac
	jr $+18		;1eaf
	ld c,003h		;1eb1
	call 01963h		;1eb3
	pop bc			;1eb6
	push hl			;1eb7
	push hl			;1eb8
	ld hl,(040a2h)		;1eb9
	ex (sp),hl			;1ebc
	ld a,091h		;1ebd
	push af			;1ebf
	inc sp			;1ec0
	push bc			;1ec1
	call 01e5ah		;1ec2
	call 01f07h		;1ec5
	push hl			;1ec8
	ld hl,(040a2h)		;1ec9
	rst 18h			;1ecc
	pop hl			;1ecd
	inc hl			;1ece
	call c,01b2fh		;1ecf
	call nc,01b2ch		;1ed2
	ld h,b			;1ed5
	ld l,c			;1ed6
	dec hl			;1ed7
	ret c			;1ed8
	ld e,00eh		;1ed9
	jp 019a2h		;1edb
	ret nz			;1ede
	ld d,0ffh		;1edf
	call 01936h		;1ee1
	ld sp,hl			;1ee4
	ld (040e8h),hl		;1ee5
	cp 091h		;1ee8
	ld e,004h		;1eea
	jp nz,019a2h		;1eec
	pop hl			;1eef
	ld (040a2h),hl		;1ef0
	inc hl			;1ef3
	ld a,h			;1ef4
	or l			;1ef5
	jr nz,$+9		;1ef6
	ld a,(040ddh)		;1ef8
	or a			;1efb
	jp nz,01a18h		;1efc
	ld hl,01d1eh		;1eff
	ex (sp),hl			;1f02
	ld a,0e1h		;1f03
	ld bc,00e3ah		;1f05
	nop			;1f08
	ld b,000h		;1f09
	ld a,c			;1f0b
	ld c,b			;1f0c
	ld b,a			;1f0d
	ld a,(hl)			;1f0e
	or a			;1f0f
	ret z			;1f10
	cp b			;1f11
	ret z			;1f12
	inc hl			;1f13
	cp 022h		;1f14
	jr z,$-11		;1f16
	sub 08fh		;1f18
	jr nz,$-12		;1f1a
	cp b			;1f1c
	adc a,d			;1f1d
	ld d,a			;1f1e
	jr $-17		;1f1f
	call 0260dh		;1f21
	rst 8			;1f24
	push de			;1f25
	ex de,hl			;1f26
	ld (040dfh),hl		;1f27
	ex de,hl			;1f2a
	push de			;1f2b
	rst 20h			;1f2c
	push af			;1f2d
	call 02337h		;1f2e
	pop af			;1f31
	ex (sp),hl			;1f32
	add a,003h		;1f33
	call 02819h		;1f35
	call 00a03h		;1f38
	push hl			;1f3b
	jr nz,$+42		;1f3c
	ld hl,(04121h)		;1f3e
	push hl			;1f41
	inc hl			;1f42
	ld e,(hl)			;1f43
	inc hl			;1f44
	ld d,(hl)			;1f45
	ld hl,(040a4h)		;1f46
	rst 18h			;1f49
	jr nc,$+16		;1f4a
	ld hl,(040a0h)		;1f4c
	rst 18h			;1f4f
	pop de			;1f50
	jr nc,$+17		;1f51
	ld hl,(040f9h)		;1f53
	rst 18h			;1f56
	jr nc,$+11		;1f57
	ld a,0d1h		;1f59
	call 029f5h		;1f5b
	ex de,hl			;1f5e
	call 02843h		;1f5f
	call 029f5h		;1f62
	ex (sp),hl			;1f65
	call 009d3h		;1f66
	pop de			;1f69
	pop hl			;1f6a
	ret			;1f6b
	cp 09eh		;1f6c
	jr nz,$+39		;1f6e
	rst 10h			;1f70
	rst 8			;1f71
	adc a,l			;1f72
	call 01e5ah		;1f73
	ld a,d			;1f76
	or e			;1f77
	jr z,$+11		;1f78
	call 01b2ah		;1f7a
	ld d,b			;1f7d
	ld e,c			;1f7e
	pop hl			;1f7f
	jp nc,01ed9h		;1f80
	ex de,hl			;1f83
	ld (040f0h),hl		;1f84
	ex de,hl			;1f87
	ret c			;1f88
	ld a,(040f2h)		;1f89
	or a			;1f8c
	ret z			;1f8d
	ld a,(0409ah)		;1f8e
	ld e,a			;1f91
	jp 019abh		;1f92
	call 02b1ch		;1f95
	ld a,(hl)			;1f98
	ld b,a			;1f99
	cp 091h		;1f9a
	jr z,$+5		;1f9c
	rst 8			;1f9e
	adc a,l			;1f9f
	dec hl			;1fa0
	ld c,e			;1fa1
	dec c			;1fa2
	ld a,b			;1fa3
	jp z,01d60h		;1fa4
	call 01e5bh		;1fa7
	cp 02ch		;1faa
	ret nz			;1fac
	jr $-11		;1fad
	ld de,040f2h		;1faf
	ld a,(de)			;1fb2
	or a			;1fb3
	jp z,019a0h		;1fb4
	inc a			;1fb7
	ld (0409ah),a		;1fb8
	ld (de),a			;1fbb
	ld a,(hl)			;1fbc
	cp 087h		;1fbd
	jr z,$+14		;1fbf
	call 01e5ah		;1fc1
	ret nz			;1fc4
	ld a,d			;1fc5
	or e			;1fc6
	jp nz,01ec5h		;1fc7
	inc a			;1fca
	jr $+4		;1fcb
	rst 10h			;1fcd
	ret nz			;1fce
	ld hl,(040eeh)		;1fcf
	ex de,hl			;1fd2
	ld hl,(040eah)		;1fd3
	ld (040a2h),hl		;1fd6
	ex de,hl			;1fd9
	ret nz			;1fda
	ld a,(hl)			;1fdb
	or a			;1fdc
	jr nz,$+6		;1fdd
	inc hl			;1fdf
	inc hl			;1fe0
	inc hl			;1fe1
	inc hl			;1fe2
	inc hl			;1fe3
	ld a,d			;1fe4
	and e			;1fe5
	inc a			;1fe6
	jp nz,01f05h		;1fe7
	ld a,(040ddh)		;1fea
	dec a			;1fed
	jp z,01dbeh		;1fee
	jp 01f05h		;1ff1
	call 02b1ch		;1ff4
	ret nz			;1ff7
	or a			;1ff8
	jp z,01e4ah		;1ff9
	dec a			;1ffc
	add a,a			;1ffd
	ld e,a			;1ffe
	cp 02dh		;1fff
	jr c,$+4		;2001
	ld e,026h		;2003
	jp 019a2h		;2005
	ld de,0000ah		;2008
	push de			;200b
	jr z,$+25		;200c
	call 01e4fh		;200e
	ex de,hl			;2011
	ex (sp),hl			;2012
	jr z,$+19		;2013
	ex de,hl			;2015
	rst 8			;2016
	inc l			;2017
	ex de,hl			;2018
	ld hl,(040e4h)		;2019
	ex de,hl			;201c
	jr z,$+8		;201d
	call 01e5ah		;201f
	jp nz,01997h		;2022
	ex de,hl			;2025
	ld a,h			;2026
	or l			;2027
	jp z,01e4ah		;2028
	ld (040e4h),hl		;202b
	ld (040e1h),a		;202e
	pop hl			;2031
	ld (040e2h),hl		;2032
	pop bc			;2035
	jp 01a33h		;2036
	call 02337h		;2039
	ld a,(hl)			;203c
	cp 02ch		;203d
	call z,01d78h		;203f
	cp 0cah		;2042
	call z,01d78h		;2044
	dec hl			;2047
	push hl			;2048
	call 00994h		;2049
	pop hl			;204c
	jr z,$+9		;204d
	rst 10h			;204f
	jp c,01ec2h		;2050
	jp 01d5fh		;2053
	ld d,001h		;2056
	call 01f05h		;2058
	or a			;205b
	ret z			;205c
	rst 10h			;205d
	cp 095h		;205e
	jr nz,$-8		;2060
	dec d			;2062
	jr nz,$-11		;2063
	jr $-22		;2065
	ld a,001h		;2067
	ld (0409ch),a		;2069
	jp 0207ch		;206c
	call 041cah		;206f
	cp 023h		;2072
	jr nz,$+8		;2074
	call 035b3h		;2076
	ld (0409ch),a		;2079
	dec hl			;207c
	rst 10h			;207d
	call z,020feh		;207e
	jp z,02169h		;2081
	or 020h		;2084
	cp 060h		;2086
	jr nz,$+29		;2088
	call 02b01h		;208a
	cp 004h		;208d
	jp nc,01e4ah		;208f
	push hl			;2092
	ld hl,03c00h		;2093
	add hl,de			;2096
	ld (04020h),hl		;2097
	ld a,e			;209a
	and 03fh		;209b
	ld (040a6h),a		;209d
	pop hl			;20a0
	rst 8			;20a1
	inc l			;20a2
	jr $-55		;20a3
	ld a,(hl)			;20a5
	cp 0bfh		;20a6
	jp z,02cbdh		;20a8
	cp 0bch		;20ab
	jp z,02137h		;20ad
	push hl			;20b0
	cp 02ch		;20b1
	jr z,$+85		;20b3
	cp 03bh		;20b5
	jr z,$+96		;20b7
	call 02337h		;20b9
	ex (sp),hl			;20bc
	rst 20h			;20bd
	jr z,$+52		;20be
	call 00fbdh		;20c0
	call 02865h		;20c3
	call 041cdh		;20c6
	ld hl,(04121h)		;20c9
	ld a,(0409ch)		;20cc
	or a			;20cf
	jp m,020e9h		;20d0
	jr z,$+10		;20d3
	ld a,(0409bh)		;20d5
	add a,(hl)			;20d8
	cp 084h		;20d9
	jr $+11		;20db
	ld a,(0409dh)		;20dd
	ld b,a			;20e0
	ld a,(040a6h)		;20e1
	add a,(hl)			;20e4
	cp b			;20e5
	call nc,020feh		;20e6
	call 028aah		;20e9
	ld a,020h		;20ec
	call 0032ah		;20ee
	or a			;20f1
	call z,028aah		;20f2
	pop hl			;20f5
	jp 0207ch		;20f6
	ld a,(040a6h)		;20f9
	or a			;20fc
	ret z			;20fd
	ld a,00dh		;20fe
	call 035cfh		;2100
	call 041d0h		;2103
	xor a			;2106
	ret			;2107
	call 041d3h		;2108
	ld a,(0409ch)		;210b
	or a			;210e
	jp p,02119h		;210f
	ld a,02ch		;2112
	call 0032ah		;2114
	jr $+77		;2117
	jr z,$+10		;2119
	ld a,(0409bh)		;211b
	cp 070h		;211e
	jp 0212bh		;2120
	ld a,(0409eh)		;2123
	ld b,a			;2126
	ld a,(040a6h)		;2127
	cp b			;212a
	call nc,020feh		;212b
	jr nc,$+54		;212e
	sub 010h		;2130
	jr nc,$-2		;2132
	cpl			;2134
	jr $+37		;2135
	call 02b1bh		;2137
	and 07fh		;213a
	ld e,a			;213c
	rst 8			;213d
	add hl,hl			;213e
	dec hl			;213f
	push hl			;2140
	call 041d3h		;2141
	ld a,(0409ch)		;2144
	or a			;2147
	jp m,01e4ah		;2148
	jp z,02153h		;214b
	ld a,(0409bh)		;214e
	jr $+5		;2151
	ld a,(040a6h)		;2153
	cpl			;2156
	add a,e			;2157
	jr nc,$+12		;2158
	inc a			;215a
	ld b,a			;215b
	ld a,020h		;215c
	call 0032ah		;215e
	dec b			;2161
	jr nz,$-4		;2162
	pop hl			;2164
	rst 10h			;2165
	jp 02081h		;2166
	ld a,(0409ch)		;2169
	or a			;216c
	call 001f8h		;216d
	xor a			;2170
	ld (0409ch),a		;2171
	call 041beh		;2174
	ret			;2177
	ccf			;2178
	ld d,d			;2179
	ld b,l			;217a
	ld b,h			;217b
	ld c,a			;217c
	dec c			;217d
	nop			;217e
	ld a,(040deh)		;217f
	or a			;2182
	jp nz,01991h		;2183
	ld a,(040a9h)		;2186
	or a			;2189
	ld e,02ah		;218a
	jp z,019a2h		;218c
	pop bc			;218f
	ld hl,02178h		;2190
	call 028a7h		;2193
	ld hl,(040e6h)		;2196
	ret			;2199
	call 02828h		;219a
	ld a,(hl)			;219d
	call 041d6h		;219e
	sub 023h		;21a1
	ld (040a9h),a		;21a3
	ld a,(hl)			;21a6
	jr nz,$+34		;21a7
	call 00293h		;21a9
	push hl			;21ac
	ld b,0fah		;21ad
	ld hl,(040a7h)		;21af
	call 00235h		;21b2
	ld (hl),a			;21b5
	inc hl			;21b6
	cp 00dh		;21b7
	jr z,$+4		;21b9
	djnz $-9		;21bb
	dec hl			;21bd
	ld (hl),000h		;21be
	call 001f8h		;21c0
	ld hl,(040a7h)		;21c3
	dec hl			;21c6
	jr $+36		;21c7
	ld bc,021dbh		;21c9
	push bc			;21cc
	cp 022h		;21cd
	ret nz			;21cf
	call 02866h		;21d0
	rst 8			;21d3
	dec sp			;21d4
	push hl			;21d5
	call 028aah		;21d6
	pop hl			;21d9
	ret			;21da
	push hl			;21db
	call 01bb3h		;21dc
	pop bc			;21df
	jp c,01dbeh		;21e0
	inc hl			;21e3
	ld a,(hl)			;21e4
	or a			;21e5
	dec hl			;21e6
	push bc			;21e7
	jp z,01f04h		;21e8
	ld (hl),02ch		;21eb
	jr $+7		;21ed
	push hl			;21ef
	ld hl,(040ffh)		;21f0
	or 0afh		;21f3
	ld (040deh),a		;21f5
	ex (sp),hl			;21f8
	jr $+4		;21f9
	rst 8			;21fb
	inc l			;21fc
	call 0260dh		;21fd
	ex (sp),hl			;2200
	push de			;2201
	ld a,(hl)			;2202
	cp 02ch		;2203
	jr z,$+40		;2205
	ld a,(040deh)		;2207
	or a			;220a
	jp nz,02296h		;220b
	ld a,(040a9h)		;220e
	or a			;2211
	ld e,006h		;2212
	jp z,019a2h		;2214
	ld a,03fh		;2217
	call 0032ah		;2219
	call 01bb3h		;221c
	pop de			;221f
	pop bc			;2220
	jp c,01dbeh		;2221
	inc hl			;2224
	ld a,(hl)			;2225
	or a			;2226
	dec hl			;2227
	push bc			;2228
	jp z,01f04h		;2229
	push de			;222c
	call 041dch		;222d
	rst 20h			;2230
	push af			;2231
	jr nz,$+27		;2232
	rst 10h			;2234
	ld d,a			;2235
	ld b,a			;2236
	cp 022h		;2237
	jr z,$+7		;2239
	ld d,03ah		;223b
	ld b,02ch		;223d
	dec hl			;223f
	call 02869h		;2240
	pop af			;2243
	ex de,hl			;2244
	ld hl,0225ah		;2245
	ex (sp),hl			;2248
	push de			;2249
	jp 01f33h		;224a
	rst 10h			;224d
	pop af			;224e
	push af			;224f
	ld bc,02243h		;2250
	push bc			;2253
	jp c,00e6ch		;2254
	jp nc,00e65h		;2257
	dec hl			;225a
	rst 10h			;225b
	jr z,$+7		;225c
	cp 02ch		;225e
	jp nz,0217fh		;2260
	ex (sp),hl			;2263
	dec hl			;2264
	rst 10h			;2265
	jp nz,021fbh		;2266
	pop de			;2269
	ld a,(040deh)		;226a
	or a			;226d
	ex de,hl			;226e
	jp nz,01d96h		;226f
	push de			;2272
	call 041dfh		;2273
	or (hl)			;2276
	ld hl,02281h		;2277
	call nz,028a7h		;227a
	pop hl			;227d
	jp 0216dh		;227e
	ccf			;2281
	ld b,l			;2282
	ld a,b			;2283
	ld h,e			;2284
	ld h,l			;2285
	ld (hl),e			;2286
	ld (hl),e			;2287
	ld l,a			;2288
	jr nz,$+102		;2289
	ld h,l			;228b
	jr nz,$+102		;228c
	ld h,c			;228e
	ld h,h			;228f
	ld l,a			;2290
	ld (hl),e			;2291
	dec c			;2292
	nop			;2293
	nop			;2294
	nop			;2295
	call 01f05h		;2296
	or a			;2299
	jr nz,$+20		;229a
	inc hl			;229c
	ld a,(hl)			;229d
	inc hl			;229e
	or (hl)			;229f
	ld e,006h		;22a0
	jp z,019a2h		;22a2
	inc hl			;22a5
	ld e,(hl)			;22a6
	inc hl			;22a7
	ld d,(hl)			;22a8
	ex de,hl			;22a9
	ld (040dah),hl		;22aa
	ex de,hl			;22ad
	rst 10h			;22ae
	cp 088h		;22af
	jr nz,$-27		;22b1
	jp 0222dh		;22b3
	ld de,00000h		;22b6
	call nz,0260dh		;22b9
	ld (040dfh),hl		;22bc
	call 01936h		;22bf
	jp nz,0199dh		;22c2
	ld sp,hl			;22c5
	ld (040e8h),hl		;22c6
	push de			;22c9
	ld a,(hl)			;22ca
	inc hl			;22cb
	push af			;22cc
	push de			;22cd
	ld a,(hl)			;22ce
	inc hl			;22cf
	or a			;22d0
	jp m,022eah		;22d1
	call 009b1h		;22d4
	ex (sp),hl			;22d7
	push hl			;22d8
	call 0070bh		;22d9
	pop hl			;22dc
	call 009cbh		;22dd
	pop hl			;22e0
	call 009c2h		;22e1
	push hl			;22e4
	call 00a0ch		;22e5
	jr $+43		;22e8
	inc hl			;22ea
	inc hl			;22eb
	inc hl			;22ec
	inc hl			;22ed
	ld c,(hl)			;22ee
	inc hl			;22ef
	ld b,(hl)			;22f0
	inc hl			;22f1
	ex (sp),hl			;22f2
	ld e,(hl)			;22f3
	inc hl			;22f4
	ld d,(hl)			;22f5
	push hl			;22f6
	ld l,c			;22f7
	ld h,b			;22f8
	call 00bd2h		;22f9
	ld a,(040afh)		;22fc
	cp 004h		;22ff
	jp z,007b2h		;2301
	ex de,hl			;2304
	pop hl			;2305
	ld (hl),d			;2306
	dec hl			;2307
	ld (hl),e			;2308
	pop hl			;2309
	push de			;230a
	ld e,(hl)			;230b
	inc hl			;230c
	ld d,(hl)			;230d
	inc hl			;230e
	ex (sp),hl			;230f
	call 00a39h		;2310
	pop hl			;2313
	pop bc			;2314
	sub b			;2315
	call 009c2h		;2316
	jr z,$+11		;2319
	ex de,hl			;231b
	ld (040a2h),hl		;231c
	ld l,c			;231f
	ld h,b			;2320
	jp 01d1ah		;2321
	ld sp,hl			;2324
	ld (040e8h),hl		;2325
	ld hl,(040dfh)		;2328
	ld a,(hl)			;232b
	cp 02ch		;232c
	jp nz,01d1eh		;232e
	rst 10h			;2331
	call 022b9h		;2332
	rst 8			;2335
	jr z,$+45		;2336
	ld d,000h		;2338
	push de			;233a
	ld c,001h		;233b
	call 01963h		;233d
	call 0249fh		;2340
	ld (040f3h),hl		;2343
	ld hl,(040f3h)		;2346
	pop bc			;2349
	ld a,(hl)			;234a
	ld d,000h		;234b
	sub 0d4h		;234d
	jr c,$+21		;234f
	cp 003h		;2351
	jr nc,$+17		;2353
	cp 001h		;2355
	rla			;2357
	xor d			;2358
	cp d			;2359
	ld d,a			;235a
	jp c,01997h		;235b
	ld (040d8h),hl		;235e
	rst 10h			;2361
	jr $-21		;2362
	ld a,d			;2364
	or a			;2365
	jp nz,023ech		;2366
	ld a,(hl)			;2369
	ld (040d8h),hl		;236a
	sub 0cdh		;236d
	ret c			;236f
	cp 007h		;2370
	ret nc			;2372
	ld e,a			;2373
	ld a,(040afh)		;2374
	sub 003h		;2377
	or e			;2379
	jp z,0298fh		;237a
	ld hl,0189ah		;237d
	add hl,de			;2380
	ld a,b			;2381
	ld d,(hl)			;2382
	cp d			;2383
	ret nc			;2384
	push bc			;2385
	ld bc,02346h		;2386
	push bc			;2389
	ld a,d			;238a
	cp 07fh		;238b
	jp z,023d4h		;238d
	cp 051h		;2390
	jp c,023e1h		;2392
	ld hl,04121h		;2395
	or a			;2398
	ld a,(040afh)		;2399
	dec a			;239c
	dec a			;239d
	dec a			;239e
	jp z,00af6h		;239f
	ld c,(hl)			;23a2
	inc hl			;23a3
	ld b,(hl)			;23a4
	push bc			;23a5
	jp m,023c5h		;23a6
	inc hl			;23a9
	ld c,(hl)			;23aa
	inc hl			;23ab
	ld b,(hl)			;23ac
	push bc			;23ad
	push af			;23ae
	or a			;23af
	jp po,023c4h		;23b0
	pop af			;23b3
	inc hl			;23b4
	jr c,$+5		;23b5
	ld hl,0411dh		;23b7
	ld c,(hl)			;23ba
	inc hl			;23bb
	ld b,(hl)			;23bc
	inc hl			;23bd
	push bc			;23be
	ld c,(hl)			;23bf
	inc hl			;23c0
	ld b,(hl)			;23c1
	push bc			;23c2
	ld b,0f1h		;23c3
	add a,003h		;23c5
	ld c,e			;23c7
	ld b,a			;23c8
	push bc			;23c9
	ld bc,02406h		;23ca
	push bc			;23cd
	ld hl,(040d8h)		;23ce
	jp 0233ah		;23d1
	call 00ab1h		;23d4
	call 009a4h		;23d7
	ld bc,013f2h		;23da
	ld d,07fh		;23dd
	jr $-18		;23df
	push de			;23e1
	call 00a7fh		;23e2
	pop de			;23e5
	push hl			;23e6
	ld bc,025e9h		;23e7
	jr $-29		;23ea
	ld a,b			;23ec
	cp 064h		;23ed
	ret nc			;23ef
	push bc			;23f0
	push de			;23f1
	ld de,06404h		;23f2
	ld hl,025b8h		;23f5
	push hl			;23f8
	rst 20h			;23f9
	jp nz,02395h		;23fa
	ld hl,(04121h)		;23fd
	push hl			;2400
	ld bc,0258ch		;2401
	jr $-55		;2404
	pop bc			;2406
	ld a,c			;2407
	ld (040b0h),a		;2408
	ld a,b			;240b
	cp 008h		;240c
	jr z,$+42		;240e
	ld a,(040afh)		;2410
	cp 008h		;2413
	jp z,02460h		;2415
	ld d,a			;2418
	ld a,b			;2419
	cp 004h		;241a
	jp z,02472h		;241c
	ld a,d			;241f
	cp 003h		;2420
	jp z,00af6h		;2422
	jp nc,0247ch		;2425
	ld hl,018bfh		;2428
	ld b,000h		;242b
	add hl,bc			;242d
	add hl,bc			;242e
	ld c,(hl)			;242f
	inc hl			;2430
	ld b,(hl)			;2431
	pop de			;2432
	ld hl,(04121h)		;2433
	push bc			;2436
	ret			;2437
	call 00adbh		;2438
	call 009fch		;243b
	pop hl			;243e
	ld (0411fh),hl		;243f
	pop hl			;2442
	ld (0411dh),hl		;2443
	pop bc			;2446
	pop de			;2447
	call 009b4h		;2448
	call 00adbh		;244b
	ld hl,018abh		;244e
	ld a,(040b0h)		;2451
	rlca			;2454
	push bc			;2455
	ld c,a			;2456
	ld b,000h		;2457
	add hl,bc			;2459
	pop bc			;245a
	ld a,(hl)			;245b
	inc hl			;245c
	ld h,(hl)			;245d
	ld l,a			;245e
	jp (hl)			;245f
	push bc			;2460
	call 009fch		;2461
	pop af			;2464
	ld (040afh),a		;2465
	cp 004h		;2468
	jr z,$-36		;246a
	pop hl			;246c
	ld (04121h),hl		;246d
	jr $-37		;2470
	call 00ab1h		;2472
	pop bc			;2475
	pop de			;2476
	ld hl,018b5h		;2477
	jr $-41		;247a
	pop hl			;247c
	call 009a4h		;247d
	call 00acfh		;2480
	call 009bfh		;2483
	pop hl			;2486
	ld (04123h),hl		;2487
	pop hl			;248a
	ld (04121h),hl		;248b
	jr $-23		;248e
	push hl			;2490
	ex de,hl			;2491
	call 00acfh		;2492
	pop hl			;2495
	call 009a4h		;2496
	call 00acfh		;2499
	jp 008a0h		;249c
	rst 10h			;249f
	ld e,028h		;24a0
	jp z,019a2h		;24a2
	jp c,00e6ch		;24a5
	call 01e3dh		;24a8
	jp nc,02540h		;24ab
	cp 0cdh		;24ae
	jr z,$-17		;24b0
	cp 02eh		;24b2
	jp z,00e6ch		;24b4
	cp 0ceh		;24b7
	jp z,02532h		;24b9
	cp 022h		;24bc
	jp z,02866h		;24be
	cp 0cbh		;24c1
	jp z,025c4h		;24c3
	cp 026h		;24c6
	jp z,04194h		;24c8
	cp 0c3h		;24cb
	jr nz,$+12		;24cd
	rst 10h			;24cf
	ld a,(0409ah)		;24d0
	push hl			;24d3
	call 027f8h		;24d4
	pop hl			;24d7
	ret			;24d8
	cp 0c2h		;24d9
	jr nz,$+12		;24db
	rst 10h			;24dd
	push hl			;24de
	ld hl,(040eah)		;24df
	call 00c66h		;24e2
	pop hl			;24e5
	ret			;24e6
	cp 0c0h		;24e7
	jr nz,$+22		;24e9
	rst 10h			;24eb
	rst 8			;24ec
	jr z,$-49		;24ed
	dec c			;24ef
	ld h,0cfh		;24f0
	add hl,hl			;24f2
	push hl			;24f3
	ex de,hl			;24f4
	ld a,h			;24f5
	or l			;24f6
	jp z,01e4ah		;24f7
	call 00a9ah		;24fa
	pop hl			;24fd
	ret			;24fe
	cp 0c1h		;24ff
	jp z,027feh		;2501
	cp 0c5h		;2504
	jp z,0419dh		;2506
	cp 0c8h		;2509
	jp z,027c9h		;250b
	cp 0c7h		;250e
	jp z,04176h		;2510
	cp 0c6h		;2513
	jp z,00132h		;2515
	cp 0c9h		;2518
	jp z,0019dh		;251a
	cp 0c4h		;251d
	jp z,02a2fh		;251f
	cp 0beh		;2522
	jp z,04155h		;2524
	sub 0d7h		;2527
	jp nc,0254eh		;2529
	call 02335h		;252c
	rst 8			;252f
	add hl,hl			;2530
	ret			;2531
	ld d,07dh		;2532
	call 0233ah		;2534
	ld hl,(040f3h)		;2537
	push hl			;253a
	call 0097bh		;253b
	pop hl			;253e
	ret			;253f
	call 0260dh		;2540
	push hl			;2543
	ex de,hl			;2544
	ld (04121h),hl		;2545
	rst 20h			;2548
	call nz,009f7h		;2549
	pop hl			;254c
	ret			;254d
	ld b,000h		;254e
	rlca			;2550
	ld c,a			;2551
	push bc			;2552
	rst 10h			;2553
	ld a,c			;2554
	cp 041h		;2555
	jr c,$+24		;2557
	call 02335h		;2559
	rst 8			;255c
	inc l			;255d
	call 00af4h		;255e
	ex de,hl			;2561
	ld hl,(04121h)		;2562
	ex (sp),hl			;2565
	push hl			;2566
	ex de,hl			;2567
	call 02b1ch		;2568
	ex de,hl			;256b
	ex (sp),hl			;256c
	jr $+22		;256d
	call 0252ch		;256f
	ex (sp),hl			;2572
	ld a,l			;2573
	cp 00ch		;2574
	jr c,$+9		;2576
	cp 01bh		;2578
	push hl			;257a
	call c,00ab1h		;257b
	pop hl			;257e
	ld de,0253eh		;257f
	push de			;2582
	ld bc,01608h		;2583
	add hl,bc			;2586
	ld c,(hl)			;2587
	inc hl			;2588
	ld h,(hl)			;2589
	ld l,c			;258a
	jp (hl)			;258b
	call 029d7h		;258c
	ld a,(hl)			;258f
	inc hl			;2590
	ld c,(hl)			;2591
	inc hl			;2592
	ld b,(hl)			;2593
	pop de			;2594
	push bc			;2595
	push af			;2596
	call 029deh		;2597
	pop de			;259a
	ld e,(hl)			;259b
	inc hl			;259c
	ld c,(hl)			;259d
	inc hl			;259e
	ld b,(hl)			;259f
	pop hl			;25a0
	ld a,e			;25a1
	or d			;25a2
	ret z			;25a3
	ld a,d			;25a4
	sub 001h		;25a5
	ret c			;25a7
	xor a			;25a8
	cp e			;25a9
	inc a			;25aa
	ret nc			;25ab
	dec d			;25ac
	dec e			;25ad
	ld a,(bc)			;25ae
	cp (hl)			;25af
	inc hl			;25b0
	inc bc			;25b1
	jr z,$-17		;25b2
	ccf			;25b4
	jp 00960h		;25b5
	inc a			;25b8
	adc a,a			;25b9
	pop bc			;25ba
	and b			;25bb
	add a,0ffh		;25bc
	sbc a,a			;25be
	call 0098dh		;25bf
	jr $+20		;25c2
	ld d,05ah		;25c4
	call 0233ah		;25c6
	call 00a7fh		;25c9
	ld a,l			;25cc
	cpl			;25cd
	ld l,a			;25ce
	ld a,h			;25cf
	cpl			;25d0
	ld h,a			;25d1
	ld (04121h),hl		;25d2
	pop bc			;25d5
	jp 02346h		;25d6
	ld a,(040afh)		;25d9
	cp 008h		;25dc
	jr nc,$+7		;25de
	sub 003h		;25e0
	or a			;25e2
	scf			;25e3
	ret			;25e4
	sub 003h		;25e5
	or a			;25e7
	ret			;25e8
	push bc			;25e9
	call 00a7fh		;25ea
	pop af			;25ed
	pop de			;25ee
	ld bc,027fah		;25ef
	push bc			;25f2
	cp 046h		;25f3
	jr nz,$+8		;25f5
	ld a,e			;25f7
	or l			;25f8
	ld l,a			;25f9
	ld a,h			;25fa
	or d			;25fb
	ret			;25fc
	ld a,e			;25fd
	and l			;25fe
	ld l,a			;25ff
	ld a,h			;2600
	and d			;2601
	ret			;2602
	dec hl			;2603
	rst 10h			;2604
	ret z			;2605
	rst 8			;2606
	inc l			;2607
	ld bc,02603h		;2608
	push bc			;260b
	or 0afh		;260c
	ld (040aeh),a		;260e
	ld b,(hl)			;2611
	call 01e3dh		;2612
	jp c,01997h		;2615
	xor a			;2618
	ld c,a			;2619
	rst 10h			;261a
	jr c,$+7		;261b
	call 01e3dh		;261d
	jr c,$+11		;2620
	ld c,a			;2622
	rst 10h			;2623
	jr c,$-1		;2624
	call 01e3dh		;2626
	jr nc,$-6		;2629
	ld de,02652h		;262b
	push de			;262e
	ld d,002h		;262f
	cp 025h		;2631
	ret z			;2633
	inc d			;2634
	cp 024h		;2635
	ret z			;2637
	inc d			;2638
	cp 021h		;2639
	ret z			;263b
	ld d,008h		;263c
	cp 023h		;263e
	ret z			;2640
	ld a,b			;2641
	sub 041h		;2642
	and 07fh		;2644
	ld e,a			;2646
	ld d,000h		;2647
	push hl			;2649
	ld hl,04101h		;264a
	add hl,de			;264d
	ld d,(hl)			;264e
	pop hl			;264f
	dec hl			;2650
	ret			;2651
	ld a,d			;2652
	ld (040afh),a		;2653
	rst 10h			;2656
	ld a,(040dch)		;2657
	or a			;265a
	jp nz,02664h		;265b
	ld a,(hl)			;265e
	sub 028h		;265f
	jp z,026e9h		;2661
	xor a			;2664
	ld (040dch),a		;2665
	push hl			;2668
	push de			;2669
	ld hl,(040f9h)		;266a
	ex de,hl			;266d
	ld hl,(040fbh)		;266e
	rst 18h			;2671
	pop hl			;2672
	jr z,$+27		;2673
	ld a,(de)			;2675
	ld l,a			;2676
	cp h			;2677
	inc de			;2678
	jr nz,$+13		;2679
	ld a,(de)			;267b
	cp c			;267c
	jr nz,$+9		;267d
	inc de			;267f
	ld a,(de)			;2680
	cp b			;2681
	jp z,026cch		;2682
	ld a,013h		;2685
	inc de			;2687
	push hl			;2688
	ld h,000h		;2689
	add hl,de			;268b
	jr $-31		;268c
	ld a,h			;268e
	pop hl			;268f
	ex (sp),hl			;2690
	push af			;2691
	push de			;2692
	ld de,024f1h		;2693
	rst 18h			;2696
	jr z,$+56		;2697
	ld de,02543h		;2699
	rst 18h			;269c
	pop de			;269d
	jr z,$+55		;269e
	pop af			;26a0
	ex (sp),hl			;26a1
	push hl			;26a2
	push bc			;26a3
	ld c,a			;26a4
	ld b,000h		;26a5
	push bc			;26a7
	inc bc			;26a8
	inc bc			;26a9
	inc bc			;26aa
	ld hl,(040fdh)		;26ab
	push hl			;26ae
	add hl,bc			;26af
	pop bc			;26b0
	push hl			;26b1
	call 01955h		;26b2
	pop hl			;26b5
	ld (040fdh),hl		;26b6
	ld h,b			;26b9
	ld l,c			;26ba
	ld (040fbh),hl		;26bb
	dec hl			;26be
	ld (hl),000h		;26bf
	rst 18h			;26c1
	jr nz,$-4		;26c2
	pop de			;26c4
	ld (hl),e			;26c5
	inc hl			;26c6
	pop de			;26c7
	ld (hl),e			;26c8
	inc hl			;26c9
	ld (hl),d			;26ca
	ex de,hl			;26cb
	inc de			;26cc
	pop hl			;26cd
	ret			;26ce
	ld d,a			;26cf
	ld e,a			;26d0
	pop af			;26d1
	pop af			;26d2
	ex (sp),hl			;26d3
	ret			;26d4
	ld (04124h),a		;26d5
	pop bc			;26d8
	ld h,a			;26d9
	ld l,a			;26da
	ld (04121h),hl		;26db
	rst 20h			;26de
	jr nz,$+8		;26df
	ld hl,01928h		;26e1
	ld (04121h),hl		;26e4
	pop hl			;26e7
	ret			;26e8
	push hl			;26e9
	ld hl,(040aeh)		;26ea
	ex (sp),hl			;26ed
	ld d,a			;26ee
	push de			;26ef
	push bc			;26f0
	call 01e45h		;26f1
	pop bc			;26f4
	pop af			;26f5
	ex de,hl			;26f6
	ex (sp),hl			;26f7
	push hl			;26f8
	ex de,hl			;26f9
	inc a			;26fa
	ld d,a			;26fb
	ld a,(hl)			;26fc
	cp 02ch		;26fd
	jr z,$-16		;26ff
	rst 8			;2701
	add hl,hl			;2702
	ld (040f3h),hl		;2703
	pop hl			;2706
	ld (040aeh),hl		;2707
	push de			;270a
	ld hl,(040fbh)		;270b
	ld a,019h		;270e
	ex de,hl			;2710
	ld hl,(040fdh)		;2711
	ex de,hl			;2714
	rst 18h			;2715
	ld a,(040afh)		;2716
	jr z,$+41		;2719
	cp (hl)			;271b
	inc hl			;271c
	jr nz,$+10		;271d
	ld a,(hl)			;271f
	cp c			;2720
	inc hl			;2721
	jr nz,$+6		;2722
	ld a,(hl)			;2724
	cp b			;2725
	ld a,023h		;2726
	inc hl			;2728
	ld e,(hl)			;2729
	inc hl			;272a
	ld d,(hl)			;272b
	inc hl			;272c
	jr nz,$-30		;272d
	ld a,(040aeh)		;272f
	or a			;2732
	ld e,012h		;2733
	jp nz,019a2h		;2735
	pop af			;2738
	sub (hl)			;2739
	jp z,02795h		;273a
	ld e,010h		;273d
	jp 019a2h		;273f
	ld (hl),a			;2742
	inc hl			;2743
	ld e,a			;2744
	ld d,000h		;2745
	pop af			;2747
	ld (hl),c			;2748
	inc hl			;2749
	ld (hl),b			;274a
	inc hl			;274b
	ld c,a			;274c
	call 01963h		;274d
	inc hl			;2750
	inc hl			;2751
	ld (040d8h),hl		;2752
	ld (hl),c			;2755
	inc hl			;2756
	ld a,(040aeh)		;2757
	rla			;275a
	ld a,c			;275b
	ld bc,0000bh		;275c
	jr nc,$+4		;275f
	pop bc			;2761
	inc bc			;2762
	ld (hl),c			;2763
	inc hl			;2764
	ld (hl),b			;2765
	inc hl			;2766
	push af			;2767
	call 00baah		;2768
	pop af			;276b
	dec a			;276c
	jr nz,$-17		;276d
	push af			;276f
	ld b,d			;2770
	ld c,e			;2771
	ex de,hl			;2772
	add hl,de			;2773
	jr c,$-55		;2774
	call 0196ch		;2776
	ld (040fdh),hl		;2779
	dec hl			;277c
	ld (hl),000h		;277d
	rst 18h			;277f
	jr nz,$-4		;2780
	inc bc			;2782
	ld d,a			;2783
	ld hl,(040d8h)		;2784
	ld e,(hl)			;2787
	ex de,hl			;2788
	add hl,hl			;2789
	add hl,bc			;278a
	ex de,hl			;278b
	dec hl			;278c
	dec hl			;278d
	ld (hl),e			;278e
	inc hl			;278f
	ld (hl),d			;2790
	inc hl			;2791
	pop af			;2792
	jr c,$+50		;2793
	ld b,a			;2795
	ld c,a			;2796
	ld a,(hl)			;2797
	inc hl			;2798
	ld d,0e1h		;2799
	ld e,(hl)			;279b
	inc hl			;279c
	ld d,(hl)			;279d
	inc hl			;279e
	ex (sp),hl			;279f
	push af			;27a0
	rst 18h			;27a1
	jp nc,0273dh		;27a2
	call 00baah		;27a5
	add hl,de			;27a8
	pop af			;27a9
	dec a			;27aa
	ld b,h			;27ab
	ld c,l			;27ac
	jr nz,$-19		;27ad
	ld a,(040afh)		;27af
	ld b,h			;27b2
	ld c,l			;27b3
	add hl,hl			;27b4
	sub 004h		;27b5
	jr c,$+6		;27b7
	add hl,hl			;27b9
	jr z,$+8		;27ba
	add hl,hl			;27bc
	or a			;27bd
	jp po,027c2h		;27be
	add hl,bc			;27c1
	pop bc			;27c2
	add hl,bc			;27c3
	ex de,hl			;27c4
	ld hl,(040f3h)		;27c5
	ret			;27c8
	xor a			;27c9
	push hl			;27ca
	ld (040afh),a		;27cb
	call 027d4h		;27ce
	pop hl			;27d1
	rst 10h			;27d2
	ret			;27d3
	ld hl,(040fdh)		;27d4
	ex de,hl			;27d7
	ld hl,00000h		;27d8
	add hl,sp			;27db
	rst 20h			;27dc
	jr nz,$+15		;27dd
	call 029dah		;27df
	call 028e6h		;27e2
	ld hl,(040a0h)		;27e5
	ex de,hl			;27e8
	ld hl,(040d6h)		;27e9
	ld a,l			;27ec
	sub e			;27ed
	ld l,a			;27ee
	ld a,h			;27ef
	sbc a,d			;27f0
	ld h,a			;27f1
	jp 00c66h		;27f2
	ld a,(040a6h)		;27f5
	ld l,a			;27f8
	xor a			;27f9
	ld h,a			;27fa
	jp 00a9ah		;27fb
	call 041a9h		;27fe
	rst 10h			;2801
	call 0252ch		;2802
	push hl			;2805
	ld hl,00890h		;2806
	push hl			;2809
	ld a,(040afh)		;280a
	push af			;280d
	cp 003h		;280e
	call z,029dah		;2810
	pop af			;2813
	ex de,hl			;2814
	ld hl,(0408eh)		;2815
	jp (hl)			;2818
	push hl			;2819
	and 007h		;281a
	ld hl,018a1h		;281c
	ld c,a			;281f
	ld b,000h		;2820
	add hl,bc			;2822
	call 02586h		;2823
	pop hl			;2826
	ret			;2827
	push hl			;2828
	ld hl,(040a2h)		;2829
	inc hl			;282c
	ld a,h			;282d
	or l			;282e
	pop hl			;282f
	ret nz			;2830
	ld e,016h		;2831
	jp 019a2h		;2833
	call 00fbdh		;2836
	call 02865h		;2839
	call 029dah		;283c
	ld bc,02a2bh		;283f
	push bc			;2842
	ld a,(hl)			;2843
	inc hl			;2844
	push hl			;2845
	call 028bfh		;2846
	pop hl			;2849
	ld c,(hl)			;284a
	inc hl			;284b
	ld b,(hl)			;284c
	call 0285ah		;284d
	push hl			;2850
	ld l,a			;2851
	call 029ceh		;2852
	pop de			;2855
	ret			;2856
	call 028bfh		;2857
	ld hl,040d3h		;285a
	push hl			;285d
	ld (hl),a			;285e
	inc hl			;285f
	ld (hl),e			;2860
	inc hl			;2861
	ld (hl),d			;2862
	pop hl			;2863
	ret			;2864
	dec hl			;2865
	ld b,022h		;2866
	ld d,b			;2868
	push hl			;2869
	ld c,0ffh		;286a
	inc hl			;286c
	ld a,(hl)			;286d
	inc c			;286e
	or a			;286f
	jr z,$+8		;2870
	cp d			;2872
	jr z,$+5		;2873
	cp b			;2875
	jr nz,$-10		;2876
	cp 022h		;2878
	call z,01d78h		;287a
	ex (sp),hl			;287d
	inc hl			;287e
	ex de,hl			;287f
	ld a,c			;2880
	call 0285ah		;2881
	ld de,040d3h		;2884
	ld a,0d5h		;2887
	ld hl,(040b3h)		;2889
	ld (04121h),hl		;288c
	ld a,003h		;288f
	ld (040afh),a		;2891
	call 009d3h		;2894
	ld de,040d6h		;2897
	rst 18h			;289a
	ld (040b3h),hl		;289b
	pop hl			;289e
	ld a,(hl)			;289f
	ret nz			;28a0
	ld e,01eh		;28a1
	jp 019a2h		;28a3
	inc hl			;28a6
	call 02865h		;28a7
	call 029dah		;28aa
	call 009c4h		;28ad
	inc d			;28b0
	dec d			;28b1
	ret z			;28b2
	ld a,(bc)			;28b3
	call 0032ah		;28b4
	cp 00dh		;28b7
	call z,02103h		;28b9
	inc bc			;28bc
	jr $-12		;28bd
	or a			;28bf
	ld c,0f1h		;28c0
	push af			;28c2
	ld hl,(040a0h)		;28c3
	ex de,hl			;28c6
	ld hl,(040d6h)		;28c7
	cpl			;28ca
	ld c,a			;28cb
	ld b,0ffh		;28cc
	add hl,bc			;28ce
	inc hl			;28cf
	rst 18h			;28d0
	jr c,$+9		;28d1
	ld (040d6h),hl		;28d3
	inc hl			;28d6
	ex de,hl			;28d7
	pop af			;28d8
	ret			;28d9
	pop af			;28da
	ld e,01ah		;28db
	jp z,019a2h		;28dd
	cp a			;28e0
	push af			;28e1
	ld bc,028c1h		;28e2
	push bc			;28e5
	ld hl,(040b1h)		;28e6
	ld (040d6h),hl		;28e9
	ld hl,00000h		;28ec
	push hl			;28ef
	ld hl,(040a0h)		;28f0
	push hl			;28f3
	ld hl,040b5h		;28f4
	ex de,hl			;28f7
	ld hl,(040b3h)		;28f8
	ex de,hl			;28fb
	rst 18h			;28fc
	ld bc,028f7h		;28fd
	jp nz,0294ah		;2900
	ld hl,(040f9h)		;2903
	ex de,hl			;2906
	ld hl,(040fbh)		;2907
	ex de,hl			;290a
	rst 18h			;290b
	jr z,$+21		;290c
	ld a,(hl)			;290e
	inc hl			;290f
	inc hl			;2910
	inc hl			;2911
	cp 003h		;2912
	jr nz,$+6		;2914
	call 0294bh		;2916
	xor a			;2919
	ld e,a			;291a
	ld d,000h		;291b
	add hl,de			;291d
	jr $-24		;291e
	pop bc			;2920
	ex de,hl			;2921
	ld hl,(040fdh)		;2922
	ex de,hl			;2925
	rst 18h			;2926
	jp z,0296bh		;2927
	ld a,(hl)			;292a
	inc hl			;292b
	call 009c2h		;292c
	push hl			;292f
	add hl,bc			;2930
	cp 003h		;2931
	jr nz,$-19		;2933
	ld (040d8h),hl		;2935
	pop hl			;2938
	ld c,(hl)			;2939
	ld b,000h		;293a
	add hl,bc			;293c
	add hl,bc			;293d
	inc hl			;293e
	ex de,hl			;293f
	ld hl,(040d8h)		;2940
	ex de,hl			;2943
	rst 18h			;2944
	jr z,$-36		;2945
	ld bc,0293fh		;2947
	push bc			;294a
	xor a			;294b
	or (hl)			;294c
	inc hl			;294d
	ld e,(hl)			;294e
	inc hl			;294f
	ld d,(hl)			;2950
	inc hl			;2951
	ret z			;2952
	ld b,h			;2953
	ld c,l			;2954
	ld hl,(040d6h)		;2955
	rst 18h			;2958
	ld h,b			;2959
	ld l,c			;295a
	ret c			;295b
	pop hl			;295c
	ex (sp),hl			;295d
	rst 18h			;295e
	ex (sp),hl			;295f
	push hl			;2960
	ld h,b			;2961
	ld l,c			;2962
	ret nc			;2963
	pop bc			;2964
	pop af			;2965
	pop af			;2966
	push hl			;2967
	push de			;2968
	push bc			;2969
	ret			;296a
	pop de			;296b
	pop hl			;296c
	ld a,l			;296d
	or h			;296e
	ret z			;296f
	dec hl			;2970
	ld b,(hl)			;2971
	dec hl			;2972
	ld c,(hl)			;2973
	push hl			;2974
	dec hl			;2975
	ld l,(hl)			;2976
	ld h,000h		;2977
	add hl,bc			;2979
	ld d,b			;297a
	ld e,c			;297b
	dec hl			;297c
	ld b,h			;297d
	ld c,l			;297e
	ld hl,(040d6h)		;297f
	call 01958h		;2982
	pop hl			;2985
	ld (hl),c			;2986
	inc hl			;2987
	ld (hl),b			;2988
	ld l,c			;2989
	ld h,b			;298a
	dec hl			;298b
	jp 028e9h		;298c
	push bc			;298f
	push hl			;2990
	ld hl,(04121h)		;2991
	ex (sp),hl			;2994
	call 0249fh		;2995
	ex (sp),hl			;2998
	call 00af4h		;2999
	ld a,(hl)			;299c
	push hl			;299d
	ld hl,(04121h)		;299e
	push hl			;29a1
	add a,(hl)			;29a2
	ld e,01ch		;29a3
	jp c,019a2h		;29a5
	call 02857h		;29a8
	pop de			;29ab
	call 029deh		;29ac
	ex (sp),hl			;29af
	call 029ddh		;29b0
	push hl			;29b3
	ld hl,(040d4h)		;29b4
	ex de,hl			;29b7
	call 029c6h		;29b8
	call 029c6h		;29bb
	ld hl,02349h		;29be
	ex (sp),hl			;29c1
	push hl			;29c2
	jp 02884h		;29c3
	pop hl			;29c6
	ex (sp),hl			;29c7
	ld a,(hl)			;29c8
	inc hl			;29c9
	ld c,(hl)			;29ca
	inc hl			;29cb
	ld b,(hl)			;29cc
	ld l,a			;29cd
	inc l			;29ce
	dec l			;29cf
	ret z			;29d0
	ld a,(bc)			;29d1
	ld (de),a			;29d2
	inc bc			;29d3
	inc de			;29d4
	jr $-6		;29d5
	call 00af4h		;29d7
	ld hl,(04121h)		;29da
	ex de,hl			;29dd
	call 029f5h		;29de
	ex de,hl			;29e1
	ret nz			;29e2
	push de			;29e3
	ld d,b			;29e4
	ld e,c			;29e5
	dec de			;29e6
	ld c,(hl)			;29e7
	ld hl,(040d6h)		;29e8
	rst 18h			;29eb
	jr nz,$+7		;29ec
	ld b,a			;29ee
	add hl,bc			;29ef
	ld (040d6h),hl		;29f0
	pop hl			;29f3
	ret			;29f4
	ld hl,(040b3h)		;29f5
	dec hl			;29f8
	ld b,(hl)			;29f9
	dec hl			;29fa
	ld c,(hl)			;29fb
	dec hl			;29fc
	rst 18h			;29fd
	ret nz			;29fe
	ld (040b3h),hl		;29ff
	ret			;2a02
	ld bc,027f8h		;2a03
	push bc			;2a06
	call 029d7h		;2a07
	xor a			;2a0a
	ld d,a			;2a0b
	ld a,(hl)			;2a0c
	or a			;2a0d
	ret			;2a0e
	ld bc,027f8h		;2a0f
	push bc			;2a12
	call 02a07h		;2a13
	jp z,01e4ah		;2a16
	inc hl			;2a19
	ld e,(hl)			;2a1a
	inc hl			;2a1b
	ld d,(hl)			;2a1c
	ld a,(de)			;2a1d
	ret			;2a1e
	ld a,001h		;2a1f
	call 02857h		;2a21
	call 02b1fh		;2a24
	ld hl,(040d4h)		;2a27
	ld (hl),e			;2a2a
	pop bc			;2a2b
	jp 02884h		;2a2c
	rst 10h			;2a2f
	rst 8			;2a30
	jr z,$-49		;2a31
	inc e			;2a33
	dec hl			;2a34
	push de			;2a35
	rst 8			;2a36
	inc l			;2a37
	call 02337h		;2a38
	rst 8			;2a3b
	add hl,hl			;2a3c
	ex (sp),hl			;2a3d
	push hl			;2a3e
	rst 20h			;2a3f
	jr z,$+7		;2a40
	call 02b1fh		;2a42
	jr $+5		;2a45
	call 02a13h		;2a47
	pop de			;2a4a
	push af			;2a4b
	push af			;2a4c
	ld a,e			;2a4d
	call 02857h		;2a4e
	ld e,a			;2a51
	pop af			;2a52
	inc e			;2a53
	dec e			;2a54
	jr z,$-42		;2a55
	ld hl,(040d4h)		;2a57
	ld (hl),a			;2a5a
	inc hl			;2a5b
	dec e			;2a5c
	jr nz,$-3		;2a5d
	jr $-52		;2a5f
	call 02adfh		;2a61
	xor a			;2a64
	ex (sp),hl			;2a65
	ld c,a			;2a66
	ld a,0e5h		;2a67
	push hl			;2a69
	ld a,(hl)			;2a6a
	cp b			;2a6b
	jr c,$+4		;2a6c
	ld a,b			;2a6e
	ld de,0000eh		;2a6f
	push bc			;2a72
	call 028bfh		;2a73
	pop bc			;2a76
	pop hl			;2a77
	push hl			;2a78
	inc hl			;2a79
	ld b,(hl)			;2a7a
	inc hl			;2a7b
	ld h,(hl)			;2a7c
	ld l,b			;2a7d
	ld b,000h		;2a7e
	add hl,bc			;2a80
	ld b,h			;2a81
	ld c,l			;2a82
	call 0285ah		;2a83
	ld l,a			;2a86
	call 029ceh		;2a87
	pop de			;2a8a
	call 029deh		;2a8b
	jp 02884h		;2a8e
	call 02adfh		;2a91
	pop de			;2a94
	push de			;2a95
	ld a,(de)			;2a96
	sub b			;2a97
	jr $-51		;2a98
	ex de,hl			;2a9a
	ld a,(hl)			;2a9b
	call 02ae2h		;2a9c
	inc b			;2a9f
	dec b			;2aa0
	jp z,01e4ah		;2aa1
	push bc			;2aa4
	ld e,0ffh		;2aa5
	cp 029h		;2aa7
	jr z,$+7		;2aa9
	rst 8			;2aab
	inc l			;2aac
	call 02b1ch		;2aad
	rst 8			;2ab0
	add hl,hl			;2ab1
	pop af			;2ab2
	ex (sp),hl			;2ab3
	ld bc,02a69h		;2ab4
	push bc			;2ab7
	dec a			;2ab8
	cp (hl)			;2ab9
	ld b,000h		;2aba
	ret nc			;2abc
	ld c,a			;2abd
	ld a,(hl)			;2abe
	sub c			;2abf
	cp e			;2ac0
	ld b,a			;2ac1
	ret c			;2ac2
	ld b,e			;2ac3
	ret			;2ac4
	call 02a07h		;2ac5
	jp z,027f8h		;2ac8
	ld e,a			;2acb
	inc hl			;2acc
	ld a,(hl)			;2acd
	inc hl			;2ace
	ld h,(hl)			;2acf
	ld l,a			;2ad0
	push hl			;2ad1
	add hl,de			;2ad2
	ld b,(hl)			;2ad3
	ld (hl),d			;2ad4
	ex (sp),hl			;2ad5
	push bc			;2ad6
	ld a,(hl)			;2ad7
	call 00e65h		;2ad8
	pop bc			;2adb
	pop hl			;2adc
	ld (hl),b			;2add
	ret			;2ade
	ex de,hl			;2adf
	rst 8			;2ae0
	add hl,hl			;2ae1
	pop bc			;2ae2
	pop de			;2ae3
	push bc			;2ae4
	ld b,e			;2ae5
	ret			;2ae6
	cp 07ah		;2ae7
	jp nz,01997h		;2ae9
	jp 041d9h		;2aec
	call 02b1fh		;2aef
	ld (04094h),a		;2af2
	call 04093h		;2af5
	jp 027f8h		;2af8
	call 02b0eh		;2afb
	jp 04096h		;2afe
	rst 10h			;2b01
	call 02337h		;2b02
	push hl			;2b05
	call 00a7fh		;2b06
	ex de,hl			;2b09
	pop hl			;2b0a
	ld a,d			;2b0b
	or a			;2b0c
	ret			;2b0d
	call 02b1ch		;2b0e
	ld (04094h),a		;2b11
	ld (04097h),a		;2b14
	rst 8			;2b17
	inc l			;2b18
	jr $+3		;2b19
	rst 10h			;2b1b
	call 02337h		;2b1c
	call 02b05h		;2b1f
	jp nz,01e4ah		;2b22
	dec hl			;2b25
	rst 10h			;2b26
	ld a,e			;2b27
	ret			;2b28
	ld a,001h		;2b29
	ld (0409ch),a		;2b2b
	pop bc			;2b2e
	call 01b10h		;2b2f
	push bc			;2b32
	ld hl,0ffffh		;2b33
	ld (040a2h),hl		;2b36
	pop hl			;2b39
	pop de			;2b3a
	ld c,(hl)			;2b3b
	inc hl			;2b3c
	ld b,(hl)			;2b3d
	inc hl			;2b3e
	ld a,b			;2b3f
	or c			;2b40
	jp z,01a19h		;2b41
	call 041dfh		;2b44
	call 01d9bh		;2b47
	push bc			;2b4a
	ld c,(hl)			;2b4b
	inc hl			;2b4c
	ld b,(hl)			;2b4d
	inc hl			;2b4e
	push bc			;2b4f
	ex (sp),hl			;2b50
	ex de,hl			;2b51
	rst 18h			;2b52
	pop bc			;2b53
	jp c,01a18h		;2b54
	ex (sp),hl			;2b57
	push hl			;2b58
	push bc			;2b59
	ex de,hl			;2b5a
	ld (040ech),hl		;2b5b
	call 00fafh		;2b5e
	ld a,020h		;2b61
	pop hl			;2b63
	call 0032ah		;2b64
	call 02b7eh		;2b67
	ld hl,(040a7h)		;2b6a
	call 02b75h		;2b6d
	call 020feh		;2b70
	jr $-64		;2b73
	ld a,(hl)			;2b75
	or a			;2b76
	ret z			;2b77
	call 0032ah		;2b78
	inc hl			;2b7b
	jr $-7		;2b7c
	push hl			;2b7e
	ld hl,(040a7h)		;2b7f
	ld b,h			;2b82
	ld c,l			;2b83
	pop hl			;2b84
	ld d,0ffh		;2b85
	jr $+5		;2b87
	inc bc			;2b89
	dec d			;2b8a
	ret z			;2b8b
	ld a,(hl)			;2b8c
	or a			;2b8d
	inc hl			;2b8e
	ld (bc),a			;2b8f
	ret z			;2b90
	jp p,02b89h		;2b91
	cp 0fbh		;2b94
	jr nz,$+10		;2b96
	dec bc			;2b98
	dec bc			;2b99
	dec bc			;2b9a
	dec bc			;2b9b
	inc d			;2b9c
	inc d			;2b9d
	inc d			;2b9e
	inc d			;2b9f
	cp 095h		;2ba0
	call z,00b24h		;2ba2
	sub 07fh		;2ba5
	push hl			;2ba7
	ld e,a			;2ba8
	ld hl,01650h		;2ba9
	ld a,(hl)			;2bac
	or a			;2bad
	inc hl			;2bae
	jp p,02bach		;2baf
	dec e			;2bb2
	jr nz,$-7		;2bb3
	and 07fh		;2bb5
	ld (bc),a			;2bb7
	inc bc			;2bb8
	dec d			;2bb9
	jp z,028d8h		;2bba
	ld a,(hl)			;2bbd
	inc hl			;2bbe
	or a			;2bbf
	jp p,02bb7h		;2bc0
	pop hl			;2bc3
	jr $-56		;2bc4
	call 01b10h		;2bc6
	pop de			;2bc9
	push bc			;2bca
	push bc			;2bcb
	call 01b2ch		;2bcc
	jr nc,$+7		;2bcf
	ld d,h			;2bd1
	ld e,l			;2bd2
	ex (sp),hl			;2bd3
	push hl			;2bd4
	rst 18h			;2bd5
	jp nc,01e4ah		;2bd6
	ld hl,01929h		;2bd9
	call 028a7h		;2bdc
	pop bc			;2bdf
	ld hl,01ae8h		;2be0
	ex (sp),hl			;2be3
	ex de,hl			;2be4
	ld hl,(040f9h)		;2be5
	ld a,(de)			;2be8
	ld (bc),a			;2be9
	inc bc			;2bea
	inc de			;2beb
	rst 18h			;2bec
	jr nz,$-5		;2bed
	ld h,b			;2bef
	ld l,c			;2bf0
	ld (040f9h),hl		;2bf1
	ret			;2bf4
	call 00284h		;2bf5
	call 02337h		;2bf8
	push hl			;2bfb
	call 02a13h		;2bfc
	ld a,0d3h		;2bff
	call 00264h		;2c01
	call 00261h		;2c04
	ld a,(de)			;2c07
	call 00264h		;2c08
	ld hl,(040a4h)		;2c0b
	ex de,hl			;2c0e
	ld hl,(040f9h)		;2c0f
	ld a,(de)			;2c12
	inc de			;2c13
	call 00264h		;2c14
	rst 18h			;2c17
	jr nz,$-6		;2c18
	call 001f8h		;2c1a
	pop hl			;2c1d
	ret			;2c1e
	sub 0b2h		;2c1f
	jr z,$+4		;2c21
	xor a			;2c23
	ld bc,0232fh		;2c24
	push af			;2c27
	ld a,(hl)			;2c28
	or a			;2c29
	jr z,$+9		;2c2a
	call 02337h		;2c2c
	call 02a13h		;2c2f
	ld a,(de)			;2c32
	ld l,a			;2c33
	pop af			;2c34
	or a			;2c35
	ld h,a			;2c36
	ld (04121h),hl		;2c37
	call z,01b4dh		;2c3a
	ld hl,00000h		;2c3d
	call 00293h		;2c40
	ld hl,(04121h)		;2c43
	ex de,hl			;2c46
	ld b,003h		;2c47
	call 00235h		;2c49
	sub 0d3h		;2c4c
	jr nz,$-7		;2c4e
	djnz $-7		;2c50
	call 00235h		;2c52
	inc e			;2c55
	dec e			;2c56
	jr z,$+5		;2c57
	cp e			;2c59
	jr nz,$+57		;2c5a
	ld hl,(040a4h)		;2c5c
	ld b,003h		;2c5f
	call 00235h		;2c61
	ld e,a			;2c64
	sub (hl)			;2c65
	and d			;2c66
	jr nz,$+35		;2c67
	ld (hl),e			;2c69
	call 0196ch		;2c6a
	ld a,(hl)			;2c6d
	or a			;2c6e
	inc hl			;2c6f
	jr nz,$-17		;2c70
	call 0022ch		;2c72
	djnz $-20		;2c75
	ld (040f9h),hl		;2c77
	ld hl,01929h		;2c7a
	call 028a7h		;2c7d
	call 001f8h		;2c80
	ld hl,(040a4h)		;2c83
	push hl			;2c86
	jp 01ae8h		;2c87
	ld hl,02ca5h		;2c8a
	call 028a7h		;2c8d
	jp 01a18h		;2c90
	ld (03c3eh),a		;2c93
	ld b,003h		;2c96
	call 00235h		;2c98
	or a			;2c9b
	jr nz,$-6		;2c9c
	djnz $-6		;2c9e
	call 00296h		;2ca0
	jr $-92		;2ca3
	ld l,(hl)			;2ca5
	ld h,c			;2ca6
	ld l,a			;2ca7
	dec c			;2ca8
	nop			;2ca9
	call 00a7fh		;2caa
	ld a,(hl)			;2cad
	jp 027f8h		;2cae
	call 02b02h		;2cb1
	push de			;2cb4
	rst 8			;2cb5
	inc l			;2cb6
	call 02b1ch		;2cb7
	pop de			;2cba
	ld (de),a			;2cbb
	ret			;2cbc
	call 02338h		;2cbd
	call 00af4h		;2cc0
	rst 8			;2cc3
	dec sp			;2cc4
	ex de,hl			;2cc5
	ld hl,(04121h)		;2cc6
	jr $+10		;2cc9
	ld a,(040deh)		;2ccb
	or a			;2cce
	jr z,$+14		;2ccf
	pop de			;2cd1
	ex de,hl			;2cd2
	push hl			;2cd3
	xor a			;2cd4
	ld (040deh),a		;2cd5
	cp d			;2cd8
	push af			;2cd9
	push de			;2cda
	ld b,(hl)			;2cdb
	or b			;2cdc
	jp z,01e4ah		;2cdd
	inc hl			;2ce0
	ld c,(hl)			;2ce1
	inc hl			;2ce2
	ld h,(hl)			;2ce3
	ld l,c			;2ce4
	jr $+30		;2ce5
	ld e,b			;2ce7
	push hl			;2ce8
	ld c,002h		;2ce9
	ld a,(hl)			;2ceb
	inc hl			;2cec
	cp 025h		;2ced
	jp z,02e17h		;2cef
	cp 020h		;2cf2
	jr nz,$+5		;2cf4
	inc c			;2cf6
	djnz $-12		;2cf7
	pop hl			;2cf9
	ld b,e			;2cfa
	ld a,025h		;2cfb
	call 02e49h		;2cfd
	call 0032ah		;2d00
	xor a			;2d03
	ld e,a			;2d04
	ld d,a			;2d05
	call 02e49h		;2d06
	ld d,a			;2d09
	ld a,(hl)			;2d0a
	inc hl			;2d0b
	cp 021h		;2d0c
	jp z,02e14h		;2d0e
	cp 023h		;2d11
	jr z,$+57		;2d13
	dec b			;2d15
	jp z,02dfeh		;2d16
	cp 02bh		;2d19
	ld a,008h		;2d1b
	jr z,$-23		;2d1d
	dec hl			;2d1f
	ld a,(hl)			;2d20
	inc hl			;2d21
	cp 02eh		;2d22
	jr z,$+66		;2d24
	cp 025h		;2d26
	jr z,$-65		;2d28
	cp (hl)			;2d2a
	jr nz,$-46		;2d2b
	cp 024h		;2d2d
	jr z,$+22		;2d2f
	cp 02ah		;2d31
	jr nz,$-54		;2d33
	ld a,b			;2d35
	cp 002h		;2d36
	inc hl			;2d38
	jr c,$+5		;2d39
	ld a,(hl)			;2d3b
	cp 024h		;2d3c
	ld a,020h		;2d3e
	jr nz,$+9		;2d40
	dec b			;2d42
	inc e			;2d43
	cp 0afh		;2d44
	add a,010h		;2d46
	inc hl			;2d48
	inc e			;2d49
	add a,d			;2d4a
	ld d,a			;2d4b
	inc e			;2d4c
	ld c,000h		;2d4d
	dec b			;2d4f
	jr z,$+73		;2d50
	ld a,(hl)			;2d52
	inc hl			;2d53
	cp 02eh		;2d54
	jr z,$+26		;2d56
	cp 023h		;2d58
	jr z,$-14		;2d5a
	cp 02ch		;2d5c
	jr nz,$+28		;2d5e
	ld a,d			;2d60
	or 040h		;2d61
	ld d,a			;2d63
	jr $-24		;2d64
	ld a,(hl)			;2d66
	cp 023h		;2d67
	ld a,02eh		;2d69
	jr nz,$-110		;2d6b
	ld c,001h		;2d6d
	inc hl			;2d6f
	inc c			;2d70
	dec b			;2d71
	jr z,$+39		;2d72
	ld a,(hl)			;2d74
	inc hl			;2d75
	cp 023h		;2d76
	jr z,$-8		;2d78
	push de			;2d7a
	ld de,02d97h		;2d7b
	push de			;2d7e
	ld d,h			;2d7f
	ld e,l			;2d80
	cp 05bh		;2d81
	ret nz			;2d83
	cp (hl)			;2d84
	ret nz			;2d85
	inc hl			;2d86
	cp (hl)			;2d87
	ret nz			;2d88
	inc hl			;2d89
	cp (hl)			;2d8a
	ret nz			;2d8b
	inc hl			;2d8c
	ld a,b			;2d8d
	sub 004h		;2d8e
	ret c			;2d90
	pop de			;2d91
	pop de			;2d92
	ld b,a			;2d93
	inc d			;2d94
	inc hl			;2d95
	jp z,0d1ebh		;2d96
	ld a,d			;2d99
	dec hl			;2d9a
	inc e			;2d9b
	and 008h		;2d9c
	jr nz,$+23		;2d9e
	dec e			;2da0
	ld a,b			;2da1
	or a			;2da2
	jr z,$+18		;2da3
	ld a,(hl)			;2da5
	sub 02dh		;2da6
	jr z,$+8		;2da8
	cp 0feh		;2daa
	jr nz,$+9		;2dac
	ld a,008h		;2dae
	add a,004h		;2db0
	add a,d			;2db2
	ld d,a			;2db3
	dec b			;2db4
	pop hl			;2db5
	pop af			;2db6
	jr z,$+82		;2db7
	push bc			;2db9
	push de			;2dba
	call 02337h		;2dbb
	pop de			;2dbe
	pop bc			;2dbf
	push bc			;2dc0
	push hl			;2dc1
	ld b,e			;2dc2
	ld a,b			;2dc3
	add a,c			;2dc4
	cp 019h		;2dc5
	jp nc,01e4ah		;2dc7
	ld a,d			;2dca
	or 080h		;2dcb
	call 00fbeh		;2dcd
	call 028a7h		;2dd0
	pop hl			;2dd3
	dec hl			;2dd4
	rst 10h			;2dd5
	scf			;2dd6
	jr z,$+15		;2dd7
	ld (040deh),a		;2dd9
	cp 03bh		;2ddc
	jr z,$+7		;2dde
	cp 02ch		;2de0
	jp nz,01997h		;2de2
	rst 10h			;2de5
	pop bc			;2de6
	ex de,hl			;2de7
	pop hl			;2de8
	push hl			;2de9
	push af			;2dea
	push de			;2deb
	ld a,(hl)			;2dec
	sub b			;2ded
	inc hl			;2dee
	ld c,(hl)			;2def
	inc hl			;2df0
	ld h,(hl)			;2df1
	ld l,c			;2df2
	ld d,000h		;2df3
	ld e,a			;2df5
	add hl,de			;2df6
	ld a,b			;2df7
	or a			;2df8
	jp nz,02d03h		;2df9
	jr $+8		;2dfc
	call 02e49h		;2dfe
	call 0032ah		;2e01
	pop hl			;2e04
	pop af			;2e05
	jp nz,02ccbh		;2e06
	call c,020feh		;2e09
	ex (sp),hl			;2e0c
	call 029ddh		;2e0d
	pop hl			;2e10
	jp 02169h		;2e11
	ld c,001h		;2e14
	ld a,0f1h		;2e16
	dec b			;2e18
	call 02e49h		;2e19
	pop hl			;2e1c
	pop af			;2e1d
	jr z,$-21		;2e1e
	push bc			;2e20
	call 02337h		;2e21
	call 00af4h		;2e24
	pop bc			;2e27
	push bc			;2e28
	push hl			;2e29
	ld hl,(04121h)		;2e2a
	ld b,c			;2e2d
	ld c,000h		;2e2e
	push bc			;2e30
	call 02a68h		;2e31
	call 028aah		;2e34
	ld hl,(04121h)		;2e37
	pop af			;2e3a
	sub (hl)			;2e3b
	ld b,a			;2e3c
	ld a,020h		;2e3d
	inc b			;2e3f
	dec b			;2e40
	jp z,02dd3h		;2e41
	call 0032ah		;2e44
	jr $-7		;2e47
	push af			;2e49
	ld a,d			;2e4a
	or a			;2e4b
	ld a,02bh		;2e4c
	call nz,0032ah		;2e4e
	pop af			;2e51
	ret			;2e52
	ld (0409ah),a		;2e53
	ld hl,(040eah)		;2e56
	or h			;2e59
	and l			;2e5a
	inc a			;2e5b
	ex de,hl			;2e5c
	ret z			;2e5d
	jr $+6		;2e5e
	call 01e4fh		;2e60
	ret nz			;2e63
	pop hl			;2e64
	ex de,hl			;2e65
	ld (040ech),hl		;2e66
	ex de,hl			;2e69
	call 01b2ch		;2e6a
	jp nc,01ed9h		;2e6d
	ld h,b			;2e70
	ld l,c			;2e71
	inc hl			;2e72
	inc hl			;2e73
	ld c,(hl)			;2e74
	inc hl			;2e75
	ld b,(hl)			;2e76
	inc hl			;2e77
	push bc			;2e78
	call 02b7eh		;2e79
	pop hl			;2e7c
	push hl			;2e7d
	call 00fafh		;2e7e
	ld a,020h		;2e81
	call 0032ah		;2e83
	ld hl,(040a7h)		;2e86
	ld a,00eh		;2e89
	call 0032ah		;2e8b
	push hl			;2e8e
	ld c,0ffh		;2e8f
	inc c			;2e91
	ld a,(hl)			;2e92
	or a			;2e93
	inc hl			;2e94
	jr nz,$-4		;2e95
	pop hl			;2e97
	ld b,a			;2e98
	ld d,000h		;2e99
	call 00384h		;2e9b
	sub 030h		;2e9e
	jr c,$+16		;2ea0
	cp 00ah		;2ea2
	jr nc,$+12		;2ea4
	ld e,a			;2ea6
	ld a,d			;2ea7
	rlca			;2ea8
	rlca			;2ea9
	add a,d			;2eaa
	rlca			;2eab
	add a,e			;2eac
	ld d,a			;2ead
	jr $-19		;2eae
	push hl			;2eb0
	ld hl,02e99h		;2eb1
	ex (sp),hl			;2eb4
	dec d			;2eb5
	inc d			;2eb6
	jp nz,02ebbh		;2eb7
	inc d			;2eba
	cp 0d8h		;2ebb
	jp z,02fd2h		;2ebd
	cp 0ddh		;2ec0
	jp z,02fe0h		;2ec2
	cp 0f0h		;2ec5
	jr z,$+67		;2ec7
	cp 031h		;2ec9
	jr c,$+4		;2ecb
	sub 020h		;2ecd
	cp 021h		;2ecf
	jp z,02ff6h		;2ed1
	cp 01ch		;2ed4
	jp z,02f40h		;2ed6
	cp 023h		;2ed9
	jr z,$+65		;2edb
	cp 019h		;2edd
	jp z,02f7dh		;2edf
	cp 014h		;2ee2
	jp z,02f4ah		;2ee4
	cp 013h		;2ee7
	jp z,02f65h		;2ee9
	cp 015h		;2eec
	jp z,02fe3h		;2eee
	cp 028h		;2ef1
	jp z,02f78h		;2ef3
	cp 01bh		;2ef6
	jr z,$+30		;2ef8
	cp 018h		;2efa
	jp z,02f75h		;2efc
	cp 011h		;2eff
	ret nz			;2f01
	pop bc			;2f02
	pop de			;2f03
	call 020feh		;2f04
	jp 02e65h		;2f07
	ld a,(hl)			;2f0a
	or a			;2f0b
	ret z			;2f0c
	inc b			;2f0d
	call 0032ah		;2f0e
	inc hl			;2f11
	dec d			;2f12
	jr nz,$-9		;2f13
	ret			;2f15
	push hl			;2f16
	ld hl,02f5fh		;2f17
	ex (sp),hl			;2f1a
	scf			;2f1b
	push af			;2f1c
	call 00384h		;2f1d
	ld e,a			;2f20
	pop af			;2f21
	push af			;2f22
	call c,02f5fh		;2f23
	ld a,(hl)			;2f26
	or a			;2f27
	jp z,02f3eh		;2f28
	call 0032ah		;2f2b
	pop af			;2f2e
	push af			;2f2f
	call c,02fa1h		;2f30
	jr c,$+4		;2f33
	inc hl			;2f35
	inc b			;2f36
	ld a,(hl)			;2f37
	cp e			;2f38
	jr nz,$-19		;2f39
	dec d			;2f3b
	jr nz,$-22		;2f3c
	pop af			;2f3e
	ret			;2f3f
	call 02b75h		;2f40
	call 020feh		;2f43
	pop bc			;2f46
	jp 02e7ch		;2f47
	ld a,(hl)			;2f4a
	or a			;2f4b
	ret z			;2f4c
	ld a,021h		;2f4d
	call 0032ah		;2f4f
	ld a,(hl)			;2f52
	or a			;2f53
	jr z,$+11		;2f54
	call 0032ah		;2f56
	call 02fa1h		;2f59
	dec d			;2f5c
	jr nz,$-11		;2f5d
	ld a,021h		;2f5f
	call 0032ah		;2f61
	ret			;2f64
	ld a,(hl)			;2f65
	or a			;2f66
	ret z			;2f67
	call 00384h		;2f68
	ld (hl),a			;2f6b
	call 0032ah		;2f6c
	inc hl			;2f6f
	inc b			;2f70
	dec d			;2f71
	jr nz,$-13		;2f72
	ret			;2f74
	ld (hl),000h		;2f75
	ld c,b			;2f77
	ld d,0ffh		;2f78
	call 02f0ah		;2f7a
	call 00384h		;2f7d
	or a			;2f80
	jp z,02f7dh		;2f81
	cp 008h		;2f84
	jr z,$+12		;2f86
	cp 00dh		;2f88
	jp z,02fe0h		;2f8a
	cp 01bh		;2f8d
	ret z			;2f8f
	jr nz,$+32		;2f90
	ld a,008h		;2f92
	dec b			;2f94
	inc b			;2f95
	jr z,$+33		;2f96
	call 0032ah		;2f98
	dec hl			;2f9b
	dec b			;2f9c
	ld de,02f7dh		;2f9d
	push de			;2fa0
	push hl			;2fa1
	dec c			;2fa2
	ld a,(hl)			;2fa3
	or a			;2fa4
	scf			;2fa5
	jp z,00890h		;2fa6
	inc hl			;2fa9
	ld a,(hl)			;2faa
	dec hl			;2fab
	ld (hl),a			;2fac
	inc hl			;2fad
	jr $-11		;2fae
	push af			;2fb0
	ld a,c			;2fb1
	cp 0ffh		;2fb2
	jr c,$+5		;2fb4
	pop af			;2fb6
	jr $-58		;2fb7
	sub b			;2fb9
	inc c			;2fba
	inc b			;2fbb
	push bc			;2fbc
	ex de,hl			;2fbd
	ld l,a			;2fbe
	ld h,000h		;2fbf
	add hl,de			;2fc1
	ld b,h			;2fc2
	ld c,l			;2fc3
	inc hl			;2fc4
	call 01958h		;2fc5
	pop bc			;2fc8
	pop af			;2fc9
	ld (hl),a			;2fca
	call 0032ah		;2fcb
	inc hl			;2fce
	jp 02f7dh		;2fcf
	ld a,b			;2fd2
	or a			;2fd3
	ret z			;2fd4
	dec b			;2fd5
	dec hl			;2fd6
	ld a,008h		;2fd7
	call 0032ah		;2fd9
	dec d			;2fdc
	jr nz,$-11		;2fdd
	ret			;2fdf
	call 02b75h		;2fe0
	call 020feh		;2fe3
	pop bc			;2fe6
	pop de			;2fe7
	ld a,d			;2fe8
	and e			;2fe9
	inc a			;2fea
	ld hl,(040a7h)		;2feb
	dec hl			;2fee
	ret z			;2fef
	scf			;2ff0
	inc hl			;2ff1
	push af			;2ff2
	jp 01a98h		;2ff3
	pop bc			;2ff6
	pop de			;2ff7
	jp 01a19h		;2ff8
	sbc a,0c3h		;2ffb
	jp 0b244h		;2ffd
	jp 03036h		;3000
	xor (hl)			;3003
	and e			;3004
	ld (hl),e			;3005
	jr z,$+7		;3006
	ld (ix+005h),000h		;3008
	ret			;300c
	or e			;300d
	ret z			;300e
	ld a,(04099h)		;300f
	or a			;3012
	jr z,$+4		;3013
	xor a			;3015
	ret			;3016
	dec a			;3017
	jr nz,$-1		;3018
	dec (ix+005h)		;301a
	jr nz,$-8		;301d
	inc (ix+005h)		;301f
	or e			;3022
	ret			;3023
	jp 03095h		;3024
	jp 0308fh		;3027
	jp 035a7h		;302a
	jp 035aeh		;302d
	jp 0340dh		;3030
	jp 030eah		;3033
	ld hl,03024h		;3036
	ld de,04000h		;3039
	ld bc,00012h		;303c
	ldir		;303f
	ld sp,042c7h		;3041
	ld (042dbh),sp		;3044
	ld hl,034e0h		;3048
	call 0309dh		;304b
	di			;304e
	ld hl,0304eh		;304f
	ld (0400dh),hl		;3052
	ld sp,042c7h		;3055
	call 001f8h		;3058
	ld hl,034e4h		;305b
	call 0309dh		;305e
	rst 10h			;3061
	cp 01fh		;3062
	jr z,$-46		;3064
	cp 041h		;3066
	jr c,$-7		;3068
	and 0dfh		;306a
	cp 05bh		;306c
	jr nc,$-13		;306e
	rst 8			;3070
	sub 041h		;3071
	rlca			;3073
	ld hl,0304eh		;3074
	push hl			;3077
	ld hl,0356fh		;3078
	add a,l			;307b
	ld l,a			;307c
	ld a,h			;307d
	adc a,000h		;307e
	ld h,a			;3080
	ld e,(hl)			;3081
	inc hl			;3082
	ld h,(hl)			;3083
	ld l,e			;3084
	ld a,0c1h		;3085
	rst 8			;3087
	jp (hl)			;3088
	call 0035bh		;3089
	cp 060h		;308c
	ret nz			;308e
	push de			;308f
	call 00049h		;3090
	pop de			;3093
	ret			;3094
	push de			;3095
	push af			;3096
	call 00033h		;3097
	pop af			;309a
	pop de			;309b
	ret			;309c
	push hl			;309d
	ld a,(hl)			;309e
	inc hl			;309f
	rst 8			;30a0
	or a			;30a1
	jr nz,$-4		;30a2
	pop hl			;30a4
	ret			;30a5
	ld a,h			;30a6
	call 030abh		;30a7
	ld a,l			;30aa
	push af			;30ab
	rrca			;30ac
	rrca			;30ad
	rrca			;30ae
	rrca			;30af
	call 030b4h		;30b0
	pop af			;30b3
	and 00fh		;30b4
	add a,090h		;30b6
	daa			;30b8
	adc a,040h		;30b9
	daa			;30bb
	rst 8			;30bc
	ret			;30bd
	ld b,007h		;30be
	ld hl,041e8h		;30c0
	call 005d9h		;30c3
	ld a,00eh		;30c6
	rst 8			;30c8
	ret			;30c9
	ld de,04000h		;30ca
	ld bc,00012h		;30cd
	ld hl,006d2h		;30d0
	ldir		;30d3
	call 001c9h		;30d5
	jp 006cch		;30d8
	call 03138h		;30db
	push af			;30de
	ex de,hl			;30df
	call 03138h		;30e0
	ex de,hl			;30e3
	ex (sp),hl			;30e4
	cp h			;30e5
	pop hl			;30e6
	ret z			;30e7
	jr $+88		;30e8
	push hl			;30ea
	push bc			;30eb
	xor a			;30ec
	ld b,a			;30ed
	ld l,a			;30ee
	ld h,a			;30ef
	rst 10h			;30f0
	cp 020h		;30f1
	jr z,$+34		;30f3
	sub 030h		;30f5
	jr c,$-7		;30f7
	cp 00ah		;30f9
	jr c,$+14		;30fb
	and 0dfh		;30fd
	sub 007h		;30ff
	cp 00ah		;3101
	jr c,$-19		;3103
	cp 010h		;3105
	jr nc,$-23		;3107
	inc b			;3109
	add hl,hl			;310a
	add hl,hl			;310b
	add hl,hl			;310c
	add hl,hl			;310d
	add a,l			;310e
	ld l,a			;310f
	call 030b4h		;3110
	jr $-35		;3113
	rst 8			;3115
	xor a			;3116
	cp b			;3117
	pop bc			;3118
	ex (sp),hl			;3119
	ld (042e4h),hl		;311a
	pop hl			;311d
	ex (sp),hl			;311e
	push hl			;311f
	ld hl,(042e4h)		;3120
	ret			;3123
	push bc			;3124
	push af			;3125
	ld b,008h		;3126
	rlca			;3128
	ld c,a			;3129
	and 001h		;312a
	add a,030h		;312c
	rst 8			;312e
	ld a,c			;312f
	djnz $-8		;3130
	ld a,0c2h		;3132
	rst 8			;3134
	pop af			;3135
	pop bc			;3136
	ret			;3137
	ld a,042h		;3138
	cp h			;313a
	ret c			;313b
	ld a,03fh		;313c
	cp h			;313e
	ret nc			;313f
	ld hl,034eeh		;3140
	call 0309dh		;3143
	jp 0304eh		;3146
	ld a,h			;3149
	cp d			;314a
	ret c			;314b
	jr z,$+4		;314c
	ex de,hl			;314e
	ret			;314f
	ld a,l			;3150
	cp e			;3151
	ret c			;3152
	ex de,hl			;3153
	ret			;3154
	ld b,004h		;3155
	ld e,(hl)			;3157
	inc hl			;3158
	ld d,(hl)			;3159
	inc hl			;315a
	ex de,hl			;315b
	rst 18h			;315c
	ld a,020h		;315d
	rst 8			;315f
	ex de,hl			;3160
	djnz $-10		;3161
	ret			;3163
	rst 30h			;3164
	ld a,00dh		;3165
	rst 8			;3167
	pop hl			;3168
	call 03138h		;3169
	rst 18h			;316c
	ld b,0feh		;316d
	jp 030c3h		;316f
	rst 30h			;3172
	pop hl			;3173
	call 03138h		;3174
	ld a,(042dfh)		;3177
	or a			;317a
	jr z,$+11		;317b
	push hl			;317d
	ld hl,(042e0h)		;317e
	ld a,(042e2h)		;3181
	ld (hl),a			;3184
	pop hl			;3185
	ld a,(hl)			;3186
	ld (042e2h),a		;3187
	ld (042e0h),hl		;318a
	ld a,0efh		;318d
	ld (hl),a			;318f
	ld (042dfh),a		;3190
	ret			;3193
	call 031f5h		;3194
	call 00296h		;3197
	call 00235h		;319a
	cp 055h		;319d
	jr nz,$+30		;319f
	ld de,03c00h		;31a1
	ld c,006h		;31a4
	call 00235h		;31a6
	ld (de),a			;31a9
	inc e			;31aa
	dec c			;31ab
	jr nz,$-6		;31ac
	ret			;31ae
	call 03194h		;31af
	call 00235h		;31b2
	cp 078h		;31b5
	jr z,$+14		;31b7
	cp 03ch		;31b9
	jr z,$+33		;31bb
	ld hl,034feh		;31bd
	call 0309dh		;31c0
	jr $+6		;31c3
	call 031d1h		;31c5
	rst 18h			;31c8
	call 001f8h		;31c9
	ret			;31cc
	call 00235h		;31cd
	ld b,a			;31d0
	call 00235h		;31d1
	ld l,a			;31d4
	call 00235h		;31d5
	ld h,a			;31d8
	add a,l			;31d9
	ld c,a			;31da
	ret			;31db
	call 0022ch		;31dc
	call 031cdh		;31df
	call 00235h		;31e2
	cp (hl)			;31e5
	jr nz,$-41		;31e6
	add a,c			;31e8
	ld c,a			;31e9
	inc hl			;31ea
	djnz $-9		;31eb
	call 00235h		;31ed
	cp c			;31f0
	jr nz,$-52		;31f1
	jr $-65		;31f3
	rst 30h			;31f5
	pop hl			;31f6
	ld a,l			;31f7
	call 00211h		;31f8
	push hl			;31fb
	ld hl,035a3h		;31fc
	call 0309dh		;31ff
	pop hl			;3202
	ret			;3203
	rst 30h			;3204
	rst 30h			;3205
	pop de			;3206
	pop hl			;3207
	ld a,00dh		;3208
	rst 8			;320a
	ld b,010h		;320b
	rst 18h			;320d
	ld a,0c4h		;320e
	rst 8			;3210
	ld a,(hl)			;3211
	rst 20h			;3212
	push hl			;3213
	or a			;3214
	sbc hl,de		;3215
	pop hl			;3217
	inc hl			;3218
	ret z			;3219
	djnz $-9		;321a
	call 03089h		;321c
	jr $-23		;321f
	rst 30h			;3221
	pop hl			;3222
	ld a,00dh		;3223
	rst 8			;3225
	rst 18h			;3226
	ld a,(hl)			;3227
	rst 20h			;3228
	rst 30h			;3229
	jr nc,$+7		;322a
	call 03138h		;322c
	pop de			;322f
	ld (hl),e			;3230
	inc hl			;3231
	jr $-15		;3232
	rst 30h			;3234
	rst 30h			;3235
	rst 30h			;3236
	pop hl			;3237
	pop de			;3238
	call 030dbh		;3239
	call 03149h		;323c
	pop bc			;323f
	dec hl			;3240
	inc hl			;3241
	ld (hl),c			;3242
	ld a,d			;3243
	cp h			;3244
	jr nz,$-4		;3245
	ld a,e			;3247
	cp l			;3248
	jr nz,$-8		;3249
	ret			;324b
	rst 30h			;324c
	ld hl,0340dh		;324d
	ld (0400dh),hl		;3250
	pop hl			;3253
	jr nc,$+5		;3254
	ld (042ddh),hl		;3256
	ld hl,(042dbh)		;3259
	ld de,(042ddh)		;325c
	dec hl			;3260
	ld (hl),d			;3261
	dec hl			;3262
	ld (042dbh),hl		;3263
	ld (hl),e			;3266
	pop hl			;3267
	pop hl			;3268
	pop de			;3269
	pop bc			;326a
	pop af			;326b
	exx			;326c
	ex af,af'			;326d
	pop hl			;326e
	pop de			;326f
	pop bc			;3270
	pop af			;3271
	pop iy		;3272
	pop ix		;3274
	ld sp,(042dbh)		;3276
	push hl			;327a
	ld hl,(042dbh)		;327b
	inc hl			;327e
	inc hl			;327f
	ld (042dbh),hl		;3280
	pop hl			;3283
	ret			;3284
	rst 30h			;3285
	rst 30h			;3286
	ld a,00dh		;3287
	rst 8			;3289
	ld hl,03503h		;328a
	call 0309dh		;328d
	pop hl			;3290
	rst 18h			;3291
	ex de,hl			;3292
	pop hl			;3293
	rst 18h			;3294
	push hl			;3295
	push de			;3296
	add hl,de			;3297
	rst 18h			;3298
	pop hl			;3299
	pop de			;329a
	or a			;329b
	sbc hl,de		;329c
	rst 18h			;329e
	ex de,hl			;329f
	xor a			;32a0
	ld l,a			;32a1
	ld h,a			;32a2
	sbc hl,de		;32a3
	rst 18h			;32a5
	ret			;32a6
	rst 30h			;32a7
	ld a,00dh		;32a8
	rst 8			;32aa
	pop bc			;32ab
	ld a,c			;32ac
	rst 20h			;32ad
	ld a,0c4h		;32ae
	rst 8			;32b0
	in a,(c)		;32b1
	call 03124h		;32b3
	rst 20h			;32b6
	ret			;32b7
	ld hl,0352dh		;32b8
	call 0309dh		;32bb
	ld hl,042c7h		;32be
	call 03155h		;32c1
	ld a,e			;32c4
	call 03124h		;32c5
	push hl			;32c8
	ld hl,03515h		;32c9
	call 0309dh		;32cc
	pop hl			;32cf
	call 03155h		;32d0
	ld a,e			;32d3
	call 03124h		;32d4
	push hl			;32d7
	ld hl,03549h		;32d8
	call 0309dh		;32db
	pop hl			;32de
	call 03155h		;32df
	ret			;32e2
	ld hl,03558h		;32e3
	call 0309dh		;32e6
	ret			;32e9
	rst 30h			;32ea
	rst 30h			;32eb
	rst 30h			;32ec
	pop bc			;32ed
	pop de			;32ee
	pop hl			;32ef
	push hl			;32f0
	push de			;32f1
	push bc			;32f2
	add hl,de			;32f3
	dec hl			;32f4
	call 030dbh		;32f5
	pop de			;32f8
	pop hl			;32f9
	call 03149h		;32fa
	jr nc,$+7		;32fd
	pop bc			;32ff
	ex de,hl			;3300
	ldir		;3301
	ret			;3303
	pop bc			;3304
	add hl,bc			;3305
	dec hl			;3306
	ex de,hl			;3307
	add hl,bc			;3308
	dec hl			;3309
	ex de,hl			;330a
	lddr		;330b
	ret			;330d
	rst 30h			;330e
	rst 30h			;330f
	ld a,00dh		;3310
	rst 8			;3312
	pop hl			;3313
	pop de			;3314
	call 03149h		;3315
	push hl			;3318
	pop hl			;3319
	push hl			;331a
	call 03089h		;331b
	ld a,(hl)			;331e
	ld b,a			;331f
	cpl			;3320
	ld (hl),a			;3321
	ld a,(hl)			;3322
	cpl			;3323
	ld (hl),a			;3324
	xor b			;3325
	call nz,03333h		;3326
	push hl			;3329
	or a			;332a
	sbc hl,de		;332b
	pop hl			;332d
	inc hl			;332e
	jr c,$-17		;332f
	jr $-24		;3331
	push af			;3333
	rst 18h			;3334
	pop af			;3335
	call 03124h		;3336
	rst 20h			;3339
	ld a,00dh		;333a
	rst 8			;333c
	ret			;333d
	rst 30h			;333e
	rst 30h			;333f
	pop de			;3340
	pop bc			;3341
	out (c),e		;3342
	ret			;3344
	call 03194h		;3345
	ld hl,(041e2h)		;3348
	push hl			;334b
	ld a,(041e4h)		;334c
	push af			;334f
	ld a,0c3h		;3350
	ld (041e2h),a		;3352
	ld hl,0335eh		;3355
	ld (041e3h),hl		;3358
	jp 002e7h		;335b
	pop af			;335e
	rst 18h			;335f
	pop af			;3360
	pop hl			;3361
	ld (041e4h),a		;3362
	ld (041e2h),hl		;3365
	ret			;3368
	rst 30h			;3369
	rst 30h			;336a
	rst 30h			;336b
	ld a,00dh		;336c
	rst 8			;336e
	pop hl			;336f
	pop de			;3370
	pop bc			;3371
	call 0035bh		;3372
	ld a,(de)			;3375
	inc de			;3376
	xor (hl)			;3377
	call nz,03333h		;3378
	inc hl			;337b
	dec bc			;337c
	ld a,b			;337d
	or c			;337e
	jr nz,$-10		;337f
	ret			;3381
	call 030beh		;3382
	push hl			;3385
	ld b,c			;3386
	ld a,(hl)			;3387
	cp 00dh		;3388
	jr z,$+7		;338a
	inc hl			;338c
	djnz $-6		;338d
	jr $+7		;338f
	ld (hl),020h		;3391
	inc hl			;3393
	djnz $-3		;3394
	pop hl			;3396
	ld a,0c2h		;3397
	rst 8			;3399
	rst 30h			;339a
	rst 30h			;339b
	rst 30h			;339c
	ex de,hl			;339d
	pop hl			;339e
	ld (042e4h),hl		;339f
	rst 30h			;33a2
	ld hl,0355bh		;33a3
	call 0309dh		;33a6
	rst 10h			;33a9
	pop hl			;33aa
	ld a,l			;33ab
	call 031f8h		;33ac
	ex de,hl			;33af
	call 00287h		;33b0
	ld b,006h		;33b3
	ld a,055h		;33b5
	call 033ffh		;33b7
	pop hl			;33ba
	pop de			;33bb
	or a			;33bc
	sbc hl,de		;33bd
	inc hl			;33bf
	ex de,hl			;33c0
	ld b,000h		;33c1
	ld a,d			;33c3
	sub 001h		;33c4
	ld d,a			;33c6
	ld a,03ch		;33c7
	jr c,$+11		;33c9
	call 033efh		;33cb
	ld a,c			;33ce
	call 00264h		;33cf
	jr $-17		;33d2
	ld c,a			;33d4
	ld a,e			;33d5
	or a			;33d6
	jr z,$+11		;33d7
	ld b,e			;33d9
	ld a,c			;33da
	call 033efh		;33db
	ld a,c			;33de
	call 00264h		;33df
	ld hl,042e4h		;33e2
	ld b,002h		;33e5
	ld a,078h		;33e7
	call 033ffh		;33e9
	jp 001f8h		;33ec
	call 00264h		;33ef
	ld a,b			;33f2
	call 00264h		;33f3
	ld a,l			;33f6
	ld c,l			;33f7
	call 00264h		;33f8
	ld a,h			;33fb
	add a,c			;33fc
	ld c,a			;33fd
	ld a,h			;33fe
	call 00264h		;33ff
	ld a,(hl)			;3402
	add a,c			;3403
	ld c,a			;3404
	ld a,(hl)			;3405
	inc hl			;3406
	call 00264h		;3407
	djnz $-8		;340a
	ret			;340c
	ld (042cfh),hl		;340d
	push af			;3410
	pop hl			;3411
	ld (042d5h),hl		;3412
	ld (042d1h),de		;3415
	pop hl			;3419
	ld (042dbh),sp		;341a
	ld sp,042dbh		;341e
	ld (042ddh),hl		;3421
	ld a,(042dfh)		;3424
	or a			;3427
	jr z,$+41		;3428
	dec hl			;342a
	cp (hl)			;342b
	jr nz,$+37		;342c
	ld de,(042e0h)		;342e
	ld a,d			;3432
	cp h			;3433
	jr nz,$+29		;3434
	ld a,e			;3436
	cp l			;3437
	jr nz,$+25		;3438
	ld a,(042e2h)		;343a
	ld (hl),a			;343d
	ld (042ddh),hl		;343e
	xor a			;3441
	ld (042dfh),a		;3442
	ld de,(042d1h)		;3445
	ld hl,(042d5h)		;3449
	push hl			;344c
	pop af			;344d
	ld hl,(042cfh)		;344e
	push ix		;3451
	push iy		;3453
	push af			;3455
	push bc			;3456
	push de			;3457
	push hl			;3458
	ex af,af'			;3459
	exx			;345a
	push af			;345b
	push bc			;345c
	push de			;345d
	push hl			;345e
	ld hl,0304eh		;345f
	push hl			;3462
	jp 032b8h		;3463
	call 032b8h		;3466
	ld a,00dh		;3469
	rst 8			;346b
	call 030beh		;346c
	ld b,000h		;346f
	ld a,(hl)			;3471
	cp 00dh		;3472
	jr z,$+7		;3474
	add a,b			;3476
	ld b,a			;3477
	inc hl			;3478
	jr $-8		;3479
	rst 8			;347b
	rst 30h			;347c
	pop hl			;347d
	ld a,b			;347e
	cp 087h		;347f
	jr nz,$+6		;3481
	ld (042d5h),hl		;3483
	ret			;3486
	cp 085h		;3487
	jr nz,$+6		;3489
	ld (042d3h),hl		;348b
	ret			;348e
	cp 089h		;348f
	jr nz,$+6		;3491
	ld (042d1h),hl		;3493
	ret			;3496
	cp 094h		;3497
	jr nz,$+6		;3499
	ld (042cfh),hl		;349b
	ret			;349e
	cp 0aeh		;349f
	jr nz,$+6		;34a1
	ld (042cdh),hl		;34a3
	ret			;34a6
	cp 0ach		;34a7
	jr nz,$+6		;34a9
	ld (042cbh),hl		;34ab
	ret			;34ae
	cp 0b0h		;34af
	jr nz,$+6		;34b1
	ld (042c9h),hl		;34b3
	ret			;34b6
	cp 0bbh		;34b7
	jr nz,$+6		;34b9
	ld (042c7h),hl		;34bb
	ret			;34be
	cp 0a1h		;34bf
	jr nz,$+6		;34c1
	ld (042d9h),hl		;34c3
	ret			;34c6
	cp 0a2h		;34c7
	jr nz,$+6		;34c9
	ld (042d7h),hl		;34cb
	ret			;34ce
	cp 0a3h		;34cf
	jr nz,$+6		;34d1
	ld (042dbh),hl		;34d3
	ret			;34d6
	cp 093h		;34d7
	jp nz,031bdh		;34d9
	ld (042ddh),hl		;34dc
	ret			;34df
	ld c,01ch		;34e0
	rra			;34e2
	nop			;34e3
	ld a,(bc)			;34e4
	ld b,h			;34e5
	ld c,c			;34e6
	ld b,a			;34e7
	ld b,d			;34e8
	ld d,l			;34e9
	ld b,a			;34ea
	jr nz,$+64		;34eb
	nop			;34ed
	ld a,(bc)			;34ee
	ld b,c			;34ef
	ld (hl),d			;34f0
	ld h,l			;34f1
	ld h,c			;34f2
	jr nz,$+82		;34f3
	ld (hl),d			;34f5
	ld l,a			;34f6
	ld (hl),h			;34f7
	ld h,l			;34f8
	ld h,a			;34f9
	ld l,c			;34fa
	ld h,h			;34fb
	ld h,c			;34fc
	nop			;34fd
	ld b,l			;34fe
	ld d,d			;34ff
	ld d,d			;3500
	ld c,a			;3501
	nop			;3502
	pop bc			;3503
	ld b,c			;3504
	call nz,0c342h		;3505
	ld b,c			;3508
	dec hl			;3509
	ld b,d			;350a
	jp nz,02d41h		;350b
	ld b,d			;350e
	jp nz,02d42h		;350f
	ld b,c			;3512
	dec c			;3513
	nop			;3514
	ld a,(bc)			;3515
	jr nz,$+74		;3516
	ld c,h			;3518
	call nz,04544h		;3519
	call nz,04342h		;351c
	call nz,04641h		;351f
	jp 05a53h		;3522
	dec l			;3525
	ld c,b			;3526
	dec l			;3527
	ld d,b			;3528
	ld c,(hl)			;3529
	ld b,e			;352a
	dec c			;352b
	nop			;352c
	ld a,(bc)			;352d
	jr nz,$+74		;352e
	ld c,h			;3530
	daa			;3531
	jp 04544h		;3532
	daa			;3535
	jp 04342h		;3536
	daa			;3539
	jp 04641h		;353a
	daa			;353d
	jp nz,05a53h		;353e
	dec l			;3541
	ld c,b			;3542
	dec l			;3543
	ld d,b			;3544
	ld c,(hl)			;3545
	ld b,e			;3546
	dec c			;3547
	nop			;3548
	ld a,(bc)			;3549
	jr nz,$+75		;354a
	ld e,c			;354c
	call nz,05849h		;354d
	call nz,05053h		;3550
	call nz,04350h		;3553
	dec c			;3556
	nop			;3557
	dec e			;3558
	ld e,000h		;3559
	ld a,(bc)			;355b
	ld d,b			;355c
	ld (hl),d			;355d
	ld h,l			;355e
	ld (hl),b			;355f
	ld h,c			;3560
	ld (hl),d			;3561
	ld h,l			;3562
	jr nz,$+113		;3563
	jr nz,$+105		;3565
	ld (hl),d			;3567
	ld h,c			;3568
	halt			;3569
	ld h,c			;356a
	ld h,h			;356b
	ld l,a			;356c
	ld (hl),d			;356d
	nop			;356e
	ld h,h			;356f
	ld sp,03172h		;3570
	xor a			;3573
	ld sp,03204h		;3574
	ld hl,03432h		;3577
	ld (0324ch),a		;357a
	add a,l			;357d
	ld (032a7h),a		;357e
	cp b			;3581
	ld (032e3h),a		;3582
	ex (sp),hl			;3585
	ld (032eah),a		;3586
	ld c,033h		;3589
	ld a,033h		;358b
	ex (sp),hl			;358d
	ld (030cah),a		;358e
	ld b,l			;3591
	inc sp			;3592
	ex (sp),hl			;3593
	ld (032e3h),a		;3594
	ex (sp),hl			;3597
	ld (03369h),a		;3598
	add a,d			;359b
	inc sp			;359c
	ld h,(hl)			;359d
	inc (hl)			;359e
	ex (sp),hl			;359f
	ld (032e3h),a		;35a0
	inc e			;35a3
	call z,0001fh		;35a4
	call 030a6h		;35a7
	ld a,020h		;35aa
	rst 8			;35ac
	ret			;35ad
	call 030abh		;35ae
	jr $-7		;35b1
	call 02828h		;35b3
	call 02b01h		;35b6
	rst 8			;35b9
	inc l			;35ba
	ld a,e			;35bb
	and d			;35bc
	jp p,01e4ah		;35bd
	push hl			;35c0
	ld hl,(040a7h)		;35c1
	ld d,h			;35c4
	ld e,l			;35c5
	inc de			;35c6
	ld (hl),d			;35c7
	dec hl			;35c8
	ld (hl),e			;35c9
	dec hl			;35ca
	ld (hl),000h		;35cb
	pop hl			;35cd
	ret			;35ce
	call 0032ah		;35cf
	ld a,(0409ch)		;35d2
	or a			;35d5
	ret p			;35d6
	call 0020ch		;35d7
	push hl			;35da
	ld hl,(040a7h)		;35db
	dec hl			;35de
	dec hl			;35df
	call 00287h		;35e0
	ld b,(hl)			;35e3
	inc hl			;35e4
	inc hl			;35e5
	inc hl			;35e6
	ld a,(hl)			;35e7
	call 00264h		;35e8
	djnz $-5		;35eb
	pop hl			;35ed
	ret			;35ee
	push hl			;35ef
	push de			;35f0
	ld hl,(040a7h)		;35f1
	ld d,(hl)			;35f4
	dec hl			;35f5
	ld e,(hl)			;35f6
	dec hl			;35f7
	ld (de),a			;35f8
	ld a,(hl)			;35f9
	cp 0fah		;35fa
	jr nc,$+9		;35fc
	inc a			;35fe
	ld (hl),a			;35ff
	inc de			;3600
	inc hl			;3601
	ld (hl),e			;3602
	inc hl			;3603
	ld (hl),d			;3604
	pop de			;3605
	pop hl			;3606
	ret			;3607
	nop			;3608
	nop			;3609
	nop			;360a
	nop			;360b
	nop			;360c
	nop			;360d
	nop			;360e
	nop			;360f
	nop			;3610
	nop			;3611
	nop			;3612
	nop			;3613
	nop			;3614
	nop			;3615
	nop			;3616
	nop			;3617
	nop			;3618
	nop			;3619
	nop			;361a
	nop			;361b
	nop			;361c
	nop			;361d
	nop			;361e
	nop			;361f
	nop			;3620
	nop			;3621
	nop			;3622
	nop			;3623
	nop			;3624
	nop			;3625
	nop			;3626
	nop			;3627
	nop			;3628
	nop			;3629
	nop			;362a
	nop			;362b
	nop			;362c
	nop			;362d
	nop			;362e
	nop			;362f
	nop			;3630
	nop			;3631
	nop			;3632
	nop			;3633
	nop			;3634
	nop			;3635
	nop			;3636
	nop			;3637
	nop			;3638
	nop			;3639
	nop			;363a
	nop			;363b
	nop			;363c
	nop			;363d
	nop			;363e
	nop			;363f
	nop			;3640
	nop			;3641
	nop			;3642
	nop			;3643
	nop			;3644
	nop			;3645
	nop			;3646
	nop			;3647
	nop			;3648
	nop			;3649
	nop			;364a
	nop			;364b
	nop			;364c
	nop			;364d
	nop			;364e
	nop			;364f
	nop			;3650
	nop			;3651
	nop			;3652
	nop			;3653
	nop			;3654
	nop			;3655
	nop			;3656
	nop			;3657
	nop			;3658
	nop			;3659
	nop			;365a
	nop			;365b
	nop			;365c
	nop			;365d
	nop			;365e
	nop			;365f
	nop			;3660
	nop			;3661
	nop			;3662
	nop			;3663
	nop			;3664
	nop			;3665
	nop			;3666
	nop			;3667
	nop			;3668
	nop			;3669
	nop			;366a
	nop			;366b
	nop			;366c
	nop			;366d
	nop			;366e
	nop			;366f
	nop			;3670
	nop			;3671
	nop			;3672
	nop			;3673
	nop			;3674
	nop			;3675
	nop			;3676
	nop			;3677
	nop			;3678
	nop			;3679
	nop			;367a
	nop			;367b
	nop			;367c
	nop			;367d
	nop			;367e
	nop			;367f
	nop			;3680
	nop			;3681
	nop			;3682
	nop			;3683
	nop			;3684
	nop			;3685
	nop			;3686
	nop			;3687
	nop			;3688
	nop			;3689
	nop			;368a
	nop			;368b
	nop			;368c
	nop			;368d
	nop			;368e
	nop			;368f
	nop			;3690
	nop			;3691
	nop			;3692
	nop			;3693
	nop			;3694
	nop			;3695
	nop			;3696
	nop			;3697
	nop			;3698
	nop			;3699
	nop			;369a
	nop			;369b
	nop			;369c
	nop			;369d
	nop			;369e
	nop			;369f
	nop			;36a0
	nop			;36a1
	nop			;36a2
	nop			;36a3
	nop			;36a4
	nop			;36a5
	nop			;36a6
	nop			;36a7
	nop			;36a8
	nop			;36a9
	nop			;36aa
	nop			;36ab
	nop			;36ac
	nop			;36ad
	nop			;36ae
	nop			;36af
	nop			;36b0
	nop			;36b1
	nop			;36b2
	nop			;36b3
	nop			;36b4
	nop			;36b5
	nop			;36b6
	nop			;36b7
	nop			;36b8
	nop			;36b9
	nop			;36ba
	nop			;36bb
	nop			;36bc
	nop			;36bd
	nop			;36be
	nop			;36bf
	nop			;36c0
	nop			;36c1
	nop			;36c2
	nop			;36c3
	nop			;36c4
	nop			;36c5
	nop			;36c6
	nop			;36c7
	nop			;36c8
	nop			;36c9
	nop			;36ca
	nop			;36cb
	nop			;36cc
	nop			;36cd
	nop			;36ce
	nop			;36cf
	nop			;36d0
	nop			;36d1
	nop			;36d2
	nop			;36d3
	nop			;36d4
	nop			;36d5
	nop			;36d6
	nop			;36d7
	nop			;36d8
	nop			;36d9
	nop			;36da
	nop			;36db
	nop			;36dc
	nop			;36dd
	nop			;36de
	nop			;36df
	nop			;36e0
	nop			;36e1
	nop			;36e2
	nop			;36e3
	nop			;36e4
	nop			;36e5
	nop			;36e6
	nop			;36e7
	nop			;36e8
	nop			;36e9
	nop			;36ea
	nop			;36eb
	nop			;36ec
	nop			;36ed
	nop			;36ee
	nop			;36ef
	nop			;36f0
	nop			;36f1
	nop			;36f2
	nop			;36f3
	nop			;36f4
	nop			;36f5
	nop			;36f6
	nop			;36f7
	nop			;36f8
	nop			;36f9
	nop			;36fa
	nop			;36fb
	nop			;36fc
	nop			;36fd
	nop			;36fe
	nop			;36ff
	nop			;3700
	nop			;3701
	nop			;3702
	nop			;3703
	nop			;3704
	nop			;3705
	nop			;3706
	nop			;3707
	nop			;3708
	nop			;3709
	nop			;370a
	nop			;370b
	nop			;370c
	nop			;370d
	nop			;370e
	nop			;370f
	nop			;3710
	nop			;3711
	nop			;3712
	nop			;3713
	nop			;3714
	nop			;3715
	nop			;3716
	nop			;3717
	nop			;3718
	nop			;3719
	nop			;371a
	nop			;371b
	nop			;371c
	nop			;371d
	nop			;371e
	nop			;371f
	nop			;3720
	nop			;3721
	nop			;3722
	nop			;3723
	nop			;3724
	nop			;3725
	nop			;3726
	nop			;3727
	nop			;3728
	nop			;3729
	nop			;372a
	nop			;372b
	nop			;372c
	nop			;372d
	nop			;372e
	nop			;372f
	nop			;3730
	nop			;3731
	nop			;3732
	nop			;3733
	nop			;3734
	nop			;3735
	nop			;3736
	nop			;3737
	nop			;3738
	nop			;3739
	nop			;373a
	nop			;373b
	nop			;373c
	nop			;373d
	nop			;373e
	nop			;373f
	nop			;3740
	nop			;3741
	nop			;3742
	nop			;3743
	nop			;3744
	nop			;3745
	nop			;3746
	nop			;3747
	nop			;3748
	nop			;3749
	nop			;374a
	nop			;374b
	nop			;374c
	nop			;374d
	nop			;374e
	nop			;374f
	nop			;3750
	nop			;3751
	nop			;3752
	nop			;3753
	nop			;3754
	nop			;3755
	nop			;3756
	nop			;3757
	nop			;3758
	nop			;3759
	nop			;375a
	nop			;375b
	nop			;375c
	nop			;375d
	nop			;375e
	nop			;375f
	nop			;3760
	nop			;3761
	nop			;3762
	nop			;3763
	nop			;3764
	nop			;3765
	nop			;3766
	nop			;3767
	nop			;3768
	nop			;3769
	nop			;376a
	nop			;376b
	nop			;376c
	nop			;376d
	nop			;376e
	nop			;376f
	nop			;3770
	nop			;3771
	nop			;3772
	nop			;3773
	nop			;3774
	nop			;3775
	nop			;3776
	nop			;3777
	nop			;3778
	nop			;3779
	nop			;377a
	nop			;377b
	nop			;377c
	nop			;377d
	nop			;377e
	nop			;377f
	nop			;3780
	nop			;3781
Warning: Code might not be 8080 compatible!
	nop			;3782
	nop			;3783
	nop			;3784
	nop			;3785
	nop			;3786
	nop			;3787
	nop			;3788
	nop			;3789
	nop			;378a
	nop			;378b
	nop			;378c
	nop			;378d
	nop			;378e
	nop			;378f
	nop			;3790
	nop			;3791
	nop			;3792
	nop			;3793
	nop			;3794
	nop			;3795
	nop			;3796
	nop			;3797
	nop			;3798
	nop			;3799
	nop			;379a
	nop			;379b
	nop			;379c
	nop			;379d
	nop			;379e
	nop			;379f
	nop			;37a0
	nop			;37a1
	nop			;37a2
	nop			;37a3
	nop			;37a4
	nop			;37a5
	nop			;37a6
	nop			;37a7
	nop			;37a8
	nop			;37a9
	nop			;37aa
	nop			;37ab
	nop			;37ac
	nop			;37ad
	nop			;37ae
	nop			;37af
	nop			;37b0
	nop			;37b1
	nop			;37b2
	nop			;37b3
	nop			;37b4
	nop			;37b5
	nop			;37b6
	nop			;37b7
	nop			;37b8
	nop			;37b9
	nop			;37ba
	nop			;37bb
	nop			;37bc
	nop			;37bd
	nop			;37be
	nop			;37bf
	nop			;37c0
	nop			;37c1
	nop			;37c2
	nop			;37c3
	nop			;37c4
	nop			;37c5
	nop			;37c6
	nop			;37c7
	nop			;37c8
	nop			;37c9
	nop			;37ca
	nop			;37cb
	nop			;37cc
	nop			;37cd
	nop			;37ce
	nop			;37cf
	nop			;37d0
	nop			;37d1
	nop			;37d2
	nop			;37d3
	nop			;37d4
	nop			;37d5
	nop			;37d6
	nop			;37d7
	nop			;37d8
	nop			;37d9
	nop			;37da
	nop			;37db
	nop			;37dc
	nop			;37dd
	nop			;37de
	nop			;37df
	nop			;37e0
	nop			;37e1
	nop			;37e2
	nop			;37e3
	nop			;37e4
	nop			;37e5
	nop			;37e6
	nop			;37e7
	nop			;37e8
	nop			;37e9
	nop			;37ea
	nop			;37eb
	nop			;37ec
	nop			;37ed
	nop			;37ee
	nop			;37ef
	nop			;37f0
	nop			;37f1
	nop			;37f2
	nop			;37f3
	nop			;37f4
	nop			;37f5
	nop			;37f6
	nop			;37f7
	nop			;37f8
	nop			;37f9
	nop			;37fa
	nop			;37fb
	nop			;37fc
	nop			;37fd
	nop			;37fe
	nop			;37ff
