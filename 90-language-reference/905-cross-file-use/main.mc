// Example: Cross-File Use
// Goal: Import a local file and instantiate a reusable block.
// Language focus: use.

use ./led_block.mc

module main
{
    DC.SRC PWR(3.3V, 20mA)
    RES R_LED(330R, 50V)
    LedBlock D_STATUS

    PWR.1 -> V3V3
    PWR.2 -> GND
    V3V3 -> R_LED -> D_STATUS.ANODE
    D_STATUS.CATHODE -> GND
}
