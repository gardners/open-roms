;; #LAYOUT# STD *       #TAKE
;; #LAYOUT# *   BASIC_0 #TAKE
;; #LAYOUT# *   *       #IGNORE

; 16-bit multiplication, INDEX+0/+1 = __FAC1+1/+2 * __FAC1+3/+4; __FAC1+1/+2 = INDEX+0/+1
; uses INDEX+2/+3 (for helper routine) as work area


helper_array_create_mul: ; preserves .X and .Y

	+phx_trash_a

	; We will reuse 8x8 multiplication routine used by floating point operations

	; __FAC1+1 (lo byte) * __FAC1+3 (lo byte)

	lda __FAC1+1
	sta INDEX+3
	lda __FAC1+3
	jsr mul_FAC2_FAC1_8x8                        ; this preserves .Y

	sta INDEX+0                                  ; result - lo byte
	stx INDEX+1                                  ; result - hi byte

	; __FAC1+1 (lo byte) * __FAC1+4 (hi byte)

	lda __FAC1+1
	sta INDEX+3
	lda __FAC1+4
	jsr helper_array_create_mul_8x8_add          ; multiply and add to high byte of the result

	; __FAC1+2 (hi byte) * __FAC1+3 (lo byte)

	lda __FAC1+2
	sta INDEX+3
	lda __FAC1+3
	jsr helper_array_create_mul_8x8_add          ; multiply and add to high byte of the result

	; __FAC1+2 (hi byte) * __FAC1+4 (hi byte) has to be 0,
	; otherwise the result would be out of range
	; do not calculate

	lda __FAC1+2
	beq helper_array_create_mul_success
	lda __FAC1+4
	beq helper_array_create_mul_success

	; FALLTROUGH

helper_array_create_mul_error:

	jmp do_OUT_OF_MEMORY_error

helper_array_create_mul_success:

	lda INDEX+0
	sta __FAC1+1
	lda INDEX+1
	sta __FAC1+2

	+plx_trash_a
	rts

helper_array_create_mul_8x8_add:

	jsr mul_FAC2_FAC1_8x8

	cpx #$00
	bne helper_array_create_mul_error

	clc
	adc INDEX+1 
	bcs helper_array_create_mul_error
	sta INDEX+1

	rts
