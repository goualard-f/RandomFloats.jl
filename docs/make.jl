using Documenter
using RandomFloats
using RandomFloats.LCG.LCG32

DocMeta.setdocmeta!(RandomFloats, :DocTestSetup, :(using RandomFloats, RandomFloats.LCG.LCG32); recursive=true)

makedocs(
    sitename="The RandomFloats Documentation",
    authors = "Frédéric Goualard",
    modules = [RandomFloats, RandomFloats.LCG, RandomFloats.LCG.LCG32],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = ["Home" => "index.md"
             "A Guided Tour" => "guided-tour.md"
             "Manual" => "manual.md"
             "Developer Documentation" => "developer.md"
             ],
)

deploydocs(
    repo = "github.com/goualard-f/RandomFloats.jl.git",
    devbranch = "main",
)
