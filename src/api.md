# API


## API: Bases

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

### API: Composite bases

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

### API: Subspace bases

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


## API: States

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


## API: Operators

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

### API: DenseOperators

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

### API: SparseOperators

```@docs
SparseOperator
```

```@docs
sparse
```

### API: Lazy Operators

```@docs
LazyTensor
```

```@docs
LazySum
```

```@docs
LazyProduct
```


## API: Superoperators

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


## API: Random operators

```@docs
randstate
```

```@docs
randoperator
```


## API: Metrics

```@docs
tracedistance
```

```@docs
tracedistance_general
```

```@docs
entropy_vn
```


## API: Systems

### API: Fock

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

### API: N-level

```@docs
NLevelBasis
```

```@docs
transition
```

```@docs
nlevelstate
```

### API: Spin

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

### API: Particle

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

### API: Many-body

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


## API: Time-evolution

### API: Schroedinger

```@docs
timeevolution.schroedinger
```

```@docs
timeevolution.schroedinger_dynamic
```

### API: Master

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

### API: Monte Carlo wave function

```@docs
timeevolution.mcwf
```
```@docs
diagonaljumps
```


## API: Spectral analysis

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


## API: Steady-states

```@docs
steadystate.master
```

```@docs
steadystate.eigenvector
```


## API: Time correlations

```@docs
timecorrelations.correlation
```

```@docs
timecorrelations.spectrum
```

```@docs
timecorrelations.correlation2spectrum
```