// Example: Simple Power Branch
// Goal: Feed two loads from one named supply rail.
// Library focus: DC, RES, LED, CAP.

module main
{
    DC.SRC PWR(3.3V, 200mA)
    CAP.CER C_BYPASS(100nF, 10V)
    RES R_LED(330R, 50V)
    LED D_STATUS(2.0V, 10mA)

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> C_BYPASS -> GND
    V3V3 -> R_LED -> D_STATUS.ANODE
    D_STATUS.CATHODE -> GND
}
