using Documenter
using QuantumOptics

builddir = "build"
postprocessdir = "postbuild"
targetpath = "../QuantumOptics.jl-website/src/documentation"

pages = [
        "introduction.md",
        "installation.md",
        "tutorial.md",
        "Quantum objects" => [
            "Introduction" => "quantumobjects/quantumobjects.md",
            "quantumobjects/bases.md",
            "quantumobjects/states.md",
            "quantumobjects/operators.md"
            ],
        "Quantum systems" => [
            "Introduction" => "quantumsystems/quantumsystems.md",
            "quantumsystems/spin.md",
            "quantumsystems/fock.md",
            "quantumsystems/nlevel.md",
            "quantumsystems/particle.md",
            "quantumsystems/subspace.md",
            "quantumsystems/manybody.md"
        ],
        "Time-evolution" => [
            "Introduction" => "timeevolution/timeevolution.md",
            "Schrödinger equation" => "timeevolution/schroedinger.md",
            "Master equation" => "timeevolution/master.md",
            "Quantum trajectories" => "timeevolution/mcwf.md",
        ],
        "api.md"
    ]

makedocs(
    format=:html,
    build = builddir,
    sitename = "QuantumOptics.jl",
    pages = pages
    )

# Copy files to separate directory for post processing
cp(builddir, postprocessdir; remove_destination=true)

layout(name) = "---\nlayout: $name\n---\n\n"
extractbody(text) = text[last(search(text, "<body>"))+1:first(search(text, "</body>"))-1]

for (rootdir, dirs, files) in walkdir(postprocessdir)
    for file in files
        if endswith(file, ".html")
            println("Prefixing: ", file)
            path = joinpath(rootdir, file)
            text = readstring(path)
            text = extractbody(text)
            if file == "search.html"
                text = layout("documentation_search") * text
            else
                text = layout("documentation") * text
            end
            f = write(path, text)
        end
    end
end

# Copy finished documentation build to website
cp(postprocessdir, targetpath; remove_destination=true)
