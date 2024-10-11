from numpy import array, abs, linspace, zeros, max, transpose   
import matplotlib.pyplot as plt

def Euler(U, dt, t, F): 

    return U + dt * F(U, t)


def Stability_region(scheme): 

    x, y = linspace(-2, 2, 100), linspace(-2, 2, 100)
    rho = zeros( (len(x), len(y)) )

    for i, xi in enumerate(x): 
        for j, yj in enumerate(y): 
           w = complex(xi, yj)     
           rho[i,j] =  abs( scheme(1., 1., 0., lambda U, t: w * U ) )

    return (x, y, rho) 

(x, y, rho) = Stability_region( Euler )

plt.contour( x, y, transpose(rho), linspace(0, 1, 11) )
plt.axis('equal')
plt.grid()
plt.show()

