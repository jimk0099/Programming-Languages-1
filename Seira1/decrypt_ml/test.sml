val med = []

val entropyList = []

val entropyLetters = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 
                        0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 
                        0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 
                        0.00978, 0.02360, 0.00150, 0.01974, 0.00074]

val lettersSmall = List.tabulate (26, fn i => chr (i + ord #"a"))
val lettersBig = List.tabulate (26, fn i => chr (i + ord #"A"))

fun shift num [] = []
  | shift num (a::tail) = 
    if num = 1 then tail @ [a]
    else shift (num-1) (tail @ [a])


fun read file =
  let
    val inStream = TextIO.openIn file
  in
    TextIO.inputAll inStream
    (*print("inStream")*)
  end 

type filepath = string

(* filepath -> string *)
fun readFile filePath =
    let val fd = TextIO.openIn filePath
        val s = TextIO.inputAll fd
        val _ = TextIO.closeIn fd
    in 
      s 
    end

(* string -> string list *)
fun split s =
  String.tokens Char.isSpace s


fun explode s =
  String.explode s 


fun convert [] = [] 
  | convert (a::tail) =
    if Char.isAlpha a
      then Char.ord(a)::convert tail 
    else 0::convert tail


fun convertLetter [] = []
  | convertLetter (a::tail) =
    Char.ord a::convertLetter tail

fun convertInt [] = []
  | convertInt (a::tail) =
    Char.chr a::convertInt tail

fun getLetters [] = []
  | getLetters (a::tail) =
    if Char.isAlpha a
      then a::getLetters tail
    else getLetters tail

fun change num list = map (fn x => x + num) list

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
    then chr (ord #"A" + n)
  else chr (n)


 
(* fun change num [] = []
  | change num (a::tail) =
  if (a >= 97 andalso a <= 122)
    then (fn a => a+num)
    (*     then val x1 = (a + num) 
      if (x1 <= 122)
        then change num tail
      else val x2 = x1 - 26 *)
  else change num tail *)





(* fun getAlpha newList [] = []
  | getAlpha newList (a::tail) =
    if Char.isAlpha a
      then a::getAlpha newList tail
    else getAlpha newList tail *)

(* fun copyTextFile (infile: string, outfile: string) = 
  let
    val ins = TextIO.openIn infile
    val outs = TextIO.openOut outfile
    fun helper (copt: char option) =
      case copt of
        NONE => (TextIO.closeIn ins; TextIO.closeOut outs)
        | SOME(c) => (TextIO.output1(outs,c); helper(TextIO.input1 ins))
  in
    helper(TextIO.input1 ins)
  end *)


