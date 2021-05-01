# FRNGDivision --
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

#======================================================= 
Generation of a float in <0,1> by dividing two integers. 
There are mainly three different ways:
- Generate a random integer and divide it by a constant;
- Generate a random integer and multiply it by the 
  inverse of a constant;
- Generate two random integers and divide the first by 
  the second.
========================================================#


include("FRNG32Division.jl")

include("FRNG64Division.jl")
