import example.*
object asesino{
	method accion(objetivo){
		objetivo.morir()
	}
}

object asesinoSutil{
	method accion(objetivo){
		if (objetivo.estaSolo()) { objetivo.morir() } 
	}
}

class Disipado{
	const porcentaje
	method accion(objetivo){
		objetivo.gastarDinero(porcentaje)
	}
}

object miedoso{
	method accion(objetivo){}
}