// Home the cursor
// (Compute's Mapping the 64 p216)

home_cursor:

	lda #$00
	sta PNTR // x position
	sta TBLX // y position

	jmp set_pointer_to_current_screen_line
