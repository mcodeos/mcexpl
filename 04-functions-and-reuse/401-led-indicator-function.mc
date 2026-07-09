// Example: LED Indicator Function
// Goal: Wrap an LED indicator connection in a local function.
// Language focus: func, parameters, reusable connection fragment.

module main
{
    DC.SRC PWR(3.3V, 100mA)

    PWR.1 -> V3V3
    PWR.2 -> GND

    func led_indicator(signal, ground)
    {
        RES R_LED(330R, 50V)
        LED D_STATUS(2.0V, 10mA)

        signal -> R_LED -> D_STATUS.ANODE
        D_STATUS.CATHODE -> ground
        return D_STATUS
    }

    led_indicator(GPIO_STATUS, GND)
}
