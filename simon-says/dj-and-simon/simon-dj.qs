// Deutsch–Jozsa Algorithm with Constant Oracle, Classification, and Student Sandbox

namespace DeutschJozsaDemo {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;

    /// Constant oracle: does nothing (always returns 0)
    operation ConstantOracle(input : Qubit[], output : Qubit) : Unit is Adj + Ctl {
        // No-op
    }

    /// Student-defined oracle placeholder
    operation StudentOracle(input : Qubit[], output : Qubit) : Unit is Adj + Ctl {
        // TODO: Students implement their own oracle logic here
        // Example: Flip output if input = |01⟩
        Controlled X([input[1]], output);
    }

    /// Helper to classify DJ results: if all 0s, then constant; else balanced
    function ClassifyDJResult(results : Result[]) : String {
        mutable allZero = true;
        for r in results {
            if r != Zero {
                set allZero = false;
            }
        }
        return (allZero ? "Constant" | "Balanced");
    }

    /// Deutsch–Jozsa algorithm runner with configurable oracle
    operation RunDeutschJozsaWith(oracle : (Qubit[], Qubit) => Unit) : (Result[], String) {
        use input = Qubit[2];
        use output = Qubit();

        // Initialize output to |1⟩
        X(output);

        // Apply Hadamards to input and output
        ApplyToEach(H, input);
        H(output);

        // Run oracle
        oracle(input, output);

        // Apply Hadamards again to input
        ApplyToEach(H, input);

        // Measure input qubits
        mutable measured = [];
        for i in 0..Length(input) - 1 {
            set measured w/= i <- MResetZ(input[i]);
        }

        Reset(output);

        // Classify result
        let verdict = ClassifyDJResult(measured);
        return (measured, verdict);
    }

    /// Predefined constant oracle test
    operation DeutschJozsaConstant() : (Result[], String) {
        return RunDeutschJozsaWith(ConstantOracle);
    }

    /// Student test using their custom oracle
    operation DeutschJozsaStudentTest() : (Result[], String) {
        return RunDeutschJozsaWith(StudentOracle);
    }
}