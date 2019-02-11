/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
#define TMR2P ((80000000/256)/10)

int mytime = 0x5957;
int c = 0x00;
int timeoutcount = 0x00;
int btn;
int sw;
int prime = 1234567;
volatile int* p;


char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void ) {
	p = (volatile int*) 0xbf886110;
	
	
		IFS(0)&=~0x100;		//sets the bit 8 to 0 which represents the interrupt bit for timer2
		timeoutcount++;			//counts up
	
		if(timeoutcount==10){					//when the interrupt count is 10
			time2string( textstring, mytime );	//it will display the contents and tick the timer and reset the counter
			display_string( 3, textstring );
			display_update();
			tick( &mytime );
		
			timeoutcount=0x00;
		}
	
	static int count=0;
	if(IFS(0)& 0x8000){
		IFS(0)&=~0x8000;		//sets the bit 15 to 0 which represents the interrupt bit for external interrupt 3
		count++;
		PORTE=count;
		
	}
}

/* Lab-specific initialization goes here */
void labinit( void )
{
   p = (volatile int*) 0xbf886100;
   *p&=0xff00;
   
   TRISD = TRISD & 0x0FE0;
// 0000 1111 1110 0000

	PR2 = TMR2P; // Load the period register
	T2CON = 0x0070; // Stop the timer and clear the control register, 
	// prescaler at 1:256,internal clock source                                   
	TMR2 = 0x0; // Clear the timer register
	
	//IFSCLR(0) = 0x00000100; // Clear the timer interrupt status flag
	//IECSET(0) = 0x00000100; // Enable timer interrupts
	T2CONSET = 0x8000; // Start the timer
	
	IPC(2) |= 0x10;				//sets the priority
	IPC(3) |= 0x04000000;
	IEC(0) = 0x8100;				//Interrupt enable bit for timer 2
	enable_interrupt();			//enable interrupt
	return;
}

/* This function is called repetitively from the main program */
void labwork( void ) {
	prime = nextprime( prime );
	display_string( 0, itoaconv( prime ) );
	display_update();
}
