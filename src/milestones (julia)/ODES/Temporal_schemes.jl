
module Temporal_schemes

  using NonlinearSolve
  using LinearAlgebra


#=
  Temporal_schemes

    Inputs: 
           U : state vector at tn
           dt: time step 
           t : tn 
           F(U,t) : Function dU/dt = F(U,t)

    Return: 
           U state vector at tn + dt    
=#

function Euler(U, dt, t, F)

    return U + dt * F(U, t)

end 


function RK4(U, dt, t, F ) 

  k1 = F( U, t)
  k2 = F( U + dt * k1/2, t + dt/2 )
  k3 = F( U + dt * k2/2, t + dt/2 )
  k4 = F( U + dt * k3,   t + dt   )

  return  U + dt * ( k1 + 2*k2 + 2*k3 + k4 )/6

end 

 function Inverse_Euler(U, dt, t, F) 

    function Residual(X, U) 
          return X - U - dt * F(X, t)
    end 

    problem = NonlinearProblem(Residual, U, U)
    return solve(problem) 

end 

function Crank_Nicolson(U, dt, t, F )

    function Residual_CN(X, U)

         a = U  +  dt/2 * F( U, t) 
         return  X - a - dt/2 *  F(X, t + dt)
    end 

    problem = NonlinearProblem(Residual_CN, U, U)
    return solve(problem) 


end 



function  Embedded_RK( U, dt, t, F, q, Tolerance)
  
    (a, b, bs, c) = Butcher_array(q)

    println(" q =", q )
    println(" size(a) =", size(a) )
    println(" size(c) =", size(c) )
    
    k = RK_stages( F, U, t, dt, a, c ) 
   # Error = dot( b-bs, k )
    Error = transpose( b-bs ) * k 

    dt_min = min( dt, dt * ( Tolerance / norm(Error) ) ^(1/q) )
    #N = Int( dt/dt_min  ) + 1
    N = trunc(Int, dt/dt_min) + 1
    h = dt / N
    Uh = copy(U)

    for i in 0:N-1 

        k = RK_stages( F, Uh, t + h*i, h, a, c ) 
       # Uh += h * dot( b, k )
       # Uh += h * transpose(b) * k 
        Uh += U + dt * transpose(k) * b
    end 

    return Uh

end 

function RK_stages( F, U, t, dt, a, c )

     Ns = size(c)[1]
     Nv = size(U)[1]
     k = zeros( Ns, Nv )
     println(" size(k) =", size(k) )

     for i in 1:Ns 
        global Up
        for  j in 1:Ns-1 
         # Up = U + dt * dot( a[i, :], k)
         # Up = U + dt * transpose( a[i, :] ) * k
          Up = U + dt * transpose(k) * a[i,:]
        end

        k[i, :] = F( Up, t + c[i] * dt ) 

     end

     return k 

end   


function Butcher_array(q)

    N_stages = Dict(2 => 2, 3 => 4, 8 => 13) 
    
    Ns =  N_stages[q]
    a = zeros(Ns, Ns); 
    b = zeros(Ns); bs = zeros(Ns); c = zeros(Ns) 
      
    if q==2 

     a[1,:] = [ 0, 0 ]
     a[2,:] = [ 1, 0 ] 
     b  = [ 1/2, 1/2 ] 
     bs = [ 1, 0 ] 
     c  = [ 0, 1]  

    elseif q==3 

      c = [ 0., 1. /2, 3. /4, 1. ]

      a[1,:] = [  0,  0,   0,   0 ]
      a[2,:] = [ 1/2, 0,   0,   0 ]
      a[3,:] = [ 0,	  3/4, 0,   0 ]
      a[4,:] = [ 2/9, 1/3, 4/9, 0	]

      b  = [ 2. /9,	1. /3,	4. /9,	0. ]
      bs = [ 7. /24,	1. /4,	1. /3,	1. /8 ]
   
    elseif q==8
          
       c = [ 0., 2. /27, 1. /9, 1. /6, 5. /12, 1. /2, 5. /6, 1. /6, 2. /3 , 1. /3,   1., 0., 1.]

       a[1,:]  = [ 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0] 
       a[2,:]  = [ 2. /27, 0., 0., 0., 0., 0., 0.,  0., 0., 0., 0., 0., 0] 
       a[3,:]  = [ 1. /36 , 1. /12, 0., 0., 0., 0., 0.,  0.,0., 0., 0., 0., 0] 
       a[4,:]  = [ 1. /24 , 0., 1. /8 , 0., 0., 0., 0., 0., 0., 0., 0., 0., 0] 
       a[5,:]  = [ 5. /12, 0., -25. /16, 25 ./16., 0., 0., 0., 0., 0., 0., 0., 0., 0]
       a[6,:]  = [ 1. /20, 0., 0., 1. /4, 1. /5, 0., 0.,0., 0., 0., 0., 0., 0] 
       a[7,:]  = [-25. /108, 0., 0., 125. /108, -65. /27, 125. /54, 0., 0., 0., 0., 0., 0., 0] 
       a[8,:]  = [ 31. /300, 0., 0., 0., 61. /225, -2. /9, 13. /900, 0., 0., 0., 0., 0., 0] 
       a[9,:]  = [ 2., 0., 0., -53. /6, 704. /45, -107. /9, 67. /90, 3., 0., 0., 0., 0., 0] 
       a[10,:]  = [-91. /108, 0., 0., 23. /108, -976. /135, 311. /54, -19. /60, 17. /6, -1. /12, 0., 0., 0., 0] 
       a[11,:] = [ 2383. /4100, 0., 0., -341. /164, 4496. /1025, -301. /82, 2133. /4100, 45. /82, 45. /164, 18. /41, 0., 0., 0] 
       a[12,:] = [ 3. /205, 0., 0., 0., 0., -6. /41, -3. /205, -3. /41, 3. /41, 6. /41, 0., 0., 0]
       a[13,:] = [ -1777. /4100, 0., 0., -341. /164, 4496. /1025, -289. /82, 2193. /4100, 51. /82, 33. /164, 19. /41, 0.,  1., 0]
      
       b  = [ 41. /840, 0., 0., 0., 0., 34. /105, 9. /35, 9. /35, 9. /280, 9. /280, 41. /840, 0., 0.] 
       bs = [ 0., 0., 0., 0., 0., 34. /105, 9. /35, 9. /35, 9. /280, 9. /280, 0., 41. /840, 41. /840]     
     
    else
             print("Butcher array  not avialale for order =", q)
             exit()
    end

    return (a, b, bs, c) 

end   

end 