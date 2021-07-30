using Plots
gr(size=(800,400))

include("Spline linear valores.jl")
include("Funcoes a usar.jl")

x1 = range(-π/2,π/2;length=41)
y1 = z2.(x1)

a, b = Spline_linear_2(x1,y1)

c = 1
S = zeros((length(x1)-1)*100)
for i = 1:(length(x1)-1)
    f(z) = a[i] + b[i]*(z - x1[i])
    s = range(x1[i],x1[i+1]; length=100)
    for j = 1:100
        S[c] = f(s[j])
        c = c + 1
    end
end

x2 = range(-π/2,π/2;length=length(S))
y2 = z2.(x2)

erro = abs.(S.-y2)

plot(legend=:bottom)
plot!(x2,erro;c=:red,lab="Erro")
plot!(x1,y1;c=:blue,lab="Spline")
plot!(x2,y2;c=:green,lab="f")
scatter!(x1,y1;c=:black,lab="(xᵢ,f(xᵢ))")
xticks!(x1,["x₀","x₁","...","","","","","","","","","","","","","","","","","...","x₂₀","...","","","","","","","","","","","","","","","","","...","x₃₉","x₄₀"])
title!("Erro Spline linear")

png("Erro linear")


