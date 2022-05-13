(* Lexer file also known in literature as scanner lexer.mll *)

{
  (* The type token is defined in file parser.mli *)
  open Parser        

  (* End of file exception *)
  exception Eof

  (* Unexpected token *)
  exception UNEXPECTED_TOKEN
} 

(* Digits 0 1 2 3 4 5 6 7 8 9 *)
let digit = ['0'-'9']
(* Float number *)
let float = digit+('.'digit)?
(* White spaces*)
let white = [' ' '\t']+
(* New line *)
let nl = ['\n']

(* Parsing token *)
rule token = parse
  | float as lxm { FLOAT(float_of_string lxm) }
  | '+'        { PLUS }
  | '-'        { MINUS } 
  | '*'        { MULT }
  | '/'        { DIV }
  | '('        { LBRACKET }
  | ')'        { RBRACKET } 
  | white      { token lexbuf }  
  | nl         { EOL }
  | eof        { raise Eof }
  | _          { raise UNEXPECTED_TOKEN }