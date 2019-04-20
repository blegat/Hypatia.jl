
using LinearAlgebra
using Test


# univariate
d = 2

# # full vandermonde
# # V_basis = [x -> x^i * conj(x)^j for j in 0:d for i in 0:d] # TODO columns are dependent if not doing j in 0:i
# V_basis = [x -> x^i * conj(x)^j for j in 0:d for i in 0:j]
# U = length(V_basis)
# @show U
# @show div(d * (d + 1), 2)



# V_basis = [z -> z^i * conj(z)^j for j in 0:d for i in 0:j]
# U = div((d + 1) * (d + 2), 2)

V_basis_mat = [z -> z^i * conj(z)^j for i in 0:d, j in 0:d]
V_basis = vec(V_basis_mat)
U = (d + 1)^2

# points are randomly sampled
# points = 2 * rand(ComplexF64, U) .- (1 + im)
radii = sqrt.(rand(U))
angles = rand(U) .* 2pi
points = radii .* (cos.(angles) .+ (sin.(angles) .* im))

# # points are the roots of unity
# points = [cospi(2k / U) + sinpi(2k / U) * im for k = 0:(U - 1)]


# P = [p^i for p in points, i in 0:d]
# @assert rank(P) == d + 1

# # @show points
V = [b(p) for p in points, b in V_basis]
# @show rank(V)
@test rank(V) == U


# make_psd = true
make_psd = false

# rand dual solution
Yh = randn(ComplexF64, d + 1, d + 1)
Y = Hermitian(make_psd ? Yh * Yh' : Yh)









# @assert isposdef(F) == isposdef(Hermitian(P * F * P'))

# values at points given coefs
# vals = [sum(F[i+1, j+1] * p^i * conj(p)^j for i in 0:d, j in 0:d) for p in points]
# vals = [sum(F[i+1, j+1] * p^i * conj(p)^j for j in 0:d for i in 0:d) for p in points]
# @assert real(vals) ≈ vals
# vals = real(vals)
# @show vals


# @test isposdef(Hermitian(P' * Diagonal(vals) * P)) == isposdef(F)

#
# # fvec = vec(F)
# # @test vals ≈ V * fvec
#
# # from values at points, recover coefs
# test_coefs = V \ vals
# @show test_coefs
# @show F
# # test_coefs_mat = reshape(test_coefs, d + 1, d + 1)
# # @test test_coefs_mat ≈ F
#
# k = 1
# for j in 0:d, i in 0:j
#     @test test_coefs[k] ≈ conj(F[j+1, i+1])
#     global k += 1
# end

# @show fvec
# @show test_coefs

#
# # Lam = Hermitian(P' * Diagonal(vals) * P)
# Lam = Hermitian(P' * Diagonal(vals) * P)
# # @show norm(Lam - P' * Diagonal(vals) * P)
#
# @show eigvals(Lam)
# @show isposdef(Lam)
# @test isposdef(Lam) == isposdef(F)
;
