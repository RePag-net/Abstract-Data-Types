/****************************************************************************
  ZahlZuString.h
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

#pragma once
#ifdef HADT
  #define _Export __declspec(dllexport)
#else
  #define _Export
#endif
#include "OKomma4.h"
#include "OStringA.h"
#include "OKomma4_80.h"
//---------------------------------------------------------------------------
__forceinline void __vectorcall __ULONGtoCHAR(char pcZahl[11], unsigned long ulZahl);
__forceinline void __vectorcall __LONGtoCHAR(char pcZahl[11], long lZahl);
__forceinline void __vectorcall __LONGLONGtoCHAR(char pcZahl[20], long long llZahl);
void __vectorcall __DOUBLE_B10toCHAR(short& Exponent, short& sVorKomma, long long& llNachKomma, double& dZahl, unsigned char& ucStellen);
void __vectorcall __DOUBLE_B10toCHAR(short& sExponent, short& sVorKomma, double dZahl, long long& llNachKomma, unsigned char ucStellen);
__forceinline void __vectorcall __FLOAT_B10zuCHAR(short& Exponent, short& sVorKomma, long& lNachKomma, float& fZahl, unsigned char& ucStellen);
void __vectorcall __FLOAT_B10zuCHAR(short& Exponent, short& sVorKomma, float fZahl, long& lNachKomma, unsigned char ucPositions);

namespace RePag
{
  namespace System
  {
    char* __vectorcall Comma4toCHAR(_Out_writes_z_(20) char pc20Number[20], _In_ COComma4* pk4Number, _In_ unsigned char ucPositions);
    char* __vectorcall Comma4_80toCHAR(_Out_writes_z_(32) char pcZahl[32], _In_ COComma4_80* pk4gZahl, _In_ unsigned char ucStellen);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?Comma4toCHAR@System@RePag@@YQPADQADPAVCOComma4@12@E@Z")
#pragma comment(linker, "/export:?Comma4_80toCHAR@System@RePag@@YQPADQADPAVCOComma4_80@12@E@Z")
#else
#pragma comment(linker, "/export:?Comma4toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4@12@E@Z")
#pragma comment(linker, "/export:?Comma4_80toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4_80@12@E@Z")
#endif
#endif
    _Export COStringA* __vectorcall Comma4toStringA(_In_ COStringA* pasString, _In_ COComma4* pk4Number, _In_ unsigned char ucPositions);
    _Export COStringA* __vectorcall Comma4_80toStringA(_In_ COStringA* pasString, _In_ COComma4_80* pk4_80Number, _In_ unsigned char ucPositions);
    _Export char* __vectorcall LONGtoCHAR(_Out_writes_z_(12) char pc12Number[12], _In_ long lNumber);
    _Export char* __vectorcall LONGLONGtoCHAR(_Out_writes_z_(21) char pc21Number[21], _In_ long long llNumber);
    _Export char* __vectorcall ULONGtoCHAR(_Out_writes_z_(11) char pc11Number[11], _In_ unsigned long ulNumber);
    _Export char* __vectorcall DOUBLE_B10toCHAR(_Out_writes_z_(28) char pc28Number[28], _In_ double dNumber, _In_ unsigned char ucPositions);
    _Export char* __vectorcall FLOAT_B10toCHAR(_Out_writes_z_(20) char pc20Number[20], _In_ float fNumber, _In_ unsigned char ucPositions);
    //---------------------------------------------------------------------------
  }
}



