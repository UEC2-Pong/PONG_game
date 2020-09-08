// INCLUDES
#include "xil_types.h"
#include "xuartlite_l.h"

#include "keyboard.h"

// VARIABLES
uint8_t ReceivedKey;

// FUNCTION DEFINITIONS

enum KeyStatus CheckingForKeys(uint32_t baseaddr) {
	if(!XUartLite_IsReceiveEmpty(baseaddr)){
		ReceivedKey = XUartLite_RecvByte(baseaddr);
		if 		(ReceivedKey == 'w') return W;
		else if (ReceivedKey == 's') return S;
		else if (ReceivedKey == 'i')  return I;
		else if (ReceivedKey == 'k')  return K;
		else if (ReceivedKey == 13)  return ENTER;
		else if (ReceivedKey == 27)  return ESC;
		else return RELEASED;
	}
	else{
		return RELEASED;
	}
}
