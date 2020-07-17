rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).


inspeccionSatisfactoria(Restaurante):-
    not(rata(_, Restaurante)).

chef(Empleado, Restaurante):-
    trabajaEn(Restaurante, Empleado),
    cocina(Empleado, _, _).

chefcito(Rata):-
    trabajaEn(Restaurante, linguini),
    rata(Rata, Restaurante).


cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

cocinaBien(remy,Plato):-
    cocina(_,Plato,_).

encargadoDe(Encargado, Plato, Restaurante):-
    trabajaEn(Restauranto, Encargado),
    cocina(Encargado, Plato, Experiencia),
    trabajaEn(Restauranto, Empleado),
    forall((cocina(Empleado, Plato, Exp2), Empleado \= Encargado), Experiencia >= Exp2).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).


saludable(Plato):-
    plato(Plato, entrada(Ingredientes)),
    length(Ingredientes, Longitud),
    Calorias is Longitud * 15,
    Calorias < 75.

calculoDePrincipales(principal(pure, Coccion), Calorias):-
    Calorias is 20 +( 5 * Coccion).

calculoDePrincipales(principal(papasFritas, Coccion), Calorias):-
    Calorias is 50 +( 5 * Coccion).

calculoDePrincipales(principal(ensalada, Coccion), Calorias):-
    Calorias is (5 * Coccion).

saludable(Plato):-
    plato(Plato, principal(Plato, Coccion)),
    calculoDePrincipales(principal(Plato, Coccion), Calorias),
    Calorias < 75.

saludable(Plato):-
    plato(Plato, postre(Calorias)),
    Calorias < 75.

criticaPositiva(antonEgo, Restaurante):-
    inspeccionSatisfactoria(Restaurante),
