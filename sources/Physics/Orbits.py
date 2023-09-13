from numba import njit
from numpy import array, sqrt 


#@jit(nopython=True)
@njit
def Kepler(U, t): 

    x = U[0]; y = U[1]; dxdt = U[2]; dydt = U[3]
    d = ( x**2  +y**2 )**1.5

    return  array( [ dxdt, dydt, -x/d, -y/d ] ) 

@njit
def Arenstorf_equations(U, t):          
   
     mu = 0.012277471
           
     x = U[0]; y = U[1]; vx = U[2];  vy = U[3]   
 
     D1 = sqrt( (x+mu)**2     + y**2 )**3
     D2 = sqrt( (x-(1-mu))**2 + y**2 )**3
     
     dxdt = vx  
     dydt = vy  
     dvxdt = x + 2 * vy - (1-mu)*( x + mu )/D1 - mu*(x-(1-mu))/D2
     dvydt = y - 2 * vx - (1-mu) * y/D1 - mu * y/D2
    
     return array( [ dxdt, dydt, dvxdt, dvydt ] ) 

