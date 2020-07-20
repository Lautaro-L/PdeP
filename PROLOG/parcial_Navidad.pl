persona(laura, 24).
persona(federico, 31).
persona(maria, 23).
persona(jacobo, 45).
persona(enrique, 49).
persona(andrea, 38).
persona(gabriella, 4).
persona(gonzalo, 23).
persona(alejo, 20).
persona(andres, 11).
persona(ricardo, 39).
persona(ana, 7).
persona(juana, 15).

%Quien quiere

quiere(andres, juguete(maxSteel, 150)).
quiere(andres, bloques([piezaT, plezaL, cubo, plezaChata])).
quiere(maria, bloques([piezaT, piezaT])).
quiere(alejo, bloques([piezaT])).
quiere(juana, juguete(barbie, 175)).
quiere(federico, abrazo).
quiere(enrique, abrazo).
quiere(gabriela, juguete(gabeneitor2000, 5000)).
quiere(laura, abrazo).
qutere(gonzalo, abrazo).

%presupuesto(Quien, Presupuesto).

presupuesto(jacobo, 20).
presupuesto(enrique, 2311).
presupuesto(ricardo, 154).
presupuesto(andrea, 100).
presupuesto(laura, 2000).

% accion(Quién, Hizo)

accion(andres,   travesura(3)).
accion(andres,   ayudar(ana)).
accion(ana,      golpear(andres)).
accion(ana,      travesura(1)).
accion(marla,    ayudar(federico)).
accion(maria,    favor(juana)).
accion(juana,    favor(maria)).
accion(federico, golpear(enrique)).
accion(gonzalo,  golpear(alejo)).
accion(alejo,    travesura(4)).

%padre(Padre o Madre, HIjo o Hija).

padre(jacobo, ana).
padre(jacobo, juana).
padre(enrique, federico).
padre(ricardo, maria).
padre(andrea, andres).
padre(laura, gabriela).


%Inicio del Programa

creeEnEl(Persona):-
    persona(Persona, Edad),
    Edad < 13.

creeEnEl(federico).

buenaAccion(favor(_)).
buenaAccion(ayudar(_)).

buenaAccion(travesura(Nivel)):-
    3 >= Nivel.

sePortoBien(Persona):-
    persona(Persona, _),
    forall(accion(Persona, Accion), buenaAccion(Accion)).
    
malcriado(Persona):-
    persona(Persona,_),
    not(sePortoBien(Persona)).

malcriado(Persona):-
    persona(Persona,_),
    not(creeEnEl(Persona)).


malcriador(Padre):-
    padre(Padre, _),
    forall(padre(Padre, Hijo), malcriado(Hijo)).



costos(juguete(_, Costo), Costo).

costos(bloques(Bloques), Costo):-
    length(Bloques, Total),    
    Costo is Total * 3.

costos(abrazo, 0).


puedeCostear(Padre, Hijo):-
    padre(Padre, Hijo),
    findall(Costo, (quiere(Hijo, Juguete), costos(Juguete, Costo)), ListaDeCostos),
    sum_list(ListaDeCostos, Total),
    presupuesto(Padre, Presupuesto),
    Presupuesto >= Total.

regaloCandidatoPara(Regalo, Persona):-
    padre(Padre, Persona),
    sePortoBien(Persona),
    creeEnEl(Persona),
    presupuesto(Padre, Presupuesto),
    quiere(Persona, Regalo),
    costos(Regalo, Costo),
    Presupuesto >= Costo.



%regalos que recibe

regalosQueRecibe(Persona, Regalos):-
    padre(Padre, Persona),
    puedeCostear(Padre, Persona),
    findall(Regalo, quiere(Persona, Regalo), Regalos).

regalosQueRecibe(Persona, Regalos):-
    padre(Padre, Persona),
    not(puedeCostear(Padre, Persona)),
    regaloMalo(Persona, Regalos).

regaloMalo(Persona, medias(gris, blanca)):-
    sePortoBien(Persona).

regaloMalo(Persona, carbon):-
    accion(Persona, MalaAccion).
    findall(MalaAccion, not(buenaAccion(MalaAccion)), Acciones),
    length(Acciones, Total),
    Total >= 2.