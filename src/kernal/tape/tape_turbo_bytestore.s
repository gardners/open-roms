;; #LAYOUT# STD *        #TAKE
;; #LAYOUT# CRT KERNAL_1 #TAKE
;; #LAYOUT# M65 KERNAL_1 #TAKE
;; #LAYOUT# *   *        #IGNORE

;
; Tape (turbo) helper routine - storing byte uder I/O
;
; Has to preserve .A and .Y
;

; This helper routine is meant to be copied to the start of CPU stack.
; Original ROM tape loading routines uses this area to store information
; about bytes that did not read properly for the first time
; (see Mapping the C64, page 47); this mechanism is useless for turbo tape,
; but it means we can safely use this area for our purposes


!ifdef CONFIG_TAPE_TURBO {


!ifdef CONFIG_MB_M65 {
!addr __tape_turbo_bytestore_defmap  = __tape_turbo_bytestore + 10
} else ifdef ROM_LAYOUT_CRT {
!addr __tape_turbo_bytestore_defmap  = __tape_turbo_bytestore + 12
} else {
!addr __tape_turbo_bytestore_defmap  = __tape_turbo_bytestore + 7
}
!addr __tape_turbo_bytestore_size    = __tape_turbo_bytestore_source_end - tape_turbo_bytestore_source


tape_turbo_bytestore_source:

!ifdef CONFIG_MB_M65 {
	jsr map_NORMAL
} else ifdef ROM_LAYOUT_CRT {
	; 'jsr map_NORMAL' would take too much time
	ldx #%00000010
	stx $DE00
}
	; Set all memory as RAM, tape motor ON
	ldx #$00
	stx CPU_R6510

	; Store byte in memory
	sta (MEMUSS), y

	; Restore default memory layout
	ldx #$00                           ; value will be determined later, offset from start: 7/10/12 bytes
	stx CPU_R6510

!ifdef CONFIG_MB_M65 {
	; Restore default map and quit
	jmp map_KERNAL_1
} else ifdef ROM_LAYOUT_CRT {
	; Restore default map and quit; 'jsr map_KERNAL_1' would take too much time
	ldx #%00010000
	stx $DE00
	rts
} else {
	; Go back
	rts
}

__tape_turbo_bytestore_source_end:


} ; CONFIG_TAPE_TURBO
