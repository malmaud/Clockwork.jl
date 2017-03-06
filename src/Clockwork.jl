module Clockwork

export Clock
import Base: +, *, ^, -

immutable Clock
    hour::Int
    on_minute::Bool
end

Clock(hour::Integer) = Clock(Int(hour), false)

const glyph_for_clock = Dict{Clock, Symbol}()
for i=1:12
    s1 = Symbol(Char(0x1F550+(i-1)))
    s2 = Symbol(Char(0x1F550+(i-1)+12))
    t1 = Clock(i, false)
    t2 = Clock(i, true)
    @eval const $s1=$t1
    @eval const $s2=$t2
    glyph_for_clock[t1] = s1
    glyph_for_clock[t2] = s2
    @eval export $s1, $s2
end

for (op, carry) in [(:+, 1), (:-, -1)]
    @eval begin
        function $op(c1::Clock, c2::Clock)
            if c1.on_minute && c2.on_minute
                hour, on_minute = $op(c1.hour, c2.hour)+$carry, false
            elseif !c1.on_minute && !c2.on_minute
                hour, on_minute = $op(c1.hour, c2.hour), false
            else
                hour, on_minute = $op(c1.hour, c2.hour), true
            end
            Clock(mod1(hour,12), on_minute)
        end
    end
end

for (op, inner_op) in [(:*,:+), (:^, :*)]
    @eval begin
        function $op(c1::Clock, c2::Clock)
            c = c1
            for n=1:c2.hour-1
                c = $inner_op(c, c1)
            end
            c
        end
    end
end

for op in [:+, :*, :^, :-]
    @eval $op(n::Integer, c::Clock) = $op(Clock(n), c)
    @eval $op(c::Clock, n::Integer) = $op(c, Clock(n))
end

function Base.show(io::IO, c::Clock)
    print(io, glyph_for_clock[c])
end

function Base.convert(::Type{Dates.CompoundPeriod}, c::Clock)
    d = Dates.Hour(c.hour)
    if c.on_minute
        d += Dates.Minute(30)
    end
    Dates.CompoundPeriod(d)
end

function Base.convert(::Type{DateTime}, c::Clock)
    args = Any[Dates.Hour(c.hour)]
    if c.on_minute
        push!(args, Dates.Minute(30))
    end
    DateTime(args...)
end

Base.DateTime(c::Clock) = convert(DateTime, c)

_hour(d::Dates.DateTime) = Dates.hour(d)
_minute(d::Dates.DateTime) = Dates.minute(d)
_hour(d::Dates.Hour) = Dates.value(d)
_minute(d::Dates.Minute) = Dates.value(d)
_hour(x) = 0
_minute(x) = 0
for op in [:_hour, :_minute]
    @eval $op(d::Dates.CompoundPeriod) = sum(map($op, d.periods))
end

Base.convert(::Type{Clock}, d::Dates.AbstractTime) =
  Clock(mod1(_hour(d), 12), _minute(d)==30)

function Base.convert(::Type{Clock}, fmt::AbstractString)
    dt = DateTime(fmt,"H:M")
    convert(Clock, dt)
end

Base.zero(::Type{Clock}) = Clock(12, false)
Base.one(::Type{Clock}) = Clock(1, false)
Base.zero(::Clock) = zero(Clock)
Base.one(::Clock) = one(Clock)

Base.rand(rng, ::Type{Clock}) = Clock(rand(rng, 1:12), rand(rng, Bool))

end # module
