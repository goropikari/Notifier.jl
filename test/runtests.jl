using Notifier, Test

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
