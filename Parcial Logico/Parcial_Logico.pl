%Para empezar, tenemos jugadores de quienes sabemos su nombre, su rating y su civilización favorita. 
%También sabemos qué unidades, recursos y edificios tiene cada jugador.

jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).


% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).



%------Punto 1


esUnAfano(Jugador1, Jugador2):-
    jugador(Jugador1, Rating1, _),
    jugador(Jugador2, Rating2, _),
    Jugador1 \= Jugador2,
    Diferencia is Rating1 - Rating2,
    Diferencia > 500.

%------Punto 2

esArquero(Unidad):- militar(Unidad, _, arqueria).
esCaballeria(Unidad):- militar(Unidad, _, caballeria).
esPiquero(Unidad):- militar(Unidad, _, piquero).
esInfanteria(Unidad):- militar(Unidad, _, infanteria).
esSamurai(samurai).
esUnico(Unidad):- militar(Unidad, _, unica).


esEfectivo(Unidad1, Unidad2):-
    esCaballeria(Unidad1),
    esArquero(Unidad2).

esEfectivo(Unidad1, Unidad2):-
    esArquero(Unidad1),
    esInfanteria(Unidad2).

esEfectivo(Unidad1, Unidad2):-
    esInfanteria(Unidad1),
    esPiquero(Unidad2).

esEfectivo(Unidad1, Unidad2):-
    esPiquero(Unidad1),
    esCaballeria(Unidad2).

esEfectivo(Unidad1, Unidad2):-
    esSamurai(Unidad1),
    esUnico(Unidad2).

%------Punto 3

%aca dude si debia limitar a que por lo menos posea una o no 

alarico(Jugador):-
    tiene(Jugador, unidad(_, _)),
    forall(tiene(Jugador, unidad(Unidad, _)), esInfanteria(Unidad)).

%-----Punto 4

leonidas(Jugador):-
    tiene(Jugador, unidad(_, _)),
    forall(tiene(Jugador, unidad(Unidad, _)), esPiquero(Unidad)).

%-----Punto 5

nomada(Jugador):-
    jugador(Jugador, _, _),
    not(tiene(Jugador, edificio(casa, _))).

%-----Punto 6

esAldeano(Unidad):- aldeano(Unidad, _).

cuantoCuesta(Unidad, costo(Madera, Alimento, Oro)):-
    militar(Unidad, costo(Madera, Alimento, Oro), _).

cuantoCuesta(Unidad, costo(Madera, Alimento, Oro)):- 
    edificio(Unidad, costo(Madera, Alimento, Oro)).

cuantoCuesta(Unidad, costo(0, 50, 0)):-
    esAldeano(Unidad).

cuantoCuesta(urnaMercante, costo(100, 0, 50)).
cuantoCuesta(carreta, costo(100, 0, 50)).

%-----Punto 7

produccion(Unidad, produce(Madera, Alimento, Oro)):-
    aldeano(Unidad, produce(Madera, Alimento, Oro)).

produccion(keshik, produce(0, 0, 10)).
produccion(urnaMercante, produce(0, 0, 32)).
produccion(carreta, produce(0, 0, 32)).

%-----Punto 8


produceRecursoXCantidad(Unidad, Cantidad, madera, Produce):-
    produccion(Unidad, produce(Madera, _, _)),
    Produce is Madera * Cantidad.

produceRecursoXCantidad(Unidad, Cantidad, alimento, Produce):-
    produccion(Unidad, produce(_, Alimento, _)),
    Produce is Alimento * Cantidad.

produceRecursoXCantidad(Unidad, Cantidad, oro, Produce):-
    produccion(Unidad, produce(_, _, Oro)),
    Produce is Oro * Cantidad.

produccionTotal(Jugador, Recurso, ProduccionTotal):-
    jugador(Jugador, _, _),
    findall(Produce, (tiene(Jugador, unidad(Unidad, Cantidad)), produceRecursoXCantidad(Unidad, Cantidad, Recurso ,Produce)), Produccion),
    sum_list(Produccion, ProduccionTotal).

%------Punto 9

tieneXunidadesTotales(Jugador, Total):-
    jugador(Jugador,_ ,_),
    findall(Cantidad, tiene(jugador, unidad(_, Cantidad)), ListaDeCantidades),
    sum_list(ListaDeCantidades, Total).

produccionvalorada(Jugador, oro ,ProduccionAbsoluta):-
    jugador(Jugador, _, _),
    produccionTotal(Jugador, oro, ProdOro),
    ProduccionAbsoluta is ProdOro *5.

produccionvalorada(Jugador, madera ,ProduccionAbsoluta):-
    jugador(Jugador, _, _),
    produccionTotal(Jugador, madera, ProdMadera),
    ProduccionAbsoluta is ProdMadera *3.

produccionvalorada(Jugador, alimento, ProduccionAbsoluta):-
    jugador(Jugador, _, _),
    produccionTotal(Jugador, alimento, ProdAlimento),
    ProduccionAbsoluta is ProdAlimento *2.


produccionAbsoluta(Jugador, ProduccionAbsoluta):-
    jugador(Jugador, _, _),
    findall(ValorTotal, produccionvalorada(Jugador, _, ValorTotal), Producciones),
    sum_list(Producciones, ProduccionAbsoluta).


estaPeleado(Jugador1, Jugador2):-
    jugador(Jugador1, _, _),
    jugador(Jugador2, _, _),
    Jugador1 \= Jugador2,
    not(esUnAfano(Jugador1, Jugador2)),
    not(esUnAfano(Jugador2, Jugador1)),
    tieneXunidadesTotales(Jugador1, Cantidad1),
    tieneXunidadesTotales(Jugador2, Cantidad2),
    Cantidad1 == Cantidad2,
    produccionAbsoluta(Jugador1, Produccion1),
    produccionAbsoluta(Jugador2, Produccion2),
    Diferencia is Produccion1 - Produccion2,
    abs(Diferencia, TotalAbs),
    TotalAbs < 100.

%------Punto 10
tieneAlMenos(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, edificio(herreria, _)).

tieneAlMenos(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, edificio(galeriaDeTiro, _)).

tieneAlMenos(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, edificio(establo, _)).

avanzaA(Jugador, edadMedia):-
    jugador(Jugador, _, _).

avanzaA(Jugador, edadDeLosCastillos):-
    tiene(Jugador, recursos(_, Alimento, Oro)),
    Alimento >= 800,
    Oro >=200,
    tieneAlMenos(Jugador).

avanzaA(Jugador, edadFeudal):-
    tiene(Jugador, recursos(_, Alimento, _)),
    Alimento >= 500,
    tiene(Jugador, edificio(casa, _)).

avanzaA(Jugador, edadImperial):-
    tiene(Jugador, recursos(_, Alimento, Oro)),
    Alimento >= 1000,
    Oro >=800,
    tiene(Jugador, edificio(castillo, _)),
    tiene(Jugador, edificio(universidad, _)).


