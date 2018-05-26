using Notifier
import Base.Dates: Time, Hour, Minute, Second
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

include("timer_test.jl")
