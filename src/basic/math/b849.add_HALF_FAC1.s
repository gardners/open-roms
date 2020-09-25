;; #LAYOUT# STD *       #TAKE
;; #LAYOUT# X16 BASIC_0 #TAKE-OFFSET 2000
;; #LAYOUT# *   BASIC_0 #TAKE
;; #LAYOUT# *   *       #IGNORE

;
; Math package - add 0.5 to FAC1
;
; See also:
; - [CM64] Computes Mapping the Commodore 64 - page 112

add_HALF_FAC1:

	ldy #>const_HALF
	lda #<const_HALF

	jmp add_MEM_FAC1
