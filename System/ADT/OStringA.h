/****************************************************************************
  OStringA.h
  For more information see https://github.com/RePag-net/Core
*****************************************************************************/

/****************************************************************************
  The MIT License(MIT)

  Copyright(c) 2020 Ren� Pagel

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
#include "OKomma4_80.h"
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    class _Export COStringA
    {
    private:
      struct STStringA
      {
        VMBLOCK vbInhalt;
        unsigned long ulLange;
        VMBLOCK vbInhalt_A;
        unsigned long ulLange_A;
      };
      char c16StringA[16];
      VMEMORY vmSpeicher;

    public:
      __thiscall COStringA(void);
      __thiscall COStringA(_In_ VMEMORY vmSpeicher);
      __thiscall COStringA(_In_z_ const char* pcString);
      __thiscall COStringA(_In_ VMEMORY vmSpeicher, _In_z_ const char* pcString);
      __thiscall ~COStringA(void);
      VMEMORY __vectorcall COFreiV(void);
      void __vectorcall operator =(_In_z_ const char* pcString);
      void __vectorcall operator =(_In_ const COStringA& asString);
      void __vectorcall operator +=(_In_z_ const char* pcString);
      void __vectorcall operator +=(_In_ const COStringA& asString);
      COStringA& __vectorcall operator +(_In_z_ const char* pcString);
      COStringA& __vectorcall operator +(_In_ const COStringA& asString);
      bool __vectorcall operator ==(_In_z_ const char* pcString);
      bool __vectorcall operator ==(_In_ const COStringA& asString);
      bool __vectorcall operator !=(_In_z_ const char* pcString);
      bool __vectorcall operator !=(_In_ const COStringA& asString);
      bool __vectorcall operator <(_In_z_ const char* pcString);
      bool __vectorcall operator <(_In_ const COStringA& asString);
      bool __vectorcall operator >(_In_z_ const char* pcString);
      bool __vectorcall operator >(_In_ const COStringA& asString);
      char& __vectorcall operator [](_In_ const unsigned long ulIndex);
      bool __vectorcall Contain(_In_z_ const char* pcString);
      bool __vectorcall Contain(_In_ const COStringA& asString);
      bool __vectorcall ContainLeft(_In_z_ const char* pcString);
      bool __vectorcall ContainLeft(_In_ const COStringA& asString);
      bool __vectorcall ContainRight(_In_z_ const char* pcString);
      bool __vectorcall ContainRight(_In_ const COStringA& asString);
      unsigned long __vectorcall SubString(_In_ VMBLOCK& vbString, _In_ const unsigned long ulVon, _In_ const unsigned long ulBis);
      COStringA* __vectorcall SubString(_In_ const COStringA* pasString, _In_ const unsigned long ulVon, _In_ const unsigned long ulBis);
      COStringA* __vectorcall Insert(_In_z_ const char* pcString, _In_ const unsigned long ulPosition);
      COStringA* __vectorcall Insert(_In_ const COStringA* pasString, _In_ const unsigned long ulPosition);
      COStringA* __vectorcall Delete(_In_ const unsigned long ulPosition, _In_ const unsigned long ulAnzahl);
      unsigned long __vectorcall SearchCharacters(_In_z_ const char* pcZeichen);
      unsigned long __vectorcall SearchCharacters(_In_z_ const char* pcZeichen, _In_ const unsigned long ulVon, _In_ const unsigned long ulBis);
      void __vectorcall ShortRight(_In_ const unsigned long ulStrLange);
      void __vectorcall ShortLeft(_In_ const unsigned long ulStrLange);
      void __vectorcall ShortRightOne(void);
      char& __vectorcall CHAR(_Out_ char& cZahl);
      unsigned char& __vectorcall BYTE(_Out_ unsigned char& ucZahl);
      short& __vectorcall SHORT(_Out_ short& sZahl);
      unsigned short& __vectorcall USHORT(_Out_ unsigned short& usZahl);
      long& __vectorcall LONG(_Out_ long& lZahl);
      unsigned long& __vectorcall ULONG(_Out_ unsigned long& ulZahl);
      long long& __vectorcall LONGLONG(_Out_ long long& llZahl);
      float& __vectorcall FLOAT(float& fZahl);
      double& __vectorcall DOUBLE(_Out_ double& dZahl);
      COComma4* __vectorcall COMMA4(_Out_ COComma4* pk4Zahl);
      COComma4_80* __vectorcall COMMA4_80(_Out_ COComma4_80* pk4gZahl);
      bool __vectorcall IsIntegralNumber(void);
      bool __vectorcall IsFloatingPointNumber(void);
      void __vectorcall Uppercase(void);
      unsigned long __vectorcall Length(void);
      void __vectorcall SetLength(_In_ const unsigned long ulStrLange);
      char* __vectorcall c_Str(void);

#ifdef HADT
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QAE@PBX@Z")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QAE@PBD@Z")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QAE@PBXPBD@Z")
#pragma comment(linker, "/export:??1COStringA@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:?COFreiV@COStringA@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:??4COStringA@System@RePag@@QAQXPBD@Z")
#pragma comment(linker, "/export:??4COStringA@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??YCOStringA@System@RePag@@QAQXPBD@Z")
#pragma comment(linker, "/export:??YCOStringA@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??HCOStringA@System@RePag@@QAQAAV012@PBD@Z")
#pragma comment(linker, "/export:??HCOStringA@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??8COStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:??8COStringA@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??9COStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:??9COStringA@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??MCOStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:??MCOStringA@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??OCOStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:??OCOStringA@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??ACOStringA@System@RePag@@QAQAADK@Z")
#pragma comment(linker, "/export:?Contain@COStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:?Contain@COStringA@System@RePag@@QAQ_NABV123@@Z")
#pragma comment(linker, "/export:?ContainLeft@COStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:?ContainLeft@COStringA@System@RePag@@QAQ_NABV123@@Z")
#pragma comment(linker, "/export:?ContainRight@COStringA@System@RePag@@QAQ_NPBD@Z")
#pragma comment(linker, "/export:?ContainRight@COStringA@System@RePag@@QAQ_NABV123@@Z")
#pragma comment(linker, "/export:?SubString@COStringA@System@RePag@@QAQKAAPADKK@Z")
#pragma comment(linker, "/export:?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z")
#pragma comment(linker, "/export:?Insert@COStringA@System@RePag@@QAQPAV123@PBDK@Z")
#pragma comment(linker, "/export:?Insert@COStringA@System@RePag@@QAQPAV123@PBV123@K@Z")
#pragma comment(linker, "/export:?Delete@COStringA@System@RePag@@QAQPAV123@KK@Z")
#pragma comment(linker, "/export:?SearchCharacters@COStringA@System@RePag@@QAQKPBD@Z")
#pragma comment(linker, "/export:?SearchCharacters@COStringA@System@RePag@@QAQKPBDKK@Z") 
#pragma comment(linker, "/export:?ShortRight@COStringA@System@RePag@@QAQXK@Z")
#pragma comment(linker, "/export:?ShortLeft@COStringA@System@RePag@@QAQXK@Z")
#pragma comment(linker, "/export:?ShortRightOne@COStringA@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?CHAR@COStringA@System@RePag@@QAQAADAAD@Z")
#pragma comment(linker, "/export:?BYTE@COStringA@System@RePag@@QAQAAEAAE@Z")
#pragma comment(linker, "/export:?SHORT@COStringA@System@RePag@@QAQAAFAAF@Z")
#pragma comment(linker, "/export:?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z")
#pragma comment(linker, "/export:?LONG@COStringA@System@RePag@@QAQAAJAAJ@Z")
#pragma comment(linker, "/export:?ULONG@COStringA@System@RePag@@QAQAAKAAK@Z")
#pragma comment(linker, "/export:?LONGLONG@COStringA@System@RePag@@QAQAA_JAA_J@Z")
#pragma comment(linker, "/export:?FLOAT@COStringA@System@RePag@@QAQAAMAAM@Z")
#pragma comment(linker, "/export:?DOUBLE@COStringA@System@RePag@@QAQAANAAN@Z")
#pragma comment(linker, "/export:?COMMA4@COStringA@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z")
#pragma comment(linker, "/export:?COMMA4_80@COStringA@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z")
#pragma comment(linker, "/export:?IsIntegralNumber@COStringA@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?IsFloatingPointNumber@COStringA@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?Uppercase@COStringA@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?Length@COStringA@System@RePag@@QAQKXZ")
#pragma comment(linker, "/export:?SetLength@COStringA@System@RePag@@QAQXK@Z")
#pragma comment(linker, "/export:?c_Str@COStringA@System@RePag@@QAQPADXZ")
#endif

    };
    //---------------------------------------------------------------------------
    COStringA* __vectorcall COStringAV(void);
    COStringA* __vectorcall COStringAV(_In_ const VMEMORY vmSpeicher);
    COStringA* __vectorcall COStringAV(_In_ const char* pcString);
    COStringA* __vectorcall COStringAV(_In_ const VMEMORY vmSpeicher, _In_ const char* pcString);
    COStringA* __vectorcall COStringAV(_In_ const COStringA* pasString);
    COStringA* __vectorcall COStringAV(_In_ const VMEMORY vmSpeicher, _In_ const COStringA* pasString);
    COStringA* __vectorcall COStringAV(_In_ const unsigned long ulStrLange);
    COStringA* __vectorcall COStringAV(_In_ const VMEMORY vmSpeicher, _In_ const unsigned long ulStrLange);
#ifdef HADT
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@XZ")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBX@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@PBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@PBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@K@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXK@Z")
#endif
    //---------------------------------------------------------------------------
  }
}