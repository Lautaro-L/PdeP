anioActual(2015).
%festival(nombre, lugar, bandas, precioBase).
%lugar(nombre, capacidad).
festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).
festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).
festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).
festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).

%banda(nombre, año, nacionalidad, popularidad).

banda(paulMasCarne,1960, uk, 70).
banda(muse,1994, uk, 45).
banda(kiss,1973, us, 63).
banda(erucaSativa,2007, ar, 60).
banda(judasPriest,1969, uk, 91).
banda(tanBionica,2012, ar, 71).
banda(miranda,2001, ar, 38).
banda(laRenga,1988, ar, 70).
banda(blackSabbath,1968, uk, 96).
banda(pharrellWilliams,2014, us, 85).

%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% tipos de entrada: campo, plateaNumerada(numero de fila),

plateaGeneral(zona).
entradasVendidas(lulapaluza, campo, 600).
entradasVendidas(lulapaluza, plateaGeneral(zona1), 200).
entradasVendidas(lulapaluza, plateaGeneral(zona2), 300).
entradasVendidas(mostrosDelRock, campo, 20000).
entradasVendidas(mostrosDelRock, plateaNumerada(1), 40).
entradasVendidas(mostrosDelRock, plateaNumerada(2), 0).

% … y asi para todas las filas

entradasVendidas(mostrosDelRock,plateaNumerada(10), 25).
entradasVendidas(mostrosDelRock,plateaGeneral(zona1), 300).
entradasVendidas(mostrosDelRock,plateaGeneral(zona2), 500).

plusZona(hipodromo, zona1, 55).
plusZona(hipodromo, zona2, 20).
plusZona(granRex, zona1, 45).
plusZona(granRex, zona2, 30).
plusZona(aerodromo, zona1, 25).


%-------------Punto 1

estaDeModa(Banda):-
    banda(Banda, Fecha, _, Popularidad),
    between(2010, 2015, Fecha),
    Popularidad > 70.

%---------------Punto 2

esCareta(Festival):-
    festival(Festival, _, Bandas, _),
    findall(BandaDeModa, (estaDeModa(BandaDeModa), member(BandaDeModa, Bandas)), BandasDeModa),
    length(BandasDeModa, Cantidad),
    Cantidad > 2.
    
esCareta(Festival):-
    festival(Festival, _, Bandas, _),
    member(miranda, Bandas).

esCareta(Festival):-
    festival(Festival, _, _, _),
    not(entradaRazonable(Festival, _)).

%----------Punto 3

entradaRazonable(Festival, plateaGeneral(Zona)):-
    costoDeLaEntrada(Festival, plateaGeneral(Zona), Costo),
    festival(Festival, lugar(Lugar, _), _, _),
    plusZona(Lugar, Zona, Plus),
    Base10 is Costo * 0.1,
    Plus < Base10.


entradaRazonable(Festival, campo):-
    costoDeLaEntrada(Festival, campo, Costo),
    popularidadTotal(Festival, Pop),
    Pop > Costo. 


entradaRazonable(Festival, plateaNumerada(Fila)):-
    festival(Festival, _, Bandas, _),
    forall(member(BandaDeModa, Bandas), not(estaDeModa(BandaDeModa))),
    costoDeLaEntrada(Festival, plateaNumerada(Fila), Costo),
    750 >= Costo.

entradaRazonable(Festival, plateaNumerada(Fila)) :-
    festival(Festival, lugar(_, Tamanio), _, _),
    costoDeLaEntrada(Festival, plateaNumerada(Fila), Costo),
    Costo < Tamanio.

entradaRazonable(Festival, plateaNumerada(Fila)) :-
    festival(Festival, _, _, _),
    costoDeLaEntrada(Festival, plateaNumerada(Fila), Costo),
    popularidadTotal(Festival, Pop),
    Costo < Pop.

popularidadTotal(Festival, Pop):-
    festival(Festival, _, Bandas, _),
    findall(PopInd, (member(Banda, Bandas), popBanda(Banda, PopInd)), Popularidades),
    sum_list(Popularidades, Pop).
    
popBanda(Banda, Pop):-
    banda(Banda,_, _, Pop).

costoDeLaEntrada(Festival, campo, Base):-
    festival(Festival, _, _, Base).

costoDeLaEntrada(Festival, plateaNumerada(Asiento), Costo):-
    festival(Festival, _, _, Base),
    entradasVendidas(Festival, plateaNumerada(Asiento), _),
    Costo is (Base + 200) / Asiento.

costoDeLaEntrada(Festival, plateaGeneral(Zona), Costo):-
    festival(Festival, lugar(Lugar, _), _, Base),
    plusZona(Lugar, Zona, Plus),
    Costo is Base + Plus.

%---------Punto 4


nacanpop(Festival):-
    festival(Festival, _, Bandas, _),
    forall(member(Banda, Bandas), banda(Banda,_, ar, _)),
    entradaRazonable(Festival, _).

%---------Punto 5
recaudacion(Festival, Recaudacion):-
    findall(Costo, precioEntradas())