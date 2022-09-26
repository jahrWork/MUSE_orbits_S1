from numba import njit
from numpy import  zeros, float64, float32 
import decorators


@decorators.exceptions
@decorators.profiling
#@njit
def Cauchy_problem( F, t, U0, Temporal_scheme): 

     N, Nv=  len(t)-1, len(U0)
     U = zeros( (N+1, Nv), dtype=float64 ) 

     U[0,:] = U0

     for n in range(N):

        U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n],  F ) 

     return U
