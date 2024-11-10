
from ODES.Cauchy_problem import Cauchy_problem
from ODES.Temporal_schemes import RK4

from numpy import           array, zeros, reshape, shape, linspace, concatenate, split, ceil, sqrt, pi   
from numpy.linalg import    norm

import matplotlib.pyplot as plt


#------------------------------------------------------------
#  Initial codition: 6 degrees of freedom per body  
#------------------------------------------------------------
def Initial_positions_and_velocities( Nc, Nb ): 
 
    U0 =  zeros(2*Nc*Nb)
    U1  = reshape( U0, (Nb, Nc, 2) )  
    r0 = reshape( U1[:, :, 0], (Nb, Nc) )     # position and velocity 
    v0 = reshape( U1[:, :, 1], (Nb, Nc) )

    # body 1 
    r0[0,:] = [ 1, 0, 0]
    v0[0,:] = [ 0, 0.4, 0]

    # body 2 
    v0[1,:] = [ 0, -0.4, 0] 
    r0[1,:] = [ -1, 0, 0]

    # body 3 
    r0[2, :] = [ 0, 1, 0 ] 
    v0[2, :] = [ -0.4, 0., 0. ] 
         
    # body 4 
    r0[3, :] = [ 0, -1, 0 ] 
    v0[3, :] = [ 0.4, 0., 0. ]  

    return U0  

#-----------------------------------------------------------------
#  dvi/dt = - G m sum_j (ri- rj) / | ri -rj |**3, dridt = vi 
#----------------------------------------------------------------- 
def F_NBody(U, t, Nb, Nc): 
     
 #   Write equations: Solution( body, coordinate, position-velocity )      
     Us  = reshape( U, (Nb, Nc, 2) )  
     F =  zeros(len(U))   
     dUs = reshape( F, (Nb, Nc, 2) )  
     
     r = reshape( Us[:, :, 0], (Nb, Nc) )     # position and velocity 
     v = reshape( Us[:, :, 1], (Nb, Nc) )
     
     drdt = reshape( dUs[:, :, 0], (Nb, Nc) ) # derivatives
     dvdt = reshape( dUs[:, :, 1], (Nb, Nc) )
    
     dvdt[:,:] = 0  # WARNING dvdt = 0, does not work 
    
     for i in range(Nb):   
       drdt[i,:] = v[i,:]
       for j in range(Nb): 
         if j != i:  
           d = r[j,:] - r[i,:]
           dvdt[i,:] = dvdt[i,:] +  d[:] / norm(d)**3 
    
     return F


#------------------------------------------------------------------
# Orbits of N bodies 
#      U : state vector
#      r, v: position and velocity points to U     
#------------------------------------------------------------------    
def Integrate_NBP():  
    
   def F(U,t): 
       return F_NBody(U, t, Nb, Nc) 

   N =  1000    # time steps 
   Nb = 4      # bodies 
   Nc = 3      # coordinates 

   t0 = 0; tf = 4 * pi 
   Time = linspace(t0, tf, N+1) # Time(0:N) 
 
   U0 = Initial_positions_and_velocities( Nc, Nb )
 
  #U = odeint(F_NBody, U0, Time)
   U = Cauchy_problem(F, Time, U0, RK4) 

   Us  = reshape( U, (N+1, Nb, Nc, 2) ) 
   r   = reshape( Us[:, :, :, 0], (N+1, Nb, Nc) ) 
   
   for i in range(Nb):
     plt.plot(  r[:, i, 0], r[:, i, 1] )
   plt.axis('equal')
   plt.grid()
   plt.show()
  


Integrate_NBP()  