
# import Pkg 
# Pkg.add(["CPUTime",  "LinearAlgebra", "MKL",  "CpuId", "LoopVectorization"])
#Pkg.add(["BenchmarkTools"])

using CPUTime, LinearAlgebra, MKL, CpuId

using BenchmarkTools
using Printf





function get_avx_value()

  cpuid = cpuinfo() 
  string_cpuid = string(cpuid)
   
  if occursin("256 bit", string_cpuid)
      AVX_value = 8
  elseif occursin("512 bit", string_cpuid)
      AVX_value = 16
  else
      AVX_value = 0
  end
  
  #println("AVX support: ", occursin("256", string_cpuid))
  #println("AVX-512 support: ", occursin("512 bit", string_cpuid))


  return AVX_value

end


function GFLOPs_max( )


  N_threads = Threads.nthreads()
  N_cores = trunc(Int, N_threads/2)
  AVX_value = get_avx_value()
  
  Theoretical_time = 1e9 /(4.5e9 * AVX_value * 2 * N_cores)
  GFLOPSmax = 1 / Theoretical_time

  return GFLOPSmax


end 


function memory_access(Nt, M)


  A = zeros( M, M)

  for k in 1:Nt
    for i in 1:M 
      for j in 1:M
            A[i,j]  = i 
      end 
    end 
  end  

  return A 

end

function mem_by_columns(Nt, M)


  A = zeros( M, M)

  for k in 1:Nt
    for j in 1:M 
      for i in 1:M
            A[i,j]  = i 
      end 
    end 
  end  

  return A 

end

function memory_allocate(Nt, M)

  
  A = zeros( M, M)

  for i in 1:Nt
   
    A = zeros( M, M)
    A[M,M]  = 1 

  end  

  return A

end


function mult_op(Nt, N)

  x = 2.6
  rho = 0.9999999999
  for j in 1:Nt 
    for i in 1:N^2 
     x = rho * x * j
    end 
  end 
  
 
  return x 

end 


function matmul(Nt, A, B, C)

  for j in 1:Nt 
    C = j *  A * B  
  end 
  
  return C 

end 

function matmul_1t(Nt, A, B, C)
  
  BLAS.set_num_threads(1)
  Threads.@threads for k in 1:Nt 
      C =  k * A * B 
  end

  return C 
end 


function mul(Nt, A, B, C)

  for j in 1:Nt 
    mul!(A, B, C)  
  end 
  
  return C 

end 



function mul_1t(Nt, A, B, C)

  BLAS.set_num_threads(1)
  Threads.@threads for j in 1:Nt
    mul!(A, B, C)  
  end 
  
  return C 

end 



function measure( operations, Nt, N, Nop )


  N_threads = Threads.nthreads()
  A = zeros(Float32, N, N)
  B = zeros(Float32, N, N)
  C = zeros(Float32, N, N)


  BLAS.set_num_threads(N_threads) 
  # warm up
  x = operations(Nt, A, B, C) 

  t1 = time_ns() 
  x = operations(Nt, A, B, C) 
  t2 = time_ns() 
  dt = t2 - t1 

  dt = @belapsed $operations($Nt, $A, $B, $C)
  dt =  dt * 1e9
  #println("t1 =", t1, " t2 = ", t2, " t2-t1 =", t2-t1)
  
  
  GFLOPS =  Nop / dt
  GFLOPS  = trunc(Int, GFLOPS)

  pretty_print(N, Nt,  operations, GFLOPS, BLAS.get_num_threads()  )

  return GFLOPS

end 




function pretty_print(c1, c2, c3, c4, c5)
       
      
  @printf("%10s %10s %-15s %10s  %10s  \n", c1, c2, c3, c4, c5)
 

end





# Nt = 2000
# N = 500 # minimal N =400 to have max velocity/2 with 32 cores 

# pretty_print("N", "Nt", "Operations", "GHz", "Threads" )


# GHz = measure(memory_access, Nt, N, N^2*Nt)
# # #println( "memory GHz_max= ", GHz_max )
# GHz = measure(mem_by_columns, Nt, N, N^2*Nt)
# println("\n")

# N = 10000000; Nt = 200000
# GFLOPSm = measure(mult_op, Nt, N, N^2*Nt)


pretty_print("N", "Nt", "Operations", "GFLOPS", "Threads" )
dim = [(50, 10000), (500, 200), (5000, 2)]
test =[ matmul, matmul_1t, mul, mul_1t]
for (N,Nt) in dim 
  for f in test 
    GFLOPS = measure(f,    Nt, N, 2*N^3*Nt)
  end 
end


println( "\n GFLOPS_max: ", GFLOPs_max()  )



