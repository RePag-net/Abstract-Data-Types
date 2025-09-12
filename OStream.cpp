#include "HADT.h"
#include "OStream.h"
//---------------------------------------------------------------------------
//BYTE ucInfo = 0;
//#define EX_STM_DATEIFEHLER 88
//#define EX_STM_POSITIONSFEHLER 89
//#define VSTElementStd (STElement*)VMBlock(8)
//#define VSTElement (STElement*)VMBlock(vmSpeicher, 8)
//#define VSTElementStdS (STElement*)VMBlockS(8)
//#define VSTElementS (STElement*)VMBlockS(vmSpeicher, 8)
//#define BY_COSTREAM 84
//---------------------------------------------------------------------------
//COStream* __vectorcall COStreamV(bool bThreadSicher)
//{
//  COStream* vStream = (COStream*)VMBlock(BY_COSTREAM);
//  vStream->COStreamV(bThreadSicher);
//  return vStream;
//}
////---------------------------------------------------------------------------
//COStream* __vectorcall COStreamV(bool bThreadSicher, unsigned long ulSpinCount)
//{
//  COStream* vStream = (COStream*)VMBlock(BY_COSTREAM);
//  vStream->COStreamV(bThreadSicher, ulSpinCount);
//  return vStream;
//}
////---------------------------------------------------------------------------
//COStream* __vectorcall COStreamV(VMEMORY vmSpeicher, bool bThreadSicher)
//{
//  COStream* vStream = (COStream*)VMBlock(vmSpeicher, BY_COSTREAM);
//  vStream->COStreamV(vmSpeicher, bThreadSicher);
//  return vStream;
//}
////---------------------------------------------------------------------------
//COStream* __vectorcall COStreamV(VMEMORY vmSpeicher, bool bThreadSicher, unsigned long ulSpinCount)
//{
//  COStream* vStream = (COStream*)VMBlock(vmSpeicher, BY_COSTREAM);
//  vStream->COStreamV(vmSpeicher, bThreadSicher, ulSpinCount);
//  return vStream;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::COStreamV(bool bThreadSicher)
//{
//  vmSpeicher = 0;
//  ulBytes = 0;
//  ulPosition = 0;
//  bThread = bThreadSicher;
//	//lsDaten = {0}; //COListV(false);
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csStream, NULL);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::COStreamV(bool bThreadSicher, unsigned long ulSpinCount)
//{
//  vmSpeicher = 0;
//  ulBytes = 0;
//  ulPosition = 0;
//  bThread = bThreadSicher;
//	lsDaten = {0};//vlDaten = COListV(false);
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::COStreamV(VMEMORY vmSpeicherA, bool bThreadSicher)
//{
//  vmSpeicher = vmSpeicherA;
//  ulBytes = 0;
//  ulPosition = 0;
//  bThread = bThreadSicher;
//	lsDaten = {0};//vlDaten = COListV(vmSpeicher, false);
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csStream, NULL);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::COStreamV(VMEMORY vmSpeicherA, bool bThreadSicher, unsigned long ulSpinCount)
//{
//  vmSpeicher = vmSpeicherA;
//  ulBytes = 0;
//  ulPosition = 0;
//  bThread = bThreadSicher;
//	lsDaten = {0};//vlDaten = COListV(vmSpeicher, false);
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount);
//}
////---------------------------------------------------------------------------
//VMEMORY __vectorcall COStream::COFreiV(void)
//{ 
//  void* pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    if(!vmSpeicher) VMFreiS(((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//    else VMFreiS(vmSpeicher, ((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//		lsDaten.DeleteFirstElementS(pvIterator, true);
//  }
//  //VMFreiV(lsDaten);
//
//  if(bThread) DeleteCriticalSection(&csStream);
//  return vmSpeicher;
//}
////-------------------------------------------------------------------------
//__thiscall COStream::COStream(bool bThreadSicher)
//{
//	BYTE ucTest = 0;
//
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::Schreibe(void* pvDaten, ULONG ulByte)
//{
//  if(!ulByte) return;
//  STElement* vstElement;
//  if(!vmSpeicher) vstElement = VSTElementStdS;
//  else vstElement = VSTElementS;
//  vstElement->ulByte = ulByte;
//  if(!vmSpeicher) vstElement->vbDaten = VMBlock(ulByte);
//  else vstElement->vbDaten = VMBlock(vmSpeicher, ulByte);
//
//  MemCopy(vstElement->vbDaten, pvDaten, ulByte);
//  lsDaten.ToEndS(vstElement);
//  ulBytes += ulByte;
//  ulPosition += ulByte;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COStream::Lese(void* pvDaten, ULONG ulByte)
//{
 // if(!ulByte) return NULL;
	//if(ulPosition > ulBytes){ ucInfo = EX_STM_POSITIONSFEHLER; return nullptr; }
	//if(ulBytes < ulPosition + ulByte){ ucInfo = EX_STM_POSITIONSFEHLER; return nullptr; }
 // ULONG ulEndPosition = 0;
 // ULONG ulElementLange;
	//ULONG ulDifferenz;

 // void* pvIterator = lsDaten.IteratorToBegin();
 // while(pvIterator){
 //   ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
 //   ulEndPosition += ulElementLange;
 //   if(ulEndPosition >= ulPosition){
 //     ulDifferenz = ulEndPosition - ulPosition;
 //     if(ulDifferenz >= ulByte){ 
	//			MemCopy(pvDaten, &((STElement*)lsDaten.Element(pvIterator))->vbDaten[ulElementLange - ulDifferenz], ulByte);
	//			break;
	//		}
 //     else{
	//			if(ulDifferenz)	MemCopy(pvDaten, &(((STElement*)lsDaten.Element(pvIterator))->vbDaten)[ulElementLange - ulDifferenz], ulDifferenz);
 //       do{
	//				lsDaten.NextElement(pvIterator);
 //         ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
 //         if(ulByte > ulDifferenz + ulElementLange)
 //           MemCopy(&((char*)pvDaten)[ulDifferenz], ((STElement*)lsDaten.Element(pvIterator))->vbDaten, ulElementLange);
 //         else MemCopy(&((char*)pvDaten)[ulDifferenz], ((STElement*)lsDaten.Element(pvIterator))->vbDaten, ulByte - ulDifferenz);
 //         ulDifferenz += ulElementLange;
 //       }
 //       while(ulDifferenz < ulByte);
 //       break;
 //     }
 //   }
 //   lsDaten.NextElement(pvIterator);
 // }

 // ulPosition += ulByte;
 // return pvDaten;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::Schreibe(void* pvDaten, ULONG ulByte, ULONG& ulSchreibPosition)
//{
//  if(!ulByte) return;
//  STElement* vstElement;
//  if(!vmSpeicher) vstElement = VSTElementStdS;
//  else vstElement = VSTElementS;
//  vstElement->ulByte = ulByte;
//  if(!vmSpeicher) vstElement->vbDaten = VMBlockS(ulByte);
//  else vstElement->vbDaten = VMBlockS(vmSpeicher, ulByte);
//
//  MemCopy(vstElement->vbDaten, pvDaten, ulByte);
//  lsDaten.ToEndS(vstElement);
//  ulBytes += ulByte;
//  ulSchreibPosition += ulByte;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibe(void* pvDaten, ULONG ulByte, ULONG& ulSchreibPosition)
//{
//  if(!ulByte) return;
//  STElement* vstElement;
//  if(!vmSpeicher) vstElement = VSTElementStdS;
//  else vstElement = VSTElementS;
//  vstElement->ulByte = ulByte;
//  if(!vmSpeicher) vstElement->vbDaten = VMBlockS(ulByte);
//  else vstElement->vbDaten = VMBlockS(vmSpeicher, ulByte);
//  MemCopy(vstElement->vbDaten, pvDaten, ulByte);
//
//  EnterCriticalSection(&csStream);
//  lsDaten.ToEndS(vstElement);
//  ulSchreibPosition += ulByte;
//  ulBytes += ulByte;
//  LeaveCriticalSection(&csStream);
//}
////---------------------------------------------------------------------------
//void* __vectorcall COStream::Lese(void* pvDaten, ULONG ulByte, ULONG& ulLesePosition)
//{
 // if(!ulByte) return NULL;
 // if(ulPosition > ulBytes){ ucInfo = EX_STM_POSITIONSFEHLER; return nullptr;}
 // if(ulBytes < ulPosition + ulByte){ ucInfo = EX_STM_POSITIONSFEHLER; return nullptr;}
 // ULONG ulEndPosition = 0;
 // ULONG ulElementLange;
	//ULONG ulNeuePosition;
 // ULONG uly;

 // void* pvIterator = lsDaten.IteratorToBegin();
 // while(pvIterator){
 //   ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
 //   ulEndPosition += ulElementLange;
 //   if(ulEndPosition >= ulPosition){
 //     ulNeuePosition = ulEndPosition - ulLesePosition;
 //     for(uly = 0; uly < ulNeuePosition && uly < ulByte; uly++){
 //       ((char*)pvDaten)[uly] = ((STElement*)lsDaten.Element(pvIterator))->vbDaten[ulElementLange-ulNeuePosition+uly];
 //     }
 //     if(ulNeuePosition < ulByte){
 //       do{
 //         lsDaten.NextElement(pvIterator);
 //         ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
 //         for(UINT ula = 0; ula < ulElementLange && uly < ulByte; ula++){
 //           ((char*)pvDaten)[uly] = ((STElement*)lsDaten.Element(pvIterator))->vbDaten[ula];
 //           uly++;
 //         }
 //       }
 //       while(uly < ulByte);
 //     }
 //   }
 //   lsDaten.NextElement(pvIterator);
 // }

 // ulLesePosition += ulByte;
 // return pvDaten;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COStream::ThLese(void* pvDaten, ULONG ulByte, ULONG& ulLesePosition)
//{
//  if(!ulByte) return NULL;
//  if(ulPosition > ulBytes){ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//  if(ulBytes < ulPosition + ulByte){ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//  ULONG ulEndPosition = 0;
//  ULONG ulElementLange;
//
//  TryEnterCriticalSection(&csStream);
//  void* pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
//    ulEndPosition += ulElementLange;
//    if(ulEndPosition >= ulPosition){
//      ULONG ulNeuePosition = ulEndPosition - ulLesePosition;
//      ULONG uly;
//      for(uly = 0; uly < ulNeuePosition && uly < ulByte; uly++){
//        ((char*)pvDaten)[uly] = ((STElement*)lsDaten.Element(pvIterator))->vbDaten[ulElementLange - ulNeuePosition + uly];
//      }
//      if(ulNeuePosition < ulByte){
//        do{
//          lsDaten.NextElement(pvIterator);
//          ulElementLange = ((STElement*)lsDaten.Element(pvIterator))->ulByte;
//          for(UINT ula = 0; ula < ulElementLange && uly < ulByte; ula++){
//            ((char*)pvDaten)[uly] = ((STElement*)lsDaten.Element(pvIterator))->vbDaten[ula];
//            uly++;
//          }
//        }
//        while(uly < ulByte);
//      }
//    }
//    lsDaten.NextElement(pvIterator);
//  }
//  LeaveCriticalSection(&csStream);
//
//  ulLesePosition += ulByte;
//  return pvDaten;
//}
////---------------------------------------------------------------------------
//COTime* __vectorcall COStream::LeseZeit(COTime* pzZeit)
//{
//  char c8Zeit[8];
//  Lese(c8Zeit, BY_TIME);
//  pzZeit->Write(c8Zeit);
//  return pzZeit;
//}
////---------------------------------------------------------------------------
//COTime* __vectorcall COStream::ThLeseZeit(COTime* pzZeit)
//{
//  char c8Zeit[8];
//  TryEnterCriticalSection(&csStream);
//  Lese(c8Zeit, BY_TIME);
//  LeaveCriticalSection(&csStream);
//  pzZeit->Write(c8Zeit);
//  return pzZeit;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeZeit(COTime* pzZeit)
//{
//  char c8Zeit[8];
//  pzZeit->Read(c8Zeit);
//  Schreibe(c8Zeit, BY_TIME);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeZeit(COTime* pzZeit)
//{
//  char c8Zeit[8];
//  pzZeit->Read(c8Zeit);
//  EnterCriticalSection(&csStream);
//  Schreibe(c8Zeit, BY_TIME);
//  LeaveCriticalSection(&csStream);
//}
////---------------------------------------------------------------------------
//COComma4* __vectorcall COStream::LeseKomma4(COComma4* pk4Zahl)
//{
//  char c6k4Zahl[6];
//  Lese(c6k4Zahl, BY_COMMA4);
//  pk4Zahl->Write(c6k4Zahl);
//  return pk4Zahl;
//}
////---------------------------------------------------------------------------
//COComma4* __vectorcall COStream::ThLeseKomma4(COComma4* pk4Zahl)
//{
//  char c6k4Zahl[6];
//  TryEnterCriticalSection(&csStream);
//  Lese(c6k4Zahl, BY_COMMA4);
//  LeaveCriticalSection(&csStream);
//  pk4Zahl->Write(c6k4Zahl);
//  return pk4Zahl;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeKomma4(COComma4* pk4Zahl)
//{
//  char c6k4Zahl[6];
//  pk4Zahl->Read(c6k4Zahl);
//  Schreibe(c6k4Zahl, BY_COMMA4);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeKomma4(COComma4* pk4Zahl)
//{
//  char c6k4Zahl[6];
//  pk4Zahl->Read(c6k4Zahl);
//  EnterCriticalSection(&csStream);
//  Schreibe(c6k4Zahl, BY_COMMA4);
//  LeaveCriticalSection(&csStream);
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COStream::LeseKomma4_80(COComma4_80* pk4gZahl)
//{
//  char c10k4gZahl[10];
//  Lese(c10k4gZahl, BY_COMMA4_80);
//  pk4gZahl->Write(c10k4gZahl);
//  return pk4gZahl;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COStream::ThLeseKomma4_80(COComma4_80* pk4gZahl)
//{
//  char c10k4gZahl[10];
//  TryEnterCriticalSection(&csStream);
//  Lese(c10k4gZahl, BY_COMMA4_80);
//  LeaveCriticalSection(&csStream);
//	pk4gZahl->Write(c10k4gZahl);
//  return pk4gZahl;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeKomma4_80(COComma4_80* pk4gZahl)
//{
//	char c10k4gZahl[10];
//  pk4gZahl->Read(c10k4gZahl);
//  Schreibe(c10k4gZahl, BY_COMMA4_80);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeKomma4_80(COComma4_80* pk4gZahl)
//{
//  char c10k4gZahl[10];
//  pk4gZahl->Read(c10k4gZahl);
//  EnterCriticalSection(&csStream);
//  Schreibe(c10k4gZahl, BY_COMMA4_80);
//  LeaveCriticalSection(&csStream);
//}
////#endif
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStream::LeseStringA(COStringA* pasString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){ BYTE ucByte;
//  Lese(&ucByte, BY_BYTE);
//  pasString->SetLength(ucByte);
//  Lese(pasString->c_Str(), ucByte); 
//  }
//  else if(ucStringtyp == FT_MEMOSTR){ USHORT usByte;
//  Lese(&usByte, BY_USHORT);
//  pasString->SetLength(usByte);
//  Lese(pasString->c_Str(), usByte); 
//  }
//  else if(ucStringtyp == FT_LONGSTR){ ULONG ulByte;
//  Lese(&ulByte, BY_ULONG);
//  pasString->SetLength(ulByte);
//  Lese(pasString->c_Str(), ulByte); 
//  }
//  return pasString;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStream::ThLeseStringA(COStringA* pasString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){ BYTE ucByte;
//  TryEnterCriticalSection(&csStream);
//  Lese(&ucByte, BY_BYTE);
//  pasString->SetLength(ucByte);
//  Lese(pasString->c_Str(), ucByte); 
//  LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){ USHORT usByte;
//  TryEnterCriticalSection(&csStream);
//  Lese(&usByte, BY_USHORT);
//  pasString->SetLength(usByte);
//  Lese(pasString->c_Str(), usByte); 
//  LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_LONGSTR){ ULONG ulByte;
//  TryEnterCriticalSection(&csStream);
//  Lese(&ulByte, BY_ULONG);
//  pasString->SetLength(ulByte);
//  Lese(pasString->c_Str(), ulByte);  
//  LeaveCriticalSection(&csStream);
//  }
//  return pasString;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeStringA(COStringA* pasString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){ BYTE ucByte;
//  ucByte = (BYTE)pasString->Length();
//  Schreibe(&ucByte, BY_BYTE);
//  Schreibe(pasString->c_Str(), ucByte);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){ USHORT usByte;
//  usByte = (USHORT)pasString->Length();
//  Schreibe(&usByte, BY_USHORT);
//  Schreibe(pasString->c_Str(), usByte);
//  }
//  else if(ucStringtyp == FT_LONGSTR){ ULONG ulByte;
//  ulByte = pasString->Length();
//  Schreibe(&ulByte, BY_ULONG);
//  Schreibe(pasString->c_Str(), ulByte);
//  }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeStringA(COStringA* pasString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){ BYTE ucByte;
//  ucByte = (BYTE)pasString->Length();
//  EnterCriticalSection(&csStream);
//  Schreibe(&ucByte, BY_BYTE);
//  Schreibe(pasString->c_Str(), ucByte);
//  LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){ USHORT usByte;
//  usByte = (USHORT)pasString->Length();
//  EnterCriticalSection(&csStream);
//  Schreibe(&usByte, BY_USHORT);
//  Schreibe(pasString->c_Str(), usByte);
//  LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_LONGSTR){ ULONG ulByte;
//  ulByte = pasString->Length();
//  EnterCriticalSection(&csStream);
//  Schreibe(&ulByte, BY_ULONG);
//  Schreibe(pasString->c_Str(), ulByte);
//  LeaveCriticalSection(&csStream);
//  }
//}
////---------------------------------------------------------------------------
//char* __vectorcall COStream::LeseCHAR(VMBLOCK& vbString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){
//    BYTE ucByte;
//    Lese(&ucByte, BY_BYTE);
//    vbString = VMBlock(ucByte);
//    Lese(vbString, ucByte);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){
//    USHORT usByte;
//    Lese(&usByte, BY_USHORT);
//    vbString = VMBlock(usByte);
//    Lese(vbString, usByte);
//  }
//  else if(ucStringtyp == FT_LONGSTR){
//    ULONG ulByte;
//    Lese(&ulByte, BY_ULONG);
//    vbString = VMBlock(ulByte);
//    Lese(vbString, ulByte);
//  }
//  return vbString;
//}
////---------------------------------------------------------------------------
//char* __vectorcall COStream::ThLeseCHAR(VMBLOCK& vbString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){
//    BYTE ucByte;
//    TryEnterCriticalSection(&csStream);
//    Lese(&ucByte, BY_BYTE);
//    vbString = VMBlock(ucByte);
//    Lese(vbString, ucByte);
//    LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){
//    USHORT usByte;
//    TryEnterCriticalSection(&csStream);
//    Lese(&usByte, BY_USHORT);
//    vbString = VMBlock(usByte);
//    Lese(vbString, usByte);
//    LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_LONGSTR){
//    ULONG ulByte;
//    TryEnterCriticalSection(&csStream);
//    Lese(&ulByte, BY_ULONG);
//    vbString = VMBlock(ulByte);
//    Lese(vbString, ulByte);
//    LeaveCriticalSection(&csStream);
//  }
//  return vbString;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeCHAR(char* pcString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){
//    BYTE ucByte;
//    ucByte = StrLength(pcString) + 1;
//    Schreibe(&ucByte, BY_BYTE);
//    Schreibe(pcString, ucByte);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){
//    USHORT usByte;
//    usByte = StrLength(pcString) + 1;
//    Schreibe(&usByte, BY_USHORT);
//    Schreibe(pcString, usByte);
//  }
//  else if(ucStringtyp == FT_LONGSTR){
//    ULONG ulByte;
//    ulByte = StrLength(pcString) + 1;
//    Schreibe(&ulByte, BY_ULONG);
//    Schreibe(pcString, ulByte);
//  }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeCHAR(char* pcString, unsigned char ucStringtyp)
//{
//  if(ucStringtyp == FT_SHORTSTR){
//    BYTE ucByte;
//    ucByte = StrLength(pcString) + 1;
//    EnterCriticalSection(&csStream);
//    Schreibe(&ucByte, BY_BYTE);
//    Schreibe(pcString, ucByte);
//    LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_MEMOSTR){
//    USHORT usByte;
//    usByte = StrLength(pcString) + 1;
//    EnterCriticalSection(&csStream);
//    Schreibe(&usByte, BY_USHORT);
//    Schreibe(pcString, usByte);
//    LeaveCriticalSection(&csStream);
//  }
//  else if(ucStringtyp == FT_LONGSTR){
//    ULONG ulByte;
//    ulByte = StrLength(pcString) + 1;
//    EnterCriticalSection(&csStream);
//    Schreibe(&ulByte, BY_ULONG);
//    Schreibe(pcString, ulByte);
//    LeaveCriticalSection(&csStream);
//  }
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ReadFile(HANDLE hDatei, LPOVERLAPPED pOverlapped, BOOL BWait)
//{
//  if(hDatei == INVALID_HANDLE_VALUE) return ERROR_INVALID_HANDLE;
//  STElement* vstElement; DWORD dwLastError = ERROR_SUCCESS, dwBytes_Gelesen; LARGE_INTEGER liFileSize;
//
//  if(!GetFileSizeEx(hDatei, &liFileSize)){ return dwLastError = GetLastError(); }
//  if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(liFileSize.LowPart);}
//  else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, liFileSize.LowPart);}
//  vstElement->ulByte = liFileSize.LowPart;
//
//  if(!pOverlapped){
//    if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, pOverlapped))){
//			dwLastError = GetLastError(); goto Error; }  
//  }
//  else{
//		if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, pOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)){
//					dwLastError = GetLastError();
//					// if(BWait) goto Error;
//					//else return dwLastError;
//					goto Error;
//				}
//			}
//			else goto Error;
//		}
//  }
//  lsDaten.ToEnd(vstElement); ulBytes = liFileSize.LowPart;
//  return dwLastError;
//
//Error:
//  if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement); }
//  else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement); }
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ThReadFile(HANDLE hDatei, LPOVERLAPPED pOverlapped, BOOL BWait)
//{
//  if(hDatei == INVALID_HANDLE_VALUE) return ERROR_INVALID_HANDLE;
//  STElement* vstElement; DWORD dwLastError = ERROR_SUCCESS, dwBytes_Gelesen; LARGE_INTEGER liFileSize;
//
//  if(!GetFileSizeEx(hDatei, &liFileSize)){ return dwLastError = GetLastError(); }
//  if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(liFileSize.LowPart); }
//  else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, liFileSize.LowPart); }
//  vstElement->ulByte = liFileSize.LowPart;
//
//  if(!pOverlapped){
//    if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, pOverlapped))){ dwLastError = GetLastError(); goto Error; }
//  }
//  else{
//		if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, pOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)){
//					dwLastError = GetLastError();
//					// if(BWait) goto Error;
//					// else return dwLastError;
//					goto Error;
//				}
//			}
//			else goto Error;
//		}
//  }
//	EnterCriticalSection(&csStream); lsDaten.ToEnd(vstElement); ulBytes = liFileSize.LowPart; LeaveCriticalSection(&csStream);
//  return dwLastError;
//
//Error:
//  if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement); }
//  else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement); }
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ReadFile(HANDLE hFile, bool bAsynchronous)
//{
//  if(hFile == INVALID_HANDLE_VALUE) return ERROR_INVALID_HANDLE;
//  STElement* vstElement; DWORD dwLastError = ERROR_SUCCESS, dwBytes_Gelesen; LARGE_INTEGER liFileSize;
//
//  if(!GetFileSizeEx(hFile, &liFileSize)){ return dwLastError = GetLastError(); }
//  if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(liFileSize.LowPart);}
//  else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, liFileSize.LowPart);}
//  vstElement->ulByte = liFileSize.LowPart;
//
//  if(!bAsynchronous){
//    if(!(::ReadFile(hFile, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, NULL))){ dwLastError = GetLastError(); goto Error; }
//  }
//	else{
//		OVERLAPPED stOverlapped = {0}; stOverlapped.hEvent = CreateEvent(NULL, false, false, NULL);
//		if(!(::ReadFile(hFile, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, &stOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hFile, &stOverlapped, &dwBytes_Gelesen, TRUE)){ dwLastError = GetLastError(); CloseHandle(stOverlapped.hEvent); goto Error; }
//			}
//			else{ CloseHandle(stOverlapped.hEvent); goto Error; }
//		}
//    CloseHandle(stOverlapped.hEvent);
//  }
//	lsDaten.ToEnd(vstElement); ulBytes = liFileSize.LowPart;
//  return dwLastError;
//
//Error:
//  if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement); }
//  else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement); }
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ThReadFile(HANDLE hDatei, bool bAsynchronous)
//{
//  if(hDatei == INVALID_HANDLE_VALUE) return ERROR_INVALID_HANDLE;
//  STElement* vstElement; DWORD dwLastError = ERROR_SUCCESS, dwBytes_Gelesen; LARGE_INTEGER liFileSize;
//
//  if(!GetFileSizeEx(hDatei, &liFileSize)){ return dwLastError = GetLastError(); }
//  if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(liFileSize.LowPart);}
//  else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, liFileSize.LowPart);}
//  vstElement->ulByte = liFileSize.LowPart;
//
//  if(!bAsynchronous){
//    if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, NULL))){ dwLastError = GetLastError(); goto Error; }  
//  }
//	else{ OVERLAPPED stOverlapped = {0}; stOverlapped.hEvent = CreateEvent(NULL, false, false, NULL);
//		if(!(::ReadFile(hDatei, vstElement->vbDaten, liFileSize.LowPart, &dwBytes_Gelesen, &stOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hDatei, &stOverlapped, &dwBytes_Gelesen, TRUE)){ dwLastError = GetLastError(); CloseHandle(stOverlapped.hEvent); goto Error; }
//			}
//			else{ CloseHandle(stOverlapped.hEvent); goto Error; }
//		}
//		CloseHandle(stOverlapped.hEvent);
//  }
//	EnterCriticalSection(&csStream); lsDaten.ToEnd(vstElement); ulBytes = liFileSize.LowPart; LeaveCriticalSection(&csStream);
//  return dwLastError;
//
//Error:
//  if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement); }
//  else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement); }
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::LeseDatei(HANDLE hDatei)
//{
//  if(hDatei == INVALID_HANDLE_VALUE){ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;}
//  int iErgebnis; ULONG ulGeleseneBytes;
//
//  ULONG ulMenge = GetFileSize(hDatei, NULL);
//  
//	if(ulMenge != 0xFFFFFFFF){
//    STElement* vstElement;
//    if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(ulMenge); }
//    else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, ulMenge); }
//    vstElement->ulByte = ulMenge;
//
//    iErgebnis = ::ReadFile(hDatei, vstElement->vbDaten, ulMenge, &ulGeleseneBytes, NULL);
//    if(iErgebnis){ lsDaten.ToEnd(vstElement); ulBytes = ulMenge; }
//    else{
//      if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement);}
//      else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement); }
//      ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;
//    }
//  }
//  else{ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo; }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThLeseDatei(HANDLE hDatei)
//{
//  if(hDatei == INVALID_HANDLE_VALUE){ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;}
//  int iErgebnis;
//  ULONG ulGeleseneBytes;
//  ULONG ulMenge = GetFileSize(hDatei, NULL);
//  if(ulMenge != 0xFFFFFFFF){
//    STElement* vstElement;
//    if(!vmSpeicher){ vstElement = VSTElementStd; vstElement->vbDaten = VMBlock(ulMenge);}
//    else{ vstElement = VSTElement; vstElement->vbDaten = VMBlock(vmSpeicher, ulMenge);}
//    vstElement->ulByte = ulMenge;
//
//    iErgebnis = ::ReadFile(hDatei, vstElement->vbDaten, ulMenge, &ulGeleseneBytes, NULL);
//    if(iErgebnis){ EnterCriticalSection(&csStream); lsDaten.ToEnd(vstElement); ulBytes = ulMenge; LeaveCriticalSection(&csStream);}
//    else{
//      if(!vmSpeicher){ VMFrei(vstElement->vbDaten); VMFrei(vstElement);}
//      else{ VMFrei(vmSpeicher, vstElement->vbDaten); VMFrei(vmSpeicher, vstElement);}
//      ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;
//    }
//  }
//  else{ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;}
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::WriteFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait)
//{
//  DWORD dwLastError = ERROR_SUCCESS, dwBytes_written; VMBLOCK vbDaten;
//  if(!Daten(vbDaten)) return ERROR_INVALID_DATA;
//
//  if(!pOverlapped){
//    if(!::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)){ dwLastError = GetLastError(); goto Ende; }
//  }
//  else{ 
//		if(!(::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hFile, pOverlapped, &dwBytes_written, BWait)){
//					dwLastError = GetLastError();
//					//if(BWait) goto Ende;
//					//else return dwLastError;
//					goto Ende;
//				}
//			}
//			else goto Ende;
//		}
//  }
//
//Ende:
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ThWriteFile(_In_ HANDLE hFile, _In_ LPOVERLAPPED pOverlapped, _In_ BOOL BWait)
//{
//  DWORD dwLastError = ERROR_SUCCESS, dwBytes_written; VMBLOCK vbDaten;
//  TryEnterCriticalSection(&csStream);
//  if(!Daten(vbDaten)){ LeaveCriticalSection(&csStream); return ERROR_INVALID_DATA; }
//
//  if(!pOverlapped){
//    if(!::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)){ dwLastError = GetLastError(); goto Ende; }
//  }
//  else{ 
//		if(!(::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hFile, pOverlapped, &dwBytes_written, BWait)){
//					dwLastError = GetLastError();
//					if(BWait) goto Ende;
//					else return dwLastError;
//				}
//			}
//			else goto Ende;
//		}
//  }
//
//Ende:
//  LeaveCriticalSection(&csStream);
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::WriteFile(_In_ HANDLE hFile, _In_ bool bAsynchronous)
//{
//  DWORD dwLastError = ERROR_SUCCESS, dwBytes_written; VMBLOCK vbDaten;
//  if(!Daten(vbDaten)) return ERROR_INVALID_DATA;
//
//  if(!bAsynchronous){
//    if(!::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, NULL)){ dwLastError = GetLastError(); goto Ende; }
//  }
//	else{	OVERLAPPED stOverlapped = {0}; stOverlapped.hEvent = CreateEvent(NULL, false, false, NULL);
//		if(!(::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, &stOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hFile, &stOverlapped, &dwBytes_written, TRUE)){ dwLastError = GetLastError(); CloseHandle(stOverlapped.hEvent); goto Ende; }
//			}
//			else{ CloseHandle(stOverlapped.hEvent); goto Ende; }
//		}
//		CloseHandle(stOverlapped.hEvent);
//  }
//
//Ende:
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//DWORD __vectorcall COStream::ThWriteFile(_In_ HANDLE hFile, _In_ bool bAsynchronous)
//{
//  DWORD dwLastError = ERROR_SUCCESS, dwBytes_written; VMBLOCK vbDaten;
//  TryEnterCriticalSection(&csStream);
//  if(!Daten(vbDaten)){ LeaveCriticalSection(&csStream); return ERROR_INVALID_DATA; }
//
//  if(!bAsynchronous){
//    if(!::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, NULL)){ dwLastError = GetLastError(); goto Ende; }
//  }
//	else{ OVERLAPPED stOverlapped = {0}; stOverlapped.hEvent = CreateEvent(NULL, false, false, NULL);
//		if(!(::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, &stOverlapped))){
//			dwLastError = GetLastError();
//			if(dwLastError == ERROR_IO_PENDING){
//				if(!GetOverlappedResult(hFile, &stOverlapped, &dwBytes_written, TRUE)){ dwLastError = GetLastError(); CloseHandle(stOverlapped.hEvent); goto Ende; }
//			}
//			else{ CloseHandle(stOverlapped.hEvent); goto Ende; }
//		}
//		CloseHandle(stOverlapped.hEvent);
//  }
//
//Ende:
//  LeaveCriticalSection(&csStream);
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  return dwLastError;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::SchreibeDatei(_In_ HANDLE hFile)
//{
//  DWORD dwBytes_written; VMBLOCK vbDaten;
//  if(!Daten(vbDaten)) return;
//  BOOL BReturn = ::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, NULL);
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  if(!BReturn){ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;}
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThSchreibeDatei(_In_ HANDLE hFile)
//{
//  DWORD dwBytes_written; VMBLOCK vbDaten;
//  TryEnterCriticalSection(&csStream);
//  if(!Daten(vbDaten)){ LeaveCriticalSection(&csStream); return; }
//  BOOL BReturn = ::WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, NULL);
//  LeaveCriticalSection(&csStream);
//  if(!vmSpeicher) VMFrei(vbDaten);
//  else VMFrei(vmSpeicher, vbDaten);
//  if(!BReturn){ ucInfo = EX_STM_DATEIFEHLER; throw ucInfo;}
//}
////---------------------------------------------------------------------------
//VMBLOCK __vectorcall COStream::Daten(_Out_ VMBLOCK& vbDaten)
//{
//  if(!ulBytes) return vbDaten = NULL;
//  if(!vmSpeicher) vbDaten = VMBlock(ulBytes);
//  else vbDaten = VMBlock(vmSpeicher, ulBytes);
//  void* pvIterator; ULONG ulz = 0;
//  pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    MemCopy(&vbDaten[ulz], ((STElement*)lsDaten.Element(pvIterator))->vbDaten, ((STElement*)lsDaten.Element(pvIterator))->ulByte);
//    ulz += ((STElement*)lsDaten.Element(pvIterator))->ulByte;
//    lsDaten.NextElement(pvIterator);
//  }
//  return vbDaten;
//}
////---------------------------------------------------------------------------
//VMBLOCK __vectorcall COStream::ThDaten(_Out_ VMBLOCK& vbDaten)
//{
//  if(!ulBytes) return vbDaten = NULL;
//  if(!vmSpeicher) vbDaten = VMBlock(ulBytes);
//  else vbDaten = VMBlock(vmSpeicher, ulBytes);
//  void* pvIterator; ULONG ulz = 0;
//
//  TryEnterCriticalSection(&csStream);
//  pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    MemCopy(&vbDaten[ulz], ((STElement*)lsDaten.Element(pvIterator))->vbDaten, ((STElement*)lsDaten.Element(pvIterator))->ulByte);
//    ulz += ((STElement*)lsDaten.Element(pvIterator))->ulByte;
//    lsDaten.NextElement(pvIterator);
//  }
//  LeaveCriticalSection(&csStream);
//  return vbDaten;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::Loschen(void)
//{
//  void* pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    if(!vmSpeicher) VMFreiS(((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//    else VMFreiS(vmSpeicher, ((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//    lsDaten.DeleteFirstElementS(pvIterator, true);
//  }
//  ulBytes = 0; ulPosition = 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStream::ThLoschen(void)
//{
//  EnterCriticalSection(&csStream);
//  void* pvIterator = lsDaten.IteratorToBegin();
//  while(pvIterator){
//    if(!vmSpeicher) VMFreiS(((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//    else VMFreiS(vmSpeicher, ((STElement*)lsDaten.Element(pvIterator))->vbDaten);
//    lsDaten.DeleteFirstElementS(pvIterator, true);
//  }
//  ulBytes = 0; ulPosition = 0;
//  LeaveCriticalSection(&csStream);
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStream::Ende(void)
//{
//  if(ulPosition >= ulBytes) return true;
//  return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStream::ThEnde(void)
//{
//  TryEnterCriticalSection(&csStream);
//  if(ulPosition >= ulBytes){ LeaveCriticalSection(&csStream); return true;}
//  LeaveCriticalSection(&csStream);
//  return false;
//}
////---------------------------------------------------------------------------
//ULONG __vectorcall COStream::Bytes(void)
//{
//  return ulBytes;
//}
////---------------------------------------------------------------------------
//ULONG* __vectorcall COStream::ThBytes(ULONG& ulBytesA)
//{
//  TryEnterCriticalSection(&csStream);
//  ulBytesA = ulBytes;
//  LeaveCriticalSection(&csStream);
//  return &ulBytesA;
//}
////---------------------------------------------------------------------------
//ULONG __vectorcall COStream::Position(void)
//{
//  return ulPosition;
//}
////---------------------------------------------------------------------------
//ULONG* __vectorcall COStream::ThPosition(ULONG& ulPositionA)
//{
//  TryEnterCriticalSection(&csStream);
//  ulPositionA = ulPosition;
//  LeaveCriticalSection(&csStream);
//  return &ulPositionA;
//}
////---------------------------------------------------------------------------
//ULONG __vectorcall COStream::SetzPosition(long lAbstand, char cVonWo)
//{
//  switch(cVonWo){
//    case STM_POS_ANFANG  : if(lAbstand <= (long)ulBytes && lAbstand >= 0) ulPosition = lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//    case STM_POS_AKTUELL : if(ulPosition + lAbstand <= ulBytes && ulPosition + lAbstand >= 0) ulPosition += lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//    case STM_POS_ENDE    : if(lAbstand <= (long)ulBytes && lAbstand >= 0) ulPosition = ulBytes - lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//  }
//  return ulPosition;
//}
////---------------------------------------------------------------------------
//ULONG __vectorcall COStream::ThSetzPosition(long lAbstand, char cVonWo)
//{
//  EnterCriticalSection(&csStream);
//  switch(cVonWo){
//    case STM_POS_ANFANG  : if(lAbstand <= (long)ulBytes && lAbstand >= 0) ulPosition = lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//    case STM_POS_AKTUELL : if(ulPosition + lAbstand <= ulBytes && ulPosition + lAbstand >= 0) ulPosition += lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//    case STM_POS_ENDE    : if(lAbstand <= (long)ulBytes && lAbstand >= 0) ulPosition = ulBytes - lAbstand;
//                           else{ ucInfo = EX_STM_POSITIONSFEHLER; throw ucInfo;}
//                           break;
//  }
//  LeaveCriticalSection(&csStream);
//  return ulPosition;
//}
////---------------------------------------------------------------------------
//BYTE __vectorcall COStream::GetLastError(void)
//{
//	BYTE ucInfo_1 = ucInfo;
//	ucInfo = 0;
//	return ucInfo_1;
//}
////---------------------------------------------------------------------------
//BYTE* __vectorcall COStream::ThGetLastError(BYTE& ucError)
//{
//	TryEnterCriticalSection(&csStream);
//	ucError = ucInfo;
//	ucInfo = 0;
//	LeaveCriticalSection(&csStream);
//	return &ucError;
//}
////---------------------------------------------------------------------------