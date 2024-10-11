from numpy import array, exp, product
from numpy.linalg import norm

v1 = array( [1, 2, 3 ] )
v2 = array( [1, 2, 3 ] ) 
x = array( [ 1, 2, 3]  ) 

def f(x): 
    
    return exp(x)


y1 = f(x)
y2 = array( list ( map(f, x) ) )
print( "mapping1 =", y1 )
print( "mapping2 =", y2 ) 

def filter1(x): 

    return x < 10 

y3 = y1[ y1 < 10 ]
y4 = array( list ( filter(filter1, y1) ) )
print( "filrer1 =", y3 )
print( "filter2 =", y4 ) 

y5 = product(x)
print( "reduce1 =", y5 )



