*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Test Teardown                 Test Teardown
Resource                      ${RENODEKEYWORDS}

*** Test Cases ***
Should Handle Button Press
    Execute Command         include @STM32F0GPIOPort.cs
    Execute Command         mach create
    Execute Command         machine LoadPlatformDescription @platforms/cpus/stm32f072.repl
    Execute Command         machine LoadPlatformDescriptionFromString "button: Miscellaneous.Button @ gpioPortB 0 { IRQ -> gpioPortB@0 }"
    Execute Command         sysbus LoadELF @C:\Users\H-O-Cally\STM32CubeIDE\workspace_1.4.0\blink_test\Debug\blink_test.elf

    Execute Command         emulation CreateLEDTester "lt" sysbus.gpioA.UserLED1

    Start Emulation

    Execute Command         AssertState lt False timeout=2
    Execute Command         sysbus.gpioPortC.button Press
    Execute Command         AssertState lt True timeout=2
    Execute Command         sysbus.gpioPortC.button Release
    Execute Command         AssertState lt False timeout=2
