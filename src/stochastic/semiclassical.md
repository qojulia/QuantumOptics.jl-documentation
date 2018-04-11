# Stochastic semi-classical systems

In addition to the stochastic Schrödinger and master equations, an implementation for semi-classical systems that are subject to noise is also available. In general, the functions [`stochastic.schroedinger_semiclassical`](@ref) and [`stochastic.master_semiclassical`](@ref) are written to handle time-dependent semi-classical problems including stochastic processes of any kind. From the point of view of syntax, they are very similar to the semi-classical implementations (see [Semi-classical systems](@ref))

## Semi-classical stochastic Schrödinger equation

To solve semi-classical problems, the functions `fquantum(t, psi, u)` and `fclassical(t, psi, u, du)` need to be passed to the solver. Here, `psi` is the quantum part of a [`semiclassical.State`](@ref), `u` its classical part and `du` the derivative of the classical part. Now, in order to solve a semi-classical equation that is subject to noise, one (or both) of two optional functions needs to be passed to [`stochastic.schroedinger_semiclassical`](@ref). The corresponding keyword arguments are `fstoch_quantum` and `fstoch_classical` that are of the same form as `fquantum` and `fclassical`, respectively.

```@example stochastic-semiclassical
using QuantumOptics # hide
b = FockBasis(2) # hide
H = number(b) # hide
Hs = [H] # hide
tspan = [0,0.1] # hide
ψ0 = semiclassical.State(fockstate(b, 0), [0.0im, 0.0im]) # hide
fquantum_schroedinger(t, psi, u) = H # hide
fclassical_schroedinger(t, psi, u, du) = du # hide
function fstoch_q_schroedinger(t, psi, u)
    # Calculate time-dependent stuff
    Hs
end

function fstoch_c_schroedinger(t, psi, u, du)
    # Calculate classical stochastic stuff
    du[1] = -u[2] # some example
    du[2] = u[1]
end

stochastic.schroedinger_semiclassical(tspan, ψ0, fquantum_schroedinger, fclassical_schroedinger;
fstoch_quantum=fstoch_q_schroedinger, fstoch_classical=fstoch_c_schroedinger)
nothing # hide
```

Note, that here `ψ0` needs to be a [`semiclassical.State`](@ref). If one of the functions is omitted, then the semi-classical problem is solved where noise is only present in the quantum or classical part, respectively. Once again, it is possible to avoid initial calculation of the function `fquantum_stoch` to obtain the length of `Hs` by defining `noise_processes`. This number has to be equal to the length of `Hs`. If `fstoch_classical` is given then add `1` to the number. Note, that internally the function also only checks whether `fstoch_classical` is given and adds `1` to the number of noise processes. So `fstoch_classical` is never evaluated before the actual time evolution.

## Semi-classical stochastic master equation

Implementing a semi-classical stochastic master equation works similarly to above. The output of the functions needs to be altered in order to return the jump operators needed for the Lindblad and measurement superoperator, respectively.

```@example stochastic-semiclassical
J = [destroy(b)] # hide
Jdagger = dagger.(J) # hide
Js = J # hide
Jsdagger = Jdagger # hide
ρ0 = ψ0 # hide
fquantum_master(t, psi, u) = H, J, Jdagger # hide
fclassical_master(t, psi, u, du) = du # hide
function fstoch_q_master(t, psi, u)
    # Calculate time-dependent stuff
    Js, Jsdagger
end

function fstoch_c_master(t, psi, u, du)
    # Calculate classical stochastic stuff
    du[1] = -u[2] # some example
    du[2] = u[1]
end

stochastic.master_semiclassical(tspan, ρ0, fquantum_master, fclassical_master;
fstoch_quantum=fstoch_q_master, fstoch_classical=fstoch_c_master)
nothing # hide
```

Note, that the operators returned by `fstoch_q_master` are cast in the form of a measurement superoperator in a stochastic master equation. Again, if one of the functions is omitted, the semi-classical time evolution is calculated where noise is only present in the part for which the respective function is defined.

In addition to the noise in the measurement superoperator and the classical noise you can also define additional functions `fstoch_H(t, rho, u)` and `fstoch_J(t, rho, u)` that correspond to stochastic terms in the Hamiltonian and stochastic Lindblad processes as in [`stochastic.master_dynamic`](@ref).

```@example stochastic-semiclassical
fstoch_H(t, rho, u) = Hs # hide
fstoch_J(t, rho, u) = J, Jdagger # hide
stochastic.master_semiclassical(tspan, ρ0, fquantum_master, fclassical_master;
fstoch_quantum=fstoch_q_master,
fstoch_classical=fstoch_c_master, fstoch_H=fstoch_H, fstoch_J=fstoch_J)
nothing # hide
```

Executing the above command with the proper definitions for `fstoch_H` and `fstoch_J`, one effectively calculates a semi-classical time evolution with noise

- due to a measurement superoperator `fstoch_quantum`
- in the classical part `fstoch_classical`
- in the Hamiltonian `fstoch_H`
- in a Lindblad term `fstoch_J`


## [Functions](@id stochastic-semiclassical: Functions)

* [`stochastic.schroedinger_semiclassical`](@ref)
* [`stochastic.master_semiclassical`](@ref)
