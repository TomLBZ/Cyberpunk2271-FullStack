#include "GPIO.h"
#include "Macros.h"

void ClockToPort(GPIO_PORT port)
{
	switch (port)
	{
	case GPIO_PORT_A:
		SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
		break;
	case GPIO_PORT_B:
		SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK;
		break;
	case GPIO_PORT_C:
		SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;
		break;
	case GPIO_PORT_D:
		SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK;
		break;
	case GPIO_PORT_E:
		SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK;
		break;
	case GPIO_PORT_NULL:
		break;
	}
}

void RemoveClockFromPort(GPIO_PORT port)
{
	switch (port)
	{
	case GPIO_PORT_A:
		SIM_SCGC5 &= ~SIM_SCGC5_PORTA_MASK;
		break;
	case GPIO_PORT_B:
		SIM_SCGC5 &= ~SIM_SCGC5_PORTB_MASK;
		break;
	case GPIO_PORT_C:
		SIM_SCGC5 &= ~SIM_SCGC5_PORTC_MASK;
		break;
	case GPIO_PORT_D:
		SIM_SCGC5 &= ~SIM_SCGC5_PORTD_MASK;
		break;
	case GPIO_PORT_E:
		SIM_SCGC5 &= ~SIM_SCGC5_PORTE_MASK;
		break;
	case GPIO_PORT_NULL:
		break;
	}
}

void selectPinFunction(GPIO_PORT port, uint8_t pin, uint8_t func)
{
	switch (port)
	{
	case GPIO_PORT_A:
		PORTA->PCR[pin] &= ~PORT_PCR_MUX_MASK;
		PORTA->PCR[pin] |= PORT_PCR_MUX(func);		
		break;
	case GPIO_PORT_B:
		PORTB->PCR[pin] &= ~PORT_PCR_MUX_MASK;
		PORTB->PCR[pin] |= PORT_PCR_MUX(func);		
		break;
	case GPIO_PORT_C:
		PORTC->PCR[pin] &= ~PORT_PCR_MUX_MASK;
		PORTC->PCR[pin] |= PORT_PCR_MUX(func);		
		break;
	case GPIO_PORT_D:
		PORTD->PCR[pin] &= ~PORT_PCR_MUX_MASK;
		PORTD->PCR[pin] |= PORT_PCR_MUX(func);		
		break;
	case GPIO_PORT_E:
		PORTE->PCR[pin] &= ~PORT_PCR_MUX_MASK;
		PORTE->PCR[pin] |= PORT_PCR_MUX(func);		
		break;
	case GPIO_PORT_NULL:
		break;
	}
}

void SelectPinFunction(Pin pin)
{
	selectPinFunction(pin.Port, pin.Number, pin.Func);
}

void SelectPinsFunctions(const Pin pins[])
{
	int index = 0;
	while (index >= 0)
	{
		Pin MyPin = pins[index];
		if (MyPin.Port == GPIO_PORT_NULL) index = -1;
		else
		{
			SelectPinFunction(MyPin);
			index++;
		}
	}
}

void ClockToPorts(const GPIO_PORT ports[])
{
	int index = 0;
	while (index >= 0) 
	{
		GPIO_PORT MyPort = ports[index];
		if (MyPort == GPIO_PORT_NULL) index = -1;
		else 
		{ 
			ClockToPort(MyPort);
			index++;
		}
	}
}

void RemoveClockFromPorts(GPIO_PORT ports[])
{
	int index = 0;
	while (index >= 0) 
	{
		GPIO_PORT MyPort = ports[index];
		if (MyPort == GPIO_PORT_NULL) index = -1;
		else 
		{ 
			RemoveClockFromPort(MyPort);
			index++;
		}
	}
}

void setPinDirection(GPIO_PORT port, uint8_t pin, PIN_DIRECTION direction)
{
	switch (port)
	{
	case GPIO_PORT_A:
		if (direction == PIN_OUTPUT) PTA->PDDR |= MASK(pin);	
		else PTA->PDDR &= ~MASK(pin);
		break;
	case GPIO_PORT_B:
		if (direction == PIN_OUTPUT) PTB->PDDR |= MASK(pin);	
		else PTB->PDDR &= ~MASK(pin);
		break;
	case GPIO_PORT_C:
		if (direction == PIN_OUTPUT) PTC->PDDR |= MASK(pin);	
		else PTC->PDDR &= ~MASK(pin);
		break;
	case GPIO_PORT_D:
		if (direction == PIN_OUTPUT) PTD->PDDR |= MASK(pin);	
		else PTD->PDDR &= ~MASK(pin);
		break;
	case GPIO_PORT_E:
		if (direction == PIN_OUTPUT) PTE->PDDR |= MASK(pin);	
		else PTE->PDDR &= ~MASK(pin);
		break;
	case GPIO_PORT_NULL:
		break;
	}
}

void SetPinDirection(Pin pin, PIN_DIRECTION direction)
{
	setPinDirection(pin.Port, pin.Number, direction);
}

void SetPinsDirections(const Pin pins[], PIN_DIRECTION direction)
{
	int index = 0;
	while (index >= 0)
	{
		Pin MyPin = pins[index];
		if (MyPin.Port == GPIO_PORT_NULL) index = -1;
		else
		{
			SetPinDirection(MyPin, direction);
			index++;
		}
	}
}

void digitalWritePin(GPIO_PORT port, uint8_t pin, PIN_VALUE value)
{
	switch (port)
	{
	case GPIO_PORT_A:
		if (value == HIGH) PTA->PDOR |= MASK(pin);	
		else PTA->PDOR &= ~MASK(pin);
		break;
	case GPIO_PORT_B:
		if (value == HIGH) PTB->PDOR |= MASK(pin);	
		else PTB->PDOR &= ~MASK(pin);
		break;
	case GPIO_PORT_C:
		if (value == HIGH) PTC->PDOR |= MASK(pin);	
		else PTC->PDOR &= ~MASK(pin);
		break;
	case GPIO_PORT_D:
		if (value == HIGH) PTD->PDOR |= MASK(pin);	
		else PTD->PDOR &= ~MASK(pin);
		break;
	case GPIO_PORT_E:
		if (value == HIGH) PTE->PDOR |= MASK(pin);	
		else PTE->PDOR &= ~MASK(pin);
		break;
	case GPIO_PORT_NULL:
		break;
	}
}

void DigitalWritePin(Pin pin, PIN_VALUE value)
{
	digitalWritePin(pin.Port, pin.Number, value);
}

void DigitalWritePins(const Pin pins[], PIN_VALUE value)
{
	int index = 0;
	while (index >= 0)
	{
		Pin MyPin = pins[index];
		if (MyPin.Port == GPIO_PORT_NULL) index = -1;
		else
		{
			DigitalWritePin(MyPin, value);
			index++;
		}
	}
}

PIN_VALUE digitalReadPin(GPIO_PORT port, uint8_t pin)
{
	switch (port)
	{
	case GPIO_PORT_A:
		if (PTA->PDIR & MASK(pin)) return HIGH;
		else return LOW;
	case GPIO_PORT_B:
		if (PTB->PDIR & MASK(pin)) return HIGH;
		else return LOW;
	case GPIO_PORT_C:
		if (PTC->PDIR & MASK(pin)) return HIGH;
		else return LOW;
	case GPIO_PORT_D:
		if (PTD->PDIR & MASK(pin)) return HIGH;
		else return LOW;
	case GPIO_PORT_E:
		if (PTE->PDIR & MASK(pin)) return HIGH;
		else return LOW;
	case GPIO_PORT_NULL:
		return UNKNOWN;
	}
	return UNKNOWN;
}

PIN_VALUE DigitalReadPin(Pin pin)
{
	return digitalReadPin(pin.Port, pin.Number);
}

void AnalogInputEnable(ADC_OUTPUT_BITWIDTH width, ADC_HARDWARE_AVERAGE samples)
{
	SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK; // enable ADC
	uint8_t resolution = 0;
	switch (width)
	{
	case ADC_8BIT:
		break;
	case ADC_10BIT:
		resolution = 2;
		break;
	case ADC_12BIT:
		resolution = 1;
		break;
	case ADC_16BIT:
		resolution = 3;
		break;
	}
	ADC0_CFG1 = 0; // reset cfg 1
	ADC0_CFG1 |= ADC_CFG1_MODE(resolution) | ADC_CFG1_ADICLK(1); // clk = bus / 2, max 12 MHz
	ADC0_CFG2 = 0; // reset cfg 2
	ADC0_CFG2 |= 7; // 0b111, high speed mode, 2 extra cycles
	ADC0_SC3 = 0;  // Reset SC3
	switch(samples)
	{
	case ADC_AVG_DISABLED:
		break;
	case ADC_AVG_4SAMPLES:
		ADC0_SC3 |= 4; // 0b100
		break;
	case ADC_AVG_8SAMPLES:
		ADC0_SC3 |= 5; // 0b101
		break;
	case ADC_AVG_16SAMPLES:
		ADC0_SC3 |= 6; // 0b110
		break;
	case ADC_AVG_32SAMPLES:
		ADC0_SC3 |= 7; // 0b111
		break;
	}
	ADC0_SC1A |= ADC_SC1_ADCH(31); // disable module channel A
	ADC0_SC1B |= ADC_SC1_ADCH(31);  // disable module channel B
}

uint16_t AnalogReadPin(Pin pin)
{
	ADC_INPUT_CHANNEL channel = ADC_INPUT_CHANNEL_A;
	uint8_t channelNumber = 255;
	if (pin.Port == GPIO_PORT_E)
	{
		if (pin.Number == 20 && pin.Func == 0) channelNumber = 0;
		else if (pin.Number == 21 && pin.Func == 0) channelNumber = 4;
		else if (pin.Number == 22 && pin.Func == 0) channelNumber = 3;
		else if (pin.Number == 23 && pin.Func == 0) channelNumber = 7;
		else if (pin.Number == 29 && pin.Func == 0) 
		{
			channelNumber = 4;
			channel = ADC_INPUT_CHANNEL_B;
		}
		else if (pin.Number == 30 && pin.Func == 0) channelNumber = 23;
	}
	else if (pin.Port == GPIO_PORT_B)
	{
		if (pin.Number == 0 && pin.Func == 0) channelNumber = 8;
		else if (pin.Number == 1 && pin.Func == 0) channelNumber = 9;
		else if (pin.Number == 2 && pin.Func == 0) channelNumber = 12;
		else if (pin.Number == 3 && pin.Func == 0) channelNumber = 13;
	}
	else if (pin.Port == GPIO_PORT_C)
	{
		if (pin.Number == 0 && pin.Func == 0) channelNumber = 14;
		else if (pin.Number == 1 && pin.Func == 0) channelNumber = 15;
		else if (pin.Number == 2 && pin.Func == 0) channelNumber = 11;
	}
	else if (pin.Port == GPIO_PORT_D)
	{
		channel = ADC_INPUT_CHANNEL_B;
		if (pin.Number == 1 && pin.Func == 0) channelNumber = 5;
		else if (pin.Number == 5 && pin.Func == 0) channelNumber = 6;
		else if (pin.Number == 6 && pin.Func == 0) channelNumber = 7;
	}
	if (channel == ADC_INPUT_CHANNEL_A) 
	{
		ADC0_CFG2 &= ~MASK(4);   // mux = 0, select A
		ADC0_SC1A = ADC_SC1_ADCH(channelNumber);
		while (ADC0_SC2 & ADC_SC2_ADACT_MASK); // conversion in progress
		while (!(ADC0_SC1A & ADC_SC1_COCO_MASK)); // conversion ends for A
		return ADC0_RA;
	}
	else 
	{
		ADC0_CFG2 |= MASK(4);  // mux = 1, select B
		ADC0_SC1B = ADC_SC1_ADCH(channelNumber);
		while (ADC0_SC2 & ADC_SC2_ADACT_MASK) ; // conversion in progress
		while(!(ADC0_SC1B & ADC_SC1_COCO_MASK));  // conversion ends for B
		return ADC0_RA;
	}
}

void AnalogOutputEnable(void)
{
	SIM_SCGC6 |= SIM_SCGC6_DAC0_MASK; // enable dac
	DAC0_C0 |= DAC_C0_DACRFS_MASK; // uses vdda as ref, since adc is using vrefh. prevents collision
	//DAC0_C0 |= DAC_C0_DACTRGSEL_MASK;
	//DAC0_C0  |= DAC_C0_DACSWTRG_MASK;
	DAC0_DAT0L = 0x00;
	DAC0_DAT0H |= 0x0;
	DAC0_DAT1L = 0xFF;
	DAC0_DAT1H |= 0xF;
	DAC0_C0 = DAC_C0_DACEN_MASK;
}

void AnalogWritePin(Pin pin, uint16_t value)
{
	analogWritePin(pin.Port, pin.Number, value);
}

void analogWritePin(GPIO_PORT port, uint8_t pin, uint16_t value)
{
	if (port != GPIO_PORT_E) return;
	if (pin != 30) return;					// E30 is the only Pin connected to DAC on this board.
	DAC0_DAT0L = (uint8_t)(value & 0xFF);
	DAC0_DAT0H = (uint8_t)(value >> 8);
}
