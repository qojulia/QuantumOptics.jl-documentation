using Documenter
using QuantumOptics

# Makedocs otherwise creates an empty directory
rm("build"; recursive=true)

makedocs()