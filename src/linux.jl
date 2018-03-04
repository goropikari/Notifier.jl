import Base.notify
export notify, alarm, say, register_email, email

include("email.jl")

"""
---
    Notifier.notify(message; title="Julia", sound=false, time=4)

Notify by desktop notification.

# Arguments
- `sound::Union{Bool, AbstractString}`: Play default sound or specific sound.
- `time::Real`: display time.
"""
function notify(message::AbstractString;
                title="Julia",
                sound::Union{Bool, AbstractString}=false,
                time::Real=4)
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            @async run(`aplay -q $(joinpath(@__DIR__, "default.wav"))`)
        elseif ispath(sound)
            @async run(`aplay -q $sound`)
        end
    end
    run(`notify-send $title $message -i $(joinpath(@__DIR__, "logo.svg")) -t $(time * 1000)`)

    return
end

"""
    Notifier.alarm(;sound="defalut.wav")

Notify by sound.
If you choose a specific sound WAV file, you can play it instead of the defalut sound.
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
    run(`espeak $msg`)
end
