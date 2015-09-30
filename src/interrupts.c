#include <stm32f401.h>
#include <interrupts.h>
#include <globals.h>

/**
 * Setup the NVIC 
 * Use CMSIS macros to do the but swizzling and register accesses
 */
void SetupInterrupts(void)
{
  NVIC_SetPriorityGrouping(__NVIC_PRIORITYGROUP);
  
  uint32_t preemptLevel = 0;
  uint32_t subPri  = 0;
  
  uint32_t pri = NVIC_EncodePriority(NVIC_GetPriorityGrouping(), preemptLevel, subPri);  
  NVIC_SetPriority(SysTick_IRQn, pri);  
  
  /**
   * Enable some interrupts
   * The Systick Irq 
   * The GPIO  for the User Button, which is on GPIO line GPIO_PIN_USER_BUTTON (AKA 13)
   * we could be clever here and put the GPIO enable in a switch statement, that is left to you to do
   */
  
  
  /* Enable Systick IRQ */
  
    
  
}


/**
 * Add interrupt handlers for Systick and GPIO
 * GPIO is part of the EXTI block
 * These will override the weak linkages specified in the startup.s file
 */
void SysTickIrqHandler(void)
{
    ++CurrentTick;
}


void EXTI0IRQHandler(void)
{
  
}

void EXTI1IRQHandler(void)
{
  
}

void EXTI2IRQHandler(void)
{
  
}

void EXTI3IRQHandler(void)
{
  
}

void EXTI4IRQHandler(void)
{
  
}


void EXTI5Thru9IRQHandler(void)
{

}

void EXTI10Thru15IRQHandler(void)
{

}

