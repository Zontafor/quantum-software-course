from midiutil import MIDIFile

# Example melody from Q#
gate_sequence = ["h", "cx", "x", "z"]

# Mapping from quantum gate to (note, duration)
gate_to_note = {
    "h": (60, 1),   # C4, quarter note
    "x": (62, 1),   # D4
    "z": (64, 1),   # E4
    "cx": (67, 2),  # G4, half note
    "cz": (69, 2),  # A4
    "t": (71, 1),   # B4
    "tdg": (61, 1), # C#4
    "s": (63, 1),   # D#4
    "sdg": (65, 1), # E#4
    "y": (66, 1),   # F#4
    "ccx": (0, 2),  # Rest as 0 velocity (optional: silence)
}

# Create a MIDI track
midi = MIDIFile(1)
track = 0
channel = 0
volume = 100
midi.addTrackName(track, 0, "Quantum Melody")
midi.addTempo(track, 0, 120)

start_time = 0
for gate in gate_sequence:
    note, duration = gate_to_note.get(gate, (60, 1))
    if note > 0:
        midi.addNote(track, channel, note, start_time, duration, volume)
    start_time += duration

# Write to disk
with open("quantum_melody.mid", "wb") as output_file:
    midi.writeFile(output_file)