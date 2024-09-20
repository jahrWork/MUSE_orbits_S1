
from numpy import array, zeros
from numpy.linalg import norm  
from Linear_systems import Gauss 


def Newton(F, x0):  
  """
 ____________________________________________________________________
  Newton solver 
        Inputs: 
                x0   : initial guess and output value 
                F(X) : vector function  
        return: 
                x : solution (F(x)=0)

  Author: Juan A Hernandez (juanantonio.hernandez@upm.es) Oct 2022 
_____________________________________________________________________
  """
  
  iteration = 0; itmax = 1000
  x = x0; Dx = x0  
  print("x0 =", x0)
 
  while  norm(Dx) > 1e-8 and iteration <= itmax : 
    
      iteration = iteration + 1 
      J = Jacobian( F, x0 ) 
         
      b = -F(x0);
      Dx = Gauss( J, b) 
      x[:] = x[:] + Dx  # WARNING x = x + Dx (does not work)
      
      print("x =", x, "iteration =", iteration, "Newton norm(Dx) = ",  norm(Dx) ) 

  return x 

  
def Jacobian( F, x ):  

   Dx = 1e-3     
   Dxi = zeros( len(x) ) # WARNING Dxi = x does not work 
   J = zeros( (len(x), len(x)) )
       
   for i, _ in enumerate(x):

       Dxi[:] = 0
       Dxi[i] = Dx
       J[:,i] =  ( F(x + Dxi) - F(x - Dxi) )/(2*Dx)  
   
   return J    






def f(x): 

    return array( [ x**2 - 1 ] ) 

x0 = array( [ 0.1 ])
print(" solution =", Newton(f, x0 ) )