import Personalidades.*
class Persona{
	const familia
	const conyuges = []
	const acompaniantes = []
	const personalidad
	
	method dinero(){
		return familia.patrimonio() / familia.cantidadDeMiembros()
	}
	
	method noEstaCasado(){
		return conyuges.isEmpty()
	}
	
	method sePuedeCasarCon(persona){
		return familia.admiteCasamiento(self, persona)
	}
	
	method casarseCon(persona){
		conyuges.add(persona)
	}
	
	method estaSolo(){
		return acompaniantes.isEmpty()
	}
	
	method aliados(){
		return familia.miembros() + conyuges + acompaniantes
	}
	
	method casaRica(){
		return familia.esRica()
	}
	
	method esPeligroso(){
		return (self.aliados().sum({ aliado => aliado.dinero() }) > 10000) || conyuges.all({ persona => persona.casaRica() }) || self.aliados().any({ persona => persona.esPeligroso() })
	}
	
	method ejecutarConspiracion(objetivo){
		personalidad.accion(objetivo)
	}
}



class Casas{
	const property miembros = []
	const patrimonio = 1000
	
	method patrimonio(){
		return patrimonio
	}
		
	method cantidadDeMiembros(){
		return miembros.size()
	}
	
	method esMiembro(persona){
		return miembros.contains(persona)
	}
	
	method esRica(){
		return patrimonio > 1000
	}

}



object lannister inherits Casas{
	
	method admiteCasamiento(persona1 , persona2){
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

class Evento{
	
}

class Casamiento{
	const marido
	const mujer
	
	method sePuedenCasar(){
		return	marido.sePuedeCasarCon(mujer) && mujer.sePuedeCasarCon(marido)
	}
	
	method sucederEvento(){
		if (self.sePuedenCasar()) { 
			marido.casarseCon(mujer)
			mujer.casarseCon(marido)
		}
		
	}
	
}

object dragon{
	method dinero(){
		return 0
	}
	
	method esPeligroso(){
		return true
	}
}


class Lobo{
	const huargos
	
	method dinero(){
		return 0
	}
	
	method esPeligroso(){
		return huargos
	}
}

class Conspiracion{
	const objetivo
	const conspiradores
	
	method traidores(){
		return conspiradores.aliados().filter({ aliado => conspiradores.contains(aliado) }).size()
	}
	
	method ejecutarConspiracion(){
		conspiradores.forEach({ conspirador => conspirador.ejecutarConspiracion(objetivo) })
	}
	
	method funciono(){
		return not objetivo.esPeligroso()
	}
}