-- 1)
funcionMisteriosa :: Int -> String -> Bool
funcionMisteriosa unNumero unaPalabra = ((==unNumero).length) unaPalabra
--funcionMisteriosa
--funcionMisteriosa :: Int -> String -> Bool
--funcionMisteriosa 3
--funcionMisteriosa :: String -> Bool


--2)
esNumeroDeLaSuerteSi :: (Int-> Bool) -> Int->  Bool 
esNumeroDeLaSuerteSi unaCondicion unNumero = unaCondicion unNumero
--esNumeroDeLaSuerteSi
--esNumeroDeLaSuerteSi :: (Int -> Bool) -> Int -> Bool
--esNumeroDeLaSuerteSi (>3)
--esNumeroDeLaSuerteSi (>3) :: Int -> Bool
--esNumeroDeLaSuerteSi (>3) 4
--esNumeroDeLaSuerteSi (>3) 4 :: Bool


--3)
esMayorQue x = (>x)
esPar = even
cumpleLasCondiciones unaCondicion otraCondicion unNumero = unaCondicion unNumero && otraCondicion unNumero
--cumpleLasCondiciones (esMayorQue 3) esPar
-- en este caso ambas funciones se aplican parcialmente 
-- cumpleLasCondiciones (esMayorQue 3) esPar :: (Int -> Bool)->(Int -> Bool) -> Int -> Bool
saludar unSaludo unNombre = unSaludo unNombre
-- saludar ( "hola" ++ )
-- ninguna es aplicada de forma parcial
-- saludar ("hola" ++ ) :: (String -> String) -> String -> String
elModuloDelPrimeroEsMayor primerNumero segundoNumero = abs primerNumero > abs segundoNumero
-- ninguna se aplica parcialmente 
-- elModuloDelPrimeroEsMayor :: (Num a, Ord a, Num b, Ord b) => a -> b -> Bool
tuplaDeFunciones unaFuncion otraFuncion unaPalabra = (unaFuncion unaPalabra, otraFuncion unaPalabra)
-- ambas se aplican parcialmente.
--tuplaDeFunciones :: a -> (Bool, Bool)


--4)
tomarUltimosCuatroCaracteres :: String -> String
tomarUltimosCuatroCaracteres palabra = (reverse . take 4 . reverse) palabra
terminaCon :: String -> String -> Bool 
terminaCon ultimosCuatro = ((==ultimosCuatro) . tomarUltimosCuatroCaracteres)
esPalabraBuenarda :: String -> Bool
esPalabraBuenarda = (terminaCon "ardo")
esPalabraItaliana :: String -> Bool
esPalabraItaliana = (terminaCon "elli")
esMejorNumero :: Int -> Int -> Bool
esMejorNumero n1 n2 = ((&&) ((>n2)n1)) ((>200) ((+(-n2))n1))