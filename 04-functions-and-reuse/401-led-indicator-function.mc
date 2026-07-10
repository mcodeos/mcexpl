// Example: LED Indicator Function
// Goal: Give a custom status LED a reusable connection method.
// Language focus: func, parameters, this, return, method calls.

component STATUS_LED(fv::UV.VOLT, fi::UV.AMP)
{
    name = "Status LED"
    spec = [
        forward_voltage = fv
        forward_current = fi
    ]
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Indicator(signal, ground)
    {
        signal -> RES(330R, 50V) -> this -> ground
        return this
    }
}

module main
{
    STATUS_LED D_STATUS(2.0V, 5mA)

    // GPIO_STATUS and GND are connection points supplied by a larger design.
    D_STATUS.Indicator(GPIO_STATUS, GND)
}
