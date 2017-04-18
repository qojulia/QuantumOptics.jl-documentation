# API


## [Bases](@id API: Bases)

```@docs
Basis
```

```@docs
GenericBasis
```

```@docs
length
```

```@docs
bases.multiplicable
```

### [Composite bases](@id API: Composite bases)

```@docs
CompositeBasis
```

```@docs
tensor
```

```@docs
ptrace
```

```@docs
permutesystems
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
projector(b1::Basis, b2::SubspaceBasis)
projector(b1::SubspaceBasis, b2::Basis)
```


## [States](@id API: States)

```@docs
StateVector
```

```@docs
Bra
```

```@docs
Ket
```

```@docs
tensor{T<:StateVector}(a::T, b::T)
```

```@docs
tensor(::Ket, ::Bra)
```

```@docs
dagger(x::Bra)
dagger(x::Ket)
```

```@docs
states.norm(x::StateVector)
```

```@docs
states.normalize(x::StateVector)
```

```@docs
states.normalize!(x::StateVector)
```

```@docs
basisstate
```


## [Operators](@id API: Operators)

```@docs
Operator
```

```@docs
dagger(a::Operator)
```

```@docs
identityoperator
```

```@docs
trace(x::Operator)
```

```@docs
ptrace(a::Operator, index::Vector{Int})
```

```@docs
normalize(op::Operator)
```

```@docs
normalize!(op::Operator)
```

```@docs
expect
```

```@docs
variance
```

```@docs
tensor(a::Operator, b::Operator)
```

```@docs
embed
```

```@docs
permutesystems(a::Operator, perm::Vector{Int})
```

```@docs
expm(op::Operator)
```

```@docs
operators.gemv!
```

```@docs
operators.gemm!
```

### [DenseOperators](@id API: DenseOperators)

```@docs
DenseOperator
```

```@docs
full
```

```@docs
projector(a::Ket, b::Bra)
projector(a::Ket)
projector(a::Bra)
```

### [SparseOperators](@id API: SparseOperators)

```@docs
SparseOperator
```

```@docs
sparse
```

### [Lazy Operators](@id API: Lazy Operators)

```@docs
LazyTensor
```

```@docs
LazySum
```

```@docs
LazyProduct
```


## [Superoperators](@id API: Superoperators)

```@docs
superoperators.SuperOperator
```

```@docs
DenseSuperOperator
```

```@docs
SparseSuperOperator
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

```@docs
expm(op::DenseSuperOperator)
```


## [Random operators](@id API: Random operators)

```@docs
randstate
```

```@docs
randoperator
```


## [Metrics](@id API: Metrics)

```@docs
tracedistance
```

```@docs
tracedistance_general
```

```@docs
entropy_vn
```


## [Systems](@id API: Systems)

### [Fock](@id API: Fock)

```@docs
FockBasis
```

```@docs
number
```

```@docs
destroy
```

```@docs
create
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
position
```

```@docs
momentum
```

```@docs
gaussianstate
```

```@docs
particle.FFTOperator(::MomentumBasis, ::PositionBasis)
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
manybodyoperator
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
eig
```

```@docs
eigs
```

```@docs
eigvals
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