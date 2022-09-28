from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler, Crank_Nicolson 
from Physics.Orbits import Kepler 
import matplotlib.pyplot as plt

 
from numpy import linspace


def Simulation(tf, N, U0): 
   
    t = linspace(0, tf, N)
    schemes = [ Euler, Crank_Nicolson ]
    
    for method in schemes:
       U =  Cauchy_problem( Kepler, t, U0, method) 
       plt.plot(U[:,0] , U[:,1])
       plt.show()

   