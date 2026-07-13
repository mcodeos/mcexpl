// Example: Sensor Node Power File
// Goal: Provide a reusable power input component for a multi-file example.
// Language focus: cross-file component definition.

component SENSOR_NODE_POWER
{
    name = "Sensor Node Power"
    pins = [
        ps 1 = VIN
        ps 2 = V3V3
        ps 3 = GND
    ]
}
