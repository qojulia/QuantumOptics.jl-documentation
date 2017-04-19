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
Operator
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
randstate
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
bases.multiplicable
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
states.norm(x::StateVector)
```

```@docs
trace
```

```@docs
ptrace
```

```@docs
normalize(x::StateVector)
normalize(op::Operator)
```

```@docs
normalize!(x::StateVector)
normalize!(op::Operator)
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
expm(op::Operator)
expm(op::DenseSuperOperator)
```

```@docs
operators.gemv!
```

```@docs
operators.gemm!
```

* Conversion of operators

```@docs
full(::Operator)
```

```@docs
sparse(::Operator)
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

```@docs
qfunc
```

### [N-level](@id API: N-level)

```@docs
NLevelBasis
```

```@docs
transition
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
gaussianstate
```

```@docs
particle.FFTOperator
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


## [Metrics](@id API: Metrics)

```@docs
tracenorm
```

```@docs
tracedistance
```

```@docs
tracenorm_general
```

```@docs
tracedistance_general
```

```@docs
entropy_vn
```

```@docs
fidelity
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
diagonaljumps
```


## [Spectral analysis](@id API: Spectral analysis)

```@docs
eig(::DenseOperator)
```

```@docs
eigs(::SparseOperator, args...)
```

```@docs
eigvals(::DenseOperator)
```

```@docs
eigvals!(::DenseOperator)
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