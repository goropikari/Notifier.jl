import Base.notify
export notify

if ispath("/usr/local/bin/terminal-notifier")
	const terminalnotifier = "/usr/local/bin/terminal-notifier"
elseif ispath(joinpath(Pkg.dir("Homebrew"), "deps", "usr", "bin", "terminal-notifier"))
	const terminalnotifier = joinpath(Pkg.dir("Homebrew"), "deps", "usr", "bin", "terminal-notifier")
else
	error("Notifier.jl not properly installed. Please run Pkg.build(\"Notifier\")")
end

function notify(message=""; title="Julia", subtitle="", group="", sound=false, sender="org.julialang.launcherapp")
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

function remove(group="ALL"; sender="org.julialang.launcherapp")
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
