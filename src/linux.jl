export alarm, say

include("email.jl")

"""
---
    Notifier.notify(message; title="Julia", sound=false, time=4, logo)

Notify by desktop notification.

# Arguments
- `sound::Union{Bool, AbstractString}`: Play default sound or specific sound.
- `time::Real`: display time.
- `logo`: Default is Julia logo
"""
function notify(message::AbstractString;
                title="Julia",
                sound::Union{Bool, AbstractString}=false,
                time::Real=4,
                logo::AbstractString=joinpath(@__DIR__, "logo.svg"))
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            d = @__DIR__
            @async run(`aplay -q $(joinpath(d, "default.wav"))`)
        elseif ispath(sound)
            @async run(`aplay -q $sound`)
        end
    end
    run(`notify-send $title $message -i $(logo) -t $(time * 1000)`)

    return
end
notify() = notify("Task completed.")

"""
    Notifier.alarm(;sound="default.wav")

Notify by sound.
If you choose a specific sound WAV file, you can play it instead of the default sound.
"""
function alarm(;sound::AbstractString=joinpath(@__DIR__, "default.wav"))
    @async run(`aplay -q $sound`)
    return nothing
end

"""
    Notifier.say(message::AbstractString)

Read a given message aloud.
"""
function say(msg::AbstractString)
    run(pipeline(`espeak $msg`, stderr=devnull))
end
