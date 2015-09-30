#include <stdlib.h>
#include <stdint.h>
#include <globals.h>
#include <clocks.h>
#include <pinmux.h>
#include <interrupts.h>

/*
 * These variables should be initialized during the startup sequence
 */
volatile uint16_t    InitializedVariable16 = 0x1234;
volatile uint32_t    InitializedVariable32 = 0xABCD5678;   


volatile uint16_t    ZeroInitializedVariable16;
volatile uint32_t    ZeroInitializedVariable32;

/* 
 * This variable should be zero initialized during startup
 */
uint64_t    ZeroInitializedVariable;

int main()
{
  
  /* Setup clocks first, unclocked modules will case the system to lockup the bus if accessed */
  SetupSystemClocks();
  
  /* Configure Pin Mux */
  SetupPinmux();
  
  /* Start processing interrupts */
  SetupInterrupts();
  
  /* This variable should be initialized by startup  */
  static uint32_t InitializedLocal = 0xbeef8008;
  
  /* Task: Look at the variables in the debugger to verify that they were genuinely set to the values */
  
 
  
  /* This loop exists to prevent the compiler from removing the variables */
  while (InitializedVariable16) {
            ++InitializedLocal;
            ++InitializedVariable32;
            --InitializedVariable16;
            ++ZeroInitializedVariable32;
  }
  
  
  /* main should never actually return in this case */
  return 0;

}