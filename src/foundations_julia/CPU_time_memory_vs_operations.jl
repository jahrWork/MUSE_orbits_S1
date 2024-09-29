function memory_access(Nt, N)

  M = trunc(Int, sqrt(N))
  A = zeros( M, M)

  for i in 1:Nt
   
    A = zeros( M, M)
    A[M,M]  = 1 

  end  

  return A

end


function operations(Nt, N)

  x = 1.6
  for j in 1:Nt 
     
    rho = 0.999999999
    for i in 1:N 
     x = rho * x 
    end 

  end 
  return x 
end 

Nt = 10000
N = 90000 
A = @time memory_access(Nt, N)
x = @time operations(Nt, N)
println( "number of memory accesses = ", size(A)[1]^2 ) 
println( "number of operations = ", N, " x = ", x ) 

