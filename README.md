# LinuxNotifier

This package is a notification tool for Linux OS.

## Setup
Before using LinuxNotifier, you need to install following softwares to work correctly in your Linux system.
- libnotify for desktop notifications
- "mail" for e-mail notifications

This package uses "mail" linux command to notify by e-mail. Thus you need some settings in advance.
If following command works correctly, you don't need further setting.
```bash
	$ echo test | mail -s foo yourmail@example.com
```

## Installation
```Julia
	Pkg.clone("git://github.com/goropikari/LinuxNotifier.jl.git")
```

## Usage
### popup notification
```Julia
	using LinuxNotifier
	notify("calculation done")
	# defalut title is set by date.
	# You can change the title by title option, notify("calculation done", title="foofoo")
	notify("calculation done", sound=true) # with sound
	notify("calculation done", sound="./foo.wav") # specify a sound file
	alarm() # only sound. You can specify a sound file, alarm(sound="./foo.wav")
```
<img src="./src/popup.png" align="left"  />


<br><br><br><br>
### e-mail notification
```Julia
	email("message", To="foo@example.com") # defalut subject is set by date.
	email("message", subject="result", To="foo@example.com")
```


If you use "email" function frequently, I recommend you to register your email address by "register_email" function.
```Julia
	julia> register_email()
	Type your desired recipient e-mail address to receive a notification.
	e-mail: foo@example.com

	Recipient e-mail address is saved at /path/to/.julia/v0.5/LinuxNotifier/email/address.txt.
	If you want to change the address, modify /path/to/.julia/v0.5/LinuxNotifier/email/address.txt directly or run register_email() again
```

After you registered, you don't need to specify e-mail address.
```Julia
	email("message")
```
