%definição da fram instrumentos e tudfo o que tiver haver com esta frame.

/******************
* instrumento frame definition,
******************/
def_instrumento:-
  new_frame(instrumento),
  new_slot(instrumento,nome),
  new_slot(instrumento,ref),
  new_slot(instrumeto,data_fabrico),
  new_slot(instrumento,preco),
  new_slot(instrumento,pecas),
  new_slot(instrumento,quantidade).




%metodo que verifica se existem as peças necessárias para este instrumento.
get_name(N):-
  write('Introduza o Nome/Modelo do Instrumento (Ex:. gibsonA4): '),
  read(N).


/**********************
*Adds a new Instrument
***********************/

new_Instrument:-
  get_name(N),
  (not(frame_exists(N)),
   gen_Instrument(N),
   add_value(N,nome,N),
   write('Referência do Instrumento: '),
   read(Ref),
   add_value(N,ref,Ref),
   get_date(D),
   add_value(N,data_fabrico,D),
   write('Preço do Produto: '),
   read(Price),
   add_value(N,preco,Price),
   writeln('Quais são os materiais necessários? (Nome da peça e depois a quantidade. Escreva ok quando acabar): '),
   readListUntil(Pecas,'ok'),
   add_values(N,pecas,Pecas),

   get_value(N,quantidade,_));
  write('Instrumento j� existe!').

/**********************
*Creates the frame for that new instrument,
* -Also adds what relation this instrument has with the frame 'instrumento' (is_a),
* and the relation the instrument has with the frame 'fabrica' (is_in)
* -Adds demons related with the slot 'quantidade' and the slot 'pecas'.
***********************/
gen_Instrument(N):-
  new_frame(N),
  new_slot(N,is_in,fabrica),
  new_slot(N,is_a,instrumento),
  new_demon(N,quantidade,control_Instrument_Stock,if_write,after,alter_value),
  new_demon(N,pecas,set_Piece_Instrument_Relation,if_write,after,side_effect).
/***********************
* Delete a Instrument.
************************/
delete_Instrument:-
  write('Indique o Nome/Modelo do Instrumento(Ex:. gibsonA4):  '),
  read(InstrumentName),
  (frame_exists(InstrumentName),
    remove_all_demons(InstrumentName,_),
    delete_frame(InstrumentName),
  );
  write('Instrumento não existe!').

/***********************
*Alter Instrument.
************************
*Asks what Instrument we want to change,
*Then displays and asks what we want to change
************************/
alter_Instrument:-
  get_name(InstrumentName),
  alter_instrument_Menu,  %adicionar esta função que escreve o que podemos mudar no Instrumento
  read(Option),
  (frame_exists(InstrumentName),
    (Option =:= 1 ->
      write('Adicione a nova referência:  '),
      read(REF),
      new_value(InstrumentName,ref,REF);
    Option =:= 2 ->
      write('Novo preço:  '),
      read(NPrice),
      new_value(InstrumentName,preco,NPrice);
    Option =:= 3 ->
      get_values(InstrumentName,pecas,OList),
      reset_relation_Instrument_Piece(InstrumentName,OList), %Deletes all the relation between the instrument and the piece
      write('Nova lista de peças para o instrumento (colocar o nome e depois a quantidade, ok quando acabar):  '),
      readListUntil(NList,'ok'),
      new_values(InstrumentName,pecas,NList)
    ));
    write('Instrumento não existe!').

/***********************
* display_Instrument
************************
* Asks the name os the instrument we want to view.
* Displays all the information we have for that instrument.
************************/
display_Instrument:-
  get_name(Instrument_Name),

  (frame_exists(Instrument_Name),
    get_all_slots(Instrument_Name,LS),
    write(LS),
    /*
    write('Nome do Instrumento -> '),write(InstrumentName),nl,
    write('Referência do Instrumento -> '),write(Ref),nl,
    write('Preço do Instrumento -> '), write(Price),nl,
    write('Peças necessárias e quantidade ->  '),write(List),nl,
    write('Quantidade possível de produzir -> '),write(Q),
    */
  );
  write('Instrumento não existe!').



/***********************
*reset_relation_Instrument_Piece
************************
* -When the pieces we need to make an instrument is altered we also need to change
*  correct all the relation between the instrument and the pieces.
*  In this case we delete all the relations the pieces have with the instrument.
************************/
reset_relation_Instrument_Piece(Instrument_Name, [(Piece_Name,Piece_quantity)|T]):-
  (frame_exists(Piece_Name),
    delete_slot(Piece_Name,is_in,Instrument_Name),
    reset_relation_Instrument_Piece(Instrument_Name,T));
  write('Não hà relação'),
  reset_relation_Instrument_Piece(Instrument_Name,T).

/**************
*Demon
*Set relations between a intrument and the pieces it Needed_Pieces
***************/
set_Piece_Instrument_Relation(Instrument_Name,_,_,_,_,Peca,Quantity):-
  (frame_exists(Instrument_Name),
   get_values(Instrument_Name,pecas,LV),
   process_relation_list(Instrument_Name,LV));
   write('Erro!').


/***************
*Adds the relation Instrument/Piece in every piece
****************/
process_relation_list(Instrument_Name,[(Piece_Name,Piece_quantity)|T]):-
  (frame_exists(Piece_Name),
    new_slot(Piece_Name, in_in, InstrumentName),
    process_relation_list(Instrument_Name,T));
  write('Peça não existe'),
  process_relation_list(Instrument_Name,T).


/****************
*Consigo saber quantos instrumentos consigo produzir na realidade
****************/
get_Possible_stock(InstrumentName,Stock):-

    get_values(N,pecas,Pecas),

    findall((Name_Piece,Piece_Stock),get_list_piece_stock(Pecas,Name_Piece,Piece_Stock),AP),
    findall((Name_Piece1,Real_Stock),process_stock_piece_list(AP,Pecas,Name_Piece1,Real_Stock),AP1),
    minp(AP1,_,Stock).


  %add_value(InstrumentName,quantidade,Stock).

/****************
* Obtém a Lista com o nome e a quantidade de peças necessárias para um dado instromento.
****************/
get_list_piece_stock([(Piece_Name,_)|T],Piece_Name,Quantity):-
  get_piece_stock(Piece_Name,Quantity),
  get_list_piece_stock(T,Piece_Name,Quantity).
/*****************
 * Obtém a divisão entre o stock de cada peça existente com a quantidade de peças necessárias
 * para um certo instrumento.
 *****************/
process_stock_piece_list([(Piece_Name,Piece_Stock)|T],[(Piece_Name,Needed_Pieces)|T1], Piece_Name,Real_Stock ):-
  Real_Stock is div(Piece_Stock,Needed_Pieces),
  process_stock_piece_list(T,T1,Piece_Name, Real_Stock).

/*****************
*Get the minimum value
******************/
minp([(P,D)],P,D).
minp([(P,D)|R],P,D):-
    minp(R,_,M),
    D=<M.
minp([(_,D)|R],P,M):-
    minp(R,P,M),
    D>M.

/******************
*Makes an Order of instruments.
*******************
* Given a order in the quantity "Quantity"
* Checks if the factory can cover that quantity and then
* If it has enought of that instrument, the Instrument stock and the factory stock is reduced;
* If there are not enought Instruments for that order it gives a warning to the person making the purchase.
******************/
make_Order(Instrument_Name, Quantity):-
  get_value(Instrument_Name,quantidade, Val),

  ( Val>=Quantity ->
      NV is Val-Quantity,
      new_value(Instrumen_Name, quantidade, NV),
      decrease_Factory_Stock(Quantity),
      write('Compra feita com sucesso!');
    Val<Quantity ->
      write('Não é possivel assegurar a sua encomenta.').
  );!.
