/****************************************************************************
  ZahlZuHexalString.h
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
