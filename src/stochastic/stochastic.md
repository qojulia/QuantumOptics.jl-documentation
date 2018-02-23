# Stochastics


In addition to the standard time evolution, **QuantumOptics.jl** also features various possibilities to treat stochastic problems. Like the [Time-evolution](@ref) module, the stochastic solvers are built around the stochastic differential equation solvers from **DifferentialEquations.jl**. Many of the options available for stochastic problems treated with **DifferentialEquations.jl** (like, for example, the choice of algorithm) can be used seamlessly withing **QuantumOptics.jl**. For details on the possibilities, please refer to the documentation of [**DifferentialEquations.jl**](http://docs.juliadiffeq.org/stable/).
In general, the usage of the [Stochastics](@ref) module is very similar to the standard time evolution. The main difference is, that additional terms that are proportional to the noise in the equation have to be passed to the corresponding functions.

```@example
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
Hs = [H] # hide
J = [destroy(b)] # hide
Js = J # hide
T = [0,0.1] # hide
ψ0 = fockstate(b, 0) # hide
dt = 1e-1 # hide
tout, ψt = stochastic.schroedinger(T, ψ0, H, Hs; dt=dt)
tout, ρt = stochastic.master(T, ψ0, H, J, Js; dt=dt)
nothing # hide
```
