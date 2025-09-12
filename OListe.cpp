#include "HADT.h"
#include "OListe.h"
//---------------------------------------------------------------------------
//#define VSTKnotenStd (STKnoten*)VMBlock(8)
//#define VSTKnoten (STKnoten*)VMBlock(vmSpeicher, 8)
//#define VSTKnotenStdS (STKnoten*)VMBlockS(8)
//#define VSTKnotenS (STKnoten*)VMBlockS(vmSpeicher, 8)
//#define BY_COLISTE 44
//---------------------------------------------------------------------------
//COList* __vectorcall COListV(bool bThreadSicher)
//{
// COList* vListe = (COList*)VMBlock(BY_COLISTE);
// vListe->COListV(bThreadSicher);
// return vListe;
//}
////---------------------------------------------------------------------------
//COList* __vectorcall COListV(bool bThreadSicher, unsigned long ulSpinCount)
//{
//  COList* vListe = (COList*)VMBlock(BY_COLISTE);
//  vListe->COListV(bThreadSicher, ulSpinCount);
//  return vListe;
//  return vListe;
//}
////---------------------------------------------------------------------------
//COList* __vectorcall COListV(VMEMORY vmSpeicher, bool bThreadSicher)
//{
// COList* vListe = (COList*)VMBlock(vmSpeicher, BY_COLISTE);
// vListe->COListV(vmSpeicher, bThreadSicher);
// return vListe;
//}
////---------------------------------------------------------------------------
//COList* __vectorcall COListV(VMEMORY vmSpeicher, bool bThreadSicher, unsigned long ulSpinCount)
//{
//  COList* vListe = (COList*)VMBlock(vmSpeicher, BY_COLISTE);
//  vListe->COListV(vmSpeicher, bThreadSicher, ulSpinCount);
//  return vListe;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::COListV(bool bThreadSicher)
//{
// vmSpeicher = 0;
// pstErster = 0;
// pstLetzter = 0;
// ulAnzahl = 0;
// bThread = bThreadSicher;
// if(bThread) InitializeCriticalSectionAndSpinCount(&csIterator, NULL);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::COListV(bool bThreadSicher, unsigned long ulSpinCount)
//{
//  vmSpeicher = 0;
//  pstErster = 0;
//  pstLetzter = 0;
//  ulAnzahl = 0;
//  bThread = bThreadSicher;
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::COListV(VMEMORY vmSpeicherA, bool bThreadSicher)
//{
// vmSpeicher = vmSpeicherA;
// pstErster = 0;
// pstLetzter = 0;
// ulAnzahl = 0;
// bThread = bThreadSicher;
// if(bThread) InitializeCriticalSectionAndSpinCount(&csIterator, NULL);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::COListV(VMEMORY vmSpeicherA, bool bThreadSicher, unsigned long ulSpinCount)
//{
//  vmSpeicher = vmSpeicherA;
//  pstErster = 0;
//  pstLetzter = 0;
//  ulAnzahl = 0;
//  bThread = bThreadSicher;
//  if(bThread) InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount);
//}
////---------------------------------------------------------------------------
//__thiscall COList::COList(VMEMORY vmSpeicherA, bool bThreadSicher, unsigned long ulSpinCount)
//{
//
//
//}
////---------------------------------------------------------------------------
//VMEMORY __vectorcall COList::COFreiV(void)
//{
// if(bThread){ ThDeleteList(false); DeleteCriticalSection(&csIterator);}
// else DeleteList(false);
// return vmSpeicher;
//}
//////---------------------------------------------------------------------------
//void* __vectorcall COList::ToBegin(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStd;
// else vstTemp = VSTKnoten;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = pstErster;
// if(!pstErster) pstLetzter = vstTemp;
// pstErster = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThToBegin(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStd;
// else vstTemp = VSTKnoten;
// vstTemp->pvDaten = pvDaten;
// EnterCriticalSection(&csIterator);
// vstTemp->pstNachster = pstErster;
// if(!pstErster) pstLetzter = vstTemp;
// pstErster = vstTemp;
// ulAnzahl++;
// LeaveCriticalSection(&csIterator);
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ToEnd(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStd;
// else vstTemp = VSTKnoten;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = 0;
// if(!pstLetzter) pstErster = vstTemp;
// else pstLetzter->pstNachster = vstTemp;
// pstLetzter = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThToEnd(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStd;
// else vstTemp = VSTKnoten;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = 0;
// EnterCriticalSection(&csIterator);
// if(!pstLetzter) pstErster = vstTemp;
// else pstLetzter->pstNachster = vstTemp;
// pstLetzter = vstTemp;
// ulAnzahl++;
// LeaveCriticalSection(&csIterator);
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ToBeginS(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStdS;
// else vstTemp = VSTKnotenS;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = pstErster;
// if(!pstErster) pstLetzter = vstTemp;
// pstErster = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThToBeginS(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStdS;
// else vstTemp = VSTKnotenS;
// vstTemp->pvDaten = pvDaten;
// EnterCriticalSection(&csIterator);
// vstTemp->pstNachster = pstErster;
// if(!pstErster) pstLetzter = vstTemp;
// pstErster = vstTemp;
// ulAnzahl++;
// LeaveCriticalSection(&csIterator);
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ToEndS(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStdS;
// else vstTemp = VSTKnotenS;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = 0;
// if(!pstLetzter) pstErster = vstTemp;
// else pstLetzter->pstNachster = vstTemp;
// pstLetzter = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThToEndS(void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStdS;
// else vstTemp = VSTKnotenS;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = 0;
// EnterCriticalSection(&csIterator);
// if(!pstLetzter) pstErster = vstTemp;
// else pstLetzter->pstNachster = vstTemp;
// pstLetzter = vstTemp;
// ulAnzahl++;
// LeaveCriticalSection(&csIterator);
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::Element(ULONG ulIndex)
//{
// if(ulIndex < ulAnzahl){
//    if(!ulIndex) return pstErster->pvDaten;
//    else if(ulIndex == ulAnzahl - 1) return pstLetzter->pvDaten;
//    else{ STKnoten* pstTemp = pstErster;
//          for(ULONG ulx = 1; ulx <= ulIndex; ulx++){
//              pstTemp = pstTemp->pstNachster;
//          }
//          return pstTemp->pvDaten;
//    }
// }
// else return 0;
//}
//---------------------------------------------------------------------------
//void* __vectorcall COList::ThElement(ULONG ulIndex)
//{
// EnterCriticalSection(&csIterator);
// if(ulIndex < ulAnzahl){
//    if(!ulIndex){ LeaveCriticalSection(&csIterator); return pstErster->pvDaten;}
//    else if(ulIndex == ulAnzahl - 1){ LeaveCriticalSection(&csIterator); return pstLetzter->pvDaten;}
//    else{ STKnoten* pstTemp = pstErster;
//          for(ULONG ulx = 1; ulx <= ulIndex; ulx++){
//              pstTemp = pstTemp->pstNachster;
//          }
//          LeaveCriticalSection(&csIterator); return pstTemp->pvDaten;
//    }
// }
// else{ LeaveCriticalSection(&csIterator); return 0;}
//}
//---------------------------------------------------------------------------
//void __vectorcall COList::DeleteElement(ULONG ulIndex, bool bDatenLoschen)
//{
// if(ulIndex < ulAnzahl){
//	 void* pvTemp = pstErster;
//	 if(!ulIndex) DeleteFirstElement(pvTemp, bDatenLoschen);
//   else{
//		     void* pstTemp = pstErster;
//         void* pstLoschen = 0;
//         for(ULONG ul = 1; ul <= ulIndex; ul++){
//           NextElement(pstTemp, pstLoschen);
//         }
//         DeleteElement(pstTemp, pstLoschen, bDatenLoschen);
//   }
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::ThDeleteElement(ULONG ulIndex, bool bDatenLoschen)
//{
// EnterCriticalSection(&csIterator);
// if(ulIndex < ulAnzahl){ void* pvTemp = pstErster;
//	 if(!ulIndex) DeleteFirstElement(pvTemp, bDatenLoschen);
//   else{ void* pstTemp = pstErster;
//         void* pstLoschen = 0;
//         for(ULONG ul = 1; ul <= ulIndex; ul++){
//           NextElement(pstTemp, pstLoschen);
//         }
//         DeleteElement(pstTemp, pstLoschen, bDatenLoschen);
//   }
// }
// LeaveCriticalSection(&csIterator);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteElementS(ULONG ulIndex, bool bDatenLoschen)
//{
// if(ulIndex < ulAnzahl){ void* pvTemp = pstErster;
//	 if(!ulIndex) DeleteFirstElementS(pvTemp, bDatenLoschen);
//   else{ void* pstTemp = pstErster;
//         void* pstLoschen = 0;
//         for(ULONG ul = 1; ul <= ulIndex; ul++){
//           NextElement(pstTemp, pstLoschen);
//         }
//         DeleteElementS(pstTemp, pstLoschen, bDatenLoschen);
//   }
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::ThDeleteElementS(ULONG ulIndex, bool bDatenLoschen)
//{
// EnterCriticalSection(&csIterator);
// if(ulIndex < ulAnzahl){ void* pvTemp = pstErster;
//	 if(!ulIndex) DeleteFirstElementS(pvTemp, bDatenLoschen);
//   else{ void* pstTemp = pstErster;
//         void* pstLoschen = 0;
//         for(ULONG ul = 1; ul <= ulIndex; ul++){
//           NextElement(pstTemp, pstLoschen);
//         }
//         DeleteElementS(pstTemp, pstLoschen, bDatenLoschen);
//   }
// }
// LeaveCriticalSection(&csIterator);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteElement(void*& pstKnoten, void*& pstLoschen, bool bDatenLoschen)
//{
 //if(pstLoschen == NULL){
 //  if(!pstErster->pstNachster){
 //        if(bDatenLoschen){
 //          if(!vmSpeicher) VMFrei(((STKnoten*)pstErster)->pvDaten);
 //          else VMFrei(vmSpeicher, ((STKnoten*)pstErster)->pvDaten);
 //        }
 //        if(!vmSpeicher) VMFrei(pstErster);
 //        else VMFrei(vmSpeicher, pstErster);
 //        pstErster = 0; pstLetzter = 0;
 //        pstKnoten = 0; pstLoschen = 0;
 //  }
 //  else{ STKnoten* pstTemp = pstErster;
 //        pstErster = pstErster->pstNachster;
 //        if(bDatenLoschen){
 //          if(!vmSpeicher) VMFrei(((STKnoten*)pstTemp)->pvDaten);
 //          else VMFrei(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
 //        }
 //        if(!vmSpeicher) VMFrei(pstTemp);
 //        else VMFrei(vmSpeicher, pstTemp);
 //        pstKnoten = pstErster;
 //        pstLoschen = 0;
 //  }
 //}
 //else{   STKnoten* pstTemp = ((STKnoten*)pstLoschen)->pstNachster;
 //        ((STKnoten*)pstLoschen)->pstNachster = (((STKnoten*)pstLoschen)->pstNachster)->pstNachster;
 //        if(!((STKnoten*)pstLoschen)->pstNachster) pstLetzter = (STKnoten*)pstLoschen;
 //        if(bDatenLoschen){
 //          if(!vmSpeicher) VMFrei(((STKnoten*)pstTemp)->pvDaten);
 //          else VMFrei(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
 //        }
 //        if(!vmSpeicher) VMFrei(pstTemp);
 //        else VMFrei(vmSpeicher, pstTemp);
 //        pstKnoten = pstLoschen;
 //}
 //ulAnzahl--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteElementS(void*& pstKnoten, void*& pstLoschen, bool bDatenLoschen)
//{
// if(pstLoschen == NULL){
//   if(!pstErster->pstNachster){
//         if(bDatenLoschen){
//           if(!vmSpeicher) VMFreiS(((STKnoten*)pstErster)->pvDaten);
//           else VMFreiS(vmSpeicher, ((STKnoten*)pstErster)->pvDaten);
//         }
//         if(!vmSpeicher) VMFreiS(pstErster);
//         else VMFreiS(vmSpeicher, pstErster);
//         pstErster = 0; pstLetzter = 0;
//         pstKnoten = 0; pstLoschen = 0;
//   }
//   else{ STKnoten* pstTemp = pstErster;
//         pstErster = pstErster->pstNachster;
//         if(bDatenLoschen){
//           if(!vmSpeicher) VMFreiS(((STKnoten*)pstTemp)->pvDaten);
//           else VMFreiS(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//         }
//         if(!vmSpeicher) VMFreiS(pstTemp);
//         else VMFreiS(vmSpeicher, pstTemp);
//         pstKnoten = pstErster;
//         pstLoschen = 0;
//   }
// }
// else{   STKnoten* pstTemp = ((STKnoten*)pstLoschen)->pstNachster;
//         ((STKnoten*)pstLoschen)->pstNachster = (((STKnoten*)pstLoschen)->pstNachster)->pstNachster;
//         if(!((STKnoten*)pstLoschen)->pstNachster) pstLetzter = (STKnoten*)pstLoschen;
//         if(bDatenLoschen){
//           if(!vmSpeicher) VMFreiS(((STKnoten*)pstTemp)->pvDaten);
//           else VMFreiS(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//         }
//         if(!vmSpeicher) VMFreiS(pstTemp);
//         else VMFreiS(vmSpeicher, pstTemp);
//         pstKnoten = pstLoschen;
// }
// ulAnzahl--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteFirstElement(void*& pstKnoten, bool bDatenLoschen)
//{
// if(!pstErster->pstNachster){
//       if(bDatenLoschen){
//         if(!vmSpeicher) VMFrei(((STKnoten*)pstErster)->pvDaten);
//         else VMFrei(vmSpeicher, ((STKnoten*)pstErster)->pvDaten);
//       }
//       if(!vmSpeicher) VMFrei(pstErster);
//       else VMFrei(vmSpeicher, pstErster);
//       pstErster = 0; pstLetzter = 0; pstKnoten = 0;
// }
// else{ STKnoten* pstTemp = pstErster;
//       pstErster = pstErster->pstNachster;
//       if(bDatenLoschen){
//         if(!vmSpeicher) VMFrei(((STKnoten*)pstTemp)->pvDaten);
//         else VMFrei(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//       }
//       if(!vmSpeicher) VMFrei(pstTemp);
//       else VMFrei(vmSpeicher, pstTemp);
//       pstKnoten = pstErster;
// }
// ulAnzahl--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteFirstElementS(void*& pstKnoten, bool bDatenLoschen)
//{
// if(!pstErster->pstNachster){
//       if(bDatenLoschen){
//         if(!vmSpeicher) VMFreiS(((STKnoten*)pstErster)->pvDaten);
//         else VMFreiS(vmSpeicher, ((STKnoten*)pstErster)->pvDaten);
//       }
//       if(!vmSpeicher) VMFreiS(pstErster);
//       else VMFreiS(vmSpeicher, pstErster);
//       pstErster = 0; pstLetzter = 0; pstKnoten = 0;
// }
// else{ STKnoten* pstTemp = pstErster;
//       pstErster = pstErster->pstNachster;
//       if(bDatenLoschen){
//         if(!vmSpeicher) VMFreiS(((STKnoten*)pstTemp)->pvDaten);
//         else VMFreiS(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//       }
//       if(!vmSpeicher) VMFreiS(pstTemp);
//       else VMFreiS(vmSpeicher, pstTemp);
//       pstKnoten = pstErster;
// }
// ulAnzahl--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteList(bool bDatenLoschen)
//{
// while(pstErster){
//     STKnoten* pstTemp = pstErster;
//     pstErster = pstErster->pstNachster;
//     if(bDatenLoschen){
//       if(!vmSpeicher) VMFrei(((STKnoten*)pstTemp)->pvDaten);
//       else VMFrei(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//     }
//     if(!vmSpeicher) VMFrei(pstTemp);
//     else VMFrei(vmSpeicher, pstTemp);
// }
// ulAnzahl = 0;
// pstLetzter = 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::ThDeleteList(bool bDatenLoschen)
//{
// EnterCriticalSection(&csIterator);
// DeleteList(bDatenLoschen);
// LeaveCriticalSection(&csIterator);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::DeleteListS(bool bDatenLoschen)
//{
// while(pstErster){
//     STKnoten* pstTemp = pstErster;
//     pstErster = pstErster->pstNachster;
//     if(bDatenLoschen){
//       if(!vmSpeicher) VMFreiS(((STKnoten*)pstTemp)->pvDaten);
//       else VMFreiS(vmSpeicher, ((STKnoten*)pstTemp)->pvDaten);
//     }
//     if(!vmSpeicher) VMFreiS(pstTemp);
//     else VMFreiS(vmSpeicher, pstTemp);
// }
// ulAnzahl = 0;
// pstLetzter = 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::ThDeleteListS(bool bDatenLoschen)
//{
// EnterCriticalSection(&csIterator);
// DeleteListS(bDatenLoschen);
// LeaveCriticalSection(&csIterator);
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::NextElement(void*& pstKnoten)
//{
// pstKnoten = ((STKnoten*)pstKnoten)->pstNachster;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::NextElement(void*& pstKnotenAktuell, void*& pstKnotenVorheriger)
//{
// if(pstKnotenAktuell){
//   if(pstKnotenAktuell != pstErster || pstKnotenVorheriger != pstErster){
//      pstKnotenVorheriger = pstKnotenAktuell;
//      pstKnotenAktuell = ((STKnoten*)pstKnotenAktuell)->pstNachster;
//   }
//   else pstKnotenVorheriger = 0;
// }
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::Element(void* pstKnoten)
//{
// return ((STKnoten*)pstKnoten)->pvDaten;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::Insert(void*& pstKnotenAktuell, void*& pstKnotenVorheriger, void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStd;
// else vstTemp = VSTKnoten;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = (STKnoten*)pstKnotenAktuell;
// if(pstKnotenVorheriger == NULL) pstErster = vstTemp;
// else ((STKnoten*)pstKnotenVorheriger)->pstNachster = vstTemp;
// if(pstKnotenAktuell == NULL) pstLetzter = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::InsertS(void*& pstKnotenAktuell, void*& pstKnotenVorheriger, void* pvDaten)
//{
// STKnoten* vstTemp;
// if(!vmSpeicher) vstTemp = VSTKnotenStdS;
// else vstTemp = VSTKnotenS;
// vstTemp->pvDaten = pvDaten;
// vstTemp->pstNachster = (STKnoten*)pstKnotenAktuell;
// if(pstKnotenVorheriger == NULL) pstErster = vstTemp;
// else ((STKnoten*)pstKnotenVorheriger)->pstNachster = vstTemp;
// if(pstKnotenAktuell == NULL) pstLetzter = vstTemp;
// ulAnzahl++;
// return vstTemp;
//}
////---------------------------------------------------------------------------
//ULONG __vectorcall COList::Number(void)
//{
// return ulAnzahl;
//}
////---------------------------------------------------------------------------
//ULONG& __vectorcall COList::ThNumber(ULONG& ulAnzahlA)
//{
// TryEnterCriticalSection(&csIterator);
// ulAnzahlA = ulAnzahl;
// LeaveCriticalSection(&csIterator);
// return ulAnzahlA;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::IteratorToBegin(void)
//{
// return pstErster;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThIteratorToBegin(void)
//{
// TryEnterCriticalSection(&csIterator);
// return pstErster;
//}
////---------------------------------------------------------------------------
//void* __vectorcall COList::ThIteratorToBegin_Lock(void)
//{
// EnterCriticalSection(&csIterator);
// return pstErster;
//}
////---------------------------------------------------------------------------
//void __vectorcall COList::ThIteratorEnd(void)
//{
// LeaveCriticalSection(&csIterator);
//}
////---------------------------------------------------------------------------