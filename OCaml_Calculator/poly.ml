(* File containing draw functions *)
let range = 41;;
let x_scale = 1;;
let y_scale = 3;;

let space_char:string = "  " 
let line_char:string = "()" 
let x_axis_char:string = "=="
let y_axis_char:string = "||"
let polynomial_value poly = fun x -> (List.fold_left (fun s a -> x * s + a) 0 poly);;

let match_head h row_val poly= 
    if row_val = (polynomial_value poly (h/x_scale))/y_scale then
        [line_char]
    else if row_val = 0 then
        [x_axis_char]
    else
        if h = 0 then [y_axis_char]
        else [space_char]


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
        |h::[] -> print_string h; print_string "\n"
        |h::t -> print_string h; print_row t
let rec print_canvas canv=
    match canv with
        (h:'a list)::([]:'a list list) -> print_row h
        |(h:'a list)::t -> print_row h; print_canvas t;;





let x_range = List.init range (fun x -> x - range/2);;
let y_range = List.init range (fun y -> -y + range/2);;


let polydraw l = 
    print_canvas (build_canvas [[]] x_range y_range l);
    print_string x_axis_char;
    print_string " - ";
    print_int x_scale;
    print_string "\n";
    print_string "\n";
    print_string y_axis_char;
    print_string " - ";
    print_int y_scale;
    print_string "\n";
    1.;;

let polyval l v = float_of_int (polynomial_value l v);;
