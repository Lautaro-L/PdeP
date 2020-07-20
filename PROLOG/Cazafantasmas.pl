herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).


posee(Persona, aspiradora(Potencia)):-
    tiene(Persona, aspiradora(Potencia2)),
    Potencia2 >= Potencia.

posee(Persona, Elemento):-
    tiene(Persona, Elemento).

puedeHacer(Persona, Tarea):-
    tiene(Persona, varitaDeNeutrones),
    herramientasRequeridas(Tarea, _).

puedeHacer(Persona, Tarea);-
herramientasRequeridas(Tarea, Herramientas),
tiene(Persona, _),
forall(member(Herramienta, Herramientas), posee(Persona, Herramienta)).

tareaPedida(beto, limpiarObelisco, 100).
tareaPedida(beto, vacunarGente, 250).
tareaPedida(dona, buscarStickers, 10).
tareaPedida(dona, buscar22s, 20).
tareaPedida(lau, buscar22s, 50).


precio(limpiarObelisco, 20).
precio(buscarStickers, 10).
precio(vacunarGente, 40).
precio(buscar22s, 22).

costoPorm2(Tarea, M2, Costo):-
    precio(Tarea, P),
    Costo is P * M2.

costo(Cliente, CostoTot):-
    tareaPedida(Cliente, _, _),
    findall(Costo, (tareaPedida(Cliente, Tarea, Superficie), costoPorm2(Tarea, Superficie, Costo)), Lista),
    sum_list(Lista, CostoTot).
    
    