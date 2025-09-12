#include "HADT.h"
//#include "OZeit.h"
//#define BY_COZEIT 20
//#define _FZeit ((STFZeit*)c16FZeit)->FZeit
//---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(void)
//{
// COZeit* vZeit = (COZeit*)VMBlock(BY_COZEIT);
// vZeit->COZeitV();
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(VMEMORY vmSpeicher)
//{
// COZeit* vZeit = (COZeit*)VMBlock(vmSpeicher, BY_COZEIT);
// vZeit->COZeitV(vmSpeicher);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(const char* pcString)
//{
// COZeit* vZeit = (COZeit*)VMBlock(BY_COZEIT);
// vZeit->COZeitV(pcString);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(const SYSTEMTIME& stSystemTime)
//{
// COZeit* vZeit = (COZeit*)VMBlock(BY_COZEIT);
// vZeit->COZeitV(stSystemTime);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(VMEMORY vmSpeicher, const char* pcString)
//{
// COZeit* vZeit = (COZeit*)VMBlock(vmSpeicher, BY_COZEIT);
// vZeit->COZeitV(vmSpeicher, pcString);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(const COZeit* pzZeit)
//{
// COZeit* vZeit = (COZeit*)VMBlock(BY_COZEIT);
// vZeit->COZeitV(pzZeit);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(VMEMORY vmSpeicher, const COZeit* pzZeit)
//{
// COZeit* vZeit = (COZeit*)VMBlock(vmSpeicher, BY_COZEIT);
// vZeit->COZeitV(vmSpeicher, pzZeit);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(const STZeit& stZeit)
//{
// COZeit* vZeit = (COZeit*)VMBlock(BY_COZEIT);
// vZeit->COZeitV(stZeit);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(VMEMORY vmSpeicher, const STZeit& stZeit)
//{
// COZeit* vZeit = (COZeit*)VMBlock(vmSpeicher, BY_COZEIT);
// vZeit->COZeitV(vmSpeicher, stZeit);
// return vZeit;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeitV(VMEMORY vmSpeicher, const SYSTEMTIME& stSystemTime)
//{
// COZeit* vZeit = (COZeit*)VMBlock(vmSpeicher, BY_COZEIT);
// vZeit->COZeitV(vmSpeicher, stSystemTime);
// return vZeit;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(void)
//{
// vmSpeicher = NULL;
// _FZeit.dwLowDateTime = 0;
// _FZeit.dwHighDateTime = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(const COZeit* pzZeit)
//{
//	vmSpeicher = NULL;
//	*this = *pzZeit;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(const char* pcString)
//{
// vmSpeicher = NULL;
// StringzuFILETIME(pcString);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(const STZeit& stZeit)
//{
// vmSpeicher = NULL;
// SYSTEMTIME stSZeit = {2011,7,3,23,0,0,0,0};
//
// stSZeit.wDay = (WORD)stZeit.ulTag; stSZeit.wMonth = stZeit.ucMonat; stSZeit.wYear = stZeit.usJahr;
// stSZeit.wHour = stZeit.ucStunde; stSZeit.wMinute = stZeit.ucMinute; stSZeit.wSecond = stZeit.ucSekunde;
 //stSZeit.wMilliseconds = stZeit.usMillisekunde;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(const SYSTEMTIME& stSystemTime)
//{
// vmSpeicher = NULL;
// SystemTimeToFileTime(&stSystemTime, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(VMEMORY vmSpeicherA)
//{
// vmSpeicher = vmSpeicherA;
// _FZeit.dwLowDateTime = 0; _FZeit.dwHighDateTime = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(VMEMORY vmSpeicherA, const COZeit* pzZeit)
//{
// vmSpeicher = vmSpeicherA;
// *this = *pzZeit;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(VMEMORY vmSpeicherA, const char* pcString)
//{
// vmSpeicher = vmSpeicherA;
// StringzuFILETIME(pcString);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(VMEMORY vmSpeicherA, const STTime& stZeit)
//{
// vmSpeicher = vmSpeicherA;
// SYSTEMTIME stSZeit = {2011,7,3,23,0,0,0,0};
//
// stSZeit.wDay = (WORD)stZeit.ulTag; stSZeit.wMonth = stZeit.ucMonat; stSZeit.wYear = stZeit.usJahr;
// stSZeit.wHour = stZeit.ucStunde; stSZeit.wMinute = stZeit.ucMinute; stSZeit.wSecond = stZeit.ucSekunde; stSZeit.wMilliseconds = stZeit.usMillisekunde;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::COZeitV(VMEMORY vmSpeicherA, const SYSTEMTIME& stSystemTime)
//{
// vmSpeicher = vmSpeicherA;
// SystemTimeToFileTime(&stSystemTime, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//VMEMORY __vectorcall COZeit::COFreiV(void)
//{
// return vmSpeicher;
//}
////---------------------------------------------------------------------------
//__thiscall COZeit::COZeit(const SYSTEMTIME& stSystemTime)
//{
//
//
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COZeit::StringzuFILETIME(const char* pcString)
//{
// SYSTEMTIME stSZeit = {2006,11,3,29,0,0,0,0};
// COStringA asString = pcString;
// COStringA asZiffer;
// ULONG ulLange = asString.Length();
//
// switch(ulLange){
//   case  8 : if(CharactersPosition(pcString, ulLange, 58, true) != 2){
//               asString.SubString(&asZiffer, 1, 2);
//               asZiffer.USHORT(stSZeit.wDay);
//               asString.SubString(&asZiffer, 4, 5);
//               asZiffer.USHORT(stSZeit.wMonth);
//               asString.SubString(&asZiffer, 7, 8);
//               asZiffer.USHORT(stSZeit.wYear);
//               stSZeit.wYear += 2000;
//               stSZeit.wHour = 0; stSZeit.wMinute = 0; stSZeit.wSecond = 0; stSZeit.wMilliseconds = 0;
//             }
//             else{
//               asString.SubString(&asZiffer, 1, 2);
//               asZiffer.USHORT(stSZeit.wHour);
//               asString.SubString(&asZiffer, 4, 5);
//               asZiffer.USHORT(stSZeit.wMinute);
//               asString.SubString(&asZiffer, 7, 8);
//               asZiffer.USHORT(stSZeit.wSecond);
//               stSZeit.wMilliseconds = 0;
//             }
//             break;
//   case 10 : asString.SubString(&asZiffer, 1, 2);
//             asZiffer.USHORT(stSZeit.wDay);
//             asString.SubString(&asZiffer, 4, 5);
//             asZiffer.USHORT(stSZeit.wMonth);
//             asString.SubString(&asZiffer, 7, 10);
//             asZiffer.USHORT(stSZeit.wYear);
//             stSZeit.wHour = 0; stSZeit.wMinute = 0; stSZeit.wSecond = 0; stSZeit.wMilliseconds = 0;
//             break;
//   case 17 : asString.SubString(&asZiffer, 1, 2);
//             asZiffer.USHORT(stSZeit.wDay);
//             asString.SubString(&asZiffer, 4, 5);
//             asZiffer.USHORT(stSZeit.wMonth);
//             asString.SubString(&asZiffer, 7, 8);
//             asZiffer.USHORT(stSZeit.wYear);
//						 stSZeit.wYear += 2000;
//
//             asString.SubString(&asZiffer, 10, 11);
//             asZiffer.USHORT(stSZeit.wHour);
//             asString.SubString(&asZiffer, 13, 14);
//             asZiffer.USHORT(stSZeit.wMinute);
//             asString.SubString(&asZiffer, 16, 17);
//             asZiffer.USHORT(stSZeit.wSecond);
//             stSZeit.wMilliseconds = 0;
//             break;
//   case 19 : asString.SubString(&asZiffer, 1, 2);
//             asZiffer.USHORT(stSZeit.wDay);
//             asString.SubString(&asZiffer, 4, 5);
//             asZiffer.USHORT(stSZeit.wMonth);
//             asString.SubString(&asZiffer, 7, 10);
//             asZiffer.USHORT(stSZeit.wYear);
//
//             asString.SubString(&asZiffer, 12, 13);
//             asZiffer.USHORT(stSZeit.wHour);
//             asString.SubString(&asZiffer, 15, 16);
//             asZiffer.USHORT(stSZeit.wMinute);
//             asString.SubString(&asZiffer, 18, 19);
//             asZiffer.USHORT(stSZeit.wSecond);
//             stSZeit.wMilliseconds = 0;
//             break;
// }
// SystemTimeToFileTime(&stSZeit, &_FZeit);
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COZeit::Kopieren(void)
//{
// ((STFZeit*)c16FZeit)->FZeit_A = _FZeit;  
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COZeit::Wechseln(const COZeit& zZeit)
//{
// ((STFZeit*)zZeit.c16FZeit)->FZeit = ((STFZeit*)zZeit.c16FZeit)->FZeit_A; 
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeit::Now(void)
//{
// SYSTEMTIME stSZeit;
// GetLocalTime(&stSZeit);
// stSZeit.wMilliseconds = 0;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeit::Today(void)
//{
// SYSTEMTIME stSZeit;
// GetLocalTime(&stSZeit);
// stSZeit.wHour = 0; stSZeit.wMinute = 0; stSZeit.wSecond = 0; stSZeit.wMilliseconds = 0;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//COZeit* __vectorcall COZeit::Morgen(void)
//{
// SYSTEMTIME stSZeit; ULARGE_INTEGER unZeit;
// GetLocalTime(&stSZeit);
// stSZeit.wHour = 0; stSZeit.wMinute = 0; stSZeit.wSecond = 0; stSZeit.wMilliseconds = 0;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart += 864000000000;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::IstNull(void)
//{
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// if(unZeit.QuadPart == 0) return true;
// return false;
//}
////---------------------------------------------------------------------------
//char* __vectorcall COZeit::CHARDate(char* pcDatum)
//{
// SYSTEMTIME stSZeit;
// ULONG ulTest = LOCALE_USER_DEFAULT;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, &stSZeit, NULL, pcDatum, 11);
// return pcDatum;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrDatum(COStringA* pasDatum)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// char pcZeit[11];
// GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, &stSZeit, NULL, pcZeit, 11);
// *pasDatum = pcZeit;
// return pasDatum;
//}
////---------------------------------------------------------------------------
//char* __vectorcall COZeit::CHARTime(char* pcZeit)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
 //GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, &stSZeit, NULL, pcZeit, 9);
// return pcZeit;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrZeit(COStringA* pasZeit)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// char pcZeit[9];
// GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, &stSZeit, NULL, pcZeit, 9);
// *pasZeit = pcZeit;
// return pasZeit;
//}
////---------------------------------------------------------------------------
//char* __vectorcall COZeit::CHARDateTime(char* pcDatumZeit)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, &stSZeit, NULL, pcDatumZeit, 11);
// pcDatumZeit[10] = 32;
// char pcZeit[9];
// GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, &stSZeit, NULL, pcZeit, 9);
// MemCopy(&pcDatumZeit[11], pcZeit, 9);
// return pcDatumZeit;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrDateTime(COStringA* pasDatumZeit)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// char pcDatum[11];
// GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, &stSZeit, NULL, pcDatum, 11);
// *pasDatumZeit = pcDatum;
// char pcZeit[9];
// GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, &stSZeit, NULL, pcZeit, 9);
// *pasDatumZeit += " "; *pasDatumZeit += pcZeit;
// return pasDatumZeit;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrDatumFormat(COStringA* pasDatum, const char* pcFormat)
//{
// SYSTEMTIME stSZeit; *pasDatum = NULL;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes = GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, NULL, NULL);
// VMBLOCK vbZeit = VMBlock(iBytes); vbZeit[iBytes - 1] = 0;
// if(GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, vbZeit, iBytes)) *pasDatum = vbZeit; 
// VMFrei(vbZeit); return pasDatum;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrZeitFormat(COStringA* pasZeit, const char* pcFormat)
//{
// SYSTEMTIME stSZeit; *pasZeit = NULL;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes = GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, NULL, NULL);
// VMBLOCK vbZeit = VMBlock(iBytes); vbZeit[iBytes - 1] = 0;
// if(GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, vbZeit, iBytes)) *pasZeit = vbZeit;
// VMFrei(vbZeit); return pasZeit;
//}
////---------------------------------------------------------------------------
//COStringA* __vectorcall COZeit::StrDateTimeFormat(COStringA* pasDatumZeit, const char* pcFormat_Datum, const char* pcFormat_Zeit, bool bAnordnung_DatumZeit)
//{
// SYSTEMTIME stSZeit; *pasDatumZeit = NULL;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes = GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Datum, NULL, NULL);
// VMBLOCK vbDatum = VMBlock(iBytes); vbDatum[iBytes - 1] = 0;
// GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Datum, vbDatum, iBytes);
//
// iBytes = GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Zeit, NULL, NULL);
// VMBLOCK vbZeit = VMBlock(iBytes); vbZeit[iBytes - 1] = 0;
// GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Zeit, vbZeit, iBytes);
//
// if(bAnordnung_DatumZeit){ *pasDatumZeit = vbDatum; *pasDatumZeit += vbZeit;}
// else{ *pasDatumZeit = vbZeit; *pasDatumZeit += vbDatum;}
// VMFrei(vbDatum); VMFrei(vbZeit);
// return pasDatumZeit;
//}
////---------------------------------------------------------------------------
//VMBLOCK __vectorcall COZeit::VMBLOCKDateFormat(VMBLOCK& vbDatum, const char* pcFormat)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes = GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, NULL, NULL);
// vbDatum = VMBlock(iBytes); vbDatum[iBytes - 1] = 0;
// GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, vbDatum, iBytes);
// return vbDatum;
//}
////---------------------------------------------------------------------------
//VMBLOCK __vectorcall COZeit::VMBLOCKZeitFormat(VMBLOCK& vbZeit, const char* pcFormat)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes = GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, NULL, NULL);
// vbZeit = VMBlock(iBytes); vbZeit[iBytes - 1] = 0;
// GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat, vbZeit, iBytes);
// return vbZeit;
//}
////---------------------------------------------------------------------------
//VMBLOCK __vectorcall COZeit::VMBLOCKDateTimeFormat(VMBLOCK& vbDatumZeit, const char* pcFormat_Datum, const char* pcFormat_Zeit, bool bAnordnung_DatumZeit)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// int iBytes_Datum = GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Datum, NULL, NULL);
// VMBLOCK vbDatum = VMBlock(iBytes_Datum); vbDatum[iBytes_Datum - 1] = 0;
// GetDateFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Datum, vbDatum, iBytes_Datum--);
//
// int iBytes_Zeit = GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Zeit, NULL, NULL);
// VMBLOCK vbZeit = VMBlock(iBytes_Zeit); vbZeit[iBytes_Zeit - 1] = 0;
// GetTimeFormat(LOCALE_USER_DEFAULT, NULL, &stSZeit, pcFormat_Zeit, vbZeit, iBytes_Zeit--);
//
// vbDatumZeit = VMBlock(iBytes_Datum + iBytes_Zeit + 1); vbDatumZeit[iBytes_Datum + iBytes_Zeit] = 0;
// if(bAnordnung_DatumZeit){ MemCopy(vbDatumZeit, vbDatum, iBytes_Datum); MemCopy(&vbDatumZeit[iBytes_Datum], vbZeit, iBytes_Zeit);}
// else{ MemCopy(vbDatumZeit, vbZeit, iBytes_Zeit); MemCopy(&vbDatumZeit[iBytes_Zeit], vbDatum, iBytes_Datum);}
// VMFrei(vbDatum); VMFrei(vbZeit);
// return vbDatumZeit;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator =(const char* pcString)
//{
// StringzuFILETIME(pcString);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator =(const COZeit& zZeit)
//{
// _FZeit = ((STFZeit*)zZeit.c16FZeit)->FZeit;
// Kopieren();
// Wechseln(zZeit);
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator =(const STZeit& stZeit)
//{
// SYSTEMTIME stSZeit;
//
// stSZeit.wDay = (WORD)stZeit.ulTag; stSZeit.wMonth = stZeit.ucMonat; stSZeit.wYear = stZeit.usJahr;
// stSZeit.wHour = stZeit.ucStunde; stSZeit.wMinute = stZeit.ucMinute; stSZeit.wSecond = stZeit.ucSekunde; stSZeit.wMilliseconds = stZeit.usMillisekunde;
// SystemTimeToFileTime(&stSZeit, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator =(const SYSTEMTIME& stSystemTime)
//{
// SystemTimeToFileTime(&stSystemTime, &_FZeit);
// Kopieren();
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator <(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) == -1) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator >(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) == 1) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator <=(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) < 1) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator >=(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) > -1) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator ==(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) == 0) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COZeit::operator !=(const COZeit& zZeit)
//{
// if(CompareFileTime(&_FZeit, &((STFZeit*)zZeit.c16FZeit)->FZeit) != 0) return true;
// else return false;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator +=(const STZeit& stZeit)
//{
// long long llDiffZeit;
// llDiffZeit = stZeit.usMillisekunde * 10000;
// llDiffZeit += stZeit.ucSekunde * 10000000;
// llDiffZeit += stZeit.ucMinute * 600000000;
// llDiffZeit += stZeit.ucStunde * 36000000000;
// llDiffZeit += stZeit.ulTag * 864000000000;
//
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart += llDiffZeit;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator +=(const long long llDiffSekunden)
//{
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart += llDiffSekunden * 10000000;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator -=(const STZeit& stZeit)
//{
// long long llDiffZeit;
// llDiffZeit = stZeit.usMillisekunde * 10000;
// llDiffZeit += stZeit.ucSekunde * 10000000;
// llDiffZeit += stZeit.ucMinute * 600000000;
// llDiffZeit += stZeit.ucStunde * 36000000000;
// llDiffZeit += stZeit.ulTag * 864000000000;
//
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart -= llDiffZeit;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::operator -=(const long long llDiffSekunden)
//{
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart -= llDiffSekunden * 10000000;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// Kopieren();
//}
////---------------------------------------------------------------------------
//COZeit& __vectorcall COZeit::operator +(const long long llDiffSekunden)
//{
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart += llDiffSekunden * 10000000;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// return *this;
//}
////---------------------------------------------------------------------------
//COZeit& __vectorcall COZeit::operator +(const STZeit& stZeit)
//{
// long long llDiffZeit;
// llDiffZeit = stZeit.usMillisekunde * 10000;
// llDiffZeit += stZeit.ucSekunde * 10000000;
// llDiffZeit += stZeit.ucMinute * 600000000;
// llDiffZeit += stZeit.ucStunde * 36000000000;
// llDiffZeit += stZeit.ulTag * 864000000000;
//
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart += llDiffZeit;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// return *this;
//}
////---------------------------------------------------------------------------
//COZeit& __vectorcall COZeit::operator -(const long long llDiffSekunden)
//{
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart -= llDiffSekunden * 10000000;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// return *this;
//}
////---------------------------------------------------------------------------
//COZeit& __vectorcall COZeit::operator -(const STZeit& stZeit)
//{
// long long llDiffZeit;
// llDiffZeit = stZeit.usMillisekunde * 10000;
// llDiffZeit += stZeit.ucSekunde * 10000000;
// llDiffZeit += stZeit.ucMinute * 600000000;
// llDiffZeit += stZeit.ucStunde * 36000000000;
// llDiffZeit += stZeit.ulTag * 864000000000;
//
// ULARGE_INTEGER unZeit;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
// unZeit.QuadPart -= llDiffZeit;
// _FZeit.dwHighDateTime = unZeit.HighPart;
// _FZeit.dwLowDateTime = unZeit.LowPart;
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::DifferenzZeit(const COZeit* pzZeit, STZeit& stZeit)
//{
// long long llDiffZeit; ULARGE_INTEGER unZeit; ULARGE_INTEGER unZeit_1;
// unZeit.HighPart = _FZeit.dwHighDateTime;
// unZeit.LowPart = _FZeit.dwLowDateTime;
//
// unZeit_1.HighPart = ((STFZeit*)pzZeit->c16FZeit)->FZeit.dwHighDateTime;
// unZeit_1.LowPart = ((STFZeit*)pzZeit->c16FZeit)->FZeit.dwLowDateTime;
//
// if(unZeit.QuadPart > unZeit_1.QuadPart) llDiffZeit = unZeit.QuadPart - unZeit_1.QuadPart;
// else llDiffZeit = unZeit_1.QuadPart - unZeit.QuadPart;
//
// stZeit.usJahr = 0; stZeit.ucMonat = 0;
// stZeit.ulTag = llDiffZeit / 864000000000; llDiffZeit -= stZeit.ulTag * 864000000000;
// stZeit.ucStunde = llDiffZeit / 36000000000; llDiffZeit -= stZeit.ucStunde * 36000000000;
// stZeit.ucMinute = llDiffZeit / 600000000; llDiffZeit -= stZeit.ucMinute * 600000000;
// stZeit.ucSekunde = llDiffZeit / 10000000; llDiffZeit -= stZeit.ucSekunde * 10000000;
// stZeit.usMillisekunde = llDiffZeit / 10000; llDiffZeit -= stZeit.usMillisekunde * 10000;
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::Lese(char* pcInhalt)
//{
// if(pcInhalt){ MemCopy(pcInhalt, &_FZeit.dwHighDateTime, 4); MemCopy(&pcInhalt[4], &_FZeit.dwLowDateTime, 4);}
//}
////---------------------------------------------------------------------------
//void __vectorcall COZeit::Schreibe(const char* pcInhalt)
//{
// if(pcInhalt){
//   MemCopy(&_FZeit.dwHighDateTime, pcInhalt, 4);
//   MemCopy(&_FZeit.dwLowDateTime, &pcInhalt[4], 4);
// }
// else Now();
// Kopieren();
//}
////---------------------------------------------------------------------------
//FILETIME __vectorcall COZeit::FileTime(void)
//{
// return _FZeit;
//}
////---------------------------------------------------------------------------
//SYSTEMTIME __vectorcall COZeit::SystemTime(void)
//{
// SYSTEMTIME stSZeit;
// FileTimeToSystemTime(&_FZeit, &stSZeit);
// return stSZeit;
//}
////---------------------------------------------------------------------------
