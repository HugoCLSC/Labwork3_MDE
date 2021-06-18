:-ensure_loaded(golog2_32).
:-ensure_loaded(fabrica).
:-ensure_loaded(instrumento).
:-ensure_loaded(pecas).
:-ensure_loaded(alarm).
:-ensure_loaded(relations).
:-ensure_loaded(vendedor).

cls :- write('\e[H\e[2J').

is_enter_key(13).
pause:-
    get_single_char(C),
    \+is_enter_key(C),
    !.

start:-
  cls,
  delete_kb,
  def_fabrica,
  def_instrumento,
  def_pecas,
  def_alarm,
  def_is_in_relation,
  def_is_a_relation,
  def_has_relation,
  menu_open.

menu_open:-

  cls,
  repeat,
  nl,
  write('-- Bem-vindo � APP da JALM�sica,Lda. --'),
  nl,nl,
  writeln('1 - Gerir f�brica'),
  writeln('2 - Gerir instrumentos'),
  writeln('3 - Gerir pecas'),
  writeln('4 - Atribuir pe�as'),
  writeln('5 - Listar produtos'),
  writeln('6 - Listar produtos e suas caracter�sticas por ordem crescente'),
  writeln('7 - Encomendar produto(s)'),
  writeln('8 - Visualizar mensagens de alarme'),
  writeln('9 - Requisito relevante'),
  writeln('0 - Sair'),

  write('Escolha uma op��o: '),read(Opcao),

  execute_optionMenuOpen(Opcao).

execute_optionMenuOpen(Opcao):-

  (Opcao =:= 1 -> menu_fabrica;
   Opcao =:= 2 -> menu_instrumentos;
   Opcao =:= 3 -> menu_peca;
   Opcao =:= 4 -> listar_instrumento;
   Opcao =:= 5 -> list_alarms;
   Opcao =:= 0 -> write('Obrigado pela visita � APP.'),!).

%menu referente �s opera��es realizadas nas f�bricas
menu_fabrica:-

  cls,
  nl,
  repeat,
  writeln('1- Configurar fabrica'),
  writeln('2- Consultar par�metros da f�brica'),
  writeln('3- Alterar nome'),
  writeln('4- Alterar localiza��o'),
  writeln('5- Alterar capacidade m�xima de armazenamento de produtos'),

  writeln('0- Back'),

  nl,
  write('Escolha uma op��o '), read(Opcao),
  nl,

  execute_OptionMenuFabrica(Opcao),!.

execute_OptionMenuFabrica(1):-settingsFactory,!.
execute_OptionMenuFabrica(2):-consultFactory,!.
execute_OptionMenuFabrica(3):-newNameFactory,!.
execute_OptionMenuFabrica(4):-newLocalFactory,!.
execute_OptionMenuFabrica(5):-newCapacityFactory,!.
execute_OptionMenuFabrica(0):-menu_open,!.


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
menu_instrumentos:-

  cls,
  writeln('1- Adicionar instrumento'),
  writeln('2- Apagar instrumento'),
  writeln('3- Listar instrumentos'),
  writeln('4- Alterar nome do instrumento'),
  writeln('5- Alterar refer�ncia'),
  writeln('6- Alterar data de fabrico '),
  writeln('7- Alterar pre�o'),
  writeln('8- Alterar quantidade'),
  writeln('9- Alterar pe�as'),

  writeln('0- Back'),

  nl,
  write('Escolha uma op��o '), read(Opcao),
  nl,

  execute_OptionMenuInstrumentos(Opcao).

%CRIAR NOVO INSTRUMENTO
execute_OptionMenuInstrumentos(1):-
   new_Instrument,
   !.

execute_OptionMenuInstrumentos(2):-
  menu_open,!.

%%%%%%%%%%%%%%%FUN��ES AUXILIARES %%%%%%%%%%%%%%%%%%
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
