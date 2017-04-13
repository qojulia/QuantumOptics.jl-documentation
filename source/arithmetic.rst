.. _section-arithmetic:

Arithmetic
==========

Operators:

* DenseOperator
* SparseOperator
* IdentityOperator
* LazyTensor
* LazySum
* LazyProduct

-------- -------- -------- -------- --------
   +     Number   Dense    Sparse   Id
-------- -------- -------- -------- --------
Number   Number   X        X        X
Dense    X        Dense    Dense    Dense
Sparse   X        Dense    Sparse   Sparse
Id       X        Dense    Sparse   Sparse
-------- -------- -------- -------- --------

-------- -------- -------- -------- -------- -------- -------- --------
   ⊗     Number   Dense    Sparse   Id       LTensor  LSum     LProduct
-------- -------- -------- -------- -------- -------- -------- --------
Number   X        X        X        X        X        X        X
Dense    X        Dense    X        Dense    LSum     LSum     LSum
Sparse   X        X        Sparse   Sparse   LSum     LSum     LSum
Id       X        Dense    Sparse   Sparse   LSum     LSum     LSum
LTensor  X        LTensor     LSum     LSum     LSum     LSum     LSum
LSum     X        LSum     LSum     LSum     LSum     LSum     LSum
LProduct X        LSum     LSum     LSum     LSum     LSum     LSum
-------- -------- -------- -------- -------- -------- -------- --------

