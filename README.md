# QuantumOptics.jl documentation

The documentation is built using markdown files and [Documenter.jl](https://juliadocs.github.io/Documenter.jl) and includes resources from **QuantumOptics.jl** and **QuantumOptics.jl-examples**:

* Functions exported from **QuantumOptics.jl** are included in `api.md`.
* Examples from **QuantumOptics.jl-examples** are included in `src/examples`


## Directory layout

When building the documentation the only requirement is that the documentation and the website are in the same directory:

    |
    |--> ./QuantumOptics.jl-documentation/
    |--> ./QuantumOptics.jl-website/


## Software requirements

* [Documenter.jl](https://juliadocs.github.io/Documenter.jl) (Can be installed with `julia> Pkg.add("Documenter")`)


## Build process

* Make sure the correct version of **QuantumOptics.jl** is in the Julia searchpath.
* Build **QuantumOptics.jl-examples**. Output will automatically be copied into `src/examples`.
* Run `julia make.jl`. This will first generate the documentation as html files in the `build` directory. Then it will extract the html body of each site and add a jekyll *frontmatter*, which specifies the template that will be used by jekyll when building the documentation pages. The result of this process is stored in the the `postbuild` directory. Finally these files are also copied into `../QuantumOptics.jl-website/documentation`.
