grammar Cmm;

/* Grammar */

unary: MINUS | COMPLIMENT;

type: BASETYPE | fptr | list;

display:/*console.log*/;

size:/*size*/;

append:/*add*/;

conditional: /*if else*/;

loop: /*while ,do while*/;

declare: declare COMMA lvalue | type lvalue ;

list: LIST HASHTAG type;

struct: STRUCT IDENTIFIER LSCOPE NEWLINE structBody NEWLINE RSCOPE NEWLINE;

structBody: declare NEWLINE structBody | setget structBody | ;

setget: type prototype LSCOPE NEWLINE SET scope GET scope RSCOPE;

scope : LSCOPE scope RSCOPE NEWLINE | NEWLINE statement SC? NEWLINE | NEWLINE (statement (SC | NEWLINE)+)+ NEWLINE;

comment: (LCOMMENT ~(RCOMMENT)* RCOMMENT)*; /*check*/

expressionlist : expression
    | expressionlist COMMA expression;

methodcall: IDENTIFIER LBRACE RBRACE
    | IDENTIFIER LBRACE expressionlist RBRACE;

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

typelist: type | type COMMA typelist;

fptr : FPTR LCURLY typelist MINUS RCURLY type RCURLY;

/*Tokens*/

VOID : 'void';

MAIN : 'main';

RETURN: 'return';

STRUCT: 'struct';

FPTR: 'fptr';

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
