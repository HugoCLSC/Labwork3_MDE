make_purchase:-
  write('Instrumento que deseja comprar:  '),
  read(Instrument_Name),

  (frame_exists(Instrument_Name),
    write('Quantidade a comprar: '),
    read(Quantity),
    get_value(Instrument_Name, preco, Price),

    TP is Quantity * Price,

    write('Pre�o total:  '), write(TP),nl,
    make_Order(Instrument_Name,Quantity)),!; 

  write('Actualmente n�o temos dispon�vel o produto em quest�o').
