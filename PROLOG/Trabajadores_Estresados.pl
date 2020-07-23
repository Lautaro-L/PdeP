tomarExamen(paradigmaLogico, aula522).

hacerUnDiscurso(utn, 0).

meterUnGol(primeraDivision).


nacio(dani, buenosAires).
nacio(alf, buenosAires).
nacio(nico, buenosAires).

fecha(10, 8, 2017).
fecha(11, 8, 2017).

hizo(dani, tomarExamen(paradigmaLogico, aula522), fecha(10, 8, 2017)).
hizo(dani, meterUnGol(primeraDivision), fecha(10, 8, 2017)).
hizo(dani, tomarExamen(paradigmaLogico, aula522), fecha(11 8, 2017)).


seJuegaEn(primeraDivision, buenosAires).

%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).


%------Punto 1
seHizoEn(tomarExamen(_, Lugar), Lugar).
seHizoEn(hacerUnDiscurso(Lugar, _), Lugar).
seHizoEn(seJuegaEn(Torneo), Lugar):-
    seJuegaEn(Torneo, Lugar).



dulceHogar(Persona):-
    nacio(Persona, Lugar),
    forall(hizo(Persona, Tarea, _), seHizoEn(Tarea, Lugar)).



%----Punto 2
temaComplejo(paradigmaLogico).

quedaEnArgentina(Lugar):-
    quedaEn(Lugar, argentina).

quedaEnArgentina(Lugar):-
    quedaEn(Lugar, Lugar2),
    quedaEnArgentina(Lugar2).  




estresNacional(tomarExamen(Tema, Lugar)):-
    quedaEnArgentina(Lugar),
    temaComplejo(Tema).

estresNacional(hacerUnDiscurso(Lugar, Publico)):-
    quedaEnArgentina(Lugar),
    Publico > 30000.

estresNacional(meterUnGol(Torneo)):-
    seJuegaEn(Torneo, Lugar),
    quedaEnArgentina(Lugar).


    







