using Plots
gr(size=(1920,1080))

function Spline_quadratica4(x,y)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    for i = 1:(n)
        h[i] = x[i+1]-x[i]
    end
    α = zeros(n+1)
    for i = 2:(n)
        α[i] = (a[i+1]-a[i])/h[i] - (a[i]-a[i-1])/h[i-1]
    end
    c = zeros(n+1)
    for i = 2:n
        c[i] = (α[i] - c[i-1]h[i-1])/h[i]
    end
    b = zeros(n+1)
    for i = 1:n
        b[i] = (a[i+1]-a[i])/h[i] - c[i]*h[i]
    end
    b[n+1] = b[n] + 2*c[n]*h[n]
    #plot
    #Sj(x) = aj + bj(x - xj) + cj(x - xj)^2
    for i = 1:n
        f(z) = a[i] + b[i]*(z - x[i]) + c[i]*(z - x[i])^2
        s = range(x[i],x[i+1]; length=100)
        if i == 1
            plot(f,s, c=:black, leg=false)
        else
            plot!(f,s, c=:black, leg=false)
        end
    end
    scatter!(x, a, c=:lightgray, aspect_ratio=:equal,leg=false)
    savefig("Splines quadraticas 1.png")
end
