import Text.Show.Functions

type Tarea = (Heroe -> Heroe)

data Artefacto = Artefacto{
    nombre :: String,
    rareza :: Int
}deriving (Show, Eq)

--------------1)

data Heroe = Heroe {
    epitelo :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    listaDeTareas :: [Tarea]
}deriving (Show)

--------------Auxiliares

cambiarEpitelo :: (String -> String) -> Heroe -> Heroe
cambiarEpitelo unaFuncion unHeroe = unHeroe { epitelo = unaFuncion . epitelo $ unHeroe }

cambiarReconocimiento :: (Int -> Int) -> Heroe -> Heroe
cambiarReconocimiento unaFuncion unHeroe = unHeroe { reconocimiento = unaFuncion . reconocimiento $ unHeroe }

cambiarArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
cambiarArtefactos unaFuncion unHeroe = unHeroe { artefactos = unaFuncion $ artefactos unHeroe }

cambiarRareza :: (Int -> Int) -> Artefacto -> Artefacto
cambiarRareza unaFuncion unArtefacto =  unArtefacto { rareza =  unaFuncion $ rareza unArtefacto }

cambiarListaDeTareas :: ([Tarea] -> [Tarea]) -> Heroe -> Heroe
cambiarListaDeTareas unaFuncion unHeroe = unHeroe { listaDeTareas = unaFuncion . listaDeTareas $ unHeroe }

--------------2)

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe 
 | (>1000) . reconocimiento $ unHeroe = cambiarEpitelo (const "El mitico") unHeroe
 | (>=500) . reconocimiento $ unHeroe = cambiarEpitelo (const "El magnifico") . cambiarArtefactos (++[Artefacto "lanza del Olimpo" 100]) $ unHeroe
 | (> 100) . reconocimiento $ unHeroe = cambiarEpitelo (const "Hoplita") . cambiarArtefactos (++[Artefacto "Xiphos" 50]) $ unHeroe
 | otherwise = unHeroe

--------------3)

encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto unArtefacto = (cambiarListaDeTareas (++[encontrarUnArtefacto unArtefacto])) . cambiarReconocimiento ((+) . rareza $ unArtefacto) . cambiarArtefactos (++[unArtefacto])

escalarElOlimpo :: Tarea
escalarElOlimpo = cambiarListaDeTareas (++[escalarElOlimpo]) . cambiarArtefactos (++[Artefacto "El relámpago de Zeus" 500]) . filtrarArtefactosPor 1000 . multiplicarRarezaPor 3 . cambiarReconocimiento (+500)

multiplicarRarezaPor :: Int -> Heroe -> Heroe
multiplicarRarezaPor multiplo = cambiarArtefactos (map (cambiarRareza (*multiplo)))

filtrarArtefactosPor :: Int -> Heroe -> Heroe
filtrarArtefactosPor parametro = cambiarArtefactos (filter ((>parametro) . rareza)) 

ayudarACruzar :: Int -> Tarea
ayudarACruzar calles = cambiarListaDeTareas (++[ayudarACruzar calles]) . cambiarEpitelo (const ("groso" ++ take calles ['o' ..]))

matarUnaBestia :: String -> (Heroe -> Bool) -> Tarea
matarUnaBestia nombreDeLaBestia debilidad unHeroe
 | debilidad unHeroe = cambiarListaDeTareas (++[matarUnaBestia nombreDeLaBestia debilidad]) . cambiarEpitelo (const ("El asesino de " ++ nombreDeLaBestia)) $ unHeroe
 | otherwise = cambiarEpitelo (const "El cobarde") . cambiarArtefactos (drop 1) $ unHeroe

--------------4)

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [(Artefacto "Pistola" 1000), (Artefacto "El relámpago de Zeus" 500)] [matarAlLeonDeNemea]

--------------5)

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea = matarUnaBestia "Lleon de Nemea" ((>20) . length . epitelo)

--------------6)

realizarTarea :: Tarea -> Heroe -> Heroe
realizarTarea unaTarea = unaTarea

--------------7)

presumir :: Heroe -> Heroe -> (Heroe , Heroe)
presumir primerHeroe segundoHeroe
 | (reconocimiento primerHeroe) > (reconocimiento segundoHeroe) = (primerHeroe , segundoHeroe)
 | (reconocimiento primerHeroe) < (reconocimiento segundoHeroe) = (segundoHeroe , primerHeroe)
 | (sumaDeRarezas primerHeroe) > (sumaDeRarezas segundoHeroe) = (primerHeroe , segundoHeroe)
 | (sumaDeRarezas primerHeroe) < (sumaDeRarezas segundoHeroe) = (segundoHeroe , primerHeroe)
 | otherwise = presumir (realizarLabor primerHeroe (listaDeTareas segundoHeroe)) (realizarLabor segundoHeroe (listaDeTareas primerHeroe))

sumaDeRarezas :: Heroe -> Int
sumaDeRarezas unHeroe = sum . map (rareza) $ (artefactos unHeroe)

--------------8)

{- No llegariamos a ningun resultado, debido a que entraria a una funcion recursiva
   y con los datos que poseemos no entrariamos nunca a una condicion de salida,
   por lo tanto la funcion nunca devolveria nada.
-}

--------------9)

realizarLabor :: Heroe -> [Tarea] -> Heroe
realizarLabor unHeroe [] = unHeroe
realizarLabor unHeroe (x:xs) = foldr ($) unHeroe (x:xs)

--------------10)

{- 
    No ya que si queremos conocer el estado final de aplicarle una lista de tareas (Funciones)
    como deseamos obtener el estado final, debemos evaluar la lista por completo,
    al ser una lista infinita se complican las cosas ya que se nos vuelve fisicamente imposible
    llegar al final de dicha lista por lo tanto se nos vuelve imposible conocer el estado final
 -}