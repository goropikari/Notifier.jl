export countup, countdown

"""
    countup(hour::T, min::T, sec::T) where T <: Integer

    countup(t::Time)
"""
function countup(hour::T, minute::T, second::T) where T <: Integer
    print_time(0)
    for t in 1:(hour*3600 + minute * 60 + second)
        update_printtime(t)
    end
    alarm()
end
countup(minute::T, second::T) where T <: Integer = countup(0, minute, second)
countup(second::T) where T <: Integer = countup(0, 0, second)
countup(t::Time) = countup(Hour(t).value, Minute(t).value, Second(t).value)
countup(h::Hour) = countup(h.value, 0, 0)
countup(m::Minute) = countup(0, m.value, 0)
countup(s::Second) = countup(0, 0, s.value)

"""
    countdown(hour::T, minute::T, second::T) where T <: Integer

    countdown(t::Time)
"""
function countdown(hour::T, minute::T, second::T) where T <: Integer
    print_time(hour*3600 + minute * 60 + second)
    for t in (hour*3600 + minute * 60 + second)-1:-1:0
        update_printtime(t)
    end
    alarm()
end
countdown(minute::T, second::T) where T <: Integer = countdown(0, minute, second)
countdown(second::T) where T <: Integer = countdown(0, 0, second)
countdown(t::Time) = countdown(Hour(t).value, Minute(t).value, Second(t).value)
countdown(h::Hour) = countdown(h.value, 0, 0)
countdown(m::Minute) = countdown(0, m.value, 0)
countdown(s::Second) = countdown(0, 0, s.value)

"""
    s2hms(tsec::Int)

Convert seconds to (hour, minute, second)
"""
function s2hms(tsec::Int)
    h = div(tsec,3600)
    m = mod(div(tsec,60), 60)
    s = mod(tsec,60)

    return h, m, s
end

function print_time(t::Int)
    h, m, s = s2hms(t)
    if isdefined(Main, :IJulia)
        print(stderr, Time(h,m,s))
    else
        println(stderr, Time(h,m,s))
    end
end

function updatetime()
    sleep(1)

    # ProgressMeter.jl: print(stderr, "\r\u1b[K\u1b[A") is quated from
    # https://github.com/timholy/ProgressMeter.jl/blob/2c5683bec16ba50d00bf7d8e267eda7ff7d74623/src/ProgressMeter.jl#L299
    print(stderr, "\r\u1b[K\u1b[A")
end

function update_printtime(t::Int)
    updatetime()
    print_time(t)
end
