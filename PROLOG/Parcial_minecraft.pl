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



