namespace EntanglementDemoQSharp {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Math;

    /// # Summary
    /// Runs the Bell state circuit with multiple shots and returns the counts.
    operation RunBellExperiment(numShots : Int) : Unit {
        mutable keys : String[] = [];
        mutable values : Int[] = [];

        for shot in 1..numShots {
            use qs = Qubit[2];

            H(qs[0]);
            CNOT(qs[0], qs[1]);

            let r0 = MResetZ(qs[0]);
            let r1 = MResetZ(qs[1]);

            let key = $"{r0}{r1}";

            mutable found = false;
            for idx in 0..Length(keys) - 1 {
                if keys[idx] == key {
                    set values w/= idx <- values[idx] + 1;
                    set found = true;
                }
            }

            if not found {
                set keys += [key];
                set values += [1];
            }
        }

        Message("Measurement results:");
        for i in 0..Length(keys) - 1 {
            Message($"{keys[i]} -> {values[i]}");
        }
    }

    /// # Summary
    /// Sandbox for students to experiment with entanglement or custom circuits.
    /// # Returns
    /// A tuple of measurement results (Result, Result)
    operation StudentSandbox() : (Result, Result) {
        use qs = Qubit[2];

        // START STUDENT CODE
        H(qs[0]);
        CNOT(qs[0], qs[1]);
        // END STUDENT CODE

        let r0 = M(qs[0]);
        let r1 = M(qs[1]);

        ResetAll(qs);
        return (r0, r1);
    }

    /// # Hadamard Puzzle
    /// Apply a Hadamard and try to achieve a 50/50 mix of Zero and One over many runs.
    operation HadamardPuzzle(shots : Int) : Unit {
        mutable zeroCount = 0;
        mutable oneCount = 0;

        for shot in 1..shots {
            use q = Qubit();
            H(q);
            let result = MResetZ(q);

            if result == Zero {
                set zeroCount += 1;
            } else {
                set oneCount += 1;
            }
        }

        Message($"Hadamard Puzzle Results: Zero = {zeroCount}, One = {oneCount}");
    }

    /// # Multi-Gate Puzzle
    /// Goal: Apply a specific sequence of gates to transform the state.
    /// Student must use H then CNOT to unlock correct output (00 or 11).
    operation MultiGatePuzzle(shots : Int) : Unit {
        mutable correctCount = 0;

        for shot in 1..shots {
            use qs = Qubit[2];

            // Apply sequence: H then CNOT
            H(qs[0]);
            CNOT(qs[0], qs[1]);

            let r0 = MResetZ(qs[0]);
            let r1 = MResetZ(qs[1]);

            if ((r0 == Zero and r1 == Zero) or (r0 == One and r1 == One)) {
                set correctCount += 1;
            }
        }

        Message($"Multi-Gate Puzzle Success Rate: {correctCount}/{shots}");
    }

    /// # Teleportation Challenge
    /// Demonstrates quantum teleportation from q0 to q2 using Bell pair and classical comms.
    operation TeleportationChallenge() : (Result, Result) {
        use qs = Qubit[3];

        // Prepare a state to teleport on q0
        H(qs[0]);

        // Create Bell pair between q1 and q2
        H(qs[1]);
        CNOT(qs[1], qs[2]);

        // Bell measurement between q0 and q1
        CNOT(qs[0], qs[1]);
        H(qs[0]);

        let m0 = M(qs[0]);
        let m1 = M(qs[1]);

        // Classical correction
        if m1 == One {
            X(qs[2]);
        }
        if m0 == One {
            Z(qs[2]);
        }

        let finalResult = M(qs[2]);

        ResetAll(qs);
        return (m0, finalResult);
    }
}