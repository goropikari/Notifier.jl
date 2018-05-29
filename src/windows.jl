import Base.notify
export notify, alarm, say
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
                 time::Real=8)
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            d = @__DIR__
            @async run(`powershell -Command '('new-object System.Media.SoundPlayer $(joinpath(d, "default.wav"))')'.PlaySync'('')'`)
        elseif ispath(sound)
            @async run(`powershell -Command '('new-object System.Media.SoundPlayer $sound')'.PlaySync'('')'`)
        end
    end
    #@async run(pipeline(`powershell '('new-object -comobject wscript.shell')'.popup'(''"'$message'"', $time,'"'$title'"',0')'`, stdout=DevNull, stderr=DevNull))

    # ref. Create a balloon notification in PowerShell / IT Pro
    # http://www.itprotoday.com/management-mobility/create-balloon-notification-powershell
    d = @__DIR__
    @async run(`powershell '['Void']''['System.Reflection.Assembly']'':'':'LoadWithPartialName'(''"'System.Windows.Forms'"'')'';'
        \$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon';'
        \$objNotifyIcon.BalloonTipIcon = '"'Info'"'';'
        \$objNotifyIcon.Icon = '"'$(joinpath(d, "three-balls.ico"))'"'';'
        \$objNotifyIcon.BalloonTipText = '"'$message'"'';'
        \$objNotifyIcon.BalloonTipTitle = '"'$title'"'';'
        \$objNotifyIcon.Visible = \$True';'
        \$objNotifyIcon.ShowBalloonTip'('$(time*1000)')'';'
        Start-Sleep -s $time';'
        \$objNotifyIcon.dispose'('')'
        `)

    return nothing
end
notify() = notify("Task completed.")

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

"""
    Notifier.say(message::AbstractString)

Read a given message aloud.
"""
function say(message::AbstractString)
    @async run(`powershell Add-Type -AssemblyName System.speech';'
    \$s = New-Object System.Speech.Synthesis.SpeechSynthesizer';'
    \$s.Speak'(' '"' $message '"' ')'
    `)
end
