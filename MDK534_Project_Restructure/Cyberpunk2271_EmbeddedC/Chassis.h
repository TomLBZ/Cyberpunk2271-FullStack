#ifndef CHASSIS_FLAG
#define CHASSIS_FLAG

#include "TPM.h"
#include "GPIO.h"

typedef enum Motor_t
{
	Motor_LF,
	Motor_LB,
	Motor_RF,
	Motor_RB,
	Motor_NULL
} Motor;

typedef enum ChassisMode_t
{
	Chassis_Normal,
	Chassis_Mcnum
} ChassisMode;

extern const Pin PinLeftFrontForward;
extern const Pin PinLeftFrontBackward;
extern const Pin LeftBackForward;
extern const Pin LeftBackBackward;
extern const Pin RightFrontForward;
extern const Pin RightFrontBackward;
extern const Pin RightBackForward;
extern const Pin RightBackBackward;
extern const TPM_INSTANCE Chassis_TPMs[];

extern const TPM_CHANNEL Chassis_LFF;
extern const TPM_CHANNEL Chassis_LFR;
extern const TPM_CHANNEL Chassis_LBF;
extern const TPM_CHANNEL Chassis_LBR;
extern const TPM_CHANNEL Chassis_RFF;
extern const TPM_CHANNEL Chassis_RFR;
extern const TPM_CHANNEL Chassis_RBF;
extern const TPM_CHANNEL Chassis_RBR;

extern const uint16_t ChassisMaxPower;

extern ChassisMode CurrentMode;

void InitChassis(void);

void SetChassisMode(ChassisMode mode);
// int 16 bits, actually range is 8 bits. this is because of the negative sign.
void Drive(int16_t mappedFR_Sum, int16_t mappedFR_Diff);

void DriveChannel(int16_t power, TPM_CHANNEL channelF, TPM_CHANNEL channelR);

TPM_INSTANCE GetTPMFromChannel(TPM_CHANNEL channel);

uint32_t GetFrequencyFromTPM(TPM_INSTANCE instance);

uint8_t GetPrefactorFromTPM(TPM_INSTANCE instance);

#endif
