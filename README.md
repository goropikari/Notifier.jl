# Notifier
[![Build Status](https://travis-ci.org/goropikari/Notifier.jl.svg?branch=master)](https://travis-ci.org/goropikari/Notifier.jl)
[![codecov.io](http://codecov.io/github/goropikari/Notifier.jl/coverage.svg?branch=master)](http://codecov.io/github/goropikari/Notifier.jl?branch=master)

This package is notification tools for Julialang.

## Installation
```Julia
Pkg.clone("git://github.com/goropikari/Notifier.jl.git")
```

# Linux OS
## Setup
Before using Notifier.jl, you need to install following softwares in your Linux system.
- `libnotify` for a desktop notification
- `mail` for an e-mail notification
- `aplay` (Advanced Linux Sound Architecture) for a sound notification

```bash
$ sudo apt install libnotify-bin alsa-utils mailutils heirloom-mailx bsd-mailx
```

This package uses `mail` linux command to notify by e-mail. Thus you need some settings in advance.
If following command works correctly, you don't need further setting.
```bash
$ echo test | mail -s foo yourmail@example.com
```

## Usage
### popup notification
```Julia
using Notifier
notify("calculation done")
# defalut title is "Julia".
# You can change the title by title option.
notify("calculation done", title="foofoo")
notify("calculation done", sound=true) # with sound
notify("calculation done", sound="./foo.wav") # specify a sound file
alarm() # only sound. You can specify a sound file, alarm(sound="./foo.wav")
```
![Screenshot of a Notification](./docs/popup.png?raw=true)

### e-mail notification
```Julia
email("message", To="foo@example.com") # default subject is set by date.
email("message", subject="result", To="foo@example.com")
```


If you use "email" function frequently, I recommend you to register your email address by "register_email" function.
```Julia
julia> register_email()
Type your desired recipient e-mail address to receive a notification.
e-mail: foo@example.com

Recipient e-mail address is saved at /path/to/.julia/v0.6/Notifier/email/address.txt.
If you want to change the address, modify /path/to/.julia/v0.6/Notifier/email/address.txt directly or run register_email() again
```

After you registered, you don't need to specify e-mail address.
```Julia
email("message")
```


# macOS
## Usage

```julia
using Notifier
notify("Task completed")
notify("Notification with sound", sound=true) # you can also specify a sound file
```

![Screenshot of a Notification](./docs/screenshot.png?raw=true)

Other supported parameters include `group` and `subtitle`.

You can also remove notifications. However, this does not seem to work reliably.

```julia
Notifier.remove() # removes all notifications
```

To remove specific notifications, you need to specify a group identifier when calling `notify`. This identifier can then be passed to `remove()`.

```julia
notify("Notification A", group="group1")
notify("Notification B", group="group2")

Notifier.remove("group1")
```

# Windows (Experimental)
## Usage
```Julia
using Notifier
notify("calculation done")
# defalut title is "Julia".
# You can change the title by title option.
notify("calculation done", title="foofoo")
notify("calculation done", sound=true) # with sound
notify("calculation done", sound="foo.wav") # specify a sound file
alarm() # only sound. You can specify a sound file, alarm(sound="foo.wav")
```
![Screenshot of a Notification](./docs/winpopup.png?raw=true)
