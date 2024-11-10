#from numba import njit
from numpy import  zeros, float64, float32, log10, polyfit, reshape 
#import miscellaneus.decorators
from miscellaneous import decorators 
from numpy.linalg import norm 

#@decorators.exceptions
#@decorators.profiling
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

     N, Nv =  len(t)-1, U0.size
     U = zeros( (N+1, Nv), dtype=type(U0) )
     #U = zeros( (N+1, Nv), dtype=float64 ) 

     U[0,:] = U0

     for n in range(N):

        if q != None and Tolerance !=None: 
          U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F, q, Tolerance ) 

        else: 
           U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F ) 

     return U


def Cauchy_problem_error( F, t, U0, Temporal_scheme,  q=None, Tolerance=None ): 
     """  
    Inputs:  same than Cauchy_problem 
       
    Return: 
           U: matrix[N+1, Nv], Nv state values at N+1 time steps  
           Error: matrix[N+1, Nv], Nv state values at N+1 time steps 
     """
     t1 = t 
     t2 = refine_mesh(t1)

     U1 = Cauchy_problem( F, t1, U0, Temporal_scheme, q, Tolerance)
     U2 = Cauchy_problem( F, t2, U0, Temporal_scheme, q, Tolerance)

     N =  len(t1)-1
     Nv = len(U0)
     Error = zeros( (N+1, Nv), dtype=type(U0) )

     for i in range(0, N+1):  
       Error[i,:] = ( U2[2*i, :]- U1[i, :] )

     if q != None:   
       Error = Error /( 1 - 1./2**q ) 

     return U1, Error



def refine_mesh(t1): 
      
      N = len(t1) - 1  
      t2 = zeros( 2*N +1, dtype=float64 ) 

      for i in range(0,N): 
           t2[2*i] =  t1[i]
           t2[2*i+1] = ( t1[i]  + t1[i+1] )/ 2 
      t2[2*N] = t1[N]      

      return t2 




# **********************************************************************************
#  It determines log Error versus log N step for a solutions of ODES
#  INPUTS : 
#           t:      initial partition time to integrate 
#           F:      physical problem 
#           U0:     initial condition for the solution  
#           Scheme: temporal scheme
#          
#  OUTPUTS:
#           log_N:  vector for the different number of time partitions 
#           log_E:  error for each time partition      
#           order:  order of Error of the temporal scheme 
# **********************************************************************************    
def Temporal_convergence_rate( t, F, U0, Scheme): 
                           
      N = len(t) - 1
      m = 7 
      log_E = zeros(m+1)
      log_N = zeros(m+1)

      t1 = t 
      for i in range(0,m+1):    
          
          N = len(t1) - 1
          U, Error =  Cauchy_problem_error( F, t1, U0, Scheme) 
          log_E[i] = log10 ( norm( Error[N, :]  ) ) 
          log_N[i] = log10( float(N) )  
          print(" Error =", norm(Error[N,:]), " N = ", N )

          t1 = refine_mesh(t1)
      
      y = log_E[ log_E > -12 ]
      x = log_N[ 0:len(y) ]
      order, b = polyfit(x, y, 1)

      print("order =", order, "b =", b)

      log_E = log_E - log10( 1 - 1./2**abs(order) ) 

      return  log_N, log_E, order

