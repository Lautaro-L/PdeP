class Pirata{
	var property items
	var ebriedad
	var dinero = 10
	const espiaDeLaCorona
	const property invitadoPor
	
	method nivelDeEbriedad(){
		return ebriedad
	}
	
	method pasadoDeGrogXD(){
		if ( espiaDeLaCorona ) { return false }
		else { return ebriedad < 90 }
	}
	
	method incrementarEbriedad(cantidad){
		ebriedad += cantidad
	}
	
	method tomarUnTrago(){
		self.incrementarEbriedad(5)
		self.dinero(-1)
	}
	
	method dinero(){
		return dinero
	}
	
	method dinero(cantidad) {
		(dinero += cantidad).max(0)
	}
	
	method tieneItems(requisitos){
		requisitos.any({requisito => self.tieneItem(requisito)})
	}
	
	method tieneItem(item){
		return	items.contains(item)
	}
	
	method tieneXItems(cantidad){
		return items.size() >= cantidad 
	}
	
	method seAnimaAAtacar(victima){
		return self.nivelDeEbriedad() >= victima.nivelDeEbriedadRequerido()
	}
}