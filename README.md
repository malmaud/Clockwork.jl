# Clockwork

![CI passing](https://github.com/malmaud/Clockwork.jl/actions/workflows/ci.yml/badge.svg)

Basics
---
Do all your favorite clock things:

```julia
using Clockwork
@test 🕟+🕝== 🕔 # 3:30 + 1:30 == 5:00
@test 🕑^50 == 🕓
@test Clock("3:30") == 🕟
let cp = Dates.Hour(3) + Dates.Minute(30)
  @test Clock(cp) == 🕟
  @test Dates.CompoundPeriod(🕟) == cp
end

```

Clock algebra
----

```julia
julia> hooks_nightmare = rand(Clock,10,10)
10x10 Array{Clockwork.Clock,2}:
 🕠  🕢  🕙  🕧  🕦  🕧  🕙  🕘  🕚  🕝
 🕔  🕛  🕔  🕢  🕤  🕥  🕥  🕢  🕦  🕣
 🕓  🕒  🕐  🕝  🕐  🕥  🕘  🕙  🕦  🕕
 🕧  🕒  🕒  🕓  🕟  🕑  🕙  🕗  🕝  🕕
 🕘  🕚  🕟  🕙  🕒  🕞  🕓  🕔  🕥  🕧
 🕓  🕧  🕞  🕞  🕖  🕧  🕐  🕑  🕥  🕝
 🕔  🕣  🕔  🕙  🕠  🕔  🕖  🕞  🕢  🕕
 🕛  🕧  🕥  🕥  🕧  🕚  🕙  🕔  🕛  🕢
 🕕  🕗  🕝  🕧  🕧  🕥  🕕  🕓  🕤  🕘
 🕒  🕓  🕥  🕧  🕣  🕔  🕥  🕘  🕥  🕟
julia> hooks_nightmare * rand(Clock, 10, 2)
10x2 Array{Clockwork.Clock,2}:
 🕝  🕠
 🕗  🕑
 🕝  🕔
 🕐  🕘
 🕡  🕢
 🕧  🕚
 🕧  🕕
 🕛  🕝
 🕧  🕠
 🕛  🕤
```
