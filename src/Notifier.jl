__precompile__()

module Notifier
using Compat
import Compat: Sys

Sys.islinux() && include("linux.jl")
Sys.isapple() && include("mac.jl")
Sys.iswindows() && include("windows.jl")

include("timer.jl")
end # module
