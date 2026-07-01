// Example: Power Net
// Goal: Introduce a minimal module, a source component, and named power nets.
// Library focus: DC.

module main
{
    DC.SRC PWR(5V, 500mA)

    PWR.VCC -> V5V
    PWR.GND -> GND
}
