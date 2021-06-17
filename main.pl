:-ensure_loaded(golog2_32).
:-ensure_loaded(fabrica).
:-ensure_loaded(instrumentos).
:-ensure_loaded(relacoes).
:-ensure_loaded(menu).
:-ensure_loaded(pecas).
:-ensure_loaded(alarm).


cls :- write('\e[H\e[2J').
start:-
  cls,
  def_fabrica,
  def_instrumento,
  def_pecas,
  def_alarm,
  def_is_in_relation,
  def_is_a_relation,
  def_has_relation.






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
