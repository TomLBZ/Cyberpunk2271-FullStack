#include "TPM.h"
#include "ConstantDefinitions.h"

uint16_t GetPeriod(uint32_t frequency, uint8_t prefactor)
{
	return ((BUS_CLOCK_SPEED >> prefactor) / frequency);
}

void InitTPM(TPM_INSTANCE TPM) 
{
	SIM->SOPT2 &= ~SIM_SOPT2_TPMSRC_MASK;
	SIM->SOPT2 |= SIM_SOPT2_TPMSRC(1);
	switch(TPM)
	{
		case TPM_0:
			SIM->SCGC6 |= SIM_SCGC6_TPM0_MASK;
			TPM0->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
			TPM0->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(TPM_SHIFT_DIVIDER_CH0)); // prefactor
			TPM0->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
			TPM0_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM0_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM0_C2SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM0_C2SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM0_C4SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM0_C4SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM0_C5SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM0_C5SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM0->MOD = GetPeriod(TPM_FREQUENCY_CH0, TPM_SHIFT_DIVIDER_CH0);
			TPM0_C1V = 0;
			TPM0_C2V = 0;
			TPM0_C3V = 0;
			TPM0_C4V = 0;
			TPM0_C5V = 0;
			break;
		case TPM_1:
			SIM->SCGC6 |= SIM_SCGC6_TPM1_MASK;
			TPM1->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
			TPM1->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(TPM_SHIFT_DIVIDER_CH1)); // prefactor
			TPM1->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
			TPM1_C0SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM1_C0SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM1_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM1_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM1->MOD = GetPeriod(TPM_FREQUENCY_CH1, TPM_SHIFT_DIVIDER_CH1); 		
			TPM1_C0V = 0;
			TPM1_C1V = 0;
			break;
		case TPM_2:
			SIM->SCGC6 |= SIM_SCGC6_TPM2_MASK;
			TPM2->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
			TPM2->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(TPM_SHIFT_DIVIDER_CH2)); // prefactor
			TPM2->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
			TPM2_C0SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM2_C0SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM2_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
			TPM2_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
			TPM2->MOD = GetPeriod(TPM_FREQUENCY_CH2, TPM_SHIFT_DIVIDER_CH2);
			TPM2_C0V = 0;//B2
			TPM2_C1V = 0;//B3
			break;
		case TPM_NULL:
			break;
	}
}

void InitAllTPM(void)
{
	InitTPM(TPM_0);
	InitTPM(TPM_1);
	InitTPM(TPM_2);
}

void InitTPMs(const TPM_INSTANCE TPMs[])
{
	int index = 0;
	while (TPMs[index] != TPM_NULL)
	{
		InitTPM(TPMs[index]);
		index++;
	}
}

void ModifyTPM(TPM_INSTANCE TPM, uint8_t divider, uint32_t frequency)
{
	uint16_t period = GetPeriod(frequency, divider);
	switch (TPM)
	{
		case TPM_0:
			TPM0->MOD = period;
			break;
		case TPM_1:
			TPM1->MOD = period;
			break;
		case TPM_2:
			TPM2->MOD = period;
			break;
		case TPM_NULL:
			break;
	}
}
	
void TPM_Modulate(TPM_CHANNEL channel, uint16_t value)
{
	switch (channel)
	{
		case TPM0CH0:
			TPM0_C0V = value;
			break;
		case TPM0CH1:
			TPM0_C1V = value;
			break;
		case TPM0CH2:
			TPM0_C2V = value;
			break;
		case TPM0CH3:
			TPM0_C3V = value;
			break;
		case TPM0CH4:
			TPM0_C4V = value;
			break;
		case TPM0CH5:
			TPM0_C5V = value;
			break;
		case TPM1CH0:
			TPM1_C0V = value;
			break;
		case TPM1CH1:
			TPM1_C1V = value;
			break;
		case TPM2CH0:
			TPM2_C0V = value;
			break;
		case TPM2CH1:
			TPM2_C1V = value;
			break;
	}
}	

