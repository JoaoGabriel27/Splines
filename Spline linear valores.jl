
function Spline_linear_2(x,y)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    b = zeros(n)
    for i = 1:n
        h[i] = x[i+1]-x[i]
        b[i] = (a[i+1]-a[i])/h[i]
    end
    return a, b
end