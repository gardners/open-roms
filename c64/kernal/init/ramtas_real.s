
//
// Official Kernal routine, described in:
//
// - [RG64] C64 Programmer's Reference Guide   - page 291
// - [CM64] Compute's Mapping the Commodore 64 - page 237
//
// CPU registers that has to be preserved (see [RG64]): none
//

ramtas_real:
	// C64 Programmer's Reference guide p291:
	// Clear $0000-$0101, $0200-$03ff
	// PGS: $0000, $0001 are CPU IO ports, so shouldn't get written to
	ldy #$02
	lda #$00
!:
	sta $00,y
	iny
	bne !-

!:
	// How many ways are there to efficiently erase these two pages
	// of RAM? We would like to avoid any unnecessary byte similarity
	// with the C64 KERNAL. Thus we do $0300 before $0200, even though
	// with the longer sequence of identicale bytes we see no basis for
	// it being copyrightable.  Again, we just want to redue the attack
	// surface for any misguided suit.
	sta $0300,Y
	sta $0200,Y
	iny
	bne !-

	// Allocate cassette buffer
	// "Mapping the C64", p237
	lda #<$033C
	sta TAPE1+0
	lda #>$033C
	sta TAPE1+1

	// set screen address to $0400
	// https://www.c64-wiki.com/wiki/Screen_RAM
	// Since we are setting $D018, we also make sure we are using the 
	// ROM character set (C64 Programmer's Reference Guide p322)
	lda #$14
	sta VIC_YMCSB

	// Make sure we have the correct VIC-II memory bank for the screen to really be at $0400
	// and not $4400, $8400 or $C400
	// https://www.c64-wiki.com/wiki/VIC_bank#Selecting_VIC_banks
	lda CIA2_DDRA
	ora #$03
	sta CIA2_DDRA
	lda CIA2_PRA
	ora #$03
	sta CIA2_PRA

	// Set screen address pointer ("Compute's Mapping the 64" p238)
	// This is obvious boiler plate containing no creative input, but to avoid
	// unnecessarily similarity to the C64 KERNAL, we use X instead of A to do this,
	// and several following
	ldx #>$0400
	stx HIBASE

	//  Work out RAM size and put in MEMSTR and MEMSIZK
	// "Compute's Mapping the 64", p54
	//  http://unusedino.de/ec64/technical/project64/mapping_c64.html
	ldx #>$0800
	stx MEMSTR+1
	ldx #$00
	stx MEMSTR+0
	stx MEMSIZK+0
	// Try to modify $8000, if it fails then RAM ends at $7FFF, else $9FFF
	ldx $8000
	inx
	stx $8000
	cpx $8000
	bne ramtas_32K_RAM
	dex
	stx $8000
	ldx #$A0
	stx MEMSIZK+1
	bne !+ // always non-zero, saves one byte

ramtas_32K_RAM:	
	dex
	stx $8000 // case there is RAM under the ROM
	ldx #$80
	stx MEMSIZK+1
!:
	rts