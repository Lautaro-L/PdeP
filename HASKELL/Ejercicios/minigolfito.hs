data Jugador = Jugador{
    nombreJugador :: String,
    nombrePadre :: String,
    habilidades :: Habilidad
}deriving (Show, Eq)

data Habilidad = Habilidad{
    fuerzaJugador :: Int,
    precisionJugador :: Int
}deriving (Show, Eq)

data Tiro = Tiro{
    velocidad :: Int,
    precisionTiro :: Int,
    altura :: Int
}deriving (Show, Eq)

type Palo = (Jugador -> Tiro)

obrenerPrecision :: Jugador -> Int
obrenerPrecision = precisionJugador . habilidades

obrenerFuerza :: Jugador -> Int
obrenerFuerza = fuerzaJugador . habilidades

putter :: Palo
putter unJugador = Tiro 10 ((*2) . obrenerPrecision $ unJugador ) 0

madera :: Palo
madera unJugador = Tiro 100 ((obrenerPrecision unJugador) `div` 2) 5

hierros :: Int -> Palo
hierros numeroPalo unJugador = Tiro ((*numeroPalo) . obrenerFuerza $ unJugador) ((obrenerPrecision unJugador) `div` numeroPalo ) (max 0 (numeroPalo - 3))

palos :: [Palo]
palos = [putter, madera, hierros 22]

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo unJugador


between n m x = elem x [n .. m]


mayorSegun :: (Int -> Bool) -> Int -> Int -> Int
mayorSegun f a b
 | f a > f b = a
 | otherwise = b

cambiarVelocidad :: (Int -> Int) -> Tiro -> Tiro
cambiarVelocidad unaFuncion unTiro = unTiro { velocidad = unaFuncion . velocidad $ unTiro }

cambiarPrecision :: (Int -> Int) -> Tiro -> Tiro
cambiarPrecision unaFuncion unTiro = unTiro { precisionTiro = unaFuncion . precisionTiro $ unTiro }

cambiarAltura :: (Int -> Int) -> Tiro -> Tiro
cambiarAltura unaFuncion unTiro = unTiro { altura = unaFuncion . altura $ unTiro }

tiroNulo :: Tiro
tiroNulo = Tiro 0 0 0

tiroLau :: Tiro
tiroLau = Tiro 100 100 0

tiroDona :: Tiro
tiroDona = Tiro 10 95 2

tiroDona2 :: Tiro
tiroDona2 = Tiro 10 96 0

condicionTiro :: Tiro -> (Int->Bool) -> (Int->Bool) -> (Int->Bool) -> (Tiro->Tiro) -> (Tiro->Tiro) -> Tiro
condicionTiro unTiro condicionVelocidad condicionPrecision condicionAltura siCumple siNoCumple
 | (condicionVelocidad (velocidad unTiro)) && (condicionPrecision (precisionTiro unTiro)) && (condicionAltura (altura unTiro)) = siCumple unTiro
 | otherwise = siNoCumple unTiro

tunel :: Tiro -> Tiro
tunel unTiro = condicionTiro unTiro (const True) (>90) (==0) (cambiarVelocidad (*2)) (const tiroNulo)

laguna :: Int -> Tiro -> Tiro
laguna laro unTiro = condicionTiro unTiro (>80) (const True) (between 1 5) (cambiarAltura (flip div laro)) (const tiroNulo)

hoyo :: Tiro -> Tiro
hoyo unTiro = condicionTiro unTiro (between 5 20) (>95) (==0) (const tiroNulo) (const unTiro)



























