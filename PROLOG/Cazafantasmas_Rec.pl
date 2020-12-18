herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).


cazafantasma(egon).
cazafantasma(peter).
cazafantasma(winston).

item(egon, aspiradora(200)).
item(egon, trapeador).
item(peter, trapeador).
item(winston, varitaDeNeutrinos).

tieneHerramienta(Cazafantasma, Herramienta):-
    cazafantasma(Cazafantasma),
    item(Cazafantasma , Herramienta).

tieneHerramienta(Cazafantasma, aspiradora(PotenciaRequerida)):-
    cazafantasma(Cazafantasma),
    item(Cazafantasma, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

tieneHerramientas(Cazafantasma, []).

tieneHerramientas(Cazafantasma, [Herramienta]):-
    tieneHerramienta(Cazafantasma, Herramienta).

tieneHerramientas(Cazafantasma, [Herramienta | Herramientas]):-
    tieneHerramienta(Cazafantasma, Herramienta),
    tieneHerramientas(Cazafantasma,  Herramientas).


puedeRealizarTarea(Cazafantasma, Tarea):-
    cazafantasma(Cazafantasma),
    tieneHerramienta(Cazafantasma, varitaDeNeutrinos).

puedeRealizarTarea(Cazafantasma, Tarea):-
    cazafantasma(Cazafantasma),
    herramientasRequeridas(Tarea, Requisitos),
    tieneHerramientas(Cazafantasma, Requisitos).


cobrarCliente(Cliente, Tareas, Costo):-
    findall(CostoPorM2, (tareaPedida(Cliente, Tarea, Metros), costoDeUnaTarea(Tarea, Metros, CostoPorM2)), Costos),
    sumlist(Costos, Costo).

tareaPedida(Cliente, Tarea, Metros).

precio(Tarea, CostoPorM2).

costoDeUnaTarea(Tarea, Metros, Costo):-
    precio(Tarea, CostoPorM2),
    Costo is Metros * CostoPorM2.

aceptaPedido(Cliente, Cazafantasma):-
    cazafantasma(Cazafantasma),
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizarTarea(Cazafantasma, Tarea)),
    aceptaCriterio(Cazafantasma, Cliente).

aceptaCriterio(ray, Cliente):-
    forall(tareaPedida(Cliente, Tarea, _), not(tareaPedida(Cliente, limpiarTecho, _))).



