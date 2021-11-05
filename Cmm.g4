grammar Cmm;

/* Grammar */
start: struct* method* VOID MAIN LBRACE RBRACE scope EOF;

unary: MINUS | COMPLIMENT;

type: BASETYPE | fptr | list | STRUCT IDENTIFIER;

conditional: /*if else*/;

loop: /*while ,do while*/;

declare: declare COMMA lvalue | type lvalue ;

list: LIST HASHTAG type;

struct: STRUCT IDENTIFIER LSCOPE NEWLINE (declare SC? NEWLINE | setget NEWLINE)+ RSCOPE NEWLINE;

setget: type prototype LSCOPE NEWLINE SET scope GET scope RSCOPE;

scope : LSCOPE (scope | statement SC* | NEWLINE)* RSCOPE NEWLINE?;

expressionlist : expression
    | expressionlist COMMA expression;

methodname : IDENTIFIER | DISPLAY | SIZE | APPEND;

methodcall: methodname LBRACE RBRACE
    | methodname LBRACE expressionlist RBRACE;

lvalue : IDENTIFIER | lvalue ASSIGN expression;
rvalue : INT | BOOL | lvalue;

expression : LBRACE expression RBRACE
    | rvalue
    | IDENTIFIER DOT IDENTIFIER
    | IDENTIFIER LBRACKET expression RBRACKET
    | methodcall
    | unary expression
    | expression MULT expression
    | expression ADD expression
    | expression MINUS expression
    | expression LCURLY expression
    | expression RCURLY expression
    | expression EQUAL expression
    | expression AND expression
    | expression OR expression
    ;

statement : expression | lvalue ASSIGN expression | RETURN expression | declare;

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

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9]* ;

NEWLINE : '\n'+;

WHITESPACE: [ \t\r] -> skip;

COMMENT: '/*' .*? '*/' -> skip;
