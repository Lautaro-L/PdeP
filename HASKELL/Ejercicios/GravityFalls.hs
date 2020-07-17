import Text.Show.Functions
data Persona = Persona{
    edad :: Int,
    items :: [String],
    experiencia :: Int
} deriving (Show)

data Criatura = Criatura {
    peligrosidad :: Int,
    deshacer :: (Persona -> Bool)
}

cambiarExperiencia :: (Int -> Int) -> Persona -> Persona
cambiarExperiencia unaFuncion unaPersona = unaPersona { experiencia = unaFuncion . experiencia $ unaPersona }

tieneItem :: String -> Persona -> Bool
tieneItem unItem unaPersona = elem unItem (items unaPersona)

siempredetras :: Criatura 
siempredetras = Criatura 0 (const False)

gnomos :: Int -> Criatura
gnomos cantidad = Criatura (2^cantidad) (tieneItem "sopladorde hojas")

fantasma :: Int -> (Persona -> Bool) -> Criatura
fantasma categoria asuntoPendiente = Criatura (categoria * 20) asuntoPendiente

enfrentamiento ::Criatura -> Persona -> Persona
enfrentamiento  unaCriatura unaPersona 
 | (deshacer unaCriatura) unaPersona = cambiarExperiencia (+(peligrosidad unaCriatura)) unaPersona
 | otherwise = cambiarExperiencia (+1) unaPersona

enfrentamientoMultiple :: [Criatura] -> Persona -> Int
enfrentamientoMultiple criaturas unaPersona = (experiencia (foldr (($) . enfrentamiento ) unaPersona criaturas)) - (experiencia unaPersona)

tieneMenosDe ::Int -> Persona -> Bool
tieneMenosDe parametro = (>parametro) . edad

fantasma3 :: Criatura
fantasma3 = fantasma 3 requerimiento
    where requerimiento p = tieneItem "disfraz de oveja" p && tieneMenosDe 13 p


tieneexperienciaMayora :: Int -> Persona -> Bool
tieneexperienciaMayora exp  = (>exp) . experiencia

fantasma1 :: Criatura
fantasma1 = fantasma 20  (tieneexperienciaMayora 10)

listaTest :: [Criatura]
listaTest = [gnomos 10, fantasma1, fantasma3]