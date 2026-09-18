// Example: Power Net
// Goal: Introduce a minimal module, a source component, and named power nets.
// Library focus: DC.

module main
{
    io GND
    io V5V

    DC.SRC PWR(5V, 500mA)

    PWR.1 -> V5V
    PWR.2 -> GND
}
