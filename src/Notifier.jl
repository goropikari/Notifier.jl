__precompile__()

module Notifier

if is_linux() include("linux.jl") end
if is_apple() include("mac.jl") end
# if is_windows() include("windows.jl") end

end # module
