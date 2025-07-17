#	Let students write their own oracle and see what the outcome is.
#	Quiz: Did Simon use a constant or balanced function? Use more qubits to scale the game.

# !pip install qiskit matplotlib
from qiskit import QuantumCircuit, Aer, execute
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

n = 2  # number of input bits
qc = QuantumCircuit(n + 1, n)

# Initialize output qubit to |1⟩
qc.x(n)

# Apply Hadamards to all qubits
qc.h(range(n + 1))

# === Oracle for CONSTANT function ===
# Do nothing (outputs 0 regardless of input)

# Apply Hadamards again to input qubits
qc.h(range(n))

# Measure input qubits
qc.measure(range(n), range(n))

# Simulate
sim = Aer.get_backend("qasm_simulator")
job = execute(qc, sim, shots=1024)
counts = job.result().get_counts()

# Output
print("Deutsch–Jozsa Result (Constant Oracle):")
print(counts)

# Plot
plot_histogram(counts)
plt.title("Simon Says: Is the Function Constant?")
plt.show()