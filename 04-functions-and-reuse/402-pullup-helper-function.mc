// Example: Pull-Up Helper Function
// Goal: Give a pull-up resistor a reusable connection method.
// Language focus: returning a named connection point.

component PULLUP_RESISTOR(resistance::UV.OHM, voltage::UV.VOLT)
{
    name = "Pull-Up Resistor"
    spec = [
        resistance = resistance
        voltage = voltage
    ]
    pins = [
        1 = INPUT
        2 = SOURCE
    ]

    func Pullup(input, source)
    {
        input -> this -> source
        return input
    }
}

module main
{
    DC.SRC PWR(3.3V, 50mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    R_PULLUP::PULLUP_RESISTOR(10000R, 50V).Pullup(BUTTON_IN, V3V3)
    // Repeating BUTTON_IN makes the shared input node explicit.
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
