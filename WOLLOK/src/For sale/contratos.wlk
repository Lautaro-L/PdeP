class Operacion{
	const cliente
	const
}

class Alquiler{
	const mesesDeContrato
	
	method comision(valorDelInmueble){
		return (mesesDeContrato * valorDelInmueble) / 50000
	}
}

class Venta{
	var property porcentajeDeComision
	
	method comision(valorDelInmueble){
		return valorDelInmueble * porcentajeDeComision
	}
}