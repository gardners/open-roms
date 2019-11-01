
//
// Tape (turbo) part of the LOAD routine
//

// Based on routine by enthusi/Onslaught, found here:
// - https://codebase64.pokefinder.org/doku.php?id=base:turbotape_loader_source


#if CONFIG_TAPE_TURBO


load_tape_turbo:

	// XXX prepare SID, store screen color somewhere, read header

	jsr tape_ditch_verify              // only LOAD is supported, no VERIFY

	ldy #$00
	sty PRTY                           // initial checksum value

	sty CIA2_TIMAHI
	lda #$FE                           // timer threshold for TurboTape
	sta CIA2_TIMALO

	jsr tape_ask_play

	// Read file header

	ldy #$00

	jsr tape_turbo_sync                // .X gets set to 0

	stx STAL+0                         // instead of a later lda, sta
	jsr tape_turbo_get_byte            // important trick - save time/bytes by using y-indexing
	tay
!:
	jsr tape_turbo_get_byte	
	sta STAL+1,x                       // .X still 0
	inx
	cpx #$03
	bne !-

	// Read file payload

	jsr tape_turbo_sync                // .X gets set to 0

	// FALLTROUGH

load_tape_turbo_loop:

	jsr tape_turbo_get_byte

	dec CPU_R6510                      // to load below i/o area!

	sta (STAL),y	
	eor PRTY
	sta PRTY

	inc CPU_R6510

	iny
	bne !+
	inc STAL+1
!:
	cpy MEMUSS+0
	lda STAL+1
	sbc MEMUSS+1
	bcc load_tape_turbo_loop

	// Verify the checksum

	jsr tape_turbo_get_byte
	cmp PRTY
	beq_far tape_load_success
	jmp tape_load_error


tape_turbo_get_byte:

	lda #$01	
	sta ROPRTY                         // init the to-be-read byte with 1
!:
	jsr tape_turbo_get_bit	
	rol ROPRTY
	bcc !-	                           // is the initial 1 shifted into carry already?
	lda ROPRTY                         // much nicer than ldx #8: dex: loop
	
	rts	


tape_turbo_get_bit:

	lda #$10	
!:
	bit CIA1_ICR	
	beq !-                             // busy loop to detect signal
	lda CIA2_ICR
	pha	
	lda #$19	
	sta CIA2_CRA	
	pla
	
	pha                                // audio/video effects
	asl
	sta SID_SIGVOL
	beq !+
	lda #$06
!:
	sta VIC_EXTCOL
	pla

	lsr
	rts


tape_turbo_sync:

	jsr tape_turbo_get_bit 
	rol ROPRTY  
	lda ROPRTY  
	cmp #$02  
	bne tape_turbo_sync
	ldx #$09                           // 9,8,... is real turboTape
!:                                     // I sometimes used 8,7,6... to avoid it being listed in vice :)
 	jsr tape_turbo_get_byte
 	cmp #$02
 	beq !-
!: 
	cpx ROPRTY
	bne tape_turbo_sync
	jsr tape_turbo_get_byte  
	dex
	bne !-

	rts 


#endif // CONFIG_TAPE_TURBO
