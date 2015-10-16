using CoolClocks
using Base.Test

@test 🕟+🕝== 🕔
@test 🕑^50 == 🕓
@test Clock("3:30") == 🕟
let cp = Dates.Hour(3) + Dates.Minute(30)
  @test Clock(cp) == 🕟
  @test Dates.CompoundPeriod(🕟) == cp
end
