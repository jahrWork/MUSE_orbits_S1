x = 1.234567
println( "type of x = ", typeof(x))

x = 1.234567f0
println( "type of x = ", typeof(x))

#println(" integer part of x =", Int(x))  # ERROR 
println(" integer part of x = ", trunc(Int, x))