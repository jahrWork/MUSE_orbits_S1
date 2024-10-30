from numpy import array, zeros, linspace, abs, transpose, float64


def Stability_Region(Scheme, N, x0, xf, y0, yf): 

    x, y = linspace(x0, xf, N), linspace(y0, yf, N)
    rho =  zeros( (N, N),  dtype=float64)

    for i in range(N): 
      for j in range(N):

          w = complex(x[i], y[j])
          r = Scheme( 1., 1., 0., lambda u, t: w*u )
          rho[i, j] = abs(r) 

    return rho, x, y  

