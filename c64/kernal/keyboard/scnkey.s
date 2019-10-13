
//
// Official Kernal routine, described in:
//
// - [RG64] C64 Programmer's Reference Guide   - page 295
// - [CM64] Compute's Mapping the Commodore 64 - page 220
//
// CPU registers that has to be preserved (see [RG64]): none
//

// Variables used:
// - KEYTAB  - keyboard matrix pointer
// - DELAY   - counter for first delay between key repeats
// - KOUNT   - counter for next delays between key repeats
// - SHFLAG  - SHIFT / CTRL / VENDOR keypress status
// - NDX     - number of characters in keyboard buffer
// - XMAX    - maximum size of keyboard buffer
// - LSTX    - matrix coordinate of last pressed key
// - LSTSHF  - previous status of SHFLAG
// - MODE    - flag, whether charset toggle (SHIFT+VENDOR) is allowed
// - RPTFLG  - whether key repeat is allowed


// XXX add Commodore 128 keyboard support
// XXX add Commodore 65 keybopard support
// XXX add support for using joystick to move sursor keys
// XXX explicitly prevent joystick port 1 interference

#if !CONFIG_SCNKEY_TWW_CTR

// Routine takes some ideas from TWW/CTR proposal, see here:
// - http://codebase64.org/doku.php?id=base:scanning_the_keyboard_the_correct_and_non_kernal_way


SCNKEY:

	// Prepare for SHFLAG update

	lda SHFLAG
	sta LSTSHF
	lda #$00
	sta SHFLAG

	// XXX retrieve ALT and NO_SCRL status for C128/C65 keyboards

	// Check for any activity

	lda #$00
	sta CIA1_PRA  // connect all the rows
	ldx #$FF
	cpx CIA1_PRB
	beq scnkey_no_keys

	// Retrieve SHIFT / VENDOR / CTRL status
	// Use .X to detect 2 or more keys pressed (should be $FF now)
	ldy #$03
scnkey_bucky_loop:
	lda kb_matrix_bucky_confmask, y
	sta CIA1_PRA
	lda kb_matrix_bucky_testmask, y
	and CIA1_PRB
	bne !+                          // not pressed
	lda SHFLAG
	ora kb_matrix_bucky_shflag, y
	sta SHFLAG
!:
	dey
	bpl scnkey_bucky_loop

	// Set KEYTAB vector

	jsr via_keylog // XXX for some CPUs we have indirect jsr

	// Check if we have free space in the keyboard buffer

	lda NDX
	cmp XMAX
	bcs scnkey_no_keys             // no space in keyboard buffer - do not waste time

	// XXX check for joystick activity

	// Scan the keyboard matrix

	ldx #$07 // XXX adapt for C128 and C65 keyboards
	ldy #$FF                       // offset in key matrix table, $FF for not found yet
scnkey_matrix_loop:
	lda kb_matrix_row_keys, x
	sta CIA1_PRA
	lda kb_matrix_bucky_filter, x  // filter out bucky keys
	ora CIA1_PRB
	cmp #$FF
	beq scnkey_matrix_loop_next    // skip if no key pressed from this row
	cpy #$FF
	bne scnkey_no_keys             // clash, more than one key pressed
	// We have at least one key pressed in this row, we need to find which one exactly
	ldy #$07
scnkey_matrix_loop_inner:
	cmp kb_matrix_row_keys, y
	bne !+                         // not this particular key
	tya                            // now .A contains key offset within a row
	clc
	adc kb_matrix_row_offsets, x   // now .A contains key offset from the matrix start
	tay
	jmp scnkey_matrix_loop_next
!:
	dey
	bpl scnkey_matrix_loop_inner
	bmi scnkey_no_keys            // branch always, multiple keys must have been pressed
scnkey_matrix_loop_next:
	dex
	bpl scnkey_matrix_loop

	// Scanning complete
	cpy #$FF
	bne scnkey_got_key

	// FALLTROUGH

scnkey_no_keys:

	// Mark no key press

	lda #$40 // XXX adapt value for C128 and C65 keyboards
	sta LSTX

	rts

scnkey_got_key: // .Y should now contain the key offset in matrix pointed by KEYTAB

	cpy LSTX
	beq scnkey_handle_repeat       // branch if the same key as previously
	sty LSTX

	// Reset key repeat counters - see [CM64] page 58

	// Note: according to [CM64] it should be $10 for initializing DELAY, $06 for
	// initializing KOUNT for the first time and $04 for subsequent ones - but replicating
	// this would make our implementation longer, probably without improving the compatibility.
	//
	// Besides - since I am the one who writes the code, I will make the values exactly how I like them :D

	// XXX consider making it configurable, also make configurable RPTFLG

	lda #$16
	sta DELAY

	// FALLTROUGH

scnkey_output_key:

	// Reinitialize secondary counter

	lda #$03
	sta KOUNT

	// Output PETSCII code to the keyboard buffer
	lda (KEYTAB), y
	beq scnkey_no_keys             // branch if we have no PETSCII code for this key
	ldy NDX
	sta KEYD, y
	inc NDX

	// FALLTROUGH

scnkey_done:

	rts

scnkey_handle_repeat:

	// Check whether we should repeat keys

	// XXX some keys should be repeat always!

	lda RPTFLG
	bpl scnkey_done                // branch if we should do no repeat

	// First countdown (for the first repeat)

	lda DELAY
	beq !+
	dec DELAY

	rts
!:
	// Second countdown (for both first and subsequential repeats)

	lda KOUNT
	beq scnkey_output_key          // if second counter is also 0, we can repeat the key
	dec KOUNT

	rts

via_keylog:
	jmp (KEYLOG)


#endif // no CONFIG_SCNKEY_TWW_CTR