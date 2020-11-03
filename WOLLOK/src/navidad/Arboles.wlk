class Arbol{
	const regalos = []
	
	
}

class Natural inherits Arbol{
	const vejez
	const tamanioDelTronco
	
	method regalosQueAloha(){
		return tamanioDelTronco * vejez
	}
	
}

class Artificial inherits Arbol{
	const cantidadDeRamas
	
	method regalosQueAloha(){
		return cantidadDeRamas
	}
}

class Regalo{
	const property precio
	const property destinatario
	const property espacio = 1
}

class Tarjeta{
	const property destinatario
	const property valor = 2
	const property espacio = 0
}

class Adorno{
	
}