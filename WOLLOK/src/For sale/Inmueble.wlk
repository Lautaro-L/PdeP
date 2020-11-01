class Inmueble{
	const metrosCuadrados
	const cantidadDeAmbientes
	const tipoDePublicacion
	var property plusDeZona
	
}

class Casa inherits Inmueble{
	const valorDeLaCasa
	
	method valorDelInmueble(){
		return valorDeLaCasa + plusDeZona
	}
}

class PH inherits Inmueble{
	
	method valorDelInmueble(){
		return (14000 * metrosCuadrados).min(500000) + plusDeZona
	}
}

class Departamento inherits Inmueble{
	method valorDelInmueble(){
		return (350000 * cantidadDeAmbientes) + plusDeZona
	}
}