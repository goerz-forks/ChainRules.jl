using SpecialFunctions

@testset "SpecialFunctions" for x in (1, -1, 0, 0.5, 10, -17.1, 1.5 + 0.7im)
    test_scalar(SpecialFunctions.erf, x)
    test_scalar(SpecialFunctions.erfc, x)
    test_scalar(SpecialFunctions.erfi, x)

    test_scalar(SpecialFunctions.airyai, x)
    test_scalar(SpecialFunctions.airyaiprime, x)
    test_scalar(SpecialFunctions.airybi, x)
    test_scalar(SpecialFunctions.airybiprime, x)

    test_scalar(SpecialFunctions.besselj0, x)
    test_scalar(SpecialFunctions.besselj1, x)

    test_scalar(SpecialFunctions.erfcx, x)
    test_scalar(SpecialFunctions.dawson, x)

    if x isa Real
        test_scalar(SpecialFunctions.invdigamma, x)
    end

    if x isa Real && 0 < x < 1
        test_scalar(SpecialFunctions.erfinv, x)
        test_scalar(SpecialFunctions.erfcinv, x)
    end

    if x isa Real && x > 0 || x isa Complex
        test_scalar(SpecialFunctions.bessely0, x)
        test_scalar(SpecialFunctions.bessely1, x)
        test_scalar(SpecialFunctions.gamma, x)
        test_scalar(SpecialFunctions.digamma, x)
        test_scalar(SpecialFunctions.trigamma, x)
    end
end

@testset "log gamma and co" begin
    # SpecialFunctions 0.7->0.8 changes:
    for x in (1.5, 2.5, 10.5, -0.6, -2.6, 1.6+1.6im, 1.6-1.6im, -4.6+1.6im)
        if isdefined(SpecialFunctions, :lgamma)
            test_scalar(SpecialFunctions.lgamma, x)
        end
        if isdefined(SpecialFunctions, :loggamma)
            isreal(x) && x < 0 && continue
            test_scalar(SpecialFunctions.loggamma, x)
        end

        if isdefined(SpecialFunctions, :logabsgamma)
            isreal(x) || continue

            x, Δx, x̄ = randn(3)
            Δz = (randn(), randn())

            frule_test(SpecialFunctions.logabsgamma, (x, Δx))
            rrule_test(SpecialFunctions.logabsgamma, Δz, (x, x̄))
        end
    end

end
