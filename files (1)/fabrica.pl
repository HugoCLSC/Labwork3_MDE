:-ensure_loaded(mde_mainmenu).

def_fabrica:-

    new_frame(fabrica),
    new_slot(fabrica,nome),
    new_slot(fabrica,local),
    new_slot(fabrica,cap_max),
    new_slot(fabrica,total_stock).

settingsFactory:-

  cls,
  write('Insira o nome da fábrica '), read(FactoryName),
  new_value(fabrica,nome,FactoryName),

  write('Insira o local da fábrica '), read(FactoryLocal),
  new_value(fabrica,local,FactoryLocal),

  write('Insira a capacidade da fábrica '), read(FactoryCapacity),
  new_value(fabrica,cap_max,FactoryCapacity),
  new_value(fabrica,total_stock,0),
  pause,
  cls,
  menu_fabrica,
  !.

consultFactory:-

  cls,
  show_frame(fabrica),
  pause,
  %menu_fabrica,
  !.

newNameFactory:-

  cls,
  write('Novo nome da fábrica: '), read(NewNameFactory),
  new_value(fabrica,nome,NewNameFactory),
  pause,
  menu_fabrica,
  !.

newLocalFactory:-

  cls,
  write('Nova localização da fábrica: '), read(NewLocalFactory),
  new_value(fabrica,local,NewLocalFactory),
  pause,
  menu_fabrica,
  !.

newCapacityFactory:-

  cls,
  write('Nova capacidade de armazenamento: '), read(NewCapacityFactory),
  new_value(fabrica,cap_max,NewCapacityFactory),
  pause,
  menu_fabrica,
  !.

/*********************
* Definition of the demon on the slot 'total_produtos_stock'
**********************/
def_Stock_Control:-
  new_demon(fabrica,total_produtos_stock,control_Factory_Stock,if_write,before,side_effect).


/*******************
* Adds stock to the factory given a quanitity
********************/
add_Factory_Stock(Quantity):-
  get_value(fabrica, total_produtos_stock, S),
  S1 is Quantity + S,
  new_value(fabrica,total_produtos_stock,S1).

/*********************
*Decreases the stock of the factory by a given Quantity
**********************/
decrease_Factory_Stock(Quantity):-
  get_value(fabrica,total_produtos_stock,S),
  S1 is Quantity - S,
  new_value(fabrica,total_produtos_stock,S1).
