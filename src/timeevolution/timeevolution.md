# Time-evolution


**QuantumOptics.jl** implements various solver to simulate the dynamics of closed as well as open quantum systems. The interfaces are designed to be as consistent as possible which makes it easy to switch between different methods.

```@example
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
J = [destroy(b)] # hide
T = [0,0.1] # hide
psi0 = fockstate(b, 0) # hide
tout, psi_t = timeevolution.schroedinger(T, psi0, H)
tout, rho_t = timeevolution.master(T, psi0, H, J)
tout, psi_t = timeevolution.mcwf(T, psi0, H, J)
nothing # hide
```
