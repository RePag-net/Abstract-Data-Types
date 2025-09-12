#pragma once
#ifdef HADT
#define _Export __declspec(dllexport)
#else
#define _Export
#endif
namespace RePag
{
  namespace System
  {
    //---------------------------------------------------------------------------
    inline void __vectorcall NibbleAnHex(_Out_writes_z_(37) char c37Zahl[37], _In_ BYTE& ucNibble, _In_ BYTE& ucPosition);
    _Export char* __vectorcall ULONGtoHexCHAR(_Out_writes_z_(10) char c10HexNumber[10], _In_ unsigned long ulNumber);
    _Export char* __vectorcall ULONGtoHexCHAR_64(_Out_writes_z_(18) char pc18HexNumber[18], _In_ unsigned long long ulNumber);
    _Export char* __vectorcall BIT128toGUID(_Out_writes_z_(37) char pc37GUID[37], _In_ const BIT128 bit128Value);
    //---------------------------------------------------------------------------
  }
}
