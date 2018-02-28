import Base.notify
export notify, alarm

include("email.jl")

if ispath("/usr/local/bin/terminal-notifier")
    const terminalnotifier = "/usr/local/bin/terminal-notifier"
elseif ispath(joinpath(Pkg.dir("Homebrew"), "deps", "usr", "bin", "terminal-notifier"))
    const terminalnotifier = joinpath(Pkg.dir("Homebrew"), "deps", "usr", "bin", "terminal-notifier")
else
    error("Notifier.jl is not properly installed. Please run Pkg.build(\"Notifier\")")
end

"""
    Notifier.notify(message=""; title="Julia", subtitle="", group="", sound=false, sender="org.julialang.launcherapp")

popup notification
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

function remove(group="ALL"; sender="org.julialang.launcherapp")
    run(`$terminalnotifier -remove $group -sender $sender`)
end

"""
    Notifier.alarm(;sound::AbstractString)

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
