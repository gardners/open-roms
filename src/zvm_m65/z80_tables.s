
;
; Z80 tables for quickly calculating instruction results
;


; z80_ftable_parity:
; 	+PUT_Z80_FTABLE_PARITY

z80_otable_displacement:
	+PUT_Z80_OTABLE_DISPLACEMENT

z80_ftable_INC:
	+PUT_Z80_FTABLE_INC

z80_ftable_DEC:
	+PUT_Z80_FTABLE_DEC

z80_ftable_AND:
	+PUT_Z80_FTABLE_AND

z80_ftable_IN_OR_XOR: ; XXX rename to include shift/rotate
	+PUT_Z80_FTABLE_IN_OR_XOR

z80_ftable_NEG:
	+PUT_Z80_FTABLE_NEG

z80_ftable_ADD_ADC:
	+PUT_Z80_FTABLE_ADD_ADC

z80_ftable_SUB_SBC:
	+PUT_Z80_FTABLE_SUB_SBC

z80_ftable_CP:
	+PUT_Z80_FTABLE_CP

z80_ftable_RRD_RLD:
	+PUT_Z80_FTABLE_RRD_RLD

;
; That horrific DAA instruction
;

z80_otable_DAA_N0C0H0:
	+PUT_Z80_OTABLE_DAA_N0C0H0

z80_otable_DAA_N0C0H1:
	+PUT_Z80_OTABLE_DAA_N0C0H1

z80_otable_DAA_N0C1H0:
	+PUT_Z80_OTABLE_DAA_N0C1H0

z80_otable_DAA_N0C1H1:
	+PUT_Z80_OTABLE_DAA_N0C1H1

z80_otable_DAA_N1C0H0:
	+PUT_Z80_OTABLE_DAA_N1C0H0

z80_otable_DAA_N1C0H1:
	+PUT_Z80_OTABLE_DAA_N1C0H1

z80_otable_DAA_N1C1H0:
	+PUT_Z80_OTABLE_DAA_N1C1H0

z80_otable_DAA_N1C1H1:
	+PUT_Z80_OTABLE_DAA_N1C1H1

z80_ftable_DAA_N0C0H0:
	+PUT_Z80_FTABLE_DAA_N0C0H0

z80_ftable_DAA_N0C0H1:
	+PUT_Z80_FTABLE_DAA_N0C0H1

z80_ftable_DAA_N0C1H0:
	+PUT_Z80_FTABLE_DAA_N0C1H0

z80_ftable_DAA_N0C1H1:
	+PUT_Z80_FTABLE_DAA_N0C1H1

z80_ftable_DAA_N1C0H0:
	+PUT_Z80_FTABLE_DAA_N1C0H0

z80_ftable_DAA_N1C0H1:
	+PUT_Z80_FTABLE_DAA_N1C0H1

z80_ftable_DAA_N1C1H0:
	+PUT_Z80_FTABLE_DAA_N1C1H0

z80_ftable_DAA_N1C1H1:
	+PUT_Z80_FTABLE_DAA_N1C1H1
