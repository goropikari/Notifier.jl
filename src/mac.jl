import Homebrew
import Base.notify
export notify

if Homebrew.installed("terminal-notifier")
	terminalnotifier = joinpath(Homebrew.prefix("terminal-notifier"), "bin", "terminal-notifier")
	if !isfile(terminalnotifier)
		error("terminal-notifier binary does not exist: $terminalnotifier")
	end
else
	error("OSXNotifier not properly installed. Please run Pkg.build(\"OSXNotifier\")")
end

function notify(message=""; title="Julia", subtitle="", group="", sound=false, sender="julialang.org")
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

function remove(group="ALL"; sender="julialang.org")
	run(`$terminalnotifier -remove $group -sender $sender`)
end

#function list(group="ALL")
#	lines = readall(`$terminalnotifier -list $group`)
#	lines = split(lines, "\n")
#	lines = map(line -> split(line, "\t"), lines)
#	lines = map(line -> map(element -> convert(ASCIIString, element), line), lines)
#	keys = lines[1]
#	lines = lines[2:end-1]
#	map(line -> Dict(zip(keys, line)), lines)
#end
