class Comensal{
	var items
	var property posicion
	var criterio
	var preferencia
	var comidasComidas
	
	method pedirItem(item, persona){
		persona.darItem(item, persona)
	} 
	
	method darItem(item, persona){
		if ( items.contains(item) ) { criterio.darItem(persona, item) }
	} 
	
	method sacarItem(unElemento){
		items.remove(unElemento)
	}
	
	method darTodoA(persona){
		items.forEach({ item => persona.pasarElementoA(persona, item) })
	}
	
	method pasarElementoA(persona, item){
		persona.recibirItem(item)
		self.sacarItem(item)
	}
	
	method primerItem(){
		return items.head()
	}
	
	method itemsCercanos(){
		return items
	}
	
	method cambiarPosicionCon(persona){
		const nuevaPosicion = persona.posicion()
		persona.posicion(posicion)
		posicion = nuevaPosicion
	}
	
	method recibirItem(item){
		items.add(item)
	}
	
	method aComerla(comida){
		if ( preferencia.aceptaComida(comida) ) { self.registrarComida(comida) }
	}
	
	method registrarComida(comida){
		comidasComidas.add(comida)
	}
	
	method pipon(){
		return comidasComidas.any({ comida => comida.esPesada() })
	}
	
	method comioCarne(){
		return comidasComidas.any({ comida => comida.esCarne() })
	}
}


object sordo{
	
	method darItem(persona1, itemDeseado, persona2){
		const item = persona1.primerItem()
		persona1.pasarElementoA(persona2, item)
	}
}


object impaciente{
	
	method darItem(persona1, itemDeseado, persona2){
		persona1.darTodoA(persona1)
	}
}


object inquieto{
	
	method darItem(persona1, itemDeseado, persona2){
		persona1.cambiarPosicionCon(persona2)
	}	
}

object vegetariano{
	method aceptaComida(comida){
		return not comida.esCarne()
	}
}

object dietetico{
	var property criterio = 500
	
	method aceptaComida(comida){
		return comida.calorias() <= criterio
	}
}

object alternado{
	var anterior
	
	method aceptaComida(comida){
		anterior = not anterior
		return anterior
	}
}

object combinado{
	var property tipos = [alternado, dietetico, vegetariano]
	
	method aceptaComida(comida){
		tipos.all({ preferencia => preferencia.aceptaComida(comida) })
	}
}


class Comida{
	const property esCarne
	const property calorias
	
	method esPesada(){
		return calorias > 500
	}
}

object osky inherits Comensal{
	method laEstaPasandoBien(){
		return true
	}
}

object moni inherits Comensal{
	method laEstaPasandoBien(){
		return posicion == "1@1"
	}
}

object facu inherits Comensal{
	method laEstaPasandoBien(){
		return self.comioCarne()
	}
}

object vero inherits Comensal{
	method laEstaPasandoBien(){
		return items.size() <= 3
	}
}