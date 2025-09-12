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
        VMBLOCK vbInhalt_A;
        unsigned long ulLange;
        unsigned long ulLange_A;
      };
#ifndef _64bit
      char c16StringA[16];
#else
      char c16StringA[24];
#endif
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
      BIT128& __vectorcall BIT128fromGUID(BIT128& bit128Zahl);
      bool __vectorcall IsIntegralNumber(void);
      bool __vectorcall IsFloatingPointNumber(void);
      void __vectorcall Uppercase(void);
      unsigned long __vectorcall Length(void);
      void __vectorcall SetLength(_In_ const unsigned long ulStrLange);
      char* __vectorcall c_Str(void);

#ifdef HADT
#ifndef _64bit
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
#pragma comment(linker, "/export:?BIT128fromGUID@COStringA@System@RePag@@QAQAAY0BA@EAAY0BA@E@Z")
#pragma comment(linker, "/export:?IsIntegralNumber@COStringA@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?IsFloatingPointNumber@COStringA@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?Uppercase@COStringA@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?Length@COStringA@System@RePag@@QAQKXZ")
#pragma comment(linker, "/export:?SetLength@COStringA@System@RePag@@QAQXK@Z")
#pragma comment(linker, "/export:?c_Str@COStringA@System@RePag@@QAQPADXZ")
#else
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QEAA@PEBX@Z")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QEAA@PEBD@Z")
#pragma comment(linker, "/export:??0COStringA@System@RePag@@QEAA@PEBXPEBD@Z")
#pragma comment(linker, "/export:??1COStringA@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:?COFreiV@COStringA@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:??4COStringA@System@RePag@@QEAQXPEBD@Z")
#pragma comment(linker, "/export:??4COStringA@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??YCOStringA@System@RePag@@QEAQXPEBD@Z")
#pragma comment(linker, "/export:??YCOStringA@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??HCOStringA@System@RePag@@QEAQAEAV012@PEBD@Z")
#pragma comment(linker, "/export:??HCOStringA@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??8COStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:??8COStringA@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??9COStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:??9COStringA@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??MCOStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:??MCOStringA@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??OCOStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:??OCOStringA@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??ACOStringA@System@RePag@@QEAQAEADK@Z")
#pragma comment(linker, "/export:?Contain@COStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:?Contain@COStringA@System@RePag@@QEAQ_NAEBV123@@Z")
#pragma comment(linker, "/export:?ContainLeft@COStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:?ContainLeft@COStringA@System@RePag@@QEAQ_NAEBV123@@Z")
#pragma comment(linker, "/export:?ContainRight@COStringA@System@RePag@@QEAQ_NPEBD@Z")
#pragma comment(linker, "/export:?ContainRight@COStringA@System@RePag@@QEAQ_NAEBV123@@Z")
#pragma comment(linker, "/export:?SubString@COStringA@System@RePag@@QEAQKAEAPEADKK@Z")
#pragma comment(linker, "/export:?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z")
#pragma comment(linker, "/export:?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBDK@Z")
#pragma comment(linker, "/export:?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBV123@K@Z")
#pragma comment(linker, "/export:?Delete@COStringA@System@RePag@@QEAQPEAV123@KK@Z")
#pragma comment(linker, "/export:?SearchCharacters@COStringA@System@RePag@@QEAQKPEBD@Z")
#pragma comment(linker, "/export:?SearchCharacters@COStringA@System@RePag@@QEAQKPEBDKK@Z")
#pragma comment(linker, "/export:?ShortRight@COStringA@System@RePag@@QEAQXK@Z")
#pragma comment(linker, "/export:?ShortLeft@COStringA@System@RePag@@QEAQXK@Z")
#pragma comment(linker, "/export:?ShortRightOne@COStringA@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?CHAR@COStringA@System@RePag@@QEAQAEADAEAD@Z")
#pragma comment(linker, "/export:?BYTE@COStringA@System@RePag@@QEAQAEAEAEAE@Z")
#pragma comment(linker, "/export:?SHORT@COStringA@System@RePag@@QEAQAEAFAEAF@Z")
#pragma comment(linker, "/export:?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z")
#pragma comment(linker, "/export:?LONG@COStringA@System@RePag@@QEAQAEAJAEAJ@Z")
#pragma comment(linker, "/export:?ULONG@COStringA@System@RePag@@QEAQAEAKAEAK@Z")
#pragma comment(linker, "/export:?LONGLONG@COStringA@System@RePag@@QEAQAEA_JAEA_J@Z")
#pragma comment(linker, "/export:?FLOAT@COStringA@System@RePag@@QEAQAEAMAEAM@Z")
#pragma comment(linker, "/export:?DOUBLE@COStringA@System@RePag@@QEAQAEANAEAN@Z")
#pragma comment(linker, "/export:?COMMA4@COStringA@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z")
#pragma comment(linker, "/export:?COMMA4_80@COStringA@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z")
#pragma comment(linker, "/export:?BIT128fromGUID@COStringA@System@RePag@@QEAQAEAY0BA@EAEAY0BA@E@Z")
#pragma comment(linker, "/export:?IsIntegralNumber@COStringA@System@RePag@@QEAQ_NXZ")
#pragma comment(linker, "/export:?IsFloatingPointNumber@COStringA@System@RePag@@QEAQ_NXZ")
#pragma comment(linker, "/export:?Uppercase@COStringA@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?Length@COStringA@System@RePag@@QEAQKXZ")
#pragma comment(linker, "/export:?SetLength@COStringA@System@RePag@@QEAQXK@Z")
#pragma comment(linker, "/export:?c_Str@COStringA@System@RePag@@QEAQPEADXZ")
#endif
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
#ifndef _64bit
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@XZ")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBX@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@PBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@PBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@K@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXK@Z")
#else
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@XZ")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBX@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBD@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBX@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBV312@@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@K@Z")
#pragma comment(linker, "/export:?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXK@Z")
#endif
#endif
    //---------------------------------------------------------------------------
  }
}