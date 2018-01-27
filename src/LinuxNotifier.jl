module LinuxNotifier

import Base.notify
export notify, register_email, email, alarm
import WAV.wavplay

@doc """
    alarm(;sound::AbstractString)
    notify by sound

    if you choose a specific sound WAV file, you can use it instead of the defalut sound.
""" alarm
alarm(;sound::AbstractString=joinpath(@__DIR__, "LinuxNotifier_sound.wav")) = wavplay(sound)

if is_unix() || is_linux()
    @doc """
    ---
    notify(message::AbstractString; title::AbstractString, sound, time)

    defalut parameter\n
        title = "\$(round(now(), Dates.Second(1)))"\n
        sound = false\n
        time = 4 # display time (seconds)
    """ notify
    function notify(message::AbstractString;
                     title="$(round(now(), Dates.Second(1)))",
                     sound::Union{Bool, AbstractString}=false,
                     time::Real=4)
        if sound == true || typeof(sound) <: AbstractString
            if sound == true
                wavplay(joinpath(@__DIR__, "LinuxNotifier_sound.wav"))
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
        output_dir = "$(Pkg.dir())/LinuxNotifier/email"
        if ! ispath(output_dir); mkdir(output_dir); end

        if ispath(output_dir * "/address.txt")

            println("An e-mail address is already registered.")
            println("Do you overwrite? [y/n]")
            YesNo = lowercase(chomp(readline(STDIN)))

            if YesNo ∈ ["n", "no"]
                return
            end

            println("\nType your desired recipient e-mail address to receive a notification.")
            print("e-mail: ")
            ToAddress = chomp(readline(STDIN))
            fp = open("$output_dir/address.txt", "w")
            write(fp, ToAddress)
            close(fp)

        else
            println("Type your desired recipient e-mail address to receive a notification.")
            print("e-mail: ")
            ToAddress = chomp(readline(STDIN))
            fp = open("$output_dir/address.txt", "w")
            write(fp, ToAddress)
            close(fp)

            println("\nRecipient e-mail address is saved at $output_dir/address.txt.")
            println("If you want to change the address, modify $output_dir/address.txt directly or execute register_email() again.")
        end
    end



    @doc """
    email(message; subject, ToAddress)

    defalut\n
    subject="\$(round(now(), Dates.Second(1)))"\n
    ToAddress="not-specified"\n
    """ email
    function email(message; subject="$(round(now(), Dates.Second(1)))", ToAddress="not-specified")
        output_dir = "$(Pkg.dir())/LinuxNotifier/email"
        if ToAddress == "not-specified"
            if ispath(output_dir * "/address.txt")
                ToAddress = readline(output_dir * "/address.txt")
            else
                println("Email address is not specified.")
                println("To send an e-mail, register an e-mail address by register_email() or")
                println("specify it by ToAddress option like")
                println("	email(\"some messages\", ToAddress=\"hoge@example.com\").")

                return
            end
        end
        run(pipeline(`echo $message`, `mail -s $subject $ToAddress`))
    end
end # if
end # module
