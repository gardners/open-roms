;; #LAYOUT# STD *       #TAKE
;; #LAYOUT# CRT BASIC_1 #TAKE
;; #LAYOUT# M65 BASIC_1 #TAKE
;; #LAYOUT# *   BASIC_0 #TAKE
;; #LAYOUT# *   *       #IGNORE

;
; Prepare interpreter to execute commands in direct mode
;

prepare_direct_execution:

!ifdef SEGMENT_M65_BASIC_0 {

	jsr map_BASIC_1
	jsr (VB1__prepare_direct_execution)
	jmp map_NORMAL

} else ifdef SEGMENT_CRT_BASIC_0 {

	jsr map_BASIC_1
	jsr JB1__prepare_direct_execution
	jmp map_NORMAL

} else {

	; Setup pointer to the statement
	lda #<BUF
	sta TXTPTR+0
	lda #>BUF
	sta TXTPTR+1

	; There is no stored line, so zero that pointer out
	lda #$00
	sta OLDTXT+0
	sta OLDTXT+1

	; Put invalid line number in current line number value,
	; so that we know we are in direct mode (Computes Mapping the 64 p19)
	lda #$FF
	sta CURLIN+1

	rts

} ; ROM layout
