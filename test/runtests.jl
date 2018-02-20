using Notifier
using Base.Test

# write your own tests here
# @test 1 == 2
if is_apple()
    include("mac_test.jl")
end
