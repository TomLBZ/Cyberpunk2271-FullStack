#pragma once
#include "MKL25Z4.h"

namespace GPIO
{
	enum GPIO_PORT
	{
		GPIO_PORT_A,
		GPIO_PORT_B,
		GPIO_PORT_C,
		GPIO_PORT_D,
		GPIO_PORT_E,
		GPIO_PORT_NULL
	};

	enum PIN_DIRECTION
	{
		PIN_INPUT,
		PIN_OUTPUT
	};

	enum PIN_VALUE
	{
		LOW,
		HIGH,
		UNKNOWN
	};

	enum ADC_OUTPUT_BITWIDTH
	{
		ADC_8BIT,
		ADC_10BIT,
		ADC_12BIT,
		ADC_16BIT
	};
		
	enum ADC_HARDWARE_AVERAGE
	{
		ADC_AVG_DISABLED,
		ADC_AVG_4SAMPLES,
		ADC_AVG_8SAMPLES,
		ADC_AVG_16SAMPLES,
		ADC_AVG_32SAMPLES
	};
		
	enum ADC_INPUT_CHANNEL
	{
		ADC_INPUT_CHANNEL_A,
		ADC_INPUT_CHANNEL_B
	};
	
	struct Pin
	{
		GPIO_PORT Port;
		uint8_t Number;
		uint8_t Func;
	};
	
	/// <summary> Enables Clock to a Selected Port </summary>
	/// <param name="port">The Port to be Clocked.</param>
	/// <returns> void </returns>
	void ClockToPort(GPIO_PORT port);
		
	/// <summary> Enables Clock to a Selected Ports </summary>
	/// <param name="ports">The Ports to be Clocked.</param>
	/// <returns> void </returns>
	void ClockToPorts(const GPIO_PORT ports[]);
	
	/// <summary> Disables Clock from a Selected Port </summary>
	/// <param name="port">The Port to remove Clock from.</param>
	/// <returns> void </returns>
	void RemoveClockFromPort(GPIO_PORT port);
	
	/// <summary> Disables Clock from a Selected Ports </summary>
	/// <param name="ports">The Ports to remove Clock from.</param>
	/// <returns> void </returns>
	void RemoveClockFromPorts(GPIO_PORT ports[]);

	/// <summary> Sets the function of a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="func">The Pin function (refer to datasheet) to be selected.</param>
	/// <returns> void </returns>
	void SelectPinFunction(GPIO_PORT port, uint8_t pin, uint8_t func);
	
	/// <summary> Sets the function of a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <returns> void </returns>
	void SelectPinFunction(Pin pin);
	
	/// <summary> Sets the function of specific pins. </summary>
	/// <param name="pins">The Pins of target.</param>
	/// <returns> void </returns>
	void SelectPinsFunctions(const Pin pins[]);
	
	/// <summary> Sets the direction of a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="direction">The Pin direction to be selected.</param>
	/// <returns> void </returns>
	void SetPinDirection(GPIO_PORT port, uint8_t pin, PIN_DIRECTION direction);
	
	/// <summary> Sets the direction of a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="direction">The Pin direction to be selected.</param>
	/// <returns> void </returns>
	void SetPinDirection(Pin pin, PIN_DIRECTION direction);
	
	/// <summary> Sets the directions of specific pins. </summary>
	/// <param name="pins">The Pins of target.</param>
	/// <param name="direction">The Pin direction to be selected for all target pins.</param>
	/// <returns> void </returns>
	void SetPinsDirections(const Pin pins[], PIN_DIRECTION direction);
	
	/// <summary> Writes LOW or HIGH to a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="value">The Pin value to be written.</param>
	/// <returns> void </returns>
	void DigitalWritePin(GPIO_PORT port, uint8_t pin, PIN_VALUE value);
	
	/// <summary> Writes LOW or HIGH to a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="value">The Pin value to be written.</param>
	/// <returns> void </returns>
	void DigitalWritePin(Pin pin, PIN_VALUE value);
	
	/// <summary> Writes LOW or HIGH to specific pins. </summary>
	/// <param name="pins">The Pins of target.</param>
	/// <param name="value">The Pin value to be written for all target pins.</param>
	/// <returns> void </returns>
	void DigitalWritePins(const Pin pins[], PIN_VALUE value);
	
	/// <summary> Reads LOW or HIGH from a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target.</param>
	/// <returns> PIN_VALUE, either LOW or HIGH. </returns>
	PIN_VALUE DigitalReadPin(GPIO_PORT port, uint8_t pin);
	
	/// <summary> Reads LOW or HIGH from a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <returns> PIN_VALUE, either LOW or HIGH. </returns>
	PIN_VALUE DigitalReadPin(Pin pin);

	/// <summary> Enables ADC. </summary>
	/// <param name="mode">The output mode of the ADC.</param>
	/// <returns> void </returns>
	void AnalogInputEnable(ADC_OUTPUT_BITWIDTH width = ADC_16BIT, ADC_HARDWARE_AVERAGE samples = ADC_AVG_DISABLED);
		
	/// <summary> Reads 0 to 4095 from a specific pin. </summary>
	/// <param name="pin">The Pin of target. It must be internally connected to the ADC.</param>
	/// <returns> uint16_t </returns>
	uint16_t AnalogReadPin(Pin pin);
	
	/// <summary> Enables analog output of a specific pin, if available. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target. It must be internally connected to the DAC, 
	/// and its function must has been set correctly. (refer to datasheet) </param>
	/// <returns> void </returns>
	void AnalogOutputEnable(GPIO_PORT port, uint8_t pin);
	
	/// <summary> Writes 0 to 4095 to a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target. It must be internally connected to the DAC.</param>
	/// <param name="value">The Pin value to be written.</param>
	/// <returns> void </returns>
	void AnalogWritePin(GPIO_PORT port, uint8_t pin, uint16_t value);
	
	/// <summary> Writes 0 to 4095 to a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="value">The Pin value to be written. It must be internally connected to the DAC.</param>
	/// <returns> void </returns>
	void AnalogWritePin(Pin pin, uint16_t value);
	
	/// <summary> Writes 0 to 4095 to specific pins. </summary>
	/// <param name="pins">The Pins of target.</param>
	/// <param name="value">The Pin value to be written for all target pins. They must be internally connected to the DAC.</param>
	/// <returns> void </returns>
	void AnalogWritePins(const Pin pins[], uint16_t value);

}
