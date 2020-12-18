precio(remera, estampado(floreado, [rojo, verde, blanco]), 500).
precio(remera, estampado(rayado, [verde, negro, rojo]), 600).
precio(buzo, liso(azul), 1200).
precio(vestido, liso(negro), 3000).
precio(saquito, liso(blanco), 1500).

paleta(sobria, negro).	
paleta(sobria, azul).  	
paleta(sobria, blanco).        
paleta(sobria, gris).
paleta(alegre, verde).	
paleta(alegre, blanco).  
paleta(alegre, amarillo).
paleta(furiosa, rojo).  
paleta(furiosa, violeta).  
paleta(furiosa, fucsia).

prenda(prenda(Prenda, Tela)):- precio(Prenda, Tela).

coloresCombinables(UnColor, OtroColor):-
    esColor(UnColor),
    esColor(OtroColor),
    UnColor \= OtroColor,
    cumpleCondicion(UnColor, OtroColor).

cumpleCondicion(UnColor, OtroColor):-
    pertenecenALaMismaPaleta(UnColor, OtroColor).

cumpleCondicion(UnColor, OtroColor):-
    unoEsNegro(UnColor, OtroColor).

unoEsNegro(negro, UnColor).
unoEsNegro(UnColor, negro).

pertenecenALaMismaPaleta(UnColor, OtroColor):-
    paleta(Paleta, UnColor),
    paleta(Paleta, OtroColor).

esColor(Color):-
    paleta(_, Color).

%%%%%%%%%%%   2


colorinche(prenda(Prenda, Tipo)):-
    prenda(prenda(Prenda, Tipo)),
    coloresColorinches(Tipo).

coloresColorinches(estampado(_, Colores)):-
    member(Color, Colores),
    forall((member(OtroColor, Colores), OtroColor \= Color ), not(pertenecenALaMismaPaleta(Color, OtroColor))).


%%%%%%%%%% 3


colorDeModa(Color):-
    forall(prenda(prenda(Prenda, estampado(_, Colores))), member(Color, Colores)).

%%%%%%%%%% 4


combinan(prenda(UnaPrenda, UnTipo), prenda(OtraPrenda, OtroTipo)):-
    prenda(prenda(UnaPrenda, UnTipo)),
    prenda(prenda(OtraPrenda, OtroTipo)),
    prendasConCondicion(UnTipo, OtroTipo).



prendasConCondicion(liso(Color), liso(OtroColor)):-
    coloresCombinables(UnColor, OtroColor).

prendasConCondicion(liso(Color), estampado(_, Colores)):-
    combinaConAlguno(Color, Colores).

prendasConCondicion(estampado(_, Colores), liso(Color)):-
    combinaConAlguno(Color, Colores).


combinaConAlguno(Color, Colores):-
    member(UnColor, Colores),
    coloresCombinables(UnColor, Color).


%%%%%%%%%% 5


precioMaxiomo(Prenda, Precio):-
    precio(Prenda, _, _),
    findall(Precios, (precio(Prenda, _, Precios)), Lista),
    max_list(Lista, Precio).

%%%%%%%%% 6 



alMenos2(Prendas):-
    length(Prendas, Longitud),
    Longitud >= 2.



conjuntoValido(Prendas):-
    alMenos2(Prendas),
    todasCumplen(Prendas).

todasCumplen([prenda(UnaPrenda, UnTipo) | Prendas]):-
    forall( member(prenda(OtraPrenda, OtroTipo), Prendas), combinan(prenda(UnaPrenda, UnTipo), prenda(OtraPrenda, OtroTipo))),
    todasCumplen(Prendas).

todasCumplen([Prenda]).
todasCumplen([]).

