type Duracion = Float
type Caloria = Float
type Ejercicio = Duracion -> Gimnasta -> Gimnasta
data Gimnasta = Gimnasta{
    nombre :: String,
    edad :: Float,
    peso :: Float,
    coeficiente :: Float
} deriving (Show, Eq, Ord);

data Rutina = Rutina{
    nombreRutina :: String,
    duracionTotal :: Float,
    ejercicios :: [Ejercicio]
}


cambiarPeso :: (Float -> Float) -> Gimnasta -> Gimnasta
cambiarPeso unaFuncion unGimnasta = unGimnasta{ peso = max 0 ( unaFuncion . peso $ unGimnasta) }

cambiarCoeficiente :: (Float -> Float) -> Gimnasta -> Gimnasta
cambiarCoeficiente unaFuncion unGimnasta = unGimnasta{ coeficiente = max 0 ( unaFuncion . coeficiente $ unGimnasta) }
 
cambiarRutina ::([Ejercicio] -> [Ejercicio]) -> Rutina -> Rutina
cambiarRutina unaFuncion unaRutina = unaRutina{ ejercicios = (unaFuncion . ejercicios $ unaRutina) }

cambiarDuracionRutina ::(Float -> Float) -> Rutina -> Rutina
cambiarDuracionRutina unaFuncion unaRutina = unaRutina{ duracionTotal = (unaFuncion . duracionTotal $ unaRutina) }


lautaro :: Gimnasta
lautaro = Gimnasta "Lautaro" 22.0 88.0 22.0

rutina1 :: Rutina
rutina1 = Rutina "La Diabolica" 222 [montania 44, colina 44, hacerPesas 88, entrenamientoEnCinta]

esSaludable :: Gimnasta -> Bool
esSaludable = (<100).peso

esMayorDe :: Float -> Gimnasta -> Bool
esMayorDe unaEdad unGimnasta = (>unaEdad) (edad unGimnasta)

quemarCalorias :: Gimnasta -> Caloria -> Gimnasta   
quemarCalorias unGimnasta calorias
 | not . esSaludable $ unGimnasta = cambiarPeso (subtract(calorias/150)) unGimnasta
 | (esMayorDe 30 unGimnasta) && (calorias > 200) = cambiarPeso (subtract 1) unGimnasta
 | otherwise = cambiarPeso (subtract (calorias/(peso unGimnasta * edad unGimnasta))) unGimnasta

cinta :: Float -> Ejercicio
cinta velocidadMedia duracion unGimnasta = quemarCalorias unGimnasta (velocidadMedia * duracion)

caminataEnCinta :: Ejercicio
caminataEnCinta duracion = cinta duracion 5

entrenamientoEnCinta :: Ejercicio
entrenamientoEnCinta duracion = cinta ((12+duracion/5)/2) 40 

hacerPesas :: Float -> Ejercicio
hacerPesas pesas duracion 
 | (>10) duracion = cambiarCoeficiente (+(pesas/10)) 
 | otherwise = id

colina :: Float -> Ejercicio
colina inclinacion duracion unGimnasta = quemarCalorias unGimnasta (inclinacion * duracion * 2)

montania :: Float -> Ejercicio
montania inclinacion duracion = cambiarCoeficiente (+1) . colina (duracion/2) (inclinacion+3) . colina (duracion/2) inclinacion

cantidadDeEjercicios :: [ejercicios] -> Float
cantidadDeEjercicios unaRutina = fromIntegral (length (unaRutina)) :: Float

hacerRutina :: Rutina -> Gimnasta -> Gimnasta
hacerRutina unaRutina unGimnasta
    | (== 0) . length . ejercicios $ unaRutina = unGimnasta
    | otherwise = hacerRutina (cambiarRutina tail unaRutina) ((head . ejercicios $ unaRutina) (duracionTotal unaRutina) unGimnasta)

hacerRutinav2 :: Rutina -> Gimnasta -> Gimnasta
hacerRutinav2 unaRutina unGimnasta = foldl (hacerEjercicio) (unGimnasta) (ejercicios unaRutina)
 where hacerEjercicio a b = b (duracionTotal unaRutina) a 

resumenDeRutina :: Rutina -> Gimnasta -> (String, Float, Float)
resumenDeRutina unaRutina unGimnasta = (nombreRutina unaRutina, pesoPerdido, (-) (coeficiente (hacerRutinav2 unaRutina unGimnasta)) (coeficiente unGimnasta))
 where pesoPerdido = subtract (peso (hacerRutinav2 unaRutina unGimnasta)) (peso unGimnasta)
 

resumenDeRutinas :: [Rutina] -> Gimnasta -> [(String, Float, Float)]
resumenDeRutinas rutinas unGimnasta = map (flip resumenDeRutina unGimnasta) (filter (salud) rutinas)
 where salud rut = esSaludable (hacerRutinav2 rut unGimnasta)