import Yaarr.*

object busquedaDelTesoro {
	const requisitos = ["mapa" , "brujula" , "Botella de GrogXD"]
	method cumpleRequisitos(pirata){
		return ( pirata.dinero() <= 5 and pirata.tiene(requisitos))
		}
		
	method barcoCumple(){
		
	}
}


class ConvertirseEnLeyenda{
	const itemEspecial
	
	method elPirataEsLeyenda(pirata){
		pirata.tieneItem(itemEspecial)
	}
}