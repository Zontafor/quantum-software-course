// Q# operations for Bell state entanglement demo
// Copyright 2025 Michelle L. Wu & The MITRE Corporation.
//
// DO NOT MODIFY THIS FILE.

namespace EntanglementDemo {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;

    /// # Summary
    /// Creates a Bell state and measures both qubits.
    /// # Returns
    /// A tuple of measurement results (r0, r1)
    operation MeasureBellPair() : (Result, Result) {
        use qs = Qubit[2];

        H(qs[0]);
        CNOT(qs[0], qs[1]);

        let r0 = M(qs[0]);
        let r1 = M(qs[1]);

        ResetAll(qs);
        return (r0, r1);
    }

    /// # Summary
    /// Intentionally breaks entanglement by applying an X gate after Bell state creation.
    /// # Returns
    /// A tuple of measurement results (r0, r1)
    operation BreakEntanglement() : (Result, Result) {
        use qs = Qubit[2];

        H(qs[0]);
        CNOT(qs[0], qs[1]);
        X(qs[1]); // Breaks the entanglement

        let r0 = M(qs[0]);
        let r1 = M(qs[1]);

        ResetAll(qs);
        return (r0, r1);
    }

    /// # Summary
    /// Allows students to define their own entanglement experiment.
    /// # Returns
    /// A tuple of measurement results (Result, Result)
    operation StudentExtension() : (Result, Result) {
        use qs = Qubit[2];

        // TODO: Students can add any gates here

        let r0 = M(qs[0]);
        let r1 = M(qs[1]);

        ResetAll(qs);
        return (r0, r1);
    }
}