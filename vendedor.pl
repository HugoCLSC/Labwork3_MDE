make_purchase:-
  write('Instrumento que deseja comprar:  '),
  read(Instrument_Name),

  (frame_exists(Instrument_Name),
    write('Quantidade a comprar: ')
    read(Quantity),
    get_value(Instrument_Name, preco, Price),

    TP is Quantity * Price,

    write('Preço total:  '), write(TP),nl

    make_Order(Instrumen_Name,Quantity),
  );
  write('Actualmente não temos disponível o produto em questão').
