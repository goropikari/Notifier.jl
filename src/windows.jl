import Base.notify
export notify, alarm

@doc """
---
notify(message::AbstractString;
       title::AbstractString,
       sound::Union{Bool, AbstractString},
       time::Real)

default parameter\n
    title = "Julia"\n
    time = 4 # display time (seconds). If you set time=0, then the message box is displayed until you put botton.
""" notify
function notify(message::AbstractString;
                 title="Julia",
                 sound::Union{Bool, AbstractString}=false,
                 time::Real=4)
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            @async run(`powershell -NoExit '('new-object System.Media.SoundPlayer $(joinpath(@__DIR__, "default.wav"))')'.Play'('')'`)
        elseif ispath(sound)
            #@async run(`aplay -q $sound`)
            @async run(`powershell -NoExit '('new-object System.Media.SoundPlayer $sound')'.Play'('')'`)
        end
    end
    @async run(pipeline(`powershell '('new-object -comobject wscript.shell')'.popup'(''"'$message'"', $time,'"'$title'"',0')'`, stdout=DevNull, stderr=DevNull))

    return
end

@doc """
    alarm(;sound::AbstractString)
    notify by sound

    if you choose a specific sound WAV file, you can use it instead of the default sound.
""" alarm
alarm(;sound::AbstractString=joinpath(@__DIR__, "default.wav")) = @async run(`powershell -NoExit '('new-object System.Media.SoundPlayer $sound')'.Play'('')'`)
