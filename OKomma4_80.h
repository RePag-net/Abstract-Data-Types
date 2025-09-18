/******************************************************************************
MIT License

Copyright(c) 2025 René Pagel

Filename: OKomma4_80.h
For more information see https://github.com/RePag-net/Abstract-Data-Types

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files(the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions :

The above copyright notice and this permission notice shall be included in all
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
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    class _Export COComma4_80
    {
    private:
      struct STComma4_80
      {
        long long llPreComma;
        long long llPreComma_A;
        short sAfterComma;
        short sAfterComma_A;
      };
      char c20Comma4_80[20];
      VMEMORY vmMemory;

    public:
      __thiscall COComma4_80(void);
      __thiscall COComma4_80(_In_ const double dZahl);
      __thiscall COComma4_80(_In_ const int iZahl);
      __thiscall COComma4_80(_In_ const long long llZahl);
      __thiscall COComma4_80(_In_ const COComma4& k4Zahl);
      __thiscall COComma4_80(_In_ const COComma4_80& k4_80Zahl);
      __thiscall COComma4_80(_In_ const __m128i m128iZahl);
      __thiscall COComma4_80(_In_ const __m128d m128dZahl);
      VMEMORY __vectorcall COFreiV(void);
      void __vectorcall operator =(_In_ const double dZahl);
      void __vectorcall operator =(_In_ const int iZahl);
      void __vectorcall operator =(_In_ const long long llZahl);
      void __vectorcall operator =(_In_ const COComma4& k4Zahl);
      void __vectorcall operator =(_In_ const COComma4_80& k4gZahl);
      void __vectorcall operator =(_In_ const __m128i m128iZahl);
      void __vectorcall operator =(_In_ const __m128d m128dZahl);
      void __vectorcall operator +=(_In_ const COComma4& k4Zahl);
      void __vectorcall operator +=(_In_ const COComma4_80& k4gZahl);
      COComma4_80& __vectorcall operator +(_In_ const COComma4& k4Zahl);
      COComma4_80& __vectorcall operator +(_In_ const COComma4_80& k4gZahl);
      void __vectorcall operator -=(_In_ const COComma4& k4Zahl);
      void __vectorcall operator -=(_In_ const COComma4_80& k4gZahl);
      COComma4_80& __vectorcall operator -(_In_ const COComma4& k4Zahl);
      COComma4_80& __vectorcall operator -(_In_ const COComma4_80& k4gZahl);
      void __vectorcall operator *=(_In_ const COComma4& k4Zahl);
      void __vectorcall operator *=(_In_ const COComma4_80& k4gZahl);
      COComma4_80& __vectorcall operator *(_In_ const COComma4& k4Zahl);
      COComma4_80& __vectorcall operator *(_In_ const COComma4_80& k4gZahl);
      void __vectorcall operator /=(_In_ const COComma4& k4Zahl);
      void __vectorcall operator /=(_In_ const COComma4_80& k4gZahl);
      COComma4_80& __vectorcall operator /(_In_ const COComma4& k4Zahl);
      COComma4_80& __vectorcall operator /(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator <(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator <(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator >(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator >(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator <=(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator <=(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator >=(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator >=(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator ==(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator ==(_In_ const COComma4_80& k4gZahl);
      bool __vectorcall operator !=(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator !=(_In_ const COComma4_80& k4gZahl);
      void __vectorcall operator ++(void);
      void __vectorcall operator ++(_In_ int i);
      void __vectorcall operator --(void);
      void __vectorcall operator --(_In_ int i);
      char __vectorcall Compare(_In_ const COComma4* pk4Zahl);
      char __vectorcall Compare(_In_ const COComma4_80* pk4gZahl);
      void __vectorcall Write(_Out_writes_(10) const char c10Zahl[10]);
      void __vectorcall Read(_In_reads_(10) const char c10Zahl[10]);
      long long __vectorcall PreComma(void);
      short __vectorcall AfterComma(void);
      float __vectorcall FLOAT(void);
      double __vectorcall DOUBLE(void);
      __m128d __vectorcall M128D(void);
      void __vectorcall SetZero(void);
      COComma4_80* __vectorcall Round(_In_ const unsigned char ucStellen);
      void __vectorcall PresignChange(void);
      COComma4_80* __vectorcall pi(void);
      COComma4_80* __vectorcall pi_10e18(void);
      double __vectorcall sin(void);
      double __vectorcall cos(void);
      double __vectorcall tan(void);
      double __vectorcall Squareroot(void);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@N@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@H@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@_J@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@ABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@ABV012@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@T__m128i@@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QAE@U__m128d@@@Z")
#pragma comment(linker, "/export:?COFreiV@COComma4_80@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXN@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQX_J@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXABVCOComma4@@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXABV0@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXT__m128i@@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QAQXU__m128d@@@Z")
#pragma comment(linker, "/export:??YCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??YCOComma4_80@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??HCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??HCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??ZCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??ZCOComma4_80@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??GCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??GCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??XCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??XCOComma4_80@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??DCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??DCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??_0COComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??_0COComma4_80@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??KCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??KCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??MCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??MCOComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??OCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??OCOComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??NCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??NCOComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??PCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??PCOComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??8COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??8COComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??9COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z")
#pragma comment(linker, "/export:??9COComma4_80@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??ECOComma4_80@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:??ECOComma4_80@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4_80@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:??FCOComma4_80@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:?Compare@COComma4_80@System@RePag@@QAQDPBVCOComma4@23@@Z")
#pragma comment(linker, "/export:?Compare@COComma4_80@System@RePag@@QAQDPBV123@@Z")
#pragma comment(linker, "/export:?Write@COComma4_80@System@RePag@@QAQXQBD@Z")
#pragma comment(linker, "/export:?Read@COComma4_80@System@RePag@@QAQXQBD@Z")
#pragma comment(linker, "/export:?PreComma@COComma4_80@System@RePag@@QAQ_JXZ")
#pragma comment(linker, "/export:?AfterComma@COComma4_80@System@RePag@@QAQFXZ")
#pragma comment(linker, "/export:?FLOAT@COComma4_80@System@RePag@@QAQMXZ")
#pragma comment(linker, "/export:?DOUBLE@COComma4_80@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?M128D@COComma4_80@System@RePag@@QAQ?AU__m128d@@XZ")
#pragma comment(linker, "/export:?SetZero@COComma4_80@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?Round@COComma4_80@System@RePag@@QAQPAV123@E@Z")
#pragma comment(linker, "/export:?PresignChange@COComma4_80@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?pi@COComma4_80@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?pi_10e18@COComma4_80@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?sin@COComma4_80@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?cos@COComma4_80@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?tan@COComma4_80@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?Squareroot@COComma4_80@System@RePag@@QAQNXZ")
#else
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@N@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@H@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@_J@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@AEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@AEBV012@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@T__m128i@@@Z")
#pragma comment(linker, "/export:??0COComma4_80@System@RePag@@QEAA@U__m128d@@@Z")
#pragma comment(linker, "/export:?COFreiV@COComma4_80@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXN@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQX_J@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXT__m128i@@@Z")
#pragma comment(linker, "/export:??4COComma4_80@System@RePag@@QEAQXU__m128d@@@Z")
#pragma comment(linker, "/export:??YCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??ZCOComma4_80@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??ZCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??ZCOComma4_80@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??XCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??XCOComma4_80@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??_0COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??_0COComma4_80@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??MCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??MCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??OCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??OCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??NCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??NCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??PCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??PCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??8COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??8COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??9COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:??9COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??ECOComma4_80@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:??ECOComma4_80@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4_80@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4_80@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?Compare@COComma4_80@System@RePag@@QEAQDPEBVCOComma4@23@@Z")
#pragma comment(linker, "/export:?Compare@COComma4_80@System@RePag@@QEAQDPEBV123@@Z")
#pragma comment(linker, "/export:?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z")
#pragma comment(linker, "/export:?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z")
#pragma comment(linker, "/export:?PreComma@COComma4_80@System@RePag@@QEAQ_JXZ")
#pragma comment(linker, "/export:?AfterComma@COComma4_80@System@RePag@@QEAQFXZ")
#pragma comment(linker, "/export:?FLOAT@COComma4_80@System@RePag@@QEAQMXZ")
#pragma comment(linker, "/export:?DOUBLE@COComma4_80@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?M128D@COComma4_80@System@RePag@@QEAQ?AU__m128d@@XZ")
#pragma comment(linker, "/export:?SetZero@COComma4_80@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?Round@COComma4_80@System@RePag@@QEAQPEAV123@E@Z")
#pragma comment(linker, "/export:?PresignChange@COComma4_80@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?pi@COComma4_80@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?pi_10e18@COComma4_80@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?sin@COComma4_80@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?cos@COComma4_80@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?tan@COComma4_80@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?Squareroot@COComma4_80@System@RePag@@QEAQNXZ")
#endif
#endif
    };
    //---------------------------------------------------------------------------
    COComma4_80* __vectorcall COComma4_80V(void);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher);
    COComma4_80* __vectorcall COComma4_80V(_In_ const double dZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const double dZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const int iZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const int iZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const long long llZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const long long llZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const COComma4* pk4Zahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const COComma4* pk4Zahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const COComma4_80* pk4gZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const COComma4_80* pk4gZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const __m128i m128iZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const __m128i m128iZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const __m128d m128dZahl);
    COComma4_80* __vectorcall COComma4_80V(_In_ const VMEMORY vmSpeicher, _In_ const __m128d m128dZahl);
    //---------------------------------------------------------------------------
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@XZ")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@N@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXN@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@H@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXH@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@_J@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX_J@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBVCOComma4@12@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPAVCOComma4@12@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBV312@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPBV312@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@T__m128i@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXT__m128i@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@U__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXU__m128d@@@Z")
#else
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@XZ")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@N@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXN@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@H@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXH@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@_J@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX_J@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBVCOComma4@12@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEAVCOComma4@12@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBV312@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEBV312@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@U__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXU__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@T__m128i@@@Z")
#pragma comment(linker, "/export:?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXT__m128i@@@Z")
#endif
#endif  
    //---------------------------------------------------------------------------
  }
}