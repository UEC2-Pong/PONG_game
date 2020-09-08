// INCLUDES
#include "xil_types.h"
#include "xparameters.h"
#include "xgpio.h"
#include "sleep.h"

#include "options.h"
#include "keyboard.h"
#include "game.h"

// VARIABLES && DEFINES
XGpio gpio;
extern uint32_t gpio_output;

// FUNCTION DEFINITIONS

void Options(uint8_t *GameSpeed){
	enum KeyStatus eKeyStatus;
	uint8_t aSpeedValue[3] = {FAST, MEDIUM, SLOW};
	uint8_t icon_highlighter = 0x01;
	static uint8_t GameSpeedCode = 1;

	while(eScreenMode == OPTIONS){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == W) {
			icon_highlighter = (icon_highlighter+2)%3;
			xil_printf("pressed: 'w' ");
		}
		else if(eKeyStatus == S) {
			icon_highlighter = (icon_highlighter+1)%3;
			xil_printf("pressed: 's' ");
		}
		else if(eKeyStatus == ENTER){
			GameSpeedCode = icon_highlighter;
			*GameSpeed 	  = aSpeedValue[icon_highlighter];
			xil_printf("pressed: 'enter' ");
		}
		if(eKeyStatus == ESC){
			eScreenMode 	 = MENU;
			icon_highlighter = 3;
			xil_printf("pressed: 'esc' ");
		}
		else {}
		SendOptions(GameSpeedCode, icon_highlighter);
		usleep(2500);
	}
}

void SendOptions(uint8_t GameSpeedCode, uint8_t icon_highlighter){
	gpio_output = eScreenMode<<30;
	gpio_output = gpio_output | (icon_highlighter<<28);
	gpio_output = gpio_output | (GameSpeedCode<<26);
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}
