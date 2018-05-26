import Compat.Dates: Hour, Minute, Second, Time
@test try
    countup(0,0,3)
    true
catch
    false
end
@test try
    countup(0,3)
    true
catch
    false
end
@test try
    countup(3)
    true
catch
    false
end
@test try
    countup(Time(0,1,3))
    true
catch
    false
end
@test try
    countup(Minute(1))
    true
catch
    false
end
@test try
    countup(Second(3))
    true
catch
    false
end


@test try
    countdown(0,0,3)
    true
catch
    false
end
@test try
    countdown(0,3)
    true
catch
    false
end
@test try
    countdown(3)
    true
catch
    false
end
@test try
    countdown(Time(0,1,3))
    true
catch
    false
end
@test try
    countdown(Minute(1))
    true
catch
    false
end
@test try
    countdown(Second(3))
    true
catch
    false
end
