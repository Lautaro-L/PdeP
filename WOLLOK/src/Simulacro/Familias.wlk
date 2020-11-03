import Armas.*

class Mafioso{
	var muerto = false
	var herido = false
	var rango
	var lealtad
	
	method duermeConLosPeces(){
		return muerto
	}
	
	method morir(){
		muerto = true
	}
	
	method herirse(){
		herido = true
	}
	
	method herido(){
		return herido
	}
	
	method hacerSuTrabajo(victima){
		rango.atacar(victima)
	}
	
	method obtenerArma(arma){
		rango.armas().add(arma)
	}
	
	method tieneArmaSutil(){
		return rango.armas().any({ arma => arma.esSutil() })
	}
	
	method subirDeRango(nuevoRango){
		rango = nuevoRango
	}
}


class Don{
	var property armas
	const subordinados
	
	method atacar(victima){
		2.times( subordinados.anyOne().atacar(victima) )
	}
	
	method sabeDespacharElegantemente(){
		return true
	}
	
}

class Subjefe{
	var property armas
	const subordinados
	
	method atacar(victima){
		armas.anyOne().usar(victima)
	}
	
	method sabeDespacharElegantemente(){
		return subordinados.any({ subordinado => subordinado.tieneArmaSutil() })
	}
}

class Soldado{
	var property armas = [escopeta]
		
	method atacar(victima){
		armas.first().usar(victima)
	}
	
	method tieneMasDeArmas(cantidad){
		return armas > cantidad
	}
}


class Familia{
	var don
	var soldados
	var subjefes 
	const miembros = soldados + subjefes + don
	
	method quedanVivos(){
		miembros.any({ miembro => not miembro.duermeConLosPeces() })
	}
	
	method peligroso(){
		return miembros.filter({ mafioso => not mafioso.duermeConLosPeces() }).max({ mafioso => mafioso.armas().size() })
	}
	
	method elQueQuieraEstarArmadoQueAndeArmado(){
		miembros.forEach({ mafioso => mafioso.obtenerArma(new Revolver(balas = 6, capacidad = 6)) })
	}
	
	method ataqueSorpresa(familiaEnemiga, miembros){
		miembros.forEach({ miembro => if(familiaEnemiga.quedanVivos()) {miembro.hacerSuTrabajo(familiaEnemiga.peligroso())} else {} })
	}
	
	method luto(){
		soldados.filter({ soldado => soldado.tieneMasDeArmas(5) }).forEach({ soldado => {  } })
	}
}

object vivo{}
object herido{}
object muerto{}