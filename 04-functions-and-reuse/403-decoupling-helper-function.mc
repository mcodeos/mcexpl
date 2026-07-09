// Example: Decoupling Helper Function
// Goal: Reuse a local function for a rail-to-ground capacitor.
// Language focus: func, parameters, repeated calls.

module main
{
    DC.SRC PWR(5V, 500mA)
    REG.LDO U_LDO(3.3V, 0.2A, 5V, 0.3V)

    PWR.1 -> V5V
    PWR.2 -> GND
    V5V -> U_LDO.INPUT
    U_LDO.OUTPUT -> V3V3
    U_LDO.GND -> GND

    func decouple(rail, ground)
    {
        CAP.CER C_LOCAL(100nF, 10V)

        rail -> C_LOCAL -> ground
        return rail
    }

    decouple(V5V, GND)
    decouple(V3V3, GND)
}
