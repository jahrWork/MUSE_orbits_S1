from numpy import array, zeros, linspace, sin, pi 
import matplotlib.pyplot as plt 


def F(U,t): 
    
    x, xd = U[0], U[1]

    return array( [  xd, -x ])


N = 200

U = array( zeros([N, 2]) ) 
t = array( zeros([N]) ) 
print( type(U) ) 

U[0, :] = array( [1, 0] )


dt = (4*pi)/N 
t = linspace(0., 1., N)

for n in range(0, N-1): 
  U[n+1, :] = U[n,:]  + dt * F( U[n, :], t[n] )

plt.axis("equal")
plt.plot( U[:, 0], U[:,1] )
plt.show()

