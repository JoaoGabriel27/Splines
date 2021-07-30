#como o spline linear é simplismente ligar xᵢ com xᵢ₊₁ por uma reta utilizamos o plot em cada intervalo
using Plots
gr(size=(1920,1080))

function Spline_linear_1(x,y)
    plot!(x,y, c=:gray, aspect_ratio=:equal, leg=false)
    scatter!(x,y, c=:black, leg=false)
end

#Porém, existe o metodo matemático para encontrar n-1 retas que ligam os n pontos

function Spline_linear_2(x,y)
    n = length(x) - 1
    a = copy(y)
    h = zeros(n)
    b = zeros(n)
    for i = 1:n
        h[i] = x[i+1]-x[i]
        b[i] = (a[i+1]-a[i])/h[i]
    end
    #plot
    for i = 1:n
        f(z) = a[i] + b[i]*(z - x[i])
        s = range(x[i],x[i+1]; length=100)
        if i == 1
            plot(f,s, c=:black, leg=false)
        else
            plot!(f,s, c=:black, leg=false)
        end
    end
    scatter!(x, a, c=:lightgray, aspect_ratio=:equal,leg=false)
    savefig("Splines lineares.png")
end
