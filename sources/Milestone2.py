from ODES.Cauchy_problem import Cauchy_problem 
from ODES.Temporal_schemes import Euler, Crank_Nicolson 
from Physics.Orbits import Kepler 
import matplotlib.pyplot as plt

 
from numpy import linspace


def Simulation(tf, N, U0): 
   
    t = linspace(0, tf, N)
        
    U =  Cauchy_problem( Kepler, t, U0, Euler) 

    plt.plot(U[:,0] , U[:,1])
    plt.show()

    U =  Cauchy_problem( Kepler, t, U0, Crank_Nicolson) 

    print( type(U) )
    plt.plot(U[:,0] , U[:,1])
    plt.show()
