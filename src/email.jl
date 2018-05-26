export register_email, email

"""
    Notifier.register_email()

Register a recipient e-mail address.
"""
function register_email()
    emaildir = joinpath(@__DIR__, "..", "email")
    mkpath(emaildir)

    if ispath(joinpath(emaildir, "address.txt"))
        println("An e-mail address is already registered.")
        print("Do you overwrite? [y/n]: ")
        YesNo = lowercase(chomp(readline(stdin)))

        if YesNo ∈ ["n", "no"]
            return nothing
        end
    end

    println("\nType your desired recipient e-mail address to receive a notification.")
    print("e-mail: ")
    To = chomp(readline(stdin))
    fp = open(joinpath(emaildir, "address.txt"), "w")
    write(fp, To)
    close(fp)

    println("\nRecipient e-mail address is saved at $(abspath((joinpath(emaildir, "address.txt")))).")
    println("If you want to change the address, modify $(abspath((joinpath(emaildir, "address.txt")))) directly or run register_email() again.")
end

"""
    Notifier.email(message; subject, To)

Send email to specific email address.

# Arguments
- `To::AbstractString`: recipient email adress.
"""
function email(message; subject="$(round(now(), Dates.Second(1)))", To="")
    emaildir = joinpath(@__DIR__, "..", "email")
    if isempty(To)
        if ispath(joinpath(emaildir, "address.txt"))
            To = readline(joinpath(emaildir, "address.txt"))
        else
            error("""Email address is not specified.
                       In order to send an e-mail, you should register an e-mail address by
                           register_email()
                       or specify the address by using To option.
                           email(\"some messages\", To=\"foo@example.com\").""")
        end
    end
    run(pipeline(`echo $message`, `mail -s $subject $To`))
end
