/****************************************************************************
  ZahlenZuString.cpp
  For more information see https://github.com/RePag-net/Core
*****************************************************************************/

/****************************************************************************
  The MIT License(MIT)

  Copyright(c) 2021 René Pagel

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this softwareand associated documentation files(the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions :

  The above copyright noticeand this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
******************************************************************************/

#include "HADT.h"
#include "ZahlZuString.h"

using namespace RePag::System;

//---------------------------------------------------------------------------
short sControlSchnittA = 0x1F72;
short sNullA = 0;
short sFunfA= 5;
short sMinusFunfA = -5;
short sTeilerA = 10;
//---------------------------------------------------------------------------
char* __vectorcall RePag::System::ULONGtoCHAR(char pcZahl[11], unsigned long ulZahl)
{
 unsigned char ucVorKommaStellen = 0, ucLange = 0; char c11VorKomma[11];

 __ULONGtoCHAR(c11VorKomma, ulZahl);
 while(c11VorKomma[ucVorKommaStellen++] == 48 && ucVorKommaStellen < 11);
 if(ucVorKommaStellen == 11) ucVorKommaStellen--;
 ucLange += 11 - ucVorKommaStellen;

 pcZahl[ucLange] = 0;

 ucVorKommaStellen = 9;
 while(ucLange--){ MemCopy(&pcZahl[ucLange], &c11VorKomma[ucVorKommaStellen--], 1); }

 return pcZahl;
}
//---------------------------------------------------------------------------
char* __vectorcall RePag::System::LONGtoCHAR(char pcZahl[12], long lZahl)
{
 unsigned char ucVorKommaStellen = 0, ucLange = 0; char c11VorKomma[11];

 __LONGtoCHAR(c11VorKomma, lZahl);
 while(c11VorKomma[ucVorKommaStellen++] == 48 && ucVorKommaStellen < 11);
 if(ucVorKommaStellen == 11) ucVorKommaStellen--;
 ucLange += 11 - ucVorKommaStellen;

 if(!c11VorKomma[10]) ucLange++;
 pcZahl[ucLange] = 0;

 ucVorKommaStellen = 9;
 if(!c11VorKomma[10]){
	 pcZahl[0] = 0x2d;
   while(--ucLange){ MemCopy(&pcZahl[ucLange], &c11VorKomma[ucVorKommaStellen--], 1); }
 }
 else{
   while(ucLange--){ MemCopy(&pcZahl[ucLange], &c11VorKomma[ucVorKommaStellen--], 1); }
 }

 return pcZahl;
}
//---------------------------------------------------------------------------
char* __vectorcall RePag::System::LONGLONGtoCHAR(char pcZahl[21], long long llZahl)
{
 unsigned char ucVorKommaStellen = 0, ucLange = 0; char c20VorKomma[20];

 __LONGLONGtoCHAR(c20VorKomma, llZahl);
 while(c20VorKomma[ucVorKommaStellen++] == 48 && ucVorKommaStellen < 20);
 if(ucVorKommaStellen == 20) ucVorKommaStellen--;
 ucLange += 20 - ucVorKommaStellen;

 if(!c20VorKomma[19]) ucLange++;
 pcZahl[ucLange] = 0;

 ucVorKommaStellen = 18;
 if(!c20VorKomma[19]){
	 pcZahl[0] = 0x2d;
   while(--ucLange){ MemCopy(&pcZahl[ucLange], &c20VorKomma[ucVorKommaStellen--], 1); }
 }
 else{
   while(ucLange--){ MemCopy(&pcZahl[ucLange], &c20VorKomma[ucVorKommaStellen--], 1); }
 }

 return pcZahl;
}
//---------------------------------------------------------------------------
char* __vectorcall RePag::System::DOUBLE_B10toCHAR(_Out_writes_z_(28) char pcZahl[28],
																		_In_ double dZahl, _In_ unsigned char ucStellen)
{
 short sExponent, sVorKomma; long long llNachKomma; char cVorKomma; char pc21NachKomma[21]; char pc11Exponent[11]; BYTE ucBytes = 0, ucLange;

 if(!dZahl){ BYTE ucNullen = ucStellen; 
	 cVorKomma = 0x30;
   pc11Exponent[0] = 0x30; pc11Exponent[1] = 0; 
   pc21NachKomma[ucNullen] = 0;
	 while(ucNullen--) pc21NachKomma[ucNullen] = 0x30;
 }
 else{
	 //__DOUBLE_B10toCHAR(sExponent, sVorKomma, llNachKomma, dZahl, ucStellen);
	 __DOUBLE_B10toCHAR(sExponent, sVorKomma, dZahl, llNachKomma, ucStellen);
   cVorKomma = sVorKomma + 0x30;
   LONGtoCHAR(pc11Exponent, sExponent);
   LONGLONGtoCHAR(pc21NachKomma, llNachKomma);
 }

 if(dZahl < 0){
	 pcZahl[0] = 45;
   MemCopy(&pcZahl[1], &cVorKomma, ++ucBytes);
   ucBytes++;
	 pcZahl[ucBytes++] = 44;
	 if(ucStellen > 0 && ucStellen < 16) ucLange = ucStellen - (BYTE)StrLength(pc21NachKomma);
 	 else ucLange = 16 - StrLength(pc21NachKomma);
	 while(ucLange--) pcZahl[ucBytes++] = 48;
	 ucLange = StrLength(pc21NachKomma);
   MemCopy(&pcZahl[ucBytes], pc21NachKomma, ucLange);
   ucBytes += ucLange;
   MemCopy(&pcZahl[ucBytes], "*10e", 4); ucBytes += 4;
	 ucLange = StrLength(pc11Exponent);
   MemCopy(&pcZahl[ucBytes], pc11Exponent, ucLange);
   ucBytes += ucLange;
	 pcZahl[ucBytes] = 0;
 }
 else{
   MemCopy(pcZahl, &cVorKomma, ++ucBytes);
	 pcZahl[ucBytes++] = 44;
	 if(ucStellen > 0 && ucStellen < 16) ucLange = ucStellen - StrLength(pc21NachKomma);
	 else ucLange = 16 - StrLength(pc21NachKomma);
	 while(ucLange--) pcZahl[ucBytes++] = 48;
	 ucLange = StrLength(pc21NachKomma);
   MemCopy(&pcZahl[ucBytes], pc21NachKomma, ucLange);
   ucBytes += ucLange;
   MemCopy(&pcZahl[ucBytes], "*10e", 4); ucBytes += 4;
	 ucLange = StrLength(pc11Exponent);
   MemCopy(&pcZahl[ucBytes], pc11Exponent, ucLange);
   ucBytes += ucLange;
	 pcZahl[ucBytes] = 0;
 }

 return pcZahl;
}
//---------------------------------------------------------------------------
char* __vectorcall RePag::System::FLOAT_B10toCHAR(_Out_writes_z_(20) char pcZahl[20], _In_ float fZahl, _In_ unsigned char ucStellen)
{
 short sExponent, sVorKomma; long lNachKomma; char cVorKomma; char pc11NachKomma[11]; char pc11Exponent[11]; BYTE ucBytes = 0, ucLange;

 if(!fZahl){ BYTE ucNullen = ucStellen; 
	 cVorKomma = 0x30;
   pc11Exponent[0] = 0x30; pc11Exponent[1] = 0; 
   pc11NachKomma[ucNullen] = 0;
	 while(ucNullen--) pc11NachKomma[ucNullen] = 0x30;
 }
 else{
	 __FLOAT_B10zuCHAR(sExponent, sVorKomma, fZahl, lNachKomma, ucStellen);
   cVorKomma = sVorKomma + 0x30;
   LONGtoCHAR(pc11Exponent, sExponent);
   ULONGtoCHAR(pc11NachKomma, lNachKomma);
 }

 if(fZahl < 0){
	 pcZahl[0] = 45;
   MemCopy(&pcZahl[1], &cVorKomma, ++ucBytes);
   ucBytes++;
	 pcZahl[ucBytes++] = 44;
	 if(ucStellen > 0 && ucStellen < 8) ucLange = ucStellen - StrLength(pc11NachKomma);
 	 else ucLange = 8 - StrLength(pc11NachKomma);
	 while(ucLange--) pcZahl[ucBytes++] = 48;
	 ucLange = StrLength(pc11NachKomma);
   MemCopy(&pcZahl[ucBytes], pc11NachKomma, ucLange);
   ucBytes += ucLange;
   MemCopy(&pcZahl[ucBytes], "*10e", 4); ucBytes += 4;
	 ucLange = StrLength(pc11Exponent);
   MemCopy(&pcZahl[ucBytes], pc11Exponent, ucLange);
   ucBytes += ucLange;
	 pcZahl[ucBytes] = 0;
 }
 else{
   MemCopy(pcZahl, &cVorKomma, ++ucBytes);
	 pcZahl[ucBytes++] = 44;
	 if(ucStellen > 0 && ucStellen < 8) ucLange = ucStellen - StrLength(pc11NachKomma);
	 else ucLange = 8 - StrLength(pc11NachKomma);
	 while(ucLange--) pcZahl[ucBytes++] = 48;
	 ucLange = StrLength(pc11NachKomma);
   MemCopy(&pcZahl[ucBytes], pc11NachKomma, ucLange);
   ucBytes += ucLange;
   MemCopy(&pcZahl[ucBytes], "*10e", 4); ucBytes += 4;
	 ucLange = StrLength(pc11Exponent);
   MemCopy(&pcZahl[ucBytes], pc11Exponent, ucLange);
   ucBytes += ucLange;
	 pcZahl[ucBytes] = 0;
 }

 return pcZahl;
}
//---------------------------------------------------------------------------
COStringA* __vectorcall RePag::System::Comma4toStringA(COStringA* pasString, COComma4* pk4Zahl, unsigned char ucStellen)
{
 char c20Zahl[20];
 *pasString = Comma4toCHAR(c20Zahl, pk4Zahl, ucStellen);
 return pasString;
}
//---------------------------------------------------------------------------
COStringA* __vectorcall RePag::System::Comma4_80toStringA(COStringA* pasString, COComma4_80* pk4gZahl, unsigned char ucStellen)
{
 char c32Zahl[32];
 *pasString = Comma4_80toCHAR(c32Zahl, pk4gZahl, ucStellen);
 return pasString;
}
//---------------------------------------------------------------------------
inline void __vectorcall __LONGtoCHAR(char pc11Zahl[11], long lZahl)
{
 unsigned char ucUbertrag;  char cStellen = 0;
 while(cStellen < 11) pc11Zahl[cStellen++] = 48;

 if(lZahl & (1 << 31)){
   for(BYTE ucBit = 0; ucBit < 31; ucBit++) lZahl = lZahl ^ (1 << ucBit);
	 pc11Zahl[9]++;
	 pc11Zahl[10] = 0;
 }

 for(unsigned char ucBit = 0; ucBit < 32; ucBit++){
   switch(ucBit){
      case 0  : if(lZahl & (1 << ucBit)){ pc11Zahl[9]++;} break;
      case 1  : if(lZahl & (1 << ucBit)){ pc11Zahl[9] += 2;} break;
      case 2  : if(lZahl & (1 << ucBit)){ pc11Zahl[9] += 4;} break;
      case 3  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if(ucUbertrag) pc11Zahl[8]++;
                } break;
      case 4  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                } break;
      case 5  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                } break;
      case 6  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if(ucUbertrag) pc11Zahl[7]++;
                } break;
      case 7  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                } break;
      case 8  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                } break;
      case 9  : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if(ucUbertrag) pc11Zahl[6]++;
                } break;
      case 10 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                } break;
      case 11 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 4 + ucUbertrag) > 57){ pc11Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 5; ucUbertrag = 0;}
                   else pc11Zahl[8] += 4;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                } break;
      case 12 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 9 + ucUbertrag) > 57){ pc11Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 0; ucUbertrag = 0;}
                   else pc11Zahl[8] += 9;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                } break;
      case 13 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 9 + ucUbertrag) > 57){ pc11Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else pc11Zahl[8] += 9;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[5]++;
                } break;
      case 14 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 8 + ucUbertrag) > 57){ pc11Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 9; ucUbertrag = 0;}
                   else pc11Zahl[8] += 8;
                   if((pc11Zahl[7] + 3 + ucUbertrag) > 57){ pc11Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 4; ucUbertrag = 0;}
                   else pc11Zahl[7] += 3;
                   if((pc11Zahl[6] + 6 + ucUbertrag) > 57){ pc11Zahl[6] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 1 + ucUbertrag) > 57){ pc11Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 1; ucUbertrag = 0;}
                } break;
      case 15 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if((pc11Zahl[7] + 7 + ucUbertrag) > 57){ pc11Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 8; ucUbertrag = 0;}
                   else pc11Zahl[7] += 7;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                } break;
      case 16 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if((pc11Zahl[6] + 5 + ucUbertrag) > 57){ pc11Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 6 + ucUbertrag) > 57){ pc11Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[4]++;
                } break;
      case 17 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 7 + ucUbertrag) > 57){ pc11Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 8; ucUbertrag = 0;}
                   else pc11Zahl[8] += 7;
                   if((pc11Zahl[7] + 0 + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                } break;
      case 18 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 4 + ucUbertrag) > 57){ pc11Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 5; ucUbertrag = 0;}
                   else pc11Zahl[8] += 4;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 6 + ucUbertrag) > 57){ pc11Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 2 + ucUbertrag) > 57){ pc11Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 2; ucUbertrag = 0;}
                } break;
      case 19 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 8 + ucUbertrag) > 57){ pc11Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 9; ucUbertrag = 0;}
                   else pc11Zahl[8] += 8;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 2 + ucUbertrag) > 57){ pc11Zahl[5] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 5 + ucUbertrag) > 57){ pc11Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[3]++;
                } break;
      case 20 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 7 + ucUbertrag) > 57){ pc11Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 8; ucUbertrag = 0;}
                   else pc11Zahl[8] += 7;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 4 + ucUbertrag) > 57){ pc11Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[4] + ucUbertrag) > 57){ pc11Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 1 + ucUbertrag) > 57){ pc11Zahl[3] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 1; ucUbertrag = 0;}
                } break;
      case 21 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 9 + ucUbertrag) > 57){ pc11Zahl[5] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   if((pc11Zahl[4] + ucUbertrag) > 57){ pc11Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 2 + ucUbertrag) > 57){ pc11Zahl[3] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 2; ucUbertrag = 0;}
                } break;
      case 22 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + ucUbertrag) > 57){ pc11Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 1; ucUbertrag = 0;}
                   else pc11Zahl[8] += 0;
                   if((pc11Zahl[7] + 3 + ucUbertrag) > 57){ pc11Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 4; ucUbertrag = 0;}
                   else pc11Zahl[7] += 3;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 9 + ucUbertrag) > 57){ pc11Zahl[5] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 4 + ucUbertrag) > 57){ pc11Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 4; ucUbertrag = 0;}
                } break;
      case 23 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + ucUbertrag) > 57){ pc11Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 1; ucUbertrag = 0;}
                   else pc11Zahl[8] += 0;
                   if((pc11Zahl[7] + 6 + ucUbertrag) > 57){ pc11Zahl[7] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 7; ucUbertrag = 0;}
                   else pc11Zahl[7] += 6;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 8 + ucUbertrag) > 57){ pc11Zahl[5] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 3 + ucUbertrag) > 57){ pc11Zahl[4] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 8 + ucUbertrag) > 57){ pc11Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[2]++;
                } break;
      case 24 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 7 + ucUbertrag) > 57){ pc11Zahl[5] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 7 + ucUbertrag) > 57){ pc11Zahl[4] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 6 + ucUbertrag) > 57){ pc11Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 1 + ucUbertrag) > 57){ pc11Zahl[2] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 1; ucUbertrag = 0;}
                } break;
      case 25 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                   if((pc11Zahl[7] + 4 + ucUbertrag) > 57){ pc11Zahl[7] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 5; ucUbertrag = 0;}
                   else pc11Zahl[7] += 4;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 5 + ucUbertrag) > 57){ pc11Zahl[5] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 5 + ucUbertrag) > 57){ pc11Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 3 + ucUbertrag) > 57){ pc11Zahl[3] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                } break;
      case 26 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if((pc11Zahl[7] + 8 + ucUbertrag) > 57){ pc11Zahl[7] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 9; ucUbertrag = 0;}
                   else pc11Zahl[7] += 8;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + ucUbertrag) > 57){ pc11Zahl[5] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 7 + ucUbertrag) > 57){ pc11Zahl[3] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 6 + ucUbertrag) > 57){ pc11Zahl[2] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[1]++;
                } break;
      case 27 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 7 + ucUbertrag) > 57){ pc11Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 8; ucUbertrag = 0;}
                   else pc11Zahl[7] += 7;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 1 + ucUbertrag) > 57){ pc11Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 2 + ucUbertrag) > 57){ pc11Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 4 + ucUbertrag) > 57){ pc11Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 1 + ucUbertrag) > 57){ pc11Zahl[1] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 1; ucUbertrag = 0;}
                } break;
      case 28 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 4 + ucUbertrag) > 57){ pc11Zahl[7] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 5; ucUbertrag = 0;}
                   else pc11Zahl[7] += 4;
                   if((pc11Zahl[6] + 5 + ucUbertrag) > 57){ pc11Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 4 + ucUbertrag) > 57){ pc11Zahl[4] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 8 + ucUbertrag) > 57){ pc11Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 6 + ucUbertrag) > 57){ pc11Zahl[2] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 2 + ucUbertrag) > 57){ pc11Zahl[1] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 2; ucUbertrag = 0;}
                } break;
      case 29 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 9 + ucUbertrag) > 57){ pc11Zahl[7] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 0; ucUbertrag = 0;}
                   else pc11Zahl[7] += 9;
                   if((pc11Zahl[6] + ucUbertrag) > 57){ pc11Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 7 + ucUbertrag) > 57){ pc11Zahl[5] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 8 + ucUbertrag) > 57){ pc11Zahl[4] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 6 + ucUbertrag) > 57){ pc11Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 5 + ucUbertrag) > 57){ pc11Zahl[1] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[0]++;
                } break;
      case 30 : if(lZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 8 + ucUbertrag) > 57){ pc11Zahl[7] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 9; ucUbertrag = 0;}
                   else pc11Zahl[7] += 8;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 4 + ucUbertrag) > 57){ pc11Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 7 + ucUbertrag) > 57){ pc11Zahl[4] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 3 + ucUbertrag) > 57){ pc11Zahl[3] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 7 + ucUbertrag) > 57){ pc11Zahl[2] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[1] + ucUbertrag) > 57){ pc11Zahl[1] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[0] + 1 + ucUbertrag) > 57){ pc11Zahl[0] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[0] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[0] += 1; ucUbertrag = 0;}
                } break;
   }
 }
}
//---------------------------------------------------------------------------
inline void __vectorcall __LONGLONGtoCHAR(char pc20Zahl[20], long long llZahl)
{
 unsigned char ucBit, ucUbertrag;  char cStellen = 0;
 while(cStellen < 20) pc20Zahl[cStellen++] = 48;

 if(llZahl < 0){
   for(ucBit = 0; ucBit < 31; ucBit++) llZahl = llZahl ^ (1 << ucBit);
	 pc20Zahl[18]++;
   pc20Zahl[19] = 0;
 }

 for(ucBit = 0; ucBit < 31; ucBit++){
   switch(ucBit){
      case 0  : if(llZahl & (1 << ucBit)){ pc20Zahl[18]++;} break;
      case 1  : if(llZahl & (1 << ucBit)){ pc20Zahl[18] += 2;} break;
      case 2  : if(llZahl & (1 << ucBit)){ pc20Zahl[18] += 4;} break;
      case 3  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if(ucUbertrag) pc20Zahl[17]++;
                } break;
      case 4  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
                   else pc20Zahl[17] += 1;
                } break;
      case 5  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
                   else pc20Zahl[17] += 3;
                } break;
      case 6  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
                   else pc20Zahl[17] += 6;
                   if(ucUbertrag) pc20Zahl[16]++;
                } break;
      case 7  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
                   else pc20Zahl[17] += 2;
                   if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
                   else pc20Zahl[16] += 1;
                } break;
      case 8  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
                   else pc20Zahl[17] += 5;
                   if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
                   else pc20Zahl[16] += 2;
                } break;
      case 9  : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
                   else pc20Zahl[17] += 1;
                   if((pc20Zahl[16] + 5 + ucUbertrag) > 57){ pc20Zahl[16] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 6; ucUbertrag = 0;}
                   else pc20Zahl[16] += 5;
                   if(ucUbertrag) pc20Zahl[15]++;
                } break;
      case 10 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
                   else pc20Zahl[17] += 2;
                   if((pc20Zahl[16] + ucUbertrag) > 57){ pc20Zahl[16] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 1; ucUbertrag = 0;}
                   else pc20Zahl[16] += 0;
                   if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
                } break;
      case 11 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
                   else pc20Zahl[17] += 4;
                   if((pc20Zahl[16] + ucUbertrag) > 57){ pc20Zahl[16] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 1; ucUbertrag = 0;}
                   else pc20Zahl[16] += 0;
                   if((pc20Zahl[15] + 2 + ucUbertrag) > 57){ pc20Zahl[15] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 2; ucUbertrag = 0;}
                } break;
      case 12 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 0; ucUbertrag = 0;}
                   else pc20Zahl[17] += 9;
                   if((pc20Zahl[16] + ucUbertrag) > 57){ pc20Zahl[16] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 1; ucUbertrag = 0;}
                   else pc20Zahl[16] += 0;
                   if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
                } break;
      case 13 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else pc20Zahl[17] += 9;
                   if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
                   else pc20Zahl[16] += 1;
                   if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[14]++;
                } break;
      case 14 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
                   else pc20Zahl[17] += 8;
                   if((pc20Zahl[16] + 3 + ucUbertrag) > 57){ pc20Zahl[16] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 4; ucUbertrag = 0;}
                   else pc20Zahl[16] += 3;
                   if((pc20Zahl[15] + 6 + ucUbertrag) > 57){ pc20Zahl[15] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 6; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
                } break;
      case 15 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
                   else pc20Zahl[17] += 6;
                   if((pc20Zahl[16] + 7 + ucUbertrag) > 57){ pc20Zahl[16] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 8; ucUbertrag = 0;}
                   else pc20Zahl[16] += 7;
                   if((pc20Zahl[15] + 2 + ucUbertrag) > 57){ pc20Zahl[15] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 2; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 3 + ucUbertrag) > 57){ pc20Zahl[14] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 3; ucUbertrag = 0;}
                } break;
      case 16 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
                   else pc20Zahl[17] += 3;
                   if((pc20Zahl[16] + 5 + ucUbertrag) > 57){ pc20Zahl[16] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 6; ucUbertrag = 0;}
                   else pc20Zahl[16] += 5;
                   if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 6 + ucUbertrag) > 57){ pc20Zahl[14] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[13]++;
                } break;
      case 17 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
                   else pc20Zahl[17] += 7;
                   if((pc20Zahl[16] + 0 + ucUbertrag) > 57){ pc20Zahl[16] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 1; ucUbertrag = 0;}
                   else pc20Zahl[16] += 0;
                   if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 3 + ucUbertrag) > 57){ pc20Zahl[14] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 1 + ucUbertrag) > 57){ pc20Zahl[13] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 1; ucUbertrag = 0;}
                } break;
      case 18 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
                   else pc20Zahl[17] += 4;
                   if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
                   else pc20Zahl[16] += 1;
                   if((pc20Zahl[15] + 2 + ucUbertrag) > 57){ pc20Zahl[15] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 2; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 6 + ucUbertrag) > 57){ pc20Zahl[14] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 6; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 2 + ucUbertrag) > 57){ pc20Zahl[13] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 2; ucUbertrag = 0;}
                } break;
      case 19 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
                   else pc20Zahl[17] += 8;
                   if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
                   else pc20Zahl[16] += 2;
                   if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 5 + ucUbertrag) > 57){ pc20Zahl[13] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[12]++;
                } break;
      case 20 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
                   else pc20Zahl[17] += 7;
                   if((pc20Zahl[16] + 5 + ucUbertrag) > 57){ pc20Zahl[16] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 6; ucUbertrag = 0;}
                   else pc20Zahl[16] += 5;
                   if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[13] + ucUbertrag) > 57){ pc20Zahl[13] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 1; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 0; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 1 + ucUbertrag) > 57){ pc20Zahl[12] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 1; ucUbertrag = 0;}
                } break;
      case 21 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
                   else pc20Zahl[17] += 5;
                   if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
                   else pc20Zahl[16] += 1;
                   if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 9 + ucUbertrag) > 57){ pc20Zahl[14] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 0; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 9; ucUbertrag = 0;}
                   if((pc20Zahl[13] + ucUbertrag) > 57){ pc20Zahl[13] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 1; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 0; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 2 + ucUbertrag) > 57){ pc20Zahl[12] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 2; ucUbertrag = 0;}
                } break;
      case 22 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + ucUbertrag) > 57){ pc20Zahl[17] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 1; ucUbertrag = 0;}
                   else pc20Zahl[17] += 0;
                   if((pc20Zahl[16] + 3 + ucUbertrag) > 57){ pc20Zahl[16] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 4; ucUbertrag = 0;}
                   else pc20Zahl[16] += 3;
                   if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 9 + ucUbertrag) > 57){ pc20Zahl[14] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 0; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 9; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 1 + ucUbertrag) > 57){ pc20Zahl[13] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 1; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 4 + ucUbertrag) > 57){ pc20Zahl[12] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 4; ucUbertrag = 0;}
                } break;
      case 23 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + ucUbertrag) > 57){ pc20Zahl[17] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 1; ucUbertrag = 0;}
                   else pc20Zahl[17] += 0;
                   if((pc20Zahl[16] + 6 + ucUbertrag) > 57){ pc20Zahl[16] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 7; ucUbertrag = 0;}
                   else pc20Zahl[16] += 6;
                   if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 3 + ucUbertrag) > 57){ pc20Zahl[13] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 8 + ucUbertrag) > 57){ pc20Zahl[12] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[11]++;
                } break;
      case 24 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
                   else pc20Zahl[17] += 1;
                   if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
                   else pc20Zahl[16] += 2;
                   if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 7 + ucUbertrag) > 57){ pc20Zahl[14] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
                } break;
      case 25 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
                   else pc20Zahl[17] += 3;
                   if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
                   else pc20Zahl[16] += 4;
                   if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 5 + ucUbertrag) > 57){ pc20Zahl[14] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 5; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 5 + ucUbertrag) > 57){ pc20Zahl[13] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 5; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 3 + ucUbertrag) > 57){ pc20Zahl[11] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 3; ucUbertrag = 0;}
                } break;
      case 26 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
                   else pc20Zahl[17] += 6;
                   if((pc20Zahl[16] + 8 + ucUbertrag) > 57){ pc20Zahl[16] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 9; ucUbertrag = 0;}
                   else pc20Zahl[16] += 8;
                   if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[14] + ucUbertrag) > 57){ pc20Zahl[14] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 1; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 0; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 1 + ucUbertrag) > 57){ pc20Zahl[13] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 1; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 6 + ucUbertrag) > 57){ pc20Zahl[11] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[10]++;
                } break;
      case 27 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 8;}
                   if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
                   else pc20Zahl[17] += 2;
                   if((pc20Zahl[16] + 7 + ucUbertrag) > 57){ pc20Zahl[16] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 8; ucUbertrag = 0;}
                   else pc20Zahl[16] += 7;
                   if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 2 + ucUbertrag) > 57){ pc20Zahl[13] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 2; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 4 + ucUbertrag) > 57){ pc20Zahl[12] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 3 + ucUbertrag) > 57){ pc20Zahl[11] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[10] + 1 + ucUbertrag) > 57){ pc20Zahl[10] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[10] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[10] += 1; ucUbertrag = 0;}
                } break;
      case 28 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 6;}
                   if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
                   else pc20Zahl[17] += 5;
                   if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
                   else pc20Zahl[16] += 4;
                   if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 3 + ucUbertrag) > 57){ pc20Zahl[14] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 8 + ucUbertrag) > 57){ pc20Zahl[12] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 6 + ucUbertrag) > 57){ pc20Zahl[11] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 6; ucUbertrag = 0;}
                   if((pc20Zahl[10] + 2 + ucUbertrag) > 57){ pc20Zahl[10] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[10] += 3; ucUbertrag = 0;}
                   else{ pc20Zahl[10] += 2; ucUbertrag = 0;}
                } break;
      case 29 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 2;}
                   if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
                   else pc20Zahl[17] += 1;
                   if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
                   else pc20Zahl[16] += 9;
                   if((pc20Zahl[15] + ucUbertrag) > 57){ pc20Zahl[15] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 1; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 0; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 7 + ucUbertrag) > 57){ pc20Zahl[14] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 3 + ucUbertrag) > 57){ pc20Zahl[11] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[10] + 5 + ucUbertrag) > 57){ pc20Zahl[10] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[10] += 6; ucUbertrag = 0;}
                   else{ pc20Zahl[10] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc20Zahl[9]++;
                } break;
      case 30 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
                   else{ pc20Zahl[18] += 4;}
                   if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
                   else pc20Zahl[17] += 2;
                   if((pc20Zahl[16] + 8 + ucUbertrag) > 57){ pc20Zahl[16] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[16] += 9; ucUbertrag = 0;}
                   else pc20Zahl[16] += 8;
                   if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
                   if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
                   else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
                   if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
                   else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
                   if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
                   else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
                   if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
                   else{ pc20Zahl[10] += 0; ucUbertrag = 0;}
                   if((pc20Zahl[9] + 1 + ucUbertrag) > 57){ pc20Zahl[9] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc20Zahl[9] += 2; ucUbertrag = 0;}
                   else{ pc20Zahl[9] += 1; ucUbertrag = 0;}
                } break;
   }
 }

 llZahl >>= 31;
 if(llZahl < 0){ for(ucBit = 0; ucBit < 32; ucBit++) llZahl = llZahl ^ (1 << ucBit);}

 for(ucBit = 0; ucBit < 32; ucBit++){
	 switch(ucBit){
			case 0 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
									 else pc20Zahl[17] += 4;
									 if((pc20Zahl[16] + 6 + ucUbertrag) > 57){ pc20Zahl[16] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 7; ucUbertrag = 0;}
									 else pc20Zahl[16] += 6;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 4 + ucUbertrag) > 57){ pc20Zahl[11] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 1 + ucUbertrag) > 57){ pc20Zahl[10] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 2 + ucUbertrag) > 57){ pc20Zahl[9] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 2; ucUbertrag = 0;}
								} break;
			case 1 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 0; ucUbertrag = 0;}
									 else pc20Zahl[17] += 9;
									 if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
									 else pc20Zahl[16] += 2;
									 if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 6 + ucUbertrag) > 57){ pc20Zahl[14] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 4 + ucUbertrag) > 57){ pc20Zahl[12] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 9 + ucUbertrag) > 57){ pc20Zahl[11] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 2 + ucUbertrag) > 57){ pc20Zahl[10] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
								} break;
			case 2 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 0; ucUbertrag = 0;}
									 else pc20Zahl[17] += 9;
									 if((pc20Zahl[16] + 5 + ucUbertrag) > 57){ pc20Zahl[16] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 6; ucUbertrag = 0;}
									 else pc20Zahl[16] += 5;
									 if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 3 + ucUbertrag) > 57){ pc20Zahl[14] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 9 + ucUbertrag) > 57){ pc20Zahl[12] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 8 + ucUbertrag) > 57){ pc20Zahl[11] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 5 + ucUbertrag) > 57){ pc20Zahl[10] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[8]++;
								} break;
			case 3 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
									 else pc20Zahl[17] += 8;
									 if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
									 else pc20Zahl[16] += 1;
									 if((pc20Zahl[15] + 9 + ucUbertrag) > 57){ pc20Zahl[15] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 6 + ucUbertrag) > 57){ pc20Zahl[14] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 9 + ucUbertrag) > 57){ pc20Zahl[12] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 1 + ucUbertrag) > 57){ pc20Zahl[10] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 7 + ucUbertrag) > 57){ pc20Zahl[9] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 1 + ucUbertrag) > 57){ pc20Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 1; ucUbertrag = 0;}
								} break;
			case 4 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
									 else pc20Zahl[17] += 6;
									 if((pc20Zahl[16] + 3 + ucUbertrag) > 57){ pc20Zahl[16] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 4; ucUbertrag = 0;}
									 else pc20Zahl[16] += 3;
									 if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 3 + ucUbertrag) > 57){ pc20Zahl[14] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 9 + ucUbertrag) > 57){ pc20Zahl[12] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 5 + ucUbertrag) > 57){ pc20Zahl[11] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 3 + ucUbertrag) > 57){ pc20Zahl[10] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 3 + ucUbertrag) > 57){ pc20Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 3; ucUbertrag = 0;}
								} break;
			case 5 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
									 else pc20Zahl[17] += 3;
									 if((pc20Zahl[16] + 7 + ucUbertrag) > 57){ pc20Zahl[16] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 8; ucUbertrag = 0;}
									 else pc20Zahl[16] += 7;
									 if((pc20Zahl[15] + 6 + ucUbertrag) > 57){ pc20Zahl[15] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 7 + ucUbertrag) > 57){ pc20Zahl[14] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 9 + ucUbertrag) > 57){ pc20Zahl[12] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 7 + ucUbertrag) > 57){ pc20Zahl[10] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 6 + ucUbertrag) > 57){ pc20Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 6; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[7]++;
								} break;
			case 6 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
									 else pc20Zahl[17] += 7;
									 if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
									 else pc20Zahl[16] += 4;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 5 + ucUbertrag) > 57){ pc20Zahl[14] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 8 + ucUbertrag) > 57){ pc20Zahl[12] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 3 + ucUbertrag) > 57){ pc20Zahl[11] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 4 + ucUbertrag) > 57){ pc20Zahl[10] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 7 + ucUbertrag) > 57){ pc20Zahl[9] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 3 + ucUbertrag) > 57){ pc20Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 1 + ucUbertrag) > 57){ pc20Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 1; ucUbertrag = 0;}
								} break;
			case 7 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
									 else pc20Zahl[17] += 4;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 6 + ucUbertrag) > 57){ pc20Zahl[15] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[14] + ucUbertrag) > 57){ pc20Zahl[14] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 1; ucUbertrag = 0;}
									 else{ ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 8 + ucUbertrag) > 57){ pc20Zahl[10] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 7 + ucUbertrag) > 57){ pc20Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 2 + ucUbertrag) > 57){ pc20Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 2; ucUbertrag = 0;}
								} break;
			case 8 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
									 else pc20Zahl[17] += 8;
									 if((pc20Zahl[16] + 8 + ucUbertrag) > 57){ pc20Zahl[16] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 9; ucUbertrag = 0;}
									 else pc20Zahl[16] += 8;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 5 + ucUbertrag) > 57){ pc20Zahl[12] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 5 + ucUbertrag) > 57){ pc20Zahl[11] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 7 + ucUbertrag) > 57){ pc20Zahl[10] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 4 + ucUbertrag) > 57){ pc20Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 5 + ucUbertrag) > 57){ pc20Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[6]++;
								} break;
			case 9 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
									 else pc20Zahl[17] += 7;
									 if((pc20Zahl[16] + 7 + ucUbertrag) > 57){ pc20Zahl[16] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 8; ucUbertrag = 0;}
									 else pc20Zahl[16] += 7;
									 if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 6 + ucUbertrag) > 57){ pc20Zahl[13] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 1 + ucUbertrag) > 57){ pc20Zahl[12] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 5 + ucUbertrag) > 57){ pc20Zahl[10] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + ucUbertrag) > 57){ pc20Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[6] + 1 + ucUbertrag) > 57){ pc20Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 1; ucUbertrag = 0;}
								} break;
			case 10 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
									 else pc20Zahl[17] += 5;
									 if((pc20Zahl[16] + 5 + ucUbertrag) > 57){ pc20Zahl[16] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 6; ucUbertrag = 0;}
									 else pc20Zahl[16] += 5;
									 if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 5 + ucUbertrag) > 57){ pc20Zahl[14] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 2 + ucUbertrag) > 57){ pc20Zahl[13] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 2 + ucUbertrag) > 57){ pc20Zahl[11] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 1 + ucUbertrag) > 57){ pc20Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 2 + ucUbertrag) > 57){ pc20Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 2; ucUbertrag = 0;}
								} break;
			case 11 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + ucUbertrag) > 57){ pc20Zahl[17] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 1; ucUbertrag = 0;}
									 else pc20Zahl[17] += 0;
									 if((pc20Zahl[16] + 1 + ucUbertrag) > 57){ pc20Zahl[16] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 2; ucUbertrag = 0;}
									 else pc20Zahl[16] += 1;
									 if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 5 + ucUbertrag) > 57){ pc20Zahl[13] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 4 + ucUbertrag) > 57){ pc20Zahl[11] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 3 + ucUbertrag) > 57){ pc20Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 4 + ucUbertrag) > 57){ pc20Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 4; ucUbertrag = 0;}
								} break;
			case 12 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + ucUbertrag) > 57){ pc20Zahl[17] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 1; ucUbertrag = 0;}
									 else pc20Zahl[17] += 0;
									 if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
									 else pc20Zahl[16] += 2;
									 if((pc20Zahl[15] + 2 + ucUbertrag) > 57){ pc20Zahl[15] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[13] + ucUbertrag) > 57){ pc20Zahl[13] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 9 + ucUbertrag) > 57){ pc20Zahl[11] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 6 + ucUbertrag) > 57){ pc20Zahl[9] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 7 + ucUbertrag) > 57){ pc20Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 8 + ucUbertrag) > 57){ pc20Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 8; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[5]++;
								} break;
			case 13 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
									 else pc20Zahl[17] += 1;
									 if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
									 else pc20Zahl[16] += 4;
									 if((pc20Zahl[15] + 4 + ucUbertrag) > 57){ pc20Zahl[15] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[13] + ucUbertrag) > 57){ pc20Zahl[13] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 8 + ucUbertrag) > 57){ pc20Zahl[11] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 1 + ucUbertrag) > 57){ pc20Zahl[10] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 2 + ucUbertrag) > 57){ pc20Zahl[9] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 5 + ucUbertrag) > 57){ pc20Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 7 + ucUbertrag) > 57){ pc20Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 1 + ucUbertrag) > 57){ pc20Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 1; ucUbertrag = 0;}
								} break;
			case 14 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
									 else pc20Zahl[17] += 3;
									 if((pc20Zahl[16] + 8 + ucUbertrag) > 57){ pc20Zahl[16] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 9; ucUbertrag = 0;}
									 else pc20Zahl[16] += 8;
									 if((pc20Zahl[15] + 8 + ucUbertrag) > 57){ pc20Zahl[15] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[13] + ucUbertrag) > 57){ pc20Zahl[13] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[12] + 2 + ucUbertrag) > 57){ pc20Zahl[12] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 3 + ucUbertrag) > 57){ pc20Zahl[10] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 8 + ucUbertrag) > 57){ pc20Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 1 + ucUbertrag) > 57){ pc20Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 5 + ucUbertrag) > 57){ pc20Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 3 + ucUbertrag) > 57){ pc20Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 3; ucUbertrag = 0;}
								} break;
			case 15 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
									 else pc20Zahl[17] += 6;
									 if((pc20Zahl[16] + 6 + ucUbertrag) > 57){ pc20Zahl[16] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 7; ucUbertrag = 0;}
									 else pc20Zahl[16] += 6;
									 if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 7 + ucUbertrag) > 57){ pc20Zahl[14] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 1 + ucUbertrag) > 57){ pc20Zahl[13] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 4 + ucUbertrag) > 57){ pc20Zahl[12] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 4 + ucUbertrag) > 57){ pc20Zahl[11] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 7 + ucUbertrag) > 57){ pc20Zahl[10] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 6 + ucUbertrag) > 57){ pc20Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 3 + ucUbertrag) > 57){ pc20Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[6] + ucUbertrag) > 57){ pc20Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[5] + 7 + ucUbertrag) > 57){ pc20Zahl[5] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 7; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[4]++;
								} break;
			case 16 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
									 else pc20Zahl[17] += 2;
									 if((pc20Zahl[16] + 3 + ucUbertrag) > 57){ pc20Zahl[16] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 4; ucUbertrag = 0;}
									 else pc20Zahl[16] += 3;
									 if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 5 + ucUbertrag) > 57){ pc20Zahl[14] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 3 + ucUbertrag) > 57){ pc20Zahl[13] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 8 + ucUbertrag) > 57){ pc20Zahl[12] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 8 + ucUbertrag) > 57){ pc20Zahl[11] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 4 + ucUbertrag) > 57){ pc20Zahl[10] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 7 + ucUbertrag) > 57){ pc20Zahl[9] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 3 + ucUbertrag) > 57){ pc20Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 7 + ucUbertrag) > 57){ pc20Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[6] + ucUbertrag) > 57){ pc20Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[5] + 4 + ucUbertrag) > 57){ pc20Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 1 + ucUbertrag) > 57){ pc20Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 1; ucUbertrag = 0;}
								} break;
			case 17 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
									 else pc20Zahl[17] += 5;
									 if((pc20Zahl[16] + 6 + ucUbertrag) > 57){ pc20Zahl[16] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 7; ucUbertrag = 0;}
									 else pc20Zahl[16] += 6;
									 if((pc20Zahl[15] + ucUbertrag) > 57){ pc20Zahl[15] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 9 + ucUbertrag) > 57){ pc20Zahl[10] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 7 + ucUbertrag) > 57){ pc20Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 4 + ucUbertrag) > 57){ pc20Zahl[7] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 1 + ucUbertrag) > 57){ pc20Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 8 + ucUbertrag) > 57){ pc20Zahl[5] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 2 + ucUbertrag) > 57){ pc20Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 2; ucUbertrag = 0;}
								} break;
			case 18 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 1 + ucUbertrag) > 57){ pc20Zahl[17] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 2; ucUbertrag = 0;}
									 else pc20Zahl[17] += 1;
									 if((pc20Zahl[16] + 3 + ucUbertrag) > 57){ pc20Zahl[16] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 4; ucUbertrag = 0;}
									 else pc20Zahl[16] += 3;
									 if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 5 + ucUbertrag) > 57){ pc20Zahl[11] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 9 + ucUbertrag) > 57){ pc20Zahl[10] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 4 + ucUbertrag) > 57){ pc20Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 9 + ucUbertrag) > 57){ pc20Zahl[7] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 2 + ucUbertrag) > 57){ pc20Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 6 + ucUbertrag) > 57){ pc20Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 5 + ucUbertrag) > 57){ pc20Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 5; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[3]++;
								} break;
			case 19 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 2 + ucUbertrag) > 57){ pc20Zahl[17] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 3; ucUbertrag = 0;}
									 else pc20Zahl[17] += 2;
									 if((pc20Zahl[16] + 6 + ucUbertrag) > 57){ pc20Zahl[16] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 7; ucUbertrag = 0;}
									 else pc20Zahl[16] += 6;
									 if((pc20Zahl[15] + 2 + ucUbertrag) > 57){ pc20Zahl[15] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[11] + ucUbertrag) > 57){ pc20Zahl[11] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[10] + 9 + ucUbertrag) > 57){ pc20Zahl[10] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 8 + ucUbertrag) > 57){ pc20Zahl[7] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 5 + ucUbertrag) > 57){ pc20Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 2 + ucUbertrag) > 57){ pc20Zahl[5] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 1 + ucUbertrag) > 57){ pc20Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 1 + ucUbertrag) > 57){ pc20Zahl[3] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 1; ucUbertrag = 0;}
								} break;
			case 20 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
									 else pc20Zahl[17] += 4;
									 if((pc20Zahl[16] + 2 + ucUbertrag) > 57){ pc20Zahl[16] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 3; ucUbertrag = 0;}
									 else pc20Zahl[16] += 2;
									 if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 6 + ucUbertrag) > 57){ pc20Zahl[13] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 8 + ucUbertrag) > 57){ pc20Zahl[10] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 7 + ucUbertrag) > 57){ pc20Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 1 + ucUbertrag) > 57){ pc20Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 5 + ucUbertrag) > 57){ pc20Zahl[5] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 2 + ucUbertrag) > 57){ pc20Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 2 + ucUbertrag) > 57){ pc20Zahl[3] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 2; ucUbertrag = 0;}
								} break;
			case 21 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 0; ucUbertrag = 0;}
									 else pc20Zahl[17] += 9;
									 if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
									 else pc20Zahl[16] += 4;
									 if((pc20Zahl[15] + ucUbertrag) > 57){ pc20Zahl[15] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[14] + 7 + ucUbertrag) > 57){ pc20Zahl[14] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 3 + ucUbertrag) > 57){ pc20Zahl[13] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 2 + ucUbertrag) > 57){ pc20Zahl[11] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 6 + ucUbertrag) > 57){ pc20Zahl[10] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 5 + ucUbertrag) > 57){ pc20Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 3 + ucUbertrag) > 57){ pc20Zahl[6] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[5] + ucUbertrag) > 57){ pc20Zahl[5] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[4] + 5 + ucUbertrag) > 57){ pc20Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 4 + ucUbertrag) > 57){ pc20Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 4; ucUbertrag = 0;}
								} break;
			case 22 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 9 + ucUbertrag) > 57){ pc20Zahl[17] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 0; ucUbertrag = 0;}
									 else pc20Zahl[17] += 9;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + ucUbertrag) > 57){ pc20Zahl[15] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 4 + ucUbertrag) > 57){ pc20Zahl[12] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 5 + ucUbertrag) > 57){ pc20Zahl[11] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 2 + ucUbertrag) > 57){ pc20Zahl[10] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 1 + ucUbertrag) > 57){ pc20Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 7 + ucUbertrag) > 57){ pc20Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[5] + ucUbertrag) > 57){ pc20Zahl[5] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[4] + ucUbertrag) > 57){ pc20Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[3] + 9 + ucUbertrag) > 57){ pc20Zahl[3] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 9; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[2]++;
								} break;
			case 23 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
									 else pc20Zahl[17] += 8;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 9 + ucUbertrag) > 57){ pc20Zahl[12] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[11] + ucUbertrag) > 57){ pc20Zahl[11] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[10] + 5 + ucUbertrag) > 57){ pc20Zahl[10] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 3 + ucUbertrag) > 57){ pc20Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 4 + ucUbertrag) > 57){ pc20Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 1 + ucUbertrag) > 57){ pc20Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[4] + ucUbertrag) > 57){ pc20Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[3] + 8 + ucUbertrag) > 57){ pc20Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 1 + ucUbertrag) > 57){ pc20Zahl[2] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 1; ucUbertrag = 0;}
								} break;
			case 24 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 6 + ucUbertrag) > 57){ pc20Zahl[17] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 7; ucUbertrag = 0;}
									 else pc20Zahl[17] += 6;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 6 + ucUbertrag) > 57){ pc20Zahl[14] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 8 + ucUbertrag) > 57){ pc20Zahl[12] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 7 + ucUbertrag) > 57){ pc20Zahl[9] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 7 + ucUbertrag) > 57){ pc20Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 8 + ucUbertrag) > 57){ pc20Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 2 + ucUbertrag) > 57){ pc20Zahl[5] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[4] + ucUbertrag) > 57){ pc20Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[3] + 6 + ucUbertrag) > 57){ pc20Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 3 + ucUbertrag) > 57){ pc20Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 3; ucUbertrag = 0;}
								} break;
			case 25 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 3 + ucUbertrag) > 57){ pc20Zahl[17] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 4; ucUbertrag = 0;}
									 else pc20Zahl[17] += 3;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 9 + ucUbertrag) > 57){ pc20Zahl[13] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 3 + ucUbertrag) > 57){ pc20Zahl[11] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 9 + ucUbertrag) > 57){ pc20Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 5 + ucUbertrag) > 57){ pc20Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 7 + ucUbertrag) > 57){ pc20Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 5 + ucUbertrag) > 57){ pc20Zahl[5] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[4] + ucUbertrag) > 57){ pc20Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[3] + 2 + ucUbertrag) > 57){ pc20Zahl[3] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 7 + ucUbertrag) > 57){ pc20Zahl[2] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 7; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[1]++;
								} break;
			case 26 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
									 else pc20Zahl[17] += 7;
									 if((pc20Zahl[16] + 8 + ucUbertrag) > 57){ pc20Zahl[16] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 9; ucUbertrag = 0;}
									 else pc20Zahl[16] += 8;
									 if((pc20Zahl[15] + 5 + ucUbertrag) > 57){ pc20Zahl[15] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 5 + ucUbertrag) > 57){ pc20Zahl[14] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 5 + ucUbertrag) > 57){ pc20Zahl[12] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 7 + ucUbertrag) > 57){ pc20Zahl[11] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[10] + ucUbertrag) > 57){ pc20Zahl[10] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 8 + ucUbertrag) > 57){ pc20Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 1 + ucUbertrag) > 57){ pc20Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 5 + ucUbertrag) > 57){ pc20Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 1 + ucUbertrag) > 57){ pc20Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 1 + ucUbertrag) > 57){ pc20Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 4 + ucUbertrag) > 57){ pc20Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 4 + ucUbertrag) > 57){ pc20Zahl[2] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[1] + 1 + ucUbertrag) > 57){ pc20Zahl[1] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 1; ucUbertrag = 0;}
								} break;
			case 27 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + 4 + ucUbertrag) > 57){ pc20Zahl[17] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 5; ucUbertrag = 0;}
									 else pc20Zahl[17] += 4;
									 if((pc20Zahl[16] + 7 + ucUbertrag) > 57){ pc20Zahl[16] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 8; ucUbertrag = 0;}
									 else pc20Zahl[16] += 7;
									 if((pc20Zahl[15] + 1 + ucUbertrag) > 57){ pc20Zahl[15] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 1 + ucUbertrag) > 57){ pc20Zahl[14] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 7 + ucUbertrag) > 57){ pc20Zahl[13] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 1 + ucUbertrag) > 57){ pc20Zahl[12] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 5 + ucUbertrag) > 57){ pc20Zahl[11] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 1 + ucUbertrag) > 57){ pc20Zahl[10] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 6 + ucUbertrag) > 57){ pc20Zahl[9] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 7 + ucUbertrag) > 57){ pc20Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 3 + ucUbertrag) > 57){ pc20Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[6] + ucUbertrag) > 57){ pc20Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[5] + 3 + ucUbertrag) > 57){ pc20Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 2 + ucUbertrag) > 57){ pc20Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 8 + ucUbertrag) > 57){ pc20Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 8 + ucUbertrag) > 57){ pc20Zahl[2] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[1] + 2 + ucUbertrag) > 57){ pc20Zahl[1] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 2; ucUbertrag = 0;}
								} break;
			case 28 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 8) > 57){ pc20Zahl[18] += -2; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 8;}
									 if((pc20Zahl[17] + 8 + ucUbertrag) > 57){ pc20Zahl[17] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 9; ucUbertrag = 0;}
									 else pc20Zahl[17] += 8;
									 if((pc20Zahl[16] + 4 + ucUbertrag) > 57){ pc20Zahl[16] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 5; ucUbertrag = 0;}
									 else pc20Zahl[16] += 4;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 2 + ucUbertrag) > 57){ pc20Zahl[14] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 4 + ucUbertrag) > 57){ pc20Zahl[13] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + ucUbertrag) > 57){ pc20Zahl[11] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[10] + 3 + ucUbertrag) > 57){ pc20Zahl[10] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 2 + ucUbertrag) > 57){ pc20Zahl[9] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 5 + ucUbertrag) > 57){ pc20Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[7] + 7 + ucUbertrag) > 57){ pc20Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[6] + ucUbertrag) > 57){ pc20Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[5] + 6 + ucUbertrag) > 57){ pc20Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 4 + ucUbertrag) > 57){ pc20Zahl[4] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 6 + ucUbertrag) > 57){ pc20Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 7 + ucUbertrag) > 57){ pc20Zahl[2] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[1] + 5 + ucUbertrag) > 57){ pc20Zahl[1] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 5; ucUbertrag = 0;}
									 if(ucUbertrag) pc20Zahl[0]++;
								} break;
			case 29 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 6) > 57){ pc20Zahl[18] += -4; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 6;}
									 if((pc20Zahl[17] + 7 + ucUbertrag) > 57){ pc20Zahl[17] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 8; ucUbertrag = 0;}
									 else pc20Zahl[17] += 7;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 6 + ucUbertrag) > 57){ pc20Zahl[15] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 4 + ucUbertrag) > 57){ pc20Zahl[14] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 8 + ucUbertrag) > 57){ pc20Zahl[13] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 6 + ucUbertrag) > 57){ pc20Zahl[12] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[11] + ucUbertrag) > 57){ pc20Zahl[11] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[10] + 6 + ucUbertrag) > 57){ pc20Zahl[10] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 4 + ucUbertrag) > 57){ pc20Zahl[9] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[8] + ucUbertrag) > 57){ pc20Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[7] + 5 + ucUbertrag) > 57){ pc20Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[7] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[6] + 1 + ucUbertrag) > 57){ pc20Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 2 + ucUbertrag) > 57){ pc20Zahl[5] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 9 + ucUbertrag) > 57){ pc20Zahl[4] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 2 + ucUbertrag) > 57){ pc20Zahl[3] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 5 + ucUbertrag) > 57){ pc20Zahl[2] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[1] + 1 + ucUbertrag) > 57){ pc20Zahl[1] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[0] + 1 + ucUbertrag) > 57){ pc20Zahl[0] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[0] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[0] += 1; ucUbertrag = 0;}
								} break;
			case 30 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 2) > 57){ pc20Zahl[18] += -8; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 2;}
									 if((pc20Zahl[17] + 5 + ucUbertrag) > 57){ pc20Zahl[17] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 6; ucUbertrag = 0;}
									 else pc20Zahl[17] += 5;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 3 + ucUbertrag) > 57){ pc20Zahl[15] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 9 + ucUbertrag) > 57){ pc20Zahl[14] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 6 + ucUbertrag) > 57){ pc20Zahl[13] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 3 + ucUbertrag) > 57){ pc20Zahl[12] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 1 + ucUbertrag) > 57){ pc20Zahl[11] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 2 + ucUbertrag) > 57){ pc20Zahl[10] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 9 + ucUbertrag) > 57){ pc20Zahl[9] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 0; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 if((pc20Zahl[8] + ucUbertrag) > 57){ pc20Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[7] + ucUbertrag) > 57){ pc20Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[6] + 3 + ucUbertrag) > 57){ pc20Zahl[6] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 4 + ucUbertrag) > 57){ pc20Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 8 + ucUbertrag) > 57){ pc20Zahl[4] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 5 + ucUbertrag) > 57){ pc20Zahl[3] += -5 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 6; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 5; ucUbertrag = 0;}
									 if((pc20Zahl[2] + ucUbertrag) > 57){ pc20Zahl[2] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[1] + 3 + ucUbertrag) > 57){ pc20Zahl[1] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[0] + 2 + ucUbertrag) > 57){ pc20Zahl[0] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[0] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[0] += 2; ucUbertrag = 0;}
								} break;
			case 31 : if(llZahl & (1 << ucBit)){ ucUbertrag = 0;
									 if((pc20Zahl[18] + 4) > 57){ pc20Zahl[18] += -6; ucUbertrag = 1;}
									 else{ pc20Zahl[18] += 4;}
									 if((pc20Zahl[17] + ucUbertrag) > 57){ pc20Zahl[17] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[17] += 1; ucUbertrag = 0;}
									 else pc20Zahl[17] += 0;
									 if((pc20Zahl[16] + 9 + ucUbertrag) > 57){ pc20Zahl[16] += -1 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[16] += 0; ucUbertrag = 0;}
									 else pc20Zahl[16] += 9;
									 if((pc20Zahl[15] + 7 + ucUbertrag) > 57){ pc20Zahl[15] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[15] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[15] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[14] + 8 + ucUbertrag) > 57){ pc20Zahl[14] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[14] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[14] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[13] + 3 + ucUbertrag) > 57){ pc20Zahl[13] += -7 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[13] += 4; ucUbertrag = 0;}
									 else{ pc20Zahl[13] += 3; ucUbertrag = 0;}
									 if((pc20Zahl[12] + 7 + ucUbertrag) > 57){ pc20Zahl[12] += -3 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[12] += 8; ucUbertrag = 0;}
									 else{ pc20Zahl[12] += 7; ucUbertrag = 0;}
									 if((pc20Zahl[11] + 2 + ucUbertrag) > 57){ pc20Zahl[11] += -8 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[11] += 3; ucUbertrag = 0;}
									 else{ pc20Zahl[11] += 2; ucUbertrag = 0;}
									 if((pc20Zahl[10] + 4 + ucUbertrag) > 57){ pc20Zahl[10] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[10] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[10] += 4; ucUbertrag = 0;}
									 if((pc20Zahl[9] + 8 + ucUbertrag) > 57){ pc20Zahl[9] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[9] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[9] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[8] + 1 + ucUbertrag) > 57){ pc20Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[8] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[8] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[7] + ucUbertrag) > 57){ pc20Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[7] += 1; ucUbertrag = 0;}
									 else{ucUbertrag = 0;}
									 if((pc20Zahl[6] + 6 + ucUbertrag) > 57){ pc20Zahl[6] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[6] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[6] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[5] + 8 + ucUbertrag) > 57){ pc20Zahl[5] += -2 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[5] += 9; ucUbertrag = 0;}
									 else{ pc20Zahl[5] += 8; ucUbertrag = 0;}
									 if((pc20Zahl[4] + 6 + ucUbertrag) > 57){ pc20Zahl[4] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[4] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[4] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[3] + 1 + ucUbertrag) > 57){ pc20Zahl[3] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[3] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[3] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[2] + 1 + ucUbertrag) > 57){ pc20Zahl[2] += -9 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[2] += 2; ucUbertrag = 0;}
									 else{ pc20Zahl[2] += 1; ucUbertrag = 0;}
									 if((pc20Zahl[1] + 6 + ucUbertrag) > 57){ pc20Zahl[1] += -4 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[1] += 7; ucUbertrag = 0;}
									 else{ pc20Zahl[1] += 6; ucUbertrag = 0;}
									 if((pc20Zahl[0] + 4 + ucUbertrag) > 57){ pc20Zahl[0] += -6 + ucUbertrag; ucUbertrag = 1;}
									 else if(ucUbertrag){ pc20Zahl[0] += 5; ucUbertrag = 0;}
									 else{ pc20Zahl[0] += 4; ucUbertrag = 0;}
								} break;
	 }
 }
}
//---------------------------------------------------------------------------
inline void __vectorcall __ULONGtoCHAR(char pc11Zahl[11], unsigned long ulZahl)
{
 unsigned char ucUbertrag;  char cStellen = 0;
 while(cStellen < 11) pc11Zahl[cStellen++] = 48;

 for(unsigned char ucBit = 0; ucBit < 32; ucBit++){
   switch(ucBit){
      case 0  : if(ulZahl & (1 << ucBit)){ pc11Zahl[9]++;} break;
      case 1  : if(ulZahl & (1 << ucBit)){ pc11Zahl[9] += 2;} break;
      case 2  : if(ulZahl & (1 << ucBit)){ pc11Zahl[9] += 4;} break;
      case 3  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if(ucUbertrag) pc11Zahl[8]++;
                } break;
      case 4  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                } break;
      case 5  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                } break;
      case 6  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if(ucUbertrag) pc11Zahl[7]++;
                } break;
      case 7  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                } break;
      case 8  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                } break;
      case 9  : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if(ucUbertrag) pc11Zahl[6]++;
                } break;
      case 10 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                } break;
      case 11 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 4 + ucUbertrag) > 57){ pc11Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 5; ucUbertrag = 0;}
                   else pc11Zahl[8] += 4;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                } break;
      case 12 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 9 + ucUbertrag) > 57){ pc11Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 0; ucUbertrag = 0;}
                   else pc11Zahl[8] += 9;
                   if((pc11Zahl[7] + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                } break;
      case 13 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 9 + ucUbertrag) > 57){ pc11Zahl[8] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else pc11Zahl[8] += 9;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[5]++;
                } break;
      case 14 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 8 + ucUbertrag) > 57){ pc11Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 9; ucUbertrag = 0;}
                   else pc11Zahl[8] += 8;
                   if((pc11Zahl[7] + 3 + ucUbertrag) > 57){ pc11Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 4; ucUbertrag = 0;}
                   else pc11Zahl[7] += 3;
                   if((pc11Zahl[6] + 6 + ucUbertrag) > 57){ pc11Zahl[6] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 1 + ucUbertrag) > 57){ pc11Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 1; ucUbertrag = 0;}
                } break;
      case 15 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if((pc11Zahl[7] + 7 + ucUbertrag) > 57){ pc11Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 8; ucUbertrag = 0;}
                   else pc11Zahl[7] += 7;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                } break;
      case 16 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if((pc11Zahl[6] + 5 + ucUbertrag) > 57){ pc11Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 6 + ucUbertrag) > 57){ pc11Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[4]++;
                } break;
      case 17 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 7 + ucUbertrag) > 57){ pc11Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 8; ucUbertrag = 0;}
                   else pc11Zahl[8] += 7;
                   if((pc11Zahl[7] + 0 + ucUbertrag) > 57){ pc11Zahl[7] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 1; ucUbertrag = 0;}
                   else pc11Zahl[7] += 0;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                } break;
      case 18 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 4 + ucUbertrag) > 57){ pc11Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 5; ucUbertrag = 0;}
                   else pc11Zahl[8] += 4;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 2 + ucUbertrag) > 57){ pc11Zahl[6] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 6 + ucUbertrag) > 57){ pc11Zahl[5] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 2 + ucUbertrag) > 57){ pc11Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 2; ucUbertrag = 0;}
                } break;
      case 19 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 8 + ucUbertrag) > 57){ pc11Zahl[8] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 9; ucUbertrag = 0;}
                   else pc11Zahl[8] += 8;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 2 + ucUbertrag) > 57){ pc11Zahl[5] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 5 + ucUbertrag) > 57){ pc11Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[3]++;
                } break;
      case 20 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 7 + ucUbertrag) > 57){ pc11Zahl[8] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 8; ucUbertrag = 0;}
                   else pc11Zahl[8] += 7;
                   if((pc11Zahl[7] + 5 + ucUbertrag) > 57){ pc11Zahl[7] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 6; ucUbertrag = 0;}
                   else pc11Zahl[7] += 5;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 4 + ucUbertrag) > 57){ pc11Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[4] + ucUbertrag) > 57){ pc11Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 1 + ucUbertrag) > 57){ pc11Zahl[3] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 1; ucUbertrag = 0;}
                } break;
      case 21 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 1 + ucUbertrag) > 57){ pc11Zahl[7] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 2; ucUbertrag = 0;}
                   else pc11Zahl[7] += 1;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 9 + ucUbertrag) > 57){ pc11Zahl[5] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   if((pc11Zahl[4] + ucUbertrag) > 57){ pc11Zahl[4] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 2 + ucUbertrag) > 57){ pc11Zahl[3] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 2; ucUbertrag = 0;}
                } break;
      case 22 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + ucUbertrag) > 57){ pc11Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 1; ucUbertrag = 0;}
                   else pc11Zahl[8] += 0;
                   if((pc11Zahl[7] + 3 + ucUbertrag) > 57){ pc11Zahl[7] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 4; ucUbertrag = 0;}
                   else pc11Zahl[7] += 3;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 9 + ucUbertrag) > 57){ pc11Zahl[5] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 4 + ucUbertrag) > 57){ pc11Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 4; ucUbertrag = 0;}
                } break;
      case 23 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + ucUbertrag) > 57){ pc11Zahl[8] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 1; ucUbertrag = 0;}
                   else pc11Zahl[8] += 0;
                   if((pc11Zahl[7] + 6 + ucUbertrag) > 57){ pc11Zahl[7] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 7; ucUbertrag = 0;}
                   else pc11Zahl[7] += 6;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 8 + ucUbertrag) > 57){ pc11Zahl[5] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 3 + ucUbertrag) > 57){ pc11Zahl[4] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 8 + ucUbertrag) > 57){ pc11Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[2]++;
                } break;
      case 24 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 2 + ucUbertrag) > 57){ pc11Zahl[7] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 3; ucUbertrag = 0;}
                   else pc11Zahl[7] += 2;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 7 + ucUbertrag) > 57){ pc11Zahl[5] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 7 + ucUbertrag) > 57){ pc11Zahl[4] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 6 + ucUbertrag) > 57){ pc11Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 1 + ucUbertrag) > 57){ pc11Zahl[2] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 1; ucUbertrag = 0;}
                } break;
      case 25 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 3 + ucUbertrag) > 57){ pc11Zahl[8] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 4; ucUbertrag = 0;}
                   else pc11Zahl[8] += 3;
                   if((pc11Zahl[7] + 4 + ucUbertrag) > 57){ pc11Zahl[7] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 5; ucUbertrag = 0;}
                   else pc11Zahl[7] += 4;
                   if((pc11Zahl[6] + 4 + ucUbertrag) > 57){ pc11Zahl[6] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 5 + ucUbertrag) > 57){ pc11Zahl[5] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 5 + ucUbertrag) > 57){ pc11Zahl[4] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 3 + ucUbertrag) > 57){ pc11Zahl[3] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                } break;
      case 26 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 6 + ucUbertrag) > 57){ pc11Zahl[8] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 7; ucUbertrag = 0;}
                   else pc11Zahl[8] += 6;
                   if((pc11Zahl[7] + 8 + ucUbertrag) > 57){ pc11Zahl[7] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 9; ucUbertrag = 0;}
                   else pc11Zahl[7] += 8;
                   if((pc11Zahl[6] + 8 + ucUbertrag) > 57){ pc11Zahl[6] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[5] + ucUbertrag) > 57){ pc11Zahl[5] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 1 + ucUbertrag) > 57){ pc11Zahl[4] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 7 + ucUbertrag) > 57){ pc11Zahl[3] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 6 + ucUbertrag) > 57){ pc11Zahl[2] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 6; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[1]++;
                } break;
      case 27 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 7 + ucUbertrag) > 57){ pc11Zahl[7] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 8; ucUbertrag = 0;}
                   else pc11Zahl[7] += 7;
                   if((pc11Zahl[6] + 7 + ucUbertrag) > 57){ pc11Zahl[6] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 1 + ucUbertrag) > 57){ pc11Zahl[5] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 2 + ucUbertrag) > 57){ pc11Zahl[4] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 2; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 4 + ucUbertrag) > 57){ pc11Zahl[3] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 1 + ucUbertrag) > 57){ pc11Zahl[1] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 1; ucUbertrag = 0;}
                } break;
      case 28 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 6) > 57){ pc11Zahl[9] += -4; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 6;}
                   if((pc11Zahl[8] + 5 + ucUbertrag) > 57){ pc11Zahl[8] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 6; ucUbertrag = 0;}
                   else pc11Zahl[8] += 5;
                   if((pc11Zahl[7] + 4 + ucUbertrag) > 57){ pc11Zahl[7] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 5; ucUbertrag = 0;}
                   else pc11Zahl[7] += 4;
                   if((pc11Zahl[6] + 5 + ucUbertrag) > 57){ pc11Zahl[6] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 5; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 3 + ucUbertrag) > 57){ pc11Zahl[5] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 4 + ucUbertrag) > 57){ pc11Zahl[4] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 8 + ucUbertrag) > 57){ pc11Zahl[3] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 6 + ucUbertrag) > 57){ pc11Zahl[2] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 2 + ucUbertrag) > 57){ pc11Zahl[1] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 2; ucUbertrag = 0;}
                } break;
      case 29 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 2) > 57){ pc11Zahl[9] += -8; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 2;}
                   if((pc11Zahl[8] + 1 + ucUbertrag) > 57){ pc11Zahl[8] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 2; ucUbertrag = 0;}
                   else pc11Zahl[8] += 1;
                   if((pc11Zahl[7] + 9 + ucUbertrag) > 57){ pc11Zahl[7] += -1 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 0; ucUbertrag = 0;}
                   else pc11Zahl[7] += 9;
                   if((pc11Zahl[6] + ucUbertrag) > 57){ pc11Zahl[6] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 7 + ucUbertrag) > 57){ pc11Zahl[5] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 8 + ucUbertrag) > 57){ pc11Zahl[4] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 6 + ucUbertrag) > 57){ pc11Zahl[3] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 6; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 3 + ucUbertrag) > 57){ pc11Zahl[2] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 5 + ucUbertrag) > 57){ pc11Zahl[1] += -5 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 6; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 5; ucUbertrag = 0;}
                   if(ucUbertrag) pc11Zahl[0]++;
                } break;
      case 30 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 4) > 57){ pc11Zahl[9] += -6; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 4;}
                   if((pc11Zahl[8] + 2 + ucUbertrag) > 57){ pc11Zahl[8] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 3; ucUbertrag = 0;}
                   else pc11Zahl[8] += 2;
                   if((pc11Zahl[7] + 8 + ucUbertrag) > 57){ pc11Zahl[7] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 9; ucUbertrag = 0;}
                   else pc11Zahl[7] += 8;
                   if((pc11Zahl[6] + 1 + ucUbertrag) > 57){ pc11Zahl[6] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 4 + ucUbertrag) > 57){ pc11Zahl[5] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 7 + ucUbertrag) > 57){ pc11Zahl[4] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 3 + ucUbertrag) > 57){ pc11Zahl[3] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 7 + ucUbertrag) > 57){ pc11Zahl[2] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[1] + ucUbertrag) > 57){ pc11Zahl[1] += -10 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 1; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 0; ucUbertrag = 0;}
                   if((pc11Zahl[0] + 1 + ucUbertrag) > 57){ pc11Zahl[0] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[0] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[0] += 1; ucUbertrag = 0;}
                } break;
      case 31 : if(ulZahl & (1 << ucBit)){ ucUbertrag = 0;
                   if((pc11Zahl[9] + 8) > 57){ pc11Zahl[9] += -2; ucUbertrag = 1;}
                   else{ pc11Zahl[9] += 8;}
                   if((pc11Zahl[8] + 4 + ucUbertrag) > 57){ pc11Zahl[8] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[8] += 5; ucUbertrag = 0;}
                   else pc11Zahl[8] += 4;
                   if((pc11Zahl[7] + 6 + ucUbertrag) > 57){ pc11Zahl[7] += -4 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[7] += 7; ucUbertrag = 0;}
                   else pc11Zahl[7] += 6;
                   if((pc11Zahl[6] + 3 + ucUbertrag) > 57){ pc11Zahl[6] += -7 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[6] += 4; ucUbertrag = 0;}
                   else{ pc11Zahl[6] += 3; ucUbertrag = 0;}
                   if((pc11Zahl[5] + 8 + ucUbertrag) > 57){ pc11Zahl[5] += -2 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[5] += 9; ucUbertrag = 0;}
                   else{ pc11Zahl[5] += 8; ucUbertrag = 0;}
                   if((pc11Zahl[4] + 4 + ucUbertrag) > 57){ pc11Zahl[4] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[4] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[4] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[3] + 7 + ucUbertrag) > 57){ pc11Zahl[3] += -3 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[3] += 8; ucUbertrag = 0;}
                   else{ pc11Zahl[3] += 7; ucUbertrag = 0;}
                   if((pc11Zahl[2] + 4 + ucUbertrag) > 57){ pc11Zahl[2] += -6 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[2] += 5; ucUbertrag = 0;}
                   else{ pc11Zahl[2] += 4; ucUbertrag = 0;}
                   if((pc11Zahl[1] + 1 + ucUbertrag) > 57){ pc11Zahl[1] += -9 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[1] += 2; ucUbertrag = 0;}
                   else{ pc11Zahl[1] += 1; ucUbertrag = 0;}
                   if((pc11Zahl[0] + 2 + ucUbertrag) > 57){ pc11Zahl[0] += -8 + ucUbertrag; ucUbertrag = 1;}
                   else if(ucUbertrag){ pc11Zahl[0] += 3; ucUbertrag = 0;}
                   else{ pc11Zahl[0] += 2; ucUbertrag = 0;}
                }
                break;
   }
 }
}