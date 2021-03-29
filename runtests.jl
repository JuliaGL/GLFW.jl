# Needing this file is a bit unfortunate,
# but seeing https://github.com/GabrielBB/xvfb-action/issues/3
# makes me loose all hope to get the string interpolation right :D
using Pkg; Pkg.test(coverage=true)
