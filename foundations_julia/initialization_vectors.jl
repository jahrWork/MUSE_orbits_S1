using LinearAlgebra

function initialization_vectors_and_matrices()

    

    U = [1, 1/2] 
    println("U = ", U)
    
    println(typeof(U), "\n")

    A = zeros(2,2)
    A[1, :] = [ 1, 2 ]  # row 1 of matrix A 
    A[2, :] = [ 3, 4 ]  # row 2 of matrix A 
    #println("U * A = ", U * A ) # ERROR: non conformal matrices
    println("U * A = ", transpose(U) * A, "\n" )




    A = zeros(3,2)
    A[1, :] = [ 1, 2 ]  # row 1 of matrix A 
    A[2, :] = [ 3, 4 ]  # row 2 of matrix A 
    A[3, :] = [ 5, 6 ]  # row 3 of matrix A  
    println( A[1,:] ) 
    println(typeof(A), "\n")
   

    # vector of vectors 
    B = [ [ 1, 2], [3,4] ] 
    println(typeof(B), "\n")

    # matrix : [ column1 column2 column3 ]
    C = [ [ 1, 2] [3,4] [5,6] ] 
    println("C = ", C)
    println("C = ", C[1,:] )
    println(typeof(C), "\n")

    D = [1 2 ; 3 4; 5 6]
    println("D = ", D)
    println("D = ", D[1,:] )
    println(typeof(D), "\n")
   
    println("transpose(D) = ", transpose(D) ) 
    println("transpose(D) = ", transpose(D)[1,:] ) 

    E = [1 2 ; 3 4]
    println("trace(E) = ", tr(E), "\n" ) 


    Ns = 2; Nv = 4
    k = zeros( Ns, Nv )
    a = zeros(Ns, Ns) 
    i = 1 
    println( size(k), "   ", size(a) )
    U = [1, 2, 3, 4]
    dt = 0.1
    V =  transpose( a[i, :] ) * k
    Up = U + dt * transpose(V)
    print(" u = ", Up)

  
    Up = U + dt * transpose(k) * a[i,:]
    print(" u = ", Up)


end 

initialization_vectors_and_matrices()