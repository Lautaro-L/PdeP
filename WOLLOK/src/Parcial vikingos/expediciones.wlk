import Vikingos.*

class Expedicion{
	const objetivos = []
	const vikingos = []
	var botin
	
	method subirVikingo(vikingo){
		if ( not vikingo. puedeIrAExcursion() ) {throw new Exception(message = "Oops! No tiene mas monedas :frowning:")}
			vikingos.add(vikingo)
	}
	
	method botinObtenido(){
		return botin
	}
	
	method saquear(objetivo){
		objetivo.serSaqueado(vikingos)
		botin += objetivo.botin(vikingos)
	}
	
	method ejecutarSaqueo(){
		objetivos.forEach({ ciudad => self.saquear(ciudad) })
		self.repartirGanancias()
	}
	
	method repartirGanancias(){
		const botinPorVikingo = botin / vikingos.size()
		vikingos.forEach({ vikingo => vikingo.ganarDinero(botinPorVikingo) })
	}
	
	method valeLaPenaLaExpedicion(){
		return objetivos.all({ objetivo => objetivo.valeLaPena(vikingos) })
	}
}



class Capital{
	const valorDeRiqueza
	
	method valeLaPena(vikingos){
		return ((valorDeRiqueza * vikingos.size()) / vikingos.size()) >= 3
	}
	
	method botin(vikingos){
		return valorDeRiqueza * vikingos.size()
	}
	
	method serSaqueada(vikingos){
		vikingos.forEach({ vikingo => vikingo.matarAAlguien() })
	}
}

class Aldea{
	const estaDefendida
	var crucifijos
	const cantidadMinima
	
	method valeLaPena(vikingos){
		if (estaDefendida) { return  cantidadMinima <= vikingos.size()}
		else { return self.botin(vikingos) >= 15 }
	}
	
		method botin(vikingos){
		return crucifijos
	}
	
	method serSaqueada(vikingos){
		crucifijos = 0
	}
}