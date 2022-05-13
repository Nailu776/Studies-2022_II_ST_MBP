/* Parser file parser.mly */

%token <int> INT            /* Integer number */
%token PLUS MINUS           /* Plus Minus signs */
%token EOL                  /* End of line */
%left PLUS MINUS            /* Sequence of mathematical operations */

%start line                 /* Entry point */
%type <int> line
%%

line:
    expr EOL                { $1 }      /* Parse line with expression + EndOfLine sign*/
;

expr:
  |  INT                    { $1 }      /* Expr == num */
  | expr PLUS expr          { $1 + $3 } /* num oper num */
  | expr MINUS expr         { $1 - $3 } /* num oper num */
;