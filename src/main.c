#include <stdlib.h>
#include <stdint.h>



/*
 * These variable should be initialized during the startup sequence
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
  /* This variable should be initialized by startup  */
  static uint32_t InitializedLocal = 0xbeef8008;
  
 
  while (InitializedVariable16) {
            ++InitializedLocal;
            ++InitializedVariable32;
            --InitializedVariable16;
            ++ZeroInitializedVariable32;
  }
  
  return 0;

}