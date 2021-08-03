using Images, FileIO, Colors

include("Spline cubica 1 valores.jl")

function resize_image(img, T)
    aux_img = img
    img = load(img)
    cont = 1
    di = 0
    if typeof(img) == Matrix{RGB{N0f8}}
        img = float64.(channelview(img))
        di, m, n = size(img)
        if T < 1.0
            nova_img = zeros(di,m,n)
        else
            nova_img = zeros(di,Int64(floor(T*m)),Int64(floor(T*n)))
        end
        print("Espere um instante \n")
        print("Termina em ...")
        for h = 1:di
            x = range(1,n;length=n)
            xn = range(1,n;length=Int64(floor(T*n)))
            for i in 1:m
                a, b, c, d = Splines_cubicas_naturais(x,img[h,i,:])
                for j = 1:(n-1)
                    f(r) = (a[j]) + (b[j])*(r - x[j]) + (c[j])*(r - x[j])^2 + (d[j])*(r - x[j])^3
                    for k = 1:(Int64(floor(T))+1)
                        if xn[cont] >= x[j] && xn[cont] <= x[j+1]
                            z = f.(xn[cont])
                            if z < 0
                                z = 0.0
                            elseif z > 1
                                z = 1.0
                            end
                            nova_img[h, i, cont] = z
                            cont = cont + 1
                        end
                    end
                end
                cont = 1
            end
            x = range(1,m;length=m)
            xm = range(1,m;length=Int64(floor(T*m)))
            for i in 1:Int64(floor(T*n))
                a, b, c, d = Splines_cubicas_naturais(x,nova_img[h,:,i])
                for j = 1:(m-1)
                    f(r) = (a[j]) + (b[j])*(r - x[j]) + (c[j])*(r - x[j])^2 + (d[j])*(r - x[j])^3
                    for k = 1:(Int64(floor(T)+1))
                        if xm[cont] >= x[j] && xm[cont] <= x[j+1]
                            z = f.(xm[cont])
                            if z < 0
                                z = 0.0
                            elseif z > 1
                                z = 1.0
                            end
                            nova_img[h,cont, i] = z
                            cont = cont + 1
                        end
                    end
                end
                cont = 1
            end
            g = [3,2,1]
            print(g[h],"...")
        end
        print("Terminou!")
        name = string(T*m)*"x"*string(T*n)*"_"*aux_img
        if T < 1.0
            nova_nova_img = zeros(3,Int64(floor(T*m)),Int64(floor(T*n)))
            nova_nova_img[1:3,1:Int64(floor(T*m)),1:Int64(floor(T*n))] = nova_img[1:3,1:Int64(floor(T*m)),1:Int64(floor(T*n))]
            nova_nova_img = colorview(RGB,nova_nova_img)
            save(name,nova_nova_img)
        else
            nova_img = colorview(RGB,nova_img)
            save(name,nova_img)
        end
    elseif typeof(img) == Matrix{Gray{N0f8}}
        m, n = size(img)
        if T < 1.0
            nova_img = zeros(m,n)
        else
            nova_img = zeros(Int64(floor(T*m)),Int64(floor(T*n)))
        end
        img = float64.(channelview(img))
        x = range(1,n;length=n)
        xn = range(1,n;length=Int64(floor(T*n)))
        print("Espere um instante \n")
        for i in 1:m
            a, b, c, d = Splines_cubicas_naturais(x,img[i,:])
            for j = 1:(n-1)
                f(r) = (a[j]) + (b[j])*(r - x[j]) + (c[j])*(r - x[j])^2 + (d[j])*(r - x[j])^3
                for k = 1:(Int64(floor(T))+1)
                    if xn[cont] >= x[j] && xn[cont] <= x[j+1]
                        z = f.(xn[cont])
                        if z < 0
                            z = 0.0
                        elseif z > 1
                            z = 1.0
                        end
                        nova_img[i, cont] = z
                        cont = cont + 1
                    end
                end
            end
            cont = 1
        end
        print("Quase pronto...")
        x = range(1,m;length=m)
        xm = range(1,m;length=Int64(floor(T*m)))
        for i in 1:Int64(floor(T*n))
            a, b, c, d = Splines_cubicas_naturais(x,nova_img[:,i])
            for j = 1:(m-1)
                f(r) = (a[j]) + (b[j])*(r - x[j]) + (c[j])*(r - x[j])^2 + (d[j])*(r - x[j])^3
                for k = 1:(Int64(floor(T)+1))
                    if xm[cont] >= x[j] && xm[cont] <= x[j+1]
                        z = f.(xm[cont])
                        if z < 0
                            z = 0.0
                        elseif z > 1
                            z = 1.0
                        end
                        nova_img[cont, i] = z
                        cont = cont + 1
                    end
                end
            end
            cont = 1
        end
        print("Terminou!")
        name = string(T*m)*"x"*string(T*n)*"_"*aux_img
        if T < 1.0
            nova_nova_img = zeros(Int64(floor(T*m)),Int64(floor(T*n)))
            nova_nova_img[1:Int64(floor(T*m)),1:Int64(floor(T*n))] = nova_img[1:Int64(floor(T*m)),1:Int64(floor(T*n))]
            nova_nova_img = colorview(Gray,nova_nova_img)
            save(name,nova_nova_img)
        else
            nova_img = colorview(Gray,nova_img)
            save(name,nova_img)
        end
    end
end



