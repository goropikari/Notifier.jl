using Notifier
import Compat: Sys
@static if VERSION < v"0.7.0-DEV.5222"
    using Base.Test
else
    using Test
end

# write your own tests here
if Sys.islinux()
    include("linux_test.jl")
end
if Sys.isapple()
    include("mac_test.jl")
end
if Sys.iswindows()
    include("windows_test.jl")
end

include("timer_test.jl")
