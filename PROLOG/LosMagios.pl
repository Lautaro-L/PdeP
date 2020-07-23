persona(bart).
persona(larry).
persona(otto).
persona(marge).

persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(homero, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).


%Punto 1'

noEsMagio(Persona):-
    persona(Persona),
    not(esMagio(Persona)),
    not(aspiranteMagio(Persona)).

nombre(Persona):- 
    noEsMagio(Persona).

nombre(Persona):- persona(alMando(Persona, _)).
nombre(Persona):- persona(novato(Persona)).
nombre(Persona):- persona(elElegido(Persona)).





esMagio(Persona):-
    persona(alMando(Persona, _)).

esMagio(Persona):-
    persona(novato(Persona)).

esMagio(Persona):-
    persona(elElegido(Persona)).

aspiranteMagio(Persona):-
    hijo(Persona, Padre),
    esMagio(Padre).

aspiranteMagio(Persona):-
    salvo(Persona, Magio),
    esMagio(Magio).

%--------------- Fin punto 1

%--------------- Inicio punto 2

puedeDarOrdenes(Magio1, Magio2):-
    persona(alMando(Magio1, Nivel)),
    persona(alMando(Magio2, Nivel2)),
    Nivel > Nivel2.

puedeDarOrdenes(Magio1, Magio2):-
    persona(alMando(Magio1, _)),
    persona(novato(Magio2)).

puedeDarOrdenes(Magio1, Magio2):-
    persona(elElegido(Magio1)),
    esMagio(Magio2).

%--------------- Fin punto 2

%--------------- Inicio punto 3

sienteEnvidia(Persona, EnvidiaA):-
    aspiranteMagio(Persona),
    findall(Magio, esMagio(Magio), EnvidiaA).

sienteEnvidia(Persona, EnvidiaA):-
    persona(Persona),
    findall(Magio, aspiranteMagio(Magio), EnvidiaA).

sienteEnvidia(Persona, EnvidiaA):-
    persona(novato(Persona)),
    findall(Magio, persona(alMando(Magio, _)), EnvidiaA).

%--------------- Fin punto 3

sienteEnvidiaV2(Persona, Envidiados):-
    nombre(Persona),
    findall(Envidiado, envidia(Persona, Envidiado), Envidiados).

envidia(Persona, Envidiado):-
    aspiranteMagio(Persona),
    esMagio(Envidiado).

envidia(Persona, Envidiado):-
    noEsMagio(Persona),
    aspiranteMagio(Envidiado).

envidia(Persona, Envidiado):-
    persona(novato(Persona)),
    persona(alMando(Envidiado, _)).

%--------------- Inicio punto 4





%--------------- Fin punto 4

%--------------- Inicio punto 5

soloLoGoza(Persona, Beneficio):-
    gozaBeneficio(Persona, Beneficio),
    forall(gozaBeneficio(Magio, Beneficio), Magio == Persona).

%--------------- Fin punto 5

%--------------- Inicio punto 6

cuantosAprovechan(Beneficio, Cantidad):-
    gozaBeneficio(_, Beneficio),
    findall(Aprovechan, gozaBeneficio(Aprovechan, Beneficio), Lista),
    length(Lista, Cantidad).
    

tipoDeBeneficioMasAprovechado(Beneficio):-
    cuantosAprovechan(Beneficio, Cantidad),
    forall((gozaBeneficio(_, Beneficio2), Beneficio2 \= Beneficio), (cuantosAprovechan(Beneficio2, Cantidad2), Cantidad2 < Cantidad)).
