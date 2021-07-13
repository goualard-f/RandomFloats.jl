# RNGMisc --
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

export mersenne_twister, lehmer64

"""
    SimpleUInt64Generator

Simple integer generator with a state reduced to a single integer.
"""
mutable struct SimpleUInt64Generator <: RandomUInt64Generator
    state
    seed
    name::String
    fun
    SimpleUInt64Generator(name,seed,fun) = new(seed,seed,name,fun)
end



function nextUInt64(rng::SimpleUInt64Generator)
    return rng.fun(rng)
end

"""
    JuliaRandUInt64Generator

Integer random number generator inherited from the `Random` Julia standard library.
"""
struct JuliaUInt64Generator <: RandomUInt64Generator
    seed::UInt64
    rng::Random.AbstractRNG
    name::String
end

function nextUInt64(rng::JuliaUInt64Generator)
    return Random.rand(rng.rng,UInt64)
end

mersenne_twister(seed = GLOBAL_SEED) = JuliaUInt64Generator(seed,
                                                            Random.MersenneTwister(seed),
                                                            "MersenneTwister")

