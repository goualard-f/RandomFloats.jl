# LCG32 --
#
#	Copyright 2021 University of Nantes, France.
#
#	This file is part of the RandomFloats library.
#
#	The RandomFloats library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation; either version 3 of the License, or (at your
#	option) any later version.
#	
#	The RandomFloats library is distributed in the hope that it will be useful,
# but	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#	or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#	for more details.
#	
#	You should have received copies of the GNU General Public License and the
#	GNU Lesser General Public License along with the RandomFloats Library.
# If not,	see https://www.gnu.org/licenses/.

module LCG32

import ...RandomUInt32Generator
import ...nextUInt32
import ...GLOBAL_SEED

export minstd, irandu
export urand

"""
    LCG32Generator

Compute the next 32 bits integer for a *Linear Congruential Generator* using the formula:
```julia
next = (a * next + c) % m
```
where `a`, `c` and `m` are the parameters of the LCG.
"""
mutable struct LCG32Generator <: RandomUInt32Generator
    next_value::UInt32
    seed::UInt32
    name::String
    a::UInt32
    c::UInt32
    m::UInt32
    LCG32Generator(name,a,c,m) = new(GLOBAL_SEED,GLOBAL_SEED,name,a,c,m)
    function LCG32Generator(name,seed,a,c,m)
        # We check the general acceptability of the seed. Each specific RNG
        # adds it own constraints upon creation.
        sizeof(seed)==8 &&
            (0 < seed <= typemax(Int32)
             || throw(ArgumentError("seed must be in [1, $(typemax(Int32))]")))
        new(seed,seed,name,a,c,m)
    end
end


function nextUInt32(rng::LCG32Generator)
    # We convert `rng.a` to an UInt64 to avoid overflow during the
    # multiplication.
    return rng.next_value = (UInt64(rng.a)*rng.next_value + rng.c) % rng.m 
end

"""
    minstd(seed = GLOBAL_SEED)

MINSTD implementation of the [*multiplicative linear congruential generator*](https://en.wikipedia.org/wiki/Linear_congruential_generator) by Lewis, Goodman and Miller.

The seed must be a strictly positive integer smaller or equal to ``2^31-2``. 

## Reference
_A pseudo-random number generator for the System/360_. P.A.W. Lewis, A.S. Goodman, 
and J.M. Miller. IBM Systems Journal, 8(2), p. 137, June 1969.

## Characteristics
Return an integer drawn uniformly at random in the domain ``[1,2^{31}-2]``.
"""
function minstd(seed = GLOBAL_SEED)
    0 < seed <= 2^31-2 || throw(ArgumentError("the seed must be in [1, $(2^31-2)]"))
    return LCG32Generator("minstd",seed,16807,0,2^31-1)
end

"""
    irandu(seed = GLOBAL_SEED)

The integer part of the IBM System/360 (in)famous [`RANDU` generator](https://en.wikipedia.org/wiki/RANDU).

The generator should be seeded with a positive odd integer smaller than ``10^9``. 

## Reference
_System/360 Scientific Subroutine Package, Version III_. Scientific Application Program 
H20-0205-3. 1968.

## Characteristics
Return an integer in the domain ``[1,2^{31}-1]``.
"""
function irandu(seed = GLOBAL_SEED)
    (isodd(seed) && 0 < seed <= 2^31) ||
        throw(ArgumentError("the seed must be an odd integer in [1, $(2^31)]"))
    return LCG32Generator("irandu",seed,65539,0,2^31)
end

"""
    urand(seed = GLOBAL_SEED)

Integer version of the RNG proposed by M.A. Malcom and C.B. Moler in 1973.

The generator must be seeded with an integer in ``[0, 2^31-1]``.

This is the [basic generator](https://github.com/scilab/scilab/blob/master/scilab/modules/randlib/src/c/urand.c) for SCILAB.

## Reference
_URAND: A Universal Random Number Generator_. M.A. Malcom and C.B. Moler. Report STAN-CS-73-334, January 1973. Computer Science Department, Stanford University.
"""
function urand(seed = GLOBAL_SEED)
    (seed < 0 || seed > 2147483647) && throw(ArgumentError("the seed must be an integer in [0, 2^31-1]"))
    return LCG32Generator("urand",seed,843314861,453816693,2^31)
end
end # module
