/****************************************************************************
  HADT.h
  For more information see https://github.com/RePag-net/Core
*****************************************************************************/

/****************************************************************************
  The MIT License(MIT)

  Copyright(c) 2020 René Pagel

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
#include "targetver.h"

#define WIN32_LEAN_AND_MEAN             // Selten verwendete Komponenten aus Windows-Headern ausschließen

#define ADTH
#include "CompSys.h"
#include "Fieldsizes.h"

namespace RePag
{
  namespace System
  {
    //--------------------------------------------------------------------------
    unsigned long __vectorcall StrLength(_In_z_ const char* pcString);
    unsigned long __vectorcall CharactersPosition(_In_z_ const char* pcString, _In_ char cCharacters, _In_ bool bFromLeftToRigth);
    unsigned long __vectorcall CharactersPosition(_In_z_ const char* pcString, _In_ unsigned long ulLength, _In_ char cCharacters, _In_ bool bFromLeftToRigth);
    char __vectorcall StrCompare(_In_z_ const char* pcRefString, _In_z_ const char* pcCmpString);
    char __vectorcall StrCompare(_In_z_ const char* pcRefString, _In_ unsigned long ulRefLength, _In_z_ const char* pcCmpString, _In_ unsigned long ulcmpLength);
    bool __vectorcall StrContain(_In_z_ const char* pcRefString, _In_z_ const char* pcCmpString);
    bool __vectorcall StrContain(_In_z_ const char* pcRefString, _In_ unsigned long ulRefLength, _In_z_ const char* pcCmpString, _In_ unsigned long ulVglLength);
    bool __vectorcall StrContainLeft(_In_z_ const char* pcRefString, _In_z_ const char* pcVglString);
    bool __vectorcall StrContainLeft(_In_z_ const char* pcRefString, _In_ unsigned long ulRefLength, _In_z_ const char* pcCmpString, _In_ unsigned long ulcmpLength);
    bool __vectorcall StrContainRight(_In_z_ const char* pcRefString, _In_z_ const char* pcVglString);
    bool __vectorcall StrContainRight(_In_z_ const char* pcRefString, _In_ unsigned long ulRefLength, _In_z_ const char* pcCmpString, _In_ unsigned long ulCmpLength);
    char __vectorcall BIT128Compare(_In_ const BIT128 bit128Value_1, _In_ const BIT128 bit128Value_2);
#pragma comment(linker, "/export:?StrLength@System@RePag@@YQKPBD@Z")
#pragma comment(linker, "/export:?CharactersPosition@System@RePag@@YQKPBDD_N@Z")
#pragma comment(linker, "/export:?CharactersPosition@System@RePag@@YQKPBDKD_N@Z")
#pragma comment(linker, "/export:?StrCompare@System@RePag@@YQDPBD0@Z")
#pragma comment(linker, "/export:?StrCompare@System@RePag@@YQDPBDK0K@Z")
#pragma comment(linker, "/export:?StrContain@System@RePag@@YQ_NPBD0@Z")
#pragma comment(linker, "/export:?StrContain@System@RePag@@YQ_NPBDK0K@Z")
#pragma comment(linker, "/export:?StrContainLeft@System@RePag@@YQ_NPBD0@Z")
#pragma comment(linker, "/export:?StrContainLeft@System@RePag@@YQ_NPBDK0K@Z")
#pragma comment(linker, "/export:?StrContainRight@System@RePag@@YQ_NPBD0@Z")
#pragma comment(linker, "/export:?StrContainRight@System@RePag@@YQ_NPBDK0K@Z")
#pragma comment(linker, "/export:?BIT128Compare@System@RePag@@YQDQBE0@Z")
    //--------------------------------------------------------------------------
  }
}