#include "Chassis.h"
#include "ConstantDefinitions.h"

ChassisMode CurrentMode = _CHASSIS_MODE_DEFAULT;

const TPM_CHANNEL Chassis_LFF = _CHASSIS_LFF_CHANNEL;
const TPM_CHANNEL Chassis_LFR = _CHASSIS_LFR_CHANNEL;
const TPM_CHANNEL Chassis_LBF = _CHASSIS_LBF_CHANNEL;
const TPM_CHANNEL Chassis_LBR = _CHASSIS_LBR_CHANNEL;
const TPM_CHANNEL Chassis_RFF = _CHASSIS_RFF_CHANNEL;
const TPM_CHANNEL Chassis_RFR = _CHASSIS_RFR_CHANNEL;
const TPM_CHANNEL Chassis_RBF = _CHASSIS_RBF_CHANNEL;
const TPM_CHANNEL Chassis_RBR = _CHASSIS_RBR_CHANNEL;

const TPM_INSTANCE Chassis_TPMs[] = 
{
	_TPM_CHOICE1,
	_TPM_CHOICE2,
	_TPM_CHOICE_NULL
};

void InitChassis(void)
{
	InitTPMs(Chassis_TPMs);
}

void SetChassisMode(ChassisMode mode)
{
	CurrentMode = mode;
}

void Drive(int16_t mappedFR_Sum, int16_t mappedFR_Diff)
{
	int16_t lf, lb, rf, rb;
	switch(CurrentMode)
  {
		case Chassis_Mcnum:
			lf = mappedFR_Sum;
			rb = lf;
			lb= mappedFR_Diff;
			rf = lb;
    break;
    case Chassis_Normal:
			lf = mappedFR_Sum;
			lb = lf;
			rf = mappedFR_Diff;
			rb = rf;
    break;
	}
	DriveChannel(lf, Chassis_LFF, Chassis_LFR);
	DriveChannel(lb, Chassis_LBF, Chassis_LBR);
	DriveChannel(rf, Chassis_RFF, Chassis_RFR);
	DriveChannel(rb, Chassis_RBF, Chassis_RBR);
}

TPM_INSTANCE GetTPMFromChannel(TPM_CHANNEL channel)
{
	switch (channel)
	{
		case TPM0CH0:
			return TPM_0;
		case TPM0CH1:
			return TPM_0;
		case TPM0CH2:
			return TPM_0;
		case TPM0CH3:
			return TPM_0;
		case TPM0CH4:
			return TPM_0;
		case TPM0CH5:
			return TPM_0;
		case TPM1CH0:
			return TPM_1;
		case TPM1CH1:
			return TPM_1;
		case TPM2CH0:
			return TPM_2;
		case TPM2CH1:
			return TPM_2;			
	}
	return TPM_0;
}

uint32_t GetFrequencyFromTPM(TPM_INSTANCE instance)
{
	switch (instance)
	{
		case TPM_0:
			return TPM_FREQUENCY_CH0;
		case TPM_1:
			return TPM_FREQUENCY_CH1;
		case TPM_2:
			return TPM_FREQUENCY_CH2;
		case TPM_NULL:
			return 0;
	}
	return 0;
}

uint8_t GetPrefactorFromTPM(TPM_INSTANCE instance)
{
	switch (instance)
	{
		case TPM_0:
			return TPM_SHIFT_DIVIDER_CH0;
		case TPM_1:
			return TPM_SHIFT_DIVIDER_CH1;
		case TPM_2:
			return TPM_SHIFT_DIVIDER_CH2;
		case TPM_NULL:
			return 0;
	}
	return 0;
}

void DriveChannel(int16_t power, TPM_CHANNEL channelF, TPM_CHANNEL channelR)
{
	TPM_INSTANCE instF = GetTPMFromChannel(channelF);
	TPM_INSTANCE instR = GetTPMFromChannel(channelR);
	uint32_t frequencyF = GetFrequencyFromTPM(instF);
	uint32_t frequencyR = GetFrequencyFromTPM(instR);
	uint8_t prefactorF = GetPrefactorFromTPM(instF);
	uint8_t prefactorR = GetPrefactorFromTPM(instR);
	uint16_t periodF = GetPeriod(frequencyF, prefactorF);
	uint16_t periodR = GetPeriod(frequencyR, prefactorR);
	uint16_t powerU = power > 0 ? (uint16_t)power : (uint16_t)(-power);
	uint16_t widthF = (uint16_t)(periodF * powerU / ChassisMaxPower);
	uint16_t widthR = (uint16_t)(periodR * powerU / ChassisMaxPower);
	if (power >= 0)
	{
		TPM_Modulate(channelF, widthF);
		TPM_Modulate(channelR, 0);
	}
	else 
	{
		TPM_Modulate(channelR, widthR);
		TPM_Modulate(channelF, 0);
	}
}
