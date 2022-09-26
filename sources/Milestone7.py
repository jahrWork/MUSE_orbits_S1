
from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler 
from Physics.Orbits import Kepler 

import matplotlib.pyplot as plt
import decorators 
from numba import njit 
from numpy import array, zeros, linspace

"""
This is our final version to integrate any problem with any temporal scheme.

Different abstractions : 
                     1) dU/dt = F(U, t) 
                     2) Temporal scheme to one step 
                     3) Cauchy problem to perform different steps 



"""

@decorators.debugging 
@decorators.exceptions
def Simulation(tf, N, U0): 

   
   
    t = linspace(0, tf, N)
        
    U =  Cauchy_problem( Kepler, t, U0, Euler) 

    plt.plot(U[:,0] , U[:,1])
    plt.show()



