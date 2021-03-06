;; #LAYOUT# STD *       #TAKE
;; #LAYOUT# *   BASIC_0 #TAKE
;; #LAYOUT# *   *       #IGNORE

;
; Math package - sine of FAC1 in radians
;
; See also:
; - [CM64] Computes Mapping the Commodore 64 - page 210 - XXX address does not match
; - https://www.c64-wiki.com/wiki/Floating_point_arithmetic
; - https://codebase64.org/doku.php?id=base:kernal_floating_point_mathematics
;

; XXX provide implementation

sin_FAC1:

	+STUB_IMPLEMENTATION

poly_sin:

	!byte $05                          ; series length - 1

	+PUT_CONST_POLY_SIN_1
	+PUT_CONST_POLY_SIN_2
	+PUT_CONST_POLY_SIN_3
	+PUT_CONST_POLY_SIN_4
	+PUT_CONST_POLY_SIN_5
	+PUT_CONST_POLY_SIN_6
