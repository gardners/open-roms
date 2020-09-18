;; #LAYOUT# STD *       #TAKE
;; #LAYOUT# *   BASIC_0 #TAKE
;; #LAYOUT# *   *       #IGNORE

;
; Helper routine, used by garbage collector
;


helper_TXTPTR_down_A:                  ; .A - bytes to decrease TXTPTR, uses DSCPNT+0

	sta DSCPNT+0

	sec
	lda TXTPTR+0
	sbc DSCPNT+0 
	sta TXTPTR+0
	bcs @1
	dec TXTPTR+1
@1:
	rts
