# quantum_midi_runner.py
# Requires: pip install qsharp midiutil

import qsharp
from EntanglementDemoQSharp import CustomMelodyMapped
from midiutil import MIDIFile

# Step 1: Define a gate sequence and fetch note/duration pairs from Q#
gate_sequence = ["h", "cx", "x", "z", "ccx"]
note_durations = CustomMelodyMapped.simulate(gates=gate_sequence)

# Step 2: Map note names to MIDI pitch numbers
note_to_pitch = {
    "C": 60, "C#": 61, "D": 62, "D#": 63,
    "E": 64, "E#": 65, "F": 66, "G": 67,
    "A": 69, "B": 71, "Rest": 0, "?": 60
}

# Step 3: Create a new MIDI file
midi = MIDIFile(1)
track = 0
channel = 0
volume = 100
midi.addTrackName(track, 0, "Quantum Melody")
midi.addTempo(track, 0, 120)

start_time = 0
for note_name, duration in note_durations:
    pitch = note_to_pitch.get(note_name, 60)
    if pitch > 0:
        midi.addNote(track, channel, pitch, start_time, duration, volume)
    start_time += duration

# Step 4: Write the MIDI file to disk
with open("quantum_melody.mid", "wb") as output_file:
    midi.writeFile(output_file)

print("MIDI file 'quantum_melody.mid' has been written from Q# output.")