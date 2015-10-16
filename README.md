# CoolClocks


[![Build Status](https://travis-ci.org/malmaud/CoolClocks.jl.svg?branch=master)](https://travis-ci.org/malmaud/CoolClocks.jl)

[![Coverage Status](https://coveralls.io/repos/malmaud/CoolClocks.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/malmaud/CoolClocks.jl?branch=master)

[![codecov.io](http://codecov.io/github/malmaud/CoolClocks.jl/coverage.svg?branch=master)](http://codecov.io/github/malmaud/CoolClocks.jl?branch=master)

Do all your favorite clock things:

```julia
using CoolClocks
@test 🕟+🕝== 🕔 # 3:30 + 1:30 == 5:00
@test 🕑^50 == 🕓
@test Clock("3:30") == 🕟
let cp = Dates.Hour(3) + Dates.Minute(30)
  @test Clock(cp) == 🕟
  @test Dates.CompoundPeriod(🕟) == cp
end

```
