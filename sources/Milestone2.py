from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler, Inverse_Euler, Crank_Nicolson, Embedded_RK 
from Physics.Orbits import Kepler 
import matplotlib.pyplot as plt
from numpy import array 

 
from numpy import linspace


def Simulation(tf, N, U0): 
   
    t = linspace(0, tf, N)
    #schemes = [ Euler, Inverse_Euler, Crank_Nicolson, Embedded_RK ]
    schemes = [  (Euler, None, None ),  (Embedded_RK, 2, 1e-1), (Embedded_RK, 8, 1e-1)  ]
    #schemes = [  (Euler, None, None )  ]

    
    for (method, order, eps)  in schemes:

       if order != None:  
          U =  Cauchy_problem( Kepler, t, U0, method, q=order, Tolerance=eps ) 
       else: 
          U =  Cauchy_problem( Kepler, t, U0, method ) 

       plt.plot( U[:,0] , U[:,1], "." )
       plt.show()

if __name__ == "__main__":

  Simulation(100, 100, array( [ 1., 0., 0., 1. ] ) )