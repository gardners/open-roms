// #LAYOUT# STD *       #TAKE
// #LAYOUT# *   BASIC_0 #TAKE
// #LAYOUT# *   *       #IGNORE


#if CONFIG_TAPE_WEDGE


// .X has to contain size of the buffer

wedge_tape:

	lda #$FF
	sta CURLIN+1                       // in case of error do not print line number

	cpx #$02
	bne_16 do_SYNTAX_error

	lda BUF+1

	cmp #$4C                           // 'L'
	beq wedge_arrow_L

#if CONFIG_TAPE_HEAD_ALIGN

	cmp #$48                           // 'H'
	beq wedge_arrow_H

#endif

	jmp do_SYNTAX_error

wedge_arrow_L:

	// Execute 'arrow + L'
	
	lda #$00
	sta FNLEN                          // default file name is empty
	sta VERCKB                         // operation is LOAD, not VERIFY

	ldy #$01
#if CONFIG_TAPE_TURBO
	ldx #$07                           // turbo tape device
#else
	ldx #$01                           // normal tape device
#endif

	jsr JSETFLS

	// Perform loading

	jmp cmd_load_got_params

#if CONFIG_TAPE_HEAD_ALIGN

wedge_arrow_H:

	jsr tape_head_align

	jsr print_return
	jmp do_BREAK_error

#endif


#endif // CONFIG_TAPE_WEDGE