// 3-Qubit Bit-Flip Quantum Error Correction in Q#

namespace ErrorCorrectionDemo {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    /// Inject a bit-flip error on qubit 0 (can modify to test others)
    operation InjectError(qs : Qubit[]) : Unit {
        X(qs[0]); // Flip qubit 0 to simulate error
    }

    /// Perform bit-flip error correction using majority vote logic
    operation CorrectError(qs : Qubit[]) : Unit {
        CNOT(qs[1], qs[0]);
        CNOT(qs[2], qs[0]);
        CCNOT(qs[1], qs[2], qs[0]);
    }

    /// Main error correction experiment
    operation ErrorCorrectionExperiment() : Result {
        use qs = Qubit[3];

        // Encode logical |0⟩ as |000⟩ (default)

        // Inject error
        InjectError(qs);

        // Correct the error
        CorrectError(qs);

        // Measure corrected logical qubit
        let result = M(qs[0]);

        ResetAll(qs);
        return result;
    }
    /// # Student decoder stub
    /// Students must write logic to correct a bit-flip error
    operation StudentDecoder(qs : Qubit[]) : Unit {
        // TODO: Add gates to perform majority-vote correction
    }

    /// Inject a bit-flip error on qubit 0 (X)
    operation InjectBitFlip(qs : Qubit[]) : Unit {
        X(qs[0]);
    }

    /// Inject a phase-flip error on qubit 0 (Z)
    operation InjectPhaseFlip(qs : Qubit[]) : Unit {
        Z(qs[0]);
    }

    /// Bit-flip decoder using majority vote logic
    operation CorrectBitFlip(qs : Qubit[]) : Unit {
        CNOT(qs[1], qs[0]);
        CNOT(qs[2], qs[0]);
        CCNOT(qs[1], qs[2], qs[0]);
    }

    /// Phase-flip decoder using H-basis majority vote
    operation CorrectPhaseFlip(qs : Qubit[]) : Unit {
        // Move to X-basis
        for q in qs { H(q); }
        CorrectBitFlip(qs);
        for q in qs { H(q); }
    }

    /// Run phase-flip code test
    operation PhaseFlipCorrectionExperiment() : Result {
        use qs = Qubit[3];

        // Encode logical |0⟩ in phase-flip code basis
        // Step 1: Prepare |+++⟩ = H⊗3 |000⟩
        for q in qs { H(q); }

        // Step 2: Inject phase error
        InjectPhaseFlip(qs);

        // Step 3: Correct in X-basis
        CorrectPhaseFlip(qs);

        // Step 4: Decode and measure
        let result = M(qs[0]);
        ResetAll(qs);
        return result;
    }

    /// Encode Shor logical |0> = (|000⟩+|111⟩)⊗3
    operation EncodeShor(qs : Qubit[]) : Unit {
        H(qs[0]);
        CNOT(qs[0], qs[1]);
        CNOT(qs[0], qs[2]);
        CNOT(qs[0], qs[3]);
        CNOT(qs[3], qs[4]);
        CNOT(qs[3], qs[5]);
        CNOT(qs[0], qs[6]);
        CNOT(qs[6], qs[7]);
        CNOT(qs[6], qs[8]);
    }

    /// Simplified Shor decoder and measurement
    operation ShorExperiment() : Result {
        use qs = Qubit[9];

        // Encode Shor logical |0⟩
        EncodeShor(qs);

        // Inject a single bit-flip or phase-flip
        Z(qs[4]); // Test with a phase flip on qubit 4

        // Decode manually (or skip to logical measurement)
        // NOTE: Full Shor decoding not implemented here — advanced session

        // Measure one qubit from each block
        let r0 = M(qs[0]);
        let r1 = M(qs[3]);
        let r2 = M(qs[6]);

        ResetAll(qs);
        // Return majority vote (simplified)
        if (r0 == r1 and r1 == r2) {
            return r0;
        } else {
            return Zero; // default fallback for now
        }
    }
}