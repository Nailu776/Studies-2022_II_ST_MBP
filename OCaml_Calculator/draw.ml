(* File containing draw functions *)
let range = 101;;


let space_char:string = "8" 
let line_char:string = "*" 
let polynomial_value poly x = List.fold_right (fun a s -> x * s + a) poly 0;;


let match_head h row_val poly= 
    if row_val = polynomial_value poly h then
        [line_char]
    else
        [space_char]

let rec build_row row_val x_range result poly =
    match x_range with
        h::[] -> result @ (match_head h row_val poly)
        |h::t -> build_row row_val t (result @ (match_head h row_val poly)) poly

let rec build_canvas canv x_range y_range poly =
    match y_range with
        h::[] -> canv @ [(build_row h x_range [] poly)]
        |h::t -> build_canvas (canv @ [(build_row h x_range [] poly)]) x_range t  poly

let rec print_row row =
    match row with
        [] -> print_string "\n"
        |h::[] -> print_string h
        |h::t -> print_string h; print_row t
let rec print_canvas canv=
    match canv with
        (h:'a list)::([]:'a list list) -> print_row h
        |(h:'a list)::t -> print_row h; print_canvas t;;


let x_range = List.init range (fun x -> x - range/2);;
let y_range = List.init range (fun y -> -y + range/2);;

print_canvas (build_canvas [[]] x_range y_range [1;0]);;

