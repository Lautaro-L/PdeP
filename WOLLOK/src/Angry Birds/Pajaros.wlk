import punto2.*
class PajaroComun{
	var ira
	var enojos
	
	method fuerza(){
		return ira * 2
	}
	
	method enojarse(){
		ira *= 2
		enojos +=1
	}
	
	method calmarse(cantidad){
		ira -= cantidad
	}
	
	method puedeDerribar(obstaculo){
		return (self.fuerza() >= obstaculo.resistencia())
	}
	
	method enfrentarObstaculo(obstaculos){
		if ( self.puedeDerribar(obstaculos.first()) ) { obstaculos.remove(obstaculos.first()) }
		else{}
	}
}

class Red inherits PajaroComun{
	override method fuerza(){
		return ira * 10 * enojos
	}
}

class Bomb inherits PajaroComun{
	var fuerzaMax = 9000
	
	method cambiarMax(cant){
		fuerzaMax = cant
	}
	
	override method fuerza(){
		return super().fuerza().max(9000)
	}
	
	
}

class Chuck inherits PajaroComun{
	var velocidad 
	
	override method fuerza(){
		if (velocidad <= 80) { return 150 }
		else { return 150 + (5 * (velocidad - 80)) }
	}
	
	override method enojarse(){
		super().enojarse()
		velocidad *= 2
	}
	
	override method calmarse(cantidad){}
	
}

class Terence inherits PajaroComun{
	var property multiplicador
	
	override method fuerza(){
		return ira * multiplicador * enojos
	}
}

class Matilda inherits PajaroComun{
	var huevos 
	
	override method fuerza(){
		return super().fuerza() + huevos.sum({ huevo => huevo.peso() })
	}
	
	override method enojarse(){
		super().enojarse()
		huevos.add(new Huevo(peso = 2))
		}
		
}

class Huevo{
	var property peso
	}
	
	
	class Isla{
		var property pajaros
		
		method losFuertes(){
			return pajaros.filter({ pajaro => pajaro.fuerza() > 50 })
		}
		
		method fuerzaDeLaIsla(){
			return self.losFuertes().sum()
		}
		
		method sucederEvento(evento){
			evento.sucederEvento(pajaros)
		}
		
		method sucederEventos(eventos){
			eventos.forEach({evento => self.sucederEvento(evento)})
		}
		
		method enfrentarIsla(islaCerdos){
			pajaros.forEach({ pajaro => pajaro.enfrentarObstaculo( islaCerdos.obstaculos() )})
		}
		
	}
	
class SesionDeManejoDeIra{
	method sucederEvento(habitantes){
		habitantes.forEach({ pajaro => pajaro.calmarse(5) })
	}
}
		
class InvasionDeDerditos{
	var cantidad
	method enojarlos(pajaros){
		pajaros.forEach({ pajaro => pajaro.enojarse() })
	}
	method sucederEvento(habitantes){
		cantidad.div(100).times({ self.enojarlos(habitantes) })
	}
}
	   
class FiestaSorpresa{
	var homenajeados
	method sucederEvento(habitantes){
	   		homenajeados.forEach({ pajaro => pajaro.enojarse() })
	   	}
}






