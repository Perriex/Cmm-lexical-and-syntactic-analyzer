grammar Cmm;

value: INT | BOOL | IDENTIFIER;

unary: MINUS | COMPLIMENT;

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

comment: (LCOMMENT ~(RCOMMENT)* RCOMMENT)*; /*check*/

expression : LBRACE expression RBRACE
    | value
    | IDENTIFIER.IDENTIFIER
    | IDENTIFIER LBRACKET value RBRACKET
    | IDENTIFIER LBRACE expression RBRACE
    | unary expression
    | expression MULT expression
    | expression ADD expression
    | expression MINUS expression
    | expression COMP expression
    | expression EQUAL expression
    | expression AND expression
    | expression OR expression
    | expression COMMA expression
    ;

call :
    | expression
    | call COMMA call
    | IDENTIFIER LBRACE call RBRACE
    ;

statement : call | IDENTIFIER ASSIGN expression | RETURN expression;

/*Tokens*/


VOID : 'void';

MAIN : 'main';

RETURN: 'return';

STRUCT: 'struct';

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

NEWLINE : '\n'+;

SC : ';' ;

RCOMMENT: '*/' ;

LCOMMENT: '/*';

MINUS: '-';

COMPLIMENT: '~';

MULT: ('*' | '/');

ADD: '+';

COMP: ('<' | '>');

EQUAL: '==';

AND: '&';

OR: '|';

ASSIGN: '=';

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9]* ;

WHITESPACE: [ \t\r] -> skip;
