using Documenter
using QuantumOptics

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
        "Examples" => [
            "Pumped cavity" => "examples/pumped-cavity.md",
            "Jaynes-Cummings" => "examples/jaynes-cummings.md",
            "Particle in harmonic trap" => "examples/particle-in-harmonic-trap.md",
            "Particle into barrier" => "examples/particle-into-barrier.md",
            "Raman transition" => "examples/raman.md",
            "2 qubit entanglement" => "examples/two-qubit-entanglement.md",
            "Correlation spectrum" => "examples/correlation-spectrum.md",
            "Simple many-body system" => "examples/manybody-fourlevel-system.md",
            "N particles in double well" => "examples/nparticles-in-double-well.md",
			"Doppler cooling" => "examples/doppler-cooling.md",
        ],
        "api.md",
    ]

makedocs(
    modules = [QuantumOptics],
    checkdocs = :exports,
    format=:html,
    build = builddir,
    sitename = "QuantumOptics.jl",
    pages = pages
    )

# Copy files to separate directory for post processing
cp(builddir, postprocessdir; remove_destination=true)

layout(search) = "---\nlayout: default\ntype: documentation\nsearch: $search\n---\n\n"
extractbody(text) = text[last(search(text, "<body>"))+1:first(search(text, "</body>"))-1]

for (rootdir, dirs, files) in walkdir(postprocessdir)
    for file in files
        if endswith(file, ".html")
            println("Prefixing: ", file)
            path = joinpath(rootdir, file)
            text = readstring(path)
            text = extractbody(text)
            if file == "search.html"
                text = layout("true") * text
            else
                text = layout("false") * text
            end
            f = write(path, text)
        end
    end
end

# Copy finished documentation build to website
cp(postprocessdir, targetpath; remove_destination=true)
