// Reference: Attributes, Spec, And Typed Parameters
// Focus: typed constructor parameters and spec attributes.

component REF_RESISTOR(resistance::UV.OHM, voltage::UV.VOLT)
{
    name = "Reference Resistor"
    spec = [
        resistance = resistance
        voltage = voltage
    ]
    package = "0603"

    pins = [
        1 = 1
        2 = 2
    ]
}

module main
{
    DC.SRC PWR(3.3V, 10mA)
    REF_RESISTOR R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 5mA)

    PWR.1 -> R_LIMIT -> D_STATUS.ANODE
    D_STATUS.CATHODE -> PWR.2
}
