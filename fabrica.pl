
def_fabrica:-
    new_frame(fabrica),
    new_slot(fabrica,nome),
    new_slot(fabrica,cidade),
    new_slot(fabrica,cap_max),
    new_slot(fabrica,total_produtos_stock).


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
