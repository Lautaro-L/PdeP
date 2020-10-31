import Familias.*


class Revolver{
	var  balas
	const capacidad
	
	method usar(victima){
		if ( balas == 0 ){}
		{	balas -= 1 
			victima.estado(muerto)
		}
	} 
	method recargar(){
		balas = capacidad
	}
	
	method esSutil(){
		return (balas == 1)
	}
}

object escopeta{
	
	method usar(victima){
		if (victima.estado() == herido){victima.estado(muerta)}
		{victima.estado(herido)}
	}
	method esSutil(){
		return false
	}
}

class CuerdaDePiano{
	const calidad
	
	method usar(victima){
		victima.estado(calidad.usar())
	}
	method esSutil(){
		return true
	}
}

object buena{
	method usar(victima){
		return muerto
	}
}
object mala{
	method usar(victima){
		return victima.estado()
	}
}