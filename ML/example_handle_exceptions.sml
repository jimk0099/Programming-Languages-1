exception Nomatch;

fun member(a,[]) = raise Nomatch
  | member(a,b::y) = if a = b then b::y
                     else member(a,y);

fun member2(a, x) = member(a, x) handle Nomatch =>
                        (print("Empty list! "); []
                        );
