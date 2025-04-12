# Transistor Sizing for Power, Delay, and PDP Optimization Using HSPICE

### 🔹 Step 1: HSPICE Design & Functionality Verification

- Design the selected circuit in **HSPICE**.
- Simulate and **verify the functionality** of the circuit.

### ✅ Task 1: Functionality Verification in HSPICE

- The CMOS transistors (T1–T4) were modeled using standard HSPICE syntax.
- A transient analysis was run to verify correct XOR/XNOR functionality.
- Simulation waveforms confirm the circuit behaves as expected:
  - Input A (waveform 1)
  - Input B (waveform 2)
  - XOR Output (waveform 3)
  - XNOR Output (waveform 4)
  
---

### 🔹 Step 2: Minimum Width Analysis

- Determine **W<sub>min</sub>** (minimum width) for all transistors together.
- Calculate and **demonstrate improvements** in:
  - Average Power
  - Delay
  - Power-Delay Product (PDP)

  ### 📉 Task 2: Determine Optimal Wmin for Power, Delay, PDP

- We swept transistor widths simultaneously and extracted the optimal values based on:
  - **Power Consumption**
  - **Propagation Delay**
  - **Power-Delay Product (PDP)**

**Results**:
| Parameter       | Optimal Width (nm) |
|----------------|--------------------|
| Power           | 260                |
| Delay           | ↓ with ↑ Width     |
| PDP             | ↓ with ↑ Width     |

**Key Observations**:
- Power is minimized around 260nm.
- Delay and PDP decrease as width increases due to lower resistance.

---

### 🔹 Step 3: Width Optimization via Scaling

- With **W<sub>min</sub>** as the lower bound:
  - Scale each transistor's width using different coefficients.
  - Determine the **optimal width coefficients** for each transistor.
  - Report optimal values for **delay**, **average power**, and **PDP**.

### 🔍 Task 3: Optimizing Each Transistor Individually

We introduced coefficients `K1` to `K6`, each multiplying `Wmin`, and performed a sweep for each:

```spice
.param K1=1 K2=1 K3=1 K4=1 K5=1 K6=1
M1 Y A B VDD PMOS W='K1*Wmin' ...
```

- Step-by-step sweeps were conducted per transistor.
- For each parameter (**Power**, **Delay**, **PDP**), the sweep was zoomed in around the minimum.
- High-resolution simulations were done using a **0.0001** step size for precision.

## 📊 Final Optimized Coefficients (for Power)

| Step   | K1     | K2     | K3     | K4     | K5     | K6   |
|--------|--------|--------|--------|--------|--------|------|
| Initial| 2.6897 | 2.4801 | 1.3500 | 1.6384 | 1.2389 | 1.00 |
| Final  | 2.6950 | 2.3990 | 1.3490 | 1.6390 | 1.1590 | 1.00 |


---

### 🔹 Step 4: Comparative Analysis

- Compare the results of optimized scaling (from Step 4) with the base case (Step 3).
- Which width coefficients work best for:
  - Power Optimization
  - Delay Optimization
  - PDP Optimization
- Identify the **best trade-off configuration**.

## ⚡ Delay & PDP Optimizations

- Separate sets of sweeps were conducted for optimizing **delay** and **PDP**.
- A similar methodology was used, but with **delay** or **PDP** as the objective function.
- Final tables (e.g., _page 42_, _page 56_ of the report) show **gradual improvement** in K coefficients across 6 optimization rounds.

---

### 🔹 Step 5: Functional Correctness Check

- Examine whether resizing the transistors **affects functional correctness**.
- Provide analysis and justification.





