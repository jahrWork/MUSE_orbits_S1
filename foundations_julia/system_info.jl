import Pkg 
#Pkg.resolve()
#Pkg.instantiate()
Pkg.add("Hwloc")
Pkg.add("CUDA")
Pkg.add("CpuId")

using CUDA, Hwloc, CpuId

# Remeber to enter your cpu_frequency manually

# GPU Functions
function get_GPU_architecture(capability)
    if capability.major == 9
        return "Ada Lovelace"  # RTX 40 series
    elseif capability.major == 8
        return "Ampere"  # RTX 30 series
    elseif capability.major == 7
        if capability.minor == 5
            return "Turing"  # RTX 20 series
        else
            return "Volta"  # Tesla V100
        end
    elseif capability.major == 6
        return "Pascal"  # GTX 10 series
    elseif capability.major == 5
        return "Maxwell"  # GTX 900 series
    elseif capability.major == 3
        return "Kepler"  # GTX 600/700 series
    else
        return "Unknown Architecture"
    end
end

function cuda_cores_per_sm(capability)
    if capability.major == 9
        return 128
    elseif capability.major == 8
        return 128
    elseif capability.major == 7
        return 64
    elseif capability.major == 6
        return 64
    else
        return 32
    end
end

function gpu_info(return_max_gflops=false)
    device = CUDA.device()
    capability = CUDA.capability(device)
    sm_count = CUDA.attribute(device, CUDA.DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT)
    cores_per_sm = cuda_cores_per_sm(capability)
    total_cuda_cores = sm_count * cores_per_sm
    clock_rate = CUDA.attribute(device, CUDA.DEVICE_ATTRIBUTE_CLOCK_RATE) / 1e6
    max_gflops = 2 * clock_rate * total_cuda_cores

    if return_max_gflops
        return max_gflops
    else
        println("--------------------------------------------------------")
        println("GPU Information")
        println(" ")
        println("GPU Name: ", CUDA.name(device))
        println("GPU Compute Capability: ", capability.major, ".", capability.minor, " (", get_GPU_architecture(capability), ")")
        println("GPU Memory: ", round(CUDA.totalmem(device) / 1e9, digits=2), " GB (base-10, where 1 GB = 1,000,000,000 bytes)")
        println("GPU Memory: ", round(CUDA.totalmem(device) / 2^30, digits=2), " GiB (base-2, where 1 GiB = 1,073,741,824 bytes)")
        println("GPU Streaming Multiprocessor (SM) Count: ", sm_count)
        println("CUDA Cores per SM: ", cores_per_sm)
        println("Total CUDA Cores: ", total_cuda_cores)
        println("GPU Clock Rate: ", clock_rate, " GHz")
        println("GPU Theoretical max GFLOPS: ", round(max_gflops, digits=2), " GFLOPS")
        println("--------------------------------------------------------")
    end
end

# CPU Functions
function get_avx_value(string_cpuid)

    if occursin("256 bit", string_cpuid)
        return 8
    elseif occursin("512 bit", string_cpuid)
        return 16
    else
        return 0
    end
end

function cpu_info(return_max_gflops=false)
    topology = Hwloc.topology_load()
    N_cores = num_physical_cores()
    N_threads = num_virtual_cores()
    cpuid = cpuinfo()
    string_cpuid = string(cpuid)
    cpu_frequency = 4.5  # GHz (Adjust as needed)
    AVX_value = get_avx_value(string_cpuid)

    if return_max_gflops
        if AVX_value > 0
            # Sigo pensado que esto es incorrecto, AVX_value en AVX2 es 8, pero sobre dos registros de 256 bits, falta otro factor de 2 por lo tanto.
            # Se puede ver con nuestras pruebas (conseguimos casi 700GFLOPS en mi Ryzen 5 5600X con AVX2, marcando el teórico 432GFLOPS)
            Theoretical_time = 1e9 / (cpu_frequency * 1e9 * AVX_value * 2 * N_cores) 
            return 1 / Theoretical_time
        else
            return 0
        end
    else
        println("--------------------------------------------------------")
        println("CPU Information")
        println(" ")
        println("CPU Cores: ", N_cores)
        println("CPU Threads: ", N_threads)
        println("CPU Frequency: ", cpu_frequency, " GHz           (GHz adjusted manually)")
        println("AVX support: ", occursin("256 bit", string_cpuid))
        println("AVX-512 support: ", occursin("512 bit", string_cpuid))
        println("AVX Value: ", AVX_value)
        if AVX_value > 0
            Theoretical_time = 1e9 / (cpu_frequency * 1e9 * AVX_value * 2 * N_cores)
            println("CPU Theoretical max GFLOPS: ", round(1 / Theoretical_time, digits=2), " GFLOPS")
        else
            println("AVX not supported. Cannot compute theoretical GFLOPS.")
        end
    end
end

function system_info()
    println("--------------------------------------------------------")
    println("System information")
    cpu_info()
    gpu_info()
end

# Run the system_info function to get the CPU and GPU information
system_info()

# Run the cpu_info function to get the CPU information
# cpu_info()
# cpu_info(true) # To get the CPU theoretical max GFLOPS

# Run the gpu_info function to get the GPU information
# gpu_info()
# gpu_info(true) # To get the GPU theoretical max GFLOPS

