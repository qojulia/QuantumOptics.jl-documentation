# API


## [Quantum-objects](@id API: Quantum objects)

### [Types](@id API: Quantum objects types)

* General basis types. Specialized bases can be found in the section [API: Quantum-systems](@ref).

```@docs
Basis
```

```@docs
GenericBasis
```

```@docs
CompositeBasis
```

* States

```@docs
StateVector
```

```@docs
Bra
```

```@docs
Ket
```

* General purpose operators. A few more specialized operators are implemented in [API: Quantum-systems](@ref).

```@docs
AbstractOperator
```

```@docs
DataOperator
```

```@docs
DenseOperator
```

```@docs
SparseOperator
```

```@docs
LazyTensor
```

```@docs
LazySum
```

```@docs
LazyProduct
```


* Super operators:

```@docs
SuperOperator
```

```@docs
DenseSuperOperator
```

```@docs
SparseSuperOperator
```


### [Functions](@id API: Quantum objects functions)

* Functions to generate general states, operators and super-operators

```@docs
basisstate
```

```@docs
identityoperator
```

```@docs
diagonaloperator
```

```@docs
randoperator
```

```@docs
spre
```

```@docs
spost
```

```@docs
liouvillian
```

* As far as it makes sense the same functions are implemented for bases, states, operators and superoperators.

```@docs
bases.samebases
```

```@docs
bases.check_samebases
```

```@docs
bases.multiplicable
```

```@docs
bases.check_multiplicable
```

```@docs
bases.basis
```

```@docs
dagger
```

```@docs
tensor
```

```@docs
projector(a::Ket, b::Bra)
projector(a::Ket)
projector(a::Bra)
```

```@docs
dm
```

```@docs
states.norm(x::StateVector)
```

```@docs
tr
```

```@docs
ptrace
```

```@docs
normalize(x::StateVector)
normalize(op::AbstractOperator)
```

```@docs
normalize!(x::StateVector)
normalize!(op::AbstractOperator)
```

```@docs
expect
```

```@docs
variance
```

```@docs
embed
```

```@docs
permutesystems
```

```@docs
exp(op::AbstractOperator)
exp(op::DenseSuperOperator)
```

```@docs
operators.gemv!
```

```@docs
operators.gemm!
```

* Conversion of operators

```@docs
dense
```

```@docs
sparse(::AbstractOperator)
```

### [Exceptions](@id API: Quantum objects exceptions)

```@docs
bases.IncompatibleBases
```


## [Quantum systems](@id API: Quantum systems)

### [Fock](@id API: Fock)

```@docs
FockBasis
```

```@docs
number(::FockBasis)
```

```@docs
destroy(::FockBasis)
```

```@docs
create(::FockBasis)
```

```@docs
displace
```

```@docs
fockstate
```

```@docs
coherentstate
```


### [Phase space](@id API: Phase space)

```@docs
qfunc
```

```@docs
wigner
```

```@docs
coherentspinstate
```

```@docs
qfuncsu2
```

```@docs
wignersu2
```

```@docs
ylm
```

### [N-level](@id API: N-level)

```@docs
NLevelBasis
```

```@docs
transition(::NLevelBasis, ::Int, ::Int)
```

```@docs
nlevelstate
```

### [Spin](@id API: Spin)

```@docs
SpinBasis
```

```@docs
sigmax
```

```@docs
sigmay
```

```@docs
sigmaz
```

```@docs
sigmap
```

```@docs
sigmam
```

```@docs
spinup
```

```@docs
spindown
```

### [Particle](@id API: Particle)

```@docs
PositionBasis
```

```@docs
MomentumBasis
```

```@docs
particle.spacing
```

```@docs
samplepoints
```

```@docs
position(b::PositionBasis)
position(b::MomentumBasis)
```

```@docs
momentum(b::PositionBasis)
momentum(b::MomentumBasis)
```

```@docs
potentialoperator
```

```@docs
gaussianstate
```

```@docs
particle.FFTOperator
```

```@docs
particle.FFTOperators
```

```@docs
particle.FFTKets
```

```@docs
transform
```

### [Subspace bases](@id API: Subspace bases)

```@docs
SubspaceBasis
```

```@docs
subspace.orthonormalize
```

```@docs
projector(b1::SubspaceBasis, b2::SubspaceBasis)
```

### [Many-body](@id API: Many-body)

```@docs
ManyBodyBasis
```

```@docs
fermionstates
```

```@docs
bosonstates
```

```@docs
number(::ManyBodyBasis, ::Int)
number(::ManyBodyBasis)
```

```@docs
destroy(::ManyBodyBasis, ::Int)
```

```@docs
create(::ManyBodyBasis, ::Int)
```

```@docs
manybodyoperator
```

```@docs
onebodyexpect
```


## [Metrics](@id API: Metrics)

```@docs
tracenorm
```

```@docs
tracenorm_h
```

```@docs
tracenorm_nh
```

```@docs
tracedistance
```

```@docs
tracedistance_h
```

```@docs
tracedistance_nh
```

```@docs
entropy_vn
```

```@docs
fidelity
```

```@docs
ptranspose
```

```@docs
PPT
```

```@docs
negativity
```

```@docs
logarithmic_negativity
```


## [Time-evolution](@id API: Time-evolution)

### [Schroedinger](@id API: Schroedinger)

```@docs
timeevolution.schroedinger
```

```@docs
timeevolution.schroedinger_dynamic
```

### [Master](@id API: Master)

```@docs
timeevolution.master
```

```@docs
timeevolution.master_h
```

```@docs
timeevolution.master_nh
```

```@docs
timeevolution.master_dynamic
```

```@docs
timeevolution.master_nh_dynamic
```

```@docs
timeevolution.@skiptimechecks
```

### [Monte Carlo wave function](@id API: Monte Carlo wave function)

```@docs
timeevolution.mcwf
```

```@docs
timeevolution.mcwf_h
```

```@docs
timeevolution.mcwf_nh
```

```@docs
timeevolution.mcwf_dynamic
```

```@docs
timeevolution.mcwf_nh_dynamic
```

```@docs
diagonaljumps
```


## [Spectral analysis](@id API: Spectral analysis)

```@docs
eigenstates
```

```@docs
eigenenergies
```

```@docs
simdiag
```


## [Steady-states](@id API: Steady-states)

```@docs
steadystate.master
```

```@docs
steadystate.eigenvector
```

```@docs
steadystate.liouvillianspectrum
```


## [Time correlations](@id API: Time correlations)

```@docs
timecorrelations.correlation
```

```@docs
timecorrelations.spectrum
```

```@docs
timecorrelations.correlation2spectrum
```


## [Semi-classical](@id API: Semi-classical systems)

```@docs
semiclassical.State
```

```@docs
semiclassical.schroedinger_dynamic
```

```@docs
semiclassical.master_dynamic
```

## [Stochastics](@id API: Stochastics)

```@docs
stochastic.schroedinger
```

```@docs
stochastic.schroedinger_dynamic
```

```@docs
stochastic.homodyne_carmichael
```

```@docs
stochastic.master
```

```@docs
stochastic.master_dynamic
```

```@docs
stochastic.schroedinger_semiclassical
```

```@docs
stochastic.master_semiclassical
```

## [State definitions](@id API: State definitions)

```@docs
randstate
```

```@docs
thermalstate
```

```@docs
coherentthermalstate
```

```@docs
phase_average
```

```@docs
passive_state
```

## [Printing](@id API: Printing)

```@docs
QuantumOptics.set_printing
```
