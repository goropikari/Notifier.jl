export countup, countdown

function countup(min::Integer, sec::Integer)
   for i in 0:(60*min + sec)
       println(STDERR, i)
       sleep(1)

       # ProgressMeter.jl: print(STDERR, "\r\u1b[K\u1b[A") is quated from 
       # https://github.com/timholy/ProgressMeter.jl/blob/2c5683bec16ba50d00bf7d8e267eda7ff7d74623/src/ProgressMeter.jl#L299
       print(STDERR, "\r\u1b[K\u1b[A")
   end
   alarm()
end

# bag あり
function countdown(minite::Integer, second::Integer)
   totaltime = 60*minite + second
   for i in 0:totaltime
       println(STDERR, totaltime - i)
       sleep(1)
       print(STDERR, "\r\u1b[K\u1b[A")
   end
   alarm()
end
