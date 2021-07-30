
function Splines_cubicas_fixadas(x,y,pd1,pdn)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    α = zeros(n+1)
    α[1] = 3*(a[2] - a[1])
    for i = 1:n
        h[i] = x[i+1] - x[i]
        if i == 1
            α[i] = 3*(a[2] - a[1])/h[1] - 3*pd1
        elseif i >= 2
            α[i] = 3*(a[i+1] - a[i])/h[i] - 3*(a[i] - a[i-1])/h[i-1]
        end
        if i == n
            α[i+1] = 3*pdn - 3*(a[i+1] - a[i])/h[i] 
        end
    end
    l, μ, z = zeros(n+1), zeros(n), zeros(n+1)
    l[1] = 2*h[1]
    μ[1] = 0.5
    z[1] = α[1]/l[1]
    for i = 2:n
        l[i] = 2*(x[i+1] - x[i-1]) - h[i-1]*μ[i-1]
        μ[i] = h[i]/l[i]
        z[i] = (α[i] - h[i-1]*z[i-1])/l[i]
    end
    l[n+1] = h[n]*(2 - μ[n])
    z[n+1] = (α[n+1] - h[n]*z[n])/l[n+1]
    c = zeros(n+1)
    c[n+1] = z[n+1]
    b = zeros(n)
    d = zeros(n)
    for i = n:-1:1
        c[i] = z[i] - μ[i]*c[i+1]
        b[i] = (a[i+1] - a[i])/h[i] - h[i]*(c[i+1] + 2*c[i])/3
        d[i] = (c[i+1] - c[i])/(3*h[i])
    end
    return a, b, c, d 
end