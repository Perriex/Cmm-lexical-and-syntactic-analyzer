grammar Cmm;

/* Grammr */

start: struct* (newline function)* newline? MAIN {System.out.println("Main");} LBRACE RBRACE scope EOF;

unary: MINUS | COMPLIMENT;

type: BASETYPE | fptr | list | STRUCT IDENTIFIER | VOID;

conditional: matchIF | unmatchIF ;

newline: (WHITESPACE | NEWLINE)*NEWLINE(WHITESPACE | NEWLINE)*;

matchIF : {System.out.println("Conditional : if");} IF  expression (matchIF | scope) {System.out.println("Conditional : else");} newline ELSE (matchIF | scope) ;

unmatchIF: {System.out.println("Conditional : if");} IF expression scope |
           {System.out.println("Conditional : if");} IF expression matchIF {System.out.println("Conditional : else");} newline ELSE unmatchIF;

loop: {System.out.println("Loop : while");} WHILE expression scope | {System.out.println("Loop : do...while");} DO scope newline WHILE expression;

declare: declare COMMA n=lvalue {System.out.println("VarDec : "+$n.text);} | type n=lvalue {System.out.println("VarDec : "+$n.text);};/*bug*/

list: LIST HASHTAG type;

struct: STRUCT n=IDENTIFIER {System.out.println("StructDec : "+$n.getText());} LSCOPE (newline (declare SC? | setget))+ newline RSCOPE;

setget: type n=IDENTIFIER {System.out.println("VarDec : "+$n.getText());}  prototype LSCOPE newline
                          {System.out.println("Setter");} SET scope newline
                          {System.out.println("Getter");} GET scope newline RSCOPE;

scope : LSCOPE ( scope | source )* newline RSCOPE | source;

source: newline ( scope | conditional | loop | statement SC? );

expressionlist : expression
    | expressionlist COMMA expression;

lvalue : IDENTIFIER
    | b=BULITIN {System.out.println("Built-in : " + $b.getText());}
    | u=UTILITY {if($u.text == "size") System.out.println("Size"); else System.out.println("Append");}
    | lvalue ASSIGN expression
    | lvalue DOT IDENTIFIER
    | lvalue LBRACE RBRACE {System.out.println("FunctionCall");}
    | lvalue LBRACE expressionlist RBRACE {System.out.println("FunctionCall");}
    | lvalue LBRACKET expression RBRACKET;

rvalue : INT | BOOL | lvalue;

expression : LBRACE expression RBRACE
    | rvalue
    | l=unary expression {System.out.println("Operator : "+$l.text);}
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
     | {System.out.println("Return");} RETURN expression?
     | declare
     | conditional;

statement : statement (SC | NEWLINE)+ statementblocks | statementblocks;

argument: type n=IDENTIFIER {System.out.println("ArgumentDec : "+$n.getText());}| argument COMMA argument;

prototype: LBRACE (argument|) RBRACE;

function: type n=IDENTIFIER {System.out.println("FunctionDec : "+$n.getText());} prototype scope
          | newline fptr IDENTIFIER prototype scope;

typelist:  type  | type  COMMA typelist;

fptr : FPTR LCURLY typelist MINUS RCURLY  type  RCURLY;

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

UTILITY: 'size' | 'append';

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

WHITESPACE: [ \t\r] -> skip;

COMMENT: '/*' .*? '*/' -> skip;