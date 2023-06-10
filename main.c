#include <msp430.h>
#include "led.h"
#include <stdbool.h>


void delay(){
  __delay_cycles(250000);
}

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD; // Stop watchdog timer
  led_init();

  while(true)
    {
      led_toggle();
      delay();
    }
}
