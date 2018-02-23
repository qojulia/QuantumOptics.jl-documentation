# Stochastic Schrödinger equation

The stochastic Schrödinger equation has the basic form

```math
i\hbar\frac{\mathrm{d}}{\mathrm{d} t} |\Psi(t)\rangle = \left(H + \sum_i H_i^s \xi_i(t)\right) |\Psi(t)\rangle
```

where $H_i^s$ are the terms in the Hamiltonian that are each proportional to an independent noise term $\xi_i(t)$. Note, that by default the noise is assumed to be white-noise (uncorrelated in time), i.e. $\langle\xi_i(t)\xi_i(t')\rangle = \delta(t-t')$.

The above equation is straightforward to implement with

```@example stochastic-schroedinger
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
Hs = [H] # hide
tspan = [0,0.1] # hide
ψ0 = fockstate(b, 0) # hide
dt = 1e-1 # hide
stochastic.schroedinger(tspan, ψ0, H, Hs; dt=dt)
nothing # hide
```

Here, the first three arguments are the same as for [`timeevolution.schroedinger`](@ref). The additional argument `Hs` is either an [`Operator`](@ref) or a vector of operators. The first case corresponds to the stochastic Schrödinger equation featuring only a single noise process, while the latter corresponds to a number of noise processes, where the operators $H_i^s$ are the entries in the vector `Hs`. Note, that the keyword argument `dt` has to be set here since the default algorithms use fixed time steps (e.g. `dt=1e-2`). A default choice of `dt` is not included since it strongly depends on the given problem. For more details on algorithms, see the [**DifferentialEquations.jl** documentation](http://docs.juliadiffeq.org/stable/).

A time-dependent stochastic Schrödinger equation can also be implemented using [`stochastic.schroedinger_dynamic`](@ref). Instead of the two parts of the Hamiltonian `H` and `Hs`, the dynamic version takes two functions as arguments. One, that returns the deterministic part of the dynamic Hamiltonian, while the other returns a vector with the (time- or state-dependent) operators $H_i^s$ as entries.

```@example stochastic-schroedinger
tspan = [0,0.1] # hide
ψ0 = fockstate(b, 0) # hide
dt = 1e-1 # hide
function fdeterm(t, psi)
    # Calculate time-dependent stuff
    # Update deterministic part of Hamiltonian
    H
end

function fstoch(t, psi)
    # Calculate time-dependent stuff
    # Update stochastic part(s) of Hamiltonian
    Hs
end

stochastic.schroedinger_dynamic(tspan, ψ0, fdeterm, fstoch; dt=dt)
nothing # hide
```

Note, that the solver requires to know the number of noise processes. This number is calculated automatically from the given function `fstoch` by calculating the output at time `t=0`. If you want to avoid an initial execution of the function (e.g. because you defined some parameter to change incrementally in the function), you can make the solver skip the initial calculation of `fstoch`. This is done by passing the number of noise processes, i.e. the length of the vector `Hs` that is returned by `fstoch`, using the optional argument `noise_processes`.

## [Functions](@id stochastic-schroedinger: Functions)

* [`stochastic.schroedinger`](@ref)
* [`stochastic.schroedinger_dynamic`](@ref)


## [Examples](@id stochastic-schroedinger: Examples)

* [Two-level atom driven by a noisy laser](@ref)
