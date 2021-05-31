;****************************************************************************
;  OListe_x64.asm
;  For more information see https://github.com/RePag-net/Core
;****************************************************************************
;
;****************************************************************************
;  The MIT License(MIT)
;
;  Copyright(c) 2021 René Pagel
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
;******************************************************************************

INCLUDE listing.inc

INCLUDE ..\..\Include\CompSys_x64.inc
INCLUDE ..\..\Include\ADT_x64.inc
INCLUDELIB OLDNAMES

EXTRN	__imp_LeaveCriticalSection:PROC
EXTRN	__imp_TryEnterCriticalSection:PROC
EXTRN	__imp_EnterCriticalSection:PROC
EXTRN	__imp_DeleteCriticalSection:PROC
EXTRN	__imp_InitializeCriticalSectionAndSpinCount:PROC

.DATA
dbi_BY_COLIST DB 72

CS_OListe SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ThreadSicher = 48
sqp_this = 40
?COListV@System@RePag@@YQPEAVCOList@12@_N@Z PROC ; COListV(bThreadSicher)
		sub rsp, s_ShadowRegister

		mov byte ptr sbi_ThreadSicher[rsp], cl

		movzx rdx, dbi_BY_COLIST
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rax], ymm0
		vmovdqu ymmword ptr [rax + 32], ymm0
		vmovdqu xmmword ptr [rax + 56], xmm0
		movzx rcx, byte ptr sbi_ThreadSicher[rsp]
		mov byte ptr COList_bThread[rax], cl
		test cl, cl
		je short Ende

		xor rdx, rdx
		lea rcx, COList_csIterator[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COListV@System@RePag@@YQPEAVCOList@12@_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ThreadSicher = 56
sdi_SpinCount = 48
sqp_this = 40
?COListV@System@RePag@@YQPEAVCOList@12@_NK@Z PROC ; COListeV(bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister

		mov byte ptr sbi_ThreadSicher[rsp], cl
		mov dword ptr sdi_SpinCount[rsp], edx

		movzx rdx, dbi_BY_COLIST
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rax], ymm0
		vmovdqu ymmword ptr [rax + 32], ymm0
		vmovdqu xmmword ptr [rax + 56], xmm0
		movzx rcx, byte ptr sbi_ThreadSicher[rsp]
		mov byte ptr COList_bThread[rax], cl
		test cl, cl
		je short Ende

		mov edx, dword ptr sdi_SpinCount[rsp]
		lea rcx, COList_csIterator[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COListV@System@RePag@@YQPEAVCOList@12@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ThreadSicher = 56
sqi_Speicher = 48
sqp_this = 40
?COListV@System@RePag@@YQPEAVCOList@12@PEBX_N@Z PROC ; COListV(vmSpeicher, bThreadSicher)
		sub rsp, s_ShadowRegister

		mov qword ptr sqi_Speicher[rsp], rcx
		mov byte ptr sbi_ThreadSicher[rsp], dl

		movzx rdx, dbi_BY_COLIST
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rax], ymm0
		vmovdqu ymmword ptr [rax + 32], ymm0

		mov rcx, qword ptr sqi_Speicher[rsp]
		mov qword ptr COList_vmSpeicher[rax], rcx

		movzx rdx, byte ptr sbi_ThreadSicher[rsp]
		mov byte ptr COList_bThread[rax], dl
		test dl, dl
		je short Ende

		xor rdx, rdx 
		lea rcx, COList_csIterator[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COListV@System@RePag@@YQPEAVCOList@12@PEBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ThreadSicher = 64
sdi_SpinCount = 56
sqi_Speicher = 48
sqp_this = 40
?COListV@System@RePag@@YQPEAVCOList@12@PEBX_NK@Z PROC ; COListeV(vmSpeicher, bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister

		mov qword ptr sqi_Speicher[rsp], rcx
		mov byte ptr sbi_ThreadSicher[rsp], dl
		mov dword ptr sdi_SpinCount[rsp], r8d

		movzx rdx, dbi_BY_COLIST
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rax], ymm0
		vmovdqu ymmword ptr [rax + 32], ymm0

		mov rcx, qword ptr sqi_Speicher[rsp]
		mov qword ptr COList_vmSpeicher[rax], rcx

		movzx rdx, byte ptr sbi_ThreadSicher[rsp]
		mov byte ptr COList_bThread[rax], dl
		test dl, dl
		je short Ende

		mov edx, dword ptr sdi_SpinCount[rsp]
		lea rcx, COList_csIterator[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COListV@System@RePag@@YQPEAVCOList@12@PEBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??0COList@System@RePag@@QEAA@_N@Z PROC ; COList::COList(bThreadSicher)
		sub rsp, s_ShadowRegister

		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rcx], ymm0
		vmovdqu ymmword ptr [rcx + 32], ymm0
		vmovdqu xmmword ptr [rcx + 56], xmm0
		mov byte ptr COList_bThread[rcx], dl
		test dl, dl
		je short Ende

		xor rdx, rdx
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		add rsp, s_ShadowRegister
		ret
??0COList@System@RePag@@QEAA@_N@Z ENDP
;----------------------------------------------------------------------------
??0COList@System@RePag@@QEAA@_NK@Z PROC ; COList::COList(bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister
		
		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rcx], ymm0
		vmovdqu ymmword ptr [rcx + 32], ymm0
		vmovdqu xmmword ptr [rcx + 56], xmm0
		mov byte ptr COList_bThread[rcx], dl
		test dl, dl
		je short Ende

		mov rdx, r8
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		add rsp, s_ShadowRegister
		ret
??0COList@System@RePag@@QEAA@_NK@Z ENDP
;----------------------------------------------------------------------------
??0COList@System@RePag@@QEAA@PEBX_N@Z PROC ; COList::COList(vmSpeicher, bThreadSicher)
		sub rsp, s_ShadowRegister
		
		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rcx], ymm0
		vmovdqu ymmword ptr [rcx + 32], ymm0
		mov qword ptr COList_vmSpeicher[rcx], rdx
		mov byte ptr COList_bThread[rcx], r8b
		test r8b, r8b
		je short Ende

		xor rdx, rdx
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		add rsp, s_ShadowRegister
		ret
??0COList@System@RePag@@QEAA@PEBX_N@Z ENDP
;----------------------------------------------------------------------------
??0COList@System@RePag@@QEAA@PEBX_NK@Z PROC ; COList::COList(vmSpeicher, bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister
		
		vpxor ymm0, ymm0, ymm0
		vmovdqu ymmword ptr [rcx], ymm0
		vmovdqu ymmword ptr [rcx + 32], ymm0
		mov qword ptr COList_vmSpeicher[rcx], rdx
		mov byte ptr COList_bThread[rcx], r8b
		test r8b, r8b
		je short Ende

		mov rdx, r9
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csIterator, ulSpinCount)

	Ende:
		add rsp, s_ShadowRegister
		ret
??0COList@System@RePag@@QEAA@PEBX_NK@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_this = 40 + s_push
??1COList@System@RePag@@QEAA@XZ PROC ; COList::~COList(void)
		push rbx
		sub rsp, s_ShadowRegister
		
		mov qword ptr sqp_this[rsp], rcx
		mov r9, qword ptr COList_pstErster[rcx]
		mov rbx, qword ptr COList_vmSpeicher[rcx]

	Kopf_Anfang:
		test r9, r9
		je short Kopf_Ende
		mov rdx, r9
		mov r9, qword ptr [r9]

		mov rcx, rbx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang

	Kopf_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		movzx rax, byte ptr COList_bThread[rcx]
		test al, al
		je short Ende
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_DeleteCriticalSection ; DeleteCrticalSection(&csIterator)
		
	Ende:
		add rsp, s_ShadowRegister
		pop rbx
		ret
??1COList@System@RePag@@QEAA@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_this = 40 + s_push
?COFreiV@COList@System@RePag@@QEAQPEBXXZ PROC ; COList::COFreiV(void)
		push rbx
		sub rsp, s_ShadowRegister
		
		mov qword ptr sqp_this[rsp], rcx
		mov r9, qword ptr COList_pstErster[rcx]
		mov rbx, qword ptr COList_vmSpeicher[rcx]

	Kopf_Anfang:
		test r9, r9
		je short Kopf_Ende
		mov rdx, r9
		mov r9, qword ptr [r9]

		mov rcx, rbx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang

	Kopf_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		movzx rax, byte ptr COList_bThread[rcx]
		test al, al
		je short Ende
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_DeleteCriticalSection ; DeleteCrticalSection(&csIterator)
		mov rcx, qword ptr sqp_this[rsp]
		
	Ende:
		mov rax, qword ptr COList_vmSpeicher[rcx]
		add rsp, s_ShadowRegister
		pop rbx
		ret
?COFreiV@COList@System@RePag@@QEAQPEBXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?DeleteList@COList@System@RePag@@QEAQX_N@Z PROC ; COList::DeleteList(bDatenLoschen)
		push rbx
		push r12
		push r13
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov r12, qword ptr COList_vmSpeicher[rcx]
		
		mov rbx, qword ptr COList_pstErster[rcx]
		test dl, dl
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]
		mov r13, rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, r13
		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]

		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		xor rax, rax
		mov dword ptr COList_ulAnzahl[rcx], eax
		mov qword ptr COList_pstLetzer[rcx], rax
		mov qword ptr COList_pstErster[rcx], rax
		
		add rsp, s_ShadowRegister
		pop r13
		pop r12
		pop rbx
		ret
?DeleteList@COList@System@RePag@@QEAQX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?DeleteListS@COList@System@RePag@@QEAQX_N@Z PROC	; COList::DeleteListS(bDatenLoschen)
		push rbx
		push r12
		push r13
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov r12, qword ptr COList_vmSpeicher[rcx]
		
		mov rbx, qword ptr COList_pstErster[rcx]
		test dl, dl
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]
		mov r13, rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, r13
		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]

		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		xor rax, rax
		mov dword ptr COList_ulAnzahl[rcx], eax
		mov qword ptr COList_pstLetzer[rcx], rax
		mov qword ptr COList_pstErster[rcx], rax

		add rsp, s_ShadowRegister
		pop r13
		pop r12
		pop rbx
		ret
?DeleteListS@COList@System@RePag@@QEAQX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sbi_DatenLoschen = 48 + s_push
sqp_this = 40 + s_push
?ThDeleteList@COList@System@RePag@@QEAQX_N@Z PROC ; COList::ThDeleteList(bDatenLoschen)
		push rbx
		push r12
		push r13
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov r12, qword ptr COList_vmSpeicher[rcx]
		mov byte ptr sbi_DatenLoschen[rsp], dl

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov rbx, qword ptr COList_pstErster[rcx]
		movzx rdx, byte ptr sbi_DatenLoschen[rsp]
		test dl, dl
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]
		mov r13, rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, r13
		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]

		mov rcx, r12
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		mov rcx, qword ptr sqp_this[rsp]

		xor rax, rax
		mov dword ptr COList_ulAnzahl[rcx], eax
		mov qword ptr COList_pstLetzer[rcx], rax
		mov qword ptr COList_pstErster[rcx], rax

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)
		
		add rsp, s_ShadowRegister
		pop r13
		pop r12
		pop rbx
		ret
?ThDeleteList@COList@System@RePag@@QEAQX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sbi_DatenLoschen = 48 + s_push
sqp_this = 40 + s_push
?ThDeleteListS@COList@System@RePag@@QEAQX_N@Z PROC ; COList::ThDeleteListS(bDatenLoschen)
		push rbx
		push r12
		push r13
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov r12, qword ptr COList_vmSpeicher[rcx]
		mov byte ptr sbi_DatenLoschen[rsp], dl

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov rbx, qword ptr COList_pstErster[rcx]
		movzx rdx, byte ptr sbi_DatenLoschen[rsp]
		test dl, dl
		je short Kopf_Anfang

	Kopf_Anfang_MitLoschen:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]
		mov r13, rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, r13
		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang_MitLoschen

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, rbx
		mov rbx, qword ptr [rbx]

		mov rcx, r12
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Kopf_Anfang
		
	Ende:
		mov rcx, qword ptr sqp_this[rsp]

		xor rax, rax
		mov dword ptr COList_ulAnzahl[rcx], eax
		mov qword ptr COList_pstLetzer[rcx], rax
		mov qword ptr COList_pstErster[rcx], rax

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)
		
		add rsp, s_ShadowRegister
		pop r13
		pop r12
		pop rbx
		ret
?ThDeleteListS@COList@System@RePag@@QEAQX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 48
sqp_this = 40
?ToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ToBegin(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx
	
		mov rcx, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COList_pstErster[rcx]
		mov qword ptr [rax], rdx
		test rdx, rdx
		jne Erster_Neu
		mov qword ptr COList_pstLetzer[rcx], rax

	Erster_Neu:
		mov qword ptr COList_pstErster[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		add rsp, s_ShadowRegister
		ret
?ToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 48
sqp_this = 40
?ToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ToBeginS(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx
	
		mov rcx, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COList_pstErster[rcx]
		mov qword ptr [rax], rdx
		test rdx, rdx
		jne Erster_Neu
		mov qword ptr COList_pstLetzer[rcx], rax

	Erster_Neu:
		mov qword ptr COList_pstErster[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		add rsp, s_ShadowRegister
		ret
?ToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Element = 56
sqp_Daten = 48
sqp_this = 40
?ThToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ThToBegin(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_Element[rsp], rax

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]
	
		mov rcx, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COList_pstErster[rcx]
		mov qword ptr [rax], rdx
		test rdx, rdx
		jne Erster_Neu
		mov qword ptr COList_pstLetzer[rcx], rax

	Erster_Neu:
		mov qword ptr COList_pstErster[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		add rsp, s_ShadowRegister
		ret
?ThToBegin@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Element = 56
sqp_Daten = 48
sqp_this = 40
?ThToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ThToBeginS(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)
		mov qword ptr sqp_Element[rsp], rax

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]
	
		mov rcx, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COList_pstErster[rcx]
		mov qword ptr [rax], rdx
		test rdx, rdx
		jne Erster_Neu
		mov qword ptr COList_pstLetzer[rcx], rax

	Erster_Neu:
		mov qword ptr COList_pstErster[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		add rsp, s_ShadowRegister
		ret
?ThToBeginS@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 48
sqp_this = 40
?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ToEnd(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx 

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		xor rdx, rdx
		mov qword ptr [rax], rdx
		mov rdx, COList_pstLetzer[rcx]
		test rdx, rdx
		jne Nachster_Neu
		mov qword ptr COList_pstErster[rcx], rax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov qword ptr [rdx], rax

	Letzter_Neu:
		mov COList_pstLetzer[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		add rsp, s_ShadowRegister
		ret
?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 48
sqp_this = 40
?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ToEndS(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx 

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		xor rdx, rdx
		mov qword ptr [rax], rdx
		mov rdx, COList_pstLetzer[rcx]
		test rdx, rdx
		jne Nachster_Neu
		mov qword ptr COList_pstErster[rcx], rax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov qword ptr [rdx], rax

	Letzter_Neu:
		mov COList_pstLetzer[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		add rsp, s_ShadowRegister
		ret
?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Element = 56
sqp_Daten = 48
sqp_this = 40
?ThToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ThToEnd(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_Element[rsp], rax

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]
		mov rcx, qword ptr sqp_this[rsp]

		xor rdx, rdx
		mov qword ptr [rax], rdx
		mov rdx, COList_pstLetzer[rcx]
		test rdx, rdx
		jne Nachster_Neu
		mov qword ptr COList_pstErster[rcx], rax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov qword ptr [rdx], rax

	Letzter_Neu:
		mov COList_pstLetzer[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		add rsp, s_ShadowRegister
		ret
?ThToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Element = 56
sqp_Daten = 48
sqp_this = 40
?ThToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::ThToEndS(pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Daten[rsp], rdx

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)
		mov qword ptr sqp_Element[rsp], rax

		mov rdx, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], rdx

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		mov rcx, qword ptr sqp_this[rsp]
		xor rdx, rdx
		mov qword ptr [rax], rdx
		mov rdx, COList_pstLetzer[rcx]
		test rdx, rdx
		jne Nachster_Neu
		mov qword ptr COList_pstErster[rcx], rax
		jmp short Letzter_Neu

	Nachster_Neu:
		mov qword ptr [rdx], rax

	Letzter_Neu:
		mov COList_pstLetzer[rcx], rax
		add dword ptr COList_ulAnzahl[rcx], 1

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		add rsp, s_ShadowRegister
		ret
?ThToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Element@COList@System@RePag@@QEAQPEAXK@Z PROC ; COList::Element(ulIndex)
		xor rax, rax
		cmp edx, dword ptr COList_ulAnzahl[rcx]
		jae short Ende
		
		test edx, edx
		jne short Index_Anzahl
		mov rax, qword ptr COList_pstErster[rcx]
		mov rax, qword ptr COList_pvDaten[rax]
		jmp short Ende

	Index_Anzahl:
		mov eax, dword ptr COList_ulAnzahl[rcx]
		sub eax, 1
		cmp edx, eax
		jne short For_Init
		mov rax, qword ptr COList_pstLetzer[rcx]
		mov rax, qword ptr COList_pvDaten[rax]
		jmp short Ende

	For_Init:
		mov rax, qword ptr COList_pstErster[rcx]
		xor rcx, rcx
		
	For_Anfang:
		add ecx, 1
		cmp ecx, edx
		ja short For_Ende
		mov rax, qword ptr [rax]
		jmp short For_Anfang

	For_Ende:
		mov rax, qword ptr COList_pvDaten[rax]

	Ende:
		ret
?Element@COList@System@RePag@@QEAQPEAXK@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Element = 56
sdi_Daten = 48
sqp_this = 40
?ThElement@COList@System@RePag@@QEAQPEAXK@Z PROC ; COList::ThElement(ulIndex)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov dword ptr sdi_Daten[rsp], edx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov r8, qword ptr sqp_this[rsp]
		mov edx, dword ptr sdi_Daten[rsp]

		xor rax, rax
		cmp edx, dword ptr COList_ulAnzahl[r8]
		jae short Ende
		
		test edx, edx
		jne short Index_Anzahl
		mov rax, qword ptr COList_pstErster[r8]
		mov rax, qword ptr COList_pvDaten[rax]
		jmp short Ende

	Index_Anzahl:
		mov eax, dword ptr COList_ulAnzahl[r8]
		sub eax, 1
		cmp edx, eax
		jne short For_Init
		mov rax, qword ptr COList_pstLetzer[r8]
		mov rax, qword ptr COList_pvDaten[rax]
		jmp short Ende

	For_Init:
		mov rax, qword ptr COList_pstErster[r8]
		xor rcx, rcx
		
	For_Anfang:
		add ecx, 1
		cmp ecx, edx
		ja short For_Ende
		mov rax, qword ptr [rax]
		jmp short For_Anfang

	For_Ende:
		mov rax, qword ptr COList_pvDaten[rax]

	Ende:
		mov qword ptr sqp_Element[rsp], rax

		lea rcx, COList_csIterator[r8]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, qword ptr sqp_Element[rsp]

		add rsp, s_ShadowRegister
		ret
?ThElement@COList@System@RePag@@QEAQPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Element@COList@System@RePag@@QEAQPEAXPEAX@Z PROC ; COList::Element(pstKnoten)
		mov rax, qword ptr COList_pvDaten[rdx]
		ret
?Element@COList@System@RePag@@QEAQPEAXPEAX@Z ENDP
;----------------------------------------------------------------------------
?NextElement@COList@System@RePag@@QEAQXAEAPEAX@Z PROC ; COList::NextElement(*&pstKnoten)
		mov rax, qword ptr [rdx]
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax
		ret
?NextElement@COList@System@RePag@@QEAQXAEAPEAX@Z ENDP
;----------------------------------------------------------------------------
?NextElement@COList@System@RePag@@QEAQXAEAPEAX0@Z PROC ; COList::NextElement(*&pstKnotenAktuell, *&pstKnotenVorheriger)
		mov rax, qword ptr [rdx]
		test rax, rax
		je short Ende

		cmp rax, qword ptr COList_pstErster[rcx]
		jne short Vorheriger_Aktuell_1
		mov rax, r8
		mov rax, qword ptr [rax]
		cmp rax, qword ptr COList_pstErster[rcx]
		jne short Vorheriger_Aktuell_2
		xor rax, rax
		mov r8, rax
		jmp short Ende

	Vorheriger_Aktuell_2:
		mov rax, qword ptr [rdx]

	Vorheriger_Aktuell_1:
		mov rcx, r8
		mov qword ptr [rcx], rax
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax

	Ende:
		ret
?NextElement@COList@System@RePag@@QEAQXAEAPEAX0@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sbi_DatenLoschen = 64 + s_push
sqp_Knoten_2 = 56 + s_push
sqp_Loschen = 48 + s_push
sqp_Knoten_1 = 40 + s_push
?DeleteElement@COList@System@RePag@@QEAQXAEAPEAX0_N@Z PROC ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)
		push rbp
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov byte ptr sbi_DatenLoschen[rsp], r9b

		mov rax, r8
		mov qword ptr sqp_Loschen[rsp], rax
		mov rax, qword ptr [rax]
		test rax, rax
		jne Loschen

		mov rax, qword ptr COList_pstErster[rbp]
		mov rax, qword ptr [rax]
		test rax, rax
		jne short Nachster

		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		test r9b, r9b
		je short AllesNull

		mov rdx, qword ptr COList_pstErster[rbp]
		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	AllesNull:
		mov rdx, qword ptr COList_pstErster[rbp]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten

		xor rcx, rcx
		mov qword ptr COList_pstErster[rbp], rcx
		mov qword ptr COList_pstLetzer[rbp], rcx
		mov rdx, qword ptr [rdx]
		mov qword ptr [rdx], rcx
		mov rax, qword ptr sqp_Loschen[rsp]
		mov qword ptr [rax], rcx
		jmp Ende

	Nachster:
		mov rcx, qword ptr COList_pstErster[rbp]
		mov qword ptr COList_pstErster[rbp], rax

		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov dl, byte ptr sbi_DatenLoschen[rsp]
		test dl, dl
		je short Knoten_Erster

		mov qword ptr sqp_Knoten_2[rsp], rcx ; COList_pstErster_Alt

		mov rdx, qword ptr COList_pvDaten[rcx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rcx, qword ptr sqp_Knoten_2[rsp] ; COList_pstErster_Alt

	Knoten_Erster:
		mov rdx, rcx
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten

		mov rcx, qword ptr COList_pstErster[rbp]
		mov qword ptr [rdx], rcx
		mov rax, qword ptr sqp_Loschen[rsp]
		xor rcx, rcx
		mov qword ptr [rax], rcx
		jmp short Ende

	Loschen:
		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov rdx, qword ptr [rax] ; pstLoschen->pstNachster
		mov rcx, qword ptr [rdx] ; pstLoschen->pstNachster->pstNachster
		mov qword ptr [rax], rcx

		mov rcx, qword ptr [rax]
		test rcx, rcx
		jne short Daten_Loschen
		mov qword ptr COList_pstLetzer[rbp], rax

	Daten_Loschen:
		mov cl, byte ptr sbi_DatenLoschen[rsp]
		test cl, cl
		je short Knoten_Loschen

		mov qword ptr sqp_Knoten_2[rsp], rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_2[rsp]
		
	Knoten_Loschen:
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp]

		mov rcx, qword ptr sqp_Loschen[rsp]
		mov rcx, qword ptr [rcx]
		mov qword ptr [rdx], rcx

	Ende:
		sub dword ptr COList_ulAnzahl[rbp], 1
		add rsp, s_ShadowRegister
		pop rbp
		ret
?DeleteElement@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sbi_DatenLoschen = 64 + s_push
sqp_Knoten_2 = 56 + s_push
sqp_Loschen = 48 + s_push
sqp_Knoten_1 = 40 + s_push
?DeleteElementS@COList@System@RePag@@QEAQXAEAPEAX0_N@Z PROC ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)
		push rbp
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov byte ptr sbi_DatenLoschen[rsp], r9b

		mov rax, r8
		mov qword ptr sqp_Loschen[rsp], rax
		mov rax, qword ptr [rax]
		test rax, rax
		jne Loschen

		mov rax, qword ptr COList_pstErster[rbp]
		mov rax, qword ptr [rax]
		test rax, rax
		jne short Nachster

		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		test r9b, r9b
		je short AllesNull

		mov rdx, qword ptr COList_pstErster[rbp]
		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

	AllesNull:
		mov rdx, qword ptr COList_pstErster[rbp]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten

		xor rcx, rcx
		mov qword ptr COList_pstErster[rbp], rcx
		mov qword ptr COList_pstLetzer[rbp], rcx
		mov rdx, qword ptr [rdx]
		mov qword ptr [rdx], rcx
		mov rax, qword ptr sqp_Loschen[rsp]
		mov qword ptr [rax], rcx
		jmp Ende

	Nachster:
		mov rcx, qword ptr COList_pstErster[rbp]
		mov qword ptr COList_pstErster[rbp], rax

		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov dl, byte ptr sbi_DatenLoschen[rsp]
		test dl, dl
		je short Knoten_Erster

		mov qword ptr sqp_Knoten_2[rsp], rcx ; COList_pstErster_Alt

		mov rdx, qword ptr COList_pvDaten[rcx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rcx, qword ptr sqp_Knoten_2[rsp] ; COList_pstErster_Alt

	Knoten_Erster:
		mov rdx, rcx
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten

		mov rcx, qword ptr COList_pstErster[rbp]
		mov qword ptr [rdx], rcx
		mov rax, qword ptr sqp_Loschen[rsp]
		xor rcx, rcx
		mov qword ptr [rax], rcx
		jmp short Ende

	Loschen:
		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov rdx, qword ptr [rax] ; pstLoschen->pstNachster
		mov rcx, qword ptr [rdx] ; pstLoschen->pstNachster->pstNachster
		mov qword ptr [rax], rcx

		mov rcx, qword ptr [rax]
		test rcx, rcx
		jne short Daten_Loschen
		mov qword ptr COList_pstLetzer[rbp], rax

	Daten_Loschen:
		mov cl, byte ptr sbi_DatenLoschen[rsp]
		test cl, cl
		je short Knoten_Loschen

		mov qword ptr sqp_Knoten_2[rsp], rdx

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_2[rsp]
		
	Knoten_Loschen:
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_1[rsp]

		mov rcx, qword ptr sqp_Loschen[rsp]
		mov rcx, qword ptr [rcx]
		mov qword ptr [rdx], rcx

	Ende:
		sub dword ptr COList_ulAnzahl[rbp], 1
		add rsp, s_ShadowRegister
		pop rbp
		ret
?DeleteElementS@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_Knoten_2 = 48 + s_push
sqp_Knoten_1 = 40 + s_push
?DeleteFirstElement@COList@System@RePag@@QEAQXAEAPEAX_N@Z PROC ; COList::DeleteFirstElement(*&pstKnoten, bDatenLoschen)
		push rbp
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov rdx, qword ptr COList_pstErster[rcx]
		mov rax, qword ptr [rdx]
		test rax, rax
		jne short Nachstes
		
		test r8b, r8b
		je short Losch_Null

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Losch_Null:
		xor rax, rax
		mov qword ptr COList_pstLetzer[rbp], rax
		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten
		mov qword ptr [rdx], rax

		mov rdx, qword ptr COList_pstErster[rbp]
		mov qword ptr COList_pstErster[rbp], rax
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		jmp short Ende

	Nachstes:
		mov qword ptr COList_pstErster[rbp], rax

		test r8b, r8b
		je short Knoten_Erster

		mov qword ptr sqp_Knoten_2[rsp], rdx ; pstErster

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_2[rsp] ; pstErster

	Knoten_Erster:
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		
		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten
		mov rax, qword ptr COList_pstErster[rbp]
		mov qword ptr [rdx], rax

	Ende:
		sub dword ptr COList_ulAnzahl[rbp], 1
		add rsp, s_ShadowRegister
		pop rbp
		ret
?DeleteFirstElement@COList@System@RePag@@QEAQXAEAPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_Knoten_2 = 48 + s_push
sqp_Knoten_1 = 40 + s_push
?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z PROC ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		push rbp
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov qword ptr sqp_Knoten_1[rsp], rdx ; pstKnoten

		mov rdx, qword ptr COList_pstErster[rcx]
		mov rax, qword ptr [rdx]
		test rax, rax
		jne short Nachstes
		
		test r8b, r8b
		je short Losch_Null

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

	Losch_Null:
		xor rax, rax
		mov qword ptr COList_pstLetzer[rbp], rax
		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten
		mov qword ptr [rdx], rax

		mov rdx, qword ptr COList_pstErster[rbp]
		mov qword ptr COList_pstErster[rbp], rax
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		jmp short Ende

	Nachstes:
		mov qword ptr COList_pstErster[rbp], rax

		test r8b, r8b
		je short Knoten_Erster

		mov qword ptr sqp_Knoten_2[rsp], rdx ; pstErster

		mov rdx, qword ptr COList_pvDaten[rdx]
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_Knoten_2[rsp] ; pstErster

	Knoten_Erster:
		mov rcx, qword ptr COList_vmSpeicher[rbp]
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)
		
		mov rdx, qword ptr sqp_Knoten_1[rsp] ; pstKnoten
		mov rax, qword ptr COList_pstErster[rbp]
		mov qword ptr [rdx], rax

	Ende:
		sub dword ptr COList_ulAnzahl[rbp], 1
		add rsp, s_ShadowRegister
		pop rbp
		ret
?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Loschen = 56
sqp_Knoten = 48
sqp_this = 40
?DeleteElement@COList@System@RePag@@QEAQXK_N@Z PROC ; COList::DeleteElement(ulIndex, bDatenLoschen)
		sub rsp, s_ShadowRegister

		mov r9b, r8b ; bDatenLoschen COList::DeleteElement -> weiter unten

		mov qword ptr sqp_this[rsp], rcx
		mov r8, rdx

		cmp edx, dword ptr COList_ulAnzahl[rcx]
		jae short Ende

		mov rcx, qword ptr COList_pstErster[rcx]
		mov qword ptr sqp_Knoten[rsp], rcx
		lea rdx, sqp_Knoten[rsp]
		xor rax, rax
		mov qword ptr sqp_Loschen[rsp], rax
		lea r10, sqp_Loschen[rsp]
		mov r11, 1
		mov rax, qword ptr [rdx]

	For_Anfang:
		cmp r11, r8
		ja short Loschen
		add r11, 1

		mov qword ptr [r10], rax
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax
		jmp short For_Anfang

	Loschen:
		mov r8, r10
		mov rcx, qword ptr sqp_this[rsp]
		call ?DeleteElement@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		add rsp, s_ShadowRegister
		ret
?DeleteElement@COList@System@RePag@@QEAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Loschen = 56
sqp_Knoten = 48
sqp_this = 40
?DeleteElementS@COList@System@RePag@@QEAQXK_N@Z PROC ; COList::DeleteElementS(ulIndex, bDatenLoschen)
		sub rsp, s_ShadowRegister

		mov r9b, r8b ; bDatenLoschen COList::DeleteElement -> weiter unten

		mov qword ptr sqp_this[rsp], rcx
		mov r8, rdx

		cmp edx, dword ptr COList_ulAnzahl[rcx]
		jae short Ende

		mov rcx, qword ptr COList_pstErster[rcx]
		mov qword ptr sqp_Knoten[rsp], rcx
		lea rdx, sqp_Knoten[rsp]
		xor rax, rax
		mov qword ptr sqp_Loschen[rsp], rax
		lea r10, sqp_Loschen[rsp]
		mov r11, 1
		mov rax, qword ptr [rdx]

	For_Anfang:
		cmp r11, r8
		ja short Loschen
		add r11, 1

		mov qword ptr [r10], rax
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax
		jmp short For_Anfang

	Loschen:
		mov r8, r10
		mov rcx, qword ptr sqp_this[rsp]
		call ?DeleteElementS@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		add rsp, s_ShadowRegister
		ret
?DeleteElementS@COList@System@RePag@@QEAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Anzahl = 64
sqp_Loschen = 56
sqp_Knoten = 48
sqp_this = 40
?ThDeleteElement@COList@System@RePag@@QEAQXK_N@Z PROC ; COList::ThDeleteElement(ulIndex, bDatenLoschen)
		sub rsp, s_ShadowRegister

		mov r9b, r8b

		mov dword ptr sdi_Anzahl[rsp], edx
		mov qword ptr sqp_this[rsp], rcx
		mov r8, rdx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr sdi_Anzahl[rsp]
		cmp edx, dword ptr COList_ulAnzahl[rcx]
		jae short Ende

		mov rcx, qword ptr COList_pstErster[rcx]
		mov qword ptr sqp_Knoten[rsp], rcx
		lea rdx, sqp_Knoten[rsp]
		xor rax, rax
		mov qword ptr sqp_Loschen[rsp], rax
		lea r10, sqp_Loschen[rsp]
		mov r11, 1
		mov rax, qword ptr [rdx]

	For_Anfang:
		cmp r11, r8
		ja short Loschen
		add r11, 1

		mov qword ptr [r10], rax
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax
		jmp short For_Anfang

	Loschen:
		mov r8, r10
		mov rcx, qword ptr sqp_this[rsp]
		call ?DeleteElement@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ; COList::DeleteElement(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		add rsp, s_ShadowRegister
		ret
?ThDeleteElement@COList@System@RePag@@QEAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Anzahl = 64
sqp_Loschen = 56
sqp_Knoten = 48
sqp_this = 40
?ThDeleteElementS@COList@System@RePag@@QEAQXK_N@Z PROC ; COList::ThDeleteElementS(ulIndex, bDatenLoschen)
		sub rsp, s_ShadowRegister

		mov r9b, r8b

		mov dword ptr sdi_Anzahl[rsp], edx
		mov qword ptr sqp_this[rsp], rcx
		mov r8, rdx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr sdi_Anzahl[rsp]
		cmp edx, dword ptr COList_ulAnzahl[rcx]
		jae short Ende

		mov rcx, qword ptr COList_pstErster[rcx]
		mov qword ptr sqp_Knoten[rsp], rcx
		lea rdx, sqp_Knoten[rsp]
		xor rax, rax
		mov qword ptr sqp_Loschen[rsp], rax
		lea r10, sqp_Loschen[rsp]
		mov r11, 1
		mov rax, qword ptr [rdx]

	For_Anfang:
		cmp r11, r8
		ja short Loschen
		add r11, 1

		mov qword ptr [r10], rax
		mov rax, qword ptr [rax]
		mov qword ptr [rdx], rax
		jmp short For_Anfang

	Loschen:
		mov r8, r10
		mov rcx, qword ptr sqp_this[rsp]
		call ?DeleteElementS@COList@System@RePag@@QEAQXAEAPEAX0_N@Z ; COList::DeleteElementS(*&pstKnoten, *&pstLoschen, bDatenLoschen)

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		add rsp, s_ShadowRegister
		ret
?ThDeleteElementS@COList@System@RePag@@QEAQXK_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 64
sqp_KnotenVorheriger = 56
sqp_KnotenAktuell = 48
sqp_this = 40
?Insert@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z PROC ; COList::Insert(*&pstKnotenAktuell, *&pstKnotenVorheriger, pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_KnotenAktuell[rsp], rdx
		mov qword ptr sqp_KnotenVorheriger[rsp], r8
		mov qword ptr sqp_Daten[rsp], r9

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r9, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], r9

		mov rdx, qword ptr sqp_KnotenAktuell[rsp]
		mov rdx, qword ptr [rdx]

		mov qword ptr [rax], rdx

		mov r8, qword ptr sqp_this[rsp]
		mov rcx, qword ptr sqp_KnotenVorheriger[rsp]
		mov rcx, qword ptr [rcx]
		test rcx, rcx
		jne short Vorheriger_Nachster
		mov qword ptr COList_pstErster[r8], rax
		jmp short Knoten_Aktuell

	Vorheriger_Nachster:
		mov qword ptr [rcx], rax

	Knoten_Aktuell:
		test rdx, rdx
		jne short Ende
		mov qword ptr COList_pstLetzer[r8], rax

	Ende:
		add dword ptr COList_ulAnzahl[r8], 1
		add rsp, s_ShadowRegister
		ret
?Insert@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Daten = 64
sqp_KnotenVorheriger = 56
sqp_KnotenAktuell = 48
sqp_this = 40
?InsertS@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z PROC ; COList::InsertS(*&pstKnotenAktuell, *&pstKnotenVorheriger, pvDaten)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_KnotenAktuell[rsp], rdx
		mov qword ptr sqp_KnotenVorheriger[rsp], r8
		mov qword ptr sqp_Daten[rsp], r9

		mov rdx, 16
		mov rcx, qword ptr COList_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov r9, qword ptr sqp_Daten[rsp]
		mov qword ptr COList_pvDaten[rax], r9

		mov rdx, qword ptr sqp_KnotenAktuell[rsp]
		mov rdx, qword ptr [rdx]

		mov qword ptr [rax], rdx

		mov r8, qword ptr sqp_this[rsp]
		mov rcx, qword ptr sqp_KnotenVorheriger[rsp]
		mov rcx, qword ptr [rcx]
		test rcx, rcx
		jne short Vorheriger_Nachster
		mov qword ptr COList_pstErster[r8], rax
		jmp short Knoten_Aktuell

	Vorheriger_Nachster:
		mov qword ptr [rcx], rax

	Knoten_Aktuell:
		test rdx, rdx
		jne short Ende
		mov qword ptr COList_pstLetzer[r8], rax

	Ende:
		add dword ptr COList_ulAnzahl[r8], 1
		add rsp, s_ShadowRegister
		ret
?InsertS@COList@System@RePag@@QEAQPEAXAEAPEAX0PEAX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Number@COList@System@RePag@@QEAQKXZ PROC ; COList::Number(void)
		mov eax, dword ptr COList_ulAnzahl[rcx]
		ret
?Number@COList@System@RePag@@QEAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_this = 40 + s_push
?ThNumber@COList@System@RePag@@QEAQAEAKAEAK@Z PROC ; COList::ThNumber(&ulAnzahl)
		push rbx
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov rbx, rdx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov eax, dword ptr COList_ulAnzahl[rcx]
		mov dword ptr [rbx], eax

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		mov rax, rbx
		add rsp, s_ShadowRegister
		pop rbx
		ret
?ThNumber@COList@System@RePag@@QEAQAEAKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?IteratorToBegin@COList@System@RePag@@QEAQPEAXXZ PROC ; COList::IteratorToBegin(void)
		mov rax, qword ptr COList_pstErster[rcx]
		ret
?IteratorToBegin@COList@System@RePag@@QEAQPEAXXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
?ThIteratorToBegin@COList@System@RePag@@QEAQPEAXXZ PROC ; COList::ThIteratorToBegin(void)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_this[rsp], rcx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov rax, qword ptr COList_pstErster[rcx]

		add rsp, s_ShadowRegister
		ret
?ThIteratorToBegin@COList@System@RePag@@QEAQPEAXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
?ThIteratorToBegin_Lock@COList@System@RePag@@QEAQPEAXXZ PROC ; COList::ThIteratorToBegin_Lock(void)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_this[rsp], rcx

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csIterator)

		mov rcx, qword ptr sqp_this[rsp]
		mov rax, qword ptr COList_pstErster[rcx]

		add rsp, s_ShadowRegister
		ret
?ThIteratorToBegin_Lock@COList@System@RePag@@QEAQPEAXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
?ThIteratorEnd@COList@System@RePag@@QEAQXXZ PROC ; COList::ThIteratorEnd(void)
		sub rsp, s_ShadowRegister

		lea rcx, COList_csIterator[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csIterator)

		add rsp, s_ShadowRegister
		ret
?ThIteratorEnd@COList@System@RePag@@QEAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OListe ENDS
;----------------------------------------------------------------------------
END