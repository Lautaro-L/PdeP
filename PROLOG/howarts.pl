mago(harry).
mago(draco).
mago(hermione).

odiaria(slytherin, harry).
odiaria(hufflepuff, draco).

sangre(mestizo, harry).
sangre(pura, draco).
sangre(impura, hermione).

caracteristicas(corajudo, harry).
caracteristicas(amistoso, harry).
caracteristicas(orgulloso, harry).
caracteristicas(inteligente, harry).
caracteristicas(inteligente, draco).
caracteristicas(orgulloso, draco).
caracteristicas(orgulloso, hermione).
caracteristicas(inteligente, hermione).
caracteristicas(responsable, hermione).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

requisitos(gryffindor, coraje).
requisitos(slytherin, orgullo).
requisitos(slytherin, inteligencia).
requisitos(ravenclaw, inteligencia).
requisitos(ravenclaw, responsable).
requisitos(hufflepuff, amistoso).

%%%%%%%%%%%%%%%%

puedeEntrar(slytherin, Mago):-
    mago(Mago),
    sangre(Tipo, Mago),
    Tipo \= impura.

puedeEntrar(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

caracterApropiado(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    forall(requisitos(Casa, Requisito), caracteristicas(Requisito, Mago)).

posibleSeleccion(Casa, Mago):-
    puedeEntrar(Casa, Mago),
    caracterApropiado(Casa, Mago),
    not(odiaria(Casa, Mago)).

posibleSeleccion(gryffindor, hermione).

cadenaDeAmistades([UnMago, OtroMago | OtrosMagos]):-
    mago(UnMago),
    mago(OtroMago),
    caracteristicas(amistoso, UnMago),
    caracteristicas(amistoso, OtroMago),
    posibleSeleccion(Casa, UnMago),
    posibleSeleccion(Casa, OtroMago),
    cadenaDeAmistades([OtroMago | OtrosMagos]).

cadenaDeAmistades([UnMago]):-
    mago(UnMago),
    caracteristicas(amistoso, UnMago).

cadenaDeAmistades([]).





%%%%% 2da parte

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizoAccion(harry, fueraDeLaCama).
hizoAccion(hermione, irA(tercerPiso)).
hizoAccion(hermione, irA(restringidaBiblioteca)).
hizoAccion(harry, irA(bosque)).
hizoAccion(harry, irA(tercerPiso)).
hizoAccion(draco, irA(mazmorras)).
hizoAccion(ron, buenaAccion(50, ganarAjedrezMagico)).
hizoAccion(hermione, buenaAccion(50, salvarAmigos)).
hizoAccion(harry, buenaAccion(60, ganarleAVoldemort)).

lugarProhibido(tercerPiso, 75).
lugarProhibido(bosque, 50).
lugarProhibido(restringidaBiblioteca, 10).

puntajePorAccion(fueraDeLaCama, -50).

puntajePorAccion(irA(Lugar), Puntos):-
    lugarProhibido(Lugar, Puntaje),
    Puntos is Puntaje * -1.

puntajePorAccion(buenaAccion(Puntaje, _), Puntaje).



buenAlumno(Alumno):-
    mago(Alumno);
    forall(hizoAccion(Alumno, Accion), (puntajePorAccion(Accion, Puntaje), Puntaje > 0)).


accionRecurrente(Accion):-
    hizoAccion(Mago, Accion),
    hizoAccion(OtroMago, Accion),
    Mago \= OtroMago.


puntosObtenidos(Mago, Accion, Puntos):-
    hizoAccion(Mago, Accion),
    puntajePorAccion(Accion, Puntos).

puntosDeLaCasa(Casa, Puntaje):-
    casa(Casa),
    findall(Puntos, (esDe(Casa, Mago), puntosObtenidos(Mago, _, Puntos) ), ListaDePuntos),
    sumlist(ListaDePuntos, Puntaje).

casaGanadora(Casa):-
    puntosDeLaCasa(Casa, Puntaje),
    forall((puntosDeLaCasa(Casas, Puntajes), Casa \= Casas ), Puntaje > Puntajes).
    