/****************************************************************************
  OListe.h
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
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    class _Export COList
    {
    private:
      struct STKnoten
      {
        STKnoten* pstNachster;
        void* pvDaten;
      };
      STKnoten* pstErster;
      STKnoten* pstLetzter;
      CRITICAL_SECTION csIterator;
      ULONG ulAnzahl;
      bool bThread;
      VMEMORY vmSpeicher;

    public:
      __thiscall COList(_In_ bool bThreadSicher);
      __thiscall COList(_In_ bool bThreadSicher, _In_ unsigned long ulSpinCount);
      __thiscall COList(_In_ VMEMORY vmSpeicher, _In_ bool bThreadSicher);
      __thiscall COList(_In_ VMEMORY vmSpeicher, _In_ bool bThreadSicher, _In_ unsigned long ulSpinCount);
      __thiscall ~COList(void);
      VMEMORY __vectorcall COFreiV(void);
      void* __vectorcall ToBegin(_In_ void* pvDaten);
      void* __vectorcall ToBeginS(_In_ void* pvDaten);
      void* __vectorcall ToEnd(_In_ void* pvDaten);
      void* __vectorcall ToEndS(_In_ void* pvDaten);
      void* __vectorcall Element(_In_ ULONG ulIndex);
      void* __vectorcall Element(_In_ void* pstKnoten);
      void __vectorcall NextElement(_In_ void*& pstKnoten);
      void __vectorcall NextElement(_In_ void*& pstKnotenAktuell, _In_ void*& pstKnotenVorheriger);
      void* __vectorcall Insert(_In_ void*& pstKnotenAktuell, _In_ void*& pstKnotenVorheriger, _In_ void* pvDaten);
      void* __vectorcall InsertS(_In_ void*& pstKnotenAktuell, _In_ void*& pstKnotenVorheriger, _In_ void* pvDaten);
      void __vectorcall DeleteElement(_In_ ULONG ulIndex, _In_ bool bDeleteData);
      void __vectorcall DeleteElementS(_In_ ULONG ulIndex, _In_ bool bDatenLoschen);
      void __vectorcall DeleteElement(_In_ void*& pstKnoten, _In_ void*& pstLoschen, _In_ bool bDatenLoschen);
      void __vectorcall DeleteElementS(_In_ void*& pstKnoten, _In_ void*& pstLoschen, _In_ bool bDatenLoschen);
      void __vectorcall DeleteFirstElement(_In_ void*& pstNode, _In_ bool bDeleteData);
      void __vectorcall DeleteFirstElementS(_In_ void*& pstNode, _In_ bool bDeleteData);
      void __vectorcall DeleteList(_In_ bool bDatenLoschen);
      void __vectorcall DeleteListS(_In_ bool bDatenLoschen);
      void* __vectorcall ThToBegin(_In_ void* pvDaten);
      void* __vectorcall ThToBeginS(_In_ void* pvDaten);
      void* __vectorcall ThToEnd(_In_ void* pvDaten);
      void* __vectorcall ThToEndS(_In_ void* pvDaten);
      void* __vectorcall ThElement(unsigned long ulIndex);
      void __vectorcall ThDeleteElement(_In_ unsigned long ulIndex, _In_ bool bDatenLoschen);
      void __vectorcall ThDeleteElementS(_In_ unsigned long ulIndex, _In_ bool bDatenLoschen);
      void __vectorcall ThDeleteList(_In_ bool bDatenLoschen);
      void __vectorcall ThDeleteListS(_In_ bool bDatenLoschen);
      ULONG __vectorcall Number(void);
      ULONG& __vectorcall ThNumber(_In_ unsigned long& ulAnzahlA);
      void* __vectorcall IteratorToBegin(void);
      void* __vectorcall ThIteratorToBegin(void);
      void* __vectorcall ThIteratorToBegin_Lock(void);
      void __vectorcall ThIteratorEnd(void);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:??0COList@System@RePag@@QAE@_N@Z")
#pragma comment(linker, "/export:??1COList@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:??0COList@System@RePag@@QAE@_NK@Z")
#pragma comment(linker, "/export:??0COList@System@RePag@@QAE@PBX_N@Z")
#pragma comment(linker, "/export:??0COList@System@RePag@@QAE@PBX_NK@Z")
#pragma comment(linker, "/export:?ToBegin@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ToBeginS@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ThToBegin@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ThToBeginS@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ToEnd@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ToEndS@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ThToEnd@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?ThToEndS@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?Element@COList@System@RePag@@QAQPAXK@Z")
#pragma comment(linker, "/export:?ThElement@COList@System@RePag@@QAQPAXK@Z")
#pragma comment(linker, "/export:?Element@COList@System@RePag@@QAQPAXPAX@Z")
#pragma comment(linker, "/export:?NextElement@COList@System@RePag@@QAQXAAPAX@Z")
#pragma comment(linker, "/export:?NextElement@COList@System@RePag@@QAQXAAPAX0@Z")
#pragma comment(linker, "/export:?DeleteElement@COList@System@RePag@@QAQXAAPAX0_N@Z")
#pragma comment(linker, "/export:?DeleteElementS@COList@System@RePag@@QAQXAAPAX0_N@Z")
#pragma comment(linker, "/export:?DeleteFirstElement@COList@System@RePag@@QAQXAAPAX_N@Z")
#pragma comment(linker, "/export:?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z")
#pragma comment(linker, "/export:?DeleteElement@COList@System@RePag@@QAQXK_N@Z")
#pragma comment(linker, "/export:?DeleteElementS@COList@System@RePag@@QAQXK_N@Z")
#pragma comment(linker, "/export:?ThDeleteElement@COList@System@RePag@@QAQXK_N@Z")
#pragma comment(linker, "/export:?ThDeleteElementS@COList@System@RePag@@QAQXK_N@Z")
#pragma comment(linker, "/export:?DeleteList@COList@System@RePag@@QAQX_N@Z")
#pragma comment(linker, "/export:?DeleteListS@COList@System@RePag@@QAQX_N@Z")
#pragma comment(linker, "/export:?ThDeleteList@COList@System@RePag@@QAQX_N@Z")
#pragma comment(linker, "/export:?ThDeleteListS@COList@System@RePag@@QAQX_N@Z")
#pragma comment(linker, "/export:?COFreiV@COList@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:?Insert@COList@System@RePag@@QAQPAXAAPAX0PAX@Z")
#pragma comment(linker, "/export:?InsertS@COList@System@RePag@@QAQPAXAAPAX0PAX@Z")
#pragma comment(linker, "/export:?Number@COList@System@RePag@@QAQKXZ")
#pragma comment(linker, "/export:?ThNumber@COList@System@RePag@@QAQAAKAAK@Z")
#pragma comment(linker, "/export:?IteratorToBegin@COList@System@RePag@@QAQPAXXZ")
#pragma comment(linker, "/export:?ThIteratorToBegin@COList@System@RePag@@QAQPAXXZ")
#pragma comment(linker, "/export:?ThIteratorToBegin_Lock@COList@System@RePag@@QAQPAXXZ")
#pragma comment(linker, "/export:?ThIteratorEnd@COList@System@RePag@@QAQXXZ")
#else
#pragma comment(linker, "/export:??0COList@System@RePag@@QEAA@_N@Z")
#pragma comment(linker, "/export:??1COList@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:??0COList@System@RePag@@QEAA@_NK@Z")
#pragma comment(linker, "/export:??0COList@System@RePag@@QEAA@PEBX_N@Z")
#pragma comment(linker, "/export:??0COList@System@RePag@@QEAA@PEBX_NK@Z")
#pragma comment(linker, "/export:?ToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ThToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ThToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ThToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?ThToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?Element@COList@System@RePag@@QEAQPEAXK@Z")
#pragma comment(linker, "/export:?ThElement@COList@System@RePag@@QEAQPEAXK@Z")
#pragma comment(linker, "/export:?Element@COList@System@RePag@@QEAQPEAXPEAX@Z")
#pragma comment(linker, "/export:?NextElement@COList@System@RePag@@QEAQXAEAPEAX@Z")
#pragma comment(linker, "/export:?NextElement@COList@System@RePag@@QEAQXAEAPEAX0@Z")
#pragma comment(linker, "/export:?DeleteElement@COList@System@RePag@@QEAQXAEAPEAX0_N@Z")
#pragma comment(linker, "/export:?DeleteElementS@COList@System@RePag@@QEAQXAEAPEAX0_N@Z")
#pragma comment(linker, "/export:?DeleteFirstElement@COList@System@RePag@@QEAQXAEAPEAX_N@Z")
#pragma comment(linker, "/export:?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z")
#pragma comment(linker, "/export:?DeleteElement@COList@System@RePag@@QEAQXK_N@Z")
#pragma comment(linker, "/export:?DeleteElementS@COList@System@RePag@@QEAQXK_N@Z")
#pragma comment(linker, "/export:?ThDeleteElement@COList@System@RePag@@QEAQXK_N@Z")
#pragma comment(linker, "/export:?ThDeleteElementS@COList@System@RePag@@QEAQXK_N@Z")
#pragma comment(linker, "/export:?DeleteList@COList@System@RePag@@QEAQX_N@Z")
#pragma comment(linker, "/export:?DeleteListS@COList@System@RePag@@QEAQX_N@Z")
#pragma comment(linker, "/export:?ThDeleteList@COList@System@RePag@@QEAQX_N@Z")
#pragma comment(linker, "/export:?ThDeleteListS@COList@System@RePag@@QEAQX_N@Z")
#pragma comment(linker, "/export:?COFreiV@COList@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:?Insert@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z")
#pragma comment(linker, "/export:?InsertS@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z")
#pragma comment(linker, "/export:?Number@COList@System@RePag@@QEAQKXZ")
#pragma comment(linker, "/export:?ThNumber@COList@System@RePag@@QEAQAEAKAEAK@Z")
#pragma comment(linker, "/export:?IteratorToBegin@COList@System@RePag@@QEAQPEAXXZ")
#pragma comment(linker, "/export:?ThIteratorToBegin@COList@System@RePag@@QEAQPEAXXZ")
#pragma comment(linker, "/export:?ThIteratorToBegin_Lock@COList@System@RePag@@QEAQPEAXXZ")
#pragma comment(linker, "/export:?ThIteratorEnd@COList@System@RePag@@QEAQXXZ")
#endif
#endif
    };
    //---------------------------------------------------------------------------
    COList* __vectorcall COListV(bool bThreadSicher);
    COList* __vectorcall COListV(bool bThreadSicher, unsigned long ulSpinCount);
    COList* __vectorcall COListV(VMEMORY vmSpeicher, bool bThreadSicher);
    COList* __vectorcall COListV(VMEMORY vmSpeicher, bool bThreadSicher, unsigned long ulSpinCount);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPAVCOList@12@_N@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPAVCOList@12@_NK@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPAVCOList@12@PBX_N@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPAVCOList@12@PBX_NK@Z")
#else
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPEAVCOList@12@_N@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPEAVCOList@12@_NK@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPEAVCOList@12@PEBX_N@Z")
#pragma comment(linker, "/export:?COListV@System@RePag@@YQPEAVCOList@12@PEBX_NK@Z")
#endif
#endif
    //---------------------------------------------------------------------------
  }
}
