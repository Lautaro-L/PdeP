class Pared{
	const ancho
}

class Vidrio inherits Pared{
	method resistencia(){
		return 10 * ancho
	}
}

class Madera inherits Pared{
	method resistencia(){
		return 25 * ancho
	}
}

class Piedra inherits Pared{
	method resistencia(){
		return 50 * ancho
	}
}


object cerditoObrero{
	const property resistencia = 50
}

class CerditoArmado{
	const armadura
	
	method resistencia(){
		return 10 * armadura.resistencia()
	}
}

class Casco{
	const property resistencia
}
class Escudo{
	const property resistencia
}

class IslaCerdito{
	var property obstaculos
}



