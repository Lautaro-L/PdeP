import Text.Show.Functions
import Data.Char


data Barbaro = Barbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
    } deriving (Show)

type Objeto = Barbaro -> Barbaro
type Habilidad = [Char]
type Aventura = Barbaro -> Bool
data Vive = EstaVivo | NoVive deriving (Show, Eq, Ord)


dave :: Barbaro
dave = Barbaro "dave" 100 ["tejer", "escribir"] [ardilla, varitasDefectuosas]

daverep :: Barbaro
daverep = Barbaro "dave" 100 ["tejer", "tejer", "tejer", "escribir"] [ardilla, espada 10]

cambiarNombre :: (String -> String) -> Barbaro -> Barbaro
cambiarNombre funcion barbaro = barbaro { nombre = funcion (nombre barbaro)}

cambiarFuerza :: (Int -> Int) -> Barbaro -> Barbaro
cambiarFuerza funcion barbaro = barbaro { fuerza = funcion (fuerza barbaro)}

cambiarHabilidades :: ([Habilidad] -> [Habilidad]) -> Barbaro -> Barbaro
cambiarHabilidades funcion barbaro = barbaro { habilidades = funcion (habilidades barbaro)}

cambiarObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
cambiarObjetos funcion barbaro = barbaro {objetos = funcion (objetos barbaro)}

espada ::Int -> Objeto
espada peso barbaro = cambiarFuerza ((+) (peso *2)) barbaro

varitasDefectuosas :: Objeto
varitasDefectuosas barbaro = cambiarHabilidades ("Hacer Magia" :) (cambiarObjetos (const [varitasDefectuosas]) barbaro)

ardilla :: Objeto
ardilla = id

amuletosMisticos ::String -> Barbaro -> Barbaro
amuletosMisticos habilidad barbaro = cambiarHabilidades (habilidad :) barbaro

cuerda :: Objeto -> Objeto -> Objeto
cuerda objeto1 objeto2 = (.) objeto1 objeto2

megafono :: Objeto
megafono barbaro = cambiarHabilidades (\habilidades -> (:[]) $ (map toUpper) (concat habilidades)) barbaro

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono

tieneLaHabilidad :: Habilidad -> Barbaro -> Bool
tieneLaHabilidad habilidad barbaro = elem habilidad (habilidades barbaro)

invasionDeSuciosDuendes :: Aventura
invasionDeSuciosDuendes barbaro = tieneLaHabilidad "Escribir Poesia Atroz" barbaro

noTienePulgares :: Barbaro -> Bool
noTienePulgares barbaro = "Faffy" == nombre barbaro || "Astro" == nombre barbaro

cremalleraDelTiempo :: Aventura
cremalleraDelTiempo barbaro = noTienePulgares barbaro

dameLasVocales :: [String] -> [String]
dameLasVocales lista = map (filter (vocales)) lista
 where vocales letra = elem letra "aeiouAEIOU"

todasTienenMasQueTres :: [String] -> Bool
todasTienenMasQueTres lista = all ((>3) . length) (dameLasVocales lista)

empiezanConMayusc :: [String] -> Bool
empiezanConMayusc lista = not (any (minusc) (map head lista))
 where minusc letra = elem letra ['a' .. 'b']

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra barbaro = (length . concat . habilidades $ barbaro) >=(length . objetos $ barbaro)

caligrafia :: Barbaro -> Bool
caligrafia barbaro = (empiezanConMayusc $ habilidades barbaro) && (todasTienenMasQueTres $ habilidades barbaro)

ritualDeFechorias :: Aventura
ritualDeFechorias barbaro = saqueo || gritoDeGuerra barbaro || caligrafia barbaro
 where saqueo = tieneLaHabilidad "robar" barbaro && (fuerza barbaro >80)

sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes barbaros aventura = filter aventura barbaros

sobrevivientesMejorada :: [Barbaro] -> Aventura -> [String]
sobrevivientesMejorada barbaros aventura = map (nombre) (filter aventura barbaros)

sinRepetidos [] = []
sinRepetidos (x:xs) = [x] ++ sinRepetidos (filter (/=x) (xs))

barbarosSinRepetidos :: Barbaro  -> Barbaro
barbarosSinRepetidos barbaro = barbaro {habilidades = sinRepetidos . habilidades $ barbaro}

----------------------------descendientes----------------------------------

usarObjetos barbaro [] = barbaro
usarObjetos barbaro [x] = x barbaro
usarObjetos barbaro (x:y:xs) = usarObjetos (x barbaro) (y:xs)

descendiente :: Barbaro -> Barbaro
descendiente barbaro = barbarosSinRepetidos (usarObjetos (cambiarNombre (++"*") barbaro) (objetos barbaro))

descendientes :: Barbaro -> [Barbaro]
descendientes barbaro = [descendiente barbaro] ++ descendientes (descendiente barbaro)