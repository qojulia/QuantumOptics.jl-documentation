using Documenter
using QuantumOptics
using QuantumOpticsBase

builddir = "build"

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
            "Doppler cooling" => "examples/doppler-cooling.md",
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
    modules = [QuantumOptics, QuantumOpticsBase],
    checkdocs = :exports,
    format=Documenter.HTML(
        edit_link = nothing,
        canonical = "https://docs.qojulia.org/",
        assets = [ asset("assets/favicon.png", class=:ico, islocal = true) ]),
    build = builddir,
    sitename = "QuantumOptics.jl",
    pages = pages
    )
    

