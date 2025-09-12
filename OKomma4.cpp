#include "HADT.h"
#include "OKomma4.h"
//---------------------------------------------------------------------------
//short sControlSchnitt = 0x1F72;
//short sControlRund = 0x1372;
//short sNull = 0;
//short sFunf = 5;
//short sMinusFunf = -5;
//short sFunfzig = 50;
//short sMinusFunfzig = -50;
//short sTeiler10 = 10;
//short sTeiler100 = 100;
//short sFaktor = 10000;
//short sHalbKreis = 180;
//#define BY_COKOMMA4 16
//#define _Komma4 ((STKomma4*)c12Komma4)
//#define _sNachKomma 8
//---------------------------------------------------------------------------
//inline void __vectorcall COComma4::Kopieren(void)
//{
// _Komma4->lVorKomma_A = _Komma4->lVorKomma;
// _Komma4->sNachKomma_A = _Komma4->sNachKomma;
//}
////---------------------------------------------------------------------------
//inline void __vectorcall COComma4::Wechseln(const COComma4& k4Zahl)
//{
// ((STKomma4*)k4Zahl.c12Komma4)->lVorKomma = ((STKomma4*)k4Zahl.c12Komma4)->lVorKomma_A;
// ((STKomma4*)k4Zahl.c12Komma4)->sNachKomma = ((STKomma4*)k4Zahl.c12Komma4)->sNachKomma_A;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator =(const double dZahl)
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
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//    faddp ST(1), ST(0)		
//    ficom sFaktor
//    fstsw ax
//    sahf
//    jc EndeRund
//    fisub sFaktor
//    fld1
//		fild dword ptr [ebx]
//    faddp ST(1), ST(0)
//		fistp dword ptr [ebx]
//		jmp EndeRund
//
//    Minus50:
//    ficom sMinusFunfzig
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//    fsubp ST(1), ST(0)
//    ficom sFaktorB
//    fstsw ax
//    sahf
//    ja EndeRund
//    fisub sFaktorB
//		fild dword ptr [ebx]
//    fld1
//    fsubp ST(1), ST(0)
//		fistp dword ptr [ebx]
//
//		EndeRund: 
//    fistp word ptr [ebx + _sNachKomma]
//
//    EndeRunden:
//    ffree ST(0)
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
//}
//---------------------------------------------------------------------------
//void __vectorcall COComma4::operator =(const COComma4 k4Zahl)
//{
// _Komma4->lVorKomma = ((STKomma4*)k4Zahl.c12Komma4)->lVorKomma;
// _Komma4->sNachKomma = ((STKomma4*)k4Zahl.c12Komma4)->sNachKomma;
// Kopieren(); Wechseln(k4Zahl);
//}
//---------------------------------------------------------------------------
//void __vectorcall COComma4::operator +=(const COComma4& k4Zahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fiadd dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    fistp word ptr [ebx + _sNachKomma]
//    fistp dword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
 //Kopieren(); Wechseln(k4Zahl);
//}
//---------------------------------------------------------------------------
//COComma4& __vectorcall COComma4::operator +(const COComma4& k4Zahl)
//{
// short sControlAlt; short sFaktorA = 10000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fiadd dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja GrosserNull
//    jc KleinerNull
//
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    fistp word ptr [ebx + _sNachKomma]
//    fistp dword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator -=(const COComma4& k4Zahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fisub dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    ficom word ptr [ebx + _sNachKomma]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma]
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
//    ficom word ptr [ebx + _sNachKomma]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma]
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
//    fisub word ptr [ebx + _sNachKomma]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma]
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
//    fistp word ptr [ebx + _sNachKomma]
//    fistp dword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Kopieren();
// Wechseln(k4Zahl);
//}
////---------------------------------------------------------------------------
//COComma4& __vectorcall COComma4::operator -(const COComma4& k4Zahl)
//{ 
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fisub dword ptr [edx]
//    ftst
//    fstsw ax
//    sahf
//    ja VorkommaGrosserNull
//    jb VorkommaKleinerNull
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
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
//    ficom word ptr [ebx + _sNachKomma]
//    fstsw ax
//    sahf
//    jbe NachkommaKleiner_1
//    fild word ptr [ebx + _sNachKomma]
//    fiadd sFaktor
//    fsubrp ST(1), ST(0)
//    fxch
//    fld1
//    fsubp ST(1), ST(0)
//    fxch
//    jmp Ende
//
//    NachkommaKleiner_1:
//    fild word ptr [ebx + _sNachKomma]
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
//    ficom word ptr [ebx + _sNachKomma]
//    fstsw ax
//    sahf
//    jae MinuentKleiner_3
//    fild word ptr [ebx + _sNachKomma]
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
//    fisub word ptr [ebx + _sNachKomma]
//    fchs
//    jmp Ende
//
//    NachkommaGrosserNull_1:
//    fild word ptr [ebx + _sNachKomma]
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
//    fistp word ptr [ebx + _sNachKomma]
//    fistp dword ptr [ebx]
//    fclex
//    fldcw sControlAlt
// }
// Wechseln(k4Zahl);
// return *this;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator *=(const COComma4& k4Zahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fimul dword ptr [edx]
//    fild dword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv sFaktor
//    fild dword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//COComma4& __vectorcall COComma4::operator *(const COComma4& k4Zahl)
//{
// short sControlAlt; long lFaktor = 100000000;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fimul dword ptr [edx]
//    fild dword ptr [ebx]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv sFaktor
//    fild dword ptr [edx]
//    fimul word ptr [ebx + _sNachKomma]
//    fidiv sFaktor
//    fild word ptr [ebx + _sNachKomma]
//    fimul word ptr [edx + _sNachKomma]
//    fidiv lFaktor
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//		faddp ST(1), ST(0)
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//void __vectorcall COComma4::operator /=(const COComma4& k4Zahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//    fild dword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma]
//		fdivp ST(1), ST(0)
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//COComma4& __vectorcall COComma4::operator /(const COComma4& k4Zahl)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//    mov edx, k4Zahl
//
//    fild dword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//    fild dword ptr [edx]
//    fimul sFaktor
//    fiadd word ptr [edx + _sNachKomma]
//		fdivp ST(1), ST(0)
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//		fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//char __vectorcall COComma4::Vergleich(const COComma4* pk4Zahl)
//{
// if(_Komma4->lVorKomma < ((STKomma4*)pk4Zahl->c12Komma4)->lVorKomma) return -1;
// else if(_Komma4->lVorKomma > ((STKomma4*)pk4Zahl->c12Komma4)->lVorKomma) return 1;
// else if(_Komma4->sNachKomma < ((STKomma4*)pk4Zahl->c12Komma4)->sNachKomma) return -1;
// else if(_Komma4->sNachKomma > ((STKomma4*)pk4Zahl->c12Komma4)->sNachKomma) return 1;
// return 0;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator <(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator >(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator <=(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) < 1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator >=(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) > -1) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator ==(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == 0) return true;
// return false;
//}
////---------------------------------------------------------------------------
//bool __vectorcall COComma4::operator !=(const COComma4& k4Zahl)
//{
// if(Vergleich(&k4Zahl) == 0) return false;
// return true;
//}
////---------------------------------------------------------------------------
//char __vectorcall COComma4::Vergleich(long lVorKomma_2, short sNachKomma_2)
//{
// if(_Komma4->lVorKomma < lVorKomma_2) return -1;
// else if(_Komma4->lVorKomma > lVorKomma_2) return 1;
// else if(_Komma4->sNachKomma < sNachKomma_2) return -1;
// else if(_Komma4->sNachKomma > sNachKomma_2) return 1;
// return 0;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator ++(void)
//{
// _Komma4->lVorKomma++; _Komma4->lVorKomma_A++;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator ++(int i)
//{
// _Komma4->lVorKomma++; _Komma4->lVorKomma_A++;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator --(void)
//{
// _Komma4->lVorKomma--; _Komma4->lVorKomma_A--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::operator --(int i)
//{
// _Komma4->lVorKomma--; _Komma4->lVorKomma_A--;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::Lese(const char vbInhalt[6])
//{
// if(vbInhalt){ MemCopy((char*)vbInhalt, &_Komma4->lVorKomma, 4); MemCopy((char*)&vbInhalt[4], &_Komma4->sNachKomma, 2);}
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::Schreibe(const char vbInhalt[6])
//{
// if(vbInhalt){ MemCopy(&_Komma4->lVorKomma, vbInhalt, 4); MemCopy(&_Komma4->sNachKomma, &vbInhalt[4], 2);}
// else{ _Komma4->lVorKomma = 0; _Komma4->sNachKomma = 0;}
// Kopieren();
//}
//////---------------------------------------------------------------------------
//long __vectorcall COComma4::VorKomma(void)
//{
// return _Komma4->lVorKomma;
//}
////---------------------------------------------------------------------------
//short __vectorcall COComma4::NachKomma(void)
//{
// return _Komma4->sNachKomma;
//}
////---------------------------------------------------------------------------
//float __vectorcall COComma4::FLOAT(void)
//{
// return (float)_Komma4->lVorKomma + (float)_Komma4->sNachKomma / 10000;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4::DOUBLE(void)
//{
// return (double)_Komma4->lVorKomma + (double)_Komma4->sNachKomma / 10000;
//}
////---------------------------------------------------------------------------
//void __vectorcall COComma4::SetzNull(void)
//{
// _Komma4->lVorKomma = 0; _Komma4->sNachKomma = 0;
// Kopieren();
//}
////---------------------------------------------------------------------------
//COComma4* __vectorcall COComma4::Runden(const unsigned char ucStellen)
//{
// if(ucStellen >= 0 && ucStellen < 4){ short sFaktorA; bool bNull = false;
//   switch(ucStellen){
//       case 0 : if(_Komma4->sNachKomma > 4000 || _Komma4->sNachKomma < -4000){
//                  if(_Komma4->lVorKomma >= 0) _Komma4->lVorKomma++;
//                  else _Komma4->lVorKomma--;
//                  _Komma4->sNachKomma = 0;
//                } break;
//       case 1 : sFaktorA = 1000;
//                if(_Komma4->sNachKomma > 9400 || _Komma4->sNachKomma < -9400){
//                  if(_Komma4->lVorKomma >= 0) _Komma4->lVorKomma++;
//                  else _Komma4->lVorKomma--;
//                  _Komma4->sNachKomma = 0; bNull = true;
//                } break;
//       case 2 : sFaktorA = 100;
//                if(_Komma4->sNachKomma > 9940 || _Komma4->sNachKomma < -9940){
//                  if(_Komma4->lVorKomma >= 0) _Komma4->lVorKomma++;
//                  else _Komma4->lVorKomma--;
//                  _Komma4->sNachKomma = 0; bNull = true;
//                } break;
//       case 3 : sFaktorA = 10;
//                if(_Komma4->sNachKomma > 9994 || _Komma4->sNachKomma < -9994){
//                  if(_Komma4->lVorKomma >= 0) _Komma4->lVorKomma++;
//                  else _Komma4->lVorKomma--;
//                  _Komma4->sNachKomma = 0; bNull = true;
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
//       fild word ptr [ebx + _sNachKomma]
//       fild word ptr [ebx + _sNachKomma]
//       fidiv sFaktorA
//       fistp word ptr [ebx + _sNachKomma]
//       fild word ptr [ebx + _sNachKomma]
//       fimul sFaktorA
//       fistp word ptr [ebx + _sNachKomma]
//       fild word ptr [ebx + _sNachKomma]
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
//       fild word ptr [ebx + _sNachKomma]
//       fld1
//       fimul sFaktorA
//			 faddp ST(1), ST(0)
//       fistp word ptr [ebx + _sNachKomma]
//       jmp EndeRunden
//
//       Minus5:
//       ficom sMinusFunf
//       fstsw ax
//       sahf
//       ja EndeRunden
//       fild word ptr [ebx + _sNachKomma]
//       fld1
//       fimul sFaktorA
//	     fsubp ST(1), ST(0)
//       fistp word ptr [ebx + _sNachKomma]
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
//void __vectorcall COComma4::VorzeichenAndern(void)
//{
// _asm{
//    fclex
//    mov ebx, this
//
//    fild dword ptr [ebx]
//		fchs
//		fistp dword ptr [ebx]
//		fclex
// }
// _Komma4->lVorKomma_A = _Komma4->lVorKomma;
//}
////---------------------------------------------------------------------------
//COComma4* __vectorcall COComma4::pi(void)
//{
// short spi_VorKomma = 3, spi_NachKomma = 1416;
// _asm{
//    fclex
//    mov ebx, this
//    fild spi_VorKomma
//    fistp dword ptr [ebx]
//		fild spi_NachKomma
//    fistp word ptr [ebx + _sNachKomma]
//    fclex
// }
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//COComma4* __vectorcall COComma4::pi_10e8(void)
//{
// long lpi_VorKomma = 314159265; short spi_NachKomma = 3590;
// _asm{
//    fclex
//    mov ebx, this
//    fild lpi_VorKomma
//    fistp dword ptr [ebx]
//		fild spi_NachKomma
//    fistp word ptr [ebx + _sNachKomma]
//    fclex
// }
// Kopieren();
// return this;
//}
////---------------------------------------------------------------------------
//double __vectorcall COComma4::sin(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild dword ptr [ebx]
//		fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fsin
//
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//double __vectorcall COComma4::cos(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild dword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fcos
//
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//double __vectorcall COComma4::tan(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild dword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//		fidiv sFaktor
//
//		fldpi
//		fmulp ST(1), ST(0)
//		fild sHalbKreis
//		fdivp ST(1), ST(0)
//	  fptan
//
//		fxch
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//double __vectorcall COComma4::Quadratwurzel(void)
//{
// short sControlAlt;
// _asm{
//    fstcw sControlAlt
//    fclex
//    fldcw sControlSchnitt
//    mov ebx, this
//
//    fild dword ptr [ebx]
//    fimul sFaktor
//    fiadd word ptr [ebx + _sNachKomma]
//		fidiv sFaktor
//
//	  fsqrt
//
//    fist dword ptr [ebx]
//    fisub dword ptr [ebx]
//    fimul sFaktor
//    fist word ptr [ebx + _sNachKomma]
//    fild word ptr [ebx + _sNachKomma]
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
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  faddp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
//    jmp EndeRunden
//
//    Minus5:
//    ficom sMinusFunf
//    fstsw ax
//    sahf
//    ja EndeRunden
//    fild word ptr [ebx + _sNachKomma]
//    fld1
//	  fsubp ST(1), ST(0)
//    fistp word ptr [ebx + _sNachKomma]
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
//__m128d __vectorcall COComma4::M128D(void)
//{
//	__m128d test;
//	return test;
//}