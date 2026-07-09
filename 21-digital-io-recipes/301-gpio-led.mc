// Example: GPIO LED
// Goal: Connect a digital output to an LED indicator.
// Library focus: GPIO, DC, RES, LED.

module main
{
    DC.SRC PWR(3.3V, 50mA)
    RES R_LED(330R, 50V)
    LED D_STATUS(2.0V, 10mA)

    PWR.1 -> V3V3
    PWR.2 -> GND

    GPIO_LED -> R_LED -> D_STATUS.ANODE
    D_STATUS.CATHODE -> GND
}
