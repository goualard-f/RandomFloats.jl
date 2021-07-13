# RandomFloats

The `RandomFloats` package offers types and functions to draw integer as well as floating-point numbers uniformly at random. Integer RNGs are implemented only to the extent they are useful to implement floating-point RNGs, as the point of the package is primarily to provide ways to obtain random *floating-point numbers*.

The package purposefully defines Random Number Generators (RNGs) in a way that is not directly compatible with the Julia `Random` package.
