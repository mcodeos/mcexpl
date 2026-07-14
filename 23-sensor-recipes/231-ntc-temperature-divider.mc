// Example: NTC Temperature Divider
// Goal: Create a simple analog voltage from an NTC thermistor divider.
// Library focus: DC, RES, RES.THERM.

module main
{
    DC.SRC PWR(3.3V, 5mA)
    RES R_FIXED(10000R, 50V)
    RES.THERM RT_NTC(10000R)

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> R_FIXED -> TEMP_SENSE
    TEMP_SENSE -> RT_NTC -> GND
}
