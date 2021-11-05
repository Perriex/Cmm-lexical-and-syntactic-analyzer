grammar Cmm;

/*Grammars*/
display:/*console.log*/;

size:/*size*/;

append:/*add*/;

conditional: /*if else*/;

loop: /*while ,do while*/;

variable: /*sth - remember : type a=1,b,c | list # type name | fptr : <type -> type> */;

list: /*sth*/ ;

fptr : /*sth*/ ;

setget: LSCOPE SET scope GET scope RSCOPE;

scope : LSCOPE NEWLINE (statement ((SC|NEWLINE) statement)*) NEWLINE RSCOPE NEWLINE | statement NEWLINE ;

statement: /*call func | assign | list.append() | type variable | return */ ;

comment: (LCOMMENT ~(RCOMMENT)* RCOMMENT)*; /*check*/

/*Tokens*/

IDENTIFIER: [a-zA-Z_][a-zA-Z_0-9]* ; /* [A-Za-z_0-9]+ */

KEYWORD:
        'struct' | 'main' | 'list' | /*  'int' | 'bool' |*/
        'void' | 'while' | 'do' | 'if' | 'else' |
        'return' |/* 'get' | 'set' |  'begin' | 'end' | */
        'display' | 'append' | 'size' |/* 'true' | 'false'| */
        'fptr'
       ;
BASETYPE : 'int' | 'bool';

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

DOT: '.';

COMMA: ',' ;

NEWLINE : '\n';

SC : ';' ;

RCOMMENT: '*/' ;

LCOMMENT: '/*';

OPERATORS: '+' | '-' | '*' | '/' | '-' ;

COMPERER: '==' | '>' | '<' ;

LOGICAL: '&' | '|' | '~';

ASSIGN: '=';

WHITESPACE: [ \t\r] -> skip;