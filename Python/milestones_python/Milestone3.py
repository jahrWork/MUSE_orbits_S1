from ODES.Cauchy_problem import Cauchy_problem, Cauchy_problem_error, Temporal_convergence_rate
from ODES.Temporal_schemes import Euler, Inverse_Euler, Crank_Nicolson, Embedded_RK, RK4 
from Physics.Orbits import Kepler, oscillator 
import matplotlib.pyplot as plt
from numpy import array, cos, sin, pi, zeros, polyfit  
from numpy.linalg import norm 


 
from numpy import linspace


def Simulation_error(tf, N, U0, F): 
   

    t = linspace(0, tf, N)
    schemes = [  (Euler, 1, None ) ] #,  (Embedded_RK, 2, 1e-1), (Embedded_RK, 8, 1e-1)  ]
    
    for (method, order, eps)  in schemes:

       if order != None:  
          U, Error =  Cauchy_problem_error( F, t, U0, method, q=order, Tolerance=eps ) 
       else: 
          U, Error =  Cauchy_problem_error( F, t, U0, method ) 

       plt.axes().set_aspect('equal')
       plt.plot( U[:,0] , U[:,1], ".")
       plt.plot( cos(t) , -sin(t), ".")
       plt.show()

       E = zeros(len(t))
       for i in range(len(t)): 
          E[i] = norm( Error[i,:] )
       plt.plot( t, E, ".")
       plt.show()


def Convergence_error(tf, N, U0, F): 
   

    t = linspace(0, tf, N)
    schemes = [  (Euler, None, None ) ,  (RK4, None, None) , (Inverse_Euler, None, None), (Crank_Nicolson, None, None)  ]
    
    for (method, order, eps)  in schemes:

       log_N, log_E, order = Temporal_convergence_rate( t, F, U0, method)
     
       plt.axes().set_aspect('equal')
       plt.plot( log_N , log_E)
       plt.plot( log_N , log_E, ".")
       plt.show()
       



#Simulation_error(tf = 8*pi, N = 16000, U0 = array( [ 1., 0. ] ),   F = oscillator  )
Convergence_error(tf = 8*pi, N = 1000, U0 = array( [ 1., 0. ] ), F=oscillator )