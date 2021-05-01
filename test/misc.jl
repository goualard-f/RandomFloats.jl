@testset "irandint" begin
    rng = lehmer64(42)
    @test RandomFloats.irandint(13,rng) == 0
    @test RandomFloats.irandint(13,rng) == 0x13cb
end;
