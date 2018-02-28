import Base.notify
export notify, alarm

"""
---
    Notifier.notify(message::AbstractString;
                    title::AbstractString,
                    sound::Union{Bool, AbstractString},
                    time::Real)

    default parameter\n
        title = "Julia"\n
        time = 4 # display time (seconds).

If you set time=0, then the message box is displayed until you put botton.
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
    Notifier.alarm(;sound::AbstractString)

notify by sound

If you choose a specific WAV file, you can play it instead of the default sound.
"""
alarm(;sound::AbstractString=joinpath(@__DIR__, "default.wav")) = @async run(`powershell -Command '('new-object System.Media.SoundPlayer $sound')'.PlaySync'('')'`)
