#ifndef GPIO_FLAG
#define GPIO_FLAG

#include "MKL25Z4.h"

typedef enum GPIO_PORT_t
	{
		GPIO_PORT_A,
		GPIO_PORT_B,
		GPIO_PORT_C,
		GPIO_PORT_D,
		GPIO_PORT_E,
		GPIO_PORT_NULL
	} GPIO_PORT;

typedef enum PIN_DIRECTION_t
	{
		PIN_INPUT,
		PIN_OUTPUT
	} PIN_DIRECTION;

typedef enum PIN_VALUE_t
	{
		LOW,
		HIGH,
		UNKNOWN
	} PIN_VALUE;

typedef enum ADC_OUTPUT_BITWIDTH_t
	{
		ADC_8BIT,
		ADC_10BIT,
		ADC_12BIT,
		ADC_16BIT
	} ADC_OUTPUT_BITWIDTH;
		
typedef enum ADC_HARDWARE_AVERAGE_t
	{
		ADC_AVG_DISABLED,
		ADC_AVG_4SAMPLES,
		ADC_AVG_8SAMPLES,
		ADC_AVG_16SAMPLES,
		ADC_AVG_32SAMPLES
	} ADC_HARDWARE_AVERAGE;
		
typedef enum ADC_INPUT_CHANNEL_t
	{
		ADC_INPUT_CHANNEL_A,
		ADC_INPUT_CHANNEL_B
	} ADC_INPUT_CHANNEL;
	
typedef struct Pin_t
	{
		GPIO_PORT Port;
		uint8_t Number;
		uint8_t Func;
	} Pin;
	
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
	void selectPinFunction(GPIO_PORT port, uint8_t pin, uint8_t func);
	
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
	void setPinDirection(GPIO_PORT port, uint8_t pin, PIN_DIRECTION direction);
	
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
	void digitalWritePin(GPIO_PORT port, uint8_t pin, PIN_VALUE value);
	
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
	PIN_VALUE digitalReadPin(GPIO_PORT port, uint8_t pin);
	
	/// <summary> Reads LOW or HIGH from a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <returns> PIN_VALUE, either LOW or HIGH. </returns>
	PIN_VALUE DigitalReadPin(Pin pin);

	/// <summary> Enables ADC. </summary>
	/// <param name="mode">The output mode of the ADC.</param>
	/// <returns> void </returns>
	void AnalogInputEnable(ADC_OUTPUT_BITWIDTH width, ADC_HARDWARE_AVERAGE samples);
		
	/// <summary> Reads 0 to 4095 from a specific pin. </summary>
	/// <param name="pin">The Pin of target. It must be internally connected to the ADC.</param>
	/// <returns> uint16_t </returns>
	uint16_t AnalogReadPin(Pin pin);
	
	/// <summary> Enables analog output. </summary>
	/// <returns> void </returns>
	void AnalogOutputEnable(void);
	
	/// <summary> Writes 0 to 4095 to a specific pin. </summary>
	/// <param name="port">The Port where the pin is located.</param>
	/// <param name="pin">The Pin of target. It must be internally connected to the DAC.</param>
	/// <param name="value">The Pin value to be written.</param>
	/// <returns> void </returns>
	void analogWritePin(GPIO_PORT port, uint8_t pin, uint16_t value);
	
	/// <summary> Writes 0 to 4095 to a specific pin. </summary>
	/// <param name="pin">The Pin of target.</param>
	/// <param name="value">The Pin value to be written. It must be internally connected to the DAC.</param>
	/// <returns> void </returns>
	void AnalogWritePin(Pin pin, uint16_t value);
		
#endif
