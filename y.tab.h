/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    Add_assign = 258,
    Sub_assign = 259,
    Mul_assign = 260,
    Div_assign = 261,
    Increment = 262,
    Decrement = 263,
    OR = 264,
    AND = 265,
    NOT = 266,
    LE = 267,
    GE = 268,
    LT = 269,
    GT = 270,
    EE = 271,
    NE = 272,
    Alphabet = 273,
    class = 274,
    include = 275,
    Digit = 276,
    true_ = 277,
    false_ = 278,
    INT = 279,
    CHAR = 280,
    FLOAT = 281,
    LONG = 282,
    DOUBLE = 283,
    BOOLEAN = 284,
    shared = 285,
    WHILE = 286,
    FOR = 287,
    IF = 288,
    ELSE = 289,
    CONTINUE = 290,
    BREAK = 291,
    RETURN = 292,
    NEW = 293
  };
#endif
/* Tokens.  */
#define Add_assign 258
#define Sub_assign 259
#define Mul_assign 260
#define Div_assign 261
#define Increment 262
#define Decrement 263
#define OR 264
#define AND 265
#define NOT 266
#define LE 267
#define GE 268
#define LT 269
#define GT 270
#define EE 271
#define NE 272
#define Alphabet 273
#define class 274
#define include 275
#define Digit 276
#define true_ 277
#define false_ 278
#define INT 279
#define CHAR 280
#define FLOAT 281
#define LONG 282
#define DOUBLE 283
#define BOOLEAN 284
#define shared 285
#define WHILE 286
#define FOR 287
#define IF 288
#define ELSE 289
#define CONTINUE 290
#define BREAK 291
#define RETURN 292
#define NEW 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
