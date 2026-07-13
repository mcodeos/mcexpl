// Reference: Pins, Ranges, And Indexed Names
// Focus: pin directions, physical pin ranges, and indexed pin names.

component REF_GPIO_HEADER
{
    name = "Reference GPIO Header"
    pins = [
        io [1:4] = GPIO[0:3]
        ps 5 = VCC
        ps 6 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    REF_GPIO_HEADER J_GPIO

    PWR.1 -> V3V3
    PWR.2 -> GND
    V3V3 -> J_GPIO.VCC
    J_GPIO.GND -> GND

    J_GPIO.GPIO0 -> GPIO0
    J_GPIO.GPIO1 -> GPIO1
    J_GPIO.GPIO2 -> GPIO2
    J_GPIO.GPIO3 -> GPIO3
}
