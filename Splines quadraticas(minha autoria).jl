using Plots
gr(size=(1920,1080))

function elimina_gauss!(A,α)
    m, n = size(A)
    for j = 1:n
        cols = j+1:n
        for i = j+1:m
            mij = A[i,j]/A[j,j]
            A[i,cols] -= mij * A[j,cols]
            A[i,j] = 0.0
            α[i] -= mij * α[j]
        end
    end
end

function resolve_sistema(A,α)
    m, n = size(A)
    x = zeros(n)
    for j = n:-1:1
        x[j] = α[j]
        for k = j+1:n
            x[j] -= A[j,k] * x[k]
        end
        x[j] = x[j]/A[j,j]
    end
    return x
end

function Spline_quadratica1(x,y)
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
    A = zeros(n+1,n+1)
    for i = 1:(n+1)
        for j = 1:(n+1)
            if i == j && (i == 1 || i == (n+1))
                A[i,j] = 1
            elseif i >= 2 && (i == j)
                A[i,j-1], A[i,j] = h[j-1], h[j]
            end
        end
    end
    elimina_gauss!(A,α)
    c = resolve_sistema(A,α)
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
