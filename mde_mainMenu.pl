:-ensure_loaded(golog2_32).
:-ensure_loaded(fabrica).
:-ensure_loaded(instrumentos).
:-ensure_loaded(pecas).
:-ensure_loaded(alarm).
:-ensure_loaded(relacoes).
:-ensure_loaded(vendedor).
:-ensure_loaded(control).

cls :- write('\e[H\e[2J').

start:-
  %delete_kb, Caso precise de apagar todas as frames que existem.
  def_fabrica,
  def_instrumento,
  def_pecas,
  def_alarm,
  def_Stock_Control,
  def_is_in_relation,
  def_is_a_relation,
  def_has_relation.

menu_open :-
  %gerir produtos(Criar, visualizar, alterar e apagar produtos), gerir pecas (Criar, visualizar, alterar e apagar pe�as)
  repeat, nl, nl,
  writeln('1 - Gerir fabricas'),
  writeln('2 - Gerir produtos'),
  writeln('3 - Gerir pecas'),
  writeln('4 - Atribuir pe�as'),
  writeln('5 - Listar produtos'),
  writeln('6 - Listar produtos e suas caracter�sticas por ordem crescente'),
  writeln('7 - Encomendar produto(s)'),
  writeln('8 - Visualizar mensagens de alarme'),
  writeln('9 - Requisito relevante'),
  writeln('0 - Sair'),
  nl,
  read(Opcao),
  nl,

  execute_option(Opcao),
  Opcao =='0', !.

execute_option(Opcao):-

  (Opcao =:= 1-> menu_fabrica;
   Opcao =:= 2 -> menu_produto;
   Opcao =:= 3 -> menu_peca;
   Opcao =:= 4 -> listar_instrumento;
   Opcao =:= 5 -> list_alarms).

%menu referente �s opera��es realizadas nas f�bricas
menu_fabrica:-
  writeln('1- Adiciona fabricas'),
  writeln('2- Apagar fabricas '),
  writeln('3- Listar fabricas'),
  writeln('4- Alterar nome'),
  writeln('5- Alterar cidade'),
  writeln('6- Alterar capacidade m�xima de armazenamento de produtos'),
  writeln('7- Alterar n�mero total de produtos em stock'),

  writeln('0- Back').

%menu referente �s opera��es realizadas nas pe�as
menu_peca:-
  writeln('1- Adiciona pecas'),
  writeln('2- Apagar pecas '),
  writeln('3- Listar pecas '),
  writeln('4- Alterar referencia'),
  writeln('5- Alterar cor'),
  writeln('5- Alterar quantidade'),

  writeln('0- Back').

%menu referente �s opera��es realizadas nos produtos
menu_produto:-
  writeln('1- Adicionar produto'),
  writeln('2- Apagar produto '),
  writeln('3- Listar produto '),
  writeln('4- Alterar nome '),
  writeln('5- Alterar Referencia '),
  writeln('6- Alterar data de fabrico '),
  writeln('7- Alterar pre�o '),
  writeln('8- Alterar quantidade '),
  writeln('9- Alterar pe�as '),

  writeln('0- Back').


%Method that gets the date we are currently on.
%date(year,month,day,hour,minute,seconds,offset relative to ITC in seconds, Local timezone, true if daylight saving time applies to the current time)
get_date(D):-
    get_time(T),
    stamp_date_time(T,D,'UTC').



readListUntil(List,End):-
    (readElement((E,N),End)-> List=[(E,N)|L1],
        readListUntil(L1,End);
        List=[]).

readElement((E,N), End):-
    read(E),
    dif(E,End),
    read(N).


display_values_from_list([H|T]):-

  write(H),nl,
  display_values_from_list(T).
