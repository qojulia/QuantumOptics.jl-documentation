# QuantumOptics.jl documentation

The documentation is built using markdown files and **Documenter.jl** and includes resources from **QuantumOptics.jl** and **QuantumOptics.jl-examples**:

* Functions exported from **QuantumOptics.jl** are included in `api.md`.
* Examples from **QuantumOptics.jl-examples** are included in `src/examples`


## Directory layout

When building the documentation the only requirement is that the documentation and the website are in the same directory:

    |
    |--> ./QuantumOptics.jl-documentation/
    |--> ./QuantumOptics.jl-website/


## Software requirements

* **Documenter.jl** (Can be installed with `julia> Pkg.add("Documenter")`)


## Build process

* Make sure the correct version of **QuantumOptics.jl** is in the Julia searchpath.
* Build **QuantumOptics.jl-examples**. Output will automatically be copied into `src/examples`.
* Run `julia make.jl`. This will generate the documentation as html files in the `build` directory, apply a few changes necessary for the website and copy these edited files into `postbuild` directory. Finally these files are also copied into `../QuantumOptics.jl-website/documentation`.
