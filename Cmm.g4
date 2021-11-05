grammar Cmm;

/* Grammar */

unary: MINUS | COMPLIMENT;

type: BASETYPE;

display:/*console.log*/;

size:/*size*/;

append:/*add*/;

conditional: /*if else*/;

loop: /*while ,do while*/;

declare: declare COMMA name | type name ;

name : IDENTIFIER (ASSIGN expression)? ; /*sth - remember : type a=1,b,c | list # type name | fptr : <type -> type> */

list:  list COMMA name | LIST HASHTAG type name ;

fptr : /*sth*/ ;

setget: LSCOPE SET scope GET scope RSCOPE;

scope : LSCOPE NEWLINE statement ((SC|NEWLINE) statement)* NEWLINE RSCOPE NEWLINE | NEWLINE statement NEWLINE;

comment: (LCOMMENT ~(RCOMMENT)* RCOMMENT)*; /*check*/

commaExpression : expression
    | commaExpression COMMA expression;

methodcall: IDENTIFIER LBRACE RBRACE
    | IDENTIFIER LBRACE commaExpression RBRACE;

lvalue : IDENTIFIER | lvalue ASSIGN expression;
rvalue : INT | BOOL | lvalue;

expression : LBRACE expression RBRACE
    | rvalue
    | IDENTIFIER DOT IDENTIFIER
    | IDENTIFIER LBRACKET rvalue RBRACKET
    | methodcall
    | unary expression
    | expression MULT expression
    | expression ADD expression
    | expression MINUS expression
    | expression COMP expression
    | expression EQUAL expression
    | expression AND expression
    | expression OR expression
    ;

statement : expression | lvalue ASSIGN expression | RETURN expression;

argument: type IDENTIFIER | argument COMMA argument;

prototype: IDENTIFIER LBRACE (argument|) RBRACE;

function: type prototype scope;
action: VOID prototype scope;
method: function | action;
/*Tokens*/

VOID : 'void';

MAIN : 'main';

RETURN: 'return';

STRUCT: 'struct';

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
