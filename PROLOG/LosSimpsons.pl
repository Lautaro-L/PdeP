/* Datos */
padreDe(sven,       abe).
padreDe(abe,        abbie).
padreDe(abe,        homero).
padreDe(abe,        herbert).
padreDe(clancy,     marge).
padreDe(clancy,     patty).
padreDe(clancy,     selma).
padreDe(homero,     bart).
padreDe(homero,     hugo).
padreDe(homero,     lisa).
padreDe(homero,     maggie).
padreDe(fede,       ling).
madreDe(edwina,     abbie).
madreDe(mona,       homero).
madreDe(gaby,       herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge,      bart).
madreDe(marge,      hugo).
madreDe(marge,      lisa).
madreDe(marge,      maggie).
madreDe(selma,      ling).
/* -------------------------- */
tieneHijo(Alguien):-
    padreDe(Alguien, _);
    madreDe(Alguien, _).


mismoPadre(UnHermano, OtroHermano):-
    padreDe(Padre, UnHermano),
    padreDe(Padre, OtroHermano).

mismaMadre(UnHermano, OtroHermano):-
    madreDe(Madre, UnHermano),
    madreDe(Madre, OtroHermano).

hermanos(UnHermano, OtroHermano):-
    mismoPadre(UnHermano, OtroHermano),
    mismaMadre(UnHermano, OtroHermano).

medioHermanos(UnHermano, OtroHermano):-
    mismoPadre(UnHermano, OtroHermano);
    mismaMadre(UnHermano, OtroHermano).

compartenHijo(Padre1, Padre2):-
    (padreDe(Padre1, Hijo), madreDe(Padre2, Hijo));
    (padreDe(Padre2, Hijo), madreDe(Padre1, Hijo)).

tioDe(Tio, Sobrino):-
    (padreDe(Padre, Sobrino), hermanos(Tio, Padre));
    (madreDe(Madre, Sobrino), hermanos(Tio, Madre));
    (tioDe(ElTio, Sobrino), compartenHijo(ElTio, Tio)).

abueloDe(Abuelo, Nieto):-
    padreDe(Abuelo, Padre), padreDe(Padre, Nieto);
    padreDe(Abuelo, Madre), madreDe(Madre, Nieto);
    madreDe(Abuelo, Padre), padreDe(Padre, Nieto);
    madreDe(Abuelo, Madre), madreDe(Madre, Nieto).

abueloMultiple(Abuelo):-
    aggregate_all(count, abueloDe(Abuelo, _), Count),
    Count >= 2.

descendiente(Ancestro, Descendiente):-
    padreDe(Ancestro, Descendiente); 
    padreDe(Ancestro, Padre), descendiente(Padre, Descendiente);

    padreDe(Ancestro, Descendiente);
    padreDe(Ancestro, Madre), descendiente(Madre, Descendiente);

    madreDe(Ancestro, Descendiente);
    madreDe(Ancestro, Padre), descendiente(Padre, Descendiente);

    madreDe(Ancestro, Descendiente);
    madreDe(Ancestro, Madre), descendiente(Madre, Descendiente).








