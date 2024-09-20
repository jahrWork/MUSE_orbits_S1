print("Hello world")

from numpy import array, zeros, linspace, sin, pi 
import matplotlib.pyplot as plt 


t = linspace(0., 1., 100)
y = sin( 2*pi*t )

plt.plot(t,y)
plt.show()