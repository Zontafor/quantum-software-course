/// # Quantum Gate Melody Generator
/// Maps a list of quantum gate names to musical notes and durations
namespace EntanglementDemoQSharp {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays;

    function GateToNote(g : String) : String {
        if g == "h" { return "C"; }
        elif g == "x" { return "D"; }
        elif g == "z" { return "E"; }
        elif g == "cx" { return "G"; }
        elif g == "cz" { return "A"; }
        elif g == "t" { return "B"; }
        elif g == "tdg" { return "C#"; }
        elif g == "s" { return "D#"; }
        elif g == "sdg" { return "E#"; }
        elif g == "y" { return "F"; }
        elif g == "ccx" { return "Rest"; }
        else { return "?"; }
    }

    function GateToDuration(g : String) : Int {
        if g == "cx" or g == "ccx" or g == "cz" {
            return 2; // multi-qubit gates take longer
        } else {
            return 1; // single-qubit
        }
    }

    /// # Summary
    /// Takes a predefined gate sequence and prints the mapped musical melody
    operation QGateMelody() : Unit {
        let gates = ["h", "cx", "x", "z"];

        Message("Quantum Gate Melody:");
        for g in gates {
            let note = GateToNote(g);
            let beat = GateToDuration(g);
            Message($"{g} → {note} (duration: {beat})");
        }
    }

    /// # Student-defined Custom Melody
    /// Allows students to input their own gate sequences.
    operation CustomMelody(gates : String[]) : Unit {
        Message("\nCustom Quantum Melody:");
        for g in gates {
            let note = GateToNote(g);
            let beat = GateToDuration(g);
            Message($"{g} → {note} (duration: {beat})");
        }
    }
    
    /// # Exportable version: returns note/duration pairs to host
    function CustomMelodyMapped(gates : String[]) : (String, Int)[] {
        mutable result : (String, Int)[] = [];
        for i in 0..Length(gates)-1 {
            let g = gates[i];
            let note = GateToNote(g);
            let dur = GateToDuration(g);
            set result += [(note, dur)];
        }
        return result;
    }

}