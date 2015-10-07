%{

#include "y.tab.h"



int rowNum = 1;
int tabSize = 4;
int column = 0;
int onDiscovery();
%}



character[a-z]
digit (-)?[0-9]


whiteSpace [ ]+
tab[\t]+
carriage[\n]
null[\0]

%%
{carriage}              {rowNum++; column = 0;}
{tab}                   {column += tabSize;}
{whiteSpace}            {column++;}




"auto"                  {yylval.token = "AUTO";  return -1;}
"break"                 {yylval.token = "BREAK"; return BREAK;}
"case"                  {yylval.token = "CASE"; return CASE;}
"char"                  {yylval.token = "CHAR"; return CHAR;}
"const"                 {yylval.token = "CONST"; return CONST;}
"continue"              {yylval.token = "DEFAULT"; return CONTINUE;}   
"default"               {yylval.token = "DEFAULT"; return DEFAULT;}
"do"                    {yylval.token = "DO"; return DO;}
"double"                {yylval.token = "DOUBLE"; return DOUBLE;}
"else"                  {yylval.token = "ELSE"; return ELSE;}
"enum"                  {yylval.token = "ENUM"; return ENUM;}
"extern"                {yylval.token = "EXTERN"; return EXTERN;}
"float"                 {yylval.token = "FLOAT"; return FLOAT;}
"for"                   {yylval.token = "FOR"; return FOR;}
"goto"                  {yylval.token = "GOTO"; return GOTO;}
"if"                    {yylval.token = "IF"; return IF;}
"int"                   {yylval.token = "INT"; return INT;}
"long"                  {yylval.token = "LONG"; return LONG;}
"register"              {yylval.token = "REGISTER"; return REGISTER;}
"return"                {yylval.token = "RETURN"; return RETURN;}
"short"                 {yylval.token = "SHORT"; return SHORT;}
"signed"                {yylval.token = "SIGNED"; return SIGNED;}
"sizeof"                {yylval.token = "SIZEOF"; return SIZEOF;}
"static"                {yylval.token = "STATIC"; return STATIC;}
"struct"                {yylval.token = "STRUCT"; return STRUCT;}
"switch"                {yylval.token = "SWITCH"; return SWITCH;}
"typedef"               {yylval.token = "TYPEDEF"; return TYPEDEF;}
"union"                 {yylval.token = "UNION"; return UNION;}
"unsigned"              {yylval.token = "UNSIGNED"; return UNSIGNED;}
"void"                  {yylval.token = "VOID"; return VOID;}
"volatile"              {yylval.token = "VOLATILE"; return VOLATILE;}
"while"                 {yylval.token = "WHILE"; return WHILE;}



{character}+            {yylval.token = "IDENTIFIER"; return IDENTIFIER;}

{digit}+                {yylval.token = "INTEGER"; column += yyleng; yylval.iVal = atoi(yytext);}
{digit}+"."{digit}*     {yylval.token = "FLOAT"; column += yyleng; yylval.fVal = atof(yytext);}


"("			            {yylval.token = "("; return('(');}
")"			            {yylval.token = ")"; return(')');}
";"                     {yylval.token = ";"; return ';';}
"{"			            {yylval.token = "{"; return('{');}
"}"			            {yylval.token = "}"; return('}');}
"["			            {yylval.token = "["; return('[');}
"]"			            {yylval.token = "]"; return(']');}
"+"			            {yylval.token = "+"; return('+');}
"-"			            {yylval.token = "-"; return('-');}
"="			            {yylval.token = "="; return('=');}
"*"			            {yylval.token = "*"; return('*');}
"&"			            {yylval.token = "&"; return('&');}
"!"			            {yylval.token = "!"; return('!');}
"~"			            {yylval.token = "~"; return('~');}
">"			            {yylval.token = ">"; return('>');}
"<"			            {yylval.token = "<"; return('<');}
","			            {yylval.token = ","; return(',');}
"?"			            {yylval.token = "?"; return('?');}
"^"			            {yylval.token = "^"; return('^');}
"|"			            {yylval.token = "|"; return('|');}
":"			            {yylval.token = ":"; return(':');}
"."			            {yylval.token = "."; return('.');}


.                       {    
                         printf("Diagnostic Report:\n");
                         printf( "%s is not a valid token. \n", yytext);
                         printf("Error at Row #:%i\n",rowNum);
                         printf("Error at Column #:%i\n",column); 
                         return -1;
                        } 


%%



