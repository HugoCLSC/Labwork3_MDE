def_is_in_relation:-
    new_relation(is_in, transitive , none, has).

def_is_a_relation:-
    new_relation(is_a, transitive , all, nil).

def_has_relation:-
    new_relation(has, intransitive , none, is_in).
