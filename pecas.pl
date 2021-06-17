def_pecas:-
    new_frame(pecas),
    new_slot(pecas,nome),
    new_slot(pecas,referencias),
    new_slot(pecas,quantidade).



gen_piece:-
  write('Nome da peça:  '),
  read(PieceName),

  (not(frame_exists(PieceName)),

  new_frame(PieceName),
  new_slot(PieceName,is_in,fabrica),
  new_slot(PieceName,is_a,pecas),
  add_value(PieceName,nome,PieceName),

  write('Referência:  '),
  read(Ref),
  add_value(PieceName,referencias, Ref),

  write('Stock: '),
  read(Stock),
  add_value(PieceName,quantidade,Stock));

  write('Peça já existente!').


get_piece_stock(NomePeca,N):-
  get_value(NomePeca,quantidade,N).


alter_piece(Option):-
  write('Nome da peça:  '),
  read(N),

  (frame_exists(N),

      write('Nova referência:  '),
      read(Ref),
      new_value(N,referencias,ReF),
  );
  write('Não existe esta peças!').


delete_piece:-
  write('Nome da peça:  '),
  read(N),

  (frame_exists(N),
    delete_slot(N),
  );
  write('Peça não existe!').

decrease_Stock(Nome, Change):-
  (frame_exists(Nome),
   get_value(Nome,quatidade,Q),
   Q1 is Q-Change,
   new_value(Nome,quantidade,Q1)
  );
  write('Não existe a peça!').

increase_Stock(Nome,Change):-
  (frame_exists(Nome),
   get_value(Nome,quatidade,Q),
   Q1 is Q+Change,
   new_value(Nome,quantidade,Q1)
  );
  write('Não existe a peça!').
