@testset "irandu" begin
    # Comparing the sequence obtained from `irandu(1)` with
    # [A096555](https://oeis.org/A096555)
    A096555 = [1, 65539, 393225, 1769499, 7077969, 26542323, 95552217, 334432395, 1146624417, 1722371299, 14608041, 1766175739, 1875647473, 1800754131, 366148473, 1022489195, 692115265, 1392739779, 2127401289, 229749723, 1559239569]
    rng = irandu(1)
    for v in A096555[2:end]
        @test nextUInt32(rng) == v
    end
end;
