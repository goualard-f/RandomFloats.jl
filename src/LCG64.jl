# LCG64 --
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

module LCG64

import ...SimpleUInt64Generator
import ...GLOBAL_SEED

export lehmer64

function lehmer64_fun(rng::SimpleUInt64Generator)
    rng.state *= 0xda942042e4dd58b5
    return UInt64(rng.state >> 64)
end

"""
    lehmer64(seed = GLOBAL_SEED)

LCG as presented by D. Lemire in [_The fastest conventional random number generator that can pass Big Crush?_](https://lemire.me/blog/2019/03/19/the-fastest-conventional-random-number-generator-that-can-pass-big-crush/).

## References
Tables of linear congruential generators of different sizes and good 
lattice structure. P. L'Ecuyer, Mathematics of Computation of the American
Mathematical Society 68.225 (1999): 249-260.
"""
lehmer64(seed = GLOBAL_SEED) = return SimpleUInt64Generator("lehmer64",UInt128(seed),lehmer64_fun)

end # module
