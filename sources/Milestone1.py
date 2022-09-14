"""
This is a 101 code (our starting point) to integrate Kepler orbits with Euler method.

The objective of this course is to learn how to write 
functional programming codes by means of function composition 
not to see data flow and to have reusable and easy to maintein codes.
The idea is to mimic mathmatical concepts or abstractions.  
"""

from numpy import array, zeros
import matplotlib.pyplot as plt 


U = array( [ 1, 0, 0, 1 ])

N = 200 
x = array( zeros(N) )
y = array( zeros(N) )
x[0] = U[0] 
y[0] = U[1]

for i in range(1, N): 

  F = array( [ U[2], U[3], -U[0]/(U[0]**2+U[1]**2)**1.5, -U[1]/(U[0]**2+U[1]**2)**1.5 ] ) 
  dt = 0.1 
  U = U + dt * F 
  x[i] = U[0] 
  y[i] = U[1]

plt.plot(x, y)
plt.show()


