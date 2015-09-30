;
; The code that lives at the boot vector 
; When the Cortex starts from power up it 
;   sets the stack pointer register to the value at the boot vector
;   sets the program counter to the value at the reset vector
;   starts execution

; Define a name for this module of code/data (ie the code in this file, only 1 modules per file is allowed)
; this module will be placed at the boot vector of the Cortex by the linker (see the linker cmd line for explanation)
;
      MODULE    startupCode   
;
; Code is split into logical sections using the SECTION directive. This allows
; the position of code and data to be controlled, important to put the reset vector
; in the correct place

; How much stack is needed?
;  This depends upon what is put on it and how deep it goes (and use of recursion...) 
;  On Cortex The stack is 'fully descending' that means that the stack pointer always holds the pointer of the last stacked item. 
;  The CPU will decrement the stack pointer *before* writing to it
; Why does the stack type matter? 
;   Well if the stack is growing downwards how will you known if the bounds of the stack have been exceeded? You don't unless you gaurd against is.
;   A simple way of preventing clobbering of code/data due to stack overflow is to put it at a place in RAM where it cannot continue to growm ie at the bottom of RAM
; Hence the stack pointer is set to the lowest address of RAM plus the desired stack size.
; The stack and its location are setup in the linker configuration file (startupexample.icf)
; Forward declare that stack data section here, its actual location will be determine by the linker file.
;     the alignment is (3) which means 2 ^ 3, AKA 64 bit alignment
      SECTION CSTACK:DATA:NOROOT(3)

       
;
;     Create a data section to hold the Vector table addresses
;     it is called .intvec, it contains DATA 
;     ROOT determines id the linker will include the section even if it is not  used
;     NOROOT will cause the linke to discard unused sections
;     the alignment is (2) which means 2 ^ 2, AKA 32 bit alignment
;     NOTE: .intvec is a convention for the section with the interrupt vectors
      SECTION   .intvec:CODE:ROOT(2)


;       These are the  stock Cortex interrupt vectors (well, some of them) 
;       The only ones used in this example are Reset and SysTick
;       The rest are declared as 'weak' for now
;       (NOTE that IAR needs the name to be  __vector_table for the debugger and C-Spy to work correctly)
      PUBLIC  __vector_table
      
;   This indicates that the following is DATA, even though this is in a CODE section
;   The information is not executable, it is a list of pointers
      DATA
__vector_table  
      DCD       SFE(CSTACK)                 ; Stack Pointer will be set to this (SFE means Section End, ie the highest address in the section)
      DCD       ResetIrqHandler             ; Reset. (This points to the first piece of code that will execute at power on)
      DCD       NMIIrqHandler               ; NMI
      DCD       HardFaultIrqHandler         ; Hard Fault
      DCD       MemManageIrqHandler         ; MPU Fault
      DCD       BusFaultIrqHandler          ; Bus Fault
      DCD       UsageFaultIrqHandler        ; Usage Fault
      DCD       0
      DCD       0
      DCD       0
      DCD       0
      DCD       SVCIrqHandler               ; SVC 
      DCD       DebugIrqHandler             ; Debug Monitor
      DCD       0                       
      DCD       0
      DCD       SysTickIrqHandler           ; SysTick

      ; The STM32F401 specific interrupt vectors  Follow
      DCD     UnusedIrqHandler              ; WatchDog
      DCD     UnusedIrqHandler              ; PVD through EXTI Line detection
      DCD     UnusedIrqHandler              ; Tamper and TimeStamps through the EXTI line
      DCD     UnusedIrqHandler              ; RTC Wakeup through the EXTI line
      DCD     UnusedIrqHandler              ; Flash 
      DCD     UnusedIrqHandler              ; RCC  - Clocks
      DCD     EXTI0IRQHandler               ; EXTI Line0
      
     
      ; There are more IRQs that are not added here......
      
      
      ; These are in the code section (.text)
      SECTION   .text:CODE:ROOT
      
      ; Stub IRQ handlers
      PUBWEAK  NMIIrqHandler
      PUBWEAK  HardFaultIrqHandler
      PUBWEAK  MemManageIrqHandler
      PUBWEAK  BusFaultIrqHandler
      PUBWEAK  UsageFaultIrqHandler
      PUBWEAK  SVCIrqHandler
      PUBWEAK  DebugIrqHandler
      PUBWEAK  SysTickIrqHandler
      PUBWEAK  EXTI0IRQHandler
NMIIrqHandler      
HardFaultIrqHandler      
MemManageIrqHandler      
BusFaultIrqHandler
UsageFaultIrqHandler      
SVCIrqHandler      
DebugIrqHandler      
SysTickIrqHandler
EXTI0IRQHandler

UnusedIrqHandler           
      B         UnusedIrqHandler      ; Loop forever
PUBWEAK  
 
      
      PUBLIC  ResetIrqHandler
      EXTERN  main
      ; Define what happens at reset.
ResetIrqHandler
      
      ; The IAR library handles this usually, but for this sample it will be done manually
      ; for educational purposes
      ;LDR     R0, =__iar_program_start  ; <- this will do the zero init and init data.
      ;BX R0
      
      
      ; For illustration do the full setup of the C Library data regions manually, 
      ; This will call the C function InitializeDataSection
      ; The stack pointer is already setup by the Cortex core
      ; !!the C function must not use any globally initialized variables, as they have not been initialized yet!!
      EXTERN    InitializeDataSection           ; Tell assembler this symbol is in another file
      LDR       R0, =InitializeDataSection      ; Load a register with the address of the function
      BLX       R0                              ; branch and link, absolute address
                                                ; the link register LR, contains the address of the Next instruction below
      
      ; Globals has been initialized, bss set to zero (not C++ so no constructors to call)
      ; Time to call main
      ; note that main on an embedded system does not have the concept of a command line, hence no arguments
      ; are passed in here
      LDR       R5, =main
      BX        R5                              ; branch, absolute address (never returns)
      
      END
