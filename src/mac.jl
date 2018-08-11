export alarm, say

include("email.jl")

if ispath("/usr/local/bin/terminal-notifier")
    const terminalnotifier = "/usr/local/bin/terminal-notifier"
else
    import Homebrew
    d = joinpath(dirname(pathof(Homebrew)), "..")
    if ispath(joinpath(d, "deps", "usr", "bin", "terminal-notifier"))
        const terminalnotifier = joinpath(d, "deps", "usr", "bin", "terminal-notifier")
    else
        error("Notifier.jl is not properly installed. Please run Pkg.build(\"Notifier\")")
    end
end

"""
    Notifier.notify(message=""; title="Julia", subtitle="", group="", sound=false, sender="org.julialang.launcherapp")

Notify by desktop notification.
"""
function notify(message=""; title="Julia", subtitle="", group="", sound=false, sender="org.julialang.launcherapp")
    if group != "" && sound != "" && sound != false
        run(`$terminalnotifier -sender $sender -message $message -title $title -subtitle $subtitle -group $group -sound $sound`)
    elseif sound != "" && sound != false
        run(`$terminalnotifier -sender $sender -message $message -title $title -subtitle $subtitle -sound $sound`)
    elseif group != ""
        run(`$terminalnotifier -sender $sender -message $message -title $title -subtitle $subtitle -group $group`)
    else
        run(`$terminalnotifier -sender $sender -message $message -title $title -subtitle $subtitle`)
    end
end
notify() = notify("Task completed.")

function remove(group="ALL"; sender="org.julialang.launcherapp")
    run(`$terminalnotifier -remove $group -sender $sender`)
end

"""
    Notifier.alarm(;sound=joinpath(@__DIR__, "default.wav"))

Notify by sound.
If you choose a specific sound WAV file, you can play it instead of the defalut sound.
```julia
alarm(sound="foo.wav")
```
"""
function alarm(;sound::AbstractString=joinpath(@__DIR__, "default.wav"))
    if sound == joinpath(@__DIR__, "default.wav")
        @async run(`afplay $sound`)
    elseif ispath(abspath(relpath(expanduser(sound))))
        @async run(`afplay $(expanduser(sound))`)
    else
        error("No such file or directory")
    end

    return nothing
end

"""
    Notifier.say(message::AbstractString)

Read a given message aloud.
"""
function say(msg::AbstractString)
    run(`say $msg`)
end
