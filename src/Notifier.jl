module Notifier

using Pkg, Dates

import Base.notify
export notify

Sys.islinux() && include("linux.jl")
Sys.isapple() && include("mac.jl")
Sys.iswindows() && include("windows.jl")

include("timer.jl")
end # module
