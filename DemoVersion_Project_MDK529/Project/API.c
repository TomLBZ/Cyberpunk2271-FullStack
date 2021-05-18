#include "Environment.h"
#include "API.h"
#include "Infrastructure.h"

// Musical
void playTone(int f, float p, int t, int s) {
	unsigned long current_tick = _dac_tick_;
	if ((float)f * p - (float)0 <= FLOAT_PRECISION_UNIT) {
		ToneStop();
		//osDelay(t);
		StupidDelay(t*1000);
		//while (_dac_tick_ - current_tick < (unsigned long)t);
		return;
	}
	ToneStart(f, p);
	//osDelay(t);
	StupidDelay(t*1000);
	//while (_dac_tick_ - current_tick < (unsigned long)t);
	if (s == 0) {
		// in this case do not force stop. For precise timings of musical notes.
	} else {
		// in this case (default case) force stop.
		ToneStop();
		//osDelay(t);
		StupidDelay(t*1000);
		//while (_dac_tick_ - current_tick - (unsigned long)t < FORCE_STOP_TICKS);
	}
}

int getNoteFrequency(music_mode mode, Note note) {
	int nIndex = note.index;
	if (nIndex == 0) return 0;
	int offset = note.offset;
	int raise = note.raise;
	int f_base = (int)mode;
	int f = 0;
	if (offset >= 0) {
		f = f_base * (1 << offset);
	} else {
		f = f_base / (1 << (-offset));
	}
	int index = 0;
	switch(nIndex) {
		case 1: 
			index = raise;
			break;
		case 2: 
			index = raise + 2;
			break;
		case 3: 
			index = raise + 4;
			break;
		case 4: 
			index = raise + 5;
			break;
		case 5: 
			index = raise + 7;
			break;
		case 6: 
			index = raise + 9;
			break;
		case 7: 
			index = raise + 11;
			break;
		default:
			index = -1;
			break;
	}
	float multiplier = 1;
	float r = HALF_NOTE_RATIOF;
	if (index == -1) return 0;
	else if (index < 0) {
		while (index < 0) {
			multiplier /= r;
			index++;
		}
	}
	else {
		while (index > 0) {
			multiplier *= r;
			index--;
		}
	}
	return (int)((float)f * multiplier);
}

void playNote(music_mode mode, Note note, float power) {
	int f = getNoteFrequency(mode, note);
	playTone(f, 0.5, note.duration_ms, 1);
}

void playMusic(Music music, float power) {
	int npm = music.npm;
	char * script = music.script;
	char tmp[4]; // NECESSARY EVIL QAQ m(_ _)m
	music_mode mode = music.mode;
	int noteLength = 60000 / npm;
	int index = 0;
	int i = 0;
	while(script[i] != '\0') {
		if(script[i] == ' ' || script[i] == '\0') {
			index++;
			i++;
		} else {
			int tmplen = 0;
			if (script[i + 1] == ' ' || script[i + 1] == '\0') tmplen = 1;
			else if (script[i + 2] == ' ' || script[i + 2] == '\0') tmplen = 2;
			else if (script[i + 3] == ' ' || script[i + 3] == '\0') tmplen = 3;	
			for (int j = 0; j < tmplen; j++) tmp[j] = script[i + j];
			tmp[tmplen] = '\0';
			Note n = composeNote(tmp, noteLength);
			playNote(mode, n, power);
			i += tmplen;
		}
	}
}

int getNoteCount(char * script) {
	if (script[0] == '\0') return 0;
	int count = 1;
	int index = 1;
	while(script[index] != '\0') {
		if (script[index] == ' ') count++;
		index++;
	}
	return count;
}

// Command Responses
void handleCommand(Command command) {
	switch (command.type) {
		case CMD_LED:
			instructLED((uint16_t)command.instruction);
			break;
		case CMD_MUS:
			instructMusic((uint16_t)command.instruction);
			break;
		case CMD_MOT:
			instructMotors((uint16_t)command.instruction);
			break;
		case CMD_EXT:
			instruct((uint16_t)command.instruction);
			break;
	}
}

void instructLED(uint16_t led_instruction) { // 12sf: 4-4-4
	uint16_t trunk = led_instruction >> 4; // truncates last 4 bits
	led_B4 = (uint8_t)(led_instruction - (trunk << 4)); // gets last 4 bits as blue value
	led_R4 = (uint8_t)(trunk >> 4); // truncates last 4 bits, gets first 4 bits as red value
	led_G4 = (uint8_t)(trunk - (led_R4 << 4)); // gets last 4 bits as green value
}

void instructMusic(uint16_t music_instruction) {
	float pow = (float)(music_instruction >> 2) / (float)1024; // 10 bits
	int name = music_instruction - ((music_instruction >> 2) << 2);
	if (name == 1) {
		// play something, started
	} else if (name == 2) {
		playMusic(badApple, pow); // running
	} else if (name == 3) {
		// play something, completed
	} else { // = 0
		// play something, idle
	}
}

void instructMotors(uint16_t motor_instruction) { //inst:mmn0dd dddddd
	int isN = getBits(motor_instruction, 9, 9);
	int magnitude = getBits(motor_instruction, 7, 0);
	if (magnitude > MAX_POWER) magnitude = MAX_POWER;
	switch (motor_instruction >> 10) {
		case 1: // LB
			DriveMotor(LB, -isN, magnitude);
			break;
		case 2: // RF
			DriveMotor(RF, -isN, magnitude);
			break;
		case 3: // RB
			DriveMotor(RB, -isN, magnitude);
			break;
		default: // case 0, LF
			DriveMotor(LF, -isN, magnitude);
			break;
	}
}

void instruct(uint16_t instruction) {
	if ((instruction >> 6) == (uint8_t)(HANDSHAKE_R >> 2) && getBits(instruction, 5, 0) == 0) {
		UART2_ReenableTX();
		uint8_t t_data = HANDSHAKE_T;
		osMessageQueuePut(uartTXQ, &t_data, NULL, 0);
		runningLED_status = CONNECTED;
	} else {
		uint8_t last3bits = (uint8_t)(instruction - ((instruction >> 3) << 3));
		if (last3bits > 0 && (instruction >> 3) == 0) {
			int magnitude = MAX_POWER;
			DriveMotor(LF, 0, magnitude);
			DriveMotor(RF, 0, magnitude);
			DriveMotor(LB, 0, magnitude);
			DriveMotor(RB, 0, magnitude);
			osDelay(2000);
			if (last3bits == 1) {
				DriveMotor(LF, 1, magnitude);
				DriveMotor(RF, 0, magnitude);
				DriveMotor(LB, 1, magnitude);
				DriveMotor(RB, 0, magnitude);
			} else if (last3bits == 2) {
				DriveMotor(LF, 0, magnitude);
				DriveMotor(RF, 1, magnitude);
				DriveMotor(LB, 0, magnitude);
				DriveMotor(RB, 1, magnitude);
			} else if (last3bits == 3) {
				DriveMotor(LF, 0, magnitude / 2);
				DriveMotor(RF, 0, magnitude);
				DriveMotor(LB, 0, magnitude / 2);
				DriveMotor(RB, 0, magnitude);
			} else if (last3bits == 4) {
				DriveMotor(LF, 0, magnitude);
				DriveMotor(RF, 0, magnitude / 2);
				DriveMotor(LB, 0, magnitude);
				DriveMotor(RB, 0, magnitude / 2);
			}
			osDelay(1000);
			DriveMotor(LF, 0, magnitude);
			DriveMotor(RF, 0, magnitude);
			DriveMotor(LB, 0, magnitude);
			DriveMotor(RB, 0, magnitude);
			osDelay(2000);
			DriveMotor(LF, 0, 0);
			DriveMotor(RF, 0, 0);
			DriveMotor(LB, 0, 0);
			DriveMotor(RB, 0, 0);
		}
	}
}

int getBits (int input, int highbit, int lowbit) {
	int output = 0;
	for (int i = lowbit; i <= highbit; i++) {
		output += (input & MASK(i)) >> lowbit;
	}
	return output;
}
