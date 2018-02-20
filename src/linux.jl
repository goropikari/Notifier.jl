import Base.notify
export notify, register_email, email, alarm
import WAV.wavplay

@doc """
---
notify(message::AbstractString; title::AbstractString, sound, time)

defalut parameter\n
    title = "Julia"\n
    sound = false\n
    time = 4 # display time (seconds)
""" notify
function notify(message::AbstractString;
                 title="Julia",
                 sound::Union{Bool, AbstractString}=false,
                 time::Real=4)
    if sound == true || typeof(sound) <: AbstractString
        if sound == true
            wavplay(joinpath(@__DIR__, "Notifier_sound.wav"))
        elseif ispath(sound)
            wavplay(sound)
        end
    end
    run(`notify-send $title $message -i $(joinpath(@__DIR__, "logo.svg")) -t $(time * 1000)`)

    return
end

@doc """
register_email()

register a recipient e-mail address
""" register_email
function register_email()
    emaildir = joinpath(@__DIR__, "..", "email")
    mkpath(emaildir)

    if ispath(joinpath(emaildir, "address.txt"))
        println("An e-mail address is already registered.")
        println("Do you overwrite? [y/n]")
        YesNo = lowercase(chomp(readline(STDIN)))

        if YesNo ∈ ["n", "no"]
            return
        end
    end

    println("\nType your desired recipient e-mail address to receive a notification.")
    print("e-mail: ")
    To = chomp(readline(STDIN))
    fp = open(joinpath(emaildir, "address.txt"), "w")
    write(fp, To)
    close(fp)

    println("\nRecipient e-mail address is saved at $(abspath((joinpath(emaildir, "address.txt")))).")
    println("If you want to change the address, modify $(abspath((joinpath(emaildir, "address.txt")))) directly or run register_email() again.")
end

@doc """
    alarm(;sound::AbstractString)
    notify by sound

    if you choose a specific sound WAV file, you can use it instead of the defalut sound.
""" alarm
alarm(;sound::AbstractString=joinpath(@__DIR__, "LinuxNotifier_sound.wav")) = wavplay(sound)


@doc """
email(message; subject, To)

defalut\n
subject="\$(round(now(), Dates.Second(1)))"\n
To="not-specified"\n
""" email
function email(message; subject="$(round(now(), Dates.Second(1)))", To="not-specified")
    emaildir = joinpath(@__DIR__, "..", "email")
    if To == "not-specified"
        if ispath(joinpath(emaildir, "address.txt"))
            To = readline(joinpath(emaildir, "address.txt"))
        else
            println("Email address is not specified.")
            println("In order to send an e-mail, register an e-mail address by register_email() or")
            println("specify it by To option like")
            println("	email(\"some messages\", To=\"foo@example.com\").")

            return
        end
    end
    run(pipeline(`echo $message`, `mail -s $subject $To`))
end
