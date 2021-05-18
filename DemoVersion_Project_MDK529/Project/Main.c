/*----------------------------------------------------------------------------
 * CMSIS-RTOS 'main' function template
 *---------------------------------------------------------------------------*/
 
#include "Main.h"
 
/*----------------------------------------------------------------------------
 * Application main thread
 *---------------------------------------------------------------------------*/

void uart_thread (void* argument) {
	int isExtendingCommand = 0;
	uint8_t rData1 = 0;
	uint8_t rData2 = 0;
	for (;;) { // must run continuously.
		osThreadFlagsWait(UART_THREAD_FLAG, osFlagsWaitAny, osWaitForever);
		if (!isExtendingCommand) {
			osMessageQueueGet(uartRXQ, &rData1, NULL, 0);
			if (rData1 - ((rData1 >> 2) << 2) == CMD_EXT) { // extend if last 2 bits == "extend"
				isExtendingCommand = !isExtendingCommand;
			} else continue; // else do not extend
		} else {
			osMessageQueueGet(uartRXQ, &rData2, NULL, 0);
			isExtendingCommand = !isExtendingCommand;
			Command cmd = ParseSegmentedCommand(rData1, rData2);
			rData1 = 0;
			rData2 = 0;
			switch (cmd.type) {
				case CMD_LED:
					osMessageQueuePut(ledQ, &cmd, NULL, 0);
					osThreadFlagsSet(led_Id, LED_THREAD_FLAG);
					break;
				case CMD_MOT:
					osMessageQueuePut(motorQ, &cmd, NULL, 0);
					osThreadFlagsSet(mot_Id, MOT_THREAD_FLAG);
					break;
				case CMD_MUS:
					osMessageQueuePut(musicQ, &cmd, NULL, 0);
					osThreadFlagsSet(mus_Id, MUS_THREAD_FLAG);
					break;
				case CMD_EXT:
					osMessageQueuePut(controlQ, &cmd, NULL, 0);
					osThreadFlagsSet(misc_Id, MISC_THREAD_FLAG);
					break; 
			}
		}
		osThreadFlagsClear(UART_THREAD_FLAG);
	}
}

void loop_worker_thread (void* argument) {
	for (;;) { // Runs with 1 ms lapses. Used to update hardware states.
		//loop task 1: refreshes onboard LED.
		Led_Control_RedOnly(led_Counter < led_R4);
		Led_Control_GreenOnly(led_Counter < led_G4);
		Led_Control_BlueOnly(led_Counter < led_B4);
		if (led_Counter == LED_CYCLES) led_Counter = 0;
		else led_Counter++;
		
		//loop task 2: refreshes front LED.
		
		//loop task 3: refreashes rear LED.
		// for example, if (condition) {/*all on*/} else {/*all off*/};
		//delay task.
		osDelay(1); // run every 1ms
	}
}

void misc_thread (void* argument) {
		for (;;) { // runs only when noticed. handles handshaking and state changes.
			osThreadFlagsWait(MISC_THREAD_FLAG, osFlagsWaitAny, osWaitForever);
			Command cmd;
			osMessageQueueGet(controlQ, &cmd, NULL, 0);
			instruct((uint16_t)cmd.instruction);
			osThreadFlagsClear(MISC_THREAD_FLAG);
		}
}

void led_thread (void* argument) {
	for (;;) { // runs only when triggered. handles led values updating process.
		osThreadFlagsWait(LED_THREAD_FLAG, osFlagsWaitAny, osWaitForever);
		Command cmd;
		osMessageQueueGet(ledQ, &cmd, NULL, 0);
		instructLED((uint16_t)cmd.instruction);
		osThreadFlagsClear(LED_THREAD_FLAG);
	}
}

void music_thread (void* argument) {
	for (;;) { // runs only when triggered. handles music commands.
		osThreadFlagsWait(MUS_THREAD_FLAG, osFlagsWaitAny, osWaitForever);
		Command cmd;
		osMessageQueueGet(musicQ, &cmd, NULL, 0);
		instructMusic((uint16_t)cmd.instruction);
		osThreadFlagsClear(MUS_THREAD_FLAG);
	}
}

void motor_thread (void* argument) {
	int inst0 = 0;
	int inst1 = 0;
	int inst2 = 0;
	int inst3 = 0;
	int b1 = 0;
	int b2 = 0;
	int b3 = 0;
	int b4 = 0;
	for (;;) { // runs only when triggered. handles motor commands.
		osThreadFlagsWait(MOT_THREAD_FLAG, osFlagsWaitAny, osWaitForever);
		Command cmd;
		osMessageQueueGet(motorQ, &cmd, NULL, 0);
		if (getBits(cmd.instruction, 7, 0) != 0) runningLED_status = MOVING;
		else runningLED_status = STOPPED;
		int mot_num = getBits(cmd.instruction, 11, 10);
		switch (mot_num) {
			case 1:
				inst1 = cmd.instruction;
				b1 = 1;
				break;
			case 2:
				inst2 = cmd.instruction;
				b2 = 1;
				break;
			case 3:
				inst3 = cmd.instruction;
				b3 = 1;
				break;
			default: // case 0
				inst0 = cmd.instruction;
				b4 = 1;
				break;
		}
		if (b1 * b2 * b3 * b4 == 1) {
			instructMotors((uint16_t)inst0);
			instructMotors((uint16_t)inst1);
			instructMotors((uint16_t)inst2);
			instructMotors((uint16_t)inst3);			
			//osDelay(MOTOR_RESPONSE_TIME_MS);
		}
		osThreadFlagsClear(MOT_THREAD_FLAG);
	}
}

void runningLED_thread (void* argument) {
	//osThreadFlagsWait(0x0001,NULL, osWaitForever);
  //movingStatus status = MOVING;
  int counter = 0;
  for (;;) {
    if (runningLED_status == CONNECTED) {
      //the car just connected
      for (int i=0;i<2;i++) {
        turnOnGreen();
        osDelay(500);
        turnOffGreen();
        osDelay(500);
      }
			runningLED_status = STOPPED;
    } 
    else if (runningLED_status == MOVING) {
      // the car is moving
      for (int i = 0;i<8;i++) {
        //GREEN 
        turnOffGreen();
        turnOnSingleLedPin(green_led_segment[i]);
        i = i%8;
        if(runningLED_status == STOPPED) {
          break;
        }
        //RED
        if(counter % 4 == 0){
					PTA->PDOR = MASK(PTA17_Pin);
          //turnOnSingleLedPin(PTA17_Pin); // red on
        }
        osDelay(125);
        if(counter % 4 == 2){
          turnOffRed();
        }
        osDelay(125);
        counter++;
      }
    }
    else if (runningLED_status == STOPPED) {
      //the car stops
      turnOnGreen();
      turnOnSingleLedPin(PTA17_Pin); // red on
      osDelay(250);
      turnOffRed();
      osDelay(250);
    }
  }
}

int main (void) {
  osKernelInitialize();                 // Initialize CMSIS-RTOS
	Init();																// Init settings and variables
	//const osThreadAttr_t norm1_attr = { .priority = osPriorityNormal1 };
	const osThreadAttr_t aboveNorm1_attr = { .priority = osPriorityAboveNormal1 };
	const osThreadAttr_t high1_attr = { .priority = osPriorityHigh1 };
	osThreadNew(loop_worker_thread, NULL, NULL); // updates hardware state in routine
	uart_Id = osThreadNew(uart_thread, NULL, &high1_attr); // handles UART commands
  misc_Id = osThreadNew(misc_thread, NULL, NULL);    // Miscellineous control thread
  led_Id = osThreadNew(led_thread, NULL, NULL);    // RGB LED control thread
  mot_Id = osThreadNew(motor_thread, NULL, &aboveNorm1_attr);    // motor control thread
	mus_Id = osThreadNew(music_thread, NULL, NULL); // plays music
	tled_Id = osThreadNew(runningLED_thread, NULL, NULL); // runs led sequence
  osKernelStart();                      // Start thread execution
  for (;;) {}
}
