#include "Data.h"

Note composeNote(char * token, int noteLength) {
	Note note;
	note.offset = 0;
	note.raise = 0;
	note.duration_ms = noteLength;
	int i = 0;
	while (token[i] != '\0') {
		int tmp = (int)(token[i] - '0');
		switch(token[i]) {
			case 'u':
				note.offset = 1;
				break;
			case 'U':
				note.offset = 2;
				break;
			case 'd':
				note.offset = -1;
				break;
			case 'D':
				note.offset = -2;
				break;
			case 'b':
				note.raise = -1;
				break;
			case 's':
				note.raise = 1;
				break;
			default:
				if (tmp >= 0 && tmp <= 7 ) {
					note.index = tmp;
				}
				break;
		}	
		i++;
	}
	return note;
}

Command ParseCommand(uint16_t raw) {
	uint16_t body = raw >> 2; // removes last 2 bits
	Command cmd = { .type = CMD_EXT, .instruction = body};
	switch (raw - (body << 2)) { // last 2 bits are type indicating bits
		case 1:
			cmd.type = CMD_LED;
			break;
		case 2:
			cmd.type = CMD_MUS;
			break;
		case 3:
			cmd.type = CMD_MOT;
			break;
		default:
			break;
	}
	return cmd;
}

Command ParseSegmentedCommand(uint8_t raw1, uint8_t raw2) {
	uint16_t body = (uint16_t)((raw1 >> 2) << 6) + (uint16_t)(raw2 >> 2);
	Command cmd = { .type = CMD_EXT, .instruction = body};
	switch (raw2 - ((raw2 >> 2) << 2)) { // last 2 bits are type indicating bits
		case 1:
			cmd.type = CMD_LED;
			break;
		case 2:
			cmd.type = CMD_MUS;
			break;
		case 3:
			cmd.type = CMD_MOT;
			break;
		default:
			break;
	}
	return cmd;
}

Command CreateLEDCommand(uint8_t r_4bit, uint8_t g_4bit, uint8_t b_4bit) {
	uint16_t inst = (uint16_t)((r_4bit << 4) << 4) + (uint16_t)(g_4bit << 4) + (uint16_t)((b_4bit << 4) >> 4);
	Command command = {.type = CMD_LED, .instruction = inst };
	return command;
}

uint16_t CommandToInt16(Command command) {
	return (uint16_t)(command.instruction << 2) + (uint16_t)command.type;
}

