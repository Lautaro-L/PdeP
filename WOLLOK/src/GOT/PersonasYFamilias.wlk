class Persona{
	const familia
	var conyuges 
	
	method dinero(){
		return familia.dinero() / familia.cantidadDeMiembros()
	}
	
	method noEstaCasado(){
		return conyuges.isEmpty()
	}
}



class Casas{
	var miembros
	var property dinero
	const property origen
		
	method cantidadDeMiembros(){
		return miembros.size()
	}
	
	method esMiembro(persona){
		return miembros.contains(persona)
	}
	
	method esRica(){
		return dinero > 1000
	}

}



class Lannister inherits Casas{
	
	method admiteCasamiento(persona1, persona2){
		return persona1.noEstaCasado()
	}
}

object stark inherits Casas{
	
	method admiteCasamiento(persona1, persona2){
		return not self.esMiembro(persona2)
	}
}

object nightGuard inherits Casas{
	
	method admiteCasamiento(persona1, persona2){
		return false
	}
}