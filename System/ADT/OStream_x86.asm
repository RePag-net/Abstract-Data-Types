;/****************************************************************************
;  OStream_x86.asm
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
EXTRN __imp__GetFileSizeEx@8:PROC
EXTRN __imp__GetLastError@0:PROC
EXTRN __imp__ReadFile@20:PROC
EXTRN __imp__WriteFile@20:PROC
EXTRN __imp__GetOverlappedResult@16:PROC
EXTRN __imp__CreateEventA@16:PROC
EXTRN __imp__CloseHandle@4:PROC

EXTRN ?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z:PROC
EXTRN ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z:PROC
EXTRN ?ToEndS@COList@System@RePag@@QAQPAXPAX@Z:PROC
EXTRN ?Write@COTime@System@RePag@@QAQXPBD@Z:PROC
EXTRN ?Read@COTime@System@RePag@@QAQXPAD@Z:PROC
EXTRN ?Write@COComma4@System@RePag@@QAQXQBD@Z:PROC
EXTRN ?Read@COComma4@System@RePag@@QAQXQBD@Z:PROC
EXTRN ?Write@COComma4_80@System@RePag@@QAQXQBD@Z:PROC
EXTRN ?Read@COComma4_80@System@RePag@@QAQXQBD@Z:PROC
EXTRN ?SetLength@COStringA@System@RePag@@QAQXK@Z:PROC

.DATA
ucBY_COSTREAM DB 84
FT_SHORTSTR DB 1
FT_MEMOSTR DB 3

CS_OStream SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_bThreadSicher = 4
s_this = 0
?COStreamV@System@RePag@@YQPAVCOStream@12@_N@Z PROC ; COStreamV(bThreadSicher)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], cl

    movzx edx, ucBY_COSTREAM
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[eax], xmm7
		movdqu xmmword ptr COStream[eax + 16], xmm7
		movdqu xmmword ptr COStream[eax + 32], xmm7
		movdqu xmmword ptr COStream[eax + 48], xmm7
		movdqu xmmword ptr COStream[eax + 64], xmm7
		xor ecx, ecx
		mov dword ptr COStream_vmSpeicher[eax], ecx 
		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COStream_bThread[eax], cl
		test cl, cl
		je short Ende

		push 0
		lea ecx, COStream_csStream[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COStreamV@System@RePag@@YQPAVCOStream@12@_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_ulSpinCount = 8
s_bThreadSicher = 4
s_this = 0
?COStreamV@System@RePag@@YQPAVCOStream@12@_NK@Z PROC ; COStreamV(bThreadSicher, ulSpinCount)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], cl
		mov dword ptr s_ulSpinCount[esp], edx

    movzx edx, ucBY_COSTREAM
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[eax], xmm7
		movdqu xmmword ptr COStream[eax + 16], xmm7
		movdqu xmmword ptr COStream[eax + 32], xmm7
		movdqu xmmword ptr COStream[eax + 48], xmm7
		movdqu xmmword ptr COStream[eax + 64], xmm7
		xor ecx, ecx
		mov dword ptr COStream_vmSpeicher[eax], ecx 
		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COStream_bThread[eax], cl
		test cl, cl
		je short Ende

		push dword ptr s_ulSpinCount[esp]
		lea ecx, COStream_csStream[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COStreamV@System@RePag@@YQPAVCOStream@12@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_vmSpeicher = 8
s_bThreadSicher = 4
s_this = 0
?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_N@Z PROC ; COStreamV(vmSpeicher, bThreadSicher)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], dl
		mov dword ptr s_vmSpeicher[esp], ecx

    movzx edx, ucBY_COSTREAM
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[eax], xmm7
		movdqu xmmword ptr COStream[eax + 16], xmm7
		movdqu xmmword ptr COStream[eax + 32], xmm7
		movdqu xmmword ptr COStream[eax + 48], xmm7
		movdqu xmmword ptr COStream[eax + 64], xmm7

		mov ecx, dword ptr s_vmSpeicher[esp]
		mov dword ptr COStream_vmSpeicher[eax], ecx
		mov dword ptr COStream_COList_vmSpeicher[eax], ecx

		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COStream_bThread[eax], cl
		test cl, cl
		je short Ende

		push 0
		lea ecx, COStream_csStream[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 0
?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_vmSpeicher = 8
s_bThreadSicher = 4
s_this = 0
a_ulSpinCount = esp_Bytes + 4
?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_NK@Z PROC ; COStreamV(vmSpeicher, bThreadSicher, ulSpinCount)
		sub esp, esp_Bytes

		mov byte ptr s_bThreadSicher[esp], dl
		mov dword ptr s_vmSpeicher[esp], ecx

    movzx edx, ucBY_COSTREAM
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr s_this[esp], eax

		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[eax], xmm7
		movdqu xmmword ptr COStream[eax + 16], xmm7
		movdqu xmmword ptr COStream[eax + 32], xmm7
		movdqu xmmword ptr COStream[eax + 48], xmm7
		movdqu xmmword ptr COStream[eax + 64], xmm7

		mov ecx, dword ptr s_vmSpeicher[esp]
		mov dword ptr COStream_vmSpeicher[eax], ecx
		mov dword ptr COStream_COList_vmSpeicher[eax], ecx

		movzx ecx, byte ptr s_bThreadSicher[esp]
		mov byte ptr COStream_bThread[eax], cl
		test cl, cl
		je short Ende

		push dword ptr a_ulSpinCount[esp]
		lea ecx, COStream_csStream[eax]
		push ecx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
		mov eax, dword ptr s_this[esp]
		add esp, esp_Bytes
    ret 4
?COStreamV@System@RePag@@YQPAVCOStream@12@PBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_bThreadSicher = 4
??0COStream@System@RePag@@QAE@_N@Z PROC ; COStream::COStream(bThreadSicher)
		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[ecx], xmm7
		movdqu xmmword ptr COStream[ecx + 16], xmm7
		movdqu xmmword ptr COStream[ecx + 32], xmm7
		movdqu xmmword ptr COStream[ecx + 48], xmm7
		movdqu xmmword ptr COStream[ecx + 64], xmm7
		xor edx, edx
		mov dword ptr COStream_vmSpeicher[ecx], edx 
		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COStream_bThread[ecx], dl
		test dl, dl
		je short Ende

		push 0
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
    ret 4
??0COStream@System@RePag@@QAE@_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_bThreadSicher = 4
a_ulSpinCount = 8
??0COStream@System@RePag@@QAE@_NK@Z PROC ; COStream::COStream(bThreadSicher, ulSpinCount)
		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[ecx], xmm7
		movdqu xmmword ptr COStream[ecx + 16], xmm7
		movdqu xmmword ptr COStream[ecx + 32], xmm7
		movdqu xmmword ptr COStream[ecx + 48], xmm7
		movdqu xmmword ptr COStream[ecx + 64], xmm7
		xor edx, edx
		mov dword ptr COStream_vmSpeicher[ecx], edx 
		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COStream_bThread[ecx], dl
		test dl, dl
		je short Ende

		push dword ptr a_ulSpinCount[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
    ret 8
??0COStream@System@RePag@@QAE@_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_vmSpeicher = 4
a_bThreadSicher = 8
??0COStream@System@RePag@@QAE@PBX_N@Z PROC ; COStream::COStream(vmSpeicher, bThreadSicher)
		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[ecx], xmm7
		movdqu xmmword ptr COStream[ecx + 16], xmm7
		movdqu xmmword ptr COStream[ecx + 32], xmm7
		movdqu xmmword ptr COStream[ecx + 48], xmm7
		movdqu xmmword ptr COStream[ecx + 64], xmm7

		mov edx, dword ptr a_vmSpeicher[esp]
		mov dword ptr COStream_vmSpeicher[ecx], edx
		mov dword ptr COStream_COList_vmSpeicher[ecx], edx

		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COStream_bThread[ecx], dl
		test dl, dl
		je short Ende

		push 0
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
    ret 8
??0COStream@System@RePag@@QAE@PBX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_vmSpeicher = 4
a_bThreadSicher = 8
a_ulSpinCount = 12
??0COStream@System@RePag@@QAE@PBX_NK@Z PROC ; COStream::COStream(vmSpeicher, bThreadSicher, ulSpinCount)
		pxor xmm7, xmm7
		movdqu xmmword ptr COStream[ecx], xmm7
		movdqu xmmword ptr COStream[ecx + 16], xmm7
		movdqu xmmword ptr COStream[ecx + 32], xmm7
		movdqu xmmword ptr COStream[ecx + 48], xmm7
		movdqu xmmword ptr COStream[ecx + 64], xmm7

		mov edx, dword ptr a_vmSpeicher[esp]
		mov dword ptr COStream_vmSpeicher[ecx], edx
		mov dword ptr COStream_COList_vmSpeicher[ecx], edx

		movzx edx, byte ptr a_bThreadSicher[esp]
		mov byte ptr COStream_bThread[ecx], dl
		test dl, dl
		je short Ende

		mov edx, dword ptr a_ulSpinCount[esp]
		push dword ptr a_ulSpinCount[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__InitializeCriticalSectionAndSpinCount@8 ; InitializeCriticalSectionAndSpinCount(&csStream, ulSpinCount)

	Ende:
    ret 12
??0COStream@System@RePag@@QAE@PBX_NK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??1COStream@System@RePag@@QAE@XZ PROC ; COStream::~COStream(void)
		push ebp
		push ebx
		push edi
		push esi

		mov ebp, ecx
		mov ebx, COStream_COList_pstErster[ebp]
		mov edi, dword ptr COStream_vmSpeicher[ebp]
		lea esi, COStream_COList[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Kopf_Ende
		mov edx, dword ptr COStream_COList_pvDaten[ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		push 1
		mov edx, ebx
		mov ecx, esi
		call ?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Kopf_Ende:
		movzx eax, byte ptr COStream_bThread[ebp]
		test eax, eax
		je short Ende
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__DeleteCriticalSection@4 ; DeleteCrticalSection(&csIterator)

	Ende:
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
??1COStream@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
?COFreiV@COStream@System@RePag@@QAQPBXXZ PROC ; COStream::COFreiV(void)
		push ebp
		push ebx
		push edi
		push esi

		mov ebp, ecx
		mov ebx, COStream_COList_pstErster[ebp]
		mov edi, dword ptr COStream_vmSpeicher[ebp]
		lea esi, COStream_COList[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Kopf_Ende
		mov edx, dword ptr COStream_COList_pvDaten[ebx]

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		push 1
		mov edx, ebx
		mov ecx, esi
		call ?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Kopf_Ende:
		movzx eax, byte ptr COStream_bThread[ebp]
		test eax, eax
		je short Ende
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__DeleteCriticalSection@4 ; DeleteCrticalSection(&csIterator)

	Ende:
		mov eax, dword ptr COStream_vmSpeicher[ebp]
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
?COFreiV@COStream@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 8
?Write@COStream@System@RePag@@QAQXPAXK@Z PROC ; COStream::Write(pvDaten, ulByte)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		add dword ptr COStream_ulPosition[ebp], eax

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 4
?Write@COStream@System@RePag@@QAQXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 8
?WriteS@COStream@System@RePag@@QAQXPAXK@Z PROC ; COStream::WriteS(pvDaten, ulByte)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEndS@COList@System@RePag@@QAQPAXPAX@Z ; ToEndS(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		add dword ptr COStream_ulPosition[ebp], eax

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 4
?WriteS@COStream@System@RePag@@QAQXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 8
?ThWrite@COStream@System@RePag@@QAQXPAXK@Z PROC ; COStream::ThWrite(pvDaten, ulByte)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		add dword ptr COStream_ulPosition[ebp], eax

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 4
?ThWrite@COStream@System@RePag@@QAQXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 8
?ThWriteS@COStream@System@RePag@@QAQXPAXK@Z PROC ; COStream::ThWriteS(pvDaten, ulByte)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEndS@COList@System@RePag@@QAQPAXPAX@Z ; ToEndS(pvDaten)

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		add dword ptr COStream_ulPosition[ebp], eax

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 4
?ThWriteS@COStream@System@RePag@@QAQXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulEndPosition = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 20
?Read@COStream@System@RePag@@QAQPAXPAXK@Z PROC ; COStream::Read(pvDaten, ulByte)
		push ebp
		push ebp
		push esi
		push edi
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		xor eax, eax
		mov ecx, dword ptr COStream_ulPosition[ebp]
		mov edx, dword ptr COStream_ulBytes[ebp]
		cmp ecx, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Pruf_ulByte:
		add ecx, dword ptr a_ulByte[esp]
		cmp edx, ecx
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Kopf_Init:
		mov dword ptr s_ulEndPosition[esp], eax
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je Ende
		mov edi, dword ptr COList_pvDaten[ebx] ; edi -> ulElementLange
		mov edi, dword ptr [edi]
		add dword ptr s_ulEndPosition[esp], edi

		mov ecx, dword ptr s_ulEndPosition[esp]
		cmp ecx, dword ptr COStream_ulPosition[ebp]
		jb Next_Element

		mov esi, ecx ;  esi -> ulDifferenz
		sub esi, dword ptr COStream_ulPosition[ebp]
		cmp esi, dword ptr a_ulByte[esp]
		jb short Liste

		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push dword ptr a_ulByte[esp]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test esi, esi
		je short Fuss_Anfang
		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push esi
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov ebx, dword ptr [ebx]

		mov edi, dword ptr COList_pvDaten[ebx]
		mov edi, dword ptr [edi]

		mov ecx, esi
		add ecx, eax
		cmp dword ptr a_ulByte[esp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr a_ulByte[esp]
		sub eax, esi
		push eax
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		push edi
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add esi, edi
		cmp esi, dword ptr a_ulByte[esp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
	 	mov ebx, dword ptr [ebx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulPosition[ebp], eax
		mov eax, dword ptr s_pvDaten[esp]

	Ende:
		add esp, esp_Bytes
		pop edi
		pop esi
		pop ebx
		pop ebp
		ret 4
?Read@COStream@System@RePag@@QAQPAXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulEndPosition = 4
s_pvDaten = 0
a_ulByte = esp_Bytes + 20
?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z PROC ; COStream::ThRead(pvDaten, ulByte)
		push ebp
		push ebp
		push esi
		push edi
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		xor eax, eax
		mov ecx, dword ptr COStream_ulPosition[ebp]
		mov edx, dword ptr COStream_ulBytes[ebp]
		cmp ecx, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Pruf_ulByte:
		add ecx, dword ptr a_ulByte[esp]
		cmp edx, ecx
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Kopf_Init:
		mov dword ptr s_ulEndPosition[esp], eax
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je Thread_Ende
		mov edi, dword ptr COList_pvDaten[ebx] ; edi -> ulElementLange
		mov edi, dword ptr [edi]
		add dword ptr s_ulEndPosition[esp], edi

		mov ecx, dword ptr s_ulEndPosition[esp]
		cmp ecx, dword ptr COStream_ulPosition[ebp]
		jb Next_Element

		mov esi, ecx ;  esi -> ulDifferenz
		sub esi, dword ptr COStream_ulPosition[ebp]
		cmp esi, dword ptr a_ulByte[esp]
		jb short Liste

		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push dword ptr a_ulByte[esp]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test esi, esi
		je short Fuss_Anfang
		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push esi
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov ebx, dword ptr [ebx]

		mov edi, dword ptr COList_pvDaten[ebx]
		mov edi, dword ptr [edi]

		mov ecx, esi
		add ecx, eax
		cmp dword ptr a_ulByte[esp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr a_ulByte[esp]
		sub eax, esi
		push eax
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		push edi
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add esi, edi
		cmp esi, dword ptr a_ulByte[esp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
	 	mov ebx, dword ptr [ebx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulPosition[ebp], eax
		mov eax, dword ptr s_pvDaten[esp]

	Thread_Ende:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop edi
		pop esi
		pop ebx
		pop ebp
		ret 4
?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulSchreibPosition$ = esp_Bytes + 12
a_ulByte = esp_Bytes + 8
?Write@COStream@System@RePag@@QAQXPAXKAAK@Z PROC ; COStream::Write(pvDaten, ulByte, &ulSchreibPosition)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		mov ecx, dword ptr a_ulSchreibPosition$[esp]
		add dword ptr [ecx], eax

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 8
?Write@COStream@System@RePag@@QAQXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulSchreibPosition$ = esp_Bytes + 12
a_ulByte = esp_Bytes + 8
?WriteS@COStream@System@RePag@@QAQXPAXKAAK@Z PROC ; COStream::WriteS(pvDaten, ulByte, &ulSchreibPosition)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEndS@COList@System@RePag@@QAQPAXPAX@Z ; ToEndS(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		mov ecx, dword ptr a_ulSchreibPosition$[esp]
		add dword ptr [ecx], eax

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 8
?WriteS@COStream@System@RePag@@QAQXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulSchreibPosition$ = esp_Bytes + 12
a_ulByte = esp_Bytes + 8
?ThWrite@COStream@System@RePag@@QAQXPAXKAAK@Z PROC ; COStream::ThWrite(pvDaten, ulByte, &ulSchreibPosition)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		mov ecx, dword ptr a_ulSchreibPosition$[esp]
		add dword ptr [ecx], eax

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 8
?ThWrite@COStream@System@RePag@@QAQXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_vbElement = 4
s_pvDaten = 0
a_ulSchreibPosition$ = esp_Bytes + 12
a_ulByte = esp_Bytes + 8
?ThWriteS@COStream@System@RePag@@QAQXPAXKAAK@Z PROC ; COStream::ThWriteS(pvDaten, ulByte, &ulSchreibPosition)
		push ebp
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov edx, dword ptr a_ulByte[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vbElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlockS@System@RePag@@YQPADPBXK@Z ; VMBlockS(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vbElement[esp]
		mov dword ptr [ecx + 4], eax

		push dword ptr a_ulByte[esp]
		mov edx, dword ptr s_pvDaten[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_vbElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEndS@COList@System@RePag@@QAQPAXPAX@Z ; ToEndS(pvDaten)

		mov eax, dword ptr a_ulByte[esp]
		add dword ptr COStream_ulBytes[ebp], eax
		mov ecx, dword ptr a_ulSchreibPosition$[esp]
		add dword ptr [ecx], eax

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop ebp
		ret 8
?ThWriteS@COStream@System@RePag@@QAQXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulEndPosition = 4
s_pvDaten = 0
a_ulLesePosition = esp_Bytes + 24
a_ulByte = esp_Bytes + 20
?Read@COStream@System@RePag@@QAQPAXPAXKAAK@Z PROC ; COStream::Read(pvDaten, ulByte, &ulLesePosition)
		push ebp
		push ebp
		push esi
		push edi
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		xor eax, eax
		mov ecx, dword ptr a_ulLesePosition[esp]
		mov ecx, dword ptr [ecx]
		mov edx, dword ptr COStream_ulBytes[ebp]
		cmp ecx, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Pruf_ulByte:
		add ecx, dword ptr a_ulByte[esp]
		cmp edx, ecx
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Ende

	Kopf_Init:
		mov dword ptr s_ulEndPosition[esp], eax
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je Ende
		mov edi, dword ptr COList_pvDaten[ebx] ; edi -> ulElementLange
		mov edi, dword ptr [edi]
		add dword ptr s_ulEndPosition[esp], edi

		mov ecx, dword ptr s_ulEndPosition[esp]
		mov edx, dword ptr a_ulLesePosition[esp]
		mov edx, dword ptr [edx]
		cmp ecx, edx
		jb Next_Element

		mov esi, ecx ;  esi -> ulNeuePosition
		mov ecx, dword ptr a_ulLesePosition[esp]
		mov ecx, dword ptr [ecx]
		sub esi, ecx
		cmp esi, dword ptr a_ulByte[esp]
		jb short Liste

		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push dword ptr a_ulByte[esp]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test esi, esi
		je short Fuss_Anfang
		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push esi
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov ebx, dword ptr [ebx]

		mov edi, dword ptr COList_pvDaten[ebx]
		mov edi, dword ptr [edi]

		mov ecx, esi
		add ecx, eax
		cmp dword ptr a_ulByte[esp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr a_ulByte[esp]
		sub eax, esi
		push eax
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		push edi
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add esi, edi
		cmp esi, dword ptr a_ulByte[esp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
	 	mov ebx, dword ptr [ebx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr a_ulByte[esp]
		mov ecx, dword ptr a_ulLesePosition[esp]
		add dword ptr [ecx], eax
		mov eax, dword ptr s_pvDaten[esp]

	Ende:
		add esp, esp_Bytes
		pop edi
		pop esi
		pop ebx
		pop ebp
		ret 8
?Read@COStream@System@RePag@@QAQPAXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulEndPosition = 4
s_pvDaten = 0
a_ulLesePosition = esp_Bytes + 24
a_ulByte = esp_Bytes + 20
?ThRead@COStream@System@RePag@@QAQPAXPAXKAAK@Z PROC ; COStream::ThRead(pvDaten, ulByte, &ulLesePosition)
		push ebp
		push ebp
		push esi
		push edi
		sub esp, esp_Bytes

		mov eax, dword ptr a_ulByte[esp]
		test eax, eax
		je Ende

		mov ebp, ecx
		mov dword ptr s_pvDaten[esp], edx

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		xor eax, eax
		mov ecx, dword ptr a_ulLesePosition[esp]
		mov ecx, dword ptr [ecx]
		mov edx, dword ptr COStream_ulBytes[ebp]
		cmp ecx, edx
		jbe short Pruf_ulByte
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Pruf_ulByte:
		add ecx, dword ptr a_ulByte[esp]
		cmp edx, ecx
		jae short Kopf_Init
		mov byte ptr COStream_ucInfo[ebp], 89 ; STM_POSITIONSFEHLER
		jmp Thread_Ende

	Kopf_Init:
		mov dword ptr s_ulEndPosition[esp], eax
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je Thread_Ende
		mov edi, dword ptr COList_pvDaten[ebx] ; edi -> ulElementLange
		mov edi, dword ptr [edi]
		add dword ptr s_ulEndPosition[esp], edi

		mov ecx, dword ptr s_ulEndPosition[esp]
		mov edx, dword ptr a_ulLesePosition[esp]
		mov edx, dword ptr [edx]
		cmp ecx, edx
		jb Next_Element

		mov esi, ecx ;  esi -> ulNeuePosition
		mov ecx, dword ptr a_ulLesePosition[esp]
		mov ecx, dword ptr [ecx]
		sub esi, ecx
		cmp esi, dword ptr a_ulByte[esp]
		jb short Liste

		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push dword ptr a_ulByte[esp]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp Add_Position

	Liste:
		test esi, esi
		je short Fuss_Anfang
		mov ecx, edi
		sub ecx, esi

		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		add edx, ecx
		push esi
		mov ecx, dword ptr s_pvDaten[esp + 4]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Fuss_Anfang:
		mov ebx, dword ptr [ebx]

		mov edi, dword ptr COList_pvDaten[ebx]
		mov edi, dword ptr [edi]

		mov ecx, esi
		add ecx, eax
		cmp dword ptr a_ulByte[esp], ecx
		ja short Copy_ElementLange

		mov eax, dword ptr a_ulByte[esp]
		sub eax, esi
		push eax
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Differenz

	Copy_ElementLange:
		push edi
		mov edx, dword ptr COList_pvDaten[ebx]
		mov edx, dword ptr [edx + 4]
		mov ecx, dword ptr s_pvDaten[esp + 4]
		add ecx, esi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Differenz:
		add esi, edi
		cmp esi, dword ptr a_ulByte[esp]
		jb short Fuss_Anfang
		jmp short Add_Position

	Next_Element:
	 	mov ebx, dword ptr [ebx]
		jmp Kopf_Anfang

	Add_Position:
		mov eax, dword ptr a_ulByte[esp]
		mov ecx, dword ptr a_ulLesePosition[esp]
		add dword ptr [ecx], eax
		mov eax, dword ptr s_pvDaten[esp]

	Thread_Ende:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

	Ende:
		add esp, esp_Bytes
		pop edi
		pop esi
		pop ebx
		pop ebp
		ret 8
?ThRead@COStream@System@RePag@@QAQPAXPAXKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c8Time = 4
s_ptTime = 0
?ReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z PROC ; COStream::ReadTime(ptTime)
		sub esp, esp_Bytes

		mov dword ptr s_ptTime[esp], edx

		push 8
		lea edx, s_c8Time[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea edx, s_c8Time[esp]
		mov ecx, dword ptr s_ptTime[esp]
		call ?Write@COTime@System@RePag@@QAQXPBD@Z ; COTime::Write(pcInhalt)

		mov eax, dword ptr s_ptTime[esp]

		add esp, esp_Bytes
		ret 0
?ReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c8Time = 4
s_ptTime = 0
?ThReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z PROC ; COStream::ThReadTime(ptTime)
		sub esp, esp_Bytes

		mov dword ptr s_ptTime[esp], edx

		push 8
		lea edx, s_c8Time[esp + 4]
		call ?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::ThRead(pvDaten, ulByte)

		lea edx, s_c8Time[esp]
		mov ecx, dword ptr s_ptTime[esp]
		call ?Write@COTime@System@RePag@@QAQXPBD@Z ; COTime::Write(pcInhalt)

		mov eax, dword ptr s_ptTime[esp]

		add esp, esp_Bytes
		ret 0
?ThReadTime@COStream@System@RePag@@QAQPAVCOTime@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c8Time = 4
s_this = 0
?WriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z PROC ; COStream::WriteTime(ptTime)
		sub esp, esp_Bytes
		
		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c8Time[esp]
		call ?Read@COTime@System@RePag@@QAQXPAD@Z ; COTime::Read(pcContent)

		push 8
		lea edx, s_c8Time[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?WriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c8Time = 4
s_this = 0
?ThWriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z PROC ; COStream::ThWriteTime(ptTime)
		sub esp, esp_Bytes
		
		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c8Time[esp]
		call ?Read@COTime@System@RePag@@QAQXPAD@Z ; COTime::Read(pcContent)

		push 8
		lea edx, s_c8Time[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?ThWrite@COStream@System@RePag@@QAQXPAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?ThWriteTime@COStream@System@RePag@@QAQXPAVCOTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c6Number = 4
s_pk4Number = 0
?ReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z PROC ; COStream::ReadComma4(pk4Number)
		sub esp, esp_Bytes

		mov dword ptr s_pk4Number[esp], edx

		push 6
		lea edx, s_c6Number[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea edx, s_c6Number[esp]
		mov ecx, dword ptr s_pk4Number[esp]
		call ?Write@COComma4@System@RePag@@QAQXQBD@Z ; COComma4::Write(cZahl[6])

		add esp, esp_Bytes
		ret 0
?ReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c6Number = 4
s_pk4Number = 0
?ThReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z PROC ; COStream::ThReadComma4(pk4Number)
		sub esp, esp_Bytes

		mov dword ptr s_pk4Number[esp], edx

		push 6
		lea edx, s_c6Number[esp + 4]
		call ?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::ThRead(pvDaten, ulByte)

		lea edx, s_c6Number[esp]
		mov ecx, dword ptr s_pk4Number[esp]
		call ?Write@COComma4@System@RePag@@QAQXQBD@Z ; COComma4::Write(cZahl[6])

		add esp, esp_Bytes
		ret 0
?ThReadComma4@COStream@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c6Number = 4
s_this = 0
?WriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z PROC ; COStream::WriteComma4(pk4Number)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c6Number[esp]
		call ?Read@COComma4@System@RePag@@QAQXQBD@Z ; COComma4::Read(cZahl[6])

		push 6
		lea edx, s_c6Number[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?WriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c6Number = 4
s_this = 0
?ThWriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z PROC ; COStream::ThWriteComma4(pk4Number)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c6Number[esp]
		call ?Read@COComma4@System@RePag@@QAQXQBD@Z ; COComma4::Read(cZahl[6])

		push 6
		lea edx, s_c6Number[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?ThWrite@COStream@System@RePag@@QAQXPAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?ThWriteComma4@COStream@System@RePag@@QAQXPAVCOComma4@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_c10Number = 4
s_pk4_80Number = 0
?ReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z PROC ; COStream::ReadComma4_80(pk4_80Number)
		sub esp, esp_Bytes

		mov dword ptr s_pk4_80Number[esp], edx

		push 10
		lea edx, s_c10Number[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea edx, s_c10Number[esp]
		mov ecx, dword ptr s_pk4Number[esp]
		call ?Write@COComma4_80@System@RePag@@QAQXQBD@Z ; COComma4_80::Write(cZahl[10])

		add esp, esp_Bytes
		ret 0
?ReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_c10Number = 4
s_pk4_80Number = 0
?ThReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z PROC ; COStream::ThLReadComma4_80(pk4_80Number)
		sub esp, esp_Bytes

		mov dword ptr s_pk4_80Number[esp], edx

		push 10
		lea edx, s_c10Number[esp + 4]
		call ?ThRead@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		lea edx, s_c10Number[esp]
		mov ecx, dword ptr s_pk4Number[esp]
		call ?Write@COComma4_80@System@RePag@@QAQXQBD@Z ; COComma4_80::Write(cZahl[10])

		add esp, esp_Bytes
		ret 0
?ThReadComma4_80@COStream@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_c10Number = 4
s_this = 0
?WriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z PROC ; COStream::WriteComma4_80(pk4_80Number)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c10Number[esp]
		call ?Read@COComma4_80@System@RePag@@QAQXQBD@Z ; COComma4_80::Read(cZahl[10])

		push 10
		lea edx, s_c10Number[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?WriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_c10Number = 4
s_this = 0
?ThWriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z PROC ; COStream::ThWriteComma4_80(pk4_80Number)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx

		mov ecx, edx
		lea edx, s_c10Number[esp]
		call ?Read@COComma4_80@System@RePag@@QAQXQBD@Z ; COComma4_80::Read(cZahl[10])

		push 10
		lea edx, s_c10Number[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?ThWrite@COStream@System@RePag@@QAQXPAXK@Z ; COStream::ThWrite(pvDaten, ulByte)

		add esp, esp_Bytes
		ret 0
?ThWriteComma4_80@COStream@System@RePag@@QAQXPAVCOComma4_80@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_pasString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?ReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z PROC ; COStream::ReadStringA(pasString, ucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pasString[esp], edx

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr
    push 1
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, byte ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx eax, byte ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr
		push 2
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, word ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx eax, word ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		push 4
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		mov eax, dword ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		add esp, esp_Bytes
		ret 4
?ReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_pasString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?ThReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z PROC ; COStream::ThReadStringA(pasString, ucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pasString[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr
    push 1
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, byte ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx eax, byte ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr
		push 2
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, word ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		movzx eax, word ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		push 4
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr s_Byte[esp] 
		mov ecx, dword ptr s_pasString[esp]
		call ?SetLength@COStringA@System@RePag@@QAQXK@Z ; COStringA::SetLength(ulStrLange)

		mov eax, dword ptr s_Byte[esp] 
		push eax
		mov edx, dword ptr s_pasString[esp + 4]
		mov edx, dword ptr COStringA_vbInhalt[edx]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		mov ecx, dword ptr s_this[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)
		add esp, esp_Bytes
		ret 4
?ThReadStringA@COStream@System@RePag@@QAQPAVCOStringA@23@PAV423@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pasString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?WriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z PROC ; COStream::WriteStringA(pasString, ucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pasString[esp], edx

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr

		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 1 
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr

		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 2
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 4
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		add esp, esp_Bytes
		ret 4
?WriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pasString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?ThWriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z PROC ; COStream::ThWriteStringA(pasString, ucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_pasString[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr

		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 1
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr

		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 2
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		mov eax, dword ptr s_pasString[esp]
		lea edx, COStringA_ulLange[eax]
		push 4
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov eax, dword ptr s_pasString[esp]
		mov edx, dword ptr COStringA_ulLange[eax]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[eax]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov ecx, dword ptr s_this[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)
		add esp, esp_Bytes
		ret 4
?ThWriteStringA@COStream@System@RePag@@QAQXPAVCOStringA@23@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_vbString$ = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?ReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z PROC ; COStream::ReadCHAR(&vbString, ucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_vbString$[esp], edx

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr
    push 1
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, byte ptr s_Byte[esp]
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		movzx ecx, byte ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr
		push 2
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, word ptr s_Byte[esp] 
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		movzx ecx, word ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		push 4
		lea edx, s_Byte[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr s_Byte[esp] 
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		mov ecx, dword ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		add esp, esp_Bytes
		ret 4
?ReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_vbString$ = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 4
?ThReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z PROC ; COStream::ThReadCHAR(&vbString, uucStringtyp)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_vbString$[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr
    push 1
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, byte ptr s_Byte[esp]
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		movzx ecx, byte ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr
		push 2
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		movzx edx, word ptr s_Byte[esp] 
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		movzx ecx, word ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		push 4
		lea edx, s_Byte[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

		mov edx, dword ptr s_Byte[esp] 
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_vbString$[esp]
		mov dword ptr [ecx], eax

		mov ecx, dword ptr s_Byte[esp] 
		push ecx
		mov edx, eax
		mov ecx, dword ptr s_this[esp + 4]
		call ?Read@COStream@System@RePag@@QAQPAXPAXK@Z ; COStream::Read(pvDaten, ulByte)

	Ende:
		mov ecx, dword ptr s_this[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)
		add esp, esp_Bytes
		ret 4
?ThReadCHAR@COStream@System@RePag@@QAQPADAAPADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_vbString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 8
?WriteCHAR@COStream@System@RePag@@QAQXPADE@Z PROC ; COStream::WriteCHAR(pcString, ucStringtyp)
		push edi
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_vbString[esp], edx

		xor al, al
    mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -1
		sub edx, ecx
		mov dword ptr s_Byte[esp], edx

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr

		lea edx, s_Byte[esp]
		push 1
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr

		lea edx, s_Byte[esp]
		push 2
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		lea edx, s_Byte[esp]
		push 4
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov edx, dword ptr s_Byte[esp]
		push edx
		mov edx, dword ptr s_vbString[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		add esp, esp_Bytes
		pop	edi
		ret 4
?WriteCHAR@COStream@System@RePag@@QAQXPADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_Byte = 8
s_vbString = 4
s_this = 0
a_ucStringtyp = esp_Bytes + 8
?ThWriteCHAR@COStream@System@RePag@@QAQXPADE@Z PROC ; COStream::ThWriteCHAR(pcString, ucStringtyp)
		push edi
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_vbString[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		xor al, al
    mov edi, dword ptr s_vbString[esp]
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -1
		sub edx, ecx
		mov dword ptr s_Byte[esp], edx

		movzx eax, byte ptr a_ucStringtyp[esp]
		cmp al, FT_SHORTSTR
		jne short MemoStr

		lea edx, s_Byte[esp]
		push 1
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	MemoStr:
		cmp al, FT_MEMOSTR
		jne short LongStr

		lea edx, s_Byte[esp]
		push 2
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)
		jmp short Ende

	LongStr:
		lea edx, s_Byte[esp]
		push 4
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

	Ende:
		mov edx, dword ptr s_Byte[esp]
		push edx
		mov edx, dword ptr s_vbString[esp + 4]
		mov ecx, dword ptr s_this[esp + 4]
		call ?Write@COStream@System@RePag@@QAQXPAXK@Z ; COStream::Write(pvDaten, ulByte)

		mov ecx, dword ptr s_this[esp]
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		add esp, esp_Bytes
		pop	edi
		ret 4
?ThWriteCHAR@COStream@System@RePag@@QAQXPADE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 24
s_dwBytes_Gelesen = 20
s_vstElement = 16
s_liFileSize = 8
s_dwLastError = 4
s_hDatei = 0
a_BWait = esp_Bytes + 12
a_pOverlapped = esp_Bytes + 8
?ReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z PROC ; COStream::ReadFile(hDatei, pOverlapped, BWait)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hDatei[esp], edx

		mov dword ptr s_dwLastError[esp], 6
		cmp edx, -1
		je Ende

		mov dword ptr s_dwLastError[esp], 0

		lea eax, dword ptr s_liFileSize[esp]
		push eax
		push dword ptr s_hDatei[esp + 4]
		call dword ptr __imp__GetFileSizeEx@8 ; GetFileSizeEx(hDatei, &liFileSize)
		test eax, eax
		jne short Block
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		jmp Ende

	Block:
		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr s_liFileSize[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vstElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vstElement[esp]
		mov dword ptr [ecx + 4], eax

		mov edx, dword ptr a_pOverlapped[esp]
		test edx, edx
		jne short Overlapped

		push 0
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je short Error
		jmp short Liste

	Overlapped:
		push dword ptr a_pOverlapped[esp]
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		jne short Liste
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hDatei[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test eax, eax
		je short Error

	Liste:
		mov edx, dword ptr s_vstElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)
		mov ecx, dword ptr s_liFileSize[esp]
		mov dword ptr COStream_ulBytes[ebp], ecx
		mov dword ptr s_dwLastError[esp], 0
		jmp short Ende

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

		mov edx, dword ptr s_vstElement[esp]
		mov edx, dword ptr [edx + 4]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vstElement[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 8
?ReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 24
s_dwBytes_Gelesen = 20
s_vstElement = 16
s_liFileSize = 8
s_dwLastError = 4
s_hDatei = 0
a_BWait = esp_Bytes + 12
a_pOverlapped = esp_Bytes + 8
?ThReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z PROC ; COStream::ThReadFile(hDatei, pOverlapped, BWait)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hDatei[esp], edx

		mov dword ptr s_dwLastError[esp], 6
		cmp edx, -1
		je Ende

		mov dword ptr s_dwLastError[esp], 0

		lea eax, dword ptr s_liFileSize[esp]
		push eax
		push dword ptr s_hDatei[esp + 4]
		call dword ptr __imp__GetFileSizeEx@8 ; GetFileSizeEx(hDatei, &liFileSize)
		test eax, eax
		jne short Block
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		jmp Ende

	Block:
		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr s_liFileSize[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vstElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vstElement[esp]
		mov dword ptr [ecx + 4], eax

		mov edx, dword ptr a_pOverlapped[esp]
		test edx, edx
		jne short Overlapped

		push 0
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je short Error
		jmp short Liste

	Overlapped:
		push dword ptr a_pOverlapped[esp]
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		jne short Liste
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hDatei[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test eax, eax
		je short Error

	Liste:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_vstElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)
		mov ecx, dword ptr s_liFileSize[esp]
		mov dword ptr COStream_ulBytes[ebp], ecx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)
		jmp short Ende

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

		mov edx, dword ptr s_vstElement[esp]
		mov edx, dword ptr [edx + 4]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vstElement[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 8
?ThReadFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 44
s_stOverlapped = 24
s_dwBytes_Gelesen = 20
s_vstElement = 16
s_liFileSize = 8
s_dwLastError = 4
s_hDatei = 0
a_bAsynchronous = esp_Bytes + 8
?ReadFile@COStream@System@RePag@@QAQKPAX_N@Z PROC ; COStream::ReadFile(hFile, bAsynchronous)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hDatei[esp], edx

		mov dword ptr s_dwLastError[esp], 6
		cmp edx, -1
		je Ende

		mov dword ptr s_dwLastError[esp], 0

		lea eax, dword ptr s_liFileSize[esp]
		push eax
		push dword ptr s_hDatei[esp + 4]
		call dword ptr __imp__GetFileSizeEx@8 ; GetFileSizeEx(hDatei, &liFileSize)
		test eax, eax
		jne short Block
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		jmp Ende

	Block:
		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr s_liFileSize[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vstElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vstElement[esp]
		mov dword ptr [ecx + 4], eax

		mov edx, dword ptr a_bAsynchronous[esp]
		test edx, edx
		jne short Asynchron

		push 0
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je Error
		jmp short Liste

	Asynchron:
		PXOR xmm7, xmm7
		movdqu xmmword ptr s_stOverlapped[esp], xmm7
		push 0
		push 0
		push 0
		push 0
		call dword ptr __imp__CreateEventA@16 ; CreateEvent(NULL, false, false, NULL);
		mov dword ptr s_stOverlapped[esp + 16], eax

		lea edx, s_stOverlapped[esp]
		push edx
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		mov eax, dword ptr s_vstElement[esp + 12]
		mov eax, dword ptr [eax + 4]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		jne short Liste_Event
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error_Event

		push 1
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hDatei[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test eax, eax
		je short Error_Event

	Liste_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Liste:
		mov edx, dword ptr s_vstElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)
		mov ecx, dword ptr s_liFileSize[esp]
		mov dword ptr COStream_ulBytes[ebp], ecx
		mov dword ptr s_dwLastError[esp], 0
		jmp short Ende

	Error_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

		mov edx, dword ptr s_vstElement[esp]
		mov edx, dword ptr [edx + 4]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vstElement[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 4
?ReadFile@COStream@System@RePag@@QAQKPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 44
s_stOverlapped = 24
s_dwBytes_Gelesen = 20
s_vstElement = 16
s_liFileSize = 8
s_dwLastError = 4
s_hDatei = 0
a_bAsynchronous = esp_Bytes + 8
?ThReadFile@COStream@System@RePag@@QAQKPAX_N@Z PROC ; COStream::ThReadFile(hDatei, bAsynchronous)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hDatei[esp], edx

		mov dword ptr s_dwLastError[esp], 6
		cmp edx, -1
		je Ende

		mov dword ptr s_dwLastError[esp], 0

		lea eax, dword ptr s_liFileSize[esp]
		push eax
		push dword ptr s_hDatei[esp + 4]
		call dword ptr __imp__GetFileSizeEx@8 ; GetFileSizeEx(hDatei, &liFileSize)
		test eax, eax
		jne short Block
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		jmp Ende

	Block:
		mov edx, 8
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr s_liFileSize[esp]
		mov dword ptr [eax], edx
		mov dword ptr s_vstElement[esp], eax

		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_vstElement[esp]
		mov dword ptr [ecx + 4], eax

		mov edx, dword ptr a_bAsynchronous[esp]
		test edx, edx
		jne short Asynchron

		push 0
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		je Error
		jmp short Liste

	Asynchron:
		PXOR xmm7, xmm7
		movdqu xmmword ptr s_stOverlapped[esp], xmm7
		push 0
		push 0
		push 0
		push 0
		call dword ptr __imp__CreateEventA@16 ; CreateEvent(NULL, false, false, NULL);
		mov dword ptr s_stOverlapped[esp + 16], eax

		lea edx, s_stOverlapped[esp]
		push edx
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr s_liFileSize[esp + 8]
		mov eax, dword ptr s_vstElement[esp + 12]
		mov eax, dword ptr [eax + 4]
		push eax
		push dword ptr s_hDatei[esp + 16]
		call dword ptr __imp__ReadFile@20 ; ReadFile(hDatei, vbDaten, dwBytes, &dwBytes_Gelesen, pOverlapped)
		test eax, eax
		jne short Liste_Event
		
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error_Event

		push 1
		lea ecx, s_dwBytes_Gelesen[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hDatei[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hDatei, pOverlapped, &dwBytes_Gelesen, BWait)
		test eax, eax
		je short Error_Event

	Liste_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Liste:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_vstElement[esp]
		lea ecx, COStream_COList[ebp]
		call ?ToEnd@COList@System@RePag@@QAQPAXPAX@Z ; ToEnd(pvDaten)
		mov ecx, dword ptr s_liFileSize[esp]
		mov dword ptr COStream_ulBytes[ebp], ecx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)
		jmp short Ende

	Error_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

		mov edx, dword ptr s_vstElement[esp]
		mov edx, dword ptr [edx + 4]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vstElement[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 4
?ThReadFile@COStream@System@RePag@@QAQKPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_vbDaten = 12
s_dwBytes_written = 8
s_dwLastError = 4
s_hFile = 0
a_BWait = esp_Bytes + 12
a_pOverlapped = esp_Bytes + 8
?WriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z PROC ; COStream::WriteFile(hFile, pOverlapped, BWait)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hFile[esp], edx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, s_vbDaten[esp]
		call ?Data@COStream@System@RePag@@QAQPADAAPAD@Z ; COStream::Daten(&vbDaten)
		test eax, eax
		je Ende

		mov edx, dword ptr a_pOverlapped[esp]
		test edx, edx
		jne short Overlapped

		 push 0
		 lea ecx, s_dwBytes_written[esp + 4]
		 push ecx
		 push dword ptr COStream_ulBytes[ebp]
		 push eax
		 push dword ptr s_hFile[esp + 16]
		 call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		 test eax, eax
		 je short Error
		 jmp short Ende

	Overlapped:
		 push dword ptr a_pOverlapped[esp]
		 lea ecx, s_dwBytes_written[esp + 4]
		 push ecx
		 push dword ptr COStream_ulBytes[ebp]
		 push eax
		 push dword ptr s_hFile[esp + 16]
		 call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		 test eax, eax
		 jne short Ende

		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Ende

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hFile[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test eax, eax
		jne short Ende

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

	Ende:
		mov edx, dword ptr s_vbDaten[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 8
?WriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_vbDaten = 12
s_dwBytes_written = 8
s_dwLastError = 4
s_hFile = 0
a_BWait = esp_Bytes + 12
a_pOverlapped = esp_Bytes + 8
?ThWriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z PROC ; COStream::ThWriteFile(hFile, pOverlapped, BWait)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx
		mov dword ptr s_hFile[esp], edx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		lea edx, s_vbDaten[esp]
		lea ecx, COStream[ebp]
		call ?Data@COStream@System@RePag@@QAQPADAAPAD@Z ; COStream::Daten(&vbDaten)
		test eax, eax
		je Ende

		mov edx, dword ptr a_pOverlapped[esp]
		test edx, edx
		jne short Overlapped

		push 0
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push eax
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		je short Error
		jmp short Ende
		
	Overlapped:
		push dword ptr a_pOverlapped[esp]
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push eax
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		jne short Ende

		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Ende

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hFile[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test eax, eax
		jne short Ende

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

	Ende:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov edx, dword ptr s_vbDaten[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 8
?ThWriteFile@COStream@System@RePag@@QAQKPAXPAU_OVERLAPPED@@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 36
s_stOverlapped = 16
s_vbDaten = 12
s_dwBytes_written = 8
s_dwLastError = 4
s_hFile = 0
a_bAsynchronous = esp_Bytes + 8
?WriteFile@COStream@System@RePag@@QAQKPAX_N@Z PROC ; COStream::WriteFile(hFile, bAsynchronous)
		push ebp
		sub esp, esp_Bytes
		
		mov ebp, ecx
		mov dword ptr s_hFile[esp], edx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, s_vbDaten[esp]
		call ?Data@COStream@System@RePag@@QAQPADAAPAD@Z ; COStream::Daten(&vbDaten)
		test eax, eax
		je Ende

		mov edx, dword ptr a_bAsynchronous[esp]
		test edx, edx
		jne short Asynchron

		push 0
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push eax
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		je short Error
		jmp short Ende

	Asynchron:
		PXOR xmm7, xmm7
		movdqu xmmword ptr s_stOverlapped[esp], xmm7
		push 0
		push 0
		push 0
		push 0
		call dword ptr __imp__CreateEventA@16 ; CreateEvent(NULL, false, false, NULL);
		mov dword ptr s_stOverlapped[esp + 16], eax

		lea edx, s_stOverlapped[esp]
		push edx
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push dword ptr s_vbDaten[esp + 12]
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		jne short Ende

		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error_Event

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hFile[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test eax, eax
		jne short Ende

	Error_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

	Ende:
		mov edx, dword ptr s_vbDaten[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 4
?WriteFile@COStream@System@RePag@@QAQKPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 36
s_stOverlapped = 16
s_vbDaten = 12
s_dwBytes_written = 8
s_dwLastError = 4
s_hFile = 0
a_bAsynchronous = esp_Bytes + 8
?ThWriteFile@COStream@System@RePag@@QAQKPAX_N@Z PROC ; COStream::ThWriteFile(hFile, bAsynchronous)
		push ebp
		sub esp, esp_Bytes
		
		mov ebp, ecx
		mov dword ptr s_hFile[esp], edx
		mov dword ptr s_dwLastError[esp], 0

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		lea edx, s_vbDaten[esp]
		lea ecx, COStream[ebp]
		call ?Data@COStream@System@RePag@@QAQPADAAPAD@Z ; COStream::Daten(&vbDaten)
		test eax, eax
		je Ende

		mov edx, dword ptr a_bAsynchronous[esp]
		test edx, edx
		jne short Asynchron

		push 0
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push eax
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		je short Error
		jmp short Ende

	Asynchron:
		PXOR xmm7, xmm7
		movdqu xmmword ptr s_stOverlapped[esp], xmm7
		push 0
		push 0
		push 0
		push 0
		call dword ptr __imp__CreateEventA@16 ; CreateEvent(NULL, false, false, NULL);
		mov dword ptr s_stOverlapped[esp + 16], eax

		lea edx, s_stOverlapped[esp]
		push edx
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr COStream_ulBytes[ebp]
		push dword ptr s_vbDaten[esp + 12]
		push dword ptr s_hFile[esp + 16]
		call dword ptr __imp__WriteFile@20 ; WriteFile(hFile, vbDaten, ulBytes, &dwBytes_written, pOverlapped)
		test eax, eax
		jne short Ende

		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax
		cmp eax, 997
		jne short Error_Event

		push dword ptr a_BWait[esp]
		lea ecx, s_dwBytes_written[esp + 4]
		push ecx
		push dword ptr a_pOverlapped[esp + 8]
		push dword ptr s_hFile[esp + 12]
		call dword ptr __imp__GetOverlappedResult@16 ; GetOverlappedResult(hFile, pOverlapped, &dwBytes_return, BWait)
		test eax, eax
		jne short Ende

	Error_Event:
		push dword ptr s_stOverlapped[esp + 16]
		call dword ptr __imp__CloseHandle@4 ; CloseHandle(hHandle)

	Error:
		call dword ptr __imp__GetLastError@0 ; GetLastError()
		mov dword ptr s_dwLastError[esp], eax

	Ende:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov edx, dword ptr s_vbDaten[esp]
    mov ecx, dword ptr COStream_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_dwLastError[esp]
		add esp, esp_Bytes
		pop ebp
		ret 4
?ThWriteFile@COStream@System@RePag@@QAQKPAX_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Data@COStream@System@RePag@@QAQPADAAPAD@Z PROC ; COStream::Data(&vbDaten)
		push ebp
		push ebx
		push edi
		push esi

		mov eax, dword ptr COStream_ulBytes[ecx]
		test eax, eax
		je short Ende

		mov ebp, ecx
		mov esi, edx

		mov edx, COStream_ulBytes[ebp]
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr [esi], eax

		xor edi, edi
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Ende

		mov eax, dword ptr COStream_COList_pvDaten[ebx]
		mov edx, dword ptr [eax]
		push edx
		mov edx, dword ptr [eax + 4]
		mov ecx, dword ptr [esi]
		add ecx, edi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov eax, dword ptr COStream_COList_pvDaten[ebx]
		add edi, dword ptr [eax]
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Ende:
		mov eax, dword ptr [esi]
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
?Data@COStream@System@RePag@@QAQPADAAPAD@Z ENDP
;----------------------------------------------------------------------------
?ThData@COStream@System@RePag@@QAQPADAAPAD@Z PROC ; COStream::ThData(&vbDaten)
		push ebp
		push ebx
		push edi
		push esi

		mov ebp, ecx
		mov esi, edx

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		mov eax, dword ptr COStream_ulBytes[ebp]
		test eax, eax
		je short Ende

		mov edx, COStream_ulBytes[ebp]
		mov ecx, dword ptr COStream_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr [esi], eax

		xor edi, edi
		mov ebx, dword ptr COStream_COList_pstErster[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Ende

		mov eax, dword ptr COStream_COList_pvDaten[ebx]
		mov edx, dword ptr [eax]
		push edx
		mov edx, dword ptr [eax + 4]
		mov ecx, dword ptr [esi]
		add ecx, edi
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov eax, dword ptr COStream_COList_pvDaten[ebx]
		add edi, dword ptr [eax]
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Ende:
		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov eax, dword ptr [esi]
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
?ThData@COStream@System@RePag@@QAQPADAAPAD@Z ENDP
;----------------------------------------------------------------------------
?Delete@COStream@System@RePag@@QAQXXZ PROC ; COStream::Delete(void)
		push ebp
		push ebx
		push edi
		push esi

		mov ebp, ecx
		mov ebx, COStream_COList_pstErster[ebp]
		mov edi, dword ptr COStream_vmSpeicher[ebp]
		lea esi, COStream_COList[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, dword ptr COStream_COList_pvDaten[ebx]
		add edx, 8

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		push 1
		mov edx, ebx
		mov ecx, esi
		call ?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Ende:
		mov dword ptr COStream_ulBytes[ebp], 0
		mov dword ptr COStream_ulPosition[ebp], 0
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
?Delete@COStream@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
?ThDelete@COStream@System@RePag@@QAQXXZ PROC ; COStream::ThDelete(void)
		push ebp
		push ebx
		push edi
		push esi

		mov ebp, ecx

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov ebx, COStream_COList_pstErster[ebp]
		mov edi, dword ptr COStream_vmSpeicher[ebp]
		lea esi, COStream_COList[ebp]

	Kopf_Anfang:
		test ebx, ebx
		je short Ende
		mov edx, dword ptr COStream_COList_pvDaten[ebx]
		add edx, 8

		mov ecx, edi
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		push 1
		mov edx, ebx
		mov ecx, esi
		call ?DeleteFirstElementS@COList@System@RePag@@QAQXAAPAX_N@Z ; COList::DeleteFirstElementS(*&pstKnoten, bDatenLoschen)
		mov ebx, dword ptr [ebx]
		jmp short Kopf_Anfang

	Ende:
		mov dword ptr COStream_ulBytes[ebp], 0
		mov dword ptr COStream_ulPosition[ebp], 0

		lea edx, COStream_csStream[ebp]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		pop esi
		pop edi
		pop ebx
		pop ebp
		ret 0
?ThDelete@COStream@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
?End@COStream@System@RePag@@QAQ_NXZ PROC ; COStream::End(void)
		xor eax, eax
		mov edx, dword ptr COStream_ulPosition[ecx]
		cmp edx, dword ptr COStream_ulBytes[ecx]
		jb short Ende
		add eax, 1

	Ende:
		ret 0
?End@COStream@System@RePag@@QAQ_NXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_bReturn = 4
s_this = 0
?ThEnd@COStream@System@RePag@@QAQ_NXZ PROC ; COStream::ThEnde(void)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		xor eax, eax
		mov dword ptr s_bReturn[esp], eax
		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COStream_ulPosition[ecx]
		cmp edx, dword ptr COStream_ulBytes[ecx]

		jb short Ende
		add dword ptr s_bReturn[esp], 1

	Ende:
		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov eax, dword ptr s_bReturn[esp]
		add esp, esp_Bytes
		ret 0
?ThEnd@COStream@System@RePag@@QAQ_NXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Bytes@COStream@System@RePag@@QAQKXZ PROC ; COStream::Bytes(void)
		mov eax, dword ptr COStream_ulBytes[ecx]
		ret 0
?Bytes@COStream@System@RePag@@QAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulBytes = 4
s_this = 0
?ThBytes@COStream@System@RePag@@QAQPAKAAK@Z PROC ; COStream::ThBytes(&ulBytes)
		sub esp,  esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_ulBytes[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COStream_ulBytes[ecx]
		mov eax, dword ptr s_ulBytes[esp]
		mov dword ptr [eax], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov eax, dword ptr s_ulBytes[esp]
		add esp, esp_Bytes
		ret 0
?ThBytes@COStream@System@RePag@@QAQPAKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Position@COStream@System@RePag@@QAQKXZ PROC ; COStream::Position(void)
		mov eax, dword ptr COStream_ulPosition[ecx]
		ret 0
?Position@COStream@System@RePag@@QAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ulPosition = 4
s_this = 0
?ThPosition@COStream@System@RePag@@QAQPAKAAK@Z PROC ; COStream::ThPosition(&ulPosition)
		sub esp,  esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_ulPosition[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COStream_ulPosition[ecx]
		mov eax, dword ptr s_ulPosition[esp]
		mov dword ptr [eax], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov eax, dword ptr s_ulPosition[esp]
		add esp, esp_Bytes
		ret 0
?ThPosition@COStream@System@RePag@@QAQPAKAAK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_cVonWo = 4
?SetPosition@COStream@System@RePag@@QAQKJD@Z PROC ; COStream::SetPosition(lAbstand, cVonWo)
		mov al, byte ptr a_cVonWo[esp]

		test al, al
		jg short VonEnde
		jl short VonAnfang

		mov eax, dword ptr COStream_ulPosition[ecx]
		add eax, edx
		cmp eax, dword ptr COStream_ulBytes[ecx]
		jg short Error
		test eax, eax
		jl short Error
		add dword ptr COStream_ulPosition[ecx], edx
		jmp short Ende

	VonEnde:
		mov eax, dword ptr COStream_ulBytes[ecx]
		cmp edx, eax
		jg short Error
		test edx, edx
		jl short Error
		sub eax, edx
		mov dword ptr COStream_ulPosition[ecx], eax
		jmp short Ende

	VonAnfang:
		mov eax, dword ptr COStream_ulBytes[ecx]
		cmp edx, eax
		jg short Error
		test edx, edx
		jl short Error
		mov dword ptr COStream_ulPosition[ecx], edx
		jmp short Ende

	Error:
		mov byte ptr COStream_ucInfo[ecx], 89

	Ende:
		mov eax, dword ptr COStream_ulPosition[ecx]
		ret 4
?SetPosition@COStream@System@RePag@@QAQKJD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_lAbstand = 4
s_this = 0
a_cVonWo = esp_Bytes + 4
?ThSetPosition@COStream@System@RePag@@QAQKJD@Z PROC ; COStream::ThSetPosition(lAbstand, cVonWo)
		sub esp, esp_Bytes

		mov dword ptr s_lAbstand[esp], edx
		mov dword ptr s_this[esp], ecx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__EnterCriticalSection@4 ; EnterCriticalSection(&csStream)

		mov edx, dword ptr s_lAbstand[esp]
		mov ecx, dword ptr s_this[esp]

		mov al, byte ptr a_cVonWo[esp]
		test al, al
		jg short VonEnde
		jl short VonAnfang

		mov eax, dword ptr COStream_ulPosition[ecx]
		add eax, edx
		cmp eax, dword ptr COStream_ulBytes[ecx]
		jg short Error
		test eax, eax
		jl short Error
		add dword ptr COStream_ulPosition[ecx], edx
		jmp short Ende

	VonEnde:
		mov eax, dword ptr COStream_ulBytes[ecx]
		cmp edx, eax
		jg short Error
		test edx, edx
		jl short Error
		sub eax, edx
		mov dword ptr COStream_ulPosition[ecx], eax
		jmp short Ende

	VonAnfang:
		mov eax, dword ptr COStream_ulBytes[ecx]
		cmp edx, eax
		jg short Error
		test edx, edx
		jl short Error
		mov dword ptr COStream_ulPosition[ecx], edx
		jmp short Ende

	Error:
		mov byte ptr COStream_ucInfo[ecx], 89

	Ende:
		mov eax, dword ptr COStream_ulPosition[ecx]

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		add esp, esp_Bytes
		ret 4
?ThSetPosition@COStream@System@RePag@@QAQKJD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?GetLastError@COStream@System@RePag@@QAQEXZ PROC ; COStream::GetLastError(void)
		movzx eax, byte ptr COStream_ucInfo[ecx]
		mov byte ptr COStream_ucInfo[ecx], 0
		ret 0
?GetLastError@COStream@System@RePag@@QAQEXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_ucError$ = 4
s_this = 0
?ThGetLastError@COStream@System@RePag@@QAQPAEAAE@Z PROC ; COStream::ThGetLastError(&ucError)
		sub esp, esp_Bytes

		mov dword ptr s_this[esp], ecx
		mov dword ptr s_ucError$[esp], edx

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__TryEnterCriticalSection@4 ; TryEnterCriticalSection(&csStream)

		mov ecx, dword ptr s_this[esp]
		movzx eax, byte ptr COStream_ucInfo[ecx]
		mov edx, dword ptr s_ucError$[esp]
		mov byte ptr [edx], al
		mov byte ptr COStream_ucInfo[ecx], 0

		lea edx, COStream_csStream[ecx]
		push edx
		call dword ptr __imp__LeaveCriticalSection@4 ; LeaveCriticalSection(&csStream)

		mov eax, dword ptr s_ucError$[esp]
		add esp, esp_Bytes
		ret 0
?ThGetLastError@COStream@System@RePag@@QAQPAEAAE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OStream ENDS
END