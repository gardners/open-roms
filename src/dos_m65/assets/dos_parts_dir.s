
;
; Data used to generate directory in CBM BASIC format
;

dir_hdr:                     ; 32 bytes - header

	!byte $01, $08           ; program location
	!byte $01, $01           ; link to the next line - dummy, will be regenerated by BASIC
	!byte $00, $00           ; line number 0
	!byte $12, $22           ; reverse mode, quote
	!pet "                "  ; space for disk/directory name
    !byte $22, $20           ; quote, space
	!pet "00 2a"             ; default ID, disk format
	!byte $00                ; end of the line

dir_hdr_sd:                  ; 32 bytes - header

	!byte $01, $08           ; program location
	!byte $01, $01           ; link to the next line - dummy, will be regenerated by BASIC
	!byte $00, $00           ; line number 0
	!byte $12, $22           ; reverse mode, quote
	!pet "sd card         "  ; space for disk/directory name
    !byte $22, $20           ; quote, space
	!pet "fat32"             ; filesystem
	!byte $00                ; end of the line

dir_end:                     ; 19 bytes

	!byte $01, $01           ; link to the next line - dummy, will be regenerated by BASIC
	!byte $00, $00           ; line number 0
	!pet "blocks free."
	!byte $00, $00, $00      ; end of the line, end of program marker

; File types / extensions

dir_ext_01: !pet "seq"       ; SEQ
dir_ext_02: !pet "prg"       ; PRG
dir_ext_03: !pet "usr"       ; USR
dir_ext_04: !pet "rel"       ; REL
dir_ext_05: !pet "dir"       ; directory
dir_ext_06: !pet "d67"       ; CBM 2040 (DOS 1)               - disk image
dir_ext_07: !pet "d64"       ; CBM 1541 / 2031 / 3040 / 4040  - disk image
dir_ext_08: !pet "d71"       ; CBM 1571                       - disk image
dir_ext_09: !pet "d81"       ; CBM 1581                       - disk image
dir_ext_0A: !pet "d80"       ; CBM 8050                       - disk image
dir_ext_0B: !pet "d81"       ; CBM 8250 / 1001                - disk image
dir_ext_0C: !pet "d90"       ; CBM D9060 / D9090              - hard disk image
dir_ext_0D: !pet "d1m"       ; CMD FD 2000 / 4000             - disk image (DD)
dir_ext_0E: !pet "d2m"       ; CMD FD 2000 / 4000             - disk image (HD)
dir_ext_0F: !pet "d4m"       ; CMD FD 4000                    - disk image (ED)
dir_ext_10: !pet "dhd"       ; CMD HD                         - hard disk image
