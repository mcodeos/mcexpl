// Example: LED Indicator Function
// Goal: Give a current-limited status LED a reusable connection method.
// Language focus: func, parameters, component pin access, method calls.

component STATUS_LED
{
    name = "Status LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Indicator(signal, resistor, ground)
    {
        signal -> resistor -> ANODE
        CATHODE -> ground
    }
}

module main
{
    STATUS_LED D_STATUS
    RES R_LIMIT(330R, 50V)

    // GPIO_STATUS and GND are connection points supplied by a larger design.
    D_STATUS.Indicator(GPIO_STATUS, R_LIMIT, GND)
}
