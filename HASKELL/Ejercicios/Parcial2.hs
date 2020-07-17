import Text.Show.Functions
type Arma = (Mutante->Mutante)
type Habilidad = [Char] 
data Mutante = Mutante {
    vida :: Int,
    elNombre :: [Char],
    equipamiento :: [Arma],
    habilidad :: [Habilidad]
    } deriving (Show)

cambiarVida :: (Int -> Int) -> Mutante -> Mutante
cambiarVida unaFuncion unMutante = unMutante {vida = unaFuncion.vida $ unMutante}

cambiarArmas :: ([Arma] -> [Arma]) -> Mutante -> Mutante
cambiarArmas unaFuncion unMutante = unMutante {equipamiento = unaFuncion.equipamiento $ unMutante}

estaMuerto :: Mutante -> Bool
estaMuerto unMutante = (== 0) . vida $ unMutante

es :: Mutante -> [Char] -> Bool
es unMutante nombre = (==nombre) . elNombre $ unMutante

esFrancis :: Mutante -> Bool
esFrancis unMutante = es unMutante "Francis"

esHabilidadMetalica :: Habilidad -> Bool
esHabilidadMetalica habilidad = elem "metal" (words habilidad)

isMyDad :: Mutante -> Bool
isMyDad unMutante = (es unMutante "Coloso") || (all esHabilidadMetalica (habilidad unMutante))

tieneLaHabilidad :: Mutante -> Habilidad -> Bool
tieneLaHabilidad unMutante laHabilidad = elem laHabilidad (habilidad unMutante) 

puños :: Arma
puños unMutante
 | tieneLaHabilidad unMutante “Esquivar Golpes” = unMutante
 | otherwise = cambiarVida (-(min 5 (vida unMutante))) unMutante


pistola :: Int -> Arma
pistola calibre unMutante = cambiarVida (-(min (vida unMutante) (cantidadDeHabilidades*calibre))) unMutante
 where cantidadDeHabilidades = length . habilidad $ unMutante

espada :: Int -> Arma
espada fueza unMutante = cambiarVida (+(fuerza'div'2)) unMutante

masArmas :: [Arma] -> Mutante -> Mutante  
masArmas masArmas unMutante = cambiarArmas (++masArmas) unMutante

ataqueRapido :: unMutante
ataqueRapido



