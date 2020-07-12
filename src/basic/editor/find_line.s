// #LAYOUT# STD *       #TAKE
// #LAYOUT# *   BASIC_0 #TAKE
// #LAYOUT# *   *       #IGNORE


// Find the BASIC line with number in LINNUM


find_line_from_start:

	// Get pointer to start of BASIC text
	jsr init_oldtxt

	// FALLTROUGH

find_line_from_current:

	// Check if line is not empty

	jsr peek_line_pointer_null_check
	bcc find_line_fail


	// Fetch the high byte of line number and compare
	ldy #$03

#if CONFIG_MEMORY_MODEL_60K
	ldx #<OLDTXT+0
	jsr peek_under_roms
#elif CONFIG_MEMORY_MODEL_46K || CONFIG_MEMORY_MODEL_50K
	jsr peek_under_roms_via_OLDTXT
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	cmp LINNUM+1
	beq !+
	bcs find_line_fail                           // branch if line number too high
	bne find_line_next
!:

	// Fetch the low byte of line number and compare
	dey

#if CONFIG_MEMORY_MODEL_60K
	jsr peek_under_roms
#elif CONFIG_MEMORY_MODEL_46K || CONFIG_MEMORY_MODEL_50K
	jsr peek_under_roms_via_OLDTXT
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	cmp LINNUM+0
	beq find_line_success
	bcs find_line_fail                           // branch if line number too high
	bne find_line_next

find_line_success:

	clc
	rts

find_line_next:

	// Advance to the next line

	jsr peek_line_pointer_null_check
	bcc find_line_fail                           // branch in no more lines exist

	ldy #$00

#if CONFIG_MEMORY_MODEL_60K
	ldx #<OLDTXT+0
	jsr peek_under_roms
#elif CONFIG_MEMORY_MODEL_46K || CONFIG_MEMORY_MODEL_50K
	jsr peek_under_roms_via_OLDTXT
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	pha
	iny

#if CONFIG_MEMORY_MODEL_60K
	jsr peek_under_roms
#elif CONFIG_MEMORY_MODEL_46K || CONFIG_MEMORY_MODEL_50K
	jsr peek_under_roms_via_OLDTXT
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	sta OLDTXT+1
	pla
	sta OLDTXT+0

#if HAS_OPCODES_65C02
	bra find_line_from_current
#else
	jmp find_line_from_current
#endif

find_line_fail:

	sec
	rts