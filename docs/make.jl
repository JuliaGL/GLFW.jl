import GLFW
using Documenter

makedocs(;
    modules=[GLFW],
    authors="Jay Petacat <jay@jayschwa.net> and Simon Danisch <sdanisch@gmail.com>",
    sitename="GLFW.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://juliagl.github.io/GLFW.jl",
        assets=String[],
        size_threshold=400000
    ),
    pages=[
        "Introduction" => "index.md",
        "API Reference" => "api.md"
    ]
)

deploydocs(;
    repo="github.com/JuliaGL/GLFW.jl.git",
)
