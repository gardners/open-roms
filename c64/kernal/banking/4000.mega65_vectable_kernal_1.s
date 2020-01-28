// #LAYOUT# M65 KERNAL_0 #TAKE-FLOAT
// #LAYOUT# M65 KERNAL_1 #TAKE
// #LAYOUT# *   *        #IGNORE

//
// Definitions for communication with Mega65 segment KERNAL_1 from KERNAL_0
//


#if SEGMENT_KERNAL_0

	// Label definitions

	.label VK1__RAMTAS                 = $4000 + 2 * 0
	.label VK1__load_tape_normal       = $4000 + 2 * 1
	.label VK1__load_tape_turbo        = $4000 + 2 * 2
	.label VK1__load_tape_auto         = $4000 + 2 * 3

#else

	// Vector table (OpenROMs private!)

	.word RAMTAS

#if CONFIG_TAPE_NORMAL && !CONFIG_TAPE_AUTODETECT
	.word load_tape_normal
#else
	.word $0000
#endif

#if CONFIG_TAPE_TURBO && !CONFIG_TAPE_AUTODETECT
	.word load_tape_turbo
#else
	.word $0000
#endif

#if CONFIG_TAPE_AUTODETECT
	.word load_tape_auto
#else
	.word $0000
#endif


#endif