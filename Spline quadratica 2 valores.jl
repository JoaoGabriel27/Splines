
function Spline_quadratica3(x,y)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    for i = 1:(n)
        h[i] = x[i+1]-x[i]
    end
    α = zeros(n+1)
    for i = 2:(n+1)
        α[i] = 2*(a[i]-a[i-1])/h[i-1]
    end
    b = zeros(n+1)
    for i = 2:n+1
        b[i] = α[i] - b[i-1]
    end
    c = zeros(n+1)
    for i = 1:n
        c[i] = (b[i+1] - b[i])/(2*h[i])
    end
    return a, b, c
end