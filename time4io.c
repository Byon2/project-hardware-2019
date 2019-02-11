#include <stdint.h>
#include <pic32mx.h>
#include "mipslab.h"

int getsw( void );

int getsw( void ){
	int p =  PORTD >> 8;
	p = p & 0x000F;
	return p;

}

int getbtns(void);

int getbtns(void){

	int p = PORTD >> 5;
	p = p & 0x0007;
	return p;
}