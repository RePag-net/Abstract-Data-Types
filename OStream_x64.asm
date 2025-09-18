;******************************************************************************
;MIT License

;Copyright(c) 2025 René Pagel

;Filename: OStream_x64.asm
;For more information see https://github.com/RePag-net/Abstract-Data-Types

;Permission is hereby granted, free of charge, to any person obtaining a copy
;of this software and associated documentation files(the "Software"), to deal
;in the Software without restriction, including without limitation the rights
;to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
;copies of the Software, and to permit persons to whom the Software is
;furnished to do so, subject to the following conditions :

;The above copyright notice and this permission notice shall be included in all
;copies or substantial portions of the Software.

;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
;AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;SOFTWARE.
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

EXTRN __imp_GetFileSizeEx:PROC
EXTRN __imp_GetLastError:PROC
EXTRN __imp_GetOverlappedResult:PROC
EXTRN __imp_ReadFile:PROC
EXTRN __imp_WriteFile:PROC
EXTRN __imp_CloseHandle:PROC
EXTRN __imp_CreateEventA:PROC

EXTRN ?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z:PROC
EXTRN ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z:PROC
EXTRN ?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z:PROC
EXTRN ?COFreiV@COList@System@RePag@@QEAQPEBXXZ: PROC

EXTRN ?Write@COTime@System@RePag@@QEAQXPEBD@Z:PROC
EXTRN ?Read@COTime@System@RePag@@QEAQXPEAD@Z:PROC

EXTRN ?Write@COComma4@System@RePag@@QEAQXQEBD@Z:PROC
EXTRN ?Read@COComma4@System@RePag@@QEAQXQEBD@Z:PROC

EXTRN ?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z:PROC
EXTRN ?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z:PROC

EXTRN ?SetLength@COStringA@System@RePag@@QEAQXK@Z:PROC

.DATA
dbi_BY_COSTREAM DB 136
FT_SHORTSTR DB 1
FT_MEMOSTR DB 3

CS_OStream SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_bThreadSicher = 48
sqp_this = 40
?COStreamV@System@RePag@@YQPEAVCOStream@12@_N@Z PROC ; COStreamV(bThreadSicher)
		sub rsp, s_ShadowRegister

		mov byte ptr sbi_bThreadSicher[rsp], cl

		movzx rdx, dbi_BY_COSTREAM
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rax], ymm5
		vmovdqu ymmword ptr COStream[rax + 32], ymm5
		vmovdqu ymmword ptr COStream[rax + 64], ymm5
		vmovdqu ymmword ptr COStream[rax + 96], ymm5
		vmovdqu xmmword ptr COStream[rax + 120], xmm5
		movzx rcx, byte ptr sbi_bThreadSicher[rsp]
		mov byte ptr COStream_bThread[rax], cl
		test cl, cl
		je short Ende

		xor rdx, rdx
		lea rcx, COStream_csStream[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COStreamV@System@RePag@@YQPEAVCOStream@12@_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_ulSpinCount = 56
sbi_bThreadSicher = 48
sqp_this = 40
?COStreamV@System@RePag@@YQPEAVCOStream@12@_NK@Z PROC ; COStreamV(bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister

		mov byte ptr sbi_bThreadSicher[rsp], cl
		mov dword ptr sdi_ulSpinCount[rsp], edx

		movzx rdx, dbi_BY_COSTREAM
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rax], ymm5
		vmovdqu ymmword ptr COStream[rax + 32], ymm5
		vmovdqu ymmword ptr COStream[rax + 64], ymm5
		vmovdqu ymmword ptr COStream[rax + 96], ymm5
		vmovdqu xmmword ptr COStream[rax + 120], xmm5
		movzx rcx, byte ptr sbi_bThreadSicher[rsp]
		mov byte ptr COStream_bThread[rax], cl
		test cl, cl
		je short Ende

		mov edx, dword ptr sdi_ulSpinCount[rsp]
		lea rcx, COStream_csStream[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COStreamV@System@RePag@@YQPEAVCOStream@12@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_bThreadSicher = 56
sqp_vmSpeicher = 48
sqp_this = 40
?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_N@Z PROC ; COStreamV(vmSpeicher, bThreadSicher)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov byte ptr sbi_bThreadSicher[rsp], dl

		movzx rdx, dbi_BY_COSTREAM
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rax], ymm5
		vmovdqu ymmword ptr COStream[rax + 32], ymm5
		vmovdqu ymmword ptr COStream[rax + 64], ymm5
		vmovdqu ymmword ptr COStream[rax + 96], ymm5
		vmovdqu xmmword ptr COStream[rax + 120], xmm5

		mov rcx, qword ptr sqp_vmSpeicher[rsp]
		mov qword ptr COStream_vmSpeicher[rax], rcx
		mov qword ptr COStream_COList_vmSpeicher[rax], rcx

		movzx rcx, byte ptr sbi_bThreadSicher[rsp]
		mov byte ptr COStream_bThread[rax], cl
		test cl, cl
		je short Ende

		xor rdx, rdx
		lea rcx, COStream_csStream[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_bThreadSicher = 60
sdi_ulSpinCount = 56
sqp_vmSpeicher = 48
sqp_this = 40
?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_NK@Z PROC ; COStreamV(vmSpeicher, bThreadSicher, ulSpinCount)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov byte ptr sbi_bThreadSicher[rsp], dl
		mov dword ptr sdi_ulSpinCount[rsp], r8d

		movzx rdx, dbi_BY_COSTREAM
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rax], ymm5
		vmovdqu ymmword ptr COStream[rax + 32], ymm5
		vmovdqu ymmword ptr COStream[rax + 64], ymm5
		vmovdqu ymmword ptr COStream[rax + 96], ymm5
		vmovdqu xmmword ptr COStream[rax + 120], xmm5

		mov rcx, qword ptr sqp_vmSpeicher[rsp]
		mov qword ptr COStream_vmSpeicher[rax], rcx
		mov qword ptr COStream_COList_vmSpeicher[rax], rcx

		movzx rcx, byte ptr sbi_bThreadSicher[rsp]
		mov byte ptr COStream_bThread[rax], cl
		test cl, cl
		je short Ende

		mov edx, dword ptr sdi_ulSpinCount[rsp]
		lea rcx, COStream_csStream[rax]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov rax, qword ptr sqp_this[rsp]
		add rsp, s_ShadowRegister
		ret
?COStreamV@System@RePag@@YQPEAVCOStream@12@PEBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??0COStream@System@RePag@@QEAA@_N@Z PROC ; COStream::COStream(bThreadSicher)
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rcx], ymm5
		vmovdqu ymmword ptr COStream[rcx + 32], ymm5
		vmovdqu ymmword ptr COStream[rcx + 64], ymm5
		vmovdqu ymmword ptr COStream[rcx + 96], ymm5
		vmovdqu xmmword ptr COStream[rcx + 120], xmm5

		mov byte ptr COStream_bThread[rcx], dl
		test dl, dl
		je short Ende

		xor rdx, rdx
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		ret
??0COStream@System@RePag@@QEAA@_N@Z ENDP
;----------------------------------------------------------------------------
??0COStream@System@RePag@@QEAA@_NK@Z PROC ; COStream::COStream(bThreadSicher, ulSpinCount)
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rcx], ymm5
		vmovdqu ymmword ptr COStream[rcx + 32], ymm5
		vmovdqu ymmword ptr COStream[rcx + 64], ymm5
		vmovdqu ymmword ptr COStream[rcx + 96], ymm5
		vmovdqu xmmword ptr COStream[rcx + 120], xmm5

		mov byte ptr COStream_bThread[rcx], dl
		test dl, dl
		je short Ende

		mov edx, r8d
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		ret
??0COStream@System@RePag@@QEAA@_NK@Z ENDP
;----------------------------------------------------------------------------
??0COStream@System@RePag@@QEAA@PEBX_N@Z PROC ; COStream::COStream(vmSpeicher, bThreadSicher)
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rcx], ymm5
		vmovdqu ymmword ptr COStream[rcx + 32], ymm5
		vmovdqu ymmword ptr COStream[rcx + 64], ymm5
		vmovdqu ymmword ptr COStream[rcx + 96], ymm5
		vmovdqu xmmword ptr COStream[rcx + 120], xmm5

		mov qword ptr COStream_vmSpeicher[rcx], rdx
		mov qword ptr COStream_COList_vmSpeicher[rcx], rdx

		mov byte ptr COStream_bThread[rcx], r8b
		test r8b, r8b
		je short Ende

		xor rdx, rdx
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		ret
??0COStream@System@RePag@@QEAA@PEBX_N@Z ENDP
;----------------------------------------------------------------------------
??0COStream@System@RePag@@QEAA@PEBX_NK@Z PROC ; COStream::COStream(vmSpeicher, bThreadSicher, ulSpinCount)
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr COStream[rcx], ymm5
		vmovdqu ymmword ptr COStream[rcx + 32], ymm5
		vmovdqu ymmword ptr COStream[rcx + 64], ymm5
		vmovdqu ymmword ptr COStream[rcx + 96], ymm5
		vmovdqu xmmword ptr COStream[rcx + 120], xmm5

		mov qword ptr COStream_vmSpeicher[rcx], rdx
		mov qword ptr COStream_COList_vmSpeicher[rcx], rdx
		
		mov byte ptr COStream_bThread[rcx], r8b
		test r8b, r8b
		je short Ende

		mov edx, r9d
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_InitializeCriticalSectionAndSpinCount ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		ret
??0COStream@System@RePag@@QEAA@PEBX_NK@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
??1COStream@System@RePag@@QEAA@XZ PROC ; COStream::~COStream(void)
		push rbx
		push rdi
		push rsi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov rbx, COStream_COList_pstErster[rcx]
		mov rdi, qword ptr COStream_vmSpeicher[rcx]
		lea rsi, COStream_COList[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Kopf_Ende
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		add rdx, 04h
		mov rdx, qword ptr [rdx]

		mov rcx, rdi
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov r8b, 1
		mov rdx, rbx
		mov rcx, rsi
		call ?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov rcx, qword ptr sqp_this[rsp]
		mov rax, COStream_COList_pstErster[rcx]
		test rax, rax ; if rbx => pstKnoten VirtualFree
		je short Kopf_Ende
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

	Kopf_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		movzx rax, byte ptr COStream_bThread[rcx]
		test rax, rax
		je short Ende
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_DeleteCriticalSection ; DeleteCrticalSection(&csIterator)

	Ende:
		add rsp, s_ShadowRegister
		pop rsi
		pop rdi
		pop rbx
		ret 
??1COStream@System@RePag@@QEAA@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?COFreiV@COStream@System@RePag@@QEAQPEBXXZ PROC ; COStream::COFreiV(void)
		push rbx
		push rdi
		push rsi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov rbx, qword ptr COStream_COList_pstErster[rcx]
		mov rdi, qword ptr COStream_vmSpeicher[rcx]
		lea rsi, COStream_COList[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Kopf_Ende
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		add rdx, 04h
		mov rdx, qword ptr [rdx]

		mov rcx, rdi
		call ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z ; VMFreiS(vmSpeicher, vbAdresse)

		mov r8b, 1
		mov rdx, rbx
		mov rcx, rsi
		call ?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov rcx, qword ptr sqp_this[rsp]
		mov rax, qword ptr COStream_COList_pstErster[rcx]
		test rax, rax ; if rbx => pstKnoten VirtualFree
		je short Kopf_Ende
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

	Kopf_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		movzx rax, byte ptr COStream_bThread[rcx]
		test rax, rax
		je short Ende
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_DeleteCriticalSection ; DeleteCrticalSection(&csIterator)
		mov rcx, qword ptr sqp_this[rsp]

	Ende:
		mov rax, qword ptr COStream_vmSpeicher[rcx]
		add rsp, s_ShadowRegister
		pop rsi
		pop rdi
		pop rbx
		ret
?COFreiV@COStream@System@RePag@@QEAQPEBXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_ulBytes = 64
sqp_vbElement = 56
sqp_pvDaten = 48
sqp_this = 40
?Write@COStream@System@RePag@@QEAQXPEAXK@Z PROC ; COStream::Write(pvDaten, ulByte)
		sub rsp, s_ShadowRegister

		test r8d, r8d
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov dword ptr sdi_ulBytes[rsp], r8d

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulBytes[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr sqp_this[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rdx, qword ptr sqp_vbElement[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_COList[rcx]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)

		mov rcx, qword ptr sqp_this[rsp]
		mov eax, dword ptr sdi_ulBytes[rsp]
		add dword ptr COStream_ulBytes[rcx], eax
		add dword ptr COStream_ulPosition[rcx], eax

	Ende:
		add rsp, s_ShadowRegister
		ret
?Write@COStream@System@RePag@@QEAQXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_ulBytes = 64
sqp_vbElement = 56
sqp_pvDaten = 48
sqp_this = 40
?WriteS@COStream@System@RePag@@QEAQXPEAXK@Z PROC ; COStream::WriteS(pvDaten, ulByte)
		sub rsp, s_ShadowRegister

		test r8d, r8d
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov dword ptr sdi_ulBytes[rsp], r8d

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulBytes[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr sqp_this[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rdx, qword ptr sqp_vbElement[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_COList[rcx]
		call ?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEndS(pvDaten)

		mov rcx, qword ptr sqp_this[rsp]
		mov eax, dword ptr sdi_ulBytes[rsp]
		add dword ptr COStream_ulBytes[rcx], eax
		add dword ptr COStream_ulPosition[rcx], eax

	Ende:
		add rsp, s_ShadowRegister
		ret
?WriteS@COStream@System@RePag@@QEAQXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_ulBytes = 64
sqp_vbElement = 56
sqp_pvDaten = 48
sqp_this = 40
?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z PROC ; COStream::ThWrite(pvDaten, ulByte)
		sub rsp, s_ShadowRegister

		test r8d, r8d
		je Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov dword ptr sdi_ulBytes[rsp], r8d

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulBytes[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr sqp_this[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbElement[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_COList[rcx]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)

		mov rcx, qword ptr sqp_this[rsp]
		mov eax, dword ptr sdi_ulBytes[rsp]
		add dword ptr COStream_ulBytes[rcx], eax
		add dword ptr COStream_ulPosition[rcx], eax

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

	Ende:
		add rsp, s_ShadowRegister
		ret
?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_ulBytes = 64
sqp_vbElement = 56
sqp_pvDaten = 48
sqp_this = 40
?ThWriteS@COStream@System@RePag@@QEAQXPEAXK@Z PROC ; COStream::ThWriteS(pvDaten, ulByte)
		sub rsp, s_ShadowRegister

		test r8d, r8d
		je Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov dword ptr sdi_ulBytes[rsp], r8d

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov r8d, dword ptr sdi_ulBytes[rsp]
		mov dword ptr [rax], r8d
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr sqp_this[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbElement[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_COList[rcx]
		call ?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEndS(pvDaten)

		mov rcx, qword ptr sqp_this[rsp]
		mov eax, dword ptr sdi_ulBytes[rsp]
		add dword ptr COStream_ulBytes[rcx], eax
		add dword ptr COStream_ulPosition[rcx], eax

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

	Ende:
		add rsp, s_ShadowRegister
		ret
?ThWriteS@COStream@System@RePag@@QEAQXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sdi_ulEndPosition = 64 + s_push
sdi_ulByte = 56 + s_push
sqp_pvDaten = 48 + s_push
sqp_this = 40 + s_push
?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z PROC ; COStream::Read(pvDaten, ulByte)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx

		xor rax, rax
		mov r8d, dword ptr COStream_ulPosition[rcx]
		mov edx, dword ptr COStream_ulBytes[rcx]
		cmp r8d, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Pruf_ulByte:
		add r8d, dword ptr sdi_ulByte[rsp]
		cmp edx, r8d
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Kopf_Init:
		mov dword ptr sdi_ulEndPosition[rsp], eax
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je Ende
		mov rdi, qword ptr COStream_COList_pvDaten[rbx]  
		mov edi, dword ptr [rdi] ;edi -> ulElementLange
		add dword ptr sdi_ulEndPosition[rsp], edi

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr sdi_ulEndPosition[rsp]
		cmp ecx, dword ptr COStream_ulPosition[rax]
		jb Next_Element

		mov rsi, rcx ;  esi -> ulDifferenz
		sub esi, dword ptr COStream_ulPosition[rax]
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Liste

		mov rcx, rdi
		sub rcx, rsi

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test rsi, rsi
		je short Fuss_Anfang
		mov rcx, rdi
		sub rcx, rsi

		mov r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov rbx, qword ptr [rbx]

		mov rdi, qword ptr COStream_COList_pvDaten[rbx]
		mov edi, dword ptr [rdi]

		mov rcx, rsi
		add rcx, rdi
		cmp dword ptr sdi_ulByte[rsp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr sdi_ulByte[rsp]
		sub rax, rsi
		mov r8, rax
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		mov r8, rdi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add rsi, rdi
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
		mov rbx, qword ptr [rbx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr sdi_ulByte[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		add dword ptr COStream_ulPosition[rcx], eax
		mov rax, qword ptr sqp_pvDaten[rsp]

	Ende:
		add rsp, s_ShadowRegister
		pop rdi
		pop rsi
		pop rbx
		ret
?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sdi_ulEndPosition = 60 + s_push
sdi_ulByte = 56 + s_push
sqp_pvDaten = 48 + s_push
sqp_this = 40 + s_push
?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z PROC ; COStream::ThRead(pvDaten, ulByte)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pvDaten[rsp], rdx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		mov rcx, qword ptr sqp_this[rsp]
		xor rax, rax
		mov r8d, dword ptr COStream_ulPosition[rcx]
		mov edx, dword ptr COStream_ulBytes[rcx]
		cmp r8d, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Pruf_ulByte:
		add r8d, dword ptr sdi_ulByte[rsp]
		cmp edx, r8d
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Kopf_Init:
		mov dword ptr sdi_ulEndPosition[rsp], eax
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je Thread_Ende
		mov rdi, qword ptr COStream_COList_pvDaten[rbx] ; rdi -> ulElementLange
		mov edi, dword ptr [rdi]
		add dword ptr sdi_ulEndPosition[rsp], edi

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr sdi_ulEndPosition[rsp]
		cmp ecx, dword ptr COStream_ulPosition[rax]
		jb Next_Element

		mov rsi, rcx ;  esi -> ulDifferenz
		sub esi, dword ptr COStream_ulPosition[rax]
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Liste

		mov rcx, rdi
		sub rcx, rsi

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test rsi, rsi
		je short Fuss_Anfang
		mov rcx, rdi
		sub rcx, rsi

		mov r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov rbx, qword ptr [rbx]

		mov rdi, qword ptr COStream_COList_pvDaten[rbx]
		mov rdi, qword ptr [rdi]

		mov rcx, rsi
		add rcx, rdi
		cmp dword ptr sdi_ulByte[rsp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr sdi_ulByte[rsp]
		sub rax, rsi
		mov r8, rax
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		mov r8, rdi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add rsi, rdi
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
		mov rbx, qword ptr [rbx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr sdi_ulByte[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		add dword ptr COStream_ulPosition[rcx], eax
		mov rax, qword ptr sqp_pvDaten[rsp]

	Thread_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

	Ende:
		add rsp, s_ShadowRegister
		pop rdi
		pop rsi
		pop rbx
		ret
?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_ulByte = 60 + s_push
sqp_ulSchreibPosition = 56 + s_push
sqp_vbElement = 48 + s_push
sqp_pvDaten = 40 + s_push
?Write@COStream@System@RePag@@QEAQXPEAXKAEAK@Z PROC ; COStream::Write(pvDaten, ulByte, &ulSchreibPosition)
		push rbp
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je short Ende

		mov rbp, rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulSchreibPosition[rsp], r9

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulByte[rsp]
		mov qword ptr [rax], rdx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rdx, qword ptr sqp_vbElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr sdi_ulByte[rsp]
		add dword ptr COStream_ulBytes[rbp], eax
		mov rcx, qword ptr sqp_ulSchreibPosition[rsp]
		add dword ptr [rcx], eax

	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?Write@COStream@System@RePag@@QEAQXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_ulByte = 60 + s_push
sqp_ulSchreibPosition = 56 + s_push
sqp_vbElement = 48 + s_push
sqp_pvDaten = 40 + s_push
?WriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z PROC ; COStream::WriteS(pvDaten, ulByte, &ulSchreibPosition)
		push rbp
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je short Ende

		mov rbp, rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulSchreibPosition[rsp], r9

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulByte[rsp]
		mov qword ptr [rax], rdx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rdx, qword ptr sqp_vbElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEndS@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEndS(pvDaten)

		mov eax, dword ptr sdi_ulByte[rsp]
		add dword ptr COStream_ulBytes[rbp], eax
		mov rcx, qword ptr sqp_ulSchreibPosition[rsp]
		add dword ptr [rcx], eax

	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?WriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_ulByte = 60 + s_push
sqp_ulSchreibPosition = 56 + s_push
sqp_vbElement = 48 + s_push
sqp_pvDaten = 40 + s_push
?ThWrite@COStream@System@RePag@@QEAQXPEAXKAEAK@Z PROC ; COStream::ThWrite(pvDaten, ulByte, &ulSchreibPosition)
		push rbp
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov rbp, rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulSchreibPosition[rsp], r9

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulByte[rsp]
		mov qword ptr [rax], rdx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr sdi_ulByte[rsp]
		add dword ptr COStream_ulBytes[rbp], eax
		mov rcx, qword ptr sqp_ulSchreibPosition[rsp]
		add dword ptr [rcx], eax

		lea rcx, COStream_csStream[rsp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)


	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?ThWrite@COStream@System@RePag@@QEAQXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_ulByte = 60 + s_push
sqp_ulSchreibPosition = 56 + s_push
sqp_vbElement = 48 + s_push
sqp_pvDaten = 40 + s_push
?ThWriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z PROC ; COStream::ThWriteS(pvDaten, ulByte, &ulSchreibPosition)
		push rbp
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov rbp, rcx
		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulSchreibPosition[rsp], r9

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr sdi_ulByte[rsp]
		mov qword ptr [rax], rdx
		mov qword ptr sqp_vbElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlockS@System@RePag@@YQPEADPEBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vbElement[rsp]
		mov qword ptr [rcx + 4], rax

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr sqp_pvDaten[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr sdi_ulByte[rsp]
		add dword ptr COStream_ulBytes[rbp], eax
		mov rcx, qword ptr sqp_ulSchreibPosition[rsp]
		add dword ptr [rcx], eax

		lea rcx, COStream_csStream[rsp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)


	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?ThWriteS@COStream@System@RePag@@QEAQXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sdi_ulEndPosition = 64 + s_push
sdi_ulByte = 56 + s_push
sqp_ulLesePosition = 48 + s_push
sqp_pvDaten = 40 + s_push
?Read@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z PROC ; COStream::Read(pvDaten, ulByte, &ulLesePosition)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulLesePosition[rsp], r9

		mov r9d, dword ptr [r9]
		mov edx, dword ptr COStream_ulBytes[rcx]
		cmp r9, rdx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Pruf_ulByte:
		add r9, r8
		cmp rdx, r9
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Kopf_Init:
		xor rax, rax
		mov dword ptr sdi_ulEndPosition[rsp], eax
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je Ende
		mov rdi, qword ptr COStream_COList_pvDaten[rbx] ; rdi -> ulElementLange
		mov edi, dword ptr [rdi]
		add dword ptr sdi_ulEndPosition[rsp], edi

		mov ecx, dword ptr sdi_ulEndPosition[rsp]
		mov rdx, qword ptr sqp_ulLesePosition[rsp]
		mov edx, dword ptr [rdx]
		cmp rcx, rdx
		jb Next_Element

		mov rsi, rcx ;  rsi -> ulNeuePosition
		mov rcx, qword ptr sqp_ulLesePosition[rsp]
		mov ecx, dword ptr [rcx]
		sub rsi, rcx
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Liste

		mov rcx, rdi
		sub rcx, rsi

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test rsi, rsi
		je short Fuss_Anfang
		mov rcx, rdi
		sub rcx, rsi

		mov r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov rbx, qword ptr [rbx]

		mov rdi, qword ptr COStream_COList_pvDaten[rbx]
		mov edi, dword ptr [rdi]

		mov rcx, rsi
		add rcx, rdi
		cmp dword ptr sdi_ulByte[rsp], ecx
		ja short Copy_ElementLange

		mov r8d, dword ptr sdi_ulByte[rsp]
		sub r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		mov r8, rdi
		mov rdx, qword ptr COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add rsi, rdi
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
		mov rbx, qword ptr [rbx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr sdi_ulByte[rsp]
		mov rcx, qword ptr sqp_ulLesePosition[rsp]
		add dword ptr [rcx], eax
		mov rax, qword ptr sqp_pvDaten[rsp]

	Ende:
		add rsp, s_ShadowRegister
		pop rdi
		pop rsi
		pop rbx
		ret
?Read@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sl_Bytes = 16

sdi_ulEndPosition = 64 + s_push + sl_Bytes
sdi_ulByte = 56 + s_push + sl_Bytes
sqp_ulLesePosition = 48 + s_push + sl_Bytes
sqp_pvDaten = 40 + s_push + sl_Bytes

sqp_this = 0 + s_ShadowRegister
?ThRead@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z PROC ; COStream::ThRead(pvDaten, ulByte, &ulLesePosition)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister + sl_Bytes

		mov dword ptr sdi_ulByte[rsp], r8d
		test r8d, r8d
		je Ende

		mov qword ptr sqp_pvDaten[rsp], rdx
		mov qword ptr sqp_ulLesePosition[rsp], r9
		mov qword ptr sqp_this[rsp], rcx

		mov rbx, rcx
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)
		mov rcx, rbx

		mov r9d, dword ptr [r9]
		mov edx, dword ptr COStream_ulBytes[rcx]
		cmp r9, rdx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Pruf_ulByte:
		add r9, r8
		cmp rdx, r9
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[rcx], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Kopf_Init:
		xor rax, rax
		mov dword ptr sdi_ulEndPosition[rsp], eax
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je Thread_Ende
		mov rdi, qword ptr COStream_COList_pvDaten[rbx] ; rdi -> ulElementLange
		mov edi, dword ptr [rdi]
		add dword ptr sdi_ulEndPosition[rsp], edi

		mov ecx, dword ptr sdi_ulEndPosition[rsp]
		mov rdx, qword ptr sqp_ulLesePosition[rsp]
		mov edx, dword ptr [rdx]
		cmp rcx, rdx
		jb Next_Element

		mov rsi, rcx ;  rsi -> ulNeuePosition
		mov rcx, qword ptr sqp_ulLesePosition[rsp]
		mov ecx, dword ptr [rcx]
		sub rsi, rcx
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Liste

		mov rcx, rdi
		sub rcx, rsi

		mov r8d, dword ptr sdi_ulByte[rsp]
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test rsi, rsi
		je short Fuss_Anfang
		mov rcx, rdi
		sub rcx, rsi

		mov r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		add rdx, rcx
		mov rcx, qword ptr sqp_pvDaten[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov rbx, qword ptr [rbx]

		mov rdi, qword ptr COStream_COList_pvDaten[rbx]
		mov edi, dword ptr [rdi]

		mov rcx, rsi
		add rcx, rdi
		cmp dword ptr sdi_ulByte[rsp], ecx
		ja short Copy_ElementLange

		mov r8d, dword ptr sdi_ulByte[rsp]
		sub r8, rsi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		mov r8, rdi
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_pvDaten[rsp]
		add rcx, rsi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add rsi, rdi
		cmp esi, dword ptr sdi_ulByte[rsp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
		mov rbx, qword ptr [rbx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr sdi_ulByte[rsp]
		mov rcx, qword ptr sqp_ulLesePosition[rsp]
		add dword ptr [rcx], eax
		mov rax, qword ptr sqp_pvDaten[rsp]

	Thread_Ende:
		mov rdx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rdx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

	Ende:
		add rsp, s_ShadowRegister + sl_Bytes
		pop rdi
		pop rsi
		pop rbx
		ret
?ThRead@COStream@System@RePag@@QEAQPEAXPEAXKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so8_cTime = 48
sqp_ptTime = 40
?ReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z PROC ; COStream::ReadTime(ptTime)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_ptTime[rsp], rdx

		mov r8, 8
		lea rdx, so8_cTime[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea rdx, so8_cTime[rsp]
		mov rcx, qword ptr sqp_ptTime[rsp]
		call ?Write@COTime@System@RePag@@QEAQXPEBD@Z ; COTime::Write(pcInhalt)

		mov rax, qword ptr sqp_ptTime[rsp]

		add rsp, s_ShadowRegister
		ret
?ReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so8_cTime = 48
sqp_ptTime = 40
?ThReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z PROC ; COStream::ThReadTime(ptTime)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_ptTime[rsp], rdx

		mov r8, 8
		lea rdx, so8_cTime[rsp]
		call ?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::ThRead(pvDaten, ulByte)

		lea rdx, so8_cTime[rsp]
		mov rcx, qword ptr sqp_ptTime[rsp]
		call ?Write@COTime@System@RePag@@QEAQXPEBD@Z ; COTime::Write(pcInhalt)

		mov rax, qword ptr sqp_ptTime[rsp]

		add rsp, s_ShadowRegister
		ret
?ThReadTime@COStream@System@RePag@@QEAQPEAVCOTime@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so8_cTime = 48
sqp_this = 40
?WriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z PROC ; COStream::WriteTime(ptTime)
		sub rsp, s_ShadowRegister
		
		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so8_cTime[rsp]
		call ?Read@COTime@System@RePag@@QEAQXPEAD@Z ; COTime::Read(pcContent)

		mov r8, 8
		lea rdx, so8_cTime[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?WriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so8_cTime = 48
sqp_this = 40
?ThWriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z PROC ; COStream::ThWriteTime(ptTime)
		sub rsp, s_ShadowRegister
		
		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so8_cTime[rsp]
		call ?Read@COTime@System@RePag@@QEAQXPEAD@Z ; COTime::Read(pcContent)

		mov r8, 8
		lea rdx, so8_cTime[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?ThWriteTime@COStream@System@RePag@@QEAQXPEAVCOTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so6_cNumber = 48
sqp_pk4Number = 40
?ReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z PROC ; COStream::ReadComma4(pk4Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_pk4Number[rsp], rdx

		mov r8, 6
		lea rdx, so6_cNumber[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea rdx, so6_cNumber[rsp]
		mov rcx, qword ptr sqp_pk4Number[rsp]
		call ?Write@COComma4@System@RePag@@QEAQXQEBD@Z ; COComma4::Write(cZahl[6])

		add rsp, s_ShadowRegister
		ret
?ReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so6_cNumber = 48
sqp_pk4Number = 40
?ThReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z PROC ; COStream::ThReadComma4(pk4Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_pk4Number[rsp], rdx

		mov r8, 6
		lea rdx, so6_cNumber[rsp]
		call ?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::ThRead(pvDaten, ulByte)

		lea rdx, so6_cNumber[rsp]
		mov rcx, qword ptr sqp_pk4Number[rsp]
		call ?Write@COComma4@System@RePag@@QEAQXQEBD@Z ; COComma4::Write(cZahl[6])

		add rsp, s_ShadowRegister
		ret
?ThReadComma4@COStream@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so6_cNumber = 48
sqp_this = 40
?WriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z PROC ; COStream::WriteComma4(pk4Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so6_cNumber[rsp]
		call ?Read@COComma4@System@RePag@@QEAQXQEBD@Z ; COComma4::Read(cZahl[6])

		mov r8, 6
		lea rdx, so6_cNumber[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?WriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so6_cNumber = 48
sqp_this = 40
?ThWriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z PROC ; COStream::ThWriteComma4(pk4Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so6_cNumber[rsp]
		call ?Read@COComma4@System@RePag@@QEAQXQEBD@Z ; COComma4::Read(cZahl[6])

		mov r8, 6
		lea rdx, so6_cNumber[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?ThWriteComma4@COStream@System@RePag@@QEAQXPEAVCOComma4@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so10_cNumber = 48
sqp_pk4_80Number = 40
?ReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z PROC ; COStream::ReadComma4_80(pk4_80Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_pk4_80Number[rsp], rdx

		mov r8, 10
		lea rdx, so10_cNumber[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea rdx, so10_cNumber[rsp]
		mov rcx, qword ptr sqp_pk4_80Number[rsp]
		call ?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z ; COComma4_80::Write(cZahl[10])

		add rsp, s_ShadowRegister
		ret
?ReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so10_cNumber = 48
sqp_pk4_80Number = 40
?ThReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z PROC ; COStream::ThLReadComma4_80(pk4_80Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_pk4_80Number[rsp], rdx

		mov r8, 10
		lea rdx, so10_cNumber[rsp]
		call ?ThRead@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::ThRead(pvDaten, ulByte)

		lea rdx, so10_cNumber[rsp]
		mov rcx, qword ptr sqp_pk4_80Number[rsp]
		call ?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z ; COComma4_80::Write(cZahl[10])

		add rsp, s_ShadowRegister
		ret
?ThReadComma4_80@COStream@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so10_cNumber = 48
sqp_this = 40
?WriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z PROC ; COStream::WriteComma4_80(pk4_80Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so10_cNumber[rsp]
		call ?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z ; COComma4_80::Read(cZahl[10])

		mov r8, 10
		lea rdx, so10_cNumber[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?WriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so10_cNumber = 48
sqp_this = 40
?ThWriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z PROC ; COStream::ThWriteComma4_80(pk4_80Number)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		mov rcx, rdx
		lea rdx, so10_cNumber[rsp]
		call ?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z ; COComma4_80::Read(cZahl[10])

		mov r8, 10
		lea rdx, so10_cNumber[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?ThWrite@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		ret
?ThWriteComma4_80@COStream@System@RePag@@QEAQXPEAVCOComma4_80@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Byte = 56
sqp_pasString = 48
sqp_this = 40
?ReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z PROC ; COStream::ReadStringA(pasString, ucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pasString[rsp], rdx

		cmp r8b, FT_SHORTSTR
		jne short MemoStr
		mov r8, 1
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, byte ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx rax, byte ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr
		mov r8, 2
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, word ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx rax, word ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		mov eax, dword ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		add rsp, s_ShadowRegister
		ret
?ReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ucStringTyp = 60
sdi_Byte = 56
sqp_pasString = 48
sqp_this = 40
?ThReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z PROC ; COStream::ThReadStringA(pasString, ucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pasString[rsp], rdx
		mov byte ptr sbi_ucStringTyp[rsp], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)
		mov rcx, qword ptr sqp_this[rsp]

		mov r8b, byte ptr sbi_ucStringTyp[rsp]
		cmp r8b, FT_SHORTSTR
		jne short MemoStr
		mov r8, 1
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, byte ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx rax, byte ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr
		mov r8, 2
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, word ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx rax, word ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr sdi_Byte[rsp] 
		mov rcx, qword ptr sqp_pasString[rsp]
		call ?SetLength@COStringA@System@RePag@@QEAQXK@Z ; COStringA::SetLength(ulStrLange)

		mov eax, dword ptr sdi_Byte[rsp] 
		mov r8, rax
		mov rdx, qword ptr sqp_pasString[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		ret
?ThReadStringA@COStream@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pasString = 48
sqp_this = 40
?WriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z PROC ; COStream::WriteStringA(pasString, ucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pasString[rsp], rdx

		cmp r8b, FT_SHORTSTR
		jne short MemoStr

		mov r8, 1 
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr

		mov r8, 2
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		add rsp, s_ShadowRegister
		ret
?WriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_ucStringTyp = 56
sqp_pasString = 48
sqp_this = 40
?ThWriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z PROC ; COStream::ThWriteStringA(pasString, ucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_pasString[rsp], rdx
		mov byte ptr sbi_ucStringTyp[rsp], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)
		mov rcx, qword ptr sqp_this[rsp]

		mov r8b, byte ptr sbi_ucStringTyp[rsp]
		cmp r8b, FT_SHORTSTR
		jne short MemoStr

		mov r8, 1 
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr

		mov r8, 2
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		mov rax, qword ptr sqp_pasString[rsp]
		lea rdx, COStringA_ulLange[rax]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rax, qword ptr sqp_pasString[rsp]
		mov r8d, dword ptr COStringA_ulLange[rax]
		mov rdx, qword ptr COStringA_vbInhalt[rax]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		ret
?ThWriteStringA@COStream@System@RePag@@QEAQXPEAVCOStringA@23@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Byte = 56
sqp_vbString = 48
sqp_this = 40
?ReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z PROC ; COStream::ReadCHAR(&vbString, ucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_vbString[rsp], rdx

		cmp r8b, FT_SHORTSTR
		jne short MemoStr
		mov r8, 1
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, byte ptr sdi_Byte[rsp]
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		movzx r8, byte ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr
		mov r8, 2
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, word ptr sdi_Byte[rsp] 
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		movzx r8, word ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr sdi_Byte[rsp] 
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		mov r8d, dword ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		add rsp, s_ShadowRegister
		ret
?ReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Byte = 56
sqp_vbString = 48
sqp_this = 40
?ThReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z PROC ; COStream::ThReadCHAR(&vbString, uucStringtyp)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_vbString[rsp], rdx
		mov byte ptr sbi_ucStringTyp[rsp], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)
		mov rcx, qword ptr sqp_this[rsp]

		movzx r8, byte ptr sbi_ucStringTyp[rsp]
		cmp r8b, FT_SHORTSTR
		jne short MemoStr
		mov r8, 1
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, byte ptr sdi_Byte[rsp]
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		movzx r8, byte ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr
		mov r8, 2
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx rdx, word ptr sdi_Byte[rsp] 
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		movzx r8, word ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov r8, 4
		lea rdx, sdi_Byte[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr sdi_Byte[rsp] 
		xor rcx, rcx
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rcx], rax

		mov r8d, dword ptr sdi_Byte[rsp] 
		mov rdx, rax
		mov rcx, qword ptr sqp_this[rsp]
		call ?Read@COStream@System@RePag@@QEAQPEAXPEAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		ret
?ThReadCHAR@COStream@System@RePag@@QEAQPEADAEAPEADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_Byte = 56 + s_push
sqp_vbString = 48 + s_push
sqp_this = 40 + s_push
?WriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z PROC ; COStream::WriteCHAR(pcString, ucStringtyp)
		push rdi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_vbString[rsp], rdx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -1
		sub rdx, rcx
		mov dword ptr sdi_Byte[rsp], edx

		cmp r8b, FT_SHORTSTR
		jne short MemoStr

		lea rdx, sdi_Byte[rsp]
		mov r8, 1
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr

		lea rdx, sdi_Byte[rsp]
		mov r8, 2
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		lea rdx, sdi_Byte[rsp]
		mov r8, 4
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov r8d, dword ptr sdi_Byte[rsp]
		mov rdx, qword ptr sqp_vbString[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		add rsp, s_ShadowRegister
		pop	rdi
		ret
?WriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sbi_ucStringTyp = 60 + s_push
sdi_Byte = 56 + s_push
sqp_vbString = 48 + s_push
sqp_this = 40 + s_push
?ThWriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z PROC ; COStream::ThWriteCHAR(pcString, ucStringtyp)
		push rdi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_vbString[rsp], rdx
		mov byte ptr sbi_ucStringTyp[rsp], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -1
		sub rdx, rcx
		mov dword ptr sdi_Byte[rsp], edx

		movzx r8, byte ptr sbi_ucStringTyp[rsp]
		cmp r8b, FT_SHORTSTR
		jne short MemoStr

		lea rdx, sdi_Byte[rsp]
		mov r8, 1
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp r8b, FT_MEMOSTR
		jne short LongStr

		lea rdx, sdi_Byte[rsp]
		mov r8, 2
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		lea rdx, sdi_Byte[rsp]
		mov r8, 4
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov r8d, dword ptr sdi_Byte[rsp]
		mov rdx, qword ptr sqp_vbString[rsp]
		mov rcx, qword ptr sqp_this[rsp]
		call ?Write@COStream@System@RePag@@QEAQXPEAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		pop	rdi
		ret
?ThWriteCHAR@COStream@System@RePag@@QEAQXPEADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 32

sqp_vstElement = 56 + s_push + s_Bytes
sdi_dwLastError = 48 + s_push + s_Bytes
sqp_hDatei = 40 + s_push + s_Bytes

sdi_dwBytes_Gelesen = 24 + s_ShadowRegister
sqi_llFileSize = 16 + s_ShadowRegister
sdi_BWait = 8 + s_ShadowRegister

aqp_pOverlapped = 0 + s_ShadowRegister
?ReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z PROC ; COStream::ReadFile(hDatei, pOverlapped, BWait)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hDatei[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr sdi_BWait[rsp], r9d

		mov dword ptr sdi_dwLastError[rsp], 6
		cmp rdx, -1
		je Ende

		mov rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqi_llFileSize[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetFileSizeEx ; GetFileSizeEx(hDatei, &liFileSize)
		test rax, rax
		jne short Block
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		jmp Ende

	Block:
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax
		mov rdx, qword ptr sqi_llFileSize[rsp]
		test rdx, rdx
		je Ende

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vstElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vstElement[rsp]
		mov qword ptr [rcx + 4], rax

		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test rax, rax
		jne short Liste

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp eax, 997
		jne short Error

		mov r9d, dword ptr sdi_BWait[rsp]
		lea r8, sdi_dwBytes_Gelesen[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test rax, rax
		je short Error

	Liste:
		mov rdx, qword ptr sqp_vstElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)
		mov rcx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr COStream_ulBytes[rbp], ecx
		mov dword ptr sdi_dwLastError[rsp], 0
		jmp short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 32

sqp_vstElement = 56 + s_push + s_Bytes
sdi_dwLastError = 48 + s_push + s_Bytes
sqp_hDatei = 40 + s_push + s_Bytes

sdi_dwBytes_Gelesen = 24 + s_ShadowRegister
sqi_llFileSize = 16 + s_ShadowRegister
sdi_BWait = 8 + s_ShadowRegister

aqp_pOverlapped = 0 + s_ShadowRegister
?ThReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z PROC ; COStream::ThReadFile(hDatei, pOverlapped, BWait)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hDatei[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr sdi_BWait[rsp], r9d

		mov dword ptr sdi_dwLastError[rsp], 6
		cmp rdx, -1
		je Ende

		mov rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqi_llFileSize[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetFileSizeEx ; GetFileSizeEx(hDatei, &liFileSize)
		test rax, rax
		jne short Block
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		jmp Ende

	Block:
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax
		mov rdx, qword ptr sqi_llFileSize[rsp]
		test rdx, rdx
		je Ende

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vstElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vstElement[rsp]
		mov qword ptr [rcx + 4], rax

		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test rax, rax
		jne short Liste

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp eax, 997
		jne short Error

		mov r9d, dword ptr sdi_BWait[rsp]
		lea r8, sdi_dwBytes_Gelesen[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test rax, rax
		je short Error

	Liste:
		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vstElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)
		mov rcx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr COStream_ulBytes[rbp], ecx
		mov dword ptr sdi_dwLastError[rsp], 0

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)
		jmp short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ThReadFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 64

sbi_bAsynchron = 64 + s_push + s_Bytes
sdi_dwBytes_Gelesen = 60 + s_push + s_Bytes
sqp_vstElement = 52 + s_push + s_Bytes
sdi_dwLastError = 48 + s_push + s_Bytes
sqp_hDatei = 40 + s_push + s_Bytes

sqi_llFileSize = 56 + s_ShadowRegister
sdi_BWait = 48 + s_ShadowRegister
so32_stOverlapped = 8 + s_ShadowRegister

qqp_pOverlapped = 0 + s_ShadowRegister
?ReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z PROC ; COStream::ReadFile(hFile, bAsynchronous)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hDatei[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr sdi_BWait[rsp], r9d
		mov byte ptr sbi_bAsynchron[rsp], r8b

		mov dword ptr sdi_dwLastError[rsp], 6
		cmp rdx, -1
		je Ende

		mov rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqi_llFileSize[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetFileSizeEx ; GetFileSizeEx(hDatei, &liFileSize)
		test rax, rax
		jne short Block
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		jmp Ende

	Block:
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax
		mov rdx, qword ptr sqi_llFileSize[rsp]
		test rdx, rdx
		je Ende

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vstElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vstElement[rsp]
		mov qword ptr [rcx + 4], rax

		movzx rdx, byte ptr sbi_bAsynchron[rsp]
		test rdx, rdx
		jne short Asynchron

		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je Error
		jmp Liste

	Asynchron:
		xor r9, r9
		xor r8, r8
		xor rdx, rdx
		xor rcx, rcx
		call qword ptr __imp_CreateEventA ; CreateEvent(NULL, false, false, NULL);
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr so32_stOverlapped[rsp], ymm5
		mov qword ptr so32_stOverlapped[rsp + 24], rax

		lea rdx, so32_stOverlapped[rsp]
		mov qword ptr aqp_pOverlapped[rsp], rdx
		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test rax, rax
		jne short Liste_Event
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov qword ptr sdi_dwLastError[rsp], rax
		cmp rax, 997
		jne short Error_Event

		mov r9, 1
		lea r8, sdi_dwBytes_Gelesen[rsp]
		lea rdx, so32_stOverlapped[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test rax, rax
		je short Error_Event

	Liste_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)

	Liste:
		mov rdx, qword ptr sqp_vstElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)
		mov rcx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr COStream_ulBytes[rbp], ecx
		xor rcx, rcx
		mov dword ptr sdi_dwLastError[rsp], ecx
		jmp short Ende

	Error_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 64

sbi_bAsynchron = 64 + s_push + s_Bytes
sdi_dwBytes_Gelesen = 60 + s_push + s_Bytes
sqp_vstElement = 52 + s_push + s_Bytes
sdi_dwLastError = 48 + s_push + s_Bytes
sqp_hDatei = 40 + s_push + s_Bytes

sqi_llFileSize = 56 + s_ShadowRegister
sdi_BWait = 48 + s_ShadowRegister
so32_stOverlapped = 8 + s_ShadowRegister

qqp_pOverlapped = 0 + s_ShadowRegister
?ThReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z PROC ; COStream::ThReadFile(hDatei, bAsynchronous)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hDatei[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr sdi_BWait[rsp], r9d
		mov byte ptr sbi_bAsynchron[rsp], r8b

		mov dword ptr sdi_dwLastError[rsp], 6
		cmp rdx, -1
		je Ende

		mov rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqi_llFileSize[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetFileSizeEx ; GetFileSizeEx(hDatei, &liFileSize)
		test rax, rax
		jne short Block
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		jmp Ende

	Block:
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax
		mov rdx, qword ptr sqi_llFileSize[rsp]
		test rdx, rdx
		je Ende

		mov rdx, 12
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr [rax], edx
		mov qword ptr sqp_vstElement[rsp], rax

		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vstElement[rsp]
		mov qword ptr [rcx + 4], rax

		movzx rdx, byte ptr sbi_bAsynchron[rsp]
		test rdx, rdx
		jne short Asynchron

		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je Error
		jmp Liste

	Asynchron:
		xor r9, r9
		xor r8, r8
		xor rdx, rdx
		xor rcx, rcx
		call qword ptr __imp_CreateEventA ; CreateEvent(NULL, false, false, NULL);
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr so32_stOverlapped[rsp], ymm5
		mov qword ptr so32_stOverlapped[rsp + 24], rax

		lea rdx, so32_stOverlapped[rsp]
		mov qword ptr aqp_pOverlapped[rsp], rdx
		lea r9, sdi_dwBytes_Gelesen[rsp]
		mov r8, qword ptr sqi_llFileSize[rsp]
		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_ReadFile ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test rax, rax
		jne short Liste_Event
		
		call qword ptr __imp_GetLastError ; GetLastError()
		mov qword ptr sdi_dwLastError[rsp], rax
		cmp rax, 997
		jne short Error_Event

		mov r9, 1
		lea r8, sdi_dwBytes_Gelesen[rsp]
		lea rdx, so32_stOverlapped[rsp]
		mov rcx, qword ptr sqp_hDatei[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test rax, rax
		je short Error_Event

	Liste_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)

	Liste:
		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vstElement[rsp]
		lea rcx, COStream_COList[rbp]
		call ?ToEnd@COList@System@RePag@@QEAQPEAXPEAX@Z ; ToEnd(pvDaten)
		mov rcx, qword ptr sqi_llFileSize[rsp]
		mov dword ptr COStream_ulBytes[rbp], ecx
		xor rcx, rcx
		mov dword ptr sdi_dwLastError[rsp], ecx

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)
		jmp short Ende

	Error_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rdx, qword ptr [rdx + 4]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov rdx, qword ptr sqp_vstElement[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ThReadFile@COStream@System@RePag@@QEAQKPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 16

adi_BWait = 64 + s_push + s_Bytes
sdi_dwLastError = 60 + s_push + s_Bytes
sdi_dwBytes_written = 56 + s_push + s_Bytes
sqp_vbDaten = 48 + s_push + s_Bytes
sqp_hFile = 40 + s_push + s_Bytes

aqp_pOverlapped = 0 + s_ShadowRegister
?WriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z PROC ; COStream::WriteFile(hFile, pOverlapped, BWait)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hFile[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr adi_BWait[rsp], r9d
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqp_vbDaten[rsp]
		call ?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ; COStream::Daten(&vbDaten)
		test rax, rax
		je Ende

		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		jne short Ende

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp rax, 997
		jne short Ende

		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		mov r9d, dword ptr adi_BWait[rsp]
		lea r8, sdi_dwBytes_written[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test rax, rax
		jne short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Ende:
		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?WriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 16

sdi_BWait = 64 + s_push + s_Bytes
sdi_dwLastError = 60 + s_push + s_Bytes
sdi_dwBytes_written = 56 + s_push + s_Bytes
sqp_vbDaten = 48 + s_push + s_Bytes
sqp_hFile = 40 + s_push + s_Bytes

aqp_pOverlapped = 0 + s_ShadowRegister
?ThWriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z PROC ; COStream::ThWriteFile(hFile, pOverlapped, BWait)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes

		mov rbp, rcx
		mov qword ptr sqp_hFile[rsp], rdx
		mov qword ptr aqp_pOverlapped[rsp], r8
		mov dword ptr sdi_BWait[rsp], r9d
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		lea rdx, sqp_vbDaten[rsp]
		mov rcx, rbp
		call ?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ; COStream::Daten(&vbDaten)
		test rax, rax
		je Ende

		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		jne short Ende

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp rax, 997
		jne short Ende

		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		mov r9d, dword ptr sdi_BWait[rsp]
		lea r8, sdi_dwBytes_written[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test rax, rax
		jne short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Ende:
		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ThWriteFile@COStream@System@RePag@@QEAQKPEAXPEAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 48

sbi_Asynchron = 64 + s_push + s_Bytes
sdi_dwLastError = 60 + s_push + s_Bytes
sdi_dwBytes_written = 56 + s_push + s_Bytes
sqp_vbDaten = 48 + s_push + s_Bytes
sqp_hFile = 40 + s_push + s_Bytes

so32_stOverlapped = 8 + s_ShadowRegister

aqp_pOverlapped = 0 + s_ShadowRegister
?WriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z PROC ; COStream::WriteFile(hFile, bAsynchronous)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes
		
		mov rbp, rcx
		mov qword ptr sqp_hFile[rsp], rdx
		mov byte ptr sbi_Asynchron[rsp], r8b
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rdx, sqp_vbDaten[rsp]
		call ?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ; COStream::Daten(&vbDaten)
		test rax, rax
		je Ende

		movzx rdx, byte ptr sbi_Asynchron[rsp]
		test rdx, rdx
		jne short Asynchron

		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		je Error
		jmp Ende

	Asynchron:
		xor r9, r9
		xor r8, r8
		xor rdx, rdx
		xor rcx, rcx
		call qword ptr __imp_CreateEventA ; CreateEvent(NULL, false, false, NULL);
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr so32_stOverlapped[rsp], ymm5
		mov qword ptr so32_stOverlapped[rsp + 24], rax
 
		lea rdx, so32_stOverlapped[rsp]
		mov qword ptr aqp_pOverlapped[rsp], rdx
		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		jne short Error_Last

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp rax, 997
		jne short Close_Event

		mov r9, 1
		lea r8, sdi_dwBytes_written[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test rax, rax
		jne short Close_Event

	Error_Last:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Close_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)
		jmp short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Ende:
		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?WriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_Bytes = 48

sbi_Asynchron = 64 + s_push + s_Bytes
sdi_dwLastError = 60 + s_push + s_Bytes
sdi_dwBytes_written = 56 + s_push + s_Bytes
sqp_vbDaten = 48 + s_push + s_Bytes
sqp_hFile = 40 + s_push + s_Bytes

so32_stOverlapped = 8 + s_ShadowRegister

aqp_pOverlapped = 0 + s_ShadowRegister
?ThWriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z PROC ; COStream::ThWriteFile(hFile, bAsynchronous)
		push rbp
		sub rsp, s_ShadowRegister + s_Bytes
		
		mov rbp, rcx
		mov qword ptr sqp_hFile[rsp], rdx
		mov byte ptr sbi_Asynchron[rsp], r8b
		xor rax, rax
		mov dword ptr sdi_dwLastError[rsp], eax

		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		lea rdx, sqp_vbDaten[rsp]
		mov rcx, rbp
		call ?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ; COStream::Daten(&vbDaten)
		test rax, rax
		je Ende

		movzx rdx, byte ptr sbi_Asynchron[rsp]
		test rdx, rdx
		jne short Asynchron

		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, rax
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		je Error
		jmp Ende

	Asynchron:
		xor r9, r9
		xor r8, r8
		xor rdx, rdx
		xor rcx, rcx
		call qword ptr __imp_CreateEventA ; CreateEvent(NULL, false, false, NULL);
		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr so32_stOverlapped[rsp], ymm5
		mov qword ptr so32_stOverlapped[rsp + 24], rax
 
		lea rdx, so32_stOverlapped[rsp]
		mov qword ptr aqp_pOverlapped[rsp], rdx
		lea r9, sdi_dwBytes_written[rsp]
		mov r8d, dword ptr COStream_ulBytes[rbp]
		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_WriteFile ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test rax, rax
		jne short Error_Last

		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax
		cmp rax, 997
		jne short Close_Event

		mov r9, 1
		lea r8, sdi_dwBytes_written[rsp]
		mov rdx, qword ptr aqp_pOverlapped[rsp]
		mov rcx, qword ptr sqp_hFile[rsp]
		call qword ptr __imp_GetOverlappedResult ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test rax, rax
		jne short Close_Event

	Error_Last:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Close_Event:
		mov rcx, qword ptr so32_stOverlapped[rsp + 24]
		call qword ptr __imp_CloseHandle ; CloseHandle(hHandle)
		jmp short Ende

	Error:
		call qword ptr __imp_GetLastError ; GetLastError()
		mov dword ptr sdi_dwLastError[rsp], eax

	Ende:
		lea rcx, COStream_csStream[rbp]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rdx, qword ptr sqp_vbDaten[rsp]
		mov rcx, qword ptr COStream_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr sdi_dwLastError[rsp]
		add rsp, s_ShadowRegister + s_Bytes
		pop rbp
		ret
?ThWriteFile@COStream@System@RePag@@QEAQKPEAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z PROC ; COStream::Data(&vbDaten)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister

		mov eax, dword ptr COStream_ulBytes[rcx]
		test rax, rax
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov rsi, rdx

		mov edx, COStream_ulBytes[rcx]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr [rsi], rax

		mov rcx, qword ptr sqp_this[rsp]
		xor rdi, rdi
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Ende

		mov rax, qword ptr COStream_COList_pvDaten[rbx]
		mov r8d, dword ptr [rax]
		mov rdx, qword ptr [rax + 4]
		mov rcx, qword ptr [rsi]
		add rcx, rdi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rax, qword ptr COStream_COList_pvDaten[rbx]
		add edi, dword ptr [rax]
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

	Ende:
		mov rax, qword ptr [rsi]
		add rsp, s_ShadowRegister
		pop rdi
		pop rsi
		pop rbx
		ret
?Data@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?ThData@COStream@System@RePag@@QEAQPEADAEAPEAD@Z PROC ; COStream::ThData(&vbDaten)
		push rbx
		push rsi
		push rdi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)
		mov rcx, qword ptr sqp_this[rsp]

		mov eax, dword ptr COStream_ulBytes[rcx]
		test rax, rax
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov rsi, rdx

		mov edx, COStream_ulBytes[rcx]
		mov rcx, qword ptr COStream_vmSpeicher[rcx]
		call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr [rsi], rax

		mov rcx, qword ptr sqp_this[rsp]
		xor rdi, rdi
		mov rbx, qword ptr COStream_COList_pstErster[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Ende

		mov rax, qword ptr COStream_COList_pvDaten[rbx]
		mov r8d, dword ptr [rax]
		mov rdx, qword ptr [rax + 4]
		mov rcx, qword ptr [rsi]
		add rcx, rdi
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rax, qword ptr COStream_COList_pvDaten[rbx]
		add edi, dword ptr [rax]
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

		mov rax, qword ptr [rsi]

	Ende:
		mov rcx, qword ptr sqp_this[rsp]
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		pop rdi
		pop rsi
		pop rbx
		ret
?ThData@COStream@System@RePag@@QEAQPEADAEAPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?Delete@COStream@System@RePag@@QEAQXXZ PROC ; COStream::Delete(void)
		push rbx
		push rdi
		push rsi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		mov rbx, COStream_COList_pstErster[rcx]
		mov rdi, qword ptr COStream_vmSpeicher[rcx]
		lea rsi, COStream_COList[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		add rdx, 04h
		mov rdx, qword ptr [rdx]

		mov rcx, rdi
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov r8, 1
		mov rdx, rbx
		mov rcx, rsi
		call ?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

	Ende:
		xor rax, rax
		mov rcx, qword ptr sqp_this[rsp]
		mov dword ptr COStream_ulBytes[rcx], eax
		mov dword ptr COStream_ulPosition[rcx], eax
		add rsp, s_ShadowRegister
		pop rsi
		pop rdi
		pop rbx
		ret
?Delete@COStream@System@RePag@@QEAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqp_this = 40 + s_push
?ThDelete@COStream@System@RePag@@QEAQXXZ PROC ; COStream::ThDelete(void)
		push rbx
		push rdi
		push rsi
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)
		mov rcx, qword ptr sqp_this[rsp]

		mov rbx, COStream_COList_pstErster[rcx]
		mov rdi, qword ptr COStream_vmSpeicher[rcx]
		lea rsi, COStream_COList[rcx]

	Kopf_Anfang:
		test rbx, rbx
		je short Ende
		mov rdx, qword ptr COStream_COList_pvDaten[rbx]
		add rdx, 04h
		mov rdx, qword ptr [rdx]

		mov rcx, rdi
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov r8, 1
		mov rdx, rbx
		mov rcx, rsi
		call ?DeleteFirstElementS@COList@System@RePag@@QEAQXAEAPEAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov rbx, qword ptr [rbx]
		jmp short Kopf_Anfang

	Ende:
		xor rax, rax
		mov rcx, qword ptr sqp_this[rsp]
		mov dword ptr COStream_ulBytes[rcx], eax
		mov dword ptr COStream_ulPosition[rcx], eax

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		pop rsi
		pop rdi
		pop rbx
		ret
?ThDelete@COStream@System@RePag@@QEAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?End@COStream@System@RePag@@QEAQ_NXZ PROC ; COStream::End(void)
		xor rax, rax
		mov edx, dword ptr COStream_ulPosition[rcx]
		cmp edx, dword ptr COStream_ulBytes[rcx]
		jb short Ende
		add rax, 1

	Ende:
		ret
?End@COStream@System@RePag@@QEAQ_NXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_bReturn = 48
sqp_this = 40
?ThEnd@COStream@System@RePag@@QEAQ_NXZ PROC ; COStream::ThEnde(void)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		xor rax, rax
		mov byte ptr sbi_bReturn[rsp], al
		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr COStream_ulPosition[rcx]
		cmp edx, dword ptr COStream_ulBytes[rcx]

		jb short Ende
		add byte ptr sbi_bReturn[rsp], 1

	Ende:
		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rax, qword ptr sbi_bReturn[rsp]
		add rsp, s_ShadowRegister
		ret
?ThEnd@COStream@System@RePag@@QEAQ_NXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Bytes@COStream@System@RePag@@QEAQKXZ PROC ; COStream::Bytes(void)
		mov eax, dword ptr COStream_ulBytes[rcx]
		ret
?Bytes@COStream@System@RePag@@QEAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_ulBytes = 48
sqp_this = 40
?ThBytes@COStream@System@RePag@@QEAQPEAKAEAK@Z PROC ; COStream::ThBytes(&ulBytes)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_ulBytes[rsp], rdx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr COStream_ulBytes[rcx]
		mov rax, qword ptr sqp_ulBytes[rsp]
		mov qword ptr [rax], rdx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rax, qword ptr sqp_ulBytes[rsp]
		add rsp, s_ShadowRegister
		ret
?ThBytes@COStream@System@RePag@@QEAQPEAKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Position@COStream@System@RePag@@QEAQKXZ PROC ; COStream::Position(void)
		mov eax, dword ptr COStream_ulPosition[rcx]
		ret
?Position@COStream@System@RePag@@QEAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_ulPosition = 48
sqp_this = 40
?ThPosition@COStream@System@RePag@@QEAQPEAKAEAK@Z PROC ; COStream::ThPosition(&ulPosition)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_ulPosition[rsp], rdx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr COStream_ulPosition[rcx]
		mov rax, qword ptr sqp_ulPosition[rsp]
		mov dword ptr [rax], edx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rax, qword ptr sqp_ulPosition[rsp]
		add rsp, s_ShadowRegister
		ret
?ThPosition@COStream@System@RePag@@QEAQPEAKAEAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?SetPosition@COStream@System@RePag@@QEAQKJD@Z PROC ; COStream::SetPosition(lAbstand, cVonWo)
		test r8b, r8b
		jg short VonEnde
		jl short VonAnfang

		mov eax, dword ptr COStream_ulPosition[rcx]
		add rax, rdx
		cmp eax, dword ptr COStream_ulBytes[rcx]
		jg short Error
		test rax, rax
		jl short Error
		add dword ptr COStream_ulPosition[rcx], edx
		jmp short Ende

	VonEnde:
		mov eax, dword ptr COStream_ulBytes[rcx]
		cmp rdx, rax
		jg short Error
		test rdx, rdx
		jl short Error
		sub rax, rdx
		mov dword ptr COStream_ulPosition[rcx], eax
		jmp short Ende

	VonAnfang:
		mov eax, dword ptr COStream_ulBytes[rcx]
		cmp rdx, rax
		jg short Error
		test rdx, rdx
		jl short Error
		mov dword ptr COStream_ulPosition[rcx], edx
		jmp short Ende

	Error:
		mov byte ptr COStream_ucInfo[rcx], 89

	Ende:
		mov eax, dword ptr COStream_ulPosition[rcx]
		ret
?SetPosition@COStream@System@RePag@@QEAQKJD@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sbi_cVonWo = 56
sdi_lAbstand = 48
sqp_this = 40
?ThSetPosition@COStream@System@RePag@@QEAQKJD@Z PROC ; COStream::ThSetPosition(lAbstand, cVonWo)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov dword ptr sdi_lAbstand[rsp], edx
		mov byte ptr sbi_cVonWo[rsp], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_EnterCriticalSection ; EnterCriticalSection(&csStream)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr sdi_lAbstand[rsp]
		mov r8b, byte ptr sbi_cVonWo[rsp]
		test r8b, r8b
		jg short VonEnde
		jl short VonAnfang

		mov eax, dword ptr COStream_ulPosition[rcx]
		add rax, rdx
		cmp eax, dword ptr COStream_ulBytes[rcx]
		jg short Error
		test rax, rax
		jl short Error
		add dword ptr COStream_ulPosition[rcx], edx
		jmp short Ende

	VonEnde:
		mov eax, dword ptr COStream_ulBytes[rcx]
		cmp rdx, rax
		jg short Error
		test rdx, rdx
		jl short Error
		sub rax, rdx
		mov dword ptr COStream_ulPosition[rcx], eax
		jmp short Ende

	VonAnfang:
		mov eax, dword ptr COStream_ulBytes[rcx]
		cmp rdx, rax
		jg short Error
		test rdx, rdx
		jl short Error
		mov dword ptr COStream_ulPosition[rcx], edx
		jmp short Ende

	Error:
		mov byte ptr COStream_ucInfo[rcx], 89

	Ende:
		mov eax, dword ptr COStream_ulPosition[rcx]

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		add rsp, s_ShadowRegister
		ret
?ThSetPosition@COStream@System@RePag@@QEAQKJD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?GetLastError@COStream@System@RePag@@QEAQEXZ PROC ; COStream::GetLastError(void)
		movzx rax, byte ptr COStream_ucInfo[rcx]
		xor rdx, rdx
		mov byte ptr COStream_ucInfo[rcx], dl
		ret
?GetLastError@COStream@System@RePag@@QEAQEXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_ucError = 48
sqp_this = 40
?ThGetLastError@COStream@System@RePag@@QEAQPEAEAEAE@Z PROC ; COStream::ThGetLastError(&ucError)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_ucError[rsp], rdx

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_TryEnterCriticalSection ; TryEnterCriticalSection(&csStream)

		mov rcx, qword ptr sqp_this[rsp]
		movzx rax, byte ptr COStream_ucInfo[rcx]
		mov rdx, qword ptr sqp_ucError[rsp]
		mov byte ptr [rdx], al
		xor r8, r8
		mov byte ptr COStream_ucInfo[rcx], r8b

		lea rcx, COStream_csStream[rcx]
		call qword ptr __imp_LeaveCriticalSection ; LeaveCriticalSection(&csStream)

		mov rax, qword ptr sqp_ucError[rsp]
		add rsp, s_ShadowRegister
		ret
?ThGetLastError@COStream@System@RePag@@QEAQPEAEAEAE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OStream ENDS
END