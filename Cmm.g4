grammar Cmm;

/* Grammr */
start: (NEWLINE? struct NEWLINE)*  (NEWLINE? function NEWLINE)* NEWLINE? MAIN {System.out.println("Main");} LBRACE RBRACE scope NEWLINE? EOF?;

type: BASETYPE | fptr | list | STRUCT IDENTIFIER | VOID;

conditional: NEWLINE (unmatchIF | matchIF);

matchIF : simpleScope | {System.out.println("Conditional : if");} IF  expression matchIF {System.out.println("Conditional : else");} NEWLINE ELSE matchIF;

unmatchIF: {System.out.println("Conditional : if");} IF expression conditional |
           {System.out.println("Conditional : if");} IF expression matchIF {System.out.println("Conditional : else");} NEWLINE ELSE unmatchIF;

loop: {System.out.println("Loop : while");} WHILE expression scope | {System.out.println("Loop : do...while");} DO scope NEWLINE WHILE expression;

declare: n=IDENTIFIER (ASSIGN assignExpression)? {System.out.println("VarDec : "+$n.getText());};

declareList: type declare
    | declareList COMMA declare
    ;

list: LIST HASHTAG type;

struct: STRUCT n=IDENTIFIER {System.out.println("StructDec : "+$n.getText());} LSCOPE (NEWLINE (declareList SC? | setget))+ NEWLINE RSCOPE;

setget: type n=IDENTIFIER {System.out.println("VarDec : "+$n.getText());}  prototype LSCOPE NEWLINE
                          {System.out.println("Setter");} SET scope NEWLINE
                          {System.out.println("Getter");} GET scope NEWLINE RSCOPE;

simpleScope : LSCOPE simpleSource* NEWLINE RSCOPE | simpleSource;

simpleSource: NEWLINE ( simpleScope | matchIF | loop | statement);

scope : LSCOPE source* NEWLINE RSCOPE | source;

source: NEWLINE ( scope | loop | statement) | conditional;

primaryExpression: IDENTIFIER
    | INT
    | BOOL
    | LBRACE expression RBRACE
    | utilCall
    ;

util: n=BULITIN  {System.out.println("Built-in : "+$n.getText());}
    | SIZE {System.out.println("Size");}
    | APPEND {System.out.println("Append");}
    ;

utilCall: util LBRACE expression RBRACE;

accessExpression: DOT IDENTIFIER accessExpression?
    | LBRACKET expression RBRACKET accessExpression?
    ;

callExpression: LBRACE expression? RBRACE callExpression?;

postfixExpression: primaryExpression
    | primaryExpression (callExpression accessExpression)* callExpression
    | primaryExpression (accessExpression callExpression)* accessExpression
    | primaryExpression (accessExpression callExpression)+
    | primaryExpression (callExpression accessExpression)+
    ;

unaryExpression: postfixExpression
    | n=MINUS unaryExpression {System.out.println("Operator : "+$n.getText());}
    | n=COMPLIMENT unaryExpression {System.out.println("Operator : "+$n.getText());}
    ;

multExpression: unaryExpression
    | multExpression n=MULT unaryExpression {System.out.println("Operator : "+$n.getText());}
    ;

addExpression: multExpression
    | addExpression n=ADD multExpression {System.out.println("Operator : "+$n.getText());}
    | addExpression n=MINUS multExpression {System.out.println("Operator : "+$n.getText());}
    ;

compExpression: addExpression
    | compExpression n=LCURLY addExpression {System.out.println("Operator : "+$n.getText());}
    | compExpression n=RCURLY addExpression {System.out.println("Operator : "+$n.getText());}
    ;

andExpression: compExpression
    | andExpression n=AND compExpression {System.out.println("Operator : "+$n.getText());}
    ;

orExpression: andExpression
    | orExpression n=OR andExpression {System.out.println("Operator : "+$n.getText());}
    ;

equalExpression: orExpression
    | orExpression n=EQUAL orExpression {System.out.println("Operator : "+$n.getText());}
    ;

assignExpression : equalExpression
    | unaryExpression ASSIGN assignExpression
    ;

expression: assignExpression
    | expression COMMA assignExpression
    ;

assignStatement: primaryExpression accessExpression ASSIGN assignExpression
    | primaryExpression ASSIGN assignExpression
    ;

functionStatement: primaryExpression (callExpression accessExpression)* callExpression
    | primaryExpression (accessExpression callExpression)*
    ;

statementblocks: {System.out.println("Return");} RETURN expression?
    | functionStatement {System.out.println("FunctionCall");}
    | assignStatement
    | declareList
    | utilCall
    ;

statement: statementblocks SC*
    | statementblocks SC+ statement
    ;

argument: type n=IDENTIFIER {System.out.println("ArgumentDec : "+$n.getText());}
    | argument COMMA argument
    ;

prototype: LBRACE (argument) RBRACE | LBRACE RBRACE;

function: type n=IDENTIFIER {System.out.println("FunctionDec : "+$n.getText());} prototype scope
    | NEWLINE fptr IDENTIFIER prototype scope
    ;

typelist:  type  | type  COMMA typelist;

fptr : FPTR LCURLY typelist MINUS RCURLY type RCURLY;

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

BULITIN : 'display';

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

NEWLINE : ([ \n\r\t]|COMMENT)*'\n'([ \n\r\t]|COMMENT)*;

WHITESPACE: [ \t\r] -> skip;

COMMENT: '/*' .*? '*/' -> skip;