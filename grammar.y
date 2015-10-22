%{
#include "driver.h"
#include "symTable.h"
#include <stdio.h>

void yyerror(char *);

%}

%union {
	int iVal;
	double dVal;
	char * sVal;
	char * identifierName;


}

%token <identifierName> IDENTIFIER 
%token INTEGER_CONSTANT FLOATING_CONSTANT CHARACTER_CONSTANT ENUMERATION_CONSTANT 
%token STRING_LITERAL 
%token SIZEOF
%token PTR_OP 
%token INC_OP DEC_OP 
%token LEFT_OP RIGHT_OP 
%token LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP 
%token MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN SUB_ASSIGN 
%token LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN 
%token TYPEDEF_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELIPSIS RANGE

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit
%%

translation_unit
	: external_declaration
		{if (parseDebug){
   			fprintf(parseFile,"translation_unit <- external_declaration \n\n");
   			}
   		}
	| translation_unit external_declaration
		{if (parseDebug){
			fprintf(parseFile,"translation_unit <- translation_unit external_declaration \n\n");
			}
		}
	;

external_declaration
	: function_definition
		{if (parseDebug){
			fprintf(parseFile,"external_declaration <- function_definition \n\n");
			}
			
		}
	| declaration
		{if (parseDebug){
			fprintf(parseFile,"external_declaration <- declarationn \n\n");
			}
			
		}
		
	;

function_definition
	: declarator compound_statement
		{if (parseDebug){
			fprintf(parseFile,"function_definition <- declarator compound_statement \n\n");
			}
			
			
		}
	| declarator declaration_list compound_statement
		{if(parseDebug){
			fprintf(parseFile,"function_definition <- declarator declaration_list compound_statement \n\n");
			}
		}
	| declaration_specifiers declarator compound_statement
		{if(parseDebug){
			fprintf(parseFile,"function_definition <- declaration_specifiers declarator compound_statement \n\n");
			}
		}
	| declaration_specifiers declarator declaration_list compound_statement
		{if(parseDebug){
			fprintf(parseFile,"function_definition <- declaration_specifiers declaration compound_statement \n\n");
			}
		}
	;

declaration
	: declaration_specifiers ';'
		{if(parseDebug){
			fprintf(parseFile,"declaration <- declaration_specifiers \n\n");
			}
		}
	| declaration_specifiers init_declarator_list ';'
		{if(parseDebug){
			fprintf(parseFile,"declaration <- declaration_specifiers init_declarator_list \n\n");
			}
		}
	;

declaration_list
	: declaration
		{if(parseDebug){
			fprintf(parseFile,"declaration_list <- declaration \n\n");
			fprintf(parseFile,"Look up is true \n\n");
			
			}
			lookUpMode = true;
		}
	| declaration_list declaration
		{if(parseDebug){
			fprintf(parseFile,"declaration_list <- declaration_list declaration \n\n");
			fprintf(parseFile,"Look up is true \n\n");
			}
		
			lookUpMode = true;
		}
	;

declaration_specifiers
	: storage_class_specifier
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- storage_class_specifier \n\n");
			}
		}
	| storage_class_specifier declaration_specifiers
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- storage_class_specifier declaration_specifiers \n\n");
			}
		}
	| type_specifier
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- type_specifier \n\n");
			fprintf(parseFile,"Insert Mode \n\n");
			}
			
			  //Set Lookup mode to false
		    lookUpMode = false;
			 
		}
	| type_specifier declaration_specifiers
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- type_specifier declaration_specifiers \n\n");
			}
		}
	| type_qualifier 
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- type_specifier declaration_specifiers \n\n");
			}
		}
	| type_qualifier declaration_specifiers
		{if(parseDebug){
			fprintf(parseFile,"declaration_specifiers <- type_qualifier declaration_specifiers \n\n");
			}
		}
	;

storage_class_specifier
	: AUTO
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- AUTO \n\n");
			}
			
			//Set Flag
			flags.auto_flag = true;
		}	
	| REGISTER
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- REGISTER  \n\n");
			}
			
			//Set Flag
			flags.register_flag = true;
		}
	| STATIC
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- STATIC \n\n");
			}
			
						
			//Set Flag
			flags.static_flag = true;

		}
	| EXTERN
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- EXTERN \n\n");
			}
			
			//Set Flag
			flags.extern_flag = true;
		}
	| TYPEDEF
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- TYPEDEF \n\n");
			}
			
			
			//Set Flag
			flags.typedef_flag = true;
		}
	;

type_specifier
	: VOID
		{if(parseDebug){
			fprintf(parseFile,"type_specifier <- VOID \n\n");
			}
			
			//Set Flag
			flags.void_flag = true;
		}
	| CHAR
		{if(parseDebug){
			fprintf(parseFile,"type_specifier <- CHAR \n\n");
			}
			
			//Set Flag
			flags.char_flag = true;
		}
	| SHORT
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- SHORT \n\n");
			}
			
			//Set Flag
			flags.short_flag = true;
		}
	| INT
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- INT \n\n");
			}
			
			//Set Flag
			flags.int_flag = true;
		}
	| LONG
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- LONG \n\n");
			}
			
			//Set Flag
			flags.long_flag = true;
		}
	| FLOAT 
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- FLOAT \n\n");
			}
			
			//Set Flag
			flags.float_flag = true;
		}
	| DOUBLE
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- DOUBLE \n\n");
			}
			
			//Set Flag
			flags.double_flag = true;
		}
	| SIGNED
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- SIGNED \n\n");
			}
			
			//Set Flag
			flags.signed_flag = true;
		}
	| UNSIGNED
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- UNSIGNED \n\n");
			}
			
			//Set Flag
			flags.unsigned_flag = true;
		}
	| struct_or_union_specifier
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- struct_or_union_specifier \n\n");
			}
			
			//Set Flag
			flags.struct_flag = true;
		}
	| enum_specifier
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- enum_specifier \n\n");
			}
			
			//Set Flag
			flags.enum_flag = true;
		}
	| TYPEDEF_NAME
		{if(parseDebug){
			fprintf(parseFile,"storage_class_specifier <- TYPEDEF_NAME \n\n");
			}
			
			//Set Flag
			flags.typedef_flag = true;
		}
	;

type_qualifier
	: CONST
		{if(parseDebug){
			fprintf(parseFile,"type_qualifier <- CONST \n\n");
			}
			
			//Set Flag
			flags.const_flag = true;
		}
	
	| VOLATILE
		{if(parseDebug){
			fprintf(parseFile,"type_qualifier <- VOLATILE \n\n");
			}
			
			//Set Flag
			flags.volatile_flag = true;
		}
	;

struct_or_union_specifier
	: struct_or_union identifier '{' struct_declaration_list '}'
		{if(parseDebug){
			fprintf(parseFile,"struct_or_union_specifier <- struct_or_union identifier '{' struct_declaration_list '}' \n\n");
			}
		}
	| struct_or_union '{' struct_declaration_list '}'
		{if(parseDebug){
			fprintf(parseFile,"struct_or_union_specifier <- struct_or_union '{' struct_declaration_list '}' \n\n");
			}
		}
	| struct_or_union identifier
		{if(parseDebug){
			fprintf(parseFile,"struct_or_union_specifier <- struct_or_union identifier \n\n");
			}
		}
	;

struct_or_union
	: STRUCT
		{if(parseDebug){
			    fprintf(parseFile,"STRUCT \n\n");
			}
		}
	| UNION
		{if(parseDebug){
			fprintf(parseFile,"UNION \n\n");
		}
		}
	;

struct_declaration_list
	: struct_declaration
		{if(parseDebug){
			fprintf(parseFile,"struct_declaration_list <- struct_declaration \n\n");
			}
		}
	| struct_declaration_list struct_declaration
		{if(parseDebug){
			fprintf(parseFile,"struct_declaration_list <- struct_declaration_list struct_declaration \n\n");
			}
		}
	;

init_declarator_list
	: init_declarator
		{if(parseDebug){
			fprintf(parseFile,"init_declarator_list <- init_declarator \n\n");
			}
		}
	| init_declarator_list ',' init_declarator
		{if(parseDebug){
			fprintf(parseFile,"init_declarator_list <- init_declarator_list ',' init_declarator \n\n");
			}
		}
	;

init_declarator
	: declarator
		{if(parseDebug){
			fprintf(parseFile,"init_declarator <- declarator \n\n");
			}
		}
	| declarator '=' initializer
		{if(parseDebug){
			fprintf(parseFile,"init_declarator <- declarator '=' initializer \n\n");
			}
		}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
		{if(parseDebug){
			fprintf(parseFile,"struct_declaration <- specifier_qualifier_list struct_declarator_list ';' \n\n");
			}
		}
	;

specifier_qualifier_list
	: type_specifier
		{if(parseDebug){
			fprintf(parseFile,"specifier_qualifier_list <- type_specifier \n\n");
			}
		}
	| type_specifier specifier_qualifier_list
		{if(parseDebug){
			fprintf(parseFile,"specifier_qualifier_list <- type_specifier specifier_qualifier_list \n\n");
			}
		}
	| type_qualifier
		{if(parseDebug){
			fprintf(parseFile,"specifier_qualifier_list <- type_qualifier \n\n");
			}
		}
	| type_qualifier specifier_qualifier_list
		{if(parseDebug){
			fprintf(parseFile,"specifier_qualifier_list <- type_qualifier specifier_qualifier_list \n\n");
			}
		}
	;

struct_declarator_list
	: struct_declarator
		{if(parseDebug){
			fprintf(parseFile,"struct_declarator_list <- struct_declarator \n\n");
			}
		}
	| struct_declarator_list ',' struct_declarator
		{if(parseDebug){
			fprintf(parseFile,"struct_declarator_list <- struct_declarator_list ',' struct_declarator \n\n");
			}
		}
	;

struct_declarator
	: declarator
		{if(parseDebug){
			fprintf(parseFile,"struct_declarator <- declarator \n\n");
			}
		}
	| ':' constant_expression
		{if(parseDebug){
			fprintf(parseFile,"struct_declarator <- ':' constant_expression \n\n");
			}
		}
	| declarator ':' constant_expression
		{if(parseDebug){
			fprintf(parseFile,"struct_declarator <- declarator ':' constant_expression \n\n");
			}
		}
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
		{if(parseDebug){
			fprintf(parseFile,"enum_specifier <- ENUM '{' enumerator_list '}' \n\n");
			}
		}
	| ENUM identifier '{' enumerator_list '}'
		{if(parseDebug){
			fprintf(parseFile,"enum_specifier <- ENUM identifier '{' enumerator_list '}' \n\n");
			}
		}
	| ENUM identifier
		{if(parseDebug){
			fprintf(parseFile,"enum_specifier <- ENUM identifier \n\n");
			}
		}
	;

enumerator_list
	: enumerator
		{if(parseDebug){
			fprintf(parseFile,"enumerator_list <- enumerator \n\n");
			}
		}
	| enumerator_list ',' enumerator
		{if(parseDebug){
			fprintf(parseFile,"enumerator_list <- enumerator_list ',' enumerator \n\n");
			}
		}
	;

enumerator
	: identifier
		{if(parseDebug){
			fprintf(parseFile,"enumerator <- identifier \n\n");
			}
		}
	| identifier '=' constant_expression
		{if(parseDebug){
			fprintf(parseFile,"enumerator <- identifier '=' constant_expression \n\n");
			}
		}
	;

declarator
	: direct_declarator
		{if(parseDebug){
			fprintf(parseFile,"declarator <- direct_declarator \n\n");
			}
		}
	| pointer direct_declarator
		{if(parseDebug){
			fprintf(parseFile,"declarator <- pointer direct_declarator \n\n");
			}
		}
	;

direct_declarator
	: identifier
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- identifier \n\n");
			}
		}
	| '(' declarator ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- '(' declarator ')' \n\n");
			}
		}
	| direct_declarator '[' ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- direct_declarator '[' ']' \n\n");
			}
		}
	| direct_declarator '[' constant_expression ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- direct_declarator '[' constant_expression ']' \n\n");
			}
		}
	| direct_declarator '(' ')' 
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- direct_declarator '(' ')' \n\n");
			}
		}
	| direct_declarator '(' parameter_type_list ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- direct_declarator '(' parameter_type_list ')' \n\n");
			}
		}
	| direct_declarator '(' identifier_list ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_declarator <- direct_declarator '(' identifier_list ')' \n\n");
			}
		}
	;

pointer
	: '*'
		{if(parseDebug){
			fprintf(parseFile,"pointer <- '*' \n\n");
			}
		}
	| '*' type_qualifier_list
		{if(parseDebug){
			fprintf(parseFile,"pointer <- '*' type_qualifier_list \n\n");
			}
		}
	| '*' pointer
		{if(parseDebug){
			fprintf(parseFile,"pointer <- '*' pointer \n\n");
			}
		}
	| '*' type_qualifier_list pointer
		{if(parseDebug){
			fprintf(parseFile,"pointer <- '*' type_qualifier_list pointer \n\n");
			}
		}
	;

type_qualifier_list
	: type_qualifier
		{if(parseDebug){
			fprintf(parseFile,"type_qualifier_list <- type_qualifier \n\n");
			}
		}
	| type_qualifier_list type_qualifier
		{if(parseDebug){
			fprintf(parseFile,"type_qualifier_list <- type_qualifier_list type_qualifier_list \n\n");
			}
		}
	;

parameter_type_list
	: parameter_list
		{if(parseDebug){
			fprintf(parseFile,"parameter_type_list <- parameter_list \n\n");
			}
		}
	| parameter_list ',' ELIPSIS
		{if(parseDebug){
			fprintf(parseFile,"parameter_type_list <- parameter_list ',' ELIPSIS \n\n");
			}
		}
	;

parameter_list
	: parameter_declaration
		{if(parseDebug){
			fprintf(parseFile,"parameter_list <- parameter_declaration \n\n");
			}
		}
	| parameter_list ',' parameter_declaration
		{if(parseDebug){
			fprintf(parseFile,"parameter_list <- parameter_list ',' parameter_declaration \n\n");
			}
		}
	;

parameter_declaration
	: declaration_specifiers declarator
		{if(parseDebug){
			fprintf(parseFile,"parameter_declaration <- declaration_specifiers declarator \n\n");
			}
		}
	| declaration_specifiers
		{if(parseDebug){
			fprintf(parseFile,"parameter_declaration <- declaration_specifiers \n\n");
			}
		}
	| declaration_specifiers abstract_declarator
		{if(parseDebug){
			fprintf(parseFile,"parameter_declaration <- declaration_specifiers abstract_declarator \n\n");
			}
		}
	;

identifier_list
	: identifier
		{if(parseDebug){
			fprintf(parseFile,"identifier_list <- identifier \n\n");
			}
		}
	| identifier_list ',' identifier
		{if(parseDebug){
			fprintf(parseFile,"identifier_list <- identifier_list ',' identifier \n\n");
			}
		}
	;

initializer
	: assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"initializer <- assignment_expression \n\n");
			}
		}
	| '{' initializer_list '}'
		{if(parseDebug){
			fprintf(parseFile,"initializer <- '{' initializer_list '}' \n\n");
			}
		}
	| '{' initializer_list ',' '}'
		{if(parseDebug){
			fprintf(parseFile,"initializer <- '{' initializer_list ',' '}' \n\n");
			}
		}
	;

initializer_list
	: initializer
		{if(parseDebug){
			fprintf(parseFile,"initializer_list <- initializer \n\n");
			}
		}
	| initializer_list ',' initializer
		{if(parseDebug){
			fprintf(parseFile,"initializer_list <- initializer_list ',' initializer \n\n");
			}
		}
	;

type_name
	: specifier_qualifier_list
		{if(parseDebug){
			fprintf(parseFile,"type_name <- specifier_qualifier_list \n\n");
			}
		}
	| specifier_qualifier_list abstract_declarator
		{if(parseDebug){
			fprintf(parseFile,"type_name <- specifier_qualifier_list abstract_declarator \n\n");
			}
		}
	;

abstract_declarator
	: pointer
		{if(parseDebug){
			fprintf(parseFile,"abstract_declarator <- pointer \n\n");
			}
		}
	| direct_abstract_declarator
		{if(parseDebug){
			fprintf(parseFile,"abstract_declarator <- direct_abstract_declarator \n\n");
			}
		}
	| pointer direct_abstract_declarator
		{if(parseDebug){
			fprintf(parseFile,"abstract_declarator <- pointer direct_abstract_declarator \n\n");
			}
		}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- '(' abstract_declarator ')' \n\n");
			}
		}
	| '[' ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- '[' ']' \n\n");
			}
		}
	| '[' constant_expression ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- '[' constant_expression ']' \n\n");
			}
		}
	| direct_abstract_declarator '[' ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- direct_abstract_declarator '[' ']' \n\n");
			}
		}
	| direct_abstract_declarator '[' constant_expression ']'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- direct_abstract_declarator '[' constant_expression ']' \n\n");
			}
		}
	| '(' ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- '(' ')' \n\n");
			}
		}
	| '(' parameter_type_list ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- '(' parameter_type_list ')' \n\n");
			}
		}
	| direct_abstract_declarator '(' ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- direct_abstract_declarator '(' ')' \n\n");
			}
		}
	| direct_abstract_declarator '(' parameter_type_list ')'
		{if(parseDebug){
			fprintf(parseFile,"direct_abstract_declarator <- direct_abstract_declarator '(' parameter_type_list ')' \n\n");
			}
		}
	;

statement
	: labeled_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- labeled_statement \n\n");
			}
		}
	| compound_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- compound_statement \n\n");
			}
		}
	| expression_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- expression_statement \n\n");
			}
		}
	| selection_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- selection_statement \n\n");
			}
		}
	| iteration_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- iteration_statement \n\n");
			}
		}
	| jump_statement
		{if(parseDebug){
			fprintf(parseFile,"statement <- jump_statement \n\n");
			}
		}
	;

labeled_statement
	: identifier ':' statement
		{if(parseDebug){
			fprintf(parseFile,"labeled_statement <- identifier ':' \n\n");
			}
		}
	| CASE constant_expression ':' statement
		{if(parseDebug){
			fprintf(parseFile,"labeled_statement <- CASE constant_expression ':' statement \n\n");
			}
		}
	| DEFAULT ':' statement
		{if(parseDebug){
			fprintf(parseFile,"DEFAULT ':' statement \n\n");
			}
		}
	;

expression_statement
	: ';'
		{if(parseDebug){
			fprintf(parseFile,"expression_statement <- ';' \n\n");
			}
		}
	| expression ';'
		{if(parseDebug){
			fprintf(parseFile,"expression_statement <- expression ';' \n\n");
			}
		}
	;

compound_statement
	: '{' '}'
		{if(parseDebug){
			fprintf(parseFile,"compound_statement <- '{' '}' \n\n");
			}
		}
	| '{' statement_list '}'
		{if(parseDebug){
			fprintf(parseFile,"compound_statement <- '{' statement_list '}' \n\n");
			}
		}
	| '{' declaration_list '}'
		{if(parseDebug){
			fprintf(parseFile,"compound_statement <- '{' declaration_list '}' \n\n");
			}
		}
	| '{' declaration_list statement_list '}'
		{if(parseDebug){
			fprintf(parseFile,"compound_statement <- '{' declaration_list statement_list '}'  \n\n");
			}
			
			
		}
	;

statement_list
	: statement
		{if(parseDebug){
			fprintf(parseFile,"statement_list <- statement  \n\n");
			}
			

		}
	| statement_list statement
		{if(parseDebug){
			fprintf(parseFile,"statement_list <- statement_list statement \n\n");
			}

		}
	;

selection_statement
	: IF '(' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"selection_statement <- IF '(' expression ')' statement  \n\n");
			}
		}
	| IF '(' expression ')' statement ELSE statement
		{if(parseDebug){
			fprintf(parseFile,"selection_statement <- IF '(' expression ')' statement ELSE statement \n\n");
			}
		}
	| SWITCH '(' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"selection_statement <- SWITCH '(' expression ')' statement \n\n");
			}
		}
	;

iteration_statement
	: WHILE '(' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- WHILE '(' expression ')' statement \n\n");
			}
		}
	| DO statement WHILE '(' expression ')' ';'
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- DO statement WHILE '(' expression_statement ')'; \n\n");
			}
		}
	| FOR '(' ';' ';' ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' ';' ';' ')' statement \n\n");
			}
		}
	| FOR '(' ';' ';' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' ';' ';' expression ')' statement \n\n");
			}
		}
	| FOR '(' ';' expression ';' ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' ';' expression ';' ')' statement \n\n");
			}
		}
	| FOR '(' ';' expression ';' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' ';' expression ';' expression ')' statement \n\n");
			}
		}
	| FOR '(' expression ';' ';' ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' expression ';' ';' ')' statement \n\n");
			}
		}
	| FOR '(' expression ';' ';' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' expression ';' ';' expression ')' statement \n\n");
			}
		}
	| FOR '(' expression ';' expression ';' ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' expression ';' expression ';' ')' statement \n\n");
			}
		}
	| FOR '(' expression ';' expression ';' expression ')' statement
		{if(parseDebug){
			fprintf(parseFile,"iteration_statement <- FOR '(' expression ';' expression ';' expression ')' statement \n\n");
			}
		}
	;

jump_statement
	: GOTO identifier ';'
		{if(parseDebug){
			fprintf(parseFile,"jump_statement <- GOTO identifier ';' \n\n");
			}
		}
	| CONTINUE ';'
		{if(parseDebug){
			fprintf(parseFile,"jump_statement <- CONTINUE ';' \n\n");
			}
		}
	| BREAK ';'
		{if(parseDebug){
			fprintf(parseFile,"jump_statement <- BREAK ';' \n\n");
			}
		}
	| RETURN ';'
		{if(parseDebug){
			fprintf(parseFile,"jump_statement <- RETURN ';' \n\n");
			}
		}
	| RETURN expression ';'
		{if(parseDebug){
			fprintf(parseFile,"jump_statement <- RETURN expression';' \n\n");
			}
		}
	;

expression
	: assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"expression <- assignment_expression \n\n");
			}
		}
	| expression ',' assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"expression <- expression ',' assignment_expression \n\n");
			}
		}
	;

assignment_expression
	: conditional_expression
		{if(parseDebug){
			fprintf(parseFile,"assignment_expression <- conditional_expression \n\n");
			}
		}
	| unary_expression assignment_operator assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"assignment_expression <- unary_expression assignment_operator assignment_expression \n\n");
			}
		}
	;

assignment_operator
	: '='
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = \n\n");
			}
	}
	
	| MUL_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- MUL_ASSIGN \n\n");
			}
		}
	| DIV_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- =  DIV_ASSIGN\n\n");
			}
		}
	| MOD_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = MOD_ASSIGN\n\n");
			}
		}
	| ADD_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = ADD_ASSIGN\n\n");
			}
		}
	| SUB_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = SUB_ASSIGN \n\n");
			}
		}
	| LEFT_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = LEFT_ASSIGNn\n");
			}
		}
	| RIGHT_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = RIGHT_ASSIGN\n\n");
			}
		}
	| AND_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = AND_ASSIGNn\n");
			}
		}
	| XOR_ASSIGN
	{if(parseDebug){
			fprintf(parseFile,"assignment_operator <- = XOR_ASSIGN\n\n");
			}
		}
	| OR_ASSIGN
	
	;

conditional_expression
	: logical_or_expression
		{if(parseDebug){
			fprintf(parseFile,"conditional_expression <- logical_or_expression \n \n");
			}
		}
	| logical_or_expression '?' expression ':' conditional_expression
		{if(parseDebug){
			fprintf(parseFile,"conditional_expression <- logical_or_expression '?' expression ':' conditional_expression \n\n");
			}
		}
	;

constant_expression
	: conditional_expression
		{if(parseDebug){
			fprintf(parseFile,"constant_expression <- conditional_expression \n\n");
			}
		}
	;

logical_or_expression
	: logical_and_expression
		{if(parseDebug){
			fprintf(parseFile,"logical_or_expression <- logical_and_expression \n\n");
			}
		}
	| logical_or_expression OR_OP logical_and_expression
		{if(parseDebug){
			fprintf(parseFile,"logical_or_expression <- logical_or_expression OR_OP logical_and_expression \n\n");
			}
		}
	;

logical_and_expression
	: inclusive_or_expression
		{if(parseDebug){
			fprintf(parseFile,"logical_and_expression <- inclusive_or_expression \n\n");
			}
		}
	| logical_and_expression AND_OP inclusive_or_expression
		{if(parseDebug){
			fprintf(parseFile,"logical_and_expression <- logical_and_expression AND_OP inclusive_or_expression  \n\n");
			}
		}
	;

inclusive_or_expression
	: exclusive_or_expression
		{if(parseDebug){
			fprintf(parseFile,"inclusive_or_expression <- exclusive_or_expression  \n\n");
			}
		}
	| inclusive_or_expression '|' exclusive_or_expression
		{if(parseDebug){
			fprintf(parseFile,"inclusive_or_expression <- inclusive_or_expression '|' exclusive_or_expression \n");
			}
		}
	;

exclusive_or_expression
	: and_expression
		{if(parseDebug){
			fprintf(parseFile,"exclusive_or_expression <- and_expression \n\n");
			}
		}
	| exclusive_or_expression '^' and_expression
		{if(parseDebug){
			fprintf(parseFile,"exclusive_or_expression <- exclusive_or_expression '^' and_expression \n");
			}
		}
	;

and_expression
	: equality_expression
		{if(parseDebug){
			fprintf(parseFile,"and_expression <- equality_expression \n\n");
			}
		}
	| and_expression '&' equality_expression
		{if(parseDebug){
			fprintf(parseFile,"and_expression <- and_expression '&' equality_expression \n");
			}
		}
	;

equality_expression
	: relational_expression
		{if(parseDebug){
			fprintf(parseFile,"equality_expression <- relational_expression \n\n");
			}
		}
	| equality_expression EQ_OP relational_expression
		{if(parseDebug){
			fprintf(parseFile,"equality_expression <-  equality_expression EQ_OP relational_expression \n\n");
			}
		}
	| equality_expression NE_OP relational_expression
		{if(parseDebug){
			fprintf(parseFile,"equality_expression <- equality_expression NE_OP relational_expression \n\n");
			}
		}
	;

relational_expression
	: shift_expression
		{if(parseDebug){
			fprintf(parseFile,"relational_expression <- shift_expression \n\n");
			}
		}
	| relational_expression '<' shift_expression
		{if(parseDebug){
			fprintf(parseFile,"relational_expression <- relational_expression '<' shift_expression \n\n");
			}
		}
	| relational_expression '>' shift_expression
		{if(parseDebug){
			fprintf(parseFile,"relational_expression <- relational_expression '>' shift_expression \n\n");
			}
		}
	| relational_expression LE_OP shift_expression
		{if(parseDebug){
			fprintf(parseFile,"relational_expression <- relational_expression LE_OP shift_expression \n\n");
			}
		}
	| relational_expression GE_OP shift_expression
		{if(parseDebug){
			fprintf(parseFile,"relational_expression <- relational_expression GE_OP shift_expression \n\n");
			}
		}
	;

shift_expression
	: additive_expression
		{if(parseDebug){
			fprintf(parseFile,"shift_expression <- additive_expression \n\n");
			}
		}
	| shift_expression LEFT_OP additive_expression
		{if(parseDebug){
			fprintf(parseFile,"shift_expression <- shift_expression LEFT_OP additive_expression \n\n");
			}
		}
	| shift_expression RIGHT_OP additive_expression
		{if(parseDebug){
			fprintf(parseFile,"shift_expression <- shift_expression RIGHT_OP additive_expression \n\n");
			}
		}
	;

additive_expression
	: multiplicative_expression
		{if(parseDebug){
			fprintf(parseFile,"additive_expression <- multiplicative_expression \n\n");
			}
		}
	| additive_expression '+' multiplicative_expression
		{if(parseDebug){
			fprintf(parseFile,"additive_expression <- additive_expression '+' multiplicative_expression \n\n");
			}
		}
	| additive_expression '-' multiplicative_expression
		{if(parseDebug){
			fprintf(parseFile,"additive_expression <- additive_expression '-' multiplicative_expression \n\n");
			}
		}
	;

multiplicative_expression
	: cast_expression
		{if(parseDebug){
			fprintf(parseFile,"multiplicative_expression <- cast_expression \n\n");
			}
		}
	| multiplicative_expression '*' cast_expression
		{if(parseDebug){
			fprintf(parseFile,"multiplicative_expression <- multiplicative_expression '*' cast_expression \n\n");
			}
		}
	| multiplicative_expression '/' cast_expression
		{if(parseDebug){
			fprintf(parseFile,"multiplicative_expression <- multiplicative_expression '/' cast_expression \n\n");
			}
		}
	| multiplicative_expression '%' cast_expression
		{if(parseDebug){
			fprintf(parseFile,"multiplicative_expression <- multiplicative_expression ''AND'' cast_expression \n\n");
			}
		}
	;

cast_expression
	: unary_expression
		{if(parseDebug){
			fprintf(parseFile,"cast_expression <- unary_expression \n\n");
			}
		}
	| '(' type_name ')' cast_expression
		{if(parseDebug){
			fprintf(parseFile,"cast_expression <-  '(' type_name ')' cast_expression \n\n");
			}
		}
	;

unary_expression
	: postfix_expression
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- postfix_expression \n\n");
			}
		}
	| INC_OP unary_expression
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- INC_OP unary_expression \n\n");
			}
		}
	| DEC_OP unary_expression
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- DEC_OP unary_expression \n\n");
			}
		}
	| unary_operator cast_expression
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- unary_operator cast_expression \n\n");
			}
		}
	| SIZEOF unary_expression
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- SIZEOF unary_expression \n\n");
			}
		}
	| SIZEOF '(' type_name ')'
		{if(parseDebug){
			fprintf(parseFile,"unary_expression <- SIZEOF '(' type_name ')' \n\n");
			}
		}
	;

unary_operator
	: '&'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- & '(' type_name ')' \n\n");
			}
		}
	| '*'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- * '(' type_name ')' \n\n");
			}
		}
	| '+'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- + '(' type_name ')' \n\n");
			}
		}
	| '-'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- - '(' type_name ')' \n\n");
			}
		}
	| '~'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- ~ '(' type_name ')' \n\n");
			}
		}
	| '!'
		{if(parseDebug){
			fprintf(parseFile,"unary_operator <- ! '(' type_name ')' \n\n");
			}
		}
	;

postfix_expression
	: primary_expression
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- primary_expression \n\n");
			}
		}
	| postfix_expression '[' expression ']'
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression '[' expression ']' \n\n");
			}
		}
	| postfix_expression '(' ')'
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression '(' ')' \n\n");
			}
		}
	| postfix_expression '(' argument_expression_list ')'
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression '(' argument_expression_list ')' \n\n");
			}
		}
	| postfix_expression '.' identifier
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression '.' identifier \n\n");
			}
		}
	| postfix_expression PTR_OP identifier
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression PTR_OP identifier \n\n");
			}
		}
	| postfix_expression INC_OP
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression INC_OP \n\n");
			}
		}
	| postfix_expression DEC_OP
		{if(parseDebug){
			fprintf(parseFile,"postfix_expression <- postfix_expression DEC_OP \n\n");
			}
		}
	;

primary_expression
	: identifier
		{if(parseDebug){
			fprintf(parseFile,"primary_expression <- identifier \n\n");
			}
		}
	| constant
		{if(parseDebug){
			fprintf(parseFile,"primary_expression <- constant \n\n");
			}
		}
	| string
		{if(parseDebug){
			fprintf(parseFile,"primary_expression <- string \n\n");
			}
		}
	| '(' expression ')'
		{if(parseDebug){
			fprintf(parseFile,"primary_expression <- '(' expression ')' \n\n");
			}
		}
	;

argument_expression_list
	: assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"argument_expression_list <- assignment_expression \n\n");
			}
		}
	| argument_expression_list ',' assignment_expression
		{if(parseDebug){
			fprintf(parseFile,"argument_expression_list <- argument_expression_list ',' assignment_expression \n\n");
			}
		}
	;

constant
	: INTEGER_CONSTANT  {
	            if(currentIdentifier != NULL){
	                
	                currentIdentifier->dataI = (int *) malloc(sizeof(int));
	                currentIdentifier->dataI = yylval.iVal;
                }
	            if(parseDebug){
			        fprintf(parseFile,"CONSTANT <- INTEGER_CONSTANT \n\n");
			    }
	         }
	| CHARACTER_CONSTANT {
	
	            if(currentIdentifier != NULL){
	                
	                currentIdentifier->dataC = (char *) malloc(sizeof(char));
	                currentIdentifier->dataC = yylval.sVal;
                }
	            if(parseDebug){
			        fprintf(parseFile,"CONSTANT <- CHARACTER_CONSTANT \n\n");
			    }


	         }
	| FLOATING_CONSTANT {	        
	
	       
	            if(parseDebug){
			        fprintf(parseFile,"CONSTANT ->FLOATING_CONSTANT \n\n");
			    }
			    
	                
	               currentIdentifier->dataD = yylval.dVal;
	         }
	| ENUMERATION_CONSTANT {	        
	        
	            if(parseDebug){
			        fprintf(parseFile,"CONSTANT ->ENUMERATION_CONSTANT\n\n");
			    }
	         }
	;

string
	: STRING_LITERAL
	    {
	            if(currentIdentifier != NULL){
	                
	                currentIdentifier->dataC = (char *) malloc(sizeof(yylval.sVal));
	                currentIdentifier->dataC = yylval.sVal;
                }
	            if(parseDebug){
			        fprintf(parseFile,"string ->STRING_LITERAL \n\n");
			    }
        }
	;

identifier
	: IDENTIFIER { 
       
  int i;
  int n;
  treeNode * shadowCheck;
  
  //Cipher id name to numberical value
  for(i = 0, n = 0; i < sizeof($1) ; i++){
    n += $1[i];       
  }
  //We are in decleration mode  
	if(!lookUpMode){
    //Check and make sure variable is not already declared in the level        
    currentIdentifier = FindIdentifier(symbolTable->treePtr, n);
    if(currentIdentifier != NULL){
      yyerror("Already Declared ");
      return -1;
    }

    //Insert the id into the identifer tree
    symbolTable->treePtr = insertIdentifier(symbolTable->treePtr, n, flags);

    //Save the id name into the identifier tree 
    currentIdentifier = FindIdentifier(symbolTable->treePtr, n);
    currentIdentifier->name = $1;
    
    //Check and see if it shadows
    
    Shadows(n, symbolTable);


    //Reset flags for following declerations
    flags = reset;
  //We are in look up mode
  }else {
     //Locate the identifier
     currentIdentifier = FindIdentifier(symbolTable->treePtr, n);
     //If not found, search the entire table
     if(currentIdentifier == NULL){
        currentIdentifier = FindIDTableScope(n, symbolTable);
        if(currentIdentifier == NULL){
          yyerror("Variable Not Declared ");
        }
      } 
	 }      
      if(parseDebug){
        fprintf(parseFile,"identifier ->IDENTIFIER (%s)\n", $1);
	    }        
  }
	;
%%

//TODO Fix up this dood with fancier error messages
void yyerror(char *msg)
{
  
  int index, lineTracker = 0, lineCount = 0;
  
  //Go to appropriate line
  for(index = 0 ; index < rowNum - 1; index++){
   //Track our current location in the file
   while(buffer[lineTracker] != '\n'){         
      lineTracker++;
    }
    lineTracker++;
    lineCount++;
  }
  //Check that we still have file to parse
  if(lineCount < rowNum  ){
    //Print the line with the error
    while(buffer[lineTracker] != '\n'){
    
      //Be wary to avoid printing garbage
      if(lineTracker < bufferSize){
        printf("%c", buffer[lineTracker]);
     
      }
      lineTracker++;
    
    }
  }
  
  //Print the arrow and appropriate error message based on our state
  printf("\n");
  for(index = 0; index < column -(sizeof(yyget_text()) + 1); index++){
    printf(" ");
  }
  printf("^\n");
  if(!lookUpMode){
    printf( "error: expected ‘,’ or ‘;’ before %s\n", yyget_text());
  }else {
    printf( "error: expected ‘}’ or ‘)’");}
    printf("\t%s line %d and column: %d\n", msg, rowNum, column);
}


