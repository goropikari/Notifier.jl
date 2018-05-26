import Compat.Dates: Hour, Minute, Second, Time
export countup, countdown

"""
    countup(hour::Integer, min::Integer, sec::Integer)

    countup(t::Time)
"""
function countup(hour::Integer, minute::Integer, second::Integer)
    for t in 0:(hour*3600 + minute * 60 + second)
        h = div(t,3600); t -= 3600 * h
        m = div(t, 60); t -= 60 * m
        s = t
        if isdefined(Main, :IJulia)
            print(stderr, Time(h,m,s))
        else
            println(stderr, Time(h,m,s))
        end
        sleep(1)

        # ProgressMeter.jl: print(stderr, "\r\u1b[K\u1b[A") is quated from
        # https://github.com/timholy/ProgressMeter.jl/blob/2c5683bec16ba50d00bf7d8e267eda7ff7d74623/src/ProgressMeter.jl#L299
        print(stderr, "\r\u1b[K\u1b[A")
    end
    alarm()
end
countup(minute::Integer, second::Integer) = countup(0, minute, second)
countup(second::Integer) = countup(0, 0, second)
countup(t::Time) = countup(Hour(t).value, Minute(t).value, Second(t).value)
countup(h::Hour) = countup(h.value, 0, 0)
countup(m::Minute) = countup(0, m.value, 0)
countup(s::Second) = countup(0, 0, s.value)

"""
    countdown(hour::Integer, minute::Integer, second::Integer)

    countdown(t::Time)
"""
function countdown(hour::Integer, minute::Integer, second::Integer)
    for t in (hour*3600 + minute * 60 + second):-1:0
        h = div(t,3600); t -= 3600 * h
        m = div(t, 60); t -= 60 * m
        s = t
        if isdefined(Main, :IJulia)
            print(stderr, Time(h,m,s))
        else
            println(stderr, Time(h,m,s))
        end
        sleep(1)

        print(stderr, "\r\u1b[K\u1b[A")
    end
    alarm()
end
countdown(minute::Integer, second::Integer) = countdown(0, minute, second)
countdown(second::Integer) = countdown(0, 0, second)
countdown(t::Time) = countdown(Hour(t).value, Minute(t).value, Second(t).value)
countdown(h::Hour) = countdown(h.value, 0, 0)
countdown(m::Minute) = countdown(0, m.value, 0)
countdown(s::Second) = countdown(0, 0, s.value)
