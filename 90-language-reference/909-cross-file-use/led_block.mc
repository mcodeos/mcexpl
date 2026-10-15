// Reference: Reusable LED Component
// Goal: Provide a local component for the cross-file use example.
// Language focus: component reuse.

component LedBlock
{
    pins = [
        io [1, 2] = DIO{A, K}   // A = anode, K = cathode (DIO face adoption)
    ]
}
