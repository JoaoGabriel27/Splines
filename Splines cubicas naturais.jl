using Plots
gr(size=(800,400))

function Splines_cubicas_naturais(x,y)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    α = zeros(n)
    for i = 1:n
        h[i] = x[i+1] - x[i]
        if i >= 2
            α[i] = 3*(a[i+1] - a[i])/h[i] - 3*(a[i] - a[i-1])/h[i-1]
        end
    end
    l, μ, z = zeros(n+1), zeros(n), zeros(n+1)
    l[1] = 1
    for i = 2:n
        l[i] = 2*(x[i+1] - x[i-1]) - h[i-1]*μ[i-1]
        μ[i] = h[i]/l[i]
        z[i] = (α[i] - h[i-1]*z[i-1])/l[i]
    end
    l[n+1] = 1
    c = zeros(n+1)
    b = zeros(n)
    d = zeros(n)
    for i = n:-1:1
        c[i] = z[i] - μ[i]*c[i+1]
        b[i] = (a[i+1] - a[i])/h[i] - h[i]*(c[i+1] + 2*c[i])/3
        d[i] = (c[i+1] - c[i])/(3*h[i])
    end
    #plot
    #Sj(x) = aj + bj(x - xj) + cj(x - xj)^2 + dj(x - xj)^3
    for i = 1:n
        f(o) = a[i] + b[i]*(o - x[i]) + c[i]*(o - x[i])^2 + d[i]*(o - x[i])^3
        s = range(x[i],x[i+1]; length=100)
        if i == 1
            plot(f,s, c=:black,leg=false)
        else
            plot!(f,s, c=:black,leg=false)
        end
    end
    scatter!(x, a, c=:lightgray, aspect_ratio=:equal,leg=false)
    savefig("Splines cubicas naturais.png")
end

