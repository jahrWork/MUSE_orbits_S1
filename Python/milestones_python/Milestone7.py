
from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler, RK4, Embedded_RK 
from Physics.Orbits import Kepler, Arenstorf_equations 

import matplotlib.pyplot as plt
from miscellaneous import decorators 
#from numba import njit 
from numpy import array, zeros, linspace



#@decorators.profiling 
def Arenstorf_orbit():  

    tf = 2*17.0652165601579625  
    N = 500 
    U0 = array([ 0.994, 0., 0., -2.0015851063790825 ])

    t = linspace(0, tf, N) 
    schemes = [  (RK4, None, None ),  (Embedded_RK, 8, 1e-9)  ]
    
    for (method, order, eps)  in schemes:
      U = Cauchy_problem( Arenstorf_equations, t, U0, method, q=order, Tolerance=eps)
      plt.axes().set_aspect('equal')
      plt.plot(U[:,0] , U[:,1], ".")
      plt.show()
   
  


Arenstorf_orbit( )


