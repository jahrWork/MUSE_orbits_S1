


# To load a module from a package, the statement using ModuleName can be used. 
# To load a module from a locally defined module, 
# a dot needs to be added before the module name like using .ModuleName.

#= Elios de Rosario
En esas circunstancias, una solución drástica es terminar la sesión de Julia y 
comenzarla de nuevo, pero eso supone tener que volver a cargar los paquetes y módulos, 
repetir los pasos anteriores del estudio que se estuviera haciendo, etc. 
Una alternativa es usar el paquete Revise. Entre otras cosas, 
este paquete proporciona la función includet, que hace lo mismo que include 
(evaluar los contenidos de un archivo de código), 
pero trazando los cambios que se realizan sobre él.

Esto significa que si se modifica alguna parte del archivo cargado con includet, 
este se "recarga" automáticamente. Las nuevas variables y 
funciones definidas en el código pasan a formar parte del espacio de trabajo; 
se aplican los cambios que se hayan hecho en sus definiciones, 
y en el caso de las funciones, las que se borren del código 
también desaparecen del espacio de trabajo.[
=#

using Pkg
Pkg.add("Revise")
using Revise 


includet("./moduleA/m1.jl")
import .m1
using .m1: f

x = 2 
println("Hello from main program")
m1.f()
f()
println("x = ", x)


#= 
module main 
     using Revise
     includet("m2.jl")  # revise only tracks change  of functions 
end  =#

# using .main: m2


# m2.f()

# Pkg.generate("MyPackage")
# Pkg.activate("")

# using .MyPackage