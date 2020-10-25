class Pirata{
	var property items
	var ebriedad
	var dinero
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
	
	method dinero( cantidad ) {
		( dinero += cantidad ).max(0)
	}
	
	method tieneItems(requisitos){
		requisitos.any({requisito => self.tieneItem(requisito)})
	}
	
	method tieneItem(item){
		return	items.contains(item)
	}
	
	
	method saquear(){
		return espiaDeLaCorona && items.contains("permiso de la corona")
	}
	
	method saquear(victima){
		return victima
	}
	
	method convertirseEnLeyenda(itemObligatorio){
		return (items.contains(itemObligatorio) and (items.size() >=10 ))
	}
	
	method saqueo(parametro, victima){
		return (dinero < parametro and self.saquear(victima))
	}
	
}