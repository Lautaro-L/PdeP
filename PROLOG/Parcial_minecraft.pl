jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%---------Punto 1

tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).

sePreocupaPorSuSalud(Jugador):-
    jugador(Jugador, Items, _),
    findall(Comestible, (comestible(Comestible), member(Comestible, Items)), Bag),
    length(Bag, Cant),
    Cant >= 2.


cantidadDeItem(Jugador, Item, Cantidad):-
    jugador(Jugador, Items, _),
    tieneItem(_, Item),
    findall(Item, member(Item, Items), Bag),
    length(Bag, Cantidad).
    
tieneMasDe(Jugador, Item):-
    cantidadDeItem(Jugador, Item, Cantidad),
    forall((cantidadDeItem(Jugador2, Item, Cant), Jugador \= Jugador2), Cantidad > Cant).

%--------Fin punto 1

%--------Inicio punto 2


hayMonstruos(Lugar):-
    lugar(Lugar, _, Oscuridad),
    Oscuridad > 6.

correPeligro(Jugador):-
    jugador(Jugador, _, Hambre),
    Hambre < 4,
    not(sePreocupaPorSuSalud(Jugador)).

correPeligro(Jugador):-
    lugar(Lugar, Jugadores, _),
    member(Jugador, Jugadores),
    hayMonstruos(Lugar).

nivelPeligrosidad(Lugar, 100):-
lugar(Lugar, Jugadores, _),
member(_, Jugadores),
hayMonstruos(Lugar).


nivelPeligrosidad(Lugar, Total):-
lugar(Lugar, Jugadores, Nivel),
not(member(_, Jugadores)),
Total is Nivel * 10.

nivelPeligrosidad(Lugar, Nivel):-
    lugar(Lugar, ListaDeJugadores, _),
    member(_,ListaDeJugadores),
    findall(JugadorHambriento, (hambriento(JugadorHambriento), member(JugadorHambriento, ListaDeJugadores)), JugadoresHambrientos),
    length(ListaDeJugadores, CantDeJugadores),
    length(JugadoresHambrientos, CantHambrientos),
    not(hayMonstruos(Lugar)),
    Nivel is (CantHambrientos*100)/CantDeJugadores.

hambriento(Jugador):-
    jugador(Jugador, _, Hambre),
    Hambre < 4.



%------------Fin 2 

%-------------Inicio 3


item(horno, [itemSimple(piedra, 8)]).
item(placaDeMadera, [itemSimple(madera, 1)]).
item(palo, [itemCompuesto(placaDeMadera)]).
item(antorcha, [itemCompuesto(palo), itemSimple(carbon, 1)]).

puedeConstruir(Jugador, Item):-
    jugador(Jugador, _, _),
    item(Item, ComponentesNecesarios),
    forall(member(ItemNecesario, ComponentesNecesarios), tieneAlMenos(Jugador, ItemNecesario)).

tieneAlMenos(Jugador, itemSimple(Item, CantidadMinima)):-
    cantidadDeItem(Jugador, Item, CantidadReal),
    CantidadReal >= CantidadMinima.

tieneAlMenos(Jugador, itemCompuesto(Item)):-
    item(Item, Items),
    member(ItemNecesario, Items),
    tieneAlMenos(Jugador, ItemNecesario).




