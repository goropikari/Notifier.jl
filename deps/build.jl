if is_linux()
    using BinDeps
    @BinDeps.setup

    libnotify = library_dependency("libnotify")

    provides(AptGet, "libnotify-bin", libnotify)
    provides(Pacman, "libnotify", libnotify)
    provides(Yum, "libnotify", libnotify)

    @BinDeps.install Dict(:libnotify => :libnotify)
end

if is_apple()
    using Homebrew
    Homebrew.add("terminal-notifier")
end
