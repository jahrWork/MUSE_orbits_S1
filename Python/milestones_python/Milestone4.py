from ODES.Temporal_schemes import Euler, RK4, Inverse_Euler, Crank_Nicolson
from ODES.Stability_regions import Stability_Region
from numpy import transpose, linspace 
import matplotlib.pyplot as plt

def test_Stability_regions(): 

    schemes = [RK4, Inverse_Euler, Euler, Crank_Nicolson] 

    for scheme in schemes: 
      rho, x, y  = Stability_Region(scheme, 100, -4, 2, -4, 4)
      plt.contour( x, y, transpose(rho), linspace(0, 1, 11) )
      plt.axis('equal')
      plt.grid()
      plt.show()


    
    
if __name__ == '__main__':  
   test_Stability_regions()