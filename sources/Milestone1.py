"""
This is a 101 code (our starting point) to integrate Kepler orbits with Euler method.

The objective of this course is to learn how to write 
functional programming codes by means of function composition 
not to see data flow and to have reusable and easy to maintein codes.
The idea is to mimic mathmatical concepts or abstractions.  
"""

from numpy import array, zeros, linspace
import matplotlib.pyplot as plt 


def first_version(): 

    U = array( [ 1, 0, 0, 1 ])
    
    N = 200 
    x = array( zeros(N) )
    y = array( zeros(N) )
    x[0] = U[0] 
    y[0] = U[1]
    
    for i in range(1, N): 
    
      F = array( [ U[2], U[3], -U[0]/(U[0]**2+U[1]**2)**1.5, -U[1]/(U[0]**2+U[1]**2)**1.5 ] ) 
      dt = 0.1 
      U = U + dt * F 
      x[i] = U[0] 
      y[i] = U[1]
    
    plt.plot(x, y)
    plt.show()

def abstraction_for_F(): 

    U = array( [ 1, 0, 0, 1 ])
    
    N = 200 
    x = array( zeros(N) )
    y = array( zeros(N) )
    t = array( zeros(N) )
    x[0] = U[0] 
    y[0] = U[1]
    t[0] = 0 
    
    for i in range(1, N): 

      dt = 0.1 
      t[i] = dt*i
      F = Kepler( U, t[i-1])
    
      U = U + dt * F 
      x[i] = U[0] 
      y[i] = U[1]
    
    plt.plot(x, y)
    plt.show()




def abstraction_for_F_and_Euler(): 

    U = array( [ 1, 0, 0, 1 ])
    
    N = 200 
    x = array( zeros(N) )
    y = array( zeros(N) )
    t = array( zeros(N) )
    x[0] = U[0] 
    y[0] = U[1]
    t[0] = 0 
    
    for i in range(1, N): 

      dt = 0.1 
      t[i] = dt*i
      U = Euler(U, dt, t, Kepler)
      x[i] = U[0] 
      y[i] = U[1]
    
    plt.plot(x, y)
    plt.show()


"""
This is our final version to integrate any problem with any temporal scheme.

Diffetent abstraction : 
                     1) dU/dt = F(U, t) 
                     2) Temporal scheme to one step 
                     3) Cauchy problem to perform different steps 



"""


def abstraction_for_F_and_Euler_and_Cauchy_Problem(): 

    N = 200 
    U0 = array( [ 1, 0, 0, 1 ])
    t = linspace(0, 20, N)
        
    U =  Cauchy_problem( Kepler, t, U0, Euler) 

    plt.plot(U[:,0] , U[:,1])
    plt.show()





def Kepler(U, t): 

    x = U[0]; y = U[1]; dxdt = U[2]; dydt = U[3]
    d = ( x**2  +y**2 )**1.5

    return  array( [ dxdt, dydt, -x/d, -y/d ] ) 

def Euler(U, dt, t, F): 

    return U + dt * F(U, t)

def Cauchy_problem( F, t, U0, Temporal_scheme): 

     N, Nv=  len(t)-1, len(U0)
     U = array( zeros([N+1, Nv] ) )

     U[0,:] = U0

     for n in range(N):

        U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F ) 

     return U

