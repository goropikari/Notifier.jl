using Notifier
using Base.Test

# write your own tests here
if is_linux()
    include("linux_test.jl")
end
if is_apple()
    include("mac_test.jl")
end
if is_windows()
    include("windows_test.jl")
end
