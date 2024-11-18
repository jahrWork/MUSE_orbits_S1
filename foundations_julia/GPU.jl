# import Pkg 
# Pkg.add("AMDGPU")

# Pkg.test("AMDGPU"; test_args=["--list"])

using AMDGPU
using BenchmarkTools

# dispatches to rocBLAS for matrix multiplication
function matmul(A,B)

     return A * B 

end      

a = AMDGPU.ones(Float32, 1024)

N = 1024
A = AMDGPU.rand(Float32, N, N)
B = AMDGPU.rand(Float32, N, N)


dt = @belapsed matmul( A, B )

print( " dt = ", dt )