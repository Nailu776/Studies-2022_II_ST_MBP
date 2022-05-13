(* Calculator file calc.ml *)

(* Open used libs *)
open Parser;;
open Lexer;;

(* Welcome message *)
print_string ("\nHello! \n
Do you want to calculate something? \nLet's start! \n
Enter your wish for calculation after \"~~\" symbol. \n
e.g. \n~~\t3 + 3 \nResult:\t6 \n\n\n");;

(* Looping flag *)
let looping = ref true;;

(* Lexer buffer *)
let lexbuf = Lexing.from_channel stdin;;

(* Print first prompt sign *)
print_string("~~\t");; 

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
          print_int result; 
          (* Flush output with prompt sign *)
          print_string("\n~~\t"); 
          flush stdout;
    (* Exception handler *)
    with 
      | Lexer.Eof ->
              print_endline ("End of file.");
              looping := false
      | UNEXPECTED_TOKEN ->
              print_endline ("Unexpected token error.\n")
      (* Don't stop loop while debuging after unexpected (yet) error *)
      | _ -> print_endline ("Something is not right.\n")
done;;