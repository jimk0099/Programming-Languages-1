val lettersSmall = List.tabulate (26, fn i => chr (i + ord #"a"))
val lettersBig = List.tabulate (26, fn i => chr (i + ord #"A"))
val nums = List.tabulate (26, fn i => i)

val entropyLetters = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 
                        0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 
                        0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 
                        0.00978, 0.02360, 0.00150, 0.01974, 0.00074]

(* filepath -> string *)
fun readFile filePath =
  let val fd = TextIO.openIn filePath
    val s = TextIO.inputAll fd
    val _ = TextIO.closeIn fd
  in 
    s 
  end

fun let2int c =
  if Char.isLower c
    then (ord c - ord #"a")
  else if Char.isUpper c
    then (ord c - ord #"A" + 26)
  else ord c

fun int2let n = 
  if (n >= 0 andalso n <= 25)
    then chr (ord #"a" + n)
  else if (n >= 26 andalso n <= 51)
    then chr (ord #"A" + n - 26)
  else chr (n)

fun shift n c = if Char.isLower c
                  then int2let((let2int c + n) mod 26)
                else if Char.isUpper c
                  then int2let((let2int c + n) mod 26 + 26)  
                else c

(* assert (encode 1 "hal") = "ibm" *)
fun encode2 n = implode o map (shift n) o explode

fun encode n = map (shift n) o explode

fun decode n = encode (~n)

fun count_eq x [] = 0.0
  | count_eq x (xs::tail) =
    if (x = xs) then 1.0 + count_eq x tail
    else count_eq x tail

fun count [] = 0.0
  | count (xs::tail) =
    if Char.isAlpha xs then 1.0 + count tail
    else count tail

fun histo xs =
  let
    val n = count xs
    val allLower = map (fn x => Char.toLower x) xs
  in
    map (fn x => (count_eq x allLower / n)) lettersSmall
  end

fun entropy_list xs =
  let
    val log_table = map (fn x => Math.ln x) entropyLetters
  in
    ListPair.map (fn (x, y) => ~ (x * y)) (xs, log_table)
  end

fun entropy [] = 0.0
  | entropy (a::tail) = a + entropy tail

fun makeCode xs = map (fn x => encode x xs) nums

fun makeHist xs = map (fn x => histo x) xs

fun make3 xs = map (fn x => entropy_list x) xs

fun make4 xs = map (fn x => entropy x) xs

fun min ([] : real list) = raise Empty
  | min (x::[]) = x
  | min (x::k::rest) =
    if x < k
      then min (x::rest)
    else min (k::rest)

fun index [] = raise Empty
  | index (a::[]) = 0
  | index (a::b::rest) =
    let
      val m = min (a::b::rest)
    in
      if (not (a > m) andalso not (a < m))
        then 0
      else 1 + index(b::rest)
    end

fun decrypt path =
  let
    val msg = readFile path
    val codes_final = makeCode msg
    val hist_final = makeHist codes_final
    val make3_final = make3 hist_final
    val make4_final = make4 make3_final
    val index_final = index make4_final
  in
    print(encode2 index_final msg ^ "\n")
  end
  
    
