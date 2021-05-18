#ifndef CONSTDEF_FLAG
#define CONSTDEF_FLAG
#include "system_MKL25Z4.h"

#define _ONBOARDLED_REFRESH_RESOLUTION_MS		(1) // t = 1ms
#define _ONBOARDLED_BITS										(4) // n = 4 bit color
#define _ONBOARDLED_COLOR_CHANGE_TIME_MS		(135) // multiple of t(2^n - 1), must <= 255 
#define _MUSIC_SAMPLE_FREQUENCY							(3000) // sample frequency of music
#define _MUSIC_INTERPOLATION_RATIO					(8)	// 4 interpolated points per data
#define _MUSIC_SECTION_LENGTH1							(5000) // section length of track 1
#define _MUSIC_SECTION_LENGTH2							(64)	// section length of track 2
#define _MUSIC_SECTION_LENGTH3							(2)	// section length of track 3
#define _MUSIC_TRACK1_SECTIONS							(7)	// track 1 length
#define _MUSIC_TRACK2_SECTIONS							(1)	// track 2 length
#define _MUSIC_TRACK3_SECTIONS							(1)	// track 3 length
#define CORE_CLOCK_SPEED 										(DEFAULT_SYSTEM_CLOCK)	// 48Mhz max
#define BUS_CLOCK_SPEED 										(DEFAULT_SYSTEM_CLOCK >> 1) // 24MHz max
#define _PIT_PERIOD													(BUS_CLOCK_SPEED / _MUSIC_SAMPLE_FREQUENCY / _MUSIC_INTERPOLATION_RATIO) // interpolate 4 values per datapoint
#define _TPM_SHIFT_DIVIDER_DEFAULT					(0)	// prescalar = 2 ^ ~ = 1
#define _TPM_FREQUENCY_DEFAULT							(0x2EE0)	// 12k Hz
#define _TPM_CHOICE1												(TPM_0)
#define _TPM_CHOICE2												(TPM_2)
#define _TPM_CHOICE3												(TPM_1)
#define _TPM_CHOICE_NULL										(TPM_NULL)
#define _CHASSIS_MODE_DEFAULT								(Chassis_Normal)
#define _CHASSIS_LFF_CHANNEL								(TPM0CH0)
#define _CHASSIS_LFR_CHANNEL								(TPM0CH2)
#define _CHASSIS_LBF_CHANNEL								(TPM0CH3)
#define _CHASSIS_LBR_CHANNEL								(TPM0CH1)
#define _CHASSIS_RFF_CHANNEL								(TPM0CH4)
#define _CHASSIS_RFR_CHANNEL								(TPM0CH5)
#define _CHASSIS_RBF_CHANNEL								(TPM2CH1)
#define _CHASSIS_RBR_CHANNEL								(TPM2CH0)
#define _CHASSIS_MAX_POWER									(255)

#endif
