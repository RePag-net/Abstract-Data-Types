#pragma once
#include "targetver.h"

#define WIN32_LEAN_AND_MEAN             // Selten verwendete Komponenten aus Windows-Headern ausschlieﬂen

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
#ifndef _64bit
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
#else
#pragma comment(linker, "/export:?StrLength@System@RePag@@YQKPEBD@Z")
#pragma comment(linker, "/export:?CharactersPosition@System@RePag@@YQKPEBDD_N@Z")
#pragma comment(linker, "/export:?CharactersPosition@System@RePag@@YQKPBDKD_N@Z")
#pragma comment(linker, "/export:?StrCompare@System@RePag@@YQDPEBD0@Z")
#pragma comment(linker, "/export:?StrCompare@System@RePag@@YQDPEBDK0K@Z")
#pragma comment(linker, "/export:?StrContain@System@RePag@@YQ_NPEBD0@Z")
#pragma comment(linker, "/export:?StrContain@System@RePag@@YQ_NPEBDK0K@Z")
#pragma comment(linker, "/export:?StrContainLeft@System@RePag@@YQ_NPEBD0@Z")
#pragma comment(linker, "/export:?StrContainLeft@System@RePag@@YQ_NPEBDK0K@Z")
#pragma comment(linker, "/export:?StrContainRight@System@RePag@@YQ_NPEBD0@Z")
#pragma comment(linker, "/export:?StrContainRight@System@RePag@@YQ_NPEBDK0K@Z")
#pragma comment(linker, "/export:?BIT128Compare@System@RePag@@YQDQEBE0@Z")
#endif
    //--------------------------------------------------------------------------
  }
}