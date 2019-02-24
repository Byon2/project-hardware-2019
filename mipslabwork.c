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

int mytime = 0x5957;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
   volatile int* p = (volatile int*) 0xbf886100;
   *p=*p&0xff00;
   
   TRISD = TRISD & 0x0FE0;
// 0000 1111 1110 0000
  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{
	volatile int* p = (volatile int*) 0xbf886110;
	*p = 0x0;
	int c = 0x00;
	int btn;
	int sw;
	while(1){
		delay( 1000000 );
		btn = getbtns();
		sw = getsw();
		moveDown();
		
		if((btn & 0x0004) == 0x0004){
			mytime = (mytime & 0x0fff) ;
			sw = sw << 12;
			mytime = mytime | sw;
		}if((btn & 0x0002) == 0x0002){
			mytime = (mytime & 0xf0ff) ;
			sw = sw << 8;
			mytime = mytime | sw;
		}if((btn & 0x0001) == 0x0001){
			mytime = (mytime & 0xff0f) ;
			sw = sw << 4;
			mytime = mytime | sw;
		}
		
		
		
		
		time2string( textstring, mytime );
		display_string( 3, textstring );
		display_update();
		tick( &mytime );
		c++;
		*p=c;
		if(c==0xff){
	  
			c=0x00;
		}
		display_image(96, icon);
	}
}
