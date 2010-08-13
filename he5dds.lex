%{


#include <string.h>
#include <assert.h>

#ifndef YY_PROTO
#define YY_PROTO(proto) proto
#endif

  
#define YYSTYPE char *
#define YY_DECL int he5ddslex YY_PROTO(( void ))
#define YY_READ_BUF_SIZE 16384

#include "he5dds.tab.hh"

int yy_line_num = 1;
static int start_line;		/* used in quote and comment error handlers */

%}
    
%option noyywrap
%option prefix="he5dds"
%option outfile="lex.he5dds.cc"

%x quote
%x comment

GROUP             	GROUP
END_GROUP       	END_GROUP
OBJECT          	OBJECT
END_OBJECT      	END_OBJECT
END             	END
HE5_GCTP_GEO    	HE5_GCTP_GEO
DATA_TYPE       	DataType=[A-Z0-9_]*
PROJECTION      	Projection
GRID_STRUCTURE  	GridStructure
SWATH_STRUCTURE  	SwathStructure
GRID_NAME       	GridName
SWATH_NAME       	SwathName
DIMENSION_SIZE  	Size
DIMENSION_NAME  	DimensionName
DATA_FIELD_NAME		DataFieldName
GEO_FIELD_NAME		GeoFieldName
DIMENSION_LIST		DimList
XDIM                    XDim=
YDIM                    YDim=
PIXELREGISTRATION	PixelRegistration=
GRIDORIGIN			GridOrigin=
UPPERLEFTPT			UpperLeftPointMtrs=
LOWERRIGHTPT		LowerRightMtrs=
DEFAULT				DEFAULT
GRIDNUM				GRID_[1-9]+[0-9]*

INT	[-+]?[0-9]+

MANTISA ([0-9]+\.?[0-9]*)|([0-9]*\.?[0-9]+)
EXPONENT (E|e)[-+]?[0-9]+

FLOAT	[-+]?{MANTISA}{EXPONENT}?

STR 	[-+a-zA-Z0-9_./:%+\-\ ]+

NEVER   [^a-zA-Z0-9_/.+\-{}:;,%]

%%

{GROUP}	    	    	he5ddslval = yytext; return GROUP;
{END_GROUP}    	    	he5ddslval = yytext; return END_GROUP;
{OBJECT}    	        he5ddslval = yytext; return OBJECT;
{END_OBJECT}    	he5ddslval = yytext; return END_OBJECT;
{END}                   /* Ignore */
{INT}                   he5ddslval = yytext; return INT;
{FLOAT}                 he5ddslval = yytext; return FLOAT;
{PROJECTION}   	    	he5ddslval = yytext; return PROJECTION;
{DATA_TYPE}   	    	he5ddslval = yytext; return DATA_TYPE;
{GRID_STRUCTURE}    	he5ddslval = yytext; return GRID_STRUCTURE;
{SWATH_STRUCTURE}    	he5ddslval = yytext; return SWATH_STRUCTURE;
{HE5_GCTP_GEO} 	    	he5ddslval = yytext; return HE5_GCTP_GEO;
{XDIM}	    	    	he5ddslval = yytext; return XDIM;
{YDIM}	    	    	he5ddslval = yytext; return YDIM;
{PIXELREGISTRATION}	   	he5ddslval = yytext; return PIXELREGISTRATION;
{GRIDORIGIN}	       	he5ddslval = yytext; return GRIDORIGIN;
{UPPERLEFTPT}  	    	he5ddslval = yytext; return UPPERLEFTPT;
{LOWERRIGHTPT} 	    	he5ddslval = yytext; return LOWERRIGHTPT;
{DEFAULT} 	    	he5ddslval = yytext; return DEFAULT;
{GRIDNUM} 	    	he5ddslval = yytext; return GRIDNUM;

{GRID_NAME}           	he5ddslval = yytext; return GRID_NAME;
{SWATH_NAME}           	he5ddslval = yytext; return SWATH_NAME;
{DIMENSION_SIZE} 	he5ddslval = yytext; return DIMENSION_SIZE;
{DIMENSION_NAME} 	he5ddslval = yytext; return DIMENSION_NAME;
{DIMENSION_LIST} 	he5ddslval = yytext; return DIMENSION_LIST;
{DATA_FIELD_NAME} 	he5ddslval = yytext; return DATA_FIELD_NAME;
{GEO_FIELD_NAME} 	he5ddslval = yytext; return GEO_FIELD_NAME;
{STR}	    	    	he5ddslval = yytext; return STR;
"="                     return (int)*yytext;
"("                     return (int)*yytext;
")"                     return (int)*yytext;
","                     return (int)*yytext;
\"                      /* Ignore */
";"                     /* Ignore */

[ \t]+
\n	    	    	++yy_line_num;
<INITIAL><<EOF>>    	yy_init = 1; yy_line_num = 1; yyterminate();
<comment>[^"\n\\*]*	yymore();
<comment>[^"\n\\*]*\n	yymore(); ++yy_line_num;
<comment>\*[^/\n]       yymore();
<comment>\*\n           yymore(); ++yy_line_num;
<comment>\\.		yymore();
<comment><<EOF>>	{
                          char msg[256];
			  sprintf(msg,
				  "Unterminated comment (starts on line %d)\n",
				  start_line);
			  YY_FATAL_ERROR(msg);
                        }
<quote>[^"\n\\]*	yymore();
<quote>[^"\n\\]*\n	yymore(); ++yy_line_num;
<quote>\\.		yymore();
<quote>\"		{ 
    			  BEGIN(INITIAL); 

			  he5ddslval = yytext;

			  return STR;
                        }
<quote><<EOF>>		{
                          char msg[256];
			  sprintf(msg,
				  "Unterminated quote (starts on line %d)\n",
				  start_line);
			  YY_FATAL_ERROR(msg);
                        }

{NEVER}                 {
                          if (yytext) {	/* suppress msgs about `' chars */
                            fprintf(stderr, "Character '%c' (%d) is not", *yytext, *yytext);
                            fprintf(stderr, " allowed (except within");
			    fprintf(stderr, " quotes) and has been ignored\n");
			  }
			}
%%
