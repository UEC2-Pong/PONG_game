// INCLUDES
#include "xparameters.h"
#include "sleep.h"
#include "xil_types.h"
#include "xgpio.h"

#include "credits.h"
#include "keyboard.h"
#include "game.h"

// VARIABLES
XGpio gpio;
extern uint32_t gpio_output;

// FUNCTION DEFINITIONS

void Credits(void){
	enum KeyStatus eKeyStatus;

	while( eScreenMode == CREDITS){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode  	 = MENU;
		}
		else {}
	SendCredits();
	usleep(2500);
	}
}

void SendCredits(void){
	gpio_output = eScreenMode<<30;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}
