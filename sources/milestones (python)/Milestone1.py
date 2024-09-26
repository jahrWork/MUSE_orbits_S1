 
from numpy import array, zeros, linspace
import matplotlib.pyplot as plt

from miscellaneous import decorators 

@decorators.profiling
def first_version(): 
    """ 
    This is a 101 code (our starting point) to integrate Kepler orbits with Euler method.

    The objective of this course is to learn how to write 
    functional programming codes by means of function composition 
    not to see data flow and to have reusable and easy to maintein codes.
    The idea is to mimic mathematical concepts or abstractions.  
    """

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

@decorators.profiling
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



@decorators.profiling
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

def Kepler(U, t): 

    x = U[0]; y = U[1]; dxdt = U[2]; dydt = U[3]
    d = ( x**2  +y**2 )**1.5

    return  array( [ dxdt, dydt, -x/d, -y/d ] ) 

def Euler(U, dt, t, F): 

    return U + dt * F(U, t)


if __name__ == "__main__":
  
  first_version()
  abstraction_for_F()
  abstraction_for_F_and_Euler()
   






