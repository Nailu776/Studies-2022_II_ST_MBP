(* Calculator file calc.ml *)

(* Open used libs *)
open Parser;;
open Lexer;;
open Sys;;

(* Welcome message *)
print_char ('\n');
print_string ("Hello! \n");;
print_string ("Do you want to calculate something? \n");;
print_string ("Let's start! \n");;
print_string ("Enter your wish for calculation after \"~~\" symbol. \n");;
print_string ("e.g. \n~~\t3 + 3 \n");;
print_string ("Result:\t6 \n");;
(* print_string ("Please separate operations and numbers with whitespaces. \n");; *)
print_string ("To terminate this program use Ctrl+C.\n\n");;

(* Looping flag *)
let looping = ref true;;

(* Lexer buffer *)
let lexbuf = Lexing.from_channel stdin;;

(* Print first prompt sign *)
print_string("~~\t");; 

(* Ctrl + C == leave the calc *)

(* Exception for ending calc *)
exception EndCalc;;

(* Function to handle sigint (CTRL+C) *)
let endCalc _ = raise EndCalc;;

(* Sigint handler = endCalc *)
signal sigint (Signal_handle endCalc);;

(* Main loop *)
while (!looping) do
    try
      (* Flush output *)
      flush stdout;
        (* result *)
        let result = 
            (* parse *)
            line 
              (* scanned lexer buffer *)
              token lexbuf in
          (* Print out the result *)
          print_string("Result:\t"); 
          print_float result; 
          (* Flush output with prompt sign *)
          print_string("\n~~\t"); 
          flush stdout;
    (* Exception handler *)
    with 
      (* Handle Ctrl+C *)
      | EndCalc -> 
              print_endline ("\n\tCtrl+C pressed. See you soon!");
              looping := false
      (* Handle end of file Ctrl+D *)
      | Lexer.Eof ->
              print_endline ("\n\tEnd of file. See you soon!");
              looping := false
      (* Unexpected token in lexer *)
      | UNEXPECTED_TOKEN ->
              print_endline ("Unexpected token error.\n")
      (* Built-int function not found *)
      | BuiltInFuncNotFound -> 
              print_endline ("Built-in function not found.\n")
      (* Don't stop loop after unexpected (yet) error *)
      | _ -> print_endline ("Something is not right.\n")
done;;

(* End of calc.ml file *)
