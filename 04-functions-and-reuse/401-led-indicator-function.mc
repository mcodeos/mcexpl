// Example: LED Indicator Function
// Goal: Give a custom status LED a minimal reusable connection method.
// Language focus: func, parameters, this, method calls.

component STATUS_LED
{
    name = "Status LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Indicator(signal, ground)
    {
        signal -> this -> ground
    }
}

module main
{
    STATUS_LED D_STATUS

    // GPIO_STATUS and GND are connection points supplied by a larger design.
    D_STATUS.Indicator(GPIO_STATUS, GND)
}
