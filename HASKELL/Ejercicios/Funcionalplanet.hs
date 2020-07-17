import Text.Show.Functions

type Truco = (Mascota -> Mascota)
data Mascota = Mascota{
    nombre       :: String,
    edad         :: Int,
    nombreDuenio :: String,
    experiencia  :: Int,
    energia      :: Int,
    trucos       :: [Truco],
    distraida    :: Bool
} deriving (Show)

data Resultados = Resultados{
    nombreMascota :: String,
    puntuacionEnergia :: Int,
    puntuacionHabilidad :: Int,
    puntuacionTernura :: Int
} deriving (Show)

cambiarEnergia :: (Int -> Int) -> Mascota -> Mascota
cambiarEnergia unaFuncion unaMascota = unaMascota { energia = unaFuncion . energia $ unaMascota } 

cambiarNombre :: (String -> String) -> Mascota -> Mascota
cambiarNombre unaFuncion unaMascota = unaMascota { nombre = unaFuncion . nombre $ unaMascota } 

cambiarConcentracion :: (Bool -> Bool) -> Mascota -> Mascota
cambiarConcentracion unaFuncion unaMascota = unaMascota { distraida = unaFuncion . distraida $ unaMascota }

cambiarExperiencia :: (Int -> Int) -> Mascota -> Mascota
cambiarExperiencia unaFuncion unaMascota = unaMascota { experiencia = unaFuncion . experiencia $ unaMascota }

cumpleCondicionDelTruco :: Int -> Mascota -> Bool
cumpleCondicionDelTruco nivel unaMascota = ((>nivel) . energia) unaMascota && (not . distraida $ unaMascota)


sentarse :: Truco
sentarse unaMascota 
 | cumpleCondicionDelTruco 5 unaMascota = cambiarEnergia (subtract 5) unaMascota
 | otherwise = unaMascota

tomarAgua :: Truco
tomarAgua = cambiarEnergia (+5)

perroMojado :: Truco
perroMojado unaMascota
 | cumpleCondicionDelTruco 5 unaMascota = (cambiarEnergia (subtract 5)) . (cambiarNombre ("Pobre"++)) $ unaMascota
 | otherwise = unaMascota

hacerseElMuerto :: Truco
hacerseElMuerto = (cambiarEnergia (+10)) . (cambiarConcentracion (const True))

mortalTriple :: Truco
mortalTriple unaMascota 
 | cumpleCondicionDelTruco 20 unaMascota = cambiarExperiencia (+10) unaMascota
 | otherwise = unaMascota


ayudanteDeSanta :: Mascota
ayudanteDeSanta = Mascota "Ayudante de santa" 10 "Bart Simpson" 5 50 [sentarse, hacerseElMuerto, tomarAgua, mortalTriple ] False

bolt :: Mascota
bolt = Mascota "Bolt" 5 "Penny" 1 100 [perroMojado, hacerseElMuerto, sentarse, mortalTriple] False

laTortuga :: Mascota
laTortuga  = Mascota "Flash" 32 "Fede Scarpa" 30 30 [sentarse, sentarse, sentarse, tomarAgua] True

realizarPresentacion :: Mascota -> Mascota
realizarPresentacion unaMascota = foldr ($) unaMascota (trucos unaMascota)

resultaados :: Mascota -> Resultados
resultaados unaMascota = Resultados (nombre unaMascota) ((*) (edad unaMascota) (energia unaMascota)) ()









