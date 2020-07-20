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


plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).


% Fin de la base de datos, Inicio del Programa

% 1)

inspeccionSatisfactoria(Restaurante):-
    not(rata(_, Restaurante)).

%2)

chef(Empleado, Restaurante):-
    trabajaEn(Restaurante, Empleado),
    cocina(Empleado, _, _).

%3)

chefcito(Rata):-
    trabajaEn(Restaurante, linguini),
    rata(Rata, Restaurante).

%4)

cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

cocinaBien(remy,Plato):-
    cocina(_,Plato,_).

%5)

encargadoDe(Encargado, Plato, Restaurante):-
    cocinaEn(Encargado, Plato, Restaurante, Experiencia),
    forall(cocinaEn(Persona, Plato, Restaurante, OtraExperiencia), OtraExperiencia =< Experiencia).
  
  cocinaEn(Persona, Plato, Restaurante, Experiencia):-
    cocina(Persona, Plato, Experiencia),
    trabajaEn(Restaurante, Persona).

%6)

saludable(Plato):-
    plato(Plato, TipoPlato),
    calorias(TipoPlato, Calorias),
    Calorias < 75.


calorias(entrada(Ingredientes), Calorias):-
    length(Ingredientes, CantidadDeIngredientes),
    Calorias is CantidadDeIngredientes * 15.

calorias(principal(Guarnicion, MinutosDeCoccion), Calorias):-
    caloriasGuarnicion(Guarnicion, CaloriasGuarnicion),
    Calorias is MinutosDeCoccion * 5 + CaloriasGuarnicion.

caloriasGuarnicion(pure, 20).
caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(ensalada, 0).

calorias(postre(Calorias), Calorias).


  

%7)

criticaPositiva(Critico, Restaurante):-
    inspeccionSatisfactoria(Restaurante),
    criterioSegunCritico(Critico, Restaurante).
  
  criterioSegunCritico(antonEgo, Restaurante):-
    forall(chef(Chef, Restaurante), cocinaBien(Chef, ratatouille)).
  
  criterioSegunCritico(christophe, Restaurante):-
    findall(Chef, chef(Chef, Restaurante), Chefs),
    length(Chefs, CantidadDeChefs),
    CantidadDeChefs > 3.
  
  criterioSegunCritico(cormillot, Restaurante):-
    forall(cocinaEn(_, Plato, Restaurante, _),  saludable(Plato)),
    forall(entradaEn(Entrada, Restaurante), tieneZanahoria(Entrada)).
  
  entradaEn(Entrada, Restaurante):-
    cocinaEn(_, Entrada, Restaurante, _),
    plato(Entrada, entrada(_)).
  
  tieneZanahoria(Entrada):-
    plato(Entrada, entrada(Ingredientes)),
    member(zanahoria, Ingredientes).
