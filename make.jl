using Documenter
using QuantumOptics
using QuantumOpticsBase

builddir = "build"
postprocessdir = "postbuild"
targetpath = "../QuantumOptics.jl-website/src/documentation"

@assert !isdir(basename(targetpath))
if !isdir(targetpath)
    println("Creating documentation output directory at \"", targetpath, "\"")
    mkdir(targetpath)
end

pages = [
        "index.md",
        "installation.md",
        "tutorial.md",
        "Quantum objects" => [
            "Introduction" => "quantumobjects/quantumobjects.md",
            "quantumobjects/bases.md",
            "quantumobjects/states.md",
            "quantumobjects/operators.md",
            ],
        "Quantum systems" => [
            "Introduction" => "quantumsystems/quantumsystems.md",
            "quantumsystems/spin.md",
            "quantumsystems/fock.md",
            "quantumsystems/nlevel.md",
            "quantumsystems/particle.md",
            "quantumsystems/subspace.md",
            "quantumsystems/manybody.md",
        ],
        "Time-evolution" => [
            "Introduction" => "timeevolution/timeevolution.md",
            "Schrödinger equation" => "timeevolution/schroedinger.md",
            "Master equation" => "timeevolution/master.md",
            "Quantum trajectories" => "timeevolution/mcwf.md",
        ],
        "metrics.md",
        "steadystate.md",
        "timecorrelations.md",
        "semiclassical.md",
        "Stochastics" => [
            "Introduction" => "stochastic/stochastic.md",
            "Stochastic Schrödinger equation" => "stochastic/schroedinger.md",
            "Stochastic Master equation" => "stochastic/master.md",
            "Stochastic semiclassical systems" => "stochastic/semiclassical.md",
        ],
        "Examples" => [
            "Pumped cavity" => "examples/pumped-cavity.md",
            "Jaynes-Cummings" => "examples/jaynes-cummings.md",
            "Superradiant laser" => "examples/superradiant-laser.md",
            "Particle in harmonic trap" => "examples/particle-in-harmonic-trap.md",
            "Particle into barrier" => "examples/particle-into-barrier.md",
            "Wavepacket in 2D" => "examples/wavepacket2D.md",
            "Raman transition" => "examples/raman.md",
            "2 qubit entanglement" => "examples/two-qubit-entanglement.md",
            "Correlation spectrum" => "examples/correlation-spectrum.md",
            "Simple many-body system" => "examples/manybody-fourlevel-system.md",
            "N particles in double well" => "examples/nparticles-in-double-well.md",
            "Cavity cooling" => "examples/cavity-cooling.md",
            "Lasing and cooling" => "examples/lasing-and-cooling.md",
            "Optomechanical cavity" => "examples/optomech-cooling.md",
            "Ramsey spectroscopy" => "examples/ramsey.md",
            "Dephasing of Atom" => "examples/atom-dephasing.md",
            "Quantum Zeno Effect" => "examples/quantum-zeno-effect.md",
            "Quantum Kicked Top" => "examples/quantum-kicked-top.md"
        ],
        "api.md",
    ]

makedocs(
    modules = [QuantumOptics,QuantumOpticsBase],
    checkdocs = :exports,
    format=Documenter.HTML(),
    build = builddir,
    sitename = "QuantumOptics.jl",
    pages = pages
    )

# Copy files to separate directory for post processing
cp(builddir, postprocessdir; force=true)

layout(search) = "---\nlayout: default\ntype: documentation\nsearch: $search\n---\n\n"
extractbody(text) = text[last(findfirst("<body>", text))+1:first(findfirst("</body>", text))-1]

for (rootdir, dirs, files) in walkdir(postprocessdir)
    for file in files
        if endswith(file, ".html")
            println("Prefixing: ", file)
            path = joinpath(rootdir, file)
            text = read(path, String)
            text = extractbody(text)
            if occursin("search", rootdir)
                text_ = layout("true") * text
            else
                text_ = layout("false") * text
            end
            write(path, text_)
        end
    end
end

# Remove body font-size from css file
path = joinpath(postprocessdir, "assets/documenter.css")
text = read(path, String)
i0 = first(findfirst("body", text))
i0 += first(findfirst("font-size", text[i0:end])) - 1
i0 = last(findlast("\n", text[1:i0]))
i1 = first(findfirst("\n", text[i0+1:end])) + i0

write(path, text[1:i0-1]*text[i1:end])

# Copy finished documentation build to website
cp(postprocessdir, targetpath; force=true)
