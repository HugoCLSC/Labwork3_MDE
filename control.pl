/*********************
* Control Instrument Stock
**********************
* 1º-If the Quantity for a product is below 5 we need to make the factory produce new Instruments.
* 2º-If it's above 5 we cool.
**********************/
control_Instrument_Stock(Frame,Nome,Ref,Data_Fab,Preco,Pecas,Quantidade):-
  (Quantidade <= 5 ->
    produce_Instrument(Nome),
    get_date(D),
    genmsg('Instrumento em pouca quantidade, fábrica a produzir',Quantidade,D);
    write('Produzido com sucesso!');
   Quantidade >5 -> !.
  );

/**********************
* Mechanism to produce an instrument.
***********************
* 1º-Checks how many Instruments we can produce in a factory and displays that number.
* 2º-Asks how many we want to produce.
* 3º-Checks if it's possible to cover that request.
* 4º-Makes the necessery steps to make that product
***********************/

produce_Instrument(Nome):-
  get_Possible_stock(Nome,Stock),
  Stock =:= 0,
  (write('Possível produzir '),write(Stock),write(Nome),nl,
  write('Quanto deseja produzir?  '),
  read(Produce),

  (Produce <= Stock ->
    get_values(Nome,pecas,Piece),
    process_needed_Pieces(Piece,Produce),
    get_date(NDate),
    new_value(Nome,data_fabrico, NDate),
    get_value(fabrica,total_produtos_stock, TS),
    NS is TS + Produce,
    new_value(fabrica,total_produtos_stock,NS),
    get_value(Nome,quantidade, Q),
    Q1 is Q+Produce,
    new_value(Nome,quantidade,Q1);
    Produce >Stock -> write('Não é possivel produzir!');
    Produce =:= 0 -> write('Nada Produzido.')
    );
  );
  write('Não é possivel produzir nada').
/******************
*Updates the stock for each piece.
*******************/
process_needed_Pieces([(Piece_Name,Piece_Quantity)|T], Produce):-
  Needed_Quantity is Produce * Piece_Quantity,
  decrease_Stock(Piece_Name,Needed_Quantity),
  process_needed_Pieces(T, Produce).


/****************
*Mechanism to control the Stock limit on the factory.
*****************
* 1º-Emmit an alarm
****************/
control_Factory_Stock(F,Nome,_,Cap,Actual_Stock):-
  Difer is Cap - Actual_Stock,
  get_date(D),
  genmsg('A chegar ao limite de capacidade da fábrica', Difer, D).
