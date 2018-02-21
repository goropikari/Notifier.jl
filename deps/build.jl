if is_apple()
    if !ispath("/usr/local/bin/terminal-notifier")
        using Homebrew
        Homebrew.add("terminal-notifier")
    end
end
