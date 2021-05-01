# RandomFloats --
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

module RandomFloats

import Random 

export nextUInt32, nextUInt64
export nextInt32, nextInt64
export nextFloat32, nextFloat64

abstract type RandomUIntGenerator end
abstract type RandomUInt32Generator <: RandomUIntGenerator end
abstract type RandomUInt64Generator <: RandomUIntGenerator end


abstract type RandomFloatGenerator end
abstract type RandomFloat32Generator <: RandomFloatGenerator end
abstract type RandomFloat64Generator <: RandomFloatGenerator end


"""
    GLOBAL_SEED

Default seed if the user forgets to provide one. We choose a small 
prime value greater than 2 to accommodate the constraints from most LCGs.
"""
const GLOBAL_SEED = 13


"""
    nextUInt32(rng::RandomUInt32Generator)

Return the next random 32 bits unsigned integer from the generator `rng`. 

!!! note Initialization
    The generator `rng` usually requires some initialization before the first 
    call to `nextUInt32`.
"""
function nextUInt32 end

"""
    nextUInt64(rng::RandomUInt64Generator)

Return the next random 64 bits unsigned integer from the generator `rng`. 

!!! note Initialization
    The generator `rng` usually requires some initialization before the first call 
    to `nextUInt64`.
"""
function nextUInt64 end

"""
    nextInt32(rng::RandomUInt32Generator)

Return the next random 32 bits integer from the generator `rng`. 

!!! note Initialization
    The generator `rng` usually requires some initialization before the first call 
    to `nextInt32`.
"""
nextInt32(rng::RandomUIntGenerator)::Int32 = reinterpret(Int32,nextUInt32(rng))

"""
    nextInt64(rng::RandomUInt64Generator)

Return the next random 64 bits integer from the generator `rng`. 

!!! note Initialization
    The generator `rng` usually requires some initialization before the first call 
    to `nextInt64`.
"""
nextInt64(rng::RandomUInt64Generator)::Int64 = reinterpret(Int64,nextUInt64(rng))


"""
    nextFloat32(rng::RandomFloat64Generator)

Return the next `Float32` float generated with `rng`.

!!! note Initialization
    The generator `rng` usually requires some initialization before the first call 
    to `nextFloat32`.
"""
function nextFloat32 end

"""
    nextFloat64(rng::RandomFloat64Generator)

Return the next `Float64` float generated with `rng`.

!!! note Initialization
    The generator `rng` usually requires some initialization before the first call 
    to `nextFloat64`.
"""
function nextFloat64 end



"""
    irandint(n::Int, rng::RandomUInt64Generator = mersenne_twister())

Draw a `n` bits integer at random using the generator `rng`. The default RNg used
is the Mersenne Twister implementation present in the `Random` Julia package.

First, compute a 64 bits integer, then discard the lowest `(64-n)` bits, which 
are often the less *random* ones.
"""
function irandint(n::Int, rng::RandomUInt64Generator = mersenne_twister())
    return nextUInt64(rng) >> (64-n)
end

# Linear Congruential Generators
include("LCG.jl")

# Miscellaneous Integer RNGs
include("RNGMisc.jl")

# FRNGs obtained by division of integers
include("FRNGDivision.jl")

# Miscellaneous algorithms to generate floats at random
include("FRNGMisc.jl")

end # module
