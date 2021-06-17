:-ensure_loaded(golog2_32).


%***********Definicoes**********
definition_fabrica:-
    new_frame(fabrica),
    new_slot(fabrica,nome),
    new_slot(fabrica,cidade),
    new_slot(fabrica,cap_max),
    new_slot(fabrica,total_produtos_stock).


def_instrumento:-
    new_frame(instrumento),
    new_slot(instrumento,nome),
    new_slot(instrumento,ref),
    new_slot(instrumento,data_fabrico),
    new_slot(instrumento,preco),
    new_slot(instrumento,pecas),
    new_slot(instrumento,quantidade).

def_pecas:-
    new_frame(pecas),
    new_slot(pecas,nome),
    new_slot(pecas,quantidade).

def_alarm:-
    new_frame(alarm),
    new_slot(alarm, notification),
    new_slot(alarm, value),
    new_slot(alarm, date),
    new_slot(alarm, count,0).

def_produces_of_relation:-
    new_relation(produces, intransitive , none, nil).

def_its_a_relation:-
    new_relation(its_a, transitive , all, nil).

def_has_relation:-
    new_relation(has, intransitive , none, nil).


% ***********Menus************

start:-
    menu_open.

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
    executa_opening(Opcao),
    Opcao =='0', !.

executa_opening(Opcao):-
    Opcao == '1', menu_fabrica;
    Opcao == '2', menu_produto;
    Opcao == '3', menu_peca;
    %Opcao == '4', menu_pecas;
    Opcao == '5', listar_instrumento;
    %Opcao == '6', menu_pecas;
    %Opcao == '7', menu_pecas;
    Opcao == '8', list_alarms;
    %Opcao == '9', menu_pecas;

    Opcao == '0'.

write_menu_fabrica:-
    writeln('1- Adiciona fabricas'),
    writeln('2- Apagar fabricas '),
    writeln('3- Listar fabricas'),
    writeln('4- Alterar nome'),
    writeln('5- Alterar cidade'),
    writeln('6- Alterar capacidade máxima de armazenamento de produtos'),
    writeln('7- Alterar número total de produtos em stock'),

    writeln('0- Back').

menu_fabrica:-
    repeat,
    nl,
    write_menu_fabrica,
    nl,
    read(Option),
    run_option(Option),
    Option == '0', !.

write_menu_peca:-
    writeln('1- Adiciona pecas'),
    writeln('2- Apagar pecas '),
    writeln('3- Listar pecas '),
    writeln('4- Alterar referencia'),
    writeln('5- Alterar cor'),
    writeln('5- Alterar quantidade'),

    writeln('0- Back').


menu_peca :-
    repeat,
    nl,
    write_menu_peca,
    nl,
    read(Option),
    run_option1(Option),
    Option == '0', !.


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


menu_produto:-
    repeat,
    nl,
    write_menu_produto,
    nl,
    read(Option),
    run_option2(Option),
    Option == '0', !.


run_option(Option):-
    Option == '1',
    write('Nome da fabrica: '),
    read(N),
    write('Cidade: '),
    read(C),
    write('Capacidade máxima de armazenamento de produtos '),
    read(Cap),
    write('Número total de produtos em stock'),
    read(S),
    cria_fabrica(N,C,Cap,S);

    Option == '2',
    write('Introduza o nome da fabrica a apagar: '),
    read(Nome),
    apagar_fabrica(Nome);

    Option == '3',
    listar_fabrica;

    Option == '4',

    write('Qual é o nome da fabrica que deseja alterar parametros ?'),
    read(N),

    write('Qual é o novo nome da fabrica ?'),
    read(Fnome),
    Aux = 'nome',
    alter_fabrica(N,Aux,Fnome);

    Option == '5',

    write('Qual é o nome da fabrica que deseja alterar parametros ?'),
    read(N),

    write('Quala nova cidade da fabrica ?'),
    read(Fcidade),
    Aux = 'cidade',
    alter_fabrica(N, Aux,Fcidade);

    Option == '6',

    write('Qual é o nome da fabrica que deseja alterar parametros ?'),
    read(N),

    write('Qual a nova capacidade maxima da fabrica ?'),
    read(Fcapacidade),
    Aux = 'capacidade',
    alter_fabrica(N, Aux,Fcapacidade);

    Option == '7',

    write('Qual é o nome da fabrica que deseja alterar parametros ?'),
    read(N),

    write('Qual é novo stock da fabrica ?'),
    read(Fstock),
    Aux = 'stock',
    alter_fabrica(N, Aux,Fstock).


run_option1(Option):-
    Option == '1',
    write('Nome do instrumento : '),
    read(N),
    write('Referencia do instrumento: '),
    read(R),
    write('Data em que o instrumento foi fabricado: '),
    read(D),
    write('Preco do instrumento: '),
    read(P),
    write('Quantidade de instrumentos: '),
    read(Qt),
    write('Peças que o instrumento precisa: '),
    read(PE),
    cria_instrumento(N,R,D,P,PE,Qt);

    Option == '2',
    write('Introduza a referencia do intrumento a apagar: '),
    read(R),
    apagar_instrumento(R),

    Option == '3',
    listar_instrumento.


run_option2(Option):-
    Option == '1',
    write('Nome da peca: '),
    read(N),
    write('Quantidade da peca : '),
    read(Qt),
    cria_peca(N,Qt);

    Option == '2',
    write('Introduza a peca a apagar: '),
    read(P),
    apagar_peca(P),

    Option == '3',
    listar_peca.


%********* criar *************

cria_fabrica(Nome,Cidade,Capacidade,Stock):-
    new_value(fabrica,nome,Nome),
    new_value(fabrica,cidade,Cidade),
    new_value(fabrica,cap_max, Capacidade),
    new_value(fabrica,total_produtos_stock, Stock).

cria_instrumento(Nome,Ref,Data_fab,Preco,Pecas,Quantidade):-
    new_slot(Ref, is_a, instrumento),
    new_value(fabrica,nome,Nome),
    new_value(instrumento,ref, Ref),
    new_value(instrumento,data_fabrico, Data_fab),
    new_value(instrumento,preco, Preco),
    new_value(instrumento,pecas, Pecas),
    new_value(instrumento,quantidade, Quantidade).

cria_peca(Nome,Quantidade):-
    new_slot(Nome, is_part_off, instrumento),
    new_value(pecas,nome,Nome),
    new_value(pecas,quantidade, Quantidade).

%************APAGAR **********

apagar_instrumento(Referencia):-
 frame_exists(Referencia),
 delete_frame(Referencia),
 write('Instrumento removido com sucesso!'),nl,!;
 write('Esse instrumento não consta na nossa fabrica'),!.

apagar_peca(Nome):-
 frame_exists(Nome),
 delete_frame(Nome),
 write('Peca removida com sucesso!'),nl,!;
 write('Essa peca não consta na nossa fabrica'),!.

apagar_fabrica(NomeF):-
 frame_exists(NomeF),
 delete_frame(NomeF),
 write('Fabrica removida com sucesso!'),nl,!;
 write('Essa fabrica não existe'),!.

% ***********listar***********

listar_fabrica:-
 nl,
 forall((frame_(Frame),get_value(Frame,instance_of,Io),Io=fabrica),show_frame(Frame)).

listar_instrumento:-
 nl,
 forall((frame_(Frame),get_value(Frame,its_a,Io),Io=instrumento),show_frame(Frame)).

listar_peca:-
 nl,
 forall((frame_(Frame),get_value(Frame,has,Io),Io=pecas),show_frame(Frame)).

list_alarms:-
 nl,
 forall((frame_(Frame),get_value(Frame,its_a,Io),Io=alarms),show_frame(Frame)).


% ***********alterar***********

alter_fabrica(Nome, Auxiliar,Param):-
(Auxiliar = 'nome' ->

    frame_exists(Nome),
    new_value(Nome,nome, Param),
    write('Nome alterado.'),nl,!;
    write('Fabrica não existe.'),nl,

 Auxiliar = 'cidade' -> write('Novo local:'),

    frame_exists(Nome),
    new_value(Nome,cidade, Param),
    write('Cidade alterada.'),nl,!;
    write('Fabrica não existe.'),nl,

 Auxiliar = 'capacidade' ->  write('Novo nome:'),

    frame_exists(Nome),
    new_value(Nome,cap_max, Param),
    write('Capacidade alterada.'),nl,!;
    write('Fabrica não existe.'),nl,

 Auxiliar = 'stock' ->  write('Novo nome:'),
    frame_exists(Nome),
    new_value(Nome,total_produtos_stock, Param),
    write('stock alterado.'),nl,!;
    write('Fabrica não existe.'),nl,

    write('Erro!-Parâmetro inexistente.'));

 !.
