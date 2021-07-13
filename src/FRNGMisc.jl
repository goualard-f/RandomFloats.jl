# FRNGMisc --
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

export rand_go
export rand_r0to1b
    
"""
    rand_go(rng = mersenne_twister())

Compute a `Float64` float drawn uniformly at random in ``[0,1)`` using the method
adopted in the _Go_ language. 

The method used consists in generating a 63 bits random integer and dividing the 
result by ``2^{63}``. The result may round to ``1.0``; in that case it is rejected and
the function is called again.

## References
[Go source](https://golang.org/src/math/rand/rand.go?s=5359:5391#L168), retrieved 2021-05-01.
"""
function rand_go(rng::RandomUInt64Generator = mersenne_twister())
    r = irandint(63,rng) / UInt64(2)^63
    return r != 1.0 ? r : rand_go()
end


"""
    ffs(Integer
"""


"""
    rand_r0to1b(::Type{T} = Float64) where {T <: AbstractFloat}

Generate a float in ``[0,1)`` by creating separately an exponent in [0,52] 
and a fractional part from 53 random bits. The position ``i`` of the rightmost ``1`` bit
determines the exponent while the  
"""
function r0to1b(::Type{T} = Float64) where {T <: AbstractFloat}
    p = precision(T)
    fsize = p - 1
    r = rand(DiscreteUniform(0,2^p-1))
    e = trailing_zeros(r)+1
    (e > fsize || e == 0) && return T(0.0)
    m = (r >> e) << (e - 1)
    return T((2.0^fsize+m)*(2.0^(-fsize-e)))
end
