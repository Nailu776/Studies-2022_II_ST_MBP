# Makefile file

# calc output file
all:  parser lexer calc
	ocamlc -o calc lexer.cmo parser.cmo calc.cmo

# Generates parser.ml and parser.ml
# and compiles it
parser: parser.mly
	ocamlyacc parser.mly     
	ocamlc -c parser.mli parser.ml

# Generates lexer.ml and compiles it
lexer: lexer.mll
	ocamllex lexer.mll       
	ocamlc -c lexer.ml

# Compile main program
calc: calc.ml
	ocamlc -c calc.ml

# Clean project
clean:
	rm -f lexer.ml parser.ml parser.mli *.cmi *.cmo calc