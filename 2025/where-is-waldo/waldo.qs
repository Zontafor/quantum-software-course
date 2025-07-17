// Grover's Algorithm: Q# Version for 2-Qubit Search (Marked |10>)

namespace GroverDemo {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    /// Applies the oracle marking |10> with a phase flip
    operation ApplyOracle(qs : Qubit[]) : Unit is Adj + Ctl {
        X(qs[0]);
        Controlled Z([qs[0]], qs[1]);
        X(qs[0]);
    }

    /// Grover diffusion operator for 2 qubits
    operation ApplyDiffusion(qs : Qubit[]) : Unit is Adj + Ctl {
        H(qs[0]); H(qs[1]);
        X(qs[0]); X(qs[1]);
        H(qs[1]);
        CNOT(qs[0], qs[1]);
        H(qs[1]);
        X(qs[0]); X(qs[1]);
        H(qs[0]); H(qs[1]);
    }

    /// Grover search for marked state |10>
    operation GroverSearch() : Result[] {
        use qs = Qubit[2];

        // Initialize in uniform superposition
        H(qs[0]); H(qs[1]);

        // Apply oracle
        ApplyOracle(qs);

        // Apply diffusion operator
        ApplyDiffusion(qs);

        // Measure and return results
        let r0 = M(qs[0]);
        let r1 = M(qs[1]);

        ResetAll(qs);
        return [r0, r1];
    }
}