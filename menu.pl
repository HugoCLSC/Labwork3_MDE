menu_open :-
  %gerir produtos(Criar, visualizar, alterar e apagar produtos), gerir pecas (Criar, visualizar, alterar e apagar peças)
  repeat, nl, nl,
  writeln('1 - Gerir fabricas'),
  writeln('2 - Gerir produtos'),
  writeln('3 - Gerir pecas'),
  writeln('4 - Atribuir peças'),
  writeln('5 - Listar produtos'),
  writeln('6 - Listar produtos e suas características por ordem crescente'),
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

  (Opcao =:= '1'->
      menu_fabrica;
   Opcao =:= '2' ->
      menu_produto;
   Opcao =:= '3' ->
     menu_peca;
   Opcao =:= '4' ->
     listar_instrumento;
   Opcao =:= '5' ->
     list_alarms).







write_menu_fabrica:-
  writeln('1- Adiciona fabricas'),
  writeln('2- Apagar fabricas '),
  writeln('3- Listar fabricas'),
  writeln('4- Alterar nome'),
  writeln('5- Alterar cidade'),
  writeln('6- Alterar capacidade máxima de armazenamento de produtos'),
  writeln('7- Alterar número total de produtos em stock'),

  writeln('0- Back').

write_menu_peca:-
  writeln('1- Adiciona pecas'),
  writeln('2- Apagar pecas '),
  writeln('3- Listar pecas '),
  writeln('4- Alterar referencia'),
  writeln('5- Alterar cor'),
  writeln('5- Alterar quantidade'),

  writeln('0- Back').

write_menu_produto:-
  writeln('1- Adiciona prduto'),
  writeln('2- Apagar produto '),
  writeln('3- Listar produto '),
  writeln('4- Alterar nome '),
  writeln('5- Alterar Referencia '),
  writeln('6- Alterar data de fabrico '),
  writeln('7- Alterar preço '),
  writeln('8- Alterar quantidade '),
  writeln('9- Alterar peças '),

  writeln('0- Back').
