grammar Cmm;

/* Grammar */

start: struct* NEWLINE*  method* NEWLINE* MAIN {System.out.println("Main");} LBRACE RBRACE scope EOF;

unary: MINUS | COMPLIMENT;

type: BASETYPE | fptr | list | STRUCT IDENTIFIER;

conditional: matchIF | unmatchIF ;

matchIF : {System.out.println("Conditional : if");} IF  expression  (matchIF | scope) {System.out.println("Conditional : else");}  ELSE (matchIF | scope) ;

unmatchIF: {System.out.println("Conditional : if");} IF  expression  scope |
           {System.out.println("Conditional : if");} IF  expression  matchIF {System.out.println("Conditional : else");} ELSE unmatchIF;

loop: {System.out.println("Loop : while");} WHILE expression scope | {System.out.println("Loop : do…while");} DO scope WHILE expression;

declare: declare COMMA lvalue | type lvalue;

list: LIST HASHTAG type;

struct: STRUCT n=IDENTIFIER {System.out.println("StructDec : "+$n.getText());} LSCOPE NEWLINE (declare SC? NEWLINE | setget NEWLINE)+ RSCOPE NEWLINE ;

setget: type n=IDENTIFIER {System.out.println("VarDec : "+$n.getText());}  prototype LSCOPE NEWLINE
                          {System.out.println("Setter");} SET scope
                          {System.out.println("Getter");} GET scope RSCOPE;

scope : LSCOPE NEWLINE ( SC |NEWLINE |scope | conditional | loop)* NEWLINE RSCOPE NEWLINE? | statement  ;

expressionlist : expression
    | expressionlist COMMA expression;

methodname :{System.out.println("FunctionCall");} IDENTIFIER |
            {System.out.println("Built-in : display");} DISPLAY |
            {System.out.println("Size");} SIZE |
            {System.out.println("Append");}  APPEND;

methodcall: methodname LBRACE RBRACE
    | methodname LBRACE expressionlist RBRACE ;

lvalue : IDENTIFIER | methodcall | lvalue ASSIGN expression | lvalue DOT IDENTIFIER | lvalue LBRACKET expression RBRACKET;
rvalue : INT | BOOL | lvalue;

expression : LBRACE expression RBRACE
    | rvalue
    | methodcall
    | unary expression
    | expression n=MULT  expression {System.out.println("Operator : "+$n.getText());}
    | expression n=ADD expression {System.out.println("Operator : "+$n.getText());}
    | expression n=MINUS  expression {System.out.println("Operator : "+$n.getText());}
    | expression n=LCURLY expression {System.out.println("Operator : "+$n.getText());}
    | expression n=RCURLY  expression {System.out.println("Operator : "+$n.getText());}
    | expression n=EQUAL  expression {System.out.println("Operator : "+$n.getText());}
    | expression n=AND  expression {System.out.println("Operator : "+$n.getText());}
    | expression n=OR  expression {System.out.println("Operator : "+$n.getText());}
    ;


statementblocks: expression
     | {System.out.println("Return");} RETURN expression? (NEWLINE|SC)*
     | declare
     | conditional;

statement : (SC | NEWLINE)+ statement | statementblocks;

argument: type n=IDENTIFIER {System.out.println("ArgumentDec : "+$n.getText());}| argument COMMA argument;

prototype: LBRACE (argument|) RBRACE;

function: type n=IDENTIFIER {System.out.println("FunctionDec : "+$n.getText());} prototype scope;
action: VOID prototype scope;
method: function | action;

typelist:  (type | VOID ) |  (type | VOID ) COMMA typelist;

fptr : FPTR LCURLY typelist MINUS RCURLY (type | VOID ) RCURLY;

/*Tokens*/

WHILE : 'while' ;

DO: 'do' ;

IF : 'if' ;

ELSE : 'else' ;

VOID : 'void';

MAIN : 'main';

RETURN: 'return';

STRUCT: 'struct';

FPTR: 'fptr';

DISPLAY: 'display';

SIZE: 'size';

APPEND: 'append';

BASETYPE : 'int' | 'bool';

LIST: 'list';

HASHTAG: '#';

INT : [0-9]+;

BOOL: 'true' | 'false' ;

GET: 'get' ;

SET: 'set' ;

LSCOPE: 'begin' ;

RSCOPE: 'end' ;

LBRACKET: '[' ;

RBRACKET: ']' ;

LBRACE: '(' ;

RBRACE: ')' ;

LCURLY: '<' ;

RCURLY: '>' ;

DOT: '.';

COMMA: ',' ;

SC : ';' ;

MINUS: '-';

COMPLIMENT: '~';

MULT: ('*' | '/');

ADD: '+';

EQUAL: '==';

AND: '&';

OR: '|';

ASSIGN: '=';

IDENTIFIER: [a-zA-Z_][a-zA-Z_0-9]* ;

NEWLINE : '\n';

WHITESPACE: [ \n\t\r] -> skip;

COMMENT: '/*' .*? '*/' -> skip;
