from numpy import  cos, log, pi, exp, sqrt 

import math 

class dual_number: 
    
    def __init__(self, x, y): 
        self.x = x 
        self.y = y 
        
    def __add__(self, z): 
        
           if isinstance (z, int) or isinstance (z, float) :

              return dual_number (self.x + z, self.y )

           else :

              x1, y1 = self.x, self.y
              x2, y2 = z.x, z.y
            
              return dual_number( x1+x2, y1+y2)

    __radd__ = __add__
          
    def __sub__(self, z): 
         
           if isinstance (z, int) or isinstance (z, float) :

              return dual_number (self.x - z, self.y )

           else :

             x1, y1 = self.x, self.y
             x2, y2 = z.x, z.y
             
             return dual_number( x1-x2, y1-y2)
      
    __rsub__ = __sub__    

    def __mul__(self, z): 
       
       
         if isinstance (z, int) or isinstance (z, float) :

              return dual_number (z * self.x, z * self.y )

         else:    

           x1, y1 = self.x, self.y
           x2, y2 = z.x, z.y
           
           return dual_number( x1*x2, x1*y2 + y1*x2)

    __rmul__ = __mul__
   
             
    def __truediv__(self, z): 
         
        
         if isinstance (z, int) or isinstance (z, float) :

              return dual_number ( self.x / z, self.y / z )

         else:   


           x1, y1 = self.x, self.y
           x2, y2 = z.x, z.y

           return dual_number( x1*x2 / x2**2, (y1*x2 - x1*y2) / x2**2 )

    __rtruediv__ = __truediv__

    def __pow__(self, w): 
         
          z = self

          return expd( w * logd(z) )
        
        
    def __str__(self):

         return f"({self.x}, {self.y})"   

  
def sin(z): 

    x, y = z.x, z.y 

    return dual_number( math.sin(x), y * math.cos(x) )

#def sind(z): 

#    return dual_number( sin(z.x), z.y * cos(z.x) ) 

#def logd(z): 

#    return dual_number( log(z.x), z.y / z.x )  

#def expd(z): 

#    return dual_number( exp(z.x), z.y * exp(z.x) )  

#def sqrtd(z): 

#    return dual_number( sqrt(z.x), z.y / ( 2*sqrt(z.x) ) )  



def derivative(f): 

    def fp(x): 

        z = dual_number(x, 1)
        w = f(z)
        return w.y
     
    return fp


def f(x): 

    return sin( pi  * x ) 

#x = 3.5
#z = dual_number(x, 1)
#print( " z = ", z.x, z.y)

#w =  sqrtd(  logd(z) * sind( pi * (1 + 2*z + z**2) ) / pi ) 

#print( " w = ", w.x, w.y)

fp = derivative(f) 
print(fp(1.5))