/* Parser file parser.mly */

%token <float> FLOAT        /* Float number         */
%token PLUS MINUS MULT DIV  /* + - * / operators    */
%token EOL                  /* End of line          */
%token LBRACKET RBRACKET    /* Symbols: '(' and ')' */


%left PLUS MINUS            /* Sequence of mathematical operations  */
%left MULT DIV              /* * an / before plus and minus         */
%nonassoc UMINUS            /* Unary minus                          */
/* Unary minus has greater priority than PLUS.
It means that (-x + y) is interpreted as ((-x) + y). */

%start line                 /* Entry point */
%type <float> line
%%

line:
    expr EOL                { $1 }      /* Parse line with expression + EndOfLine sign*/
;

expr:
  | FLOAT                   { $1 }        /* Expr == num it treats every num as float*/ 
  | LBRACKET expr RBRACKET  { $2 }        /* '('expr')'  */
  | expr PLUS expr          { $1 +. $3 }  /* num '+' num */
  | expr MINUS expr         { $1 -. $3 }  /* num '-' num */
  | expr MULT expr          { $1 *. $3 }  /* num '*' num */
  | expr DIV expr           { $1 /. $3 }  /* num '/' num */
  | MINUS expr %prec UMINUS { -. $2 }     /* '-'    expr */
;