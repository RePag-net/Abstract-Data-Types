#include "HADT.h"
#include "OKomma4_80.h"
//---------------------------------------------------------------------------
//#define BY_COKOMMA4_80 24
//#define _Komma4_80 ((STKomma4_80*)c20Komma4_80)
//#define _sNachKomma_80 16
//#define _sNachKomma 8
//extern short sControlSchnitt;
//extern short sControlRund;
//extern short sNull;
//extern short sFunf;
//extern short sMinusFunf;
//extern short sFunfzig;
//extern short sMinusFunfzig;
//extern short sTeiler10;
//extern short sTeiler100;
//extern short sFaktor;
//extern short sHalbKreis;
//---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(const __m128d m128dZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V();
// return NULL;
//}
//---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(const double dZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(dZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher, const double dZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher, dZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(const int iZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(iZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher, const int iZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher, iZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(const long long llZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(llZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher, const long long llZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher, llZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(COComma4* pk4Zahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(pk4Zahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher, COComma4* pk4Zahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher, pk4Zahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(const COComma4_80* pk4gZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(pk4gZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80V(VMEMORY vmSpeicher, const COComma4_80* pk4gZahl)
//{
// COComma4_80* vKomma4_80 = (COComma4_80*)VMBlock(vmSpeicher, BY_COKOMMA4_80);
// vKomma4_80->COComma4_80V(vmSpeicher, pk4gZahl);
// return vKomma4_80;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(void)
//{
// vmSpeicher = NULL;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(const double dZahl)
//{
// vmSpeicher = NULL;
//
// short sControlAlt; short sFaktorB = -10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fld dZahl
//    fistp qword ptr [ebx]
//		fld dZahl
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler100
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunfzig
//    fstsw ax
//    sahf
//    jb Minus50
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    faddp ST(1), ST(0)		
//    ficom sFaktor
//    fstsw ax
//    sahf
//    jc EndeRund
//    fisub sFaktor
//    fld1
//		fild qword ptr [ebx]
//    faddp ST(1), ST(0)
//		fistp qword ptr [ebx]
//		jmp EndeRund
//
//    Minus50:
//    ficom sMinusFunfzig
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    fsubp ST(1), ST(0)
//    ficom sFaktorB
//    fstsw ax
//    sahf
//    ja EndeRund
//    fisub sFaktorB
//		fild qword ptr [ebx]
//    fld1
//    fsubp ST(1), ST(0)
//		fistp qword ptr [ebx]
//
//		EndeRund: 
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(const int iZahl)
//{
// vmSpeicher = NULL;
// _Komma4_80->llVorKomma = iZahl; _Komma4_80->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(const long long llZahl)
//{
// vmSpeicher = NULL;
// _Komma4_80->llVorKomma = llZahl; _Komma4_80->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(COComma4* pk4Zahl)
//{
// vmSpeicher = NULL;
// _Komma4_80->llVorKomma = pk4Zahl->VorKomma(); _Komma4_80->sNachKomma = pk4Zahl->NachKomma();
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(const COComma4_80* pk4gZahl)
//{
// vmSpeicher = NULL;
// *this = *pk4gZahl;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA)
//{
// vmSpeicher = vmSpeicherA;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA, const double dZahl)
//{
// vmSpeicher = vmSpeicherA;
//
// short sControlAlt; short sFaktorB = -10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fld dZahl
//    fistp qword ptr [ebx]
//		fld dZahl
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler100
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunfzig
//    fstsw ax
//    sahf
//    jb Minus50
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    faddp ST(1), ST(0)		
//    ficom sFaktor
//    fstsw ax
//    sahf
//    jc EndeRund
//    fisub sFaktor
//    fld1
//		fild qword ptr [ebx]
//    faddp ST(1), ST(0)
//		fistp qword ptr [ebx]
//		jmp EndeRund
//
//    Minus50:
//    ficom sMinusFunfzig
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    fsubp ST(1), ST(0)
//    ficom sFaktorB
//    fstsw ax
//    sahf
//    ja EndeRund
//    fisub sFaktorB
//		fild qword ptr [ebx]
//    fld1
//    fsubp ST(1), ST(0)
//		fistp qword ptr [ebx]
//
//		EndeRund: 
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA, const int iZahl)
//{
// vmSpeicher = vmSpeicherA;
// _Komma4_80->llVorKomma = iZahl; _Komma4_80->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA, const long long llZahl)
//{
// vmSpeicher = vmSpeicherA;
// _Komma4_80->llVorKomma = llZahl; _Komma4_80->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA, COComma4* pk4Zahl)
//{
// vmSpeicher = vmSpeicherA;
// _Komma4_80->llVorKomma = pk4Zahl->VorKomma(); _Komma4_80->sNachKomma = pk4Zahl->NachKomma();
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::COComma4_80V(VMEMORY vmSpeicherA, const COComma4_80* pk4gZahl)
//{
// vmSpeicher = vmSpeicherA;
// *this = *pk4gZahl;
//}
////---------------------------------------------------------------------------
//__thiscall COComma4_80::COComma4_80(const long long llZahl)
//{
//
//}
////---------------------------------------------------------------------------
//VMEMORY __vectorcall COComma4_80::COFreiV(void)
//{
// return vmSpeicher;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COComma4_80::Kopieren(void)
//{
// _Komma4_80->llVorKomma_A = _Komma4_80->llVorKomma;
// _Komma4_80->sNachKomma_A = _Komma4_80->sNachKomma;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COComma4_80::Wechseln(const COComma4_80& k4gZahl)
//{
// ((STKomma4_80*)k4gZahl.c20Komma4_80)->llVorKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->llVorKomma_A;
// ((STKomma4_80*)k4gZahl.c20Komma4_80)->sNachKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->sNachKomma_A;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COComma4_80::Wechseln(const COComma4& k4Zahl)
//{
// _asm{
//    fclex
//    mov edx, k4Zahl
//    fild dword ptr [edx + 4]
//		fistp dword ptr [edx]
//    fild word ptr [edx + 10]
//		fistp word ptr [edx + 8]
//    fclex
// }
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator =(const double dZahl)
//{
// vmSpeicher = NULL;
//
// short sControlAlt; short sFaktorB = -10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fld dZahl
//    fistp qword ptr [ebx]
//		fld dZahl
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler100
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunfzig
//    fstsw ax
//    sahf
//    jb Minus50
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    faddp ST(1), ST(0)		
//    ficom sFaktor
//    fstsw ax
//    sahf
//    jc EndeRund
//    fisub sFaktor
//    fld1
//		fild qword ptr [ebx]
//    faddp ST(1), ST(0)
//		fistp qword ptr [ebx]
//		jmp EndeRund
//
//    Minus50:
//    ficom sMinusFunfzig
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//    fsubp ST(1), ST(0)
//    ficom sFaktorB
//    fstsw ax
//    sahf
//    ja EndeRund
//    fisub sFaktorB
//		fild qword ptr [ebx]
//    fld1
//    fsubp ST(1), ST(0)
//		fistp qword ptr [ebx]
//
//		EndeRund: 
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator =(const COComma4& k4Zahl)
//{
// _asm{
//    fclex
//    mov ebx, this
//    mov edx, k4Zahl
//		fild dword ptr [edx]
//		fistp qword ptr [ebx]
//		fild word ptr [edx + _sNachKomma]
//		fistp word ptr [ebx + _sNachKomma_80]
//		fclex
// }
// Kopieren(); Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator =(const COComma4_80& k4gZahl)
//{
// _Komma4_80->llVorKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->llVorKomma;
// _Komma4_80->sNachKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->sNachKomma;
// Kopieren(); Wechseln(k4gZahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator =(const __m128d m128dZahl)
//{
// _Komma4_80->llVorKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->llVorKomma;
// _Komma4_80->sNachKomma = ((STKomma4_80*)k4gZahl.c20Komma4_80)->sNachKomma;
// Kopieren(); Wechseln(k4gZahl);
//}
//---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator +=(const COComma4& k4Zahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fiadd dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd word ptr [edx + _sNachKomma]
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Plus1
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Minus1
//    jmp Ende
//
//    Plus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Minus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    KleinerNull:
//    fild word ptr [edx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jnc UngleicheVorzeichen_1
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc BeideMinus
//
//    UngleicheVorzeichen_1:
//    fxch
//    fisub sFaktorA
//    faddp ST(1), ST(0)
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Plus_Faktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Plus_Faktor:
//    fisub sFaktorA
//    jmp Ende
//
//    GrosserNull:
//    fild word ptr [edx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jc Ende
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    UngleicheVorzeichen_2:
//    fxch
//    fiadd sFaktorA
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Minus_Faktor
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideMinus:
//		faddp ST(1), ST(0) 
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    ja Ende
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//
//    Minus_Faktor:
//    fisub sFaktorA
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Kopieren(); Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator +=(const COComma4_80& k4gZahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    faddp ST(1), ST(0)
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd word ptr [edx + _sNachKomma_80]
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Plus1
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Minus1
//    jmp Ende
//
//    Plus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Minus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    KleinerNull:
//    fild word ptr [edx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jnc UngleicheVorzeichen_1
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc BeideMinus
//
//    UngleicheVorzeichen_1:
//    fxch
//    fisub sFaktorA
//    faddp ST(1), ST(0)
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Plus_Faktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Plus_Faktor:
//    fisub sFaktorA
//    jmp Ende
//
//    GrosserNull:
//    fild word ptr [edx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jc Ende
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    UngleicheVorzeichen_2:
//    fxch
//    fiadd sFaktorA
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Minus_Faktor
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideMinus:
//		faddp ST(1), ST(0) 
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    ja Ende
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//
//    Minus_Faktor:
//    fisub sFaktorA
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Kopieren(); Wechseln(k4gZahl);
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator +(const COComma4& k4Zahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fiadd dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd word ptr [edx + _sNachKomma]
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Plus1
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Minus1
//    jmp Ende
//
//    Plus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Minus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    KleinerNull:
//    fild word ptr [edx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jnc UngleicheVorzeichen_1
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc BeideMinus
//
//    UngleicheVorzeichen_1:
//    fxch
//    fisub sFaktorA
//    faddp ST(1), ST(0)
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Plus_Faktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Plus_Faktor:
//    fisub sFaktorA
//    jmp Ende
//
//    GrosserNull:
//    fild word ptr [edx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jc Ende
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    UngleicheVorzeichen_2:
//    fxch
//    fiadd sFaktorA
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Minus_Faktor
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideMinus:
//		faddp ST(1), ST(0) 
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    ja Ende
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//
//    Minus_Faktor:
//    fisub sFaktorA
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator +(const COComma4_80& k4gZahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    faddp ST(1), ST(0)
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd word ptr [edx + _sNachKomma_80]
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Plus1
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Minus1
//    jmp Ende
//
//    Plus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Minus1:
//    fisub sFaktorA
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    KleinerNull:
//    fild word ptr [edx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jnc UngleicheVorzeichen_1
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc BeideMinus
//
//    UngleicheVorzeichen_1:
//    fxch
//    fisub sFaktorA
//    faddp ST(1), ST(0)
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jbe Plus_Faktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    Plus_Faktor:
//    fisub sFaktorA
//    jmp Ende
//
//    GrosserNull:
//    fild word ptr [edx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    fxch
//    ftst
//    fstsw ax
//    sahf
//    jc UngleicheVorzeichen_2
//
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jc Ende
//    fisub sFaktorA
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    UngleicheVorzeichen_2:
//    fxch
//    fiadd sFaktorA
//    faddp ST(1), ST(0)
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    jnc Minus_Faktor
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideMinus:
//		faddp ST(1), ST(0) 
//    fild sFaktorA
//    fchs
//    fistp sFaktorA
//    ficom sFaktorA
//    fstsw ax
//    sahf
//    ja Ende
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//
//    Minus_Faktor:
//    fisub sFaktorA
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4gZahl);
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator -=(const COComma4& k4Zahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fisub dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma_80]
//    fild word ptr [edx + _sNachKomma]
//	  fsubp ST(1), ST(0) 
//    jmp Ende
//
//    VorkommaGrosserNull:
//    fild word ptr [edx + _sNachKomma]
//    ftst
//    fstsw ax
//    sahf
//    jae NachkommaGrosserNull
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_1
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_2
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0) 
//    fisub sFaktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_2:
//    fadd
//    fchs
//    jmp Ende
//
//    NachkommaKleinerNull_1:
//    fcom
//    fstsw ax
//    sahf
//    jae MinuentKleiner
//    fxch
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner:
//		fsubp ST(1), ST(0)
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull:
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    fxch
//    fsubp ST(1), ST(0)
//    jmp Ende
//
//    VorkommaKleinerNull:
//    fild word ptr [edx + _sNachKomma]
//    ftst
//    fstsw ax
//    sahf
//    ja NachkommaGrosserNull_1
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma_80]
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner_3:
//    fisub word ptr [ebx + _sNachKomma_80]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_2
//    fcom
//    fstsw ax
//    sahf
//    ja MinuentKleiner_2
//    fsubrp ST(1), ST(0)
//    jmp Ende
//
//    MinuentKleiner_2:
//    fxch
//    fiadd sFaktor
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleinerNull_2:
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_1
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0)
//    fild sFaktor
//    fchs
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//		fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_1:
//    fadd
//    fchs
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator -=(const COComma4_80& k4gZahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    fsubp ST(1), ST(0)
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma_80]
//    fild word ptr [edx + _sNachKomma_80]
//	  fsubp ST(1), ST(0) 
//    jmp Ende
//
//    VorkommaGrosserNull:
//    fild word ptr [edx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jae NachkommaGrosserNull
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_1
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_2
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0) 
//    fisub sFaktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_2:
//    fadd
//    fchs
//    jmp Ende
//
//    NachkommaKleinerNull_1:
//    fcom
//    fstsw ax
//    sahf
//    jae MinuentKleiner
//    fxch
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner:
//		fsubp ST(1), ST(0)
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull:
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    fxch
//    fsubp ST(1), ST(0)
//    jmp Ende
//
//    VorkommaKleinerNull:
//    fild word ptr [edx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    ja NachkommaGrosserNull_1
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma_80]
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner_3:
//    fisub word ptr [ebx + _sNachKomma_80]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_2
//    fcom
//    fstsw ax
//    sahf
//    ja MinuentKleiner_2
//    fsubrp ST(1), ST(0)
//    jmp Ende
//
//    MinuentKleiner_2:
//    fxch
//    fiadd sFaktor
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleinerNull_2:
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_1
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0)
//    fild sFaktor
//    fchs
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//		fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_1:
//    fadd
//    fchs
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4gZahl);
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator -(const COComma4& k4Zahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fisub dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma_80]
//    fild word ptr [edx + _sNachKomma]
//	  fsubp ST(1), ST(0) 
//    jmp Ende
//
//    VorkommaGrosserNull:
//    fild word ptr [edx + _sNachKomma]
//    ftst
//    fstsw ax
//    sahf
//    jae NachkommaGrosserNull
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_1
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_2
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0) 
//    fisub sFaktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_2:
//    fadd
//    fchs
//    jmp Ende
//
//    NachkommaKleinerNull_1:
//    fcom
//    fstsw ax
//    sahf
//    jae MinuentKleiner
//    fxch
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner:
//		fsubp ST(1), ST(0)
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull:
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    fxch
//    fsubp ST(1), ST(0)
//    jmp Ende
//
//    VorkommaKleinerNull:
//    fild word ptr [edx + _sNachKomma]
//    ftst
//    fstsw ax
//    sahf
//    ja NachkommaGrosserNull_1
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma_80]
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner_3:
//    fisub word ptr [ebx + _sNachKomma_80]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_2
//    fcom
//    fstsw ax
//    sahf
//    ja MinuentKleiner_2
//    fsubrp ST(1), ST(0)
//    jmp Ende
//
//    MinuentKleiner_2:
//    fxch
//    fiadd sFaktor
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleinerNull_2:
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_1
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0)
//    fild sFaktor
//    fchs
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//		fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_1:
//    fadd
//    fchs
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator -(const COComma4_80& k4gZahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    fsubp ST(1), ST(0)
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma_80]
//    fild word ptr [edx + _sNachKomma_80]
//	  fsubp ST(1), ST(0) 
//    jmp Ende
//
//    VorkommaGrosserNull:
//    fild word ptr [edx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jae NachkommaGrosserNull
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_1
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_2
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0) 
//    fisub sFaktor
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_2:
//    fadd
//    fchs
//    jmp Ende
//
//    NachkommaKleinerNull_1:
//    fcom
//    fstsw ax
//    sahf
//    jae MinuentKleiner
//    fxch
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner:
//		fsubp ST(1), ST(0)
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull:
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma_80]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    fxch
//    fsubp ST(1), ST(0)
//    jmp Ende
//
//    VorkommaKleinerNull:
//    fild word ptr [edx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    ja NachkommaGrosserNull_1
//    ficom word ptr [ebx + _sNachKomma_80]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma_80]
//    fild sFaktor
//    fchs
//    faddp ST(1), ST(0)
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    MinuentKleiner_3:
//    fisub word ptr [ebx + _sNachKomma_80]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma_80]
//    ftst
//    fstsw ax
//    sahf
//    jb NachkommaKleinerNull_2
//    fcom
//    fstsw ax
//    sahf
//    ja MinuentKleiner_2
//    fsubrp ST(1), ST(0)
//    jmp Ende
//
//    MinuentKleiner_2:
//    fxch
//    fiadd sFaktor
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//    faddp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleinerNull_2:
//    fchs
//    fcom
//    fstsw ax
//    sahf
//    je BeideGleich_1
//    fchs
//    fxch
//    fchs
//    faddp ST(1), ST(0)
//    fild sFaktor
//    fchs
//    fsubp ST(1), ST(0)
//    fxch
//    fld1
//		fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    BeideGleich_1:
//    fadd
//    fchs
//
//    Ende:
//    fistp word ptr [ebx + _sNachKomma_80]
//    fistp qword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4gZahl);
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator *=(const COComma4& k4Zahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fimul dword ptr [edx]
//    fild qword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv sFaktor
//    fild dword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma_80]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma_80]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator *=(const COComma4_80& k4gZahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    fmulp ST(1), ST(0)
//    fild qword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma_80]
//    fidiv sFaktor
//    fild qword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma_80]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma_80]
//    fimul word ptr [edx + _sNachKomma_80]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4gZahl);
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator *(const COComma4& k4Zahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fimul dword ptr [edx]
//    fild qword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv sFaktor
//    fild dword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma_80]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma_80]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator *(const COComma4_80& k4gZahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fild qword ptr [edx]
//    fmulp ST(1), ST(0)
//    fild qword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma_80]
//    fidiv sFaktor
//    fild qword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma_80]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma_80]
//    fimul word ptr [edx + _sNachKomma_80]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubp ST(1), ST(0)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4gZahl);
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator /=(const COComma4& k4Zahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//    fild dword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma]
//		fdivp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//		fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator /=(const COComma4_80& k4gZahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//    fild qword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma_80]
//		fdivp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//		fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4gZahl);
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator /(const COComma4& k4Zahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//    fild dword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma]
//		fdivp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//		fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//COComma4_80& __vectorcall COComma4_80::operator /(const COComma4_80& k4gZahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4gZahl
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//    fild qword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma_80]
//		fdivp ST(1), ST(0)
//		fst ST(1)
//		fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//		fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//		fsubp ST(1), ST(0)
//    fimul sTeiler10
//    fclex
//    fldcw sControlRund
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4gZahl);
// return *this;
//}
////---------------------------------------------------------------------------
//char __vectorcall COComma4_80::Vergleich(const COComma4* pk4Zahl)
//{
// //if(_Komma4_80->llVorKomma < pk4Zahl->VorKomma()) return -1;
// //else if(_Komma4_80->llVorKomma > pk4Zahl->VorKomma()) return 1;
// //else if(_Komma4_80->sNachKomma < pk4Zahl->NachKomma()) return -1;
// //else if(_Komma4_80->sNachKomma > pk4Zahl->NachKomma()) return 1;
// return 0;
//}
////---------------------------------------------------------------------------
//char __vectorcall COComma4_80::Vergleich(const COComma4_80* pk4gZahl)
//{
// if(_Komma4_80->llVorKomma < ((STKomma4_80*)pk4gZahl->c20Komma4_80)->llVorKomma) return -1;
// else if(_Komma4_80->llVorKomma > ((STKomma4_80*)pk4gZahl->c20Komma4_80)->llVorKomma) return 1;
// else if(_Komma4_80->sNachKomma < ((STKomma4_80*)pk4gZahl->c20Komma4_80)->sNachKomma) return -1;
// else if(_Komma4_80->sNachKomma > ((STKomma4_80*)pk4gZahl->c20Komma4_80)->sNachKomma) return 1;
// return 0;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator <(COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator <(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) == -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator >(COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator >(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) == 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator <=(COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) < 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator <=(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) < 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator >=(COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) > -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator >=(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) > -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator ==(const COComma4& k4Zahl)
//{
// //if(Vergleich(&k4Zahl) == 0) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator ==(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) == 0) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator !=(COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == 0) return false;
// return true;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4_80::operator !=(const COComma4_80& k4gZahl)
//{
// if(Vergleich(&k4gZahl) == 0) return false;
// return true;
//}
////---------------------------------------------------------------------------
//char __vectorcall COComma4_80::Vergleich(long long llVorKomma_2, short sNachKomma_2)
//{
// if(_Komma4_80->llVorKomma < llVorKomma_2) return -1;
// else if(_Komma4_80->llVorKomma > llVorKomma_2) return 1;
// else if(_Komma4_80->sNachKomma < sNachKomma_2) return -1;
// else if(_Komma4_80->sNachKomma > sNachKomma_2) return 1;
// return 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator ++(void)
//{
// _Komma4_80->llVorKomma++; _Komma4_80->llVorKomma_A++;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator ++(int i)
//{
// _Komma4_80->llVorKomma++; _Komma4_80->llVorKomma_A++;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator --(void)
//{
// _Komma4_80->llVorKomma--; _Komma4_80->llVorKomma_A--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::operator --(int i)
//{
// _Komma4_80->llVorKomma--; _Komma4_80->llVorKomma_A--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::Lese(_In_reads_(10) const char cZahl[10])
//{
// if(cZahl){ MemCopy((void*)cZahl, &_Komma4_80->llVorKomma, 8); MemCopy((void*)&cZahl[8], &_Komma4_80->sNachKomma, 2);}
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::Schreibe(_Out_writes_(10) const char c10Zahl[10])
//{
// if(c10Zahl){ MemCopy(&_Komma4_80->llVorKomma, c10Zahl, 8); MemCopy(&_Komma4_80->sNachKomma, &c10Zahl[8], 2);}
// else{ _Komma4_80->llVorKomma = 0; _Komma4_80->sNachKomma = 0;}
// Kopieren();
//}
////---------------------------------------------------------------------------
//long long __vectorcall COComma4_80::VorKomma(void)
//{
// return _Komma4_80->llVorKomma;
//}
////---------------------------------------------------------------------------
//short __vectorcall COComma4_80::NachKomma(void)
//{
// return _Komma4_80->sNachKomma;
//}
////---------------------------------------------------------------------------
//float __vectorcall COComma4_80::FLOAT(void)
//{
// return (float)_Komma4_80->llVorKomma + (float)_Komma4_80->sNachKomma / 10000;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4_80::DOUBLE(void)
//{
// return (double)_Komma4_80->llVorKomma + (double)_Komma4_80->sNachKomma / 10000;
//}
////---------------------------------------------------------------------------
//__m128d __vectorcall COComma4_80::M128D(void)
//{
//	__m128d m128d;
//	return m128d; //(double)_Komma4_80->llVorKomma + (double)_Komma4_80->sNachKomma / 10000;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::SetzNull(void)
//{
// _Komma4_80->llVorKomma = 0; _Komma4_80->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80::Runden(const unsigned char ucStellen)
//{
// if(ucStellen >= 0 && ucStellen < 4){ short sFaktorA; bool bNull = false;
//   switch(ucStellen){
//       case 0 : if(_Komma4_80->sNachKomma > 4000 || _Komma4_80->sNachKomma < -4000){
//                  if(_Komma4_80->llVorKomma >= 0) _Komma4_80->llVorKomma++;
//                  else _Komma4_80->llVorKomma--;
//                  _Komma4_80->sNachKomma = 0;
//                } break;
//       case 1 : sFaktorA = 1000;
//                if(_Komma4_80->sNachKomma > 9400 || _Komma4_80->sNachKomma < -9400){
//                  if(_Komma4_80->llVorKomma >= 0) _Komma4_80->llVorKomma++;
//                  else _Komma4_80->llVorKomma--;
//                  _Komma4_80->sNachKomma = 0; bNull = true;
//                } break;
//       case 2 : sFaktorA = 100;
//                if(_Komma4_80->sNachKomma > 9940 || _Komma4_80->sNachKomma < -9940){
//                  if(_Komma4_80->llVorKomma >= 0) _Komma4_80->llVorKomma++;
//                  else _Komma4_80->llVorKomma--;
//                  _Komma4_80->sNachKomma = 0; bNull = true;
//                } break;
//       case 3 : sFaktorA = 10;
//                if(_Komma4_80->sNachKomma > 9994 || _Komma4_80->sNachKomma < -9994){
//                  if(_Komma4_80->llVorKomma >= 0) _Komma4_80->llVorKomma++;
//                  else _Komma4_80->llVorKomma--;
//                  _Komma4_80->sNachKomma = 0; bNull = true;
//                } break;
//   }
//
//   if(!bNull){ short sControlAlt;
//     _asm{
//       fstcw sControlAlt
//       fclex
//       fldcw sControlSchnitt
//       mov ebx, this
//
//       fild word ptr [ebx + _sNachKomma_80]
//       fild word ptr [ebx + _sNachKomma_80]
//       fidiv sFaktorA
//       fistp word ptr [ebx + _sNachKomma_80]
//       fild word ptr [ebx + _sNachKomma_80]
//       fimul sFaktorA
//       fistp word ptr [ebx + _sNachKomma_80]
//       fild word ptr [ebx + _sNachKomma_80]
//			 fsubp ST(1), ST(0)
//       fild sFaktorA
//       fidiv sTeiler10
//			 fdivp ST(1), ST(0)	
//       frndint
//       ficom sNull
//       fstsw ax
//       sahf
//       je EndeRunden
//       ficom sFunf
//       fstsw ax
//       sahf
//       jb Minus5
//       fild word ptr [ebx + _sNachKomma_80]
//       fld1
//       fimul sFaktorA
//			 faddp ST(1), ST(0)
//       fistp word ptr [ebx + _sNachKomma_80]
//       jmp EndeRunden
//
//       Minus5:
//       ficom sMinusFunf
//       fstsw ax
//       sahf
//       ja EndeRunden
//       fild word ptr [ebx + _sNachKomma_80]
//       fld1
//       fimul sFaktorA
//	     fsubp ST(1), ST(0)
//       fistp word ptr [ebx + _sNachKomma_80]
//
//       EndeRunden:
//       ffree ST(0)
//       fclex
//       fldcw sControlAlt
//     }
//   }
// }
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4_80::VorzeichenAndern(void)
//{
// _asm{
//    fclex
//    mov ebx, this
//
//    fild qword ptr [ebx]
//		fchs
//		fistp qword ptr [ebx]
//		fclex
// }
// _Komma4_80->llVorKomma_A = _Komma4_80->llVorKomma;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80::pi(void)
//{
// short spi_VorKomma = 3, spi_NachKomma = 1416;
// _asm{
//    fclex
//    mov ebx, this
//    fild spi_VorKomma
//    fistp qword ptr [ebx]
//		fild spi_NachKomma
//    fistp word ptr [ebx + _sNachKomma_80]
//    fclex
// }
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//COComma4_80* __vectorcall COComma4_80::pi_10e18(void)
//{
// long long llpi_VorKomma = 3141592653589793238; short spi_NachKomma = 4626;
// _asm{
//    fclex
//    mov ebx, this
//    fild llpi_VorKomma
//    fistp qword ptr [ebx]
//		fild spi_NachKomma
//    fistp word ptr [ebx + _sNachKomma_80]
//    fclex
// }
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4_80::sin(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fsin
//
//		fst ST(1)
//    fistp qword ptr [ebx]
//    fild qword ptr [ebx]
//    fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// return 0;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4_80::cos(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fcos
//
//		fst ST(1)
//    fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// return 0;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4_80::tan(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fptan
//
//		fxch
//		fst ST(1)
//    fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// return 0;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4_80::Quadratwurzel(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild qword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma_80]
//		fidiv sFaktor
//
//	  fsqrt
//
//		fst ST(1)
//    fistp qword ptr [ebx]
//		fild qword ptr [ebx]
//    fsubr ST(0), ST(1)
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma_80]
//    fild word ptr [ebx + _sNachKomma_80]
//	  fsubp ST(1), ST(0)
//    fimul sTeiler10
//    frndint
//    ficom sNull
//    fstsw ax
//    sahf
//    je EndeRunden
//    ficom sFunf
//    fstsw ax
//    sahf
//    jb Minus5
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma_80]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma_80]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// return 0;
//}
////---------------------------------------------------------------------------