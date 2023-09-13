from numpy import array, zeros, max, dot 


def  Gauss(A, b):
   """
 _________________________________________________________
 Solutions to a system of linear equations A x  =b
 Method: Gauss elimination (with scaling and pivoting)
 
   Inputs: 
          A : system matrix, 
          b : independent term 
  return:
          x 
          note: matrix A and b term are modified 

 Juan A. Hernandez, juanantonio.hernandez@upm.es (Oct 2022) 
 

________________________________________________________________  

Testing: 

 >>> Gauss( array( [ array( [1, 1, 1] ), array( [1, -1, -1] ), array( [1, -1, 1] )  ] ), array( [1, 2, 3 ] ) )
 array([ 1.5, -1., 0.5])

 >>> Gauss( array( [ array( [1, 2, 3] ), array( [1, -2, -3] ), array( [1, -2, 3] )  ] ), array( [1, 2, 3 ] ) )
     array([ 1.5, -0.5,  1/6.]) 

   """
   
   N = len(b);  x = zeros(N) 
  
#  begin forward elimination
   for k, _ in enumerate(A): 
     pivoting_row_swapping( A, b, k, N)

#    the elimination (after swapping)
#    for all rows below pivot:
     for i in range(k+1, N):  
       c = A[i, k] / A[k,k]  
       A[i, k:N] = A[i, k:N] - c * A[k, k:N] 
       b[i] = b[i] - c * b[k] 
     
#  back substiturion
   for i in range(N-1, -1, -1):
   #for i, _ in reversed( list( enumerate(x) ) ):
     x[i] = ( b[i] - dot( A[i,i:N], x[i:N] ) )/ A[i,i]

   return x 




def pivoting_row_swapping( A, b, k, N): 

     s = zeros(N);

#    s[i] is the largest element of row i
     for i in range(k, N):   # loop over rows
       s[i] = max( abs(A[i,k:N]) ) 
      
#    find a row with the largest pivoting element
     pivot = abs( A[k,k] / s[k] )
     l = k
     for j in range(k, N): 
       if abs( A[j,k] / s[j] ) > pivot: 
          pivot = abs( A[j,k] / s[j] )
          l = j

#    Check if the system has a sigular matrix
     if pivot == 0.0 :  print(" The matrix is singular "); exit()
       
#    pivoting: swap rows k and l (if needed)
     if l != k : 
       #( A[k,k:N], A[l,k:N] ) = ( A[l,k:N].copy(), A[k,k:N].copy() )
        A[ [k, l] ,k:N] =  A[ [l, k], k:N]  
        ( b[k], b[l] ) =  ( b[l], b[k] )



if __name__ == "__main__":

    import doctest
    doctest.testmod( verbose = True)

    #print( Gauss.__doc__)