// #LAYOUT# M65 * #TAKE
// #LAYOUT# *   * #IGNORE


	// XXX target High RAM memory map concept - TODO: update current code

	// $10000-$17FFF (32KB) - reserved for DOS
	// $18000-$18FFF  (4KB) - chargen copied to RAM, to allow character redefinition
	// $19000-$1B7FF (10KB) - reserved for virtual text screenk, 80x128
	// $1B800-$1DFFF (10KB) - reserved for a color RAM backup when switchin between text/graphics modes
	//                (4KB) - reserved for sprites
	//                (2KB) - reserved for future use
	//                (2KB) - color RAM mirror, not useable
	// $20000-$2FFFF (64KB) - ROM, the essential part
	// $30000-$4FFFF (64KB) - ROM, additions
	// $50000-$57FFF (32KB) - reserved for graphics screen
	// $58000-...           - extended BASIC variables, RAM disk, etc.