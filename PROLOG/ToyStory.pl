duenio(andy, woody, 8).
duenio(sam, jessie, 3).

juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa, caraDePapa( [original(pieIzquierdo), original(pieDerecho), repuesto(nariz)] )).

esRaro(deAccion(stacyMalibu, 1, [sombrero])).

esColeccionista(sam).




%-----Punto 1

tematica(deTrapo(Tematica), Tematica).
tematica(deAccion(Tematica,_), Tematica).
tematica(miniFiguras(Tematica,_), Tematica).
tematica(caraDePapa(_), caraDePapa).


esDePlastico(miniFiguras(_,_)).
esDePlastico(caraDePapa(_)).


esDeColeccion(Juguete):-
    tematica(Juguete, Tematica),
    esRaro(deAccion(Tematica, _, _)).

esDeColeccion(caraDePapa(Items)):- esRaro(caraDePapa(Items)).

esDeColeccion(deTrapo(_)).


%-----Punto 2

amigoFiel(Duenio, Juguete):-
    




