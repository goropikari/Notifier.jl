@test try
    notify("foo")
    true
catch
    false
end
@test try
    notify("foo", title="bar")
    true
catch
    false
end
@test try
    notify("foo", subtitle="subbar")
    true
catch
    false
end
@test try
    notify("foo", group="baz")
    true
catch
    false
end
@test try
    notify("foo", sound=true)
    true
catch
    false
end
@test try
    notify("foo", group="baz", sound=true)
    true
catch
    false
end
@test try
    alarm()
    true
catch
    false
end
