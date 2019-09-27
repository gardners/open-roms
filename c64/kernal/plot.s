
//
// Official Kernal routine, described in:
//
// - [RG64] C64 Programmer's Reference Guide   - page 290
// - [CM64] Compute's Mapping the Commodore 64 - page 215
//
// CPU registers that has to be preserved (see [RG64]): none
//

PLOT:
	bcs plot_get

plot_set:
	sty TBLX
	stx PNTR

	// XXX handle cursor blink

	// FALLTROUGH to save one byte on RTS

plot_get:
	ldy TBLX
	ldx PNTR
	rts

