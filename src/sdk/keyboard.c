// INCLUDES
#include "xil_types.h"
#include "xuartlite_l.h"

#include "keyboard.h"

// VARIABLES

// FUNCTION DEFINITIONS

enum KeyStatus CheckingForKeys(uint32_t baseaddr) {
	uint8_t ReceivedKey;
	if(!XUartLite_IsReceiveEmpty(baseaddr)){
		ReceivedKey = XUartLite_RecvByte(baseaddr);
	    if 		(ReceivedKey == 'w') return W;
	    else if (ReceivedKey == 's') return S;
	    else if (ReceivedKey == 'i')  return I;
		else if (ReceivedKey == 'k')  return K;
		else if (ReceivedKey == 1  ) return W_RELEASED;
		else if (ReceivedKey == 2  ) return S_RELEASED;
		else if (ReceivedKey == 3  ) return I_RELEASED;
		else if (ReceivedKey == 4  ) return K_RELEASED;
		else if (ReceivedKey == 27 ) return ESC;
		else if (ReceivedKey == 13)  return ENTER;
	    }
	return RELEASED;

}
