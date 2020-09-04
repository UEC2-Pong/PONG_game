/*
 * main.c
 *
 *  Created on: 15.07.2020
 *      Author: Piotrek
 */


//AXI GPIO driver
#include "xgpio.h"

//send data over UART
#include "xil_printf.h"

//information about AXI peripherals
#include "xparameters.h"

int main()
{
	XGpio gpio;
	u32 btn, output;
	output = 0x00000200;
	XGpio_Initialize(&gpio, 0);
	XGpio_DiscreteWrite(&gpio, 2, output);
	//XGpio_SetDataDirection(&gpio, 2, 0x00000000); // set LED GPIO channel tristates to All Output
	//XGpio_SetDataDirection(&gpio, 1, 0xFFFFFFFF); // set BTN GPIO channel tristates to All Input

	while (1)
	{
		btn = XGpio_DiscreteRead(&gpio, 1);

		if (btn == 1) // turn all LEDs on when any button is pressed
			output--;
		else if (btn == 8)
			output++;
		else{}

		XGpio_DiscreteWrite(&gpio, 2, output);
		usleep(2500);
	}
}
