export alarm, say

include("email.jl")

"""
---
    Notifier.notify(message; title="Julia", sound=false, time=4, logo)

Notify by desktop notification.

# Arguments
- `urgency::AbstractString` : Urgency level ("low", "normal", "critical"). Default is "normal".
- `sound::Union{Bool, AbstractString}`: Play default sound or specific sound.
- `time::Real`: Display time.
- `logo`: Default is Julia logo
- `app_name::AbstractString` : Name of application sending the notification. Default is the name of your script (e.g. "test.jl") or "Julia REPL"/"Atom Juno" if using any of these two.
"""
function notify(message::AbstractString;
                title="Julia",
                urgency::AbstractString="normal",
                sound::Union{Bool, AbstractString}=false,
                time::Real=4,
                app_name::AbstractString=PROGRAM_FILE,
                logo::AbstractString=joinpath(@__DIR__, "logo.svg"))
    if app_name == "" && occursin("REPL", @__FILE__)   # Default for running in REPL
        app_name = "Julia REPL"
    elseif occursin("atom", app_name) && occursin("boot_repl.jl", app_name)  # Default for running in Juno
        app_name = "Atom Juno"
    end
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            d = @__DIR__
            @async run(`aplay -q $(joinpath(d, "default.wav"))`)
        elseif ispath(sound)
            @async run(`aplay -q $sound`)
        end
    end
    run(`notify-send $title $message -u $urgency -a $app_name -i $(logo) -t $(time * 1000)`)

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
