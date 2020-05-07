# QuantumOptics.jl documentation

This is the source repository for the documentation. You can find an already built version of the documentation at https://docs.qojulia.org/. The documentation is built using markdown files and [Documenter.jl](https://juliadocs.github.io/Documenter.jl) and includes resources from **QuantumOptics.jl** and **QuantumOptics.jl-examples**:

* Functions exported from **QuantumOptics.jl** are included in `api.md`.
* Examples from **QuantumOptics.jl-examples** are included in `src/examples`


## Directory layout

When building the documentation the only requirement is that the notebooks from the examples repo have been executed and copied over by make.jl from the examples directory.
    |
    |--> ./QuantumOptics.jl-documentation/
    |


## Software requirements

* [Documenter.jl](https://juliadocs.github.io/Documenter.jl) (Can be installed with `julia> Pkg.add("Documenter")`)


## Build process

* Make sure the correct version of **QuantumOptics.jl** is in the Julia searchpath.
* Build **QuantumOptics.jl-examples**. Output will automatically be copied into `src/examples`.
* Run `julia make.jl`. This will generate the documentation in the build directory.