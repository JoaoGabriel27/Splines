using Plots
gr(size=(800,400))

include("Spline cubica 1 valores.jl")

z2(x) = sin(2cos(2sin(2cos(2sin(2cos(2sin(x)))))))
x1 = range(-π/2,π/2;length=41)
y1 = z2.(x1)

a, b, c, d = Splines_cubicas_naturais(x1,y1)

cont = 1
S = zeros((length(x1)-1)*100)
for i = 1:(length(x1)-1)
    f(z) = a[i] + b[i]*(z - x1[i]) + c[i]*(z - x1[i])^2 + d[i]*(z - x1[i])^3
    s = range(x1[i],x1[i+1]; length=100)
    for j = 1:100
        S[cont] = f(s[j])
        cont = cont + 1
    end
end

x2 = range(-π/2,π/2;length=length(S))
y2 = z2.(x2)

erro = abs.(S.-y2)

plot(legend=:bottom)
plot!(x2,erro;c=:red,lab="Erro")
plot!(x2,S;c=:blue,lab="Spline")
plot!(x2,y2;c=:green,lab="f")
scatter!(x1,y1;c=:black,lab="(xᵢ,f(xᵢ))")
title!("Erro Spline Cúbica 1")
