mascota(pepa, perro(mediano)).
mascota(frida, perro(grande)).
mascota(piru, gato(macho,15)).
mascota(kali, gato(macho,3)).
mascota(olivia, gato(hembra,16)).
mascota(mambo, gato(macho,2)).
mascota(abril, gato(hembra,4)).
mascota(buenaventura, tortuga(agresiva)).
mascota(severino, tortuga(agresiva)).
mascota(simon, tortuga(tranquila)).
mascota(quinchin, gato(macho,0)).

duenio(martin,      pepa,         adopcion(2014, adopto)).
duenio(martin,      frida,        adopcion(2015, adopto)).
duenio(martin,      piru,         adopcion(2010, compro)).
duenio(martin,      kali,         adopcion(2016, adopto)).
duenio(martin,      olivia,       adopcion(2014, adopto)).
duenio(constanza,   abril,        adopcion(2006, regalaron)).
duenio(constanza,   mambo,        adopcion(2015, adopto)).
duenio(hector,      abril,        adopcion(2015, adopto)).
duenio(hector,      mambo,        adopcion(2015, adopto)).
duenio(hector,      buenaventura, adopcion(1971, adopto)).
duenio(hector,      severino,     adopcion(2007, adopto)).
duenio(hector,      simon,        adopcion(2016, adopto)).
duenio(hector,      abril,        adopcion(2006, compro)).
duenio(silvio,      quinchin,     adopcion(1990, regalaron)).

persona(martin).
persona(constanza).
persona(hector).
persona(silvio).


comprometidos(P1, P2):-
    duenio(P1, Mascota, adopcion(Anio, adopto)),
    duenio(P2, Mascota, adopcion(Anio, adopto)),
    P1 \= P2.

locoDeLosGatos(Persona):-
    persona(Persona),
    forall(duenio(Persona, Mascota, _), mascota(Mascota, gato(_, _))),
    duenio(Persona, Mascota1, _),
    duenio(Persona, Mascota2, _),
    Mascota1 \= Mascota2.

esChapita(Mascota):- mascota(Mascota, perro(chico)).
esChapita(Mascota):- mascota(Mascota, tortuga(_)).

esChapita(Mascota):-
    mascota(Mascota, gato(macho, Caricias)),
    Caricias < 10.


puedeDormir(Persona):-
    persona(Persona),
    forall(duenio(Persona, Mascota, _), not(esChapita(Mascota))).

crisisNerviosa(Persona, Anio):-
    persona(Persona),
    esChapita(Mascota),
    esChapita(Mascota2),
    duenio(Persona, Mascota, adopcion(Fecha, _)),
    duenio(Persona, Mascota2, adopcion(Fecha2, _)),
    Fecha2 =< Fecha,
    Anio is Fecha + 1.

dominaA(M1, M2):-
    mascota(M1, gato(_, _)),
    mascota(M2, perro(_)).

dominaA(M1, M2):-
    mascota(M1, gato(_, _)),
    mascota(M2, gato(_, _)),
    esChapita(M1),
    not(esChapita(M2)).

dominaA(M1, M2):-
    mascota(M1, perro(grande)),
    mascota(M2, perro(chico)).

dominaA(M1, M2):-
    mascota(M1, tortuga(agresiva)),
    mascota(M2, _).

mascotaAlfa(Persona, Mascota):-
    persona(Persona),
    duenio(Persona, Mascota, _),
    forall((duenio(Persona, Mascota2, _), Mascota2 \= Mascota), dominaA(Mascota, Mascota2)).


/* materialista(Persona):-
    persona(Persona),
    not(duenio(Persona, _, _)) */
