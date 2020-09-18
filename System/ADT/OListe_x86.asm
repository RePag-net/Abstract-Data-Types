;/****************************************************************************
;  Oliste_x86.asm
;  For more information see https://github.com/RePag-net/Core
;****************************************************************************/
;
;/****************************************************************************
;  The MIT License(MIT)
;
;  Copyright(c) 2020 René Pagel
;
;  Permission is hereby granted, free of charge, to any person obtaining a copy
;  of this softwareand associated documentation files(the "Software"), to deal
;  in the Software without restriction, including without limitation the rights
;  to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
;  copies of the Software, and to permit persons to whom the Software is
;  furnished to do so, subject to the following conditions :
;
;  The above copyright noticeand this permission notice shall be included in all
;  copies or substantial portions of the Software.
;
;  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
;  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;  SOFTWARE.
;******************************************************************************/

.686P
.XMM
.MODEL FLAT
INCLUDE listing.inc
INCLUDE ..\..\Include\CompSys.inc
INCLUDE ..\..\Include\ADT.inc
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

EXTRN __imp__InitializeCriticalSectionAndSpinCount@8:PROC
EXTRN __imp__DeleteCriticalSection@4:PROC
EXTRN __imp__EnterCriticalSection@4:PROC
EXTRN __imp__LeaveCriticalSection@4:PROC
EXTRN	__imp__TryEnterCriticalSection@4:PROC

.DATA
ucBY_COLIST DB 44

CS_OList SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_bThreadSicher = 4
s_this = 0
?COListV@System@RePag@@YQPAVCOList@12@_N@Z	PROC ; COListV(bThreadSicher)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], cl

    movzx edx, ucBY_COLIST
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COList_pstErster[eax], xmm7
		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COList_bThread[eax], cl
		test cl, cl
		je short Ende

		push 0
		lea ecx, COList_csIterator[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COListV@System@RePag@@YQPAVCOList@12@_N@Z	ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_ulSpinCount = 8
s_bThreadSicher = 4
s_this = 0
?COListV@System@RePag@@YQPAVCOList@12@_NK@Z PROC ; COListeV(bThreadSicher, ulSpinCount)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], cl
		mov dword ptr s_ulSpinCount[esp], edx

    movzx edx, ucBY_COLIST
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COList_pstErster[eax], xmm7
		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COList_bThread[eax], cl
		test cl, cl
		je short Ende

		push dword ptr s_ulSpinCount[esp]
		lea ecx, COList_csIterator[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COListV@System@RePag@@YQPAVCOList@12@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_bThreadSicher = 8
s_vmSpeicher = 4
s_this = 0
?COListV@System@RePag@@YQPAVCOList@12@PBX_N@Z PROC ; COListV(vmSpeicher, bThreadSicher)
		sub esp, esp_Bytes

		mov dword ptr s_vmSpeicher[esp], ecx
		mov byte ptr s_bThreadSicher[esp], dl

    movzx edx, ucBY_COLIST
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		xor ecx, ecx
		mov dword ptr COList_pstErster[eax], ecx
		mov dword ptr COList_pstLetzer[eax], ecx
		mov dword ptr COList_ulAnzahl[eax], ecx

		mov ecx, dword ptr s_vmSpeicher[esp]
		mov dword ptr COList_vmSpeicher[eax], ecx

		movzx edx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COList_bThread[eax], dl
		test dl, dl
		je short Ende

		push 0
		lea ecx, COList_csIterator[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COListV@System@RePag@@YQPAVCOList@12@PBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_bThreadSicher = 8
s_vmSpeicher = 4
s_this = 0
a_ulSpinCount = esp_Bytes + 8
?COListV@System@RePag@@YQPAVCOList@12@PBX_NK@Z PROC ; COListeV(vmSpeicher, bThreadSicher, ulSpinCount)
		sub esp, esp_Bytes

		mov dword ptr s_vmSpeicher[esp], ecx
		mov byte ptr s_bThreadSicher[esp], dl

    movzx edx, ucBY_COLIST
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		xor ecx, ecx
		mov dword ptr COList_pstErster[eax], ecx
		mov dword ptr COList_pstLetzer[eax], ecx
		mov dword ptr COList_ulAnzahl[eax], ecx

		mov ecx, dword ptr s_vmSpeicher[esp]
		mov dword ptr COList_vmSpeicher[eax], ecx

		movzx edx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COList_bThread[eax], dl
		test dl, dl
		je short Ende

		push dword ptr a_ulSpinCount[esp]
		lea ecx, COList_csIterator[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 4
?COListV@System@RePag@@YQPAVCOList@12@PBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_bTheardSicher = 4
??0COList@System@RePag@@QAE@_N@Z PROC ; COList::COList(bThreadSicher)
		pxor xmm7, xmm7
		movdqu xmmword ptr COList_pstErster[ecx], xmm7
		movzx edx, byte ptr a_bTheardSicher[esp]
		mov byte ptr COList_bThread[ecx], dl
		test dl, dl
		je short Ende

		push eax
		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
    ret 4
??0COList@System@RePag@@QAE@_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_bThreadSicher = 4
a_ulSpinCount = 8
??0COList@System@RePag@@QAE@_NK@Z PROC ; COList::COList(bThreadSicher, ulSpinCount)
		pxor xmm7, xmm7
		movdqu xmmword ptr COList_pstErster[ecx], xmm7
		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COList_bThread[ecx], dl
		test dl, dl
		je short Ende

		push dword ptr a_ulSpinCount[esp]
		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
    ret 8
??0COList@System@RePag@@QAE@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_vmSpeicher = 4
a_bThreadSicher = 8
??0COList@System@RePag@@QAE@PBX_N@Z PROC ; COList::COList(vmSpeicher, bThreadSicher)
		xor eax, eax
		mov dword ptr COList_pstErster[ecx], eax
		mov dword ptr COList_pstLetzer[ecx], eax
		mov dword ptr COList_ulAnzahl[ecx], eax
		mov eax, dword ptr a_vmSpeicher[esp]
		mov dword ptr COList_vmSpeicher[ecx], eax
		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COList_bThread[ecx], dl
		test dl, dl
		je short Ende

		push 0
		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
    ret 8
??0COList@System@RePag@@QAE@PBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_vmSpeicher = 4
a_bThreadSicher = 8
a_ulSpinCount = 12
??0COList@System@RePag@@QAE@PBX_NK@Z PROC ; COList::COList(vmSpeicher, bThreadSicher, ulSpinCount)
		xor eax, eax
		mov dword ptr COList_pstErster[ecx], eax
		mov dword ptr COList_pstLetzer[ecx], eax
		mov dword ptr COList_ulAnzahl[ecx], eax
		mov eax, dword ptr a_vmSpeicher[esp]
		mov dword ptr COList_vmSpeicher[ecx], eax
		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COList_bThread[ecx], dl
		test dl, dl
		je short Ende

		push dword ptr a_ulSpinCount[esp]
		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
    ret 12
??0COList@System@RePag@@QAE@PBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??1COList@System@RePag@@QAE@XZ PROC ; COList::~COList(void)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov ebx, dword ptr COList_pstErster[ebp]
		mov edi, dword ptr COList_vmSpeicher[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Kopf_Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang

	Kopf_Ende:
		movzx eax, byte ptr COList_bThread[ebp]
		test eax, eax
		je short Ende
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__DeleteCriticalSection@4 ; DeleteCrticalSection(&csIterator)
		
	Ende:
		pop edi
		pop ebx
		pop ebp
		ret 0
??1COList@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
?COFreiV@COList@System@RePag@@QAQPBXXZ PROC ; COList::COFreiV(void)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov edi, dword ptr COList_vmSpeicher[ebp]
		mov ebx, dword ptr COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Kopf_Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang

	Kopf_Ende:
		movzx eax, byte ptr COList_bThread[ebp]
		test eax, eax
		je short Ende
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__DeleteCriticalSection@4 ; DeleteCrticalSection(&csIterator)
		
	Ende:
		mov eax, edi
		pop edi
		pop ebx
		pop ebp
		ret 0
?COFreiV@COList@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
?DeleteList@COList@System@RePag@@QAQX_N@Z PROC ; COList::DeleteList(bDatenLoschen)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov edi, dword ptr COList_vmSpeicher[ebp]
		
	Kopf_Init:
		mov ebx, dword ptr COList_pstErster[ebp]
		test edx, edx
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]
		push edx

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		pop edx
		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		xor eax, eax
		mov dword ptr COList_ulAnzahl[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax
		mov dword ptr COList_pstErster[ebp], eax
		pop edi
		pop ebx
		pop ebp
		ret 0
?DeleteList@COList@System@RePag@@QAQX_N@Z ENDP
;----------------------------------------------------------------------------
?DeleteListS@COList@System@RePag@@QAQX_N@Z PROC	; COList::DeleteListS(bDatenLoschen)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov edi, dword ptr COList_vmSpeicher[ebp]
		
	Kopf_Init:
		mov ebx, dword ptr COList_pstErster[ebp]
		test edx, edx
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]
		push edx

	  mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		pop edx
		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		xor eax, eax
		mov dword ptr COList_ulAnzahl[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax
		mov dword ptr COList_pstErster[ebp], eax
		pop edi
		pop ebx
		pop ebp
		ret 0
?DeleteListS@COList@System@RePag@@QAQX_N@Z ENDP
;----------------------------------------------------------------------------
?ThDeleteList@COList@System@RePag@@QAQX_N@Z PROC ; COList::ThDeleteList(bDatenLoschen)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov edi, dword ptr COList_vmSpeicher[ebp]

		push edx ; bDatenLoschen
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)
		pop edx ; bDatenLoschen
		
	Kopf_Init:
		mov ebx, dword ptr COList_pstErster[ebp]
		test edx, edx
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]
		push edx

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		pop edx
		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		xor eax, eax
		mov dword ptr COList_ulAnzahl[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax
		mov dword ptr COList_pstErster[ebp], eax
		pop edi
		pop ebx
		pop ebp
		ret 0
?ThDeleteList@COList@System@RePag@@QAQX_N@Z ENDP
;----------------------------------------------------------------------------
?ThDeleteListS@COList@System@RePag@@QAQX_N@Z PROC ; COList::ThDeleteListS(bDatenLoschen)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov edi, dword ptr COList_vmSpeicher[ebp]

		push edx ; bDatenLoschen
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)
		pop edx ; bDatenLoschen
		
	Kopf_Init:
		mov ebx, dword ptr COList_pstErster[ebp]
		test edx, edx
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]
		push edx

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		pop edx
		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, ebx
		mov ebx, dword ptr [ebx]

		mov ecx, edi
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		xor eax, eax
		mov dword ptr COList_ulAnzahl[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax
		mov dword ptr COList_pstErster[ebp], eax
		pop edi
		pop ebx
		pop ebp
		ret 0
?ThDeleteListS@COList@System@RePag@@QAQX_N@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pvDaten = 4
s_this = 0
?ToBegin@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ToBegin(pvDaten)
		sub esp, esp_Bytes
		;push ebp

		;mov ebp, ecx
		;push edx ; pvDaten
		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ecx]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		;pop edx ; pvDaten
		mov edx, dword ptr s_pvDaten[esp]
		mov dword ptr COList_pvDaten[eax], edx
	
		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COList_pstErster[ecx]
		mov dword ptr [eax], edx
		test edx, edx
		jne Erster_Neu
		mov dword ptr COList_pstLetzer[ecx], eax

	Erster_Neu:
		mov dword ptr COList_pstErster[ecx], eax
		add dword ptr COList_ulAnzahl[ecx], 1

		;pop ebp
		add esp, esp_Bytes
		ret 0
?ToBegin@COList@System@RePag@@QAQPAXPAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pvDaten = 4
s_this = 0
?ToBeginS@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ToBeginS(pvDaten)
		sub esp, esp_Bytes
		;push ebp

		;mov ebp, ecx
		;push edx ; pvDaten
		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ecx]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		;pop edx ; pvDaten
		mov edx, dword ptr s_pvDaten[esp]
		mov dword ptr COList_pvDaten[eax], edx
	
		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COList_pstErster[ecx]
		mov dword ptr [eax], edx
		test edx, edx
		jne Erster_Neu
		mov dword ptr COList_pstLetzer[ecx], eax

	Erster_Neu:
		mov dword ptr COList_pstErster[ecx], eax
		add dword ptr COList_ulAnzahl[ecx], 1

		;pop ebp
		add esp, esp_Bytes
		ret 0
?ToBeginS@COList@System@RePag@@QAQPAXPAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 4
s_Temp_Daten = 0
?ThToBegin@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ThToBegin(pvDaten)
		push ebp
		sub esp, esp_Bytes
		;push ebx

		mov ebp, ecx
		;push edx ; pvDaten
		mov dword ptr s_Temp_Daten[esp], edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		;mov ebx, eax

		;pop edx ; pvDaten
		mov edx, dword ptr s_Temp_Daten[esp] ; pvDaten
		mov dword ptr COList_pvDaten[eax], edx

		mov dword ptr s_Temp_Daten[esp], eax ; vbBlock

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		mov eax, dword ptr s_Temp_Daten[esp] ; vbBlock

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr [eax], ecx
		test ecx, ecx
		jne Erster_Neu
		mov dword ptr COList_pstLetzer[ebp], eax

	Erster_Neu:
		mov dword ptr COList_pstErster[ebp], eax
		add dword ptr COList_ulAnzahl[ebp], 1

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		;pop ebx
		add esp, esp_Bytes
		pop ebp
		ret 0
?ThToBegin@COList@System@RePag@@QAQPAXPAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?ThToBeginS@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ThToBeginS(pvDaten)
		push ebp
		push ebx

		mov ebp, ecx
		push edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)
		mov ebx, eax

		pop edx ; pvDaten
		mov dword ptr COList_pvDaten[ebx], edx

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr [ebx], ecx
		test ecx, ecx
		jne Erster_Neu
		mov dword ptr COList_pstLetzer[ebp], ebx

	Erster_Neu:
		mov dword ptr COList_pstErster[ebp], ebx
		add dword ptr COList_ulAnzahl[ebp], 1

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		pop ebx
		pop ebp
		ret 0
?ThToBeginS@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?ToEnd@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ToEnd(pvDaten)
		push ebp

		mov ebp, ecx
		push edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; pvDaten
		mov dword ptr COList_pvDaten[eax], edx

		xor edx, edx
		mov dword ptr [eax], edx
		mov ecx, COList_pstLetzer[ebp]
		test ecx, ecx
		jne Nachster_Neu
		mov dword ptr COList_pstErster[ebp], eax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov dword ptr [ecx], eax

	Letzter_Neu:
		mov COList_pstLetzer[ebp], eax
		add dword ptr COList_ulAnzahl[ebp], 1

		pop ebp
		ret 0
?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?ToEndS@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ToEndS(pvDaten)
		push ebp

		mov ebp, ecx
		push edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; pvDaten
		mov dword ptr COList_pvDaten[eax], edx

		xor edx, edx
		mov dword ptr [eax], edx
		mov ecx, COList_pstLetzer[ebp]
		test ecx, ecx
		jne Nachster_Neu
		mov dword ptr COList_pstErster[ebp], eax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov dword ptr [ecx], eax

	Letzter_Neu:
		mov COList_pstLetzer[ebp], eax
		add dword ptr COList_ulAnzahl[ebp], 1

		pop ebp
		ret 0
?ToEndS@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?ThToEnd@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ThToEnd(pvDaten)
		sub esp, esp_Bytes
		push ebp
		push ebx

		mov ebp, ecx
		push edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ebx, eax

		pop edx ; pvDaten
		mov dword ptr COList_pvDaten[eax], edx

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		xor eax, eax
		mov dword ptr [ebx], eax
		mov ecx, COList_pstLetzer[ebp]
		test ecx, ecx
		jne Nachster_Neu
		mov dword ptr COList_pstErster[ebp], ebx
		jmp short Letzter_Neu

	Nachster_Neu:
		mov dword ptr [ecx], ebx

	Letzter_Neu:
		mov COList_pstLetzer[ebp], ebx
		add dword ptr COList_ulAnzahl[ebp], 1

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		pop ebx
		pop ebp
		add esp, esp_Bytes
		ret 0
?ThToEnd@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?ThToEndS@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::ThToEndS(pvDaten)
		push ebp
		push ebx

		mov ebp, ecx
		push edx ; pvDaten

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ebx, eax

		pop edx ; pvDaten
		mov dword ptr COList_pvDaten[eax], edx

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		xor eax, eax
		mov dword ptr [ebx], eax
		mov ecx, COList_pstLetzer[ebp]
		test ecx, ecx
		jne Nachster_Neu
		mov dword ptr COList_pstErster[ebp], ebx
		jmp short Letzter_Neu

	Nachster_Neu:
		mov dword ptr [ecx], ebx

	Letzter_Neu:
		mov COList_pstLetzer[ebp], ebx
		add dword ptr COList_ulAnzahl[ebp], 1

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		pop ebx
		pop ebp
		ret 0
?ThToEndS@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?Element@COList@System@RePag@@QAQPAXK@Z PROC ; COList::Element(ulIndex)
		xor eax, eax
		cmp edx, dword ptr COList_ulAnzahl[ecx]
		jae short Ende
		
		test edx, edx
		jne short Index_Anzahl
		mov eax, dword ptr COList_pstErster[ecx]
		mov eax, dword ptr COList_pvDaten[eax]
		jmp short Ende

	Index_Anzahl:
		mov eax, dword ptr COList_ulAnzahl[ecx]
		sub eax, 1
		cmp edx, eax
		jne short For_Init
		mov eax, dword ptr COList_pstLetzer[ecx]
		mov eax, dword ptr COList_pvDaten[eax]
		jmp short Ende

	For_Init:
		mov eax, dword ptr COList_pstErster[ecx]
		xor ecx, ecx
		
	For_Anfang:
		add ecx, 1
		cmp ecx, edx
		ja short For_Ende
		mov eax, dword ptr [eax]
		jmp short For_Anfang

	For_Ende:
		mov eax, dword ptr COList_pvDaten[eax]

	Ende:
		ret 0
?Element@COList@System@RePag@@QAQPAXK@Z ENDP
;----------------------------------------------------------------------------
?ThElement@COList@System@RePag@@QAQPAXK@Z PROC ; COList::ThElement(ulIndex)
		push ebp

		mov ebp, ecx
		push edx ; ulIndex

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		pop edx ; ulIndex

		xor eax, eax
		cmp edx, dword ptr COList_ulAnzahl[ebp]
		jae short Ende
		
		test edx, edx
		jne short Index_Anzahl
		mov eax, dword ptr COList_pstErster[ebp]
		mov eax, dword ptr COList_pvDaten[eax]
		jmp short Ende

	Index_Anzahl:
		mov eax, dword ptr COList_ulAnzahl[ebp]
		sub eax, 1
		cmp edx, eax
		jne short For_Init
		mov eax, dword ptr COList_pstLetzer[ebp]
		mov eax, dword ptr COList_pvDaten[eax]
		jmp short Ende

	For_Init:
		mov eax, dword ptr COList_pstErster[ebp]
		xor ecx, ecx
		
	For_Anfang:
		add ecx, 1
		cmp ecx, edx
		ja short For_Ende
		mov eax, dword ptr [eax]
		jmp short For_Anfang

	For_Ende:
		mov eax, dword ptr COList_pvDaten[eax]

	Ende:
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)
		pop ebp
		ret 0
?ThElement@COList@System@RePag@@QAQPAXK@Z ENDP
;----------------------------------------------------------------------------
?Element@COList@System@RePag@@QAQPAXPAX@Z PROC ; COList::Element(pstKnoten)
		mov eax, dword ptr COList_pvDaten[edx]
		ret 0
?Element@COList@System@RePag@@QAQPAXPAX@Z ENDP
;----------------------------------------------------------------------------
?NextElement@COList@System@RePag@@QAQXAAPAX@Z PROC ; COList::NextElement(*&pstKnoten)
		mov eax, dword ptr [edx]
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax
		ret 0
?NextElement@COList@System@RePag@@QAQXAAPAX@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_KnotenVoreheriger = 4
?NextElement@COList@System@RePag@@QAQXAAPAX0@Z PROC ; COList::NextElement(*&pstKnotenAktuell, *&pstKnotenVorheriger)
		mov eax, dword ptr [edx]
		test eax, eax
		je short Ende

		cmp eax, dword ptr COList_pstErster[ecx]
		jne short Vorheriger_Aktuell_1
		mov eax, dword ptr a_KnotenVoreheriger[esp]
		mov eax, dword ptr [eax]
		cmp eax, dword ptr COList_pstErster[ecx]
		jne short Vorheriger_Aktuell_2
		xor eax, eax
		mov dword ptr a_KnotenVoreheriger[esp], eax
		jmp short Ende

	Vorheriger_Aktuell_2:
		mov eax, dword ptr [edx]

	Vorheriger_Aktuell_1:
		mov ecx, dword ptr a_KnotenVoreheriger[esp]
		mov dword ptr [ecx], eax
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax

	Ende:
		ret 4
?NextElement@COList@System@RePag@@QAQXAAPAX0@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstKnoten_2 = 4
s_pstKnoten_1 = 0
a_pstLoschen = esp_Bytes + 8
a_bDatenLoschen = esp_Bytes + 12
?DeleteElement@COList@System@RePag@@QAQXAAPAX0_N@Z PROC ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)
		push ebp
		sub esp, esp_BYtes

		mov ebp, ecx

		mov eax, dword ptr a_pstLoschen[esp]
		mov eax, dword ptr [eax]
		test eax, eax
		;cmp dword ptr [eax], 0
		jne Loschen

		mov eax, dword ptr COList_pstErster[ebp]
		mov eax, dword ptr [eax]
		test eax, eax
		jne short Nachster

		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten
		;push edx ; pstKnoten

		mov edx, dword ptr a_bDatenLoschen[esp]
		test edx, edx
		;cmp dword ptr a_bDatenLoschen[esp], 0
		je short AllesNull

		mov edx, dword ptr COList_pstErster[ebp]
	  mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	AllesNull:
		mov edx, dword ptr COList_pstErster[ebp]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten

		xor ecx, ecx
		mov dword ptr COList_pstErster[ebp], ecx
		mov dword ptr COList_pstLetzer[ebp], ecx
		mov edx, dword ptr [edx]
		mov dword ptr [edx], ecx
		mov eax, dword ptr a_pstLoschen[esp]
		mov dword ptr [eax], ecx
		jmp Ende

	Nachster:
		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr COList_pstErster[ebp], eax

		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten

		mov edx, dword ptr a_bDatenLoschen[esp]
		test edx, edx
		;cmp dword ptr a_bDatenLoschen[esp], 0
		je short Knoten_Erster

		;push ecx ; COList_pstErster_Alt
		mov dword ptr s_pstKnoten_2[esp], ecx ; COList_pstErster_Alt

		mov edx, dword ptr COList_pvDaten[ecx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop ecx ; COList_pstErster_Alt
		mov ecx, dword ptr s_pstKnoten_2[esp] ; COList_pstErster_Alt

	Knoten_Erster:
		mov edx, ecx
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr [edx], ecx
		mov eax, dword ptr a_pstLoschen[esp]
		xor ecx, ecx
		mov dword ptr [eax], ecx
		jmp short Ende

	Loschen:
		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten

		;mov eax, dword ptr [eax] ; pstLoschen
		mov edx, dword ptr [eax] ; pstLoschen->pstNachster
		mov ecx, dword ptr [edx] ; pstLoschen->pstNachster->pstNachster
		mov dword ptr [eax], ecx

		mov ecx, dword ptr [eax]
		test ecx, ecx
		;cmp dword ptr [eax], 0
		jne short Daten_Loschen
		mov dword ptr COList_pstLetzer[ebp], eax

	Daten_Loschen:
		mov ecx, dword ptr a_bDatenLoschen[esp]
		test ecx, ecx
		;cmp dword ptr a_bDatenLoschen[esp], 0
		je short Knoten_Loschen

		;push edx ; pstLoschen->pstNachster
		mov dword ptr s_pstKnoten_2[esp], edx

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop edx ; pstLoschen->pstNachster
		mov edx, dword ptr s_pstKnoten_2[esp]
		
	Knoten_Loschen:
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp]

		mov ecx, dword ptr a_pstLoschen[esp]
		mov ecx, dword ptr [ecx]
		mov dword ptr [edx], ecx

	Ende:
		sub dword ptr COList_ulAnzahl[ebp], 1
		add esp, esp_Bytes
		pop ebp
		ret 8
?DeleteElement@COList@System@RePag@@QAQXAAPAX0_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstKnoten_2 = 4
s_pstKnoten_1 = 0
a_pstLoschen = esp_Bytes + 8
a_bDatenLoschen = esp_Bytes + 12
?DeleteElementS@COList@System@RePag@@QAQXAAPAX0_N@Z PROC ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)
		push ebp
		sub esp, esp_BYtes

		mov ebp, ecx

		mov eax, dword ptr a_pstLoschen[esp]
		cmp dword ptr [eax], 0
		jne Loschen

		mov eax, dword ptr COList_pstErster[ebp]
		mov eax, dword ptr [eax]
		test eax, eax
		jne short Nachster

		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten
		;push edx ; pstKnoten

		mov edx, dword ptr a_bDatenLoschen[esp]
		cmp dword ptr a_bDatenLoschen[esp], 0
		je short AllesNull

		mov edx, dword ptr COList_pstErster[ebp]
	  mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

	AllesNull:
		mov edx, dword ptr COList_pstErster[ebp]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten

		mov dword ptr COList_pstErster[ebp], 0
		mov dword ptr COList_pstLetzer[ebp], 0
		mov edx, dword ptr [edx]
		mov dword ptr [edx], 0
		mov eax, dword ptr a_pstLoschen[esp]
		mov dword ptr [eax], 0
		jmp Ende

	Nachster:
		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr COList_pstErster[ebp], eax

		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten

		cmp dword ptr a_bDatenLoschen[esp], 0
		je short Knoten_Erster

		;push ecx ; COList_pstErster_Alt
		mov dword ptr s_pstKnoten_2[esp], ecx ; COList_pstErster_Alt

		mov edx, dword ptr COList_pvDaten[ecx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop ecx ; COList_pstErster_Alt
		mov ecx, dword ptr s_pstKnoten_2[esp] ; COList_pstErster_Alt

	Knoten_Erster:
		mov edx, ecx
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr [edx], ecx
		mov eax, dword ptr a_pstLoschen[esp]
		mov dword ptr [eax], 0
		jmp short Ende

	Loschen:
		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx

		mov eax, dword ptr [eax] ; pstLoschen
		mov edx, dword ptr [eax] ; pstLoschen->pstNachster
		mov ecx, dword ptr [edx] ; pstLoschen->pstNachster->pstNachster
		mov dword ptr [eax], ecx

		cmp dword ptr [eax], 0
		jne short Daten_Loschen
		mov dword ptr COList_pstLetzer[ebp], eax

	Daten_Loschen:
		cmp dword ptr a_bDatenLoschen[esp], 0
		je short Knoten_Loschen

		;push edx ; pstLoschen->pstNachster
		mov dword ptr s_pstKnoten_2[esp], edx

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop edx ; pstLoschen->pstNachster
		mov edx, dword ptr s_pstKnoten_2[esp]
		
	Knoten_Loschen:
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp]

		mov ecx, dword ptr a_pstLoschen[esp]
		mov ecx, dword ptr [ecx]
		mov dword ptr [edx], ecx

	Ende:
		sub dword ptr COList_ulAnzahl[ebp], 1
		add esp, esp_Bytes
		pop ebp
		ret 8
?DeleteElementS@COList@System@RePag@@QAQXAAPAX0_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstKnoten_2 = 4
s_pstKnoten_1 = 0
a_bDatenLoschen = esp_Bytes + 8
?DeleteFirstElement@COList@System@RePag@@QAQXAAPAX_N@Z PROC ; COList::DeleteFirstElement(*&pstKnoten, bDatenLoschen)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten

		mov edx, dword ptr COList_pstErster[ebp]
		mov eax, dword ptr [edx]
		test eax, eax
		jne short Nachstes
		
		xor eax, eax
		cmp dword ptr a_bDatenLoschen[esp], eax
		je short Losch_Null

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Losch_Null:
		mov edx, dword ptr COList_pstErster[ebp]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		xor eax, eax
		mov dword ptr COList_pstErster[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten
		mov dword ptr [edx], eax
		jmp short Ende

	Nachstes:
		mov dword ptr COList_pstErster[ebp], eax

		xor eax, eax
		cmp dword ptr a_bDatenLoschen[esp], eax
		je short Knoten_Erster

		;push edx ; pstErster
		mov dword ptr s_pstKnoten_2[esp], edx ; pstErster

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		;pop edx ; pstErster
		mov edx, dword ptr s_pstKnoten_2[esp] ; pstErster

	Knoten_Erster:
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		
		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten
		mov eax, dword ptr COList_pstErster[ebp]
		mov dword ptr [edx], eax

	Ende:
		sub dword ptr COList_ulAnzahl[ebp], 1
		add esp, esp_Bytes
		pop ebp
		ret 4
?DeleteFirstElement@COList@System@RePag@@QAQXAAPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstKnoten_2 = 4
s_pstKnoten_1 = 0
a_bDatenLoschen = esp_Bytes + 8
?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z PROC ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		;push edx ; pstKnoten
		mov dword ptr s_pstKnoten_1[esp], edx ; pstKnoten
		mov eax, dword ptr COList_vmSpeicher[ebp]

		mov edx, dword ptr COList_pstErster[ebp]
		mov eax, dword ptr [edx]
		test eax, eax
		jne short Nachstes
		
		xor eax, eax
		cmp dword ptr a_bDatenLoschen[esp], eax
		je short Losch_Null

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

	Losch_Null:
		mov edx, dword ptr COList_pstErster[ebp]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		xor eax, eax
		mov dword ptr COList_pstErster[ebp], eax
		mov dword ptr COList_pstLetzer[ebp], eax

		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten
		mov dword ptr [edx], eax
		jmp short Ende

	Nachstes:
		mov dword ptr COList_pstErster[ebp], eax

		xor eax, eax
		cmp dword ptr a_bDatenLoschen[esp], eax
		je short Knoten_Erster

		;push edx ; pstErster
		mov dword ptr s_pstKnoten_2[esp], edx ; pstErster

		mov edx, dword ptr COList_pvDaten[edx]
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		;pop edx ; pstErster
		mov edx, dword ptr s_pstKnoten_2[esp] ; pstErster

	Knoten_Erster:
		mov ecx, dword ptr COList_vmSpeicher[ebp]
		call ?VMFreiS@System@RePag@@YQXPBXPAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		
		;pop edx ; pstKnoten
		mov edx, dword ptr s_pstKnoten_1[esp] ; pstKnoten
		mov eax, dword ptr COList_pstErster[ebp]
		mov dword ptr [edx], eax

	Ende:
		sub dword ptr COList_ulAnzahl[ebp], 1
		add esp, esp_Bytes
		pop ebp
		ret 4
?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstLoschen = 4
s_pstKnoten = 0
a_bDatenLoschen = esp_Bytes + 20
?DeleteElement@COList@System@RePag@@QAQXK_N@Z PROC ; COList::DeleteElement(ulIndex, bDatenLoschen)
		push ebp
		push ebx
		push edi
		push esi
		sub esp, esp_Bytes

		mov ebp, ecx
		mov edi, edx

		cmp edx, dword ptr COList_ulAnzahl[ebp]
		jae short Ende

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr s_pstKnoten[esp], ecx
		lea edx, dword ptr s_pstKnoten[esp]
		xor eax, eax
		mov dword ptr s_pstLoschen[esp], eax
		lea esi, dword ptr s_pstLoschen[esp]
		mov ebx, 1
		mov eax, dword ptr [edx]

	For_Anfang:
		cmp ebx, edi
		ja short Loschen
		add ebx, 1

		mov dword ptr [esi], eax
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax
		jmp short For_Anfang

	Loschen:
	mov eax, dword ptr a_bDatenLoschen[esp]
		push dword ptr a_bDatenLoschen[esp]
		push esi
		mov ecx, ebp
		call ?DeleteElement@COList@System@RePag@@QAQXAAPAX0_N@Z ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		add esp, esp_Bytes
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 4
?DeleteElement@COList@System@RePag@@QAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstLoschen = 4
s_pstKnoten = 0
a_bDatenLoschen = esp_Bytes + 20
?DeleteElementS@COList@System@RePag@@QAQXK_N@Z PROC ; COList::DeleteElementS(ulIndex, bDatenLoschen)
		push ebp
		push ebx
		push edi
		push esi
		sub esp, esp_Bytes

		mov ebp, ecx
		mov edi, edx

		cmp edx, dword ptr COList_ulAnzahl[ebp]
		jae short Ende

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr s_pstKnoten[esp], ecx
		lea edx, dword ptr s_pstKnoten[esp]
		xor eax, eax
		mov dword ptr s_pstLoschen[esp], eax
		lea esi, dword ptr s_pstLoschen[esp]
		mov ebx, 1
		mov eax, dword ptr [edx]

	For_Anfang:
		cmp ebx, edi
		ja short Loschen
		add ebx, 1

		mov dword ptr [esi], eax
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax
		jmp short For_Anfang

	Loschen:
		push dword ptr a_bDatenLoschen[esp]
		push esi
		mov ecx, ebp
		call ?DeleteElementS@COList@System@RePag@@QAQXAAPAX0_N@Z ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		add esp, esp_Bytes
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 4
?DeleteElementS@COList@System@RePag@@QAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstLoschen = 4
s_pstKnoten = 0
a_bDatenLoschen = esp_Bytes + 20
?ThDeleteElement@COList@System@RePag@@QAQXK_N@Z PROC ; COList::ThDeleteElement(ulIndex, bDatenLoschen)
		push ebp
		push ebx
		push edi
		push esi
		sub esp, esp_Bytes

		mov ebp, ecx
		mov edi, edx

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		cmp edx, dword ptr COList_ulAnzahl[ebp]
		jae short Ende

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr s_pstKnoten[esp], ecx
		lea edx, dword ptr s_pstKnoten[esp]
		xor eax, eax
		mov dword ptr s_pstLoschen[esp], eax
		lea esi, dword ptr s_pstLoschen[esp]
		mov ebx, 1
		mov eax, dword ptr [edx]

	For_Anfang:
		cmp ebx, edi
		ja short Loschen
		add ebx, 1

		mov dword ptr [esi], eax
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax
		jmp short For_Anfang

	Loschen:
		push dword ptr a_bDatenLoschen[esp]
		push esi
		mov ecx, ebp
		call ?DeleteElement@COList@System@RePag@@QAQXAAPAX0_N@Z ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		add esp, esp_Bytes
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 4
?ThDeleteElement@COList@System@RePag@@QAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pstLoschen = 4
s_pstKnoten = 0
a_bDatenLoschen = esp_Bytes + 20
?ThDeleteElementS@COList@System@RePag@@QAQXK_N@Z PROC ; COList::ThDeleteElementS(ulIndex, bDatenLoschen)
		push ebp
		push ebx
		push edi
		push esi
		sub esp, esp_Bytes

		mov ebp, ecx
		mov edi, edx

		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		cmp edx, dword ptr COList_ulAnzahl[ebp]
		jae short Ende

		mov ecx, dword ptr COList_pstErster[ebp]
		mov dword ptr s_pstKnoten[esp], ecx
		lea edx, dword ptr s_pstKnoten[esp]
		xor eax, eax
		mov dword ptr s_pstLoschen[esp], eax
		lea esi, dword ptr s_pstLoschen[esp]
		mov ebx, 1
		mov eax, dword ptr [edx]

	For_Anfang:
		cmp ebx, edi
		ja short Loschen
		add ebx, 1

		mov dword ptr [esi], eax
		mov eax, dword ptr [eax]
		mov dword ptr [edx], eax
		jmp short For_Anfang

	Loschen:
		push dword ptr a_bDatenLoschen[esp]
		push esi
		mov ecx, ebp
		call ?DeleteElementS@COList@System@RePag@@QAQXAAPAX0_N@Z ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		lea edx, COList_csIterator[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		add esp, esp_Bytes
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 4
?ThDeleteElementS@COList@System@RePag@@QAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_pstVorheriger = 8
a_pvDaten = 12
?Insert@COList@System@RePag@@QAQPAXAAPAX0PAX@Z PROC ; COList::Insert(*&pstKnotenAktuell, *&pstKnotenVorheriger, pvDaten)
		push ebp

		mov ebp, ecx
		push edx ; pstKnotenAktuell

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr a_pvDaten[esp+4]
		mov dword ptr COList_pvDaten[eax], ecx

		pop edx ; pstKnotenAktuell
		mov edx, dword ptr [edx]

		mov dword ptr [eax], edx

		mov ecx, dword ptr a_pstVorheriger[esp]
		mov ecx, dword ptr [ecx]
		test ecx, ecx
		jne short Vorheriger_Nachster
		mov dword ptr COList_pstErster[ebp], eax
		jmp short Knoten_Aktuell

	Vorheriger_Nachster:
		mov dword ptr [ecx], eax

	Knoten_Aktuell:
		test edx, edx
		jne short Ende
		mov dword ptr COList_pstLetzer[ebp], eax

	Ende:
		add dword ptr COList_ulAnzahl[ebp], 1
		pop ebp
		ret 8
?Insert@COList@System@RePag@@QAQPAXAAPAX0PAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_pstVorheriger = 8
a_pvDaten = 12
?InsertS@COList@System@RePag@@QAQPAXAAPAX0PAX@Z PROC ; COList::InsertS(*&pstKnotenAktuell, *&pstKnotenVorheriger, pvDaten)
		push ebp

		mov ebp, ecx
		push edx ; pstKnotenAktuell

		mov edx, 8
    mov ecx, dword ptr COList_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr a_pvDaten[esp+4]
		mov dword ptr COList_pvDaten[eax], ecx

		pop edx ; pstKnotenAktuell
		mov edx, dword ptr [edx]

		mov dword ptr [eax], edx

		mov ecx, dword ptr a_pstVorheriger[esp]
		mov ecx, dword ptr [ecx]
		test ecx, ecx
		jne short Vorheriger_Nachster
		mov dword ptr COList_pstErster[ebp], eax
		jmp short Knoten_Aktuell

	Vorheriger_Nachster:
		mov dword ptr [ecx], eax

	Knoten_Aktuell:
		test edx, edx
		jne short Ende
		mov dword ptr COList_pstLetzer[ebp], eax

	Ende:
		add dword ptr COList_ulAnzahl[ebp], 1
		pop ebp
		ret 8
?InsertS@COList@System@RePag@@QAQPAXAAPAX0PAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Number@COList@System@RePag@@QAQKXZ PROC ; COList::Number(void)
		mov eax, dword ptr COList_ulAnzahl[ecx]
		ret 0
?Number@COList@System@RePag@@QAQKXZ ENDP
;----------------------------------------------------------------------------
?ThNumber@COList@System@RePag@@QAQAAKAAK@Z PROC ; COList::ThNumber(&ulAnzahl)
		push ebx

		push ecx
		mov ebx, edx

		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		pop ecx
		mov eax, dword ptr COList_ulAnzahl[ecx]
		mov dword ptr [ebx], eax

		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)

		mov eax, ebx
		pop ebx
		ret 0
?ThNumber@COList@System@RePag@@QAQAAKAAK@Z ENDP
;----------------------------------------------------------------------------
?IteratorToBegin@COList@System@RePag@@QAQPAXXZ PROC ; COList::IteratorToBegin(void)
		mov eax, dword ptr COList_pstErster[ecx]
		ret 0
?IteratorToBegin@COList@System@RePag@@QAQPAXXZ ENDP
;----------------------------------------------------------------------------
?ThIteratorToBegin@COList@System@RePag@@QAQPAXXZ PROC ; COList::ThIteratorToBegin(void)
		push ecx

		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csIterator)

		pop ecx
		mov eax, dword ptr COList_pstErster[ecx]

		ret 0
?ThIteratorToBegin@COList@System@RePag@@QAQPAXXZ ENDP
;----------------------------------------------------------------------------
?ThIteratorToBegin_Lock@COList@System@RePag@@QAQPAXXZ PROC ; COList::ThIteratorToBegin_Lock(void)
		push ecx

		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csIterator)

		pop ecx
		mov eax, dword ptr COList_pstErster[ecx]

		ret 0
?ThIteratorToBegin_Lock@COList@System@RePag@@QAQPAXXZ ENDP
;----------------------------------------------------------------------------
?ThIteratorEnd@COList@System@RePag@@QAQXXZ PROC ; COList::ThIteratorEnd(void)
		lea edx, COList_csIterator[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csIterator)
		ret 0
?ThIteratorEnd@COList@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
CS_OList ENDS
END