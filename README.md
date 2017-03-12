# LinuxNotifier

This package is notification tools for Linux OS.

## Setup
Before using LinuxNotifier, you need to install following softwares to work correctly in your Linux system.
- libnotify for desktop notifications
- "mail" for e-mail notifications

This package uses "mail" linux command to notify by e-mail. Thus you need some settings in advance.
If following command works correctly, you don't need further setting.
```bash
	$ echo test | mail -s hoge yourmail@example.com
```

## Installation
```Julia
	Pkg.clone("git://github.com/goropikari/LinuxNotifier.jl.git")
```

## Usage
### popup notification
```Julia
	using LinuxNotifier
	lnotify("calculation done") 
	# defalut title is set by date.
	# You can change the title by title option, lnotify("calculation done", title="hogehoge")
	lnotify("calculation done", sound=true) # with sound
	lnotify("calculation done", music="./hoge.wav") # specify a sound file
	alarm() # only sound. You can specify a sound file, alarm(music="./piyo.wav")
```
<img src="https://github.com/goropikari/LinuxNotifier.jl/blob/master/src/popup.png" align="left"  />


<br><br><br><br>
### e-mail notification
```Julia
	email("message", ToAddress="hoge@example.com") # defalut subject is set by date.
	email("message", subject="result", ToAddress="hoge@example.com")
```


If you use "email" fn frequently, I recommend you to register your e-email address by "register_email" fn.
```Julia
	julia> register_email()
	Type your desired recipient e-mail address to receive a notification.
	e-mail: hoge@example.com

	Recipient e-mail address is saved at /path/to/.julia/v0.5/LinuxNotifier/email/address.txt.
	If you want to change the address, modify /path/to/.julia/v0.5/LinuxNotifier/email/address.txt directly or execute register_email() again
```

After you registered, you don't need specify e-mail address.
```Julia
	email("message")
```
