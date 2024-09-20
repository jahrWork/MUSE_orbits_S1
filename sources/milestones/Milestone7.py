
from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler, RK4, Embedded_RK 
from Physics.Orbits import Kepler, Arenstorf_equations 

import matplotlib.pyplot as plt
#import decorators 
from miscellaneous import decorators 
from numba import njit 
from numpy import array, zeros, linspace



@decorators.profiling 
def Arenstorf_orbit(tf, N, scheme, q = None, Tolerance = None):  

    U0 = array([ 0.994, 0., 0., -2.0015851063790825 ])
    t = linspace(0, tf, N) 
    U = Cauchy_problem( Arenstorf_equations, t, U0, scheme, q, Tolerance)
    plt.axes().set_aspect('equal')
    plt.plot(U[:,0] , U[:,1], ".")
    plt.show()
   
  

if __name__ == "__main__":

  #(tf = 100, N = 100, U0 = array( [ 1., 0., 0., 1. ] ) )

  tf = 5*17.0652165601579625  
  N = 100000

  Arenstorf_orbit( tf, N, RK4 )
  Arenstorf_orbit( tf, N, Embedded_RK, 8, 1e-8 )

