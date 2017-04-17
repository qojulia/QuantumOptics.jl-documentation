# Particle

```@example particle
using QuantumOptics # hide
xmin = -2.
xmax = 4.
N = 10
b_position = PositionBasis(xmin, xmax, N)
b_momentum = MomentumBasis(b_position)

x0 = 1.2
p0 = 0.4
sigma = 0.2
psi = gaussianstate(b_position, x0, p0, sigma)

x = position(b_position)
p = momentum(b_position)
nothing # hide
```

For particles **QuantumOptics.jl** provides two different choices - either the calculations can be done in real space or they can be done in momentum space by using [`PositionBasis`](@ref) r [`MomentumBasis`](@ref) espectively. The definition of these two bases types is:

```julia
type PositionBasis <: Basis
    shape::Vector{Int}
    xmin::Float64
    xmax::Float64
    N::Int
end

type MomentumBasis <: Basis
    shape::Vector{Int}
    pmin::Float64
    pmax::Float64
    N::Int
end
```

Since real space and momentum space are connected via a Fourier transformation the bases themselfes are connected. The numerically inevitable cutoff implies that the functions :math:`\Psi(x)` and :math:`\Psi(p)` can be interpreted to continue periodically over the whole real axis. The specific choice of the cutoff points is therefore irrelevant as long as the interval length stays the same. This free choice of cutoff points allows to easily create a corresponding [`MomentumBasis`](@ref) rom a [`PositionBasis`](@ref) nd vice versa:

```@example particle
b_momentum = MomentumBasis(b_position)
b_position = PositionBasis(b_momentum)
nothing # hide
```

When creating a momentum basis from a position basis the cutoff points are connected by ``p_\mathrm{min} = -\pi/dx`` and ``p_\mathrm{max} = \pi/dx`` where ``dx = (x_\mathrm{max} - x_\mathrm{min})/N``. Similarly for the inverse procedure the cutoffs are ``x_\mathrm{min} = -\pi/dp`` and ``x_\mathrm{max} = \pi/dp`` with ``dp = (p_\mathrm{max} - p_\mathrm{min})/N``.


## [States](@id particle: States)

* [`gaussianstate`](@ref)


## [Operators](@id particle: Operators)

All operators are defined for the position basis as well as for the momentum basis.

* [`momentum`](@ref)
* [`position`](@ref)

Transforming a state from one basis into another can be done efficiently using the [`FFTOperator`](@ref):

    Tpx = FFTOperator(basis_momentum, basis_position)
    Psi_p = Tpx*Psi_x


## [Additional functions](@id particle: Additional functions)

* [`particle.spacing`](@ref)
* [`samplepoints`](@ref)


## [Examples](@id particle: Examples)

* [Particle in harmonic trap potential](@ref)
* [Gaussian wave packet running into a potential barrier](@ref)
* [N-Particles in a double-well potential](@ref)
