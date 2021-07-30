
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
    return a, b, c 
end