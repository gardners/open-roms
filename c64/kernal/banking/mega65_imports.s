// #LAYOUT# M65 KERNAL_1 #TAKE
// #LAYOUT# *   *        #IGNORE

//
// Definitions for calling Mega65 segment KERNAL_0 routines from KERNAL_1
//

#import "KERNAL_0_combined.sym"


.label STOP                            = KERNAL_0.STOP
.label udtim_keyboard                  = KERNAL_0.udtim_keyboard

.label wait_x_bars                     = KERNAL_0.wait_x_bars


#if CONFIG_TAPE_NORMAL || CONFIG_TAPE_TURBO

.label screen_on                       = KERNAL_0.screen_on
.label screen_off                      = KERNAL_0.screen_off
.label tape_motor_on                   = KERNAL_0.tape_motor_on
.label tape_motor_off                  = KERNAL_0.tape_motor_off

.label lvs_display_loading_verifying   = KERNAL_0.proxy_K1_lvs_display_loading_verifying
.label lvs_display_done                = KERNAL_0.proxy_K1_lvs_display_done
.label lvs_return_last_address         = KERNAL_0.proxy_K1_lvs_return_last_address
.label lvs_device_not_found_error      = KERNAL_0.proxy_K1_lvs_device_not_found_error
.label lvs_load_verify_error           = KERNAL_0.proxy_K1_lvs_load_verify_error

.label lvs_check_EAL                   = KERNAL_0.lvs_check_EAL
.label lvs_STAL_to_MEMUSS              = KERNAL_0.lvs_STAL_to_MEMUSS

.label kernalerror_ROUTINE_TERMINATED  = KERNAL_0.proxy_K1_kernalerror_ROUTINE_TERMINATED

.label print_kernal_message            = KERNAL_0.proxy_K1_print_kernal_message
.label print_return                    = KERNAL_0.proxy_K1_print_return

.label __MSG_KERNAL_PRESS_PLAY         = KERNAL_0.__MSG_KERNAL_PRESS_PLAY
.label __MSG_KERNAL_FOUND              = KERNAL_0.__MSG_KERNAL_FOUND

#endif


#if CONFIG_TAPE_NORMAL

.label tape_normal_byte_store          = KERNAL_0.tape_normal_byte_store

#endif


#if CONFIG_TAPE_TURBO

.label tape_turbo_byte_store           = KERNAL_0.tape_turbo_byte_store

#endif