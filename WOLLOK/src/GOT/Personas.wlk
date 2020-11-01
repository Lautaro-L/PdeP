class Persona{
	const familia
	var conyuges 
	
	method dinero(){
		return familia.dinero() / familia.cantidadDeMiembros()
	}
	
	method estaCasado(){
		return not conyuges.isEmpty()
	}
}

class Casas{
	var miembros
	var property dinero
	const property origen
	
		
	method cantidadDeMiembros(){
		return miembros.size()
	}
	
	method admiteCasamiento(persona1 ,persona2){
		
	}

}

object lannister{
	
	method avalaElcaserio(persona1, persona2){
		return 
	}
}