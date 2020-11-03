class Vikingo{
	var rangoSocial
	var vidasCobradas
	var dinero
	
	method ganarDinero(ganancias){
		dinero += ganancias
	}
	
	method puedeIrAExcursion(){
		return rangoSocial.esApto()
	}
	
	method matarAAlguien(){
		vidasCobradas += 1
	}
	
	method ascenderATharll(){
		rangoSocial = tharll
	}
}



class Soldado inherits Vikingo{
	var armas 
	
	method esProductivo(){
		return not self.noTieneArmas() && vidasCobradas > 20
	}
	
	method noTieneArmas(){
		return armas.isEmpty()
	}
	
	override method puedeIrAExcursion(){
		return super() && self.esProductivo()
	}
	
	method ascenderAKarl(){
		rangoSocial = karl
		armas += 10
	}
}

class Granjero inherits Vikingo{
	
	var hijos
	var hectareas
	
	method noTieneArmas(){
		return true
	}
	
	method esProductivo(){
		return (hectareas / 2) >= hijos
	}
	
	override method puedeIrAExcursion(){
		return super() && self.esProductivo()
	}
	method ascenderAKarl(){
		rangoSocial = karl
		hectareas += 2
		hijos += 2
	}
}




object jarl{
	
	method esApto(vikingo){
		return vikingo.noTieneArmas()
	}
	
	method ascender(vikingo){
		vikingo.ascenderAKarl()
	}
}



object karl{
	
	method esApto(vikingo){
		return true
	}
	
	method ascender(vikingo){
		vikingo.ascenderATharll()
	}
}



object tharll{
	
	method esApto(vikingo){
		return true
	}
	method ascender(vikingo){}
}