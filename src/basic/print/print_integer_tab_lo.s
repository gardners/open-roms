// #LAYOUT# STD *       #TAKE
// #LAYOUT# *   BASIC_0 #TAKE
// #LAYOUT# *   *       #IGNORE

//
// Helper power of 10s table (low buytes) for 'print_integer'
//

print_integer_tab_lo:

	.byte <1
	.byte <10
	.byte <100
	.byte <1000
	.byte <10000
