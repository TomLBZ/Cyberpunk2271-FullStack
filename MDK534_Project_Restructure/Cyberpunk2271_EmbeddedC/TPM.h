#ifndef TPM_FLAG
#define TPM_FLAG

#include "MKL25Z4.h"

typedef enum TPM_INSTANCE_t
{
	TPM_0,
	TPM_1,
	TPM_2,
	TPM_NULL
} TPM_INSTANCE;

typedef enum TPM_CHANNEL_t
{
	TPM0CH0,
	TPM0CH1,
	TPM0CH2,
	TPM0CH3,
	TPM0CH4,
	TPM0CH5,
	TPM1CH0,
	TPM1CH1,
	TPM2CH0,
	TPM2CH1
} TPM_CHANNEL;

extern uint8_t TPM_SHIFT_DIVIDER_CH0;
extern uint32_t TPM_FREQUENCY_CH0;
extern uint8_t TPM_SHIFT_DIVIDER_CH1;
extern uint32_t TPM_FREQUENCY_CH1;
extern uint8_t TPM_SHIFT_DIVIDER_CH2;
extern uint32_t TPM_FREQUENCY_CH2;

uint16_t GetPeriod(uint32_t frequency, uint8_t prefactor);

void InitAllTPM(void);

void InitTPM(TPM_INSTANCE TPM);

void InitTPMs(const TPM_INSTANCE TPMs[]);

void ModifyTPM(TPM_INSTANCE TPM, uint8_t divider, uint32_t frequency);
	
void TPM_Modulate(TPM_CHANNEL channel, uint16_t value);

#endif
