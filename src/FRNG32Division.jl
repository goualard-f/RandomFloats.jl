# FRNG32Division --
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

import .LCG.LCG32: minstd, irandu

export old_rand_matlab, randu

"""
    RandomFloat32Div1Generator

Generator for `Float32` random floats obtained by dividing a 32 bits random integer
by a constant integer.
"""
mutable struct RandomFloat32Div1Generator <: RandomFloat32Generator
    uint32_rng::RandomUInt32Generator
    divisor::UInt32
    name::String
    RandomFloat32Div1Generator(name::String,
                               u32rng::RandomUInt32Generator,
                               d::Int) = new(u32rng,d,name)
end

function nextFloat32(rng::RandomFloat32Div1Generator)
    return nextUInt32(rng.uint32_rng)/rng.divisor
end

"""
    RandomFloat32MulGenerator

Generator for `Float32` random floats obtained by multiplying a 32 bits random integer
by a fixed float smaller than 1.
"""
mutable struct RandomFloat32MulGenerator <: RandomFloat32Generator
    uint32_rng::RandomUInt32Generator
    multiplier::Float32
    name::String
    RandomFloat32MulGenerator(name::String,
                              u32rng::RandomUInt32Generator,
                              m::Float32) = new(u32rng,m,name)
end

"""
    matlab4(seed = GLOBAL_LCG_SEED)

RNG used by MATLAB v 4.0. It is based on the [`minstd`](@ref) LCG.
"""
matlab4(seed = GLOBAL_LCG_SEED) = RandomFloat32Div1Generator("matlab4",
                                                             minstd(seed),2^31)

"""
    randu(seed = GLOBAL_LCG_SEED)

The IBM System/360 (in)famous [`RANDU` generator](https://en.wikipedia.org/wiki/RANDU).

The generator should be seeded with a positive odd integer smaller than ``10^9``. 

## Reference
_System/360 Scientific Subroutine Package, Version III_. Scientific Application Program 
H20-0205-3, p. 77, 1968.

## Characteristics
Return a `Float32` float drawn uniformly at random from ``[0,1]``.
"""
randu(seed = GLOBAL_LCG_SEED) = RandomFloat32MulGenerator("randu",irandu(seed),
                                                            Float32(0x1p-31))

function nextFloat32(rng::RandomFloat32MulGenerator)
    return nextUInt32(rng.uint32_rng)*rng.multiplier
end

