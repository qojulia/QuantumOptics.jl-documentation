# Two-time correlation functions


As a brief example, say we want to calculate the two-time correlation function of a cavity field, i.e. ``g(t) = \langle a(t) a^\dagger(0) \rangle``.
We can do this with:

```@example timecorrelations
using QuantumOptics # hide
basis = FockBasis(10)
a = destroy(basis)
κ = 1.0
η = 0.3
H = η*(a + dagger(a))
J = [sqrt(2κ)*a]
tspan = [0:0.1:10;]
ρ0 = fockstate(basis, 0) ⊗ dagger(fockstate(basis, 0))
g = timecorrelations.correlation(tspan, ρ0, H, J, dagger(a), a)
nothing # hide
```

If we omit the list of times `tspan`, the function automatically calculates the correlation until steady-state is reached:

```@example timecorrelations
t_s, g_s = timecorrelations.correlation(ρ0, H, J, dagger(a), a)
nothing # hide
```

To calculate the spectrum, we can either use the [`timecorrelations.correlation2spectrum`](@ref) to calculate it from a given correlation function, or alternatively, one can use [`timecorrelations.spectrum`](@ref), which calculates the correlation function internally and returns the Fourier transform.

## [Functions](@id timecorrelations: Functions)


* [`timecorrelations.correlation`](@ref)
* [`timecorrelations.spectrum`](@ref)
* [`timecorrelations.correlation2spectrum`](@ref)

## [Examples](@id timecorrelations: Examples)

* [Two-time correlation function and spectrum of a Fock state](@ref)
