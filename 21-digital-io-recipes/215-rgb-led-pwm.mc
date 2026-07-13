// Example: RGB LED PWM
// Goal: Connect three control signals to an RGB LED.
// Library focus: LED.RGB, RES, PWM, DC.

module main
{
    DC.SRC PWR(3.3V, 100mA)
    LED.RGB D_RGB(2.0V, 3.2V, 3.2V, 20mA)
    RES R_RED(220R, 50V)
    RES R_GREEN(220R, 50V)
    RES R_BLUE(220R, 50V)

    PWR.1 -> V3V3
    PWR.2 -> GND

    PWM_RED -> R_RED -> D_RGB.RED_ANODE
    PWM_GREEN -> R_GREEN -> D_RGB.GREEN_ANODE
    PWM_BLUE -> R_BLUE -> D_RGB.BLUE_ANODE
    D_RGB.COMMON_CATHODE -> GND
}
