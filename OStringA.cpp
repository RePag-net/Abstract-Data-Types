#include "HADT.h"
#include "OStringA.h"
#define BY_COSTRINGA 20
#define _StringA ((STStringA*)c16StringA)
//---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(void)
//{
// COStringA* vStringA = (COStringA*)VMBlock(BY_COSTRINGA);
// vStringA->COStringAV();
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(VMEMORY vmSpeicher)
//{
// COStringA* vStringA = (COStringA*)VMBlock(vmSpeicher, BY_COSTRINGA);
// vStringA->COStringAV(vmSpeicher);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(const char* pcString)
//{
// COStringA* vStringA = (COStringA*)VMBlock(BY_COSTRINGA);
// vStringA->COStringAV(pcString);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(VMEMORY vmSpeicher, const char* pcString)
//{
// COStringA* vStringA = (COStringA*)VMBlock(vmSpeicher, BY_COSTRINGA);
// vStringA->COStringAV(vmSpeicher, pcString);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(const COStringA* pasString)
//{
// COStringA* vStringA = (COStringA*)VMBlock(BY_COSTRINGA);
// vStringA->COStringAV(pasString);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(VMEMORY vmSpeicher, const COStringA* pasString)
//{
// COStringA* vStringA = (COStringA*)VMBlock(vmSpeicher, BY_COSTRINGA);
// vStringA->COStringAV(vmSpeicher, pasString);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(const unsigned long ulStrLange)
//{
// COStringA* vStringA = (COStringA*)VMBlock(BY_COSTRINGA);
// vStringA->COStringAV(ulStrLange);
// return vStringA;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringAV(VMEMORY vmSpeicher, const unsigned long ulStrLange)
//{
// COStringA* vStringA = (COStringA*)VMBlock(vmSpeicher, BY_COSTRINGA);
// vStringA->COStringAV(vmSpeicher, ulStrLange);
// return vStringA;
//}
////---------------------------------------------------------------------------
//__thiscall COStringA::COStringA(_In_ VMEMORY vmSpeicher, _In_z_ const char* pcString)
//{
//	vmSpeicher = NULL;
//	_StringA->ulLange = 0; _StringA->vbInhalt = 0;
//	Kopieren();
//}
////---------------------------------------------------------------------------
//__thiscall COStringA::~COStringA(void)
//{
//
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(void)
//{
// vmSpeicher = NULL;
// _StringA->ulLange = 0; _StringA->vbInhalt = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(const char* pcString)
//{
// vmSpeicher = NULL;
// if(pcString){ _StringA->ulLange = StrLength(pcString);
//	 if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   MemCopy(_StringA->vbInhalt, pcString, _StringA->ulLange);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
//   Kopieren();
// }
// else{ _StringA->vbInhalt = 0; _StringA->ulLange = 0;}
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(const COStringA* pasString)
//{
// vmSpeicher = NULL;
// *this = *pasString;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(const unsigned long ulStrLange)
//{
// vmSpeicher = NULL;
// if(ulStrLange){
//   _StringA->ulLange = ulStrLange;
//	 if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
//   Kopieren();
// }
// else{ _StringA->vbInhalt = 0; _StringA->ulLange = 0;}
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(VMEMORY vmSpeicherA)
//{
// vmSpeicher = vmSpeicherA;
// _StringA->ulLange = 0; _StringA->vbInhalt = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(VMEMORY vmSpeicherA, const char* pcString)
//{
// vmSpeicher = vmSpeicherA;
// if(pcString){ _StringA->ulLange = StrLength(pcString);
//	 if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   MemCopy(_StringA->vbInhalt, pcString, _StringA->ulLange);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
//   Kopieren();
// }
// else{ _StringA->vbInhalt = 0; _StringA->ulLange = 0;}
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(VMEMORY vmSpeicherA, const COStringA* pasString)
//{
// vmSpeicher = vmSpeicherA;
// *this = *pasString;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::COStringAV(VMEMORY vmSpeicherA, const unsigned long ulStrLange)
//{
// vmSpeicher = vmSpeicherA;
// if(ulStrLange){
//   _StringA->ulLange = ulStrLange;
//	 if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
//   Kopieren();
// }
// else{ _StringA->vbInhalt = 0; _StringA->ulLange = 0;}
//}
////---------------------------------------------------------------------------
//VMEMORY __vectorcall COStringA::COFreiV(void)
//{
// Freigeben();
// return vmSpeicher;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COStringA::Kopieren(void)
//{
// _StringA->vbInhalt_A = _StringA->vbInhalt;
// _StringA->ulLange_A = _StringA->ulLange;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COStringA::Wechseln(const COStringA& asString)
//{
// if(((STStringA*)asString.c16StringA)->vbInhalt != ((STStringA*)asString.c16StringA)->vbInhalt_A){
//	 if(((STStringA*)asString.c16StringA)->vbInhalt) VMFrei(asString.vmSpeicher, ((STStringA*)asString.c16StringA)->vbInhalt);
//	 ((STStringA*)asString.c16StringA)->vbInhalt = ((STStringA*)asString.c16StringA)->vbInhalt_A;
//	 ((STStringA*)asString.c16StringA)->ulLange = ((STStringA*)asString.c16StringA)->ulLange_A;
// }
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COStringA::Freigeben(void)
//{
// if(_StringA->vbInhalt || _StringA->vbInhalt_A){
//	 if(_StringA->vbInhalt == _StringA->vbInhalt_A){
//		 if(!vmSpeicher) VMFrei(_StringA->vbInhalt);
//		 else VMFrei(vmSpeicher, _StringA->vbInhalt);
//	 }
//	 else{
//		 if(!vmSpeicher) VMFrei(_StringA->vbInhalt);
//		 else VMFrei(vmSpeicher, _StringA->vbInhalt);
//		 if(!vmSpeicher) VMFrei(_StringA->vbInhalt_A);
//		 else VMFrei(vmSpeicher, _StringA->vbInhalt_A);
//	 }
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::operator =(const COStringA& asString)
//{
// if(((STStringA*)asString.c16StringA)->ulLange){
//   Freigeben();
//   _StringA->ulLange = ((STStringA*)asString.c16StringA)->ulLange;
//   if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   MemCopy(_StringA->vbInhalt, ((STStringA*)asString.c16StringA)->vbInhalt, _StringA->ulLange);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
// 	 Kopieren(); Wechseln(asString);
// }
// else{ _StringA->ulLange = 0;
//   Freigeben();
//   _StringA->vbInhalt = 0;
// 	 Kopieren(); Wechseln(asString);
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::operator +=(const COStringA& asString)
//{
// if(((STStringA*)asString.c16StringA)->ulLange){ unsigned long ulNeueLange; VMBLOCK vbNeuerInhalt;
//   if(_StringA->ulLange){
//     ulNeueLange = _StringA->ulLange + ((STStringA*)asString.c16StringA)->ulLange;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//     MemCopy(&vbNeuerInhalt[_StringA->ulLange], ((STStringA*)asString.c16StringA)->vbInhalt, ulNeueLange - _StringA->ulLange);
//   }
//   else{
//     ulNeueLange = ((STStringA*)asString.c16StringA)->ulLange;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, ((STStringA*)asString.c16StringA)->vbInhalt, ulNeueLange);
//   }
//   vbNeuerInhalt[ulNeueLange] = 0;
//   _StringA->ulLange = ulNeueLange;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren(); Wechseln(asString);
// }
//}
////---------------------------------------------------------------------------
//COStringA& __vectorcall COStringA::operator +(const COStringA& asString)
//{
// if(((STStringA*)asString.c16StringA)->ulLange){ unsigned long ulNeueLange; VMBLOCK vbNeuerInhalt;
//   if(_StringA->ulLange){
//     ulNeueLange = _StringA->ulLange + ((STStringA*)asString.c16StringA)->ulLange;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//     MemCopy(&vbNeuerInhalt[_StringA->ulLange], ((STStringA*)asString.c16StringA)->vbInhalt, ulNeueLange - _StringA->ulLange);
//   }
//   else{
//     ulNeueLange = ((STStringA*)asString.c16StringA)->ulLange;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, ((STStringA*)asString.c16StringA)->vbInhalt, ulNeueLange);
//   }
//   vbNeuerInhalt[ulNeueLange] = 0;
//
//	 if(_StringA->vbInhalt_A == _StringA->vbInhalt){
//     _StringA->vbInhalt_A = _StringA->vbInhalt;
//	   _StringA->ulLange_A = _StringA->ulLange;
//	 }
//
//   _StringA->ulLange = ulNeueLange;
//   _StringA->vbInhalt = vbNeuerInhalt;
// }
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::operator =(const char* pcString)
//{
// if(pcString){ _StringA->ulLange = StrLength(pcString);
//   Freigeben();
//   if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   MemCopy(_StringA->vbInhalt, pcString, _StringA->ulLange);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
// }
// else{ _StringA->ulLange = 0;
//   Freigeben();
//   _StringA->vbInhalt = 0;
// }
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::operator +=(const char* pcString)
//{
// if(pcString){ unsigned long ulNeueLange; VMBLOCK vbNeuerInhalt;
//   if(_StringA->ulLange){
//     ulNeueLange = _StringA->ulLange + StrLength(pcString);
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//     MemCopy(&vbNeuerInhalt[_StringA->ulLange], pcString, ulNeueLange - _StringA->ulLange);
//   }
//   else{
//     ulNeueLange = StrLength(pcString);
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, pcString, ulNeueLange);
//   }
//   vbNeuerInhalt[ulNeueLange] = 0;
//   _StringA->ulLange = ulNeueLange;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//   Kopieren();
// }
//}
////---------------------------------------------------------------------------
//COStringA& __vectorcall COStringA::operator +(const char* pcString)
//{
// if(pcString){ unsigned long ulNeueLange; VMBLOCK vbNeuerInhalt;
//   if(_StringA->ulLange){
//     ulNeueLange = _StringA->ulLange + StrLength(pcString);
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//     MemCopy(&vbNeuerInhalt[_StringA->ulLange], pcString, ulNeueLange - _StringA->ulLange);
//   }
//   else{
//     ulNeueLange = StrLength(pcString);
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(ulNeueLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, ulNeueLange + 1);
//     MemCopy(vbNeuerInhalt, pcString, ulNeueLange);
//   }
//   vbNeuerInhalt[ulNeueLange] = 0;   
//
//	 if(_StringA->vbInhalt_A == _StringA->vbInhalt){
//     _StringA->vbInhalt_A = _StringA->vbInhalt;
//	   _StringA->ulLange_A = _StringA->ulLange;
//	 }
//
//	 _StringA->ulLange = ulNeueLange;
//   _StringA->vbInhalt = vbNeuerInhalt;
// }
// return *this;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator ==(const char* pcString)
//{
// unsigned long ulStrLange = StrLength(pcString);
// if(_StringA->ulLange && ulStrLange){
//   if(!StrCompare(_StringA->vbInhalt, _StringA->ulLange, pcString, ulStrLange)) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator !=(const char* pcString)
//{
// unsigned long ulStrLange = StrLength(pcString);
// if(_StringA->ulLange && ulStrLange){
//   if(!StrCompare(_StringA->vbInhalt, _StringA->ulLange, pcString, ulStrLange)) return false;
// }
// return true;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator <(const char* pcString)
//{
// unsigned long ulStrLange = StrLength(pcString);
// if(_StringA->ulLange && ulStrLange){
//   if(StrCompare(_StringA->vbInhalt, _StringA->ulLange, pcString, ulStrLange) == 1) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator >(const char* pcString)
//{
// unsigned long ulStrLange = StrLength(pcString);
// if(_StringA->ulLange && ulStrLange){
//   if(StrCompare(_StringA->vbInhalt, _StringA->ulLange, pcString, ulStrLange) == -1) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator ==(const COStringA& asString)
//{
// if(_StringA->ulLange && ((STStringA*)asString.c16StringA)->ulLange){
//   if(!StrCompare(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange)) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator !=(const COStringA& asString)
//{
// if(_StringA->ulLange && ((STStringA*)asString.c16StringA)->ulLange){
//   if(!StrCompare(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange)) return false;
// }
// return true;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator <(const COStringA& asString)
//{
// if(_StringA->ulLange && ((STStringA*)asString.c16StringA)->ulLange){
//   if(StrCompare(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange) == 1) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::operator >(const COStringA& asString)
//{
// if(_StringA->ulLange && ((STStringA*)asString.c16StringA)->ulLange){
//   if(StrCompare(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange) == -1) return true;
// }
// return false;
//}
////---------------------------------------------------------------------------
//char& __vectorcall COStringA::operator [](const unsigned long ulIndex)
//{
// if(ulIndex > _StringA->ulLange) return *_StringA->vbInhalt;
// return *(_StringA->vbInhalt + ulIndex);
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::Contain(const char* pcString)
//{
// return StrContain(_StringA->vbInhalt, _StringA->ulLange, pcString, StrLength(pcString));
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::ContainLeft(const char* pcString)
//{
// return StrContainLeft(_StringA->vbInhalt, _StringA->ulLange, pcString, StrLength(pcString));
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::ContainRight(const char* pcString)
//{
// return StrContainLeft(_StringA->vbInhalt, _StringA->ulLange, pcString, StrLength(pcString));
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::Contain(const COStringA& asString)
//{
// return StrContain(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange);
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::ContainLeft(const COStringA& asString)
//{
// return StrContainLeft(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange);
//}
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::ContainRight(const COStringA& asString)
//{
// return StrContainLeft(_StringA->vbInhalt, _StringA->ulLange, ((STStringA*)asString.c16StringA)->vbInhalt, ((STStringA*)asString.c16StringA)->ulLange);
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::ShortRight(const unsigned long ulStrLange)
//{
// if(_StringA->ulLange && ulStrLange && _StringA->ulLange >= ulStrLange){
//	 _StringA->ulLange -= ulStrLange;
//   if(_StringA->ulLange){
//     VMBLOCK vbNeuerInhalt;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//     MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//     vbNeuerInhalt[_StringA->ulLange] = 0;
//     Freigeben();
//     _StringA->vbInhalt = vbNeuerInhalt;
//		 Kopieren();
//   }
//   else{
//     Freigeben();
//     _StringA->vbInhalt = 0;
//		 Kopieren();
//   }
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::ShortLeft(const unsigned long ulStrLange)
//{
// if(_StringA->ulLange && ulStrLange && _StringA->ulLange >= ulStrLange){ 
//	 _StringA->ulLange -= ulStrLange;
//   if(_StringA->ulLange){
//     VMBLOCK vbNeuerInhalt;
//     if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + 1);
//     else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//     MemCopy(vbNeuerInhalt, &_StringA->vbInhalt[ulStrLange], _StringA->ulLange);
//     vbNeuerInhalt[_StringA->ulLange] = 0;
//     Freigeben();
//     _StringA->vbInhalt = vbNeuerInhalt;
//		 Kopieren();
//   }
//   else{
//     Freigeben();
//     _StringA->vbInhalt = 0;
//		 Kopieren();
//   }
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::ShortRightOne(void)
//{
// if(_StringA->ulLange){
//  if(--_StringA->ulLange) _StringA->vbInhalt[_StringA->ulLange] = 0;
//  else{
//    Freigeben();
//    _StringA->vbInhalt = 0;
//		Kopieren();
//  }
// }
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringA::Delete(const unsigned long ulPosition, const unsigned long ulAnzahl)
//{
// if(_StringA->ulLange >= ulPosition + ulAnzahl){
//   VMBLOCK vbNeuerInhalt;
//   if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange - ulAnzahl + 1);
//   else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange - ulAnzahl + 1);
//   MemCopy(vbNeuerInhalt, _StringA->vbInhalt, ulPosition);
//   MemCopy(&vbNeuerInhalt[ulPosition], &_StringA->vbInhalt[ulPosition + ulAnzahl], _StringA->ulLange - ulPosition - ulAnzahl);
//   _StringA->ulLange -= ulAnzahl;
//   vbNeuerInhalt[_StringA->ulLange] = 0;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren();
// }
// else if(!ulPosition && _StringA->ulLange == ulAnzahl){
//   Freigeben();
//   _StringA->ulLange = 0; _StringA->vbInhalt = 0;
//	 Kopieren();
// }
// else if(ulPosition == 1 && _StringA->ulLange == 1 && ulAnzahl == 1){
//   Freigeben();
//   _StringA->ulLange = 0; _StringA->vbInhalt = 0;
//	 Kopieren();
// }
// return this;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringA::Insert(const char* pcString, const unsigned long ulPosition)
//{
// if(ulPosition >= _StringA->ulLange){
//	 VMBLOCK vbNeuerInhalt; unsigned long ulStrLange = StrLength(pcString);
//   if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + ulStrLange + 1);
//   else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + ulStrLange + 1);
//   MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//   MemCopy(&vbNeuerInhalt[_StringA->ulLange], pcString, ulStrLange);
//   _StringA->ulLange += ulStrLange;
//   vbNeuerInhalt[_StringA->ulLange] = 0;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren();
// }
// else{
//	 VMBLOCK vbNeuerInhalt; unsigned long ulStrLange = StrLength(pcString);
//   if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + ulStrLange + 1);
//   else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + ulStrLange + 1);
//   MemCopy(vbNeuerInhalt, _StringA->vbInhalt, ulPosition);
//   MemCopy(&vbNeuerInhalt[ulPosition], pcString, ulStrLange);
//   MemCopy(&vbNeuerInhalt[ulPosition + ulStrLange], &_StringA->vbInhalt[ulPosition], _StringA->ulLange - ulPosition);
//   _StringA->ulLange += ulStrLange;
//   vbNeuerInhalt[_StringA->ulLange] = 0;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren();
// }
// return this;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringA::Insert(const COStringA* pasString, const unsigned long ulPosition)
//{
// if(ulPosition >= _StringA->ulLange){
//	 VMBLOCK vbNeuerInhalt;
//   if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + ((STStringA*)pasString->c16StringA)->ulLange + 1);
//   else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + ((STStringA*)pasString->c16StringA)->ulLange + 1);
//   MemCopy(vbNeuerInhalt, _StringA->vbInhalt, _StringA->ulLange);
//   MemCopy(&vbNeuerInhalt[_StringA->ulLange], ((STStringA*)pasString->c16StringA)->vbInhalt, ((STStringA*)pasString->c16StringA)->ulLange);
//   _StringA->ulLange += ((STStringA*)pasString->c16StringA)->ulLange;
//   vbNeuerInhalt[_StringA->ulLange] = 0;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren();
// }
// else{
//	 VMBLOCK vbNeuerInhalt;
//   if(!vmSpeicher) vbNeuerInhalt = VMBlock(_StringA->ulLange + ((STStringA*)pasString->c16StringA)->ulLange + 1);
//   else vbNeuerInhalt = VMBlock(vmSpeicher, _StringA->ulLange + ((STStringA*)pasString->c16StringA)->ulLange + 1);
//   MemCopy(vbNeuerInhalt, _StringA->vbInhalt, ulPosition);
//   MemCopy(&vbNeuerInhalt[ulPosition], ((STStringA*)pasString->c16StringA)->vbInhalt, ((STStringA*)pasString->c16StringA)->ulLange);
//   MemCopy(&vbNeuerInhalt[ulPosition + ((STStringA*)pasString->c16StringA)->ulLange], &_StringA->vbInhalt[ulPosition], _StringA->ulLange - ulPosition);
//   _StringA->ulLange += ((STStringA*)pasString->c16StringA)->ulLange;
//   vbNeuerInhalt[_StringA->ulLange] = 0;
//   Freigeben();
//   _StringA->vbInhalt = vbNeuerInhalt;
//	 Kopieren();
// }
// return this;
//}
////---------------------------------------------------------------------------
//unsigned long __vectorcall COStringA::Length(void)
//{
// return _StringA->ulLange;
//}
////---------------------------------------------------------------------------
//char* __vectorcall COStringA::c_Str(void)
//{
// return _StringA->vbInhalt;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::SetLength(const unsigned long ulStrLange)
//{
// Freigeben();
// _StringA->ulLange = ulStrLange;
// if(_StringA->ulLange){
//   if(!vmSpeicher) _StringA->vbInhalt = VMBlock(_StringA->ulLange + 1);
//   else _StringA->vbInhalt = VMBlock(vmSpeicher, _StringA->ulLange + 1);
//   _StringA->vbInhalt[_StringA->ulLange] = 0;
// }
// else _StringA->vbInhalt = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//inline unsigned char __vectorcall COStringA::EUoderUS(void)
//{
// unsigned char ucKomma = (unsigned char)CharactersPosition(_StringA->vbInhalt, _StringA->ulLange, 44, true);
// unsigned char ucPunkt = (unsigned char)CharactersPosition(_StringA->vbInhalt, _StringA->ulLange, 46, true);
//
// if(ucKomma == ucPunkt) return _StringA->ulLange - 1;
// else if(ucPunkt > ucKomma){
//        if(ucPunkt == _StringA->ulLange){
//          if(_StringA->vbInhalt[_StringA->ulLange - 1] == 46) return ucPunkt;
//          else return ucKomma;
//        }
//        else return ucPunkt;
// }
// else if(ucPunkt < ucKomma){
//        if(ucKomma == _StringA->ulLange){
//          if(_StringA->vbInhalt[_StringA->ulLange - 1] == 44) return ucKomma;
//          else return ucPunkt;
//        }
//        else return ucKomma;
// }
// return 0;
//}
////---------------------------------------------------------------------------
//unsigned char& __vectorcall COStringA::BYTE(unsigned char& ucZahl)
//{
// ucZahl = 0;
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{
//			 if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//			 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//			 ucZahl += (_StringA->vbInhalt[ucStelle] - 48) * (unsigned char)dFaktor;
//       dFaktor *= 10;
//		 }
//     while(ucStelle--);
//   }
// }
// return ucZahl;
//}
////---------------------------------------------------------------------------
//char& __vectorcall COStringA::CHAR(char& cZahl)
//{
// cZahl = 0; 
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 45){ cZahl *= - 1; break;}
//				 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//				 cZahl += (_StringA->vbInhalt[ucStelle] - 48) * (char)dFaktor;
//         dFaktor *= 10;
//		 }
//     while(ucStelle--);
//   }
// }
// return cZahl;
//}
////---------------------------------------------------------------------------
//short& __vectorcall COStringA::SHORT(short& sZahl)
//{
// sZahl = 0;
// if(_StringA->ulLange){
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 45){ sZahl *= - 1; break;}
//				 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break; 
//				 sZahl += (_StringA->vbInhalt[ucStelle] - 48) * (short)dFaktor;
//         dFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
// }
// return sZahl;
//}
////---------------------------------------------------------------------------
//unsigned short& __vectorcall COStringA::USHORT(unsigned short& usZahl)
//{
// usZahl = 0;
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break; 
//				 usZahl += (_StringA->vbInhalt[ucStelle] - 48) * (unsigned short)dFaktor;
//         dFaktor *= 10;
//		 }
//     while(ucStelle--);
//   }
// }
// return usZahl;
//}
////---------------------------------------------------------------------------
//long& __vectorcall COStringA::LONG(long& lZahl)
//{
// lZahl = 0;
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 45){ lZahl *= - 1; break;}
//				 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break; 
//				 lZahl += (_StringA->vbInhalt[ucStelle] - 48) * (long)dFaktor;
//         dFaktor *= 10;
//		 }
//     while(ucStelle--);
//   }
// }
// return lZahl;
//}
////---------------------------------------------------------------------------
//long long& __vectorcall COStringA::LONGLONG(long long& llZahl)
//{
// llZahl = 0;
// if(_StringA->ulLange){
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//	 if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//		 do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 45){ llZahl *= - 1; break;}
//				 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//				 llZahl += (_StringA->vbInhalt[ucStelle] - 48) * (long long)dFaktor;
//				 dFaktor *= 10;
//		 }
//		 while(ucStelle--);
//	 }
// }
// return llZahl;
//}
////---------------------------------------------------------------------------
//unsigned long& __vectorcall COStringA::ULONG(unsigned long& ulZahl)
//{
// ulZahl = 0;
// if(_StringA->ulLange){
//	 unsigned char ucStelle = _StringA->ulLange - 1;
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//		 double dFaktor = 1;
//     do{ if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) ucStelle--;
//         if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//				 ulZahl += (_StringA->vbInhalt[ucStelle] - 48) * (unsigned long)dFaktor;
//         dFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
// }
// return ulZahl;
//}
////---------------------------------------------------------------------------
//#pragma warning(disable : 4244)
//
//float& __vectorcall COStringA::FLOAT(float& fZahl)
//{
// fZahl = 0; 
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle, ucStelle_A; ucStelle = ucStelle_A = EUoderUS(); float fFaktor = 10; double dExponent = 0;
//   while(++ucStelle < _StringA->ulLange){
//      if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle++;
//			if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break; 
//			if(_StringA->vbInhalt[ucStelle] == 42){
//				if(_StringA->vbInhalt[++ucStelle] == 49){ 
//					ucStelle += 3;
//					if(_StringA->vbInhalt[ucStelle] == 45){ dExponent = -1; ucStelle++;}
//					else dExponent = 1;
//	 
//					if(_StringA->ulLange - ucStelle == 1){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(fFaktor--) dExponent *= 10;
//					}
//					else if(_StringA->ulLange - ucStelle == 2){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(fFaktor--) dExponent *= 10;
//					}
//					else if(_StringA->ulLange - ucStelle >= 3){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 100;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fFaktor = 0;
//						else fFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						if(fFaktor > 308 || fFaktor < -308) fFaktor = 0;
//						while(fFaktor--) dExponent *= 10;
//					}
//				}
//				else if(_StringA->vbInhalt[ucStelle] == 50){
//					ucStelle += 2;
//					if(_StringA->vbInhalt[ucStelle] == 45){ dExponent = -1; ucStelle++;}
//					else dExponent = 1;
//	 
//					if(_StringA->ulLange - ucStelle == 1){
//						fFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(fFaktor--) dExponent *= 2;
//					}
//					else if(_StringA->ulLange - ucStelle >= 2){
//						fFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						fFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						if(fFaktor > 38 || fFaktor < -38) fFaktor = 0;
//						while(fFaktor--) dExponent *= 2;
//					}
//			  }
//				break;
//			}
//			if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fZahl += 0.0 / fFaktor;
//			else fZahl += (float)(_StringA->vbInhalt[ucStelle] - 48) / fFaktor;
//      fFaktor *= 10;
//   }
//
//   ucStelle = ucStelle_A; fFaktor = 1;
//
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//     do{
//			 if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle--;
//			 if(_StringA->vbInhalt[ucStelle] == 45){ fZahl *= - 1; break;}
//			 if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//			 if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) fZahl += 0.0 / fFaktor;
//			 else fZahl += (float)(_StringA->vbInhalt[ucStelle] - 48) * fFaktor;
//       fFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
//
//	 if(dExponent > 0) fZahl *= dExponent;
//	 else if(dExponent < 0){ dExponent *= -1; fZahl /= dExponent;}
// }
// return fZahl;
//} 
////---------------------------------------------------------------------------
//double& __vectorcall COStringA::DOUBLE(double& dZahl)
//{
// dZahl = 0; 
// if(_StringA->ulLange){ unsigned char ucStelle, ucStelle_A; ucStelle = ucStelle_A = EUoderUS(); double dFaktor = 10, dExponent = 0;
//   while(++ucStelle < _StringA->ulLange){
//      if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle++;
//      if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break; 
//			if(_StringA->vbInhalt[ucStelle] == 42){
//				if(_StringA->vbInhalt[++ucStelle] == 49){ ucStelle += 3;
//					if(_StringA->vbInhalt[ucStelle] == 45){ dExponent = -1; ucStelle++;}
//					else dExponent = 1;
//	 
//					if(_StringA->ulLange - ucStelle == 1){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(dFaktor--) dExponent *= 10;
//					}
//					else if(_StringA->ulLange - ucStelle == 2){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(dFaktor--) dExponent *= 10;
//					}
//					else if(_StringA->ulLange - ucStelle >= 3){
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 100;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dFaktor = 0;
//						else dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						if(dFaktor > 308 || dFaktor < -308) dFaktor = 0;
//						while(dFaktor--) dExponent *= 10;
//					}
//				}
//				else if(_StringA->vbInhalt[ucStelle] == 50){ ucStelle += 2;
//					if(_StringA->vbInhalt[ucStelle] == 45){ dExponent = -1; ucStelle++;}
//					else dExponent = 1;
//	 
//					if(_StringA->ulLange - ucStelle == 1){
//						dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(dFaktor--) dExponent *= 2;
//					}
//					else if(_StringA->ulLange - ucStelle == 2){
//						dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						while(dFaktor--) dExponent *= 2;
//					}
//					else if(_StringA->ulLange - ucStelle >= 3){
//						dFaktor = (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 100;
//						dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle++] - 48) * 10;
//						dFaktor += (unsigned char)(_StringA->vbInhalt[ucStelle] - 48);
//						if(dFaktor > 308 || dFaktor < -308) dFaktor = 0;
//						while(dFaktor--) dExponent *= 2;
//					}
//			  }
//				break;
//			}
//			if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dZahl += 0.0 / dFaktor;
//			else	dZahl += (double)(_StringA->vbInhalt[ucStelle] - 48) / dFaktor;
//			dFaktor *= 10;
//   }
//
//   ucStelle = ucStelle_A; dFaktor = 1;
//
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){
//     do{ if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle--;
//				 if(_StringA->vbInhalt[ucStelle] == 45){ dZahl *= - 1; break;}
//		     if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//         if(_StringA->vbInhalt[ucStelle] < 48 || _StringA->vbInhalt[ucStelle] > 57) dZahl += 0.0 / dFaktor;
//				 else dZahl += (double)(_StringA->vbInhalt[ucStelle] - 48) * dFaktor;
//         dFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
//
//	 if(dExponent > 0) dZahl *= dExponent;
//	 else if(dExponent < 0){ dExponent *= -1; dZahl /= dExponent;}
// }
// return dZahl;
//} 
////---------------------------------------------------------------------------
//COComma4* __vectorcall COStringA::COMMA4(COComma4* pk4Zahl)
//{
// pk4Zahl->SetZero(); double dFaktor = 10; COComma4* vKomma4 = COComma4V();
// if(_StringA->ulLange){ 
//	 unsigned char ucStelle, ucStelle_A; ucStelle = ucStelle_A = EUoderUS();
//   while(++ucStelle < _StringA->ulLange){
//      if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle++;
//			if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//			*vKomma4 = (_StringA->vbInhalt[ucStelle] - 48) / dFaktor;
//      *pk4Zahl += *vKomma4;
//      dFaktor *= 10;
//   }
//
//   ucStelle = ucStelle_A; dFaktor = 1;
//
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){ 
//     do{
//        if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle--;
//				if(_StringA->vbInhalt[ucStelle] == 45){ *vKomma4 = -1.0; *pk4Zahl *= *vKomma4; break;}
//				if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//				*vKomma4 = (_StringA->vbInhalt[ucStelle] - 48) * dFaktor;
//        *pk4Zahl += *vKomma4; 
//        dFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
// }
// VMFreiV(vKomma4);
// return pk4Zahl;
//} 
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COStringA::COMMA4_80(COComma4_80* pk4gZahl)
//{
// pk4gZahl->SetZero(); double dFaktor = 10; COComma4_80* vKomma4_80 = COComma4_80V();
// if(_StringA->ulLange){ unsigned char ucStelle, ucStelle_A; ucStelle = ucStelle_A = EUoderUS();
//   while(++ucStelle < _StringA->ulLange){
//      if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle++;
//			if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//			*vKomma4_80 = (_StringA->vbInhalt[ucStelle] - 48) / dFaktor;
//      *pk4gZahl += *vKomma4_80;
//      dFaktor *= 10;
//   }
//
//   ucStelle = ucStelle_A; dFaktor = 1;
//
//   if(ucStelle || _StringA->vbInhalt[ucStelle] != 44 && _StringA->vbInhalt[ucStelle] != 46){ 
//     do{
//        if(_StringA->vbInhalt[ucStelle] == 46 || _StringA->vbInhalt[ucStelle] == 44) ucStelle--;
//				if(_StringA->vbInhalt[ucStelle] == 45){ *vKomma4_80 = -1.0; *pk4gZahl *= *vKomma4_80; break;}
//				if(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) break;
//				*vKomma4_80 = (_StringA->vbInhalt[ucStelle] - 48) * dFaktor;
//        *pk4gZahl += *vKomma4_80; 
//        dFaktor *= 10;
//     }
//     while(ucStelle--);
//   }
// }
// VMFreiV(vKomma4_80);
// return pk4gZahl;
//} 
//---------------------------------------------------------------------------
//bool __vectorcall COStringA::IsIntegralNumber(void)
//{
// if(!_StringA->ulLange) return false;
// unsigned char ucKomma = 0; unsigned char ucPunkt = 0; unsigned char ucStelle = 0;
// while(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) ucStelle++;
// if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) return false;
// if(_StringA->vbInhalt[ucStelle] == 45) ucStelle++;
// while(ucStelle < _StringA->ulLange){
//	 if(_StringA->vbInhalt[ucStelle] > 47 && _StringA->vbInhalt[ucStelle] < 58 || _StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46){
//		 if(_StringA->vbInhalt[ucStelle] == 44 && ucPunkt) return false;
//		 else if(_StringA->vbInhalt[ucStelle] == 44 && !ucKomma && !ucPunkt) ucKomma = ucStelle;
//		 else if(_StringA->vbInhalt[ucStelle] == 44 && ucKomma && ucPunkt) return false;
//     else if(_StringA->vbInhalt[ucStelle] == 46 && ucKomma) return false;
//		 else if(_StringA->vbInhalt[ucStelle] == 46 && !ucPunkt && !ucKomma) ucPunkt = ucStelle;
//		 else if(_StringA->vbInhalt[ucStelle] == 46 && ucPunkt && ucKomma) return false;
//	 }
//	 else return false;
//   ucStelle++;
// }
// return true;
//} 
////---------------------------------------------------------------------------
//bool __vectorcall COStringA::IsFloatingPointNumber(void)
//{
// if(!_StringA->ulLange) return false;
// unsigned char ucKomma = 0; unsigned char ucPunkt = 0; unsigned char ucStelle = 0; bool bExponent = false;
// while(_StringA->vbInhalt[ucStelle] == 32 || _StringA->vbInhalt[ucStelle] == 95) ucStelle++;
// if(_StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46) return false;
// if(_StringA->vbInhalt[ucStelle] == 45) ucStelle++;
// while(ucStelle < _StringA->ulLange){
//	 if(_StringA->vbInhalt[ucStelle] > 47 && _StringA->vbInhalt[ucStelle] < 58 || _StringA->vbInhalt[ucStelle] == 44 || _StringA->vbInhalt[ucStelle] == 46){
//		 if(_StringA->vbInhalt[ucStelle] == 44 && !ucKomma) ucKomma = ucStelle;
//		 else if(_StringA->vbInhalt[ucStelle] == 44 && ucKomma && ucPunkt) return false;
//		 else if(_StringA->vbInhalt[ucStelle] == 46 && !ucPunkt) ucPunkt = ucStelle;
//		 else if(_StringA->vbInhalt[ucStelle] == 46 && ucPunkt && ucKomma) return false;
//	 }
//	 else if(_StringA->vbInhalt[ucStelle++] == 42 && !bExponent){ bExponent = true;
//		 if(_StringA->vbInhalt[ucStelle] == 49) ucStelle += 3;
//		 else if(_StringA->vbInhalt[ucStelle] == 50) ucStelle += 2;
//		 else return false;
//     
//		 if(_StringA->vbInhalt[ucStelle] == 45) ucStelle++;
//
//		 while(ucStelle < _StringA->ulLange){
//       if(_StringA->vbInhalt[ucStelle] > 47 && _StringA->vbInhalt[ucStelle] < 58) ucStelle++;
//			 else return false;
//		 }
//		 break;
//	 }
//	 else return false;
//   ucStelle++;
// }
// return true;
//} 
////---------------------------------------------------------------------------
//unsigned long __vectorcall COStringA::SubString(VMBLOCK& vbString, unsigned long ulVon, unsigned long ulBis)
//{
// unsigned long ulStrLange = 0;
// if(ulVon && ulBis && ulBis <= _StringA->ulLange){
//	ulStrLange = ++ulBis - ulVon;
//  vbString = VMBlock(ulStrLange + 1); 
//  MemCopy(vbString, &_StringA->vbInhalt[ulVon - 1], ulStrLange);
//	vbString[ulStrLange] = 0;
// }
// return ulStrLange;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COStringA::SubString(COStringA* pasString, unsigned long ulVon, unsigned long ulBis)
//{
// if(ulVon && ulBis && ulBis <= _StringA->ulLange){
//  pasString->SetLength(++ulBis - ulVon);
//  MemCopy(((STStringA*)pasString->c16StringA)->vbInhalt, &_StringA->vbInhalt[ulVon - 1], ulBis - ulVon);
// }
// return pasString;
//}
////---------------------------------------------------------------------------
//unsigned long __vectorcall COStringA::SearchCharacters(const char* pcZeichen)
//{
// unsigned long ulx;
// for(ulx = 0; ulx < _StringA->ulLange; ulx++){
//   if(*pcZeichen == _StringA->vbInhalt[ulx]) return ++ulx;
// }
// return 0;
//}
////---------------------------------------------------------------------------
//unsigned long __vectorcall COStringA::SearchCharacters(const char* pcZeichen, unsigned long ulVon, unsigned long ulBis)
//{
// if(ulVon && ulBis && ulBis <= _StringA->ulLange){
//   unsigned long ulx;
//   for(ulx = ulVon; ulx <= ulBis; ulx++){
//     if(*pcZeichen == _StringA->vbInhalt[ulx]) return ++ulx;
//   }
// }
// return 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COStringA::Uppercase(void)
//{
// if(_StringA->ulLange){
//   for(unsigned long ulx = 0; ulx < _StringA->ulLange; ulx++){
//		 if(_StringA->vbInhalt[ulx] >= 0x61 && _StringA->vbInhalt[ulx] <= 0x7a) _StringA->vbInhalt[ulx] -= 0x20;
//	 } 
// }
//}
////---------------------------------------------------------------------------