# Requires: pip install qsharp matplotlib

import qsharp
from GroverDemo import GroverSearch
from collections import Counter
import matplotlib.pyplot as plt

# Run GroverSearch 1024 times and tally results
shots = 1024
counts = Counter()

for _ in range(shots):
    result = GroverSearch.simulate()
    bitstring = "".join(["1" if r == 1 else "0" for r in result])
    counts[bitstring] += 1

# Output result counts
print("\nGrover Search Result Counts (1024 shots):")
for outcome in sorted(counts):
    print(f"{outcome}: {counts[outcome]}")

# Plot histogram
plt.bar(counts.keys(), counts.values(), color="mediumblue")
plt.title("Grover: Most Likely Position of the Hidden Item")
plt.xlabel("Bitstring")
plt.ylabel("Frequency")
plt.tight_layout()
plt.show()