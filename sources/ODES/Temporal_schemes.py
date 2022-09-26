from numba import njit
from scipy.optimize import newton


"""
  Temporal_schemes

    Inputs: 
           U : state vector at tn
           dt: time step 
           t : tn 
           F(U,t) : Function dU/dt = F(U,t)

    Return: 
           U state vector at tn + dt    
"""


@njit
def Euler(U, dt, t, F): 

    return U + dt * F(U, t)


def Inverse_Euler(U, dt, t, F): 

    def Residual(X): 
          return X - U - dt * F(X, t)

    return newton(func = Residual, x0 = U ) 

#@njit
def Crank_Nicolson(U, dt, t, F ): 

    def Residual_CN(X): 
         
         return  X - a - dt/2 *  F(X, t + dt)

    a = U  +  dt/2 * F( U, t)  
    return newton( Residual_CN, U )

