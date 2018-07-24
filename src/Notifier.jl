__precompile__()

module Notifier
using Compat
import Compat: Sys

@static if VERSION >= v"0.7.0-DEV"
    using Pkg, Dates
end

import Base.notify
export notify

Sys.islinux() && include("linux.jl")
Sys.isapple() && include("mac.jl")
Sys.iswindows() && include("windows.jl")

include("timer.jl")
end # module
