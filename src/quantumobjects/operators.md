# Operators

Operators can be defined as linear maps from one Hilbert space to another. However, equivalently to states, operators in **QuantumOptics.jl** are interpreted as coefficients of an abstract operator in respect to one or more generally two, possibly distinct [Bases](bases.md @ref). For a certain choice of bases ``\{|u_i\rangle\}_i`` and ``\{|v_j\rangle\}_j`` an abstract operator ``A`` has the coefficients ``A_{ij}`` which are connected by the relation

```math
A =  \sum_{ij} A_{ij} | u_i \rangle \langle v_j |
```

For this reason all operators define a left hand as well as a right hand basis:

```@example operators
using QuantumOptics # hide
type MyOperator <: Operator
    basis_l::Basis
    basis_r::Basis
    # ...
end
```

For performance reasons there are several different implementations of operators in **QuantumOptics.jl**, all inheriting from the abstract [`Operator`](@ref) type:

* [Dense operators](@ref)
* [Sparse operators](@ref)
* [Lazy operators](@ref)

They have the same interface and can in most cases be used interchangeably, e.g. they can be combined using arithmetic functions *, /, +, -:

```@example operators
b = SpinBasis(1//2)
sx = sigmax(b)
sy = sigmay(b)
sx + sy
sx * sy
nothing # hide
```

Additionally, the following functions are implemented for all types of operators, if possible:

* [`dagger`](@ref)
* [`identityoperator`](@ref)
* [`trace`](@ref)
* [`normalize`](@ref)
* [`normalize!`](@ref)
* [`expect`](@ref)
* [`variance`](@ref)
* [`tensor`](@ref)
* [`permutesystems`](@ref)
* [`embed`](@ref)
* [`ptrace`](@ref)
* [`expm`](@ref)

Conversion from one type of operator to another is also provided. I.e. to obtain a [`DenseOperator`](@ref) or [`SparseOperator`](@ref) use the [`full`](@ref) and [`sparse`](@ref) functions, respectively.


## Dense operators

[`DenseOperator`](@ref) is the default type used for density operators. I.e. creating an operator by using the tensor product of a ket and a bra state results in a [`DenseOperator`](@ref). It is implemented as:

```julia
type DenseOperator <: Operator
    basis_l::Basis
    basis_r::Basis
    data::Matrix{Complex128}
end
```

where the data is stored as complex (dense) matrix in the `data` field.

The [`full(::Operator)`](@ref) function can be used to convert other types of operators to dense operators.


## Sparse operators

[`SparseOperator`](@ref) is the default type used in **QuantumOptics.jl**. The reason is that in many quantum systems the Hamiltonians and jump operators in respect to the commonly used bases are sparse. They are implemented as:

```julia
type SparseOperator <: Operator
    basis_l::Basis
    basis_r::Basis
    data::SparseMatrixCSC{Complex128}
end
```
To convert other operators to sparse operators the [`sparse(::Operator)`](@ref) function can be used.


## Lazy operators

Lazy operators allow delayed evaluation of certain operations. This is useful when combining two operators is numerically expensive but separate multiplication with states is relatively cheap. A nice example is the [`transform`](@ref) implemented for particles. It allows using a fast fourier transformation to convert a state from real space to momentum space, applying a diagonal operator and converting it back. Doing this in operator notation is only fast if the the order of operations is ``\mathrm{IFFT}*(D*(\mathrm{FFT}*\psi))``. To create a Hamiltonian that uses this calculation order, lazy evaluation is needed:

```@example operators
xmin = -5
xmax = 5
Npoints = 100
b_position = PositionBasis(xmin, xmax, Npoints)
b_momentum = MomentumBasis(b_position)

p = momentum(b_momentum)
x = position(b_position)

Tpx = transform(b_momentum, b_position);
Txp = dagger(Tpx)

H_kin = LazyProduct(Txp, p^2/2, Tpx)
H_pot = x^2
H = LazySum(H_kin, H_pot)
nothing # hide
```

In this case the Hamiltonian ``H`` is a lazy sum of the kinetic term ``p^2/2`` and the potential term ``x^2`` where the kinetic term is the lazy product mentioned before. In the end this results in a speed up from ``O(N^2)`` to ``O(N \log N)``.

There are currently three different concrete implementations:

* [`LazyTensor`](@ref)
* [`LazySum`](@ref)
* [`LazyProduct`](@ref)
