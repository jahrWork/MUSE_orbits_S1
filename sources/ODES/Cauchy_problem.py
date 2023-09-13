from numba import njit
from numpy import  zeros, float64, float32 
#import miscellaneus.decorators
from miscellaneous import decorators 


#@decorators.exceptions
@decorators.profiling
#@njit
def Cauchy_problem( F, t, U0, Temporal_scheme, q=None, Tolerance=None ): 
     """
  

    Inputs:  
           F(U,t) : Function dU/dt = F(U,t) 
           t : time partition t (vector of length N+1)
           U0 : initial condition at t=0
           Temporal_schem 
           q : order o scheme (optional) 
           Tolerance: Error tolerance (optional)

    Return: 
           U: matrix[N+1, Nv], Nv state values at N+1 time steps     
     """

     N =  len(t)-1
     Nv = len(U0)
     #U = zeros( (N+1, Nv), dtype=type(U0) )
     U = zeros( (N+1, Nv), dtype=float64 ) 

     U[0,:] = U0

     for n in range(N):

        if q != None: 
          U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F, q, Tolerance ) 

        else: 
           U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F ) 

     return U
