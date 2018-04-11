# Stochastics


In addition to the standard time evolution, **QuantumOptics.jl** also features various possibilities to treat stochastic problems. In general, the usage of the [Stochastics](@ref) module is very similar to the standard time evolution. The main difference is, that additional terms that are proportional to the noise in the equation have to be passed to the corresponding functions.

```@example
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
Hs = [H] # hide
J = [destroy(b)] # hide
Js = J # hide
T = [0,0.1] # hide
ψ0 = fockstate(b, 0) # hide
tout, ψt = stochastic.schroedinger(T, ψ0, H, Hs)
tout, ρt = stochastic.master(T, ψ0, H, J, Js)
nothing # hide
```

Like the [Time-evolution](@ref) module, the stochastic solvers are built around the stochastic differential equation solvers from [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl). Many of the options available for stochastic problems treated with [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl) like, for example, the choice of algorithm can be used seamlessly within **QuantumOptics.jl**. The default algorithm choices are

* A Runge-Kutta Milstein method for equations involving only a single noise term (diagonal noise).
* A modified Euler-Heun method with adaptive time stepping with an error estimator based on Lamba due to Rackauckas for equations with more than one noise term (non-diagonal noise).

For details on the available algorithms and further control over the solvers, please refer to the [documentation](http://docs.juliadiffeq.org/stable/) of [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl).
