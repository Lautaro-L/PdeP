import Tareas.*
import Yaarr.*

class BarcoPirata{
	
	const property nivelDeEbriedadRequerido = 90
	const capacidad
	var property tripulacion
	var property mision
	
	method tieneLlave(){
		return tripulacion.any({pirata => pirata.tieneItem("llave de cofre")})
	}
	
	method esVulnerableA(barco){
		return tripulacion.size() <= (barco.tripulacion().size() / 2)
	}
	
	method todosPasados(){
		return tripulacion.all({pirata => pirata.pasadoDeGrogXD()})
	}
	
	method puedeEntrar(pirata){
		return (tripulacion.size() < capacidad and  mision.sirveElPirata(pirata))
	}
	
	method incorporarPirata(pirata){
		if ( self.puedeEntrar(pirata) ) {tripulacion.add(pirata)}
	}
	
	method cambiarDeMision(nuevaMision){
		mision = nuevaMision
		tripulacion.removeAllSuchThat({tripulante => not self.puedeEntrar(tripulante)})
	}
	
	method elMasEbrio(){
		return tripulacion.max({tripulante => })
	}
}


class CiudadCostera{
	const property nivelDeEbriedadRequerido = 50
	const property habitantes 
	
		method esVulnerableA(barco){
		return (habitantes.size() * 0.4) <= barco.tripulacion().size()
	}
}