class BarcoPirata{
	const property nivelDeEbriedadRequerido
	const capacidad
	var tripulacion
	method tieneLlave(){
		return tripulacion.any({pirata => pirata.tieneItem("llave de cofre")})
	}
}