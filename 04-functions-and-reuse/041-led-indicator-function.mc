// Example: LED Indicator Function
// Goal: Connect a current-limited status LED with a reusable method.
// Language focus: func, parameters, component pin access, method calls.

component STATUS_LED
{
    name = "Status LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Indicator(limited_signal, ground)
    {
        limited_signal -> ANODE
        CATHODE -> ground
    }
}

module main
{
    STATUS_LED D_STATUS
    RES R_LIMIT(330R, 50V)

    // The resistor remains a two-pin series device outside the method.
    GPIO_STATUS -> R_LIMIT.1
    D_STATUS.Indicator(R_LIMIT.2, GND)
}
