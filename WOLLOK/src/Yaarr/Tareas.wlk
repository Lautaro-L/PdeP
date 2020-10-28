import Yaarr.*

object busquedaDelTesoro {
	const requisitos = ["mapa" , "brujula" , "Botella de GrogXD"]
	method sirveElPirata(pirata){
		return ( pirata.dinero() <= 5 and pirata.tieneItems(requisitos))
		}
		
	method barcoCumple(barco){
		return barco.tieneLlave()
	}
}


class ConvertirseEnLeyenda{
	const itemEspecial
	
	method sirveElPirata(pirata){
		return pirata.tieneItem(itemEspecial) and pirata.tieneXItems(10)
	}
}

class Saquear{
	const dineroMaximo = 10
	const objetivo 
	
	method sirveElPirata(pirata){
		return (pirata.dinero() < dineroMaximo) && (pirata.seAnimaAAtacar(objetivo))
	}
	
	method sirveBarco(barco){
		return ( objetivo.esVulnerableA(barco) or barco.todosPasados())
	}
	
}
	
	
}