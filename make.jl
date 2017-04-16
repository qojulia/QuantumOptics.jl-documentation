using Documenter
using QuantumOptics

# Makedocs otherwise creates an empty directory
rm("build"; recursive=true)

makedocs(
    format=:html,
    sitename = "QuantumOptics.jl",
    pages = [
        "introduction.md",
        "installation.md",
        "tutorial.md",
        "Quantum objects" => [
            "quantumobjects/bases.md",
            "quantumobjects/states.md",
            "quantumobjects/operators.md"
            ],
        "Quantum systems" => [
            "quantumsystems/spin.md",
            "quantumsystems/fock.md",
            "quantumsystems/nlevel.md",
            "quantumsystems/particle.md",
            "quantumsystems/subspace.md",
            "quantumsystems/manybody.md"
        ],
        "timeevolution/schroedinger.md"
    ]
    )

JEKYLL_STRING = """---
layout: default
---

"""

for (rootdir, dirs, files) in walkdir("build")
    for file in files
        if endswith(file, ".html")
            println("Prefixing: ", file)
            path = joinpath(rootdir, file)
            text = readstring(path)
            text = text[last(search(text, "<body>"))+1:first(search(text, "</body>"))-1]
            text = replace(text, ".md#", "#")
            text = JEKYLL_STRING * text
            f = write(path, text)
        end
    end
end

targetpath = "../QuantumOptics.jl-website/src/documentation"

cp("build", targetpath; remove_destination=true)
