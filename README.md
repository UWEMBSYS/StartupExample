# StartupExample
Example startup code for Nucleo 401RE target.
Configures systick IRQ, basic clocks, ungates GPIO, (relocation) and initialization of C library regions and flashes a LED in main

The output format is ELF (https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)


- Coding style is left at IAR default.
- Only addresses and structures relevant to the task are provided in the header file
- The C library relocation/initialization provided by IAR is not used to illustrate all of the steps needed to startup a system. 
- The code is not relocated, it is execute in place from the internal flash.
- CMSIS is not used either

References, with current links:

IAR assembler Reference: http://supp.iar.com/FilesPublic/UPDINFO/005832/arm/doc/EWARM_AssemblerReference.ENU.pdf
Cortex M4 references, describes the core, busses and programming models:         http://infocenter.arm.com/help/topic/com.arm.doc.100166_0001_00_en/arm_cortexm4_processor_trm_100166_0001_00_en.pdf
ARMv7M Architecture Reference manual, explains instruction set, memory models, exception models...  : (need to register with ARM)   http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0403e.b/index.html
Doxygen, used to embedded code comments for later use in documentation:   http://www.stack.nl/~dimitri/doxygen/manual/index.html
STM32F401RE datasheet, contains overview, pin multiplex options ... :        http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00102166.pdf
STm32F401 Reference Manual, contains descripts of al lof the peripherals:        http://www.st.com/st-web-ui/static/active/en/resource/technical/document/reference_manual/DM00096844.pdf



This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>



