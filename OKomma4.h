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
    class _Export COComma4
    {
    private:
      struct STComma4
      {
        long lPreComma;
        long lPreComma_A;
        short sAftercomma;
        short sAfterComma_A;
      };
      char c12Comma4[12];
      VMEMORY vmMemeory;

    public:
      __thiscall COComma4(void);
      __thiscall COComma4(_In_ const double dZahl);
      __thiscall COComma4(_In_ const int iZahl);
      __thiscall COComma4(_In_ const COComma4& k4Zahl);
      __thiscall COComma4(_In_ const __m128i m128iZahl);
      __thiscall COComma4(_In_ const __m128d m128dZahl);
      VMEMORY __vectorcall COFreiV(void);
      void __vectorcall operator =(_In_ const double dZahl);
      void __vectorcall operator =(_In_ const int iZahl);
      void __vectorcall operator =(_In_ const COComma4& k4Zahl);
      void __vectorcall operator =(_In_ const __m128i m128iZahl);
      void __vectorcall operator =(_In_ const __m128d m128dZahl);
      void __vectorcall operator +=(_In_ const COComma4& k4Zahl);
      COComma4& __vectorcall operator +(_In_ const COComma4& k4Zahl);
      void __vectorcall operator -=(_In_ const COComma4& k4Zahl);
      COComma4& __vectorcall operator -(_In_ const COComma4& k4Zahl);
      void __vectorcall operator *=(_In_ const COComma4& k4Zahl);
      COComma4& __vectorcall operator *(_In_ const COComma4& k4Zahl);
      void __vectorcall operator /=(_In_ const COComma4& k4Zahl);
      COComma4& __vectorcall operator /(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator <(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator >(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator <=(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator >=(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator ==(_In_ const COComma4& k4Zahl);
      bool __vectorcall operator !=(_In_ const COComma4& k4Zahl);
      void __vectorcall operator ++(void);
      void __vectorcall operator ++(_In_ int i);
      void __vectorcall operator --(void);
      void __vectorcall operator --(_In_ int i);
      char __vectorcall Compare(_In_ const COComma4* pk4Zahl);
      void __vectorcall Write(_In_reads_(6) const char cZahl[6]);
      void __vectorcall Read(_Out_writes_(6) const char cZahl[6]);
      long __vectorcall PreComma(void);
      short __vectorcall AfterComma(void);
      float __vectorcall FLOAT(void);
      double __vectorcall DOUBLE(void);
      __m128d __vectorcall M128D(void);
      void __vectorcall SetZero(void);
      COComma4* __vectorcall Round(_In_ const unsigned char ucStellen);
      void __vectorcall PresignChange(void);
      COComma4* __vectorcall pi(void);
      COComma4* __vectorcall pi_10e8(void);
      double __vectorcall sin(void);
      double __vectorcall cos(void);
      double __vectorcall tan(void);
      double __vectorcall Squareroot(void);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@XZ")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@N@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@H@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@ABV012@@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@T__m128i@@@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QAE@U__m128d@@@Z")
#pragma comment(linker, "/export:?COFreiV@COComma4@System@RePag@@QAQPBXXZ")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QAQXN@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QAQXT__m128i@@@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QAQXU__m128d@@@Z")
#pragma comment(linker, "/export:??YCOComma4@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??HCOComma4@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??ZCOComma4@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??GCOComma4@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??XCOComma4@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??DCOComma4@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??_0COComma4@System@RePag@@QAQXABV012@@Z")
#pragma comment(linker, "/export:??KCOComma4@System@RePag@@QAQAAV012@ABV012@@Z")
#pragma comment(linker, "/export:??MCOComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??OCOComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??NCOComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??PCOComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??8COComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??9COComma4@System@RePag@@QAQ_NABV012@@Z")
#pragma comment(linker, "/export:??ECOComma4@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:??ECOComma4@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:??FCOComma4@System@RePag@@QAQXH@Z")
#pragma comment(linker, "/export:?Compare@COComma4@System@RePag@@QAQDPBV123@@Z")
#pragma comment(linker, "/export:?Write@COComma4@System@RePag@@QAQXQBD@Z")
#pragma comment(linker, "/export:?Read@COComma4@System@RePag@@QAQXQBD@Z")
#pragma comment(linker, "/export:?PreComma@COComma4@System@RePag@@QAQJXZ")
#pragma comment(linker, "/export:?AfterComma@COComma4@System@RePag@@QAQFXZ")
#pragma comment(linker, "/export:?FLOAT@COComma4@System@RePag@@QAQMXZ")
#pragma comment(linker, "/export:?DOUBLE@COComma4@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?M128D@COComma4@System@RePag@@QAQ?AU__m128d@@XZ")
#pragma comment(linker, "/export:?SetZero@COComma4@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?Round@COComma4@System@RePag@@QAQPAV123@E@Z")
#pragma comment(linker, "/export:?PresignChange@COComma4@System@RePag@@QAQXXZ")
#pragma comment(linker, "/export:?pi@COComma4@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?pi_10e8@COComma4@System@RePag@@QAQPAV123@XZ")
#pragma comment(linker, "/export:?sin@COComma4@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?cos@COComma4@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?tan@COComma4@System@RePag@@QAQNXZ")
#pragma comment(linker, "/export:?Squareroot@COComma4@System@RePag@@QAQNXZ")
#else
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@XZ")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@N@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@H@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@AEBV012@@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@T__m128i@@@Z")
#pragma comment(linker, "/export:??0COComma4@System@RePag@@QEAA@U__m128d@@@Z")
#pragma comment(linker, "/export:?COFreiV@COComma4@System@RePag@@QEAQPEBXXZ")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QEAQXN@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QEAQXT__m128i@@@Z")
#pragma comment(linker, "/export:??4COComma4@System@RePag@@QEAQXU__m128d@@@Z")
#pragma comment(linker, "/export:??YCOComma4@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??HCOComma4@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??ZCOComma4@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??GCOComma4@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??XCOComma4@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??DCOComma4@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??_0COComma4@System@RePag@@QEAQXAEBV012@@Z")
#pragma comment(linker, "/export:??KCOComma4@System@RePag@@QEAQAEAV012@AEBV012@@Z")
#pragma comment(linker, "/export:??MCOComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??OCOComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??NCOComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??PCOComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??8COComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??9COComma4@System@RePag@@QEAQ_NAEBV012@@Z")
#pragma comment(linker, "/export:??ECOComma4@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:??ECOComma4@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4@System@RePag@@QEAQXH@Z")
#pragma comment(linker, "/export:??FCOComma4@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?Compare@COComma4@System@RePag@@QEAQDPEBV123@@Z")
#pragma comment(linker, "/export:?Write@COComma4@System@RePag@@QEAQXQEBD@Z")
#pragma comment(linker, "/export:?Read@COComma4@System@RePag@@QEAQXQEBD@Z")
#pragma comment(linker, "/export:?PreComma@COComma4@System@RePag@@QEAQJXZ")
#pragma comment(linker, "/export:?AfterComma@COComma4@System@RePag@@QEAQFXZ")
#pragma comment(linker, "/export:?FLOAT@COComma4@System@RePag@@QEAQMXZ")
#pragma comment(linker, "/export:?DOUBLE@COComma4@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?M128D@COComma4@System@RePag@@QEAQ?AU__m128d@@XZ")
#pragma comment(linker, "/export:?SetZero@COComma4@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?Round@COComma4@System@RePag@@QEAQPEAV123@E@Z")
#pragma comment(linker, "/export:?PresignChange@COComma4@System@RePag@@QEAQXXZ")
#pragma comment(linker, "/export:?pi@COComma4@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?pi_10e8@COComma4@System@RePag@@QEAQPEAV123@XZ")
#pragma comment(linker, "/export:?sin@COComma4@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?cos@COComma4@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?tan@COComma4@System@RePag@@QEAQNXZ")
#pragma comment(linker, "/export:?Squareroot@COComma4@System@RePag@@QEAQNXZ")
#endif
#endif
    };
    //---------------------------------------------------------------------------
    COComma4* __vectorcall COComma4V(void);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher);
    COComma4* __vectorcall COComma4V(_In_ const double dZahl);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher, _In_ const double dZahl);
    COComma4* __vectorcall COComma4V(_In_ const int iZahl);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher, _In_ const int iZahl);
    COComma4* __vectorcall COComma4V(_In_ const COComma4* pk4Zahl);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher, _In_ const COComma4* pk4Zahl);
    COComma4* __vectorcall COComma4V(_In_ const __m128d m128dZahl);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher, _In_ const __m128d m128dZahl);
    COComma4* __vectorcall COComma4V(_In_ const __m128i m128iZahl);
    COComma4* __vectorcall COComma4V(_In_ const VMEMORY vmSpeicher, _In_ const __m128i m128iZahl);
#ifdef HADT
#ifndef _64bit
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@XZ")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBX@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@N@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXN@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@H@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXH@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@PBV312@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXPBV312@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@U__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXU__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@T__m128i@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXT__m128i@@@Z")
#else
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@XZ")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBX@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@N@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBXN@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@H@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBXH@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@PEBV312@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBXPEBV312@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@U__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBXU__m128d@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@T__m128i@@@Z")
#pragma comment(linker, "/export:?COComma4V@System@RePag@@YQPEAVCOComma4@12@QEBXT__m128i@@@Z")
#endif
#endif
    //---------------------------------------------------------------------------
  }
}