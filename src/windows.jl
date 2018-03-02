import Base.notify
export notify, alarm
"""
---
    Notifier.notify(message; title="Julia", sound=false, time=4)

Notify by desktop notification.

# Arguments
- `sound::Union{Bool, AbstractString}`: Play default sound or specific sound.
- `time::Real`: display time. If you set time=0, then the message box is displayed
                until you put the botton.
"""
function notify(message::AbstractString;
                 title="Julia",
                 sound::Union{Bool, AbstractString}=false,
                 time::Real=4)
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            @async run(`powershell -Command '('new-object System.Media.SoundPlayer $(joinpath(@__DIR__, "default.wav"))')'.PlaySync'('')'`)
        elseif ispath(sound)
            @async run(`powershell -Command '('new-object System.Media.SoundPlayer $sound')'.PlaySync'('')'`)
        end
    end
    @async run(pipeline(`powershell '('new-object -comobject wscript.shell')'.popup'(''"'$message'"', $time,'"'$title'"',0')'`, stdout=DevNull, stderr=DevNull))

    return
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
    @async run(`powershell -Command '('new-object System.Media.SoundPlayer $sound')'.PlaySync'('')'`)
end
