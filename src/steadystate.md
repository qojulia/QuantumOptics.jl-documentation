# Steady state

**QuantumOptics.jl** implements two different ways to calculate steady states. The first one is to perform a time evolution according to a master equation until an adequate accuracy is reached

* [`steadystate.master`](@ref)

Most of the arguments are identical to the ones used for a standard [Master time evolution](@ref). There are a few differences, however. First of all it is no longer required to give an initial state, but rather optional. If no initial state is given it defaults to a density matrix with a single 1 in the first entry. Note, that while for a cavity this corresponds to a Fock state with zero photons, it might be undesirable to use the default value when working with atoms (spin particles), since this state corresponds to the (highest) excited state.

Additionally, one can explicitly specify the trace distance criterion `eps`, which is checked in every time step. The time evolution stops, i.e. steady-state is reached, when the trace distance between two consecutive density matrices ``\rho(t)`` and ``\rho(t+dt)`` is smaller than this value. The default is `eps=1e-3`.

For smaller system sizes finding eigenvectors of super-operators is the preferred method:

* [`steadystate.eigenvector`](@ref)

A simple example, that can also be solved analytically, is to compute the steady-state photon number of a cavity driven with an amplitude ``\eta`` and damping rate ``2\kappa``. The analytical solution is ``n=\eta^2/\kappa^2``, while in the toolbox we may calculate this with:

```@example steadystate
using QuantumOptics # hide
b = FockBasis(10)
κ = 1.0
η = 0.5κ
H = η*(destroy(b) + create(b))
J = [sqrt(2κ)*destroy(b)]
ρ_master = steadystate.master(H, J)
ρ_eig = steadystate.eigenvector(H, J)
println("n_master = ", real(expect(number(b), ρ_master)))
println("n_eig = ", real(expect(number(b), ρ_eig)))
nothing # hide
```

Due to numerical errors the results are not exactly ``0.25``. Decreasing the value of `eps` below its default `1e-3` improves the accuracy for the time-evolution approach.


## [Functions](@id steadstate: Functions)

* [`steadystate.master`](@ref)
* [`steadystate.eigenvector`](@ref)

## [Examples](@id steadystate: Examples)
