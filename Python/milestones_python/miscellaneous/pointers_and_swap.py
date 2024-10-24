from  numpy import array, zeros, reshape 

# scalar variable: alias is not possible 
a = 3 
pa = a 
print("pa =", pa, "id(pa)= ", id(pa), "id(a) =", id(a) )
a = 4  # creates a new object 
print("pa =", pa, "id(pa)= ", id(pa), "id(a) =", id(a) )

# lists 
a = [ 1, 2, 3]
pa = a # alias
pc = a[:] # this is cloning 
a[0] = 0
print( pa, pc)

# *********************************
# vectors 
#**********************************
v = array( [1, 2, 3, 4] )
print(" id(v) = ", id(v) )
pa1 = v           # alias
pa2 = v[:]        # alias 
pc = v[:].copy()  # cloning 
v[0] = 0
print( " pa1 =", pa1, "pa2 =",  pa2, " pc = ", pc)

v = v + 1  # it does not modify pa1 
print( " pa1 =", pa1, "v =",  v, "id(v) =", id(v))

pv = reshape( v, [2,2] ) 
pv[:,:] = pv[:,:] + 1 
print( " pv =", pv, "v =", v,  "id(pv) =", id(pv))
v[:] = v[:] + 1 
print( " pv =", pv, "v =", v,  "id(pv) =", id(pv))


#************************************************
# swapping 
#************************************************

#(U[1, :], V[1, :]) = (V[1, :], U[1, :]) 
## it does nor work as expected 
def wrong_swap(U, V): 

    return (V, U) 

def swap(U, V): 

    return V.copy(), U.copy() 

U = array([ [1,2,3], [4, 5, 6], [7, 8, 9] ] )
print("U=", U)

(i1, i2) = (0, 2)

U[ [i1, i2], :] = U[ [i2, i1], :]

print("U=", U)

##( U[1,:], V[1,:] ) = wrong_swap( U[1,:], V[1,:] )
#( U[1,:], V[1,:] ) = swap( U[1,:], V[1,:] )
#U[]

#print("V=", V)


V = U  + 1
print(id(U), id(V) )
print(U)
print(V)

#************************************************
# superficial copy and deepcopy  
#************************************************
from copy import deepcopy 

A = [ [1,2], [3,4] ]
B = A.copy()      # superficial copy
A[1][1] = 0 
print("\nB = ", B )
print("A = ", A )


A = [ [1,2], [3,4] ]
B = deepcopy(A) # deep copy 
C = [ e for e in A ]  # it is not a deep copy 
D = C  # alias 
N, M = len(A), len(A[0])
print(N,M)
E = [ [ 10 for i in range(N) ] for j in range(M) ]  # [ [10,10], [10,10] ] 
#E[:] = A[:]
#for i in range(N): 
#    for j in range(M): 
#        E[i][j] = A[i][j]
A[1][1] = 0 
print("\nB = ", B )
print("A = ", A )


print("\nC = ", C )
print("\nD = ", D )
print("\nE = ", E )