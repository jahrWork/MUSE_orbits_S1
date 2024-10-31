
# import Pkg 
# Pkg.add(["CPUTime",  "LinearAlgebra", "MKL",  "CpuId", "LoopVectorization"])
#Pkg.add(["BenchmarkTools"])

using CPUTime, LinearAlgebra, MKL, CpuId, LoopVectorization

using BenchmarkTools


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
function memory_access2(Nt, M)


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


function operations(Nt, N)

  x = 2.6
  rho = 0.9999999999
  for j in 1:Nt 
    for i in 1:N^2 
     x = rho * x 
    end 
  end 
  
  return x 

end 

function matmul(Nt, N)

  A = zeros(Float32, N, N)
  B = zeros(Float32, N, N)
  C = zeros(Float32, N, N)

  for j in 1:Nt 
    C = j *  A * B  
  end 
  
  return C 

end 

function measure( operations, Nt, N, Nop )


  N_threads = Threads.nthreads()
  N_cores = trunc(Int, N_threads/2)
  AVX_value = get_avx_value()
  println("AVX_value  ", AVX_value, " N_cores = ", N_cores) 
  
  Theoretical_time = 1e9 /(4.5e9 * AVX_value * 2 * N_cores)
  GFLOPS_max = 1 / Theoretical_time

  BLAS.set_num_threads(N_threads) 
  println( "num_threads = ", BLAS.get_num_threads() )


  t1 = time_ns() 
  x = operations(Nt, N) 
  t2 = time_ns() 
  #println("t1 =", t1, " t2 = ", t2, " t2-t1 =", t2-t1)
  
  
  GFLOPS = Nop / (t2-t1)

  return GFLOPS, GFLOPS_max, x 

end 




function get_avx_value()

  cpuid = cpuinfo() 
  string_cpuid = string(cpuid)
  #println("AVX support: ", occursin("256", string_cpuid))
  #println("AVX-512 support: ", occursin("512 bit", string_cpuid))
   
  if occursin("256 bit", string_cpuid)
      AVX_value = 8
  elseif occursin("512 bit", string_cpuid)
      AVX_value = 16
  else
      AVX_value = 0
  end
  
  return AVX_value

end





Nt = 100
N = 50 

# A = @time memory_access(Nt, N)

# A = @time memory_access2(Nt, N)
# #A = @time memory_allocate(Nt, N)
# x = @time operations(Nt, N)
# println( "number of memory accesses = ", N^2 ) 
# println( "number of operations = ", N^2) 

GHz, GHz_max, _ = measure(memory_access, Nt, N, N^2*Nt)
println( "memory GHz = ", GHz ) 
println( "memory GHz_max= ", GHz_max )


GFLOPSm, GFLOPS_max, _ = measure(operations, Nt, N, N^2*Nt)
println( "GFLOPS operations = ", GFLOPSm ) 
println( "GFLOPS_max= ", GFLOPS_max )

println("")
GFLOPSm, GFLOPS_max, _ = measure(matmul, Nt, N, 2*N^3*Nt)
println( "GFLOPS matmul= ", GFLOPSm ) 
println( "GFLOPS_max= ", GFLOPS_max )


@benchmark matmul(Nt, N)
