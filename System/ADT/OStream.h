/****************************************************************************
  OStream.h
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
#include "OZeit.h"
#include "OListe.h"
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    class _Export COStream
    {
    private:
      struct STElement
      {
        ULONG ulByte;
        VMBLOCK vbDaten;
      };
      COList lsDaten;
      CRITICAL_SECTION csStream;
      ULONG ulBytes;
      ULONG ulPosition;
      bool bThread;
      BYTE ucInfo;
      VMEMORY vmSpeicher;

    public:
      __thiscall COStream(_In_ bool bThreadSafe);
      __thiscall COStream(_In_ bool bThreadSafe, _In_ unsigned long ulSpinCount);
      __thiscall COStream(_In_ VMEMORY vmMemeory, _In_ bool bThreadSafe);
      __thiscall COStream(_In_ VMEMORY vmMemeory, _In_ bool bThreadSafe, _In_ unsigned long ulSpinCount);
      __thiscall ~COStream(void);
      VMEMORY __vectorcall COFreiV(void);
      void* __vectorcall Read(_In_ void* pvData, _In_ ULONG ulByte);
      void* __vectorcall Read(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulReadPosition);
      void __vectorcall Write(_In_ void* pvDaten, _In_ ULONG ulByte);
      void __vectorcall WriteS(_In_ void* pvData, _In_ ULONG ulByte);
      void __vectorcall Write(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulWritePosition);
      void __vectorcall WriteS(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulWritePosition);
      VMBLOCK __vectorcall Data(_In_ VMBLOCK& pvData);
      void __vectorcall Delete(void);
      bool __vectorcall End(void);
      DWORD __vectorcall ReadFile(_In_ HANDLE hFile, _In_ bool bAsynchronous);
      DWORD __vectorcall ReadFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait);
      DWORD __vectorcall WriteFile(_In_ HANDLE hFile, _In_ bool bAsynchronous);
      DWORD __vectorcall WriteFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait);
      COStringA* __vectorcall ReadStringA(_In_ COStringA* pasString, _In_ unsigned char ucStringtyp);
      void __vectorcall WriteStringA(_In_ COStringA* pasString, _In_ unsigned char ucStringtyp);
      char* __vectorcall ReadCHAR(_Inout_z_ VMBLOCK& pcString, _In_ unsigned char ucStringtyp);
      void __vectorcall WriteCHAR(_In_z_ char* pcString, _In_ unsigned char ucStringtyp);
      COTime* __vectorcall ReadTime(_In_ COTime* ptTime);
      void __vectorcall WriteTime(_In_ COTime* ptTime);
      COComma4* __vectorcall ReadComma4(_In_ COComma4* pk4Number);
      void __vectorcall WriteComma4(_In_ COComma4* pk4Number);
      COComma4_80* __vectorcall ReadComma4_80(_In_ COComma4_80* pk4Number_80);
      void __vectorcall WriteComma4_80(_In_ COComma4_80* pk4Number_80);
      ULONG __vectorcall Bytes(void);
      ULONG __vectorcall Position(void);
      ULONG __vectorcall SetPosition(_In_ long lDistance, _In_ char cFromWhere);
      void* __vectorcall ThRead(_In_ void* pvData, _In_ ULONG ulByte);
      void* __vectorcall ThRead(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulReadPosition);
      void __vectorcall ThWrite(_In_ void* pvData, _In_ ULONG ulByte);
      void __vectorcall ThWriteS(_In_ void* pvData, _In_ ULONG ulByte);
      void __vectorcall ThWrite(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulWritePosition);
      void __vectorcall ThWriteS(_In_ void* pvData, _In_ ULONG ulByte, _In_ ULONG& ulWritePosition);
      DWORD __vectorcall ThReadFile(_In_ HANDLE hFile, _In_ bool bAsynchronous);
      DWORD __vectorcall ThReadFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait);
      DWORD __vectorcall ThWriteFile(_In_ HANDLE hFile, _In_ bool bAsynchronous);
      DWORD __vectorcall ThWriteFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait);
      COStringA* __vectorcall ThReadStringA(_In_ COStringA* pasString, _In_ unsigned char ucStringtyp);
      void __vectorcall ThWriteStringA(_In_ COStringA* pasString, _In_ unsigned char ucStringtyp);
      char* __vectorcall ThReadCHAR(_Inout_z_ VMBLOCK& vbString, _In_ unsigned char ucStringtyp);
      void __vectorcall ThWriteCHAR(_In_z_ char* pcString, _In_ unsigned char ucStringtyp);
      COTime* __vectorcall ThReadTime(_In_ COTime* ptTime);
      void __vectorcall ThWriteTime(_In_ COTime* ptTime);
      COComma4* __vectorcall ThReadComma4(_In_ COComma4* pk4Number);
      void __vectorcall ThWriteComma4(_In_ COComma4* pk4Number);
      COComma4_80* __vectorcall ThReadComma4_80(_In_ COComma4_80* pk4Number_80);
      void __vectorcall ThWriteComma4_80(_In_ COComma4_80* pk4Number_80);
      ULONG* __vectorcall ThBytes(_In_ ULONG& ulBytes);
      ULONG* __vectorcall ThPosition(_In_ ULONG& ulPosition);
      ULONG __vectorcall ThSetPosition(_In_ long lDistance, _In_ char cFromWhere);
      VMBLOCK __vectorcall ThData(_In_ VMBLOCK& vbData);
      void __vectorcall ThDelete(void);
      bool __vectorcall ThEnd(void);
      BYTE __vectorcall GetLastError(void);
      BYTE* __vectorcall ThGetLastError(_In_ BYTE& ucError);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:??0COStream@System@RePag@@QAE@_N@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QAE@_NK@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QAE@PBX_N@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QAE@PBX_NK@Z")
#pragma comment(linker, "/export:??1COStream@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:?COFreiV@COStream@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:?Write@COStream@System@RePag@@QAQXPAXK@Z")
#pragma comment(linker, "/export:?WriteS@COStream@System@RePag@@QAQXPAXK@Z")
#pragma comment(linker, "/export:?ThWrite@COStream@System@RePag@@QAQXPAXK@Z")
#pragma comment(linker, "/export:?ThWriteS@COStream@System@RePag@@QAQXPAXK@Z")
#pragma comment(linker, "/export:?Read@COStream@System@RePag@@QAQPAXPAXK@Z")
#pragma comment(linker, "/export:?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z")
#pragma comment(linker, "/export:?Write@COStream@System@RePag@@QAQXPAXKAAK@Z")
#pragma comment(linker, "/export:?WriteS@COStream@System@RePag@@QAQXPAXKAAK@Z")
#pragma comment(linker, "/export:?ThWrite@COStream@System@RePag@@QAQXPAXKAAK@Z")
#pragma comment(linker, "/export:?ThWriteS@COStream@System@RePag@@QAQXPAXKAAK@Z")
#pragma comment(linker, "/export:?Read@COStream@System@RePag@@QAQPAXPAXKAAK@Z")
#pragma comment(linker, "/export:?ThRead@COStream@System@RePag@@QAQPAXPAXKAAK@Z")
#pragma comment(linker, "/export:?ReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z")
#pragma comment(linker, "/export:?ThReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z")
#pragma comment(linker, "/export:?WriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z")
#pragma comment(linker, "/export:?ThWriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z")
#pragma comment(linker, "/export:?ReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z")
#pragma comment(linker, "/export:?ThReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z")
#pragma comment(linker, "/export:?WriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z")
#pragma comment(linker, "/export:?ThWriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z")
#pragma comment(linker, "/export:?ReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z")
#pragma comment(linker, "/export:?ThReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z")
#pragma comment(linker, "/export:?WriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z")
#pragma comment(linker, "/export:?ThWriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z")
#pragma comment(linker, "/export:?ReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z")
#pragma comment(linker, "/export:?ThReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z")
#pragma comment(linker, "/export:?WriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z")
#pragma comment(linker, "/export:?ThWriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z")
#pragma comment(linker, "/export:?ReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z")
#pragma comment(linker, "/export:?ThReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z")
#pragma comment(linker, "/export:?WriteCHAR@COStream@System@RePag@@QAQXPADE@Z")
#pragma comment(linker, "/export:?ThWriteCHAR@COStream@System@RePag@@QAQXPADE@Z")
#pragma comment(linker, "/export:?ReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ThReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ReadFile@COStream@System@RePag@@QAQKPAX_N@Z")
#pragma comment(linker, "/export:?ThReadFile@COStream@System@RePag@@QAQKPAX_N@Z")
#pragma comment(linker, "/export:?WriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ThWriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?WriteFile@COStream@System@RePag@@QAQKPAX_N@Z")
#pragma comment(linker, "/export:?ThWriteFile@COStream@System@RePag@@QAQKPAX_N@Z")
#pragma comment(linker, "/export:?Data@COStream@System@RePag@@QAQPADAAPAD@Z")
#pragma comment(linker, "/export:?ThData@COStream@System@RePag@@QAQPADAAPAD@Z")
#pragma comment(linker, "/export:?Delete@COStream@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?ThDelete@COStream@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?End@COStream@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?ThEnd@COStream@System@RePag@@QAQ_NXZ")
#pragma comment(linker, "/export:?Bytes@COStream@System@RePag@@QAQKXZ")
#pragma comment(linker, "/export:?ThBytes@COStream@System@RePag@@QAQPAKAAK@Z")
#pragma comment(linker, "/export:?Position@COStream@System@RePag@@QAQKXZ")
#pragma comment(linker, "/export:?ThPosition@COStream@System@RePag@@QAQPAKAAK@Z")
#pragma comment(linker, "/export:?SetPosition@COStream@System@RePag@@QAQKJD@Z")
#pragma comment(linker, "/export:?ThSetPosition@COStream@System@RePag@@QAQKJD@Z")
#pragma comment(linker, "/export:?GetLastError@COStream@System@RePag@@QAQEXZ")
#pragma comment(linker, "/export:?ThGetLastError@COStream@System@RePag@@QAQPAEAAE@Z")
#else
#pragma comment(linker, "/export:??0COStream@System@RePag@@QEAA@_N@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QEAA@_NK@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QEAA@PEBX_N@Z")
#pragma comment(linker, "/export:??0COStream@System@RePag@@QEAA@PEBX_NK@Z")
#pragma comment(linker, "/export:??1COStream@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:?COFreiV@COStream@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:?Write@COStream@System@RePag@@QEAQXPEAXK@Z")
#pragma comment(linker, "/export:?WriteS@COStream@System@RePag@@QEAQXPEAXK@Z")
#pragma comment(linker, "/export:?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z")
#pragma comment(linker, "/export:?ThWriteS@COStream@System@RePag@@QEAQXPEAXK@Z")
#pragma comment(linker, "/export:?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z")
#pragma comment(linker, "/export:?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z")
#pragma comment(linker, "/export:?Write@COStream@System@RePag@@QEAQXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?WriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?ThWrite@COStream@System@RePag@@QEAQXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?ThWriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?Read@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?ThRead@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z")
#pragma comment(linker, "/export:?ReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z")
#pragma comment(linker, "/export:?ThReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z")
#pragma comment(linker, "/export:?WriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z")
#pragma comment(linker, "/export:?ThWriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z")
#pragma comment(linker, "/export:?ReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z")
#pragma comment(linker, "/export:?ThReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z")
#pragma comment(linker, "/export:?WriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z")
#pragma comment(linker, "/export:?ThWriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z")
#pragma comment(linker, "/export:?ReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z")
#pragma comment(linker, "/export:?ThReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z")
#pragma comment(linker, "/export:?WriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z")
#pragma comment(linker, "/export:?ThWriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z")
#pragma comment(linker, "/export:?ReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z")
#pragma comment(linker, "/export:?ThReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z")
#pragma comment(linker, "/export:?WriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z")
#pragma comment(linker, "/export:?ThWriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z")
#pragma comment(linker, "/export:?ReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z")
#pragma comment(linker, "/export:?ThReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z")
#pragma comment(linker, "/export:?WriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z")
#pragma comment(linker, "/export:?ThWriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z")
#pragma comment(linker, "/export:?ReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ThReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z")
#pragma comment(linker, "/export:?ThReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z")
#pragma comment(linker, "/export:?ThWriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?WriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z")
#pragma comment(linker, "/export:?WriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z")
#pragma comment(linker, "/export:?ThWriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z")
#pragma comment(linker, "/export:?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z")
#pragma comment(linker, "/export:?ThData@COStream@System@RePag@@QEAQPEADAEAPEAD@Z")
#pragma comment(linker, "/export:?Delete@COStream@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?ThDelete@COStream@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?End@COStream@System@RePag@@QEAQ_NXZ")
#pragma comment(linker, "/export:?ThEnd@COStream@System@RePag@@QEAQ_NXZ")
#pragma comment(linker, "/export:?Bytes@COStream@System@RePag@@QEAQKXZ")
#pragma comment(linker, "/export:?ThBytes@COStream@System@RePag@@QEAQPEAKAEAK@Z")
#pragma comment(linker, "/export:?Position@COStream@System@RePag@@QEAQKXZ")
#pragma comment(linker, "/export:?ThPosition@COStream@System@RePag@@QEAQPEAKAEAK@Z")
#pragma comment(linker, "/export:?SetPosition@COStream@System@RePag@@QEAQKJD@Z")
#pragma comment(linker, "/export:?ThSetPosition@COStream@System@RePag@@QEAQKJD@Z")
#pragma comment(linker, "/export:?GetLastError@COStream@System@RePag@@QEAQEXZ")
#pragma comment(linker, "/export:?ThGetLastError@COStream@System@RePag@@QEAQPEAEAEAE@Z")
#endif
#endif
    };
    //---------------------------------------------------------------------------
#define STM_POS_ANFANG -1
#define STM_POS_AKTUELL 0
#define STM_POS_ENDE 1
//---------------------------------------------------------------------------
    COStream* __vectorcall COStreamV(_In_ bool bThreadSafe);
    COStream* __vectorcall COStreamV(VMEMORY vmMemory, bool bThreadSafe);
    COStream* __vectorcall COStreamV(bool bThreadSicher, unsigned long ulSpinCount);
    COStream* __vectorcall COStreamV(VMEMORY vmMemory, bool bThreadSafe, unsigned long ulSpinCount);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPAVCOStream@12@_N@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPAVCOStream@12@_NK@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_N@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_NK@Z")
#else
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPEAVCOStream@12@_N@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPEAVCOStream@12@_NK@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_N@Z")
#pragma comment(linker, "/export:?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_NK@Z")
#endif
#endif
  }
}
