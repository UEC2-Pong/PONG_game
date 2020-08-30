// includes
#include "xil_types.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xuartlite_l.h"
#include "xil_printf.h"
#include "sleep.h"

uint8_t screen_mode		 = 0x00;
uint8_t icon_highlighter = 0x00;
uint8_t game_speed 		 = 0x01;
uint8_t game_mode        = 0x00;
uint32_t gpio_output, gpio2_output;
uint8_t KeyStatus;

void Menu(void);
void Options(void);
void SingleGame(void);
void MultiGame(void);

void CheckingForKeys(uint32_t baseaddr) {
	if(!XUartLite_IsReceiveEmpty(baseaddr)){
		uint8_t ReceivedKey;
		ReceivedKey = XUartLite_RecvByte(baseaddr);
		if 		(ReceivedKey == 'w') KeyStatus = 1; // W
		else if (ReceivedKey == 's') KeyStatus = 2; // S
		else if (ReceivedKey == 13)  KeyStatus = 3; // Enter
		else if (ReceivedKey == 27)  KeyStatus = 4; // Esc
		else if (ReceivedKey == 38)  KeyStatus = 5; // Arrow Up
		else if (ReceivedKey == 40)  KeyStatus = 6; // Arrow Down
		else KeyStatus = 0;
	}
	else{
		KeyStatus = 0;
	}
}

// MAIN LOOP
//------------------------------------------------------------------------------------------------------------------------------------

int main(){
	XGpio gpio;
	XGpio_Initialize(&gpio, 0);
	gpio_output  = 0x00000000;
	gpio2_output = 0x000C0180;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);

	while(1){
		CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if( screen_mode == 0){
			Menu();
		}
		else if( screen_mode == 1){
			SingleGame();
			if(KeyStatus == 4){
				screen_mode 	 = 0;
				game_mode		 = 0;
				icon_highlighter = 0;
				xil_printf("pressed: 'esc' ");
			}
			else {}
		}
		else if( screen_mode == 2){
			if(KeyStatus == 4){
				screen_mode  	 = 0;
				icon_highlighter = 2;
				xil_printf("pressed: 'esc' ");
			}
			else {}
		}
		else if( screen_mode == 3){
			Options();
		}
		else{
			xil_printf("you shouldn't be here ");
		}
		gpio_output = screen_mode<<30;
		gpio_output = gpio_output | (icon_highlighter<<28);
		gpio_output = gpio_output | (game_speed<<26);
		XGpio_DiscreteWrite(&gpio, 1, gpio_output);

		/*
		gpio2_output = screen_mode<<30;
		gpio2_output = gpio2_output | (icon_highlighter<<28);
		gpio2_output = gpio2_output | (game_speed<<26);
		XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
		*/
	}
}

//------------------------------------------------------------------------------------------------------------------------------------

void Menu(void){
	if(KeyStatus == 1) {
		icon_highlighter = (icon_highlighter+3)%4;
		xil_printf("pressed: 'w' ");
	}
	else if(KeyStatus == 2) {
		icon_highlighter = (icon_highlighter+1)%4;
		xil_printf("pressed: 's' ");
	}
	else if(KeyStatus == 3){
		xil_printf("pressed: 'enter' ");
		if( icon_highlighter == 0 ){
			screen_mode = 1;
			game_mode   = 1;
		}
		else if( icon_highlighter == 1 ){
			screen_mode = 1;
			game_mode   = 2;
		}
		else if( icon_highlighter == 2 ) screen_mode = 2;
		else if( icon_highlighter == 3 ) screen_mode = 3;
		else {
			xil_printf("ERROR ");
		}
		icon_highlighter = 0;
	}
	else if(KeyStatus == 4){
		xil_printf("pressed: 'esc' ");
	}
	else{
	}
}

void Options(void){
	if(KeyStatus == 1) {
		icon_highlighter = (icon_highlighter+2)%3;
		xil_printf("pressed: 'w' ");
	}
	else if(KeyStatus == 2) {
		icon_highlighter = (icon_highlighter+1)%3;
		xil_printf("pressed: 's' ");
	}
	else if(KeyStatus == 3){
		game_speed = icon_highlighter;
		xil_printf("pressed: 'enter' ");
	}
	if(KeyStatus == 4){
		screen_mode 	 = 0;
		icon_highlighter = 3;
		xil_printf("pressed: 'esc' ");
	}
	else {}
}

void SingleGame(void){
	if(KeyStatus == 1){
		gpio_output--;
		xil_printf("pressed: 'w' ");
	}
	else if(KeyStatus == 2){
		gpio_output++;
		xil_printf("pressed: 's' ");
	}
}

void MultiGame(void){
	if(KeyStatus == 1){
		gpio_output--;
		xil_printf("pressed: 'w' ");
	}
	else if(KeyStatus == 2){
		gpio_output++;
		xil_printf("pressed: 's' ");
	}
	else if(KeyStatus == 5){
		gpio2_output--;
		xil_printf("pressed: 'Arrow Up' ");
	}
	else if(KeyStatus == 6){
		gpio2_output++;
		xil_printf("pressed: 'Arrow Down; ");
	}
}

/*
	while(1){
		CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(KeyStatus == 1) {
			screen_mode = 0b00;
			xil_printf("pressed: 'w' ");
		}
		else if(KeyStatus == 2) {
			screen_mode = 0b01;
			xil_printf("pressed: 's' ");
		}
		else if(KeyStatus == 3){
			screen_mode = 0b11;
			xil_printf("pressed: 'enter' ");
		}
		else if(KeyStatus == 4){
			screen_mode = 0b10;
			xil_printf("pressed: 'esc' ");
		}
		else{
		}
	gpio_output = screen_mode<<30;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
	usleep(2500);
	}
	*/
