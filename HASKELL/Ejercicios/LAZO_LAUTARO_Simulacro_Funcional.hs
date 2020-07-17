import Text.Show.Functions
type Arma = (Rehen->Rehen)
type Intimidar = (Ladron -> Rehen -> Rehen)
data Ladron = Ladron{
    nombreLadron :: String,
    habilidades :: [String],
    armas :: [Arma]
} deriving (Show)

type Plan = (Ladron -> Ladron)
data Rehen = Rehen{
    nombreRehen :: String,
    nivelDeComplot :: Int,
    nivelDeMiedo :: Int,
    plan :: [Plan]
}deriving (Show)

average :: [Int] -> Int
average xs = (sum xs) `div` (length xs)

cambiarMiedo :: ( Int -> Int ) -> Rehen -> Rehen
cambiarMiedo unaFuncion unRehen = unRehen { nivelDeMiedo = unaFuncion . nivelDeMiedo $ unRehen }

cambiarArmas :: ( [Arma] -> [Arma] ) -> Ladron -> Ladron
cambiarArmas unaFuncion unLadron = unLadron { armas = unaFuncion . armas $ unLadron }

cambiarComplot :: ( Int -> Int ) -> Rehen -> Rehen
cambiarComplot unaFuncion unRehen = unRehen { nivelDeComplot = unaFuncion . nivelDeComplot $ unRehen }

cantidadDeLetras :: String -> Int
cantidadDeLetras nombre = length nombre

pistola :: Int -> Arma
pistola calibre unRehen = cambiarMiedo (+(cantidadDeLetras . nombreRehen $ unRehen)) (cambiarComplot (subtract (5*calibre)) unRehen)

ametralladora :: Int -> Arma
ametralladora balas  = cambiarMiedo (+balas) . cambiarComplot (flip div 2) 

mayorMiedo :: Ladron -> Rehen -> Int
mayorMiedo unLadron unRehen = maximum (map (nivelDeMiedo.($ unRehen)) (armas unLadron))

disparos :: Intimidar
disparos unLadron unRehen = cambiarMiedo (const (mayorMiedo unLadron unRehen)) unRehen

esLadron :: String -> Ladron -> Bool
esLadron nombre unLadron = nombre == (nombreLadron unLadron)

letrasHabilidades :: Ladron -> Int
letrasHabilidades unLadron = sum . map cantidadDeLetras $ (habilidades unLadron)

hacerseElMalo :: Intimidar
hacerseElMalo unLadron unRehen
 | esLadron "Berlin" unLadron = cambiarMiedo (+(letrasHabilidades unLadron)) unRehen
 | esLadron "Rio" unLadron = cambiarComplot (+20) unRehen
 | otherwise = cambiarMiedo (+10) unRehen

atacarAlLadron :: Rehen -> Rehen -> Plan
atacarAlLadron unRehen companiero unLadron
 | (nivelDeComplot unRehen) > (nivelDeMiedo unRehen) = cambiarArmas (drop (div (cantidadDeLetras . nombreRehen $ companiero) 10)) unLadron
 | otherwise = unLadron

cantidadDeabilidades :: Ladron -> Int
cantidadDeabilidades unLadron = length . habilidades $ unLadron

esconderse :: Plan
esconderse unLadron = cambiarArmas (drop (div (cantidadDeabilidades unLadron) 3)) unLadron

tokio :: Ladron
tokio = Ladron "Tokio" ["trabajo psicológico",  "entrar en moto"] [pistola 9, pistola 9, ametralladora 30]

profesor :: Ladron
profesor = Ladron "Profesor" ["disfrazarse de linyera",  "“disfrazarse de payaso", "estar siempre un paso adelante"] [] 

pablo :: Rehen
pablo = Rehen "Pablo" 40 30 [esconderse]

arturito :: Rehen
arturito = Rehen "Arturito" 70 50 [esconderse, atacarAlLadron arturito pablo]

esInteligente :: Ladron -> Bool
esInteligente = (>2). length . habilidades 

conseguirArma :: Arma -> Ladron -> Ladron
conseguirArma nuevaArma unLadron = cambiarArmas (++[nuevaArma]) unLadron

intimidar :: Rehen -> Ladron -> Intimidar -> Rehen
intimidar unRehen unLadron unMetodo = unMetodo unLadron unRehen

calmarSiEsMayor :: Int -> Intimidar 
calmarSiEsMayor nivel unLadron unRehen
 | (>nivel) . nivelDeComplot $ unRehen = disparos unLadron unRehen
 | otherwise = unRehen

calmarLasAguas :: [Rehen] -> Ladron -> [Rehen]
calmarLasAguas rehenes unLadron = map (calmarSiEsMayor 60 unLadron) rehenes

puedeEscapar :: Ladron -> Bool
puedeEscapar unLadron =  elem "disfrazarse de" (map (take 14) (habilidades unLadron))

laCosaPintaMal :: [Rehen] -> [Ladron] -> Bool
laCosaPintaMal rehenes ladrones = (average (map nivelDeComplot rehenes)) > ((average (map nivelDeMiedo rehenes)) * (length (map armas ladrones)))

rebelarse :: Ladron -> Rehen -> Ladron
rebelarse unLadron unRehen = foldr ($) unLadron (plan unRehen)

seRebelan :: [Rehen] -> Ladron -> Ladron
seRebelan rehenes unLadron = foldl (rebelarse) unLadron (map (cambiarComplot (subtract 10)) rehenes)

planvalencia :: [Ladron] -> [Rehen] -> Int
planvalencia ladrones rehenes = 1000000 * (length (map armas (map (seRebelan rehenes) (map (conseguirArma (ametralladora 45)) ladrones))))