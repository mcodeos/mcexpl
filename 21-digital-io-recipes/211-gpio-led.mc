// Example: GPIO LED
// Goal: Connect a digital output to an LED indicator.
// Library focus: GPIO, RES, LED.

module main
{
    RES R_LED(330R, 50V)
    LED D_STATUS(2.0V, 10mA)

    GPIO_LED -> R_LED -> D_STATUS.ANODE
    D_STATUS.CATHODE -> GND
}
