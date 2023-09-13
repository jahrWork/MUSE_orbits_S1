from numba import njit, prange # import parallel range

from math import pi 
import decorators 



@decorators.profiling
def sum_series(N):  

   S = 0 

   for i in range(1, N+1):

       S +=  1 / i**2
  
   return S  

 
@decorators.profiling
@njit(parallel=True)
def sum_parallel(N):

    S = 0 
    
    for i in prange(1, N+1):    # parallel loop
     
        S += 1 / float(i)**2 

    return S 





#  number of terms to be added    
N = 2 **38 #   2*20

#SN = sum_series(N) 
#print( " SN =", SN)
#print( " Error =", pi**2/6 - SN)
#print("Error bound =  ", 1./N )

#  run with multiple cores 
SN = sum_parallel(N)
print( " SN =", SN)
print( " Error =", pi**2/6 - SN)
print("Error bound =  ", 1./N )

