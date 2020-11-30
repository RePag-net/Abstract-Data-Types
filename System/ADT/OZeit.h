/****************************************************************************
  OZeit.h
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
#ifdef HADT
  #define _Export __declspec(dllexport)
#else
  #define _Export
#endif
#include "OStringA.h"
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    typedef struct STTime
    {
      USHORT usJahr;
      BYTE ucMonat;
      ULONG ulTag;
      BYTE ucStunde;
      BYTE ucMinute;
      BYTE ucSekunde;
      USHORT usMillisekunde;
    } STTime;
    //---------------------------------------------------------------------------
    class _Export COTime
    {
    private:
      struct STFZeit
      {
        FILETIME FZeit;
        FILETIME FZeit_A;
      };
      char c16FZeit[16];
      VMEMORY vmSpeicher;

    public:
      __thiscall COTime(void);
      __thiscall COTime(_In_z_ const char* pcString);
      __thiscall COTime(_In_ const COTime* ptTime);
      __thiscall COTime(_In_ const STTime& stTime);
      __thiscall COTime(_In_ const SYSTEMTIME& stSystemTime);
      VMEMORY __vectorcall COFreiV(void);
      COTime* __vectorcall Now(void);
      COTime* __vectorcall Today(void);
      COTime* __vectorcall Tommorow(void);
      bool __vectorcall IsZero(void);
      char* __vectorcall CHARDate(_In_z_ char* pc11Date);
      char* __vectorcall CHARTime(_In_z_ char* pc9Time);
      char* __vectorcall CHARDateTime(_In_z_ char* pc20DateTime);
      COStringA* __vectorcall StrDate(_In_ COStringA* pasDate);
      COStringA* __vectorcall StrTime(_In_ COStringA* pasTime);
      COStringA* __vectorcall StrDateTime(_In_ COStringA* pasDateTime);
      COStringA* __vectorcall StrDateFormat(_In_ COStringA* pasDate, _In_z_ const char* pcFormat);
      COStringA* __vectorcall StrTimeFormat(_In_ COStringA* pasTime, _In_z_ const char* pcFormat);
      COStringA* __vectorcall StrDateTimeFormat(_In_ COStringA* pasDateTime, _In_z_ const char* pcFormat_Date, _In_z_ const char* pcFormat_Time, _In_ bool bOrding_DateTime);
      VMBLOCK __vectorcall VMBLOCKDateFormat(_In_ VMBLOCK& vbDatum, _In_z_ const char* pcFormat);
      VMBLOCK __vectorcall VMBLOCKTimeFormat(_In_ VMBLOCK& vbZeit, _In_z_ const char* pcFormat);
      VMBLOCK __vectorcall VMBLOCKDateTimeFormat(_In_ VMBLOCK& vbDateTime, _In_z_ const char* pcFormat_Date, _In_z_ const char* pcFormat_Time, _In_ bool bOrding_DatumZeit);
      void __vectorcall operator =(_In_z_ const char* pcString);
      void __vectorcall operator =(_In_ const COTime& tTime);
      void __vectorcall operator =(_In_ const STTime& stTime);
      void __vectorcall operator =(_In_ const SYSTEMTIME& stSystemTime);
      bool __vectorcall operator <(_In_ const COTime& tTime);
      bool __vectorcall operator >(_In_ const COTime& tTime);
      bool __vectorcall operator <=(_In_ const COTime& tTime);
      bool __vectorcall operator >=(_In_ const COTime& tTime);
      bool __vectorcall operator ==(_In_ const COTime& tTime);
      bool __vectorcall operator !=(_In_ const COTime& tTime);
      void __vectorcall operator +=(_In_ const STTime& tTime);
      void __vectorcall operator +=(_In_ const long long llDiffSeconds);
      void __vectorcall operator -=(_In_ const STTime& stTime);
      void __vectorcall operator -=(_In_ const long long llDiffSecunds);
      COTime& __vectorcall operator +(_In_ const STTime& stTime);
      COTime& __vectorcall operator +(_In_ const long long llDiffSeconds);
      COTime& __vectorcall operator -(_In_ const STTime& stTime);
      COTime& __vectorcall operator -(_In_ const long long llDiffSeconds);
      void __vectorcall DifferenceTime(_In_ const COTime* ptTime, _In_ STTime& stTime);
      void __vectorcall Read(_In_z_ char* pcContent);
      void __vectorcall Write(_In_z_ const char* pcContent);
      FILETIME __vectorcall FileTime(void);
      SYSTEMTIME __vectorcall SystemTime(void);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COFreiV@COTime@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QAE@PBD@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QAE@PBV0@@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QAE@ABUSTTime@12@@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QAE@ABU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:?Now@COTime@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?Today@COTime@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?Tommorow@COTime@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?IsZero@COTime@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?CHARDate@COTime@System@RePag@@QAQPADPAD@Z")
#pragma comment(linker, "/export:?StrDate@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z")
#pragma comment(linker, "/export:?CHARTime@COTime@System@RePag@@QAQPADPAD@Z")
#pragma comment(linker, "/export:?StrTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z")
#pragma comment(linker, "/export:?CHARDateTime@COTime@System@RePag@@QAQPADPAD@Z")
#pragma comment(linker, "/export:?StrDateTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z")
#pragma comment(linker, "/export:?StrDateFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z")
#pragma comment(linker, "/export:?StrTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z")
#pragma comment(linker, "/export:?StrDateTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD1_N@Z")
#pragma comment(linker, "/export:?VMBLOCKDateFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z")
#pragma comment(linker, "/export:?VMBLOCKTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z")
#pragma comment(linker, "/export:?VMBLOCKDateTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD1_N@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QAQXPBD@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QAQXABUSTTime@12@@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QAQXABU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:??MCOTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??OCOTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??NCOTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??PCOTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??8COTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??9COTime@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??YCOTime@System@RePag@@QAQXABUSTTime@12@@Z")
#pragma comment(linker, "/export:??YCOTime@System@RePag@@QAQX_J@Z")
#pragma comment(linker, "/export:??ZCOTime@System@RePag@@QAQXABUSTTime@12@@Z")
#pragma comment(linker, "/export:??ZCOTime@System@RePag@@QAQX_J@Z")
#pragma comment(linker, "/export:??HCOTime@System@RePag@@QAQAAV012@_J@Z")
#pragma comment(linker, "/export:??HCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z")
#pragma comment(linker, "/export:??GCOTime@System@RePag@@QAQAAV012@_J@Z")
#pragma comment(linker, "/export:??GCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z")
#pragma comment(linker, "/export:?DifferenceTime@COTime@System@RePag@@QAQXPBV123@AAUSTTime@23@@Z")
#pragma comment(linker, "/export:?Read@COTime@System@RePag@@QAQXPAD@Z")
#pragma comment(linker, "/export:?Write@COTime@System@RePag@@QAQXPBD@Z")
#pragma comment(linker, "/export:?FileTime@COTime@System@RePag@@QAQ?AU_FILETIME@@XZ")
#pragma comment(linker, "/export:?SystemTime@COTime@System@RePag@@QAQ?AU_SYSTEMTIME@@XZ")
#else
#pragma comment(linker, "/export:?COFreiV@COTime@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QEAA@PEBD@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QEAA@PEBV012@@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QEAA@AEBUSTTime@12@@Z")
#pragma comment(linker, "/export:??0COTime@System@RePag@@QEAA@AEBU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:?Now@COTime@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?Today@COTime@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?Tommorow@COTime@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?IsZero@COTime@System@RePag@@QEAQ_NXZ")
#pragma comment(linker, "/export:?CHARDate@COTime@System@RePag@@QEAQPEADPEAD@Z")
#pragma comment(linker, "/export:?StrDate@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z")
#pragma comment(linker, "/export:?CHARTime@COTime@System@RePag@@QEAQPEADPEAD@Z")
#pragma comment(linker, "/export:?StrTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z")
#pragma comment(linker, "/export:?CHARDateTime@COTime@System@RePag@@QEAQPEADPEAD@Z")
#pragma comment(linker, "/export:?StrDateTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z")
#pragma comment(linker, "/export:?StrDateFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z")
#pragma comment(linker, "/export:?StrTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z")
#pragma comment(linker, "/export:?StrDateTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD1_N@Z")
#pragma comment(linker, "/export:?VMBLOCKDateFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z")
#pragma comment(linker, "/export:?VMBLOCKTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z")
#pragma comment(linker, "/export:?VMBLOCKDateTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD1_N@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QEAQXPEBD@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QEAQXAEBUSTTime@12@@Z")
#pragma comment(linker, "/export:??4COTime@System@RePag@@QEAQXAEBU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:??MCOTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??OCOTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??NCOTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??PCOTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??8COTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??9COTime@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??YCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z")
#pragma comment(linker, "/export:??YCOTime@System@RePag@@QEAQX_J@Z")
#pragma comment(linker, "/export:??ZCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z")
#pragma comment(linker, "/export:??ZCOTime@System@RePag@@QEAQX_J@Z")
#pragma comment(linker, "/export:??HCOTime@System@RePag@@QEAQAEAV012@_J@Z")
#pragma comment(linker, "/export:??HCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z")
#pragma comment(linker, "/export:??GCOTime@System@RePag@@QEAQAEAV012@_J@Z")
#pragma comment(linker, "/export:??GCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z")
#pragma comment(linker, "/export:?DifferenceTime@COTime@System@RePag@@QEAQXPEBV123@AEAUSTTime@23@@Z")
#pragma comment(linker, "/export:?Read@COTime@System@RePag@@QEAQXPEAD@Z")
#pragma comment(linker, "/export:?Write@COTime@System@RePag@@QEAQXPEBD@Z")
#pragma comment(linker, "/export:?FileTime@COTime@System@RePag@@QEAQ?AU_FILETIME@@XZ")
#pragma comment(linker, "/export:?SystemTime@COTime@System@RePag@@QEAQ?AU_SYSTEMTIME@@XZ")
#endif
#endif
    };
    //---------------------------------------------------------------------------
    COTime* __vectorcall COTimeV(void);
    COTime* __vectorcall COTimeV(_In_ VMEMORY vmSpeicher);
    COTime* __vectorcall COTimeV(_In_z_ const char* pcString);
    COTime* __vectorcall COTimeV(_In_ VMEMORY vmSpeicher, _In_z_ const char* pcString);
    COTime* __vectorcall COTimeV(_In_ const COTime* ptTime);
    COTime* __vectorcall COTimeV(_In_ VMEMORY vmSpeicher, _In_ const COTime* ptTime);
    COTime* __vectorcall COTimeV(_In_ const STTime& stTime);
    COTime* __vectorcall COTimeV(_In_ VMEMORY vmSpeicher, const _In_ STTime& stTime);
    COTime* __vectorcall COTimeV(_In_ const SYSTEMTIME& stSystemTime);
    COTime* __vectorcall COTimeV(_In_ VMEMORY vmSpeicher, _In_ const SYSTEMTIME& stSystemTime);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@XZ")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBX@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBD@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@ABU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBD@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBV312@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBV312@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@ABUSTTime@12@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABUSTTime@12@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABU_SYSTEMTIME@@@Z")
#else
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@XZ")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBX@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBD@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBD@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBU_SYSTEMTIME@@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBV312@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBV312@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBUSTTime@12@@Z")
#pragma comment(linker, "/export:?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBUSTTime@12@@Z")
#endif
#endif
  }
}
