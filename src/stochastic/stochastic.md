# Stochastics


In addition to the standard time evolution, **QuantumOptics.jl** also features various possibilities to treat stochastic problems. In general, the usage of the [Stochastics](@ref) module is very similar to the standard time evolution. The main difference is, that additional terms that are proportional to the noise in the equation have to be passed to the corresponding functions.

```@example stochastic-intro
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

Like the [Time-evolution](@ref) module, the stochastic solvers are built around the stochastic differential equation solvers from [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl). Many of the options available for stochastic problems treated with [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl) like, for example, the choice of algorithm can be used seamlessly within **QuantumOptics.jl**.


### [Default algorithms and noise](@id stochastic-defaults)

The framework will try to automatically choose default settings that best suit the problem at hand. However, it can only do so much, so please be mindful of what the requirements for your calculation really are. The default algorithms that are implemented solve the stochastic equation in the **Stratonovich** sense. More specifically, they are

* A Runge-Kutta Milstein method for equations involving only a single quantum noise term (diagonal noise).
* A modified Euler-Heun method with adaptive time stepping with an error estimator based on Lamba due to Rackauckas for equations with more than one quantum noise term or combinations of classical and quantum noise (non-diagonal noise).

To override the default algorithm, simply set the `alg` keyword argument with one of the solvers you found [here](http://docs.juliadiffeq.org/stable/solvers/sde_solve.html#Full-List-of-Methods-1), e.g.

```@example stochastic-intro
import StochasticDiffEq # hide
tout, ψt = stochastic.schroedinger(T, ψ0, H, Hs; alg=StochasticDiffEq.EulerHeun(), dt=1e-2)
nothing # hide
```

Note, that in the line of code above we chose the `EulerHeun` algorithm, which is a fixed timestep method so we also needed to set `dt`.

Since most equations involving quantum noise should be norm/trace conserving, the default noise is chosen to be real white noise. For example,

```@example stochastic-intro
tout, ψt = stochastic.schroedinger(T, ψ0, H, Hs; noise=StochasticDiffEq.RealWienerProcess!(0.0, [0.0]))
nothing # hide
```

corresponds to the default for a single noise term in the Schrödinger equation. Note, that the default is complex noise for semiclassical stochastic equations, where only classical noise is included (for details see [stochastic semiclassical systems](@ref stochastic-semiclassical))

For details on the available algorithms and further control over the solvers, please refer to the [documentation](http://docs.juliadiffeq.org/stable/) of [**DifferentialEquations.jl**](https://github.com/JuliaDiffEq/DifferentialEquations.jl).
