iec_release_clk:
	lda $dd00
	and #$1b
	sta $dd00
	rts
