# Stochastic Master equation

A stochastic master equation with multiple output channels (simultaneous measurements) has the general form

```math
\dot{\rho} = -\frac{i}{\hbar} \big[H,\rho\big]
             + \sum_i \left(
                    J_i \rho J_i^\dagger
                    - \frac{1}{2} J_i^\dagger J_i \rho
                    - \frac{1}{2} \rho J_i^\dagger J_i
                +\sum_k
                    \left(J_k^s\rho + \rho \left(J_k^s\right)^\dagger\right)\xi_k(t)
                \right)
```

Here, $J_i$ are the Lindblad damping operators, while $J_i^s$ are the stochastic damping operators. The superoperator $J_i^s\rho + \rho\left(J_i^s\right)^\dagger$ describes the information gain from the $i$th measurement on the system and is proportional to the (white-) noise term $\xi_i(t)$. The function that implements this equation is very similar to [`timeevolution.master`](@ref).

```@example stochastic-master
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
J = [destroy(b)] # hide
Js = J # hide
tspan = [0,0.1] # hide
ρ0 = fockstate(b, 0) # hide
dt = 1e-1 # hide
stochastic.master(tspan, ρ0, H, J, Js; dt=dt)
nothing # hide
```

The only additional argument here is `Js`, which is a vector containing the stochastic damping operators $J_i^s$ which constitute the superoperator defined in the stochastic master equation above. Optionally, it is also possible to calculate a stochastic master equation where there are additional stochastic terms present in the Hamiltonian. This can be done by passing the optional argument `Hs` which is a vector containing all operators in the Hamiltonian that are proportional to a noise term to the function.

```@example stochastic-master
Hs = [H] # hide
stochastic.master(tspan, ρ0, H, J, Js; Hs=Hs, dt=dt)
nothing # hide
```

In principle, it is also possible to add stochastic terms to the standard Lindblad term. This is a rather special case, though, and so it is only implemented with the dynamic version of the stochastic master equation, [`stochastic.master_dynamic`](@ref).

Usage of the dynamic version is straightforward. One simply needs to define two functions for the deterministic and the stochastic part of the master equation, respectively.

```@example stochastic-master
Jdagger = dagger.(J) # hide
Jsdagger = dagger.(Js) # hide
function fdeterm(t, rho)
    # Calculate time-dependent stuff
    H, J, Jdagger
end

function fstoch(t, rho)
    # Calculate time-dependent stuff
    Js, Jsdagger
end
stochastic.master_dynamic(tspan, ρ0, fdeterm, fstoch; dt=dt)
nothing # hide
```

Note, that optionally one can include rates in the function output, `fdeterm(t, rho) = H, J, Jdagger, rates`, `fstoch(t, rho) = Js, Jsdagger, rates_s`. If one wants to include additional stochastic terms in the Hamiltonian, one can do this by defining another function and passing it as the optional argument `fstoch_H`.

```@example stochastic-master
function fstoch_H(t, rho)
    # Calculate time-dependent stuff
    Hs
end
nothing # hide
```

Here, `Hs` is again a vector of operators. Finally, one can also add some stochastic Lindblad terms to the equation by defining yet another function

```@example stochastic-master
Js_2, Js_2dagger = Js, Jsdagger # hide
function fstoch_J(t, rho)
    # Calculate time-dependent stuff
    Js_2, Js_2dagger
end
stochastic.master_dynamic(tspan, ρ0, fdeterm, fstoch; fstoch_H=fstoch_H, fstoch_J=fstoch_J, dt=dt)
nothing # hide
```

The last line in the above example corresponds to the calculation of a stochastic master equation that includes noise

- due to information gain by a measurement `fstoch`
- in the Hamiltonian `fstoch_H`
- in the Lindblad term `fstoch_J`

Like in the [`stochastic.schroedinger_dynamic`](@ref) function, if you want to avoid initial calculation of these functions in order to find the total number of noise processes, you can do so by passing the `noise_processes` keyword argument. Note, that `noise_processes` has to be equal to `length(Js) + length(Hs) + length(Js_2)` if all the functions are defined.

## [Functions](@id stochastic-master: Functions)

* [`stochastic.master`](@ref)
* [`stochastic.master_dynamic`](@ref)

## [Examples](@id stochastic-master: Examples)

* [Quantum Zeno Effect](@ref)
