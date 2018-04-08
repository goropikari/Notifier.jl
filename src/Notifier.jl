__precompile__()

module Notifier

is_linux() && include("linux.jl")
is_apple() && include("mac.jl")
is_windows() && include("windows.jl")

include("timer.jl")
end # module
