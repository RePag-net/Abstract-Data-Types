;****************************************************************************
;  OStrangA_x86.asm
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

.686P
.XMM
.MODEL FLAT
INCLUDE listing.inc
INCLUDE ..\..\Include\CompSys.inc
INCLUDE ..\..\Include\ADT.inc
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

.DATA
ucBY_COSTRINGA DB 20
dZwei DQ 2.0
dEins DQ 1.0
dZehn DQ 10.0
dMinusEins DQ -1.0
fMinusEins DD -1.0
fEins DD 1.0
fZehn DD 10.00
dDreihunderacht DQ 308.0
dMinusDreihunderacht DQ -308.0
fAchtunddreizig DD 38.0
fMinusAchtunddreizig DD -38.0
dZehntausend DQ 10000.0
llEins DQ 1

CS_OStringA SEGMENT EXECUTE
;----------------------------------------------------------------------------
??0COStringA@System@RePag@@QAE@XZ PROC ; COStringA::COStringA(void)
		xor eax, eax
    mov dword ptr COStringA_vmSpeicher[ecx], eax
    mov dword ptr COStringA_ulLange[ecx], eax
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_ulLange_A[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax
    ret 0
??0COStringA@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_vmSpeicher = 4
??0COStringA@System@RePag@@QAE@PBX@Z PROC ; COStringA::COStringA(vmSpeicher)
		mov eax, dword ptr a_vmSpeicher[esp]
		mov edx, dword ptr[ecx]
    mov dword ptr COStringA_vmSpeicher[ecx], eax
		xor eax, eax
    mov dword ptr COStringA_ulLange[ecx], eax
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_ulLange_A[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax
    ret 4
??0COStringA@System@RePag@@QAE@PBX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_pcString = 12
??0COStringA@System@RePag@@QAE@PBD@Z PROC ; COStringA::COStringA(pcString)
    push ebp
    push edi

		mov edi, dword ptr a_pcString[esp]
		test edi, edi
		jne Lange_Ermitteln
		xor eax, eax
		mov dword ptr COStringA_vmSpeicher[ecx], eax
    mov dword ptr COStringA_ulLange[ecx], eax
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_ulLange_A[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax
		jmp short Ende

	Lange_Ermitteln:
    mov ebp, ecx

    xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
    sub edi, eax
		sub edi, 1

		xor edx, edx
    mov dword ptr COStringA_vmSpeicher[ebp], edx
    mov dword ptr COStringA_ulLange[ebp], eax
    mov dword ptr COStringA_ulLange_A[ebp], eax

    mov edx, eax
		add edx, 1
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebp], eax
    mov dword ptr COStringA_vbInhalt_A[ebp], eax

    push dword ptr COStringA_ulLange[ebp]
    mov edx, edi
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

	Ende:
    pop edi
    pop ebp
    ret 4
??0COStringA@System@RePag@@QAE@PBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_pcString = 16
a_vmSpeicher = 12
??0COStringA@System@RePag@@QAE@PBXPBD@Z PROC ; COStringA::COStringA(vmSpeicher, pcString)
    push ebp
    push edi

		mov edi, dword ptr a_pcString[esp]
		test edi, edi
		jne Lange_Ermitteln
		mov eax, dword ptr a_vmSpeicher[esp]
		mov dword ptr COStringA_vmSpeicher[ecx], eax
		xor eax, eax
    mov dword ptr COStringA_ulLange[ecx], eax
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_ulLange_A[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax
		jmp short Ende

	Lange_Ermitteln:
    mov ebp, ecx

    xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
    sub edi, eax
		sub edi, 1

		mov edx, dword ptr a_vmSpeicher[esp]
    mov dword ptr COStringA_vmSpeicher[ebp], edx
    mov dword ptr COStringA_ulLange[ebp], eax
    mov dword ptr COStringA_ulLange_A[ebp], eax

    mov edx, eax
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebp], eax
    mov dword ptr COStringA_vbInhalt_A[ebp], eax

    push dword ptr COStringA_ulLange[ebp]
    mov edx, edi
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

	Ende:
    pop edi
    pop ebp
    ret 8
??0COStringA@System@RePag@@QAE@PBXPBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??1COStringA@System@RePag@@QAE@XZ PROC ; COStringA::~COStringA(void)
    push ebp
    mov ebp, ecx

		mov eax, dword ptr COStringA_vbInhalt[ebp]
    test eax, eax
    je short Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Ende

  Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

  Ende:    
    pop ebp
    ret
??1COStringA@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
?COFreiV@COStringA@System@RePag@@QAQPBXXZ PROC ; COStringA::COFreiV(void)
    push ebp
    mov ebp, ecx

		mov eax, dword ptr COStringA_vbInhalt[ebp]
    test eax, eax
    je short Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Ende

  Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

  Ende:    
		mov eax, dword ptr COStringA_vmSpeicher[ebp]
    pop ebp
    ret
?COFreiV@COStringA@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@XZ PROC ; COStringAV(void)
    movzx edx, ucBY_COSTRINGA
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor ecx, ecx
    mov dword ptr COStringA_vmSpeicher[eax], ecx
    mov dword ptr COStringA_ulLange[eax], ecx
    mov dword ptr COStringA_vbInhalt[eax], ecx
    mov dword ptr COStringA_ulLange_A[eax], ecx
    mov dword ptr COStringA_vbInhalt_A[eax], ecx
    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@XZ ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBX@Z PROC ; COStringAV(vmSpeicher)
		push ecx

    movzx edx, ucBY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx
    mov dword ptr COStringA_vmSpeicher[eax], ecx
		xor edx, edx
    mov dword ptr COStringA_ulLange[eax], edx
    mov dword ptr COStringA_vbInhalt[eax], edx
    mov dword ptr COStringA_ulLange_A[eax], edx
    mov dword ptr COStringA_vbInhalt_A[eax], edx

    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBX@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@PBD@Z PROC ; COStringAV(pcString)
    push ebx
    push edi
		push ecx

    movzx edx, ucBY_COSTRINGA
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ebx, eax

		pop edi
		test edi, edi
		jne short Lange
		xor eax, eax
		mov dword ptr COStringA_vmSpeicher[ebx], eax
		mov dword ptr COStringA_ulLange[ebx], eax
		mov dword ptr COStringA_ulLange_A[ebx], eax
		mov dword ptr COStringA_vbInhalt[ebx], eax
    mov dword ptr COStringA_vbInhalt_A[ebx], eax
		jmp short Ende
		
	Lange:
    xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
		sub edi, eax
		sub edi, 1

		xor edx, edx
    mov dword ptr COStringA_vmSpeicher[ebx], edx
    mov dword ptr COStringA_ulLange[ebx], eax
    mov dword ptr COStringA_ulLange_A[ebx], eax

    mov edx, eax
		add edx, 1
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebx], eax
    mov dword ptr COStringA_vbInhalt_A[ebx], eax

    push dword ptr COStringA_ulLange[ebx]
    mov edx, edi
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebx]
		mov byte ptr [eax], 0

	Ende:
		mov eax, ebx

    pop edi
    pop ebx
    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@PBD@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBD@Z PROC ; COStringAV(vmSpeicher, pcString)
    push ebx
    push edi
		push ecx
		push edx

    movzx edx, ucBY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ebx, eax

		pop edi
		pop ecx
		test edi, edi
		jne short Lange
		xor eax, eax
		mov dword ptr COStringA_vmSpeicher[ebx], ecx
		mov dword ptr COStringA_ulLange[ebx], eax
		mov dword ptr COStringA_ulLange_A[ebx], eax
		mov dword ptr COStringA_vbInhalt[ebx], eax
    mov dword ptr COStringA_vbInhalt_A[ebx], eax
		jmp short Ende

	Lange:
    mov dword ptr COStringA_vmSpeicher[ebx], ecx
    xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
		sub edi, eax
		sub edi, 1

    mov dword ptr COStringA_ulLange[ebx], eax
    mov dword ptr COStringA_ulLange_A[ebx], eax

    mov edx, eax
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebx]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebx], eax
    mov dword ptr COStringA_vbInhalt_A[ebx], eax

    push dword ptr COStringA_ulLange[ebx]
    mov edx, edi
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebx]
		xor dl, dl
		mov byte ptr [eax], dl

	Ende:
		mov eax, ebx
    pop edi
    pop ebx
    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBD@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@PBV312@@Z PROC ; COStringAV(pasString)
    push edi
		push esi

		mov esi, ecx

    movzx edx, ucBY_COSTRINGA
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov edi, eax

		test esi, esi
		jne short Lange
		xor eax, eax
		mov dword ptr COStringA_vmSpeicher[edi], eax
		mov dword ptr COStringA_ulLange[edi], eax
		mov dword ptr COStringA_ulLange_A[edi], eax
		mov dword ptr COStringA_vbInhalt[edi], eax
    mov dword ptr COStringA_vbInhalt_A[edi], eax
		jmp short Ende

	Lange:
		xor edx, edx
    mov dword ptr COStringA_vmSpeicher[edi], edx
    mov ecx, dword ptr COStringA_ulLange[esi]
		mov dword ptr COStringA_ulLange[edi], ecx
    mov ecx, dword ptr COStringA_ulLange_A[esi]
    mov dword ptr COStringA_ulLange_A[edi], ecx

    mov edx, dword ptr COStringA_ulLange[edi]
		add edx, 1
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[edi], eax

    push dword ptr COStringA_ulLange[edi]
    mov edx, dword ptr COStringA_vbInhalt[esi]
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[edi]
		xor dl, dl
		mov byte ptr [eax], dl

    mov edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt_A[edi], eax

    push dword ptr COStringA_ulLange_A[edi]
    mov edx, dword ptr COStringA_vbInhalt_A[esi]
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange_A[edi]
		xor dl, dl
		mov byte ptr [eax], dl

	Ende:
		mov eax, edi

		pop esi
    pop edi
    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@PBV312@@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBV312@@Z PROC ; COStringAV(vmSpeicher, pasString)
		push ebx
    push edi
		push esi

		mov ebx, ecx
		mov esi, edx

    movzx edx, ucBY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov edi, eax

	  test esi, esi
		jne short Lange
		xor eax, eax
		mov dword ptr COStringA_vmSpeicher[edi], ebx
		mov dword ptr COStringA_ulLange[edi], eax
		mov dword ptr COStringA_ulLange_A[edi], eax
		mov dword ptr COStringA_vbInhalt[edi], eax
    mov dword ptr COStringA_vbInhalt_A[edi], eax
		jmp short Ende

	Lange:
    mov dword ptr COStringA_vmSpeicher[edi], ebx
    mov ecx, dword ptr COStringA_ulLange[esi]
		mov dword ptr COStringA_ulLange[edi], ecx
    mov ecx, dword ptr COStringA_ulLange_A[esi]
    mov dword ptr COStringA_ulLange_A[edi], ecx

    mov edx, dword ptr COStringA_ulLange[edi]
		add edx, 1
    mov ecx, ebx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[edi], eax

    push dword ptr COStringA_ulLange[edi]
    mov edx, dword ptr COStringA_vbInhalt[esi]
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[edi]
		xor dl, dl
		mov byte ptr [eax], dl

    mov edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
    mov ecx, ebx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt_A[edi], eax

    push dword ptr COStringA_ulLange_A[edi]
    mov edx, dword ptr COStringA_vbInhalt_A[esi]
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange_A[edi]
		xor dl, dl
		mov byte ptr [eax], dl

	Ende:
		mov eax, edi

		pop esi
    pop edi
		pop ebx
    ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXPBV312@@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@K@Z PROC ; COStringAV(ulLange)
		push ecx ; ulLange

    movzx edx, ucBY_COSTRINGA
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; ulLange

		test edx, edx
		jne short Lange
		xor ecx, ecx
		mov dword ptr COStringA_vmSpeicher[eax], ecx
		mov dword ptr COStringA_ulLange[eax], ecx
		mov dword ptr COStringA_ulLange_A[eax], ecx
		mov dword ptr COStringA_vbInhalt[eax], ecx
    mov dword ptr COStringA_vbInhalt_A[eax], ecx
		mov ecx, eax
		jmp short Ende

	Lange:
		xor ecx, ecx
		mov dword ptr COStringA_vmSpeicher[eax], ecx
		mov dword ptr COStringA_ulLange[eax], edx
		mov dword ptr COStringA_ulLange_A[eax], edx

		push eax
		add edx, 1
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		pop ecx
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax

	Ende:
		mov eax, ecx
		ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@K@Z ENDP
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXK@Z PROC ; COStringAV(vmSpeicher, ulLange)
		push ecx ; vmSpeicher
		push edx ; ulLange

    movzx edx, ucBY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; ulLange
		pop ecx ; vmSpeicher

		test edx, edx
		jne short Lange
		xor edx, edx
		mov dword ptr COStringA_vmSpeicher[eax], ecx
		mov dword ptr COStringA_ulLange[eax], edx
		mov dword ptr COStringA_ulLange_A[eax], edx
		mov dword ptr COStringA_vbInhalt[eax], edx
    mov dword ptr COStringA_vbInhalt_A[eax], edx
		mov ecx, eax
		jmp short Ende

	Lange:
		mov dword ptr COStringA_vmSpeicher[eax], ecx
		mov dword ptr COStringA_ulLange[eax], edx
		mov dword ptr COStringA_ulLange_A[eax], edx

		push eax
		add edx, 1
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		pop ecx
    mov dword ptr COStringA_vbInhalt[ecx], eax
    mov dword ptr COStringA_vbInhalt_A[ecx], eax

	Ende:
		mov eax, ecx

		ret
?COStringAV@System@RePag@@YQPAVCOStringA@12@QBXK@Z ENDP
;----------------------------------------------------------------------------
??4COStringA@System@RePag@@QAQXPBD@Z PROC ; COStringA::operator=(pcString)
		push ebp
		push edi

		mov ebp, ecx
		mov edi, edx

		mov eax, dword ptr COStringA_vbInhalt[ebp] 
		test eax, eax
    je short Freigeben
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Lange

  Freigeben:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Lange
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Lange:
		test edi, edi
		je short Ende_Null

		xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
		sub edi, eax
		sub edi, 1

		mov dword ptr COStringA_ulLange[ebp], eax
		mov dword ptr COStringA_ulLange_A[ebp], eax

		mov edx, eax
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebp], eax
    mov dword ptr COStringA_vbInhalt_A[ebp], eax

		push dword ptr COStringA_ulLange[ebp]
    mov edx, edi
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl
		jmp short Ende

	Ende_Null:
		xor eax, eax
		mov dword ptr COStringA_ulLange[ebp], eax
    mov dword ptr COStringA_vbInhalt[ebp], eax
    mov dword ptr COStringA_ulLange_A[ebp], eax
    mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		pop edi
		pop ebp
		ret
??4COStringA@System@RePag@@QAQXPBD@Z ENDP
;----------------------------------------------------------------------------
??4COStringA@System@RePag@@QAQXABV012@@Z PROC ; COStringA::operator=(&asString)
		push ebp
		push esi

		mov ebp, ecx
		mov esi, edx

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Lange

  Freigeben_Kopie:
	  mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Lange
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Lange:
		test esi, esi
		je short Lange_Null
		mov eax, dword ptr COStringA_ulLange_A[esi]
		test eax, eax
		je short Lange_Null

		mov edx, dword ptr COStringA_ulLange_A[esi]
		mov dword ptr COStringA_ulLange[ebp], edx
		mov dword ptr COStringA_ulLange_A[ebp], edx

		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

    push dword ptr COStringA_ulLange[ebp]
    mov edx, dword ptr COStringA_vbInhalt_A[esi]
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, dword ptr COStringA_vbInhalt[esi]
		cmp eax, dword ptr COStringA_vbInhalt_A[esi]
		je short Ende
		mov edx, dword ptr COStringA_vbInhalt_A[esi]
		mov ecx, dword ptr COStringA_vmSpeicher[esi]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[esi]
		mov dword ptr COStringA_ulLange_A[esi], ecx
		mov eax, dword ptr COStringA_vbInhalt[esi]
		mov dword ptr COStringA_vbInhalt_A[esi], eax

	Lange_Null:
		xor eax, eax
		mov dword ptr COStringA_ulLange[ebp], eax
    mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_ulLange_A[ebp], eax
    mov dword ptr COStringA_vbInhalt_A[ebp], eax
		
	Ende:
		pop esi
	  pop ebp
		ret
??4COStringA@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
??YCOStringA@System@RePag@@QAQXPBD@Z PROC ; COStringA::operator+=(pcString)
		push ebp
		push ebx
		push edi
		
		mov ebp, ecx
		mov edi, edx

		test edx, edx
		je Ende

		xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
		mov ebx, eax
		sub edi, eax
		sub edi, 1

		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Lange_Null

		mov edx, dword ptr COStringA_ulLange[ebp]
		add edx, ebx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push ebx
		mov edx, edi
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		sub eax, dword ptr COStringA_ulLange[ebp]
		mov edi, eax
		add ebx, dword ptr COStringA_ulLange[ebp]
		jmp short Freigeben

	Lange_Null:
		mov edx, ebx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push ebx
		mov edx, edi
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax

	Freigeben:
	  mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov dword ptr COStringA_ulLange[ebp], ebx
		mov dword ptr COStringA_vbInhalt[ebp], edi

		mov dword ptr COStringA_ulLange_A[ebp], ebx
		mov dword ptr COStringA_vbInhalt_A[ebp], edi

	Ende:
		pop edi
		pop ebx
		pop ebp
		ret
??YCOStringA@System@RePag@@QAQXPBD@Z ENDP
;----------------------------------------------------------------------------
??YCOStringA@System@RePag@@QAQXABV012@@Z PROC ; COStringA::operator+=(&ascString)
		push ebp
		push edi
		
		mov ebp, ecx
		mov edi, edx

		mov eax, dword ptr COStringA_ulLange_A[edi]
		test eax, eax
		je Ende

		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Lange_Null

		mov edx, dword ptr COStringA_ulLange[ebp]
		add edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr COStringA_ulLange_A[edi]
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		sub eax, dword ptr COStringA_ulLange[ebp]
		push eax
		jmp short Freigeben

	Lange_Null:
		mov edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange_A[edi]
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		push eax

	;---------------------------------------------------------
	Freigeben:
	  mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
	
	Freigeben_Ende:
	;---------------------------------------------------------
	  mov ecx, dword ptr COStringA_ulLange_A[edi]
		add dword ptr COStringA_ulLange[ebp], ecx
		add dword ptr COStringA_ulLange_A[ebp], ecx
		pop  eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, dword ptr COStringA_vbInhalt[edi]
		cmp eax, dword ptr COStringA_vbInhalt_A[edi]
		je short Ende
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, dword ptr COStringA_vmSpeicher[edi]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[edi]
		mov dword ptr COStringA_ulLange_A[edi], ecx
		mov eax, dword ptr COStringA_vbInhalt[edi]
		mov dword ptr COStringA_vbInhalt_A[edi], eax

	Ende:
		pop edi
		pop ebp
		ret
??YCOStringA@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
??HCOStringA@System@RePag@@QAQAAV012@PBD@Z PROC ; COStringA::operator+(pcString)
		push ebp
		push ebx
		push edi
		
		mov ebp, ecx
		mov edi, edx

		test edx, edx
		je Ende

		xor al, al
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx
		mov ebx, eax
		sub edi, eax
		sub edi, 1

		mov eax, dword ptr COStringA_ulLange_A[ebp]
		test eax, eax
		je short Lange_Null

		mov edx, dword ptr COStringA_ulLange_A[ebp]
		add edx, ebx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange_A[ebp]
		mov edx, dword ptr COStringA_vbInhalt_A[ebp]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push ebx
		mov edx, edi
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange_A[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov ecx, dword ptr COStringA_ulLange_A[ebp]
		sub eax, ecx
		mov edi, eax
		add ebx, ecx
		jmp short Schluss

	Lange_Null:
		mov edx, ebx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push ebx
		mov edx, edi
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax

	Schluss:
		mov dword ptr COStringA_ulLange_A[ebp], ebx
		mov dword ptr COStringA_vbInhalt_A[ebp], edi

		add edi, ebx
		xor dl, dl
		mov byte ptr [edi], dl

	Ende:
		mov eax, ebp
		pop edi
		pop ebx
		pop ebp
		ret
??HCOStringA@System@RePag@@QAQAAV012@PBD@Z ENDP
;----------------------------------------------------------------------------
??HCOStringA@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COStringA::operator+(&asString)
		push ebp
		push edi

		mov ebp, ecx
		mov edi, edx

		mov eax, dword ptr COStringA_ulLange_A[edi]
		test eax, eax
		je Ende

		mov eax, dword ptr COStringA_ulLange_A[ebp]
		test eax, eax
		je short Lange_Null

		mov edx, dword ptr COStringA_ulLange_A[ebp]
		add edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
		mov ecx, dword ptr COStringA_vmSpeicher[ebp]
		call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange_A[ebp]
		mov edx, dword ptr COStringA_vbInhalt_A[ebp]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr COStringA_ulLange_A[edi]
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange_A[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		sub eax, dword ptr COStringA_ulLange_A[ebp]
		jmp short Schluss

	Lange_Null:
		mov edx, dword ptr COStringA_ulLange_A[edi]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange_A[edi]
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Schluss:
	  mov ecx, dword ptr COStringA_ulLange_A[edi]
		add dword ptr COStringA_ulLange_A[ebp], ecx
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

		add eax, dword ptr COStringA_ulLange_A[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, dword ptr COStringA_vbInhalt[edi]
		cmp eax, dword ptr COStringA_vbInhalt_A[edi]
		je short Ende
		mov edx, dword ptr COStringA_vbInhalt_A[edi]
		mov ecx, dword ptr COStringA_vmSpeicher[edi]
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[edi]
		mov dword ptr COStringA_ulLange_A[edi], ecx
		mov eax, dword ptr COStringA_vbInhalt[edi]
		mov dword ptr COStringA_vbInhalt_A[edi], eax

	Ende:
		mov eax, ebp
		pop edi
		pop ebp
		ret
??HCOStringA@System@RePag@@QAQAAV012@ABV012@@Z ENDP
;----------------------------------------------------------------------------
??8COStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::operator==(pcString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx] 
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -2
		sub edx, ecx
		mov esi, edi
		sub esi, edx
		sub esi, 1

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, edx
		jbe short RefKleinerGleich
		mov ecx, edx

	RefKleinerGleich:
		mov eax, 1
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jne short Ungleich

		cmp edx, dword ptr COStringA_ulLange[ebp]
		jne short Ungleich
		jmp short Ende

	Ungleich:
		xor eax, eax

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??8COStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
??8COStringA@System@RePag@@QAQ_NABV012@@Z PROC ; COStringA::operator==(&asString)
		push ebp
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[edx]
		test eax, eax
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, dword ptr COStringA_ulLange[edx]
		jbe short RefKleinerGleich
		mov ecx, dword ptr COStringA_ulLange[edx]

	RefKleinerGleich:
		mov eax, 1
		cld
	  mov esi, dword ptr COStringA_vbInhalt[edx]
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jne short Ungleich

		mov ecx, dword ptr COStringA_ulLange[edx]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		jne short Ungleich
		jmp short Ende

	Ungleich:
		xor eax, eax

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??8COStringA@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??9COStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::operator!=(pcString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -2
		sub edx, ecx
		mov esi, edi
		sub esi, edx
		sub esi, 1

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, edx
		jbe short RefKleinerGleich
		mov ecx, edx

	RefKleinerGleich:
		xor eax, eax
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jne short Ungleich

		cmp edx, dword ptr COStringA_ulLange[ebp]
		jne short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??9COStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
??9COStringA@System@RePag@@QAQ_NABV012@@Z PROC ; COStringA::operator!=(&asString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, dword ptr COStringA_ulLange[edx]
		jbe short RefKleinerGleich
		mov ecx, dword ptr COStringA_ulLange[edx]

	RefKleinerGleich:
		xor eax, eax
		cld
		mov esi, dword ptr COStringA_vbInhalt[edx]
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jne short Ungleich

		mov ecx, dword ptr COStringA_ulLange[edx]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		jne short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??9COStringA@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??MCOStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::operator<(pcString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -2
		sub edx, ecx
		mov esi, edi
		sub esi, edx
		sub esi, 1

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, edx
		jbe short RefKleinerGleich
		mov ecx, edx

	RefKleinerGleich:
		xor eax, eax		
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		ja short Ungleich

		cmp edx, dword ptr COStringA_ulLange[ebp]
		ja short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??MCOStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
??MCOStringA@System@RePag@@QAQ_NABV012@@Z PROC ; COStringA::operator<(&asString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, dword ptr COStringA_ulLange[edx]
		jbe short RefKleinerGleich
		mov ecx, dword ptr COStringA_ulLange[edx]

	RefKleinerGleich:
		xor eax, eax
		cld
		mov esi, dword ptr COStringA_vbInhalt[edx]
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		ja short Ungleich

		mov ecx, dword ptr COStringA_ulLange[edx]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		ja short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??MCOStringA@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::operator>(pcString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -2
		sub edx, ecx
		mov esi, edi
		sub esi, edx
		sub esi, 1

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, edx
		jbe short RefKleinerGleich
		mov ecx, edx

	RefKleinerGleich:
		xor eax, eax		
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jb short Ungleich

		cmp edx, dword ptr COStringA_ulLange[ebp]
		jb short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??OCOStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
??OCOStringA@System@RePag@@QAQ_NABV012@@Z  PROC ; COStringA::operator>(&asString)
		push ebp
		push esi
		push edi

		test edx, edx
		je short Ungleich
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Ungleich
		mov ebp, ecx

		mov ecx, dword ptr COStringA_ulLange[ebp]
		cmp ecx, dword ptr COStringA_ulLange[edx]
		jbe short RefKleinerGleich
		mov ecx, dword ptr COStringA_ulLange[edx]

	RefKleinerGleich:
		xor eax, eax
		cld
		mov esi, dword ptr COStringA_vbInhalt[edx]
		mov edi, dword ptr COStringA_vbInhalt[ebp]
		repe cmpsb
		jb short Ungleich

		mov ecx, dword ptr COStringA_ulLange[edx]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		jb short Ungleich
		jmp short Ende

	Ungleich:
		mov eax, 1

	Ende:
		pop	edi
		pop	esi
		pop	ebp
		ret
??OCOStringA@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??ACOStringA@System@RePag@@QAQAADK@Z PROC ; COStringA::operator[](ulIndex)
	  mov eax, dword ptr COStringA_vbInhalt[ecx]
		cmp edx, dword ptr COStringA_ulLange[ecx]
		jb short Index
		xor edx, edx

	Index:
		add eax, edx

	Ende:		
		ret
??ACOStringA@System@RePag@@QAQAADK@Z ENDP
;----------------------------------------------------------------------------
?Contain@COStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::Contain(pcString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Return_0
		test edx, edx
		je short Return_0

		push ecx
		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov ebx, -2
		sub ebx, ecx
		pop ecx

		test ebx, ebx
		je short Return_0

		xor eax, eax

    mov edi, dword ptr COStringA_vbInhalt[ecx]
		mov esi, edx

		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1
		add ebx, 1

		cmp ebx, edx
		ja short Return_0

		mov ecx, edx

		cmp ebx, 2
		je short EinBuchstabe
		lodsb
		repne scasb

	NachsterBuchstabe:
		test eax, eax
		je short Return_1
		lodsb
		scasb
		je NachsterBuchstabe
		test eax, eax
		je short Return_1
		jmp short Return_0

	EinBuchstabe:
		lodsb
		repne scasb
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?Contain@COStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
?Contain@COStringA@System@RePag@@QAQ_NABV123@@Z PROC ; COStringA::Contain(&asString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Return_0
		mov eax, dword ptr COStringA_vbInhalt[edx]
		test eax, eax
		je short Return_0

		cld
		xor eax, eax

		mov esi, dword ptr COStringA_vbInhalt[edx]
		mov ebx, dword ptr COStringA_ulLange[edx]
		add ebx, 1

    mov edi, dword ptr COStringA_vbInhalt[ecx]
		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1

		cmp ebx, edx
		ja short Return_0

		mov ecx, edx

		cmp ebx, 2
		je short EinBuchstabe
		lodsb
		repne scasb

	NachsterBuchstabe:
		test eax, eax
		je short Return_1
		lodsb
		scasb
		je NachsterBuchstabe
		test eax, eax
		je short Return_1
		jmp short Return_0

	EinBuchstabe:
		lodsb
		repne scasb
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?Contain@COStringA@System@RePag@@QAQ_NABV123@@Z ENDP
;----------------------------------------------------------------------------
?ContainLeft@COStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::ContainLeft(pcString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Return_0
		test edx, edx
		je short Return_0

		push ecx
		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov ebx, -2
		sub ebx, ecx
		pop ecx

		test ebx, ebx
		je short Return_0

		xor eax, eax

    mov edi, dword ptr COStringA_vbInhalt[ecx]
    mov esi, edx

		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1
		add ebx, 1

		cmp ebx, edx
		ja short Return_0

    cmp ebx, 1
    ja short Vergleich
    cmp edx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov ecx, ebx
		repe cmpsb
		test ecx, ecx
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?ContainLeft@COStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
?ContainLeft@COStringA@System@RePag@@QAQ_NABV123@@Z PROC ; COStringA::ContainLeft(&asString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx] 
		test eax, eax
		je short Return_0
		mov eax, dword ptr COStringA_vbInhalt[edx]
		test eax, eax
		je short Return_0

		cld
		xor eax, eax

    mov esi, dword ptr COStringA_vbInhalt[edx]
    mov ebx, dword ptr COStringA_ulLange[edx]
		add ebx, 1

    mov edi, dword ptr COStringA_vbInhalt[ecx]
		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1

		cmp ebx, edx
		ja short Return_0

    cmp ebx, 1
    ja short Vergleich
    cmp edx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov ecx, ebx
		repe cmpsb
		test ecx, ecx
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?ContainLeft@COStringA@System@RePag@@QAQ_NABV123@@Z ENDP
;----------------------------------------------------------------------------
?ContainRight@COStringA@System@RePag@@QAQ_NPBD@Z PROC ; COStringA::ContainRight(pcString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Return_0
		test edx, edx
		je short Return_0

		push ecx
		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov ebx, -2
		sub ebx, ecx
		pop ecx

		test ebx, ebx
		je short Return_0

		xor eax, eax

    mov edi, dword ptr COStringA_vbInhalt[ecx]
    mov esi, edx

		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1
		add ebx, 1

		cmp ebx, edx
		ja Return_0

		mov ecx, ebx

		sub edx, ebx
		add edi, edx

		repe cmpsb
		test ecx, ecx
		je Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?ContainRight@COStringA@System@RePag@@QAQ_NPBD@Z ENDP
;----------------------------------------------------------------------------
?ContainRight@COStringA@System@RePag@@QAQ_NABV123@@Z PROC ; COStringA::ContainRight(&asString)
		push ebx
		push esi
		push edi

		mov eax, dword ptr COStringA_vbInhalt[ecx]
		test eax, eax
		je short Return_0
		mov eax, dword ptr COStringA_vbInhalt[edx]
		test eax, eax
		je short Return_0

		cld
		xor eax, eax

    mov esi, dword ptr COStringA_vbInhalt[edx]
    mov ebx, dword ptr COStringA_ulLange[edx]
		add ebx, 1

    mov edi, dword ptr COStringA_vbInhalt[ecx]
		mov edx, dword ptr COStringA_ulLange[ecx]
		add edx, 1

		cmp ebx, edx
		ja Return_0

		mov ecx, ebx

		sub edx, ebx
		add edi, edx

		repe cmpsb
		test ecx, ecx
		je Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret
?ContainRight@COStringA@System@RePag@@QAQ_NABV123@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulBis = 16
a_ulVon = 12
?SubString@COStringA@System@RePag@@QAQKAAPADKK@Z PROC ; COStringA::SubString(&vbString, ulVon, ulBis)
		push ebx
		push esi
		
		xor ebx, ebx
		mov esi, dword ptr a_ulVon[esp]
		test esi, esi
		je short Ende
		mov ebx, dword ptr a_ulBis[esp]
		test ebx, ebx
		je short Ende
		cmp ebx, dword ptr COStringA_ulLange[ecx]
		ja short Ende

		push edx
		push dword ptr COStringA_vbInhalt[ecx]
		
		add ebx, 1
		sub ebx, esi

		mov edx, ebx
		add edx, 1
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx
    push ebx
		add edx, esi
		sub edx, 1
    mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		pop edx
		mov dword ptr [edx], eax
		add eax, ebx
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, ebx

	Ende:
		pop esi
		pop ebx
		ret 8
?SubString@COStringA@System@RePag@@QAQKAAPADKK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulBis = 20
a_ulVon = 16
?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z PROC ; COStringA::SubString(pasString, ulVon, ulBis)
		push ebx
		push edi
		push esi

		mov edi, edx
		
		xor eax, eax
		mov esi, dword ptr a_ulVon[esp]
		test esi, esi
		je Ende
		mov ebx, dword ptr a_ulBis[esp]
		test ebx, ebx
		je short Ende
		cmp ebx, dword ptr COStringA_ulLange[ecx]
		ja short Ende

		push dword ptr COStringA_vbInhalt[ecx]
		
		add ebx, 1
		sub ebx, esi

		mov eax, dword ptr COStringA_vbInhalt[edi] 
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[edi]
    mov ecx, dword ptr COStringA_vmSpeicher[edi]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[edi]
    cmp eax, dword ptr COStringA_vbInhalt_A[edi]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[edi]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[edi]
    mov ecx, dword ptr COStringA_vmSpeicher[edi]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov dword ptr COStringA_ulLange[edi], ebx
		mov dword ptr COStringA_ulLange_A[edi], ebx

		test ebx, ebx
		je short Inhalt_Null
		mov edx, ebx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[edi]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov dword ptr COStringA_vbInhalt[edi], eax
		mov dword ptr COStringA_vbInhalt_A[edi], eax
		mov ecx, eax
		add eax, ebx
		xor dl, dl
		mov byte ptr [eax], dl
		jmp short Inhalt

	Inhalt_Null:
		pop edx
		xor eax, eax
		mov dword ptr COStringA_vbInhalt[edi], eax
		mov dword ptr COStringA_vbInhalt_A[edi], eax
		jmp short Ende

	Inhalt:
		pop edx
    push ebx
		add edx, esi
		sub edx, 1
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov eax, edi

	Ende:
		pop esi
		pop edi
		pop ebx
		ret 8
?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ENDP
_Text ENDs
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulPosition = 20
?Insert@COStringA@System@RePag@@QAQPAV123@PBDK@Z PROC ; COStringA::Insert(pcString, ulPosition)
		push ebp
		push ebx
		push edi

		mov ebp, ecx

		test edx, edx
		je Ende

		push edx ; pcString

		xor al, al
		mov edi, edx
		mov ecx, -1
		cld
		repnz scasb
		mov edx, -2
		sub edx, ecx
		mov ebx, edx

		add edx, dword ptr COStringA_ulLange[ebp]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr a_ulPosition[esp]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		jb short Einfugen

		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		pop edx ; pcString
		push ebx
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange[ebp]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax
		sub edi, dword ptr COStringA_ulLange[ebp]
		jmp short Lange

	Einfugen:
		push dword ptr a_ulPosition[esp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		pop edx ; pcString
		push ebx
		mov ecx, eax
		add ecx, dword ptr a_ulPosition[esp]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr COStringA_ulLange[ebp]
		sub edx, dword ptr a_ulPosition[esp-4]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		add edx, dword ptr a_ulPosition[esp]
		mov ecx, eax
		add ecx, ebx
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax
		sub edi, ebx
		sub edi, dword ptr a_ulPosition[esp-4]

	Lange:
		add ebx, dword ptr COStringA_ulLange[ebp]
		mov dword ptr COStringA_ulLange[ebp], ebx
		mov dword ptr COStringA_ulLange_A[ebp], ebx
		mov eax, edi
		add eax, ebx
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov dword ptr COStringA_vbInhalt[ebp], edi
		mov dword ptr COStringA_vbInhalt_A[ebp], edi

	Ende:
		mov eax, ebp
		pop edi
		pop ebx
		pop ebp
		ret 4
?Insert@COStringA@System@RePag@@QAQPAV123@PBDK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulPosition = 16
?Insert@COStringA@System@RePag@@QAQPAV123@PBV123@K@Z PROC ; COStringA::Insert(pasString, ulPosition)
		push ebp
		push ebx
		push edi

		mov ebp, ecx
		mov ebx, edx

		test edx, edx
		je Ende

		mov edx, dword ptr COStringA_ulLange[ebx]
		add edx, dword ptr COStringA_ulLange[ebp]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr a_ulPosition[esp]
		cmp ecx, dword ptr COStringA_ulLange[ebp]
		jb short Einfugen

		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr COStringA_ulLange[ebx]
		mov edx, dword ptr COStringA_vbInhalt[ebx]
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange[ebp]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax
		sub edi, dword ptr COStringA_ulLange[ebp]
		jmp short Lange

	Einfugen:
		push dword ptr a_ulPosition[esp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr COStringA_ulLange[ebx]
		mov edx, dword ptr COStringA_vbInhalt[ebx]
		mov ecx, eax
		add ecx, dword ptr a_ulPosition[esp+4]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr COStringA_ulLange[ebp]
		sub edx, dword ptr a_ulPosition[esp]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		add edx, dword ptr a_ulPosition[esp+4]
		mov ecx, eax
		add ecx, dword ptr COStringA_ulLange[ebx]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov edi, eax
		sub edi, dword ptr COStringA_ulLange[ebx]
		sub edi, dword ptr a_ulPosition[esp]

	Lange:
		mov ebx, dword ptr COStringA_ulLange[ebx]
		add ebx, dword ptr COStringA_ulLange[ebp]
		mov dword ptr COStringA_ulLange[ebp], ebx
		mov dword ptr COStringA_ulLange_A[ebp], ebx
		mov eax, edi
		add eax, ebx
		xor dl, dl
		mov byte ptr [eax], dl

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov dword ptr COStringA_vbInhalt[ebp], edi
		mov dword ptr COStringA_vbInhalt_A[ebp], edi

	Ende:
		mov eax, ebp
		pop edi
		pop ebx
		pop ebp
		ret 4
?Insert@COStringA@System@RePag@@QAQPAV123@PBV123@K@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulAnzahl = 12
?Delete@COStringA@System@RePag@@QAQPAV123@KK@Z PROC ; COStringA::Delete(ulPosition, ulAnzahl)
		push ebp
		push ebx

		mov ebp, ecx
		mov ebx, edx

		mov eax, edx
		add eax, dword ptr a_ulAnzahl[esp]
		cmp dword ptr COStringA_ulLange[ebp], eax
		jb Position_Null
		mov edx, dword ptr COStringA_ulLange[ebp]
		sub edx, dword ptr a_ulAnzahl[esp]
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push ebx
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		push eax ; vbNeuerInhalt

		mov edx, dword ptr COStringA_ulLange[ebp]
		sub edx, ebx
		sub edx, dword ptr a_ulAnzahl[esp+4]
		push edx
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		add edx, ebx
		add edx, dword ptr a_ulAnzahl[esp+8]
		mov ecx, eax
		add ecx, ebx
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, dword ptr a_ulAnzahl[esp+4]
		mov dword ptr COStringA_ulLange[ebp], ecx
		mov dword ptr COStringA_ulLange_A[ebp], ecx
		pop ebx ; vbNeuerInhalt
		add ebx, ecx
		xor dl, dl
		mov byte ptr [ebx], dl
		sub ebx, ecx

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie_1
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende_1

  Freigeben_Kopie_1:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende_1
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende_1:
		mov dword ptr COStringA_vbInhalt[ebp], ebx
		mov dword ptr COStringA_vbInhalt_A[ebp], ebx
		jmp short Ende

	Position_Null:
		test edx, edx
		jne short Position_Eins
		mov eax, dword ptr a_ulAnzahl[esp]
		cmp dword ptr COStringA_ulLange[ebp], eax
		je Freigeben_2

	Position_Eins:
		cmp edx, 1
		jne short Ende
		cmp dword ptr COStringA_ulLange[ebp], 1
		jne short Ende
		cmp dword ptr a_ulAnzahl[ebp], 1
		jne short Ende

	Freigeben_2:
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie_2
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende_2

  Freigeben_Kopie_2:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende_2
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende_2:
		xor eax, eax
		mov dword ptr COStringA_ulLange[ebp], eax
		mov dword ptr COStringA_ulLange_A[ebp], eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		mov eax, ecx
		pop ebx
		pop ebp
		ret 4
?Delete@COStringA@System@RePag@@QAQPAV123@KK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?SearchCharacters@COStringA@System@RePag@@QAQKPBD@Z PROC ; COStringA::SearchCharacters(pcZeichen)
		push ebx
		push edi

		cld
		mov edi, dword ptr COStringA_vbInhalt[ecx]
		mov ecx, dword ptr COStringA_ulLange[ecx]
		mov ebx, ecx
		movzx eax, byte ptr [edx]

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		add ebx, 1
		cmp eax, ebx
		jne short Ende
		xor eax, eax

	Ende:
		pop	edi
		pop ebx
		ret
?SearchCharacters@COStringA@System@RePag@@QAQKPBD@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_ulBis = 16
a_ulVon = 12
?SearchCharacters@COStringA@System@RePag@@QAQKPBDKK@Z PROC ; COStringA::SearchCharacters(pcZeichen, ulVon, ulBis)
		push ebx
		push edi

		xor eax, eax
		mov ebx, dword ptr a_ulVon[esp]
		test ebx, ebx
		je short Ende
		mov ebx, dword ptr a_ulBis[esp]
		test ebx, ebx
		je short Ende
		cmp ebx, dword ptr COStringA_ulLange[ecx]
		ja short Ende

		cld
		mov edi, dword ptr COStringA_vbInhalt[ecx]
		add edi, dword ptr a_ulVon[esp]
		mov ecx, dword ptr a_ulBis[esp]
		mov ebx, ecx
		add ebx, dword ptr a_ulVon[esp]
		movzx eax, byte ptr [edx]

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		add ebx, 1
		cmp eax, ebx
		jne short Ende
		xor eax, eax

	Ende:
		pop	edi
		pop ebx
		ret 8
?SearchCharacters@COStringA@System@RePag@@QAQKPBDKK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?ShortRight@COStringA@System@RePag@@QAQXK@Z PROC ; COStringA::ShortRight(ulStrLange)
		push ebp

		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je Ende
		test edx, edx
		je Ende
		cmp edx, eax
		ja short Ende

		mov ebp, ecx

		sub dword ptr COStringA_ulLange[ebp], edx
		mov eax, dword ptr COStringA_ulLange[ebp]
		mov dword ptr COStringA_ulLange_A[ebp], eax

		mov ecx, dword ptr COStringA_ulLange[ebp]
		test ecx, ecx
		je short Freigeben

		mov edx, eax
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		push eax ; vbNeuerInhalt
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

	Freigeben:
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Inhalt_Null
		pop eax ; vbNeuerInhalt
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax
		jmp short Ende

	Inhalt_Null:
		xor eax, eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		pop ebp
		ret
?ShortRight@COStringA@System@RePag@@QAQXK@Z ENDP
;----------------------------------------------------------------------------
?ShortLeft@COStringA@System@RePag@@QAQXK@Z PROC ; COStringA::ShortLeft(ulStrLange)
		push ebp

		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je Ende
		test edx, edx
		je Ende
		cmp edx, eax
		ja Ende

		mov ebp, ecx

		sub dword ptr COStringA_ulLange[ebp], edx
		mov eax, dword ptr COStringA_ulLange[ebp]
		mov dword ptr COStringA_ulLange_A[ebp], eax

		mov ecx, dword ptr COStringA_ulLange[ebp]
		test ecx, ecx
		je short Freigeben

		push edx ; ulStrLange
		mov edx, eax
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx  ; ulStrLange
		push dword ptr COStringA_ulLange[ebp]
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		add edx, ecx
		mov ecx, eax
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		push eax ; vbNeuerInhalt
		add eax, dword ptr COStringA_ulLange[ebp]
		xor dl, dl
		mov byte ptr [eax], dl

	Freigeben:
	  mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
		je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
	  mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Inhalt_Null
		pop eax ; vbNeuerInhalt
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax
		jmp short Ende

	Inhalt_Null:
	  xor eax, eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		pop ebp
		ret
?ShortLeft@COStringA@System@RePag@@QAQXK@Z ENDP
;----------------------------------------------------------------------------
?ShortRightOne@COStringA@System@RePag@@QAQXXZ PROC ; COStringA::ShortRightOne(void)
		push ebp

		mov ebp, ecx
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Ende
		
		sub dword ptr COStringA_ulLange[ebp], 1
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je short Freigeben
		mov eax, dword ptr COStringA_ulLange[ebp]
		mov dword ptr COStringA_ulLange_A[ebp], eax
		mov edx, dword ptr COStringA_vbInhalt[ebp]
		add edx, eax
		xor cl, cl
		mov byte ptr [edx], cl
		sub edx, eax
		mov dword ptr COStringA_vbInhalt_A[ebp], edx
		jmp short Ende

	Freigeben:
	  mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		xor eax, eax
		mov dword ptr COStringA_ulLange_A[ebp], eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		pop ebp
		ret
?ShortRightOne@COStringA@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
?CHAR@COStringA@System@RePag@@QAQAADAAD@Z PROC ; COStringA::CHAR(&cZahl)
		push edi
		push esi

		xor al, al
		mov byte ptr [edx], al
		mov eax, dword ptr COStringA_ulLange[ecx] 
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Minus

	Punkt:
		cmp eax, 46
		jne short Minus
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Minus:
		cmp eax, 45
		jne Leerzeichen
		mov al, byte ptr [edx]
		imul ax, -1
		mov byte ptr [edx], al
		jmp short Ende

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add byte ptr [edx], al
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?CHAR@COStringA@System@RePag@@QAQAADAAD@Z ENDP
;----------------------------------------------------------------------------
?BYTE@COStringA@System@RePag@@QAQAAEAAE@Z PROC ; COStringA::BYTE(&ucZahl)
		push edi
		push esi

		xor al, al
		mov byte ptr [edx], al
		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Leerzeichen

	Punkt:
		cmp eax, 46
		jne short Leerzeichen
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add byte ptr [edx], al
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?BYTE@COStringA@System@RePag@@QAQAAEAAE@Z ENDP
;----------------------------------------------------------------------------
?SHORT@COStringA@System@RePag@@QAQAAFAAF@Z PROC ; COStringA::SHORT(&sZahl)
		push edi
		push esi

		xor ax, ax
		mov word ptr [edx], ax
		mov eax, dword ptr COStringA_ulLange[ecx] 
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Minus

	Punkt:
		cmp eax, 46
		jne short Minus
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Minus:
		cmp eax, 45
		jne Leerzeichen
		mov ax, word ptr [edx]
		imul ax, -1
		mov word ptr [edx], ax
		jmp short Ende

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add word ptr [edx], ax
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?SHORT@COStringA@System@RePag@@QAQAAFAAF@Z ENDP
;----------------------------------------------------------------------------
?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z PROC ; COStringA::USHORT(&usZahl)
		push edi
		push esi

		xor ax, ax
		mov word ptr [edx], ax
		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Leerzeichen

	Punkt:
		cmp eax, 46
		jne short Leerzeichen
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add word ptr [edx], ax
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ENDP
;----------------------------------------------------------------------------
?LONG@COStringA@System@RePag@@QAQAAJAAJ@Z PROC ; COStringA::LONG(&lZahl)
		push edi
		push esi

		xor eax, eax
		mov dword ptr [edx], eax
		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Minus

	Punkt:
		cmp eax, 46
		jne short Minus
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Minus:
		cmp eax, 45
		jne Leerzeichen
		mov eax, dword ptr [edx]
		imul eax, -1
		mov dword ptr [edx], eax
		jmp short Ende

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add dword ptr [edx], eax
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?LONG@COStringA@System@RePag@@QAQAAJAAJ@Z ENDP
;----------------------------------------------------------------------------
?ULONG@COStringA@System@RePag@@QAQAAKAAK@Z PROC ; COStringA::ULONG(&ulZahl)
		push edi
		push esi

		xor eax, eax
		mov dword ptr [edx], eax
		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je short Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		mov esi, 1

		add edi, 1
	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Leerzeichen

	Punkt:
		cmp eax, 46
		jne short Leerzeichen
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Leerzeichen:
		cmp eax, 32
		je short Ende
		cmp eax, 95
		je short Ende
		
		sub eax, 48
		imul eax, esi
		add dword ptr [edx], eax
		imul esi, 10

		test edi, edi
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		pop esi
		pop edi
		ret
?ULONG@COStringA@System@RePag@@QAQAAKAAK@Z ENDP
;----------------------------------------------------------------------------
?LONGLONG@COStringA@System@RePag@@QAQAA_JAA_J@Z PROC ; COStringA::LONGLONG(&llZahl)
		push edi

		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je Ende

		mov edi, dword ptr COStringA_ulLange[ecx]
		sub edi, 1
		test edi, edi
		jne short Zahl
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Ende
		cmp eax, 46
		je short Ende

	Zahl:
		movsd xmm1, dEins
		add edi, 1

	Fuss_Anfang:
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		jne short Punkt
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Minus

	Punkt:
		cmp eax, 46
		jne short Minus
		sub edi, 1
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, edi
		movzx eax, byte ptr [eax]

	Minus:
		cmp eax, 45
		jne Leerzeichen
		mulsd xmm2, dMinusEins
		jmp short Fuss_Ende

	Leerzeichen:
		cmp eax, 32
		je short Fuss_Ende
		cmp eax, 95
		je short Fuss_Ende
		
		sub eax, 48
		cvtsi2sd xmm0, eax
		mulsd xmm0, xmm1
		addsd xmm2, xmm0
		mulsd xmm1, dZehn

		test edi, edi
		jne short Fuss_Anfang

	Fuss_Ende:
		movsd qword ptr [edx], xmm2
		fld qword ptr [edx]
		fistp qword ptr [edx]

	Ende:
		mov eax, edx
		pop edi
		ret
?LONGLONG@COStringA@System@RePag@@QAQAA_JAA_J@Z ENDP
;----------------------------------------------------------------------------
?FLOAT@COStringA@System@RePag@@QAQAAMAAM@Z PROC ; COStringA::FLOAT(&fZahl)
		push ebp
		push edi
		push esi
		push ebx

		mov ebp, ecx
		mov esi, dword ptr COStringA_vbInhalt[ebp]
		xorps xmm7, xmm7
		xorps xmm0, xmm0
		xorps xmm3, xmm3
		movss dword ptr [edx], xmm0
		push edx ; fZahl
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je Ende

		cld
		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 44

    add ecx, 1
		repne scasb
		sub ebx, ecx
		add ebx, 1
		push ebx ; ucKomma

		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 46

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		pop ebx ; ucKomma

		cmp eax, ebx ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp ebx, dword ptr COStringA_ulLange[ebp]
		je Komma_Gleich_Lange
		mov edi, ebx
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov edi, ebx
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 44
		je short EU_oder_US_Ende
		mov edi, eax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[ebp]
		je short Punkt_Gleich_Lange
		mov edi, eax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov edi, eax
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 46
		je short EU_oder_US_Ende
		mov edi, ebx
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[ebp]
		sub edi, 1

	EU_oder_US_Ende:
		push edi ; ucStelle
		xorpd xmm0, xmm0 ; Exponent
		movss xmm1, fZehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[ebp]

	Kopf_Anfang:
		add edi, 1
		cmp edi, edx
		jae Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46 ; Punkt
		jne short Gleich_44
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_44:
		cmp eax, 44 ; Komma
		jne short Gleich_32
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_32:
		cmp eax, 32 
		je Kopf_Ende
		cmp eax, 95
		je Kopf_Ende
		cmp eax, 42
		jne Gleich_48
		add edi, 4
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 45
		je short Gleich_45
		addsd xmm0, dEins
		jmp short Lange_Stelle_2

	Gleich_45:
		addsd xmm0, dEins
		add edi, 1

	Lange_Stelle_2:
		mov ecx, edx
		sub ecx, edi
		cmp ecx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_2
		cmp eax, 57
		ja short Faktor_Null_2
		sub eax, 48
		imul eax, 10
		cvtsi2ss xmm1, eax
		add edi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		movss xmm1, xmm7

	Einer_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_3
		cmp eax, 57
		ja short Faktor_Null_3
		sub eax, 48
		cvtsi2ss xmm2, eax
		addss xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		movss xmm1, xmm7

	Kopf_2:
		ucomiss xmm1, xmm7
		je Kopf_Ende
		subss xmm1, fEins
		mulsd xmm0, dZehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_1
		cmp eax, 57
		ja short Faktor_Null_1
		sub eax, 48
		cvtsi2ss xmm1, eax
		jmp short Kopf_1

	Faktor_Null_1:
		movss xmm1, xmm7

	Kopf_1:
		ucomiss xmm1, xmm7
		je Kopf_Ende
		subss xmm1, fEins
		mulsd xmm0, dZehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp ecx, 3
		jl Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_4
		cmp eax, 57
		ja short Faktor_Null_4
		sub eax, 48
		imul eax, 100
		cvtsi2ss xmm1, eax
		add edi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		movss xmm1, xmm7

	Zehner_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_5
		cmp eax, 57
		ja short Faktor_Null_5
		sub eax, 48
		imul eax, 10
		cvtsi2ss xmm2, eax
		addss xmm1, xmm2
		add edi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		movss xmm1, xmm7

	Einer_Stelle_2:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		ja short Faktor_Null_6
		cmp eax, 57
		jl short Faktor_Null_6
		sub eax, 48
		cvtsi2ss xmm2, eax
		addss xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		movss xmm1, xmm7

	Faktor_38:
		ucomiss xmm1, fAchtunddreizig
		jbe short Kopf_3
		ucomiss xmm1, fMinusAchtunddreizig
		jge short Kopf_3
		movss xmm1, xmm7

	Kopf_3:
		ucomiss xmm1, xmm7
		jmp short Kopf_Ende
		subss xmm1, fEins
		mulsd xmm0, dZehn
		jmp short Kopf_3

	Exponent_Eins:
		movsd xmm0, dEins

	Kopf_4:
		ucomiss xmm1, xmm7
		jmp short Kopf_Ende
		subss xmm1, fEins
		mulsd xmm0, dZwei
		jmp short Kopf_4

	Gleich_48:
		cmp eax, 48
		jl short FZahl_Null
		cmp eax, 57
		ja short FZahl_Null
		sub eax, 48
		cvtsi2ss xmm2, eax
		divss xmm2, xmm1
		addss xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		movss xmm2, xmm7
		divss xmm2, xmm1
		addss xmm3, xmm2

	Faktor_Zehn:
		mulss xmm1, fZehn
		jmp Kopf_Anfang

	Kopf_Ende:
		pop edi ; ucStelle
		movss xmm1, fEins

		test edi, edi
		jne Fuss_Anfang
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Exponent_1
		cmp eax, 46
		je short Exponent_1

	Fuss_Anfang:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46
		je short Stelle_Minus
		cmp eax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]

	Stelle_45:
		cmp eax, 45
		jne short Stelle_32
		mulss xmm3, fMinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp eax, 32
		je short Exponent_1
		cmp eax, 95
		je short Exponent_1
		cmp eax, 48
		jb short FZahl_Null_1
		cmp eax, 57
		ja short FZahl_Null_1
		sub eax, 48
		cvtsi2ss xmm2, eax
		mulss xmm2, xmm1
		addss xmm3, xmm2
		jmp short Fuss_Ende

	FZahl_Null_1:
		movss xmm2, xmm7
		divss xmm2, xmm1
		addss xmm3, xmm2

	Fuss_Ende:
		mulss xmm1, fZehn
		test edi, edi
		je short Exponent_1
		sub edi, 1
		jmp short Fuss_Anfang

	Exponent_1:
	  xorpd xmm7, xmm7
		ucomisd xmm0, xmm7
		jg short FZahl_Mul
		ucomisd xmm0, xmm7
		jl short FZahl_Div
		jmp short Ende

	FZahl_Mul:
		cvtsd2ss xmm2, xmm0
		mulss xmm3, xmm2
		jmp short Ende

	FZahl_Div:
		mulsd xmm0, dMinusEins
		movss xmm2, xmm0
		divss xmm3, xmm2

	Ende:
		pop edx
		movss dword ptr [edx], xmm3
		mov eax, edx
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
?FLOAT@COStringA@System@RePag@@QAQAAMAAM@Z ENDP
;----------------------------------------------------------------------------
?DOUBLE@COStringA@System@RePag@@QAQAANAAN@Z PROC ; COStringA::DOUBLE(&dZahl)
		push ebp
		push edi
		push esi
		push ebx

		mov ebp, ecx
		mov esi, dword ptr COStringA_vbInhalt[ebp]
		xorps xmm0, xmm0
		xorps xmm3, xmm3
		xorpd xmm7, xmm7
		movsd qword ptr [edx], xmm0
		push edx ; fZahl
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je Ende

		cld
		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 44

    add ecx, 1
		repne scasb
		sub ebx, ecx
		add ebx, 1
		push ebx ; ucKomma

		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 46

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		pop ebx ; ucKomma

		cmp eax, ebx ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp ebx, dword ptr COStringA_ulLange[ebp]
		je Komma_Gleich_Lange
		mov edi, ebx
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov edi, ebx
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 44
		je short EU_oder_US_Ende
		mov edi, eax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[ebp]
		je short Punkt_Gleich_Lange
		mov edi, eax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov edi, eax
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 46
		je short EU_oder_US_Ende
		mov edi, ebx
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[ebp]
		sub edi, 1

	EU_oder_US_Ende:
		push edi ; ucStelle
		xorpd xmm0, xmm0 ; Exponent
		movsd xmm1, dZehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[ebp]

	Kopf_Anfang:
		add edi, 1
		cmp edi, edx
		jae Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46 ; Punkt
		jne short Gleich_44
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_44:
		cmp eax, 44 ; Komma
		jne short Gleich_32
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_32:
		cmp eax, 32 
		je Kopf_Ende
		cmp eax, 95
		je Kopf_Ende
		cmp eax, 42
		jne Gleich_48
		add edi, 4
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 45
		je short Gleich_45
		addsd xmm0, dEins
		jmp short Lange_Stelle_2

	Gleich_45:
		addsd xmm0, dEins
		add edi, 1

	Lange_Stelle_2:
		mov ecx, edx
		sub ecx, edi
		cmp ecx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_2
		cmp eax, 57
		ja short Faktor_Null_2
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		movsd xmm1, xmm7

	Einer_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_3
		cmp eax, 57
		ja short Faktor_Null_3
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		movsd xmm1, xmm7

	Kopf_2:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_1
		cmp eax, 57
		ja short Faktor_Null_1
		sub eax, 48
		cvtsi2sd xmm1, eax
		jmp short Kopf_1

	Faktor_Null_1:
		movsd xmm1, xmm7

	Kopf_1:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp ecx, 3
		jl Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_4
		cmp eax, 57
		ja short Faktor_Null_4
		sub eax, 48
		imul eax, 100
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		movsd xmm1, xmm7

	Zehner_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_5
		cmp eax, 57
		ja short Faktor_Null_5
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		add edi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		movsd xmm1, xmm7

	Einer_Stelle_2:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		ja short Faktor_Null_6
		cmp eax, 57
		jl short Faktor_Null_6
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		movsd xmm1, xmm7

	Faktor_38:
		ucomisd xmm1, dDreihunderacht
		jbe short Kopf_3
		ucomisd xmm1, dMinusDreihunderacht
		jge short Kopf_3
		movsd xmm1, xmm7

	Kopf_3:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_3

	Exponent_Eins:
		movsd xmm0, dEins

	Kopf_4:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZwei
		jmp short Kopf_4

	Gleich_48:
		cmp eax, 48
		jl short FZahl_Null
		cmp eax, 57
		ja short FZahl_Null
		sub eax, 48
		cvtsi2sd xmm2, eax
		divsd xmm2, xmm1
		addsd xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Faktor_Zehn:
		mulsd xmm1, dZehn
		jmp Kopf_Anfang

	Kopf_Ende:
		pop edi ; ucStelle
		movsd xmm1, dEins

		test edi, edi
		jne Fuss_Anfang
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Exponent_1
		cmp eax, 46
		je short Exponent_1

	Fuss_Anfang:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46
		je short Stelle_Minus
		cmp eax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]

	Stelle_45:
		cmp eax, 45
		jne short Stelle_32
		mulsd xmm3, dMinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp eax, 32
		je short Exponent_1
		cmp eax, 95
		je short Exponent_1
		cmp eax, 48
		jb short FZahl_Null_1
		cmp eax, 57
		ja short FZahl_Null_1
		sub eax, 48
		cvtsi2sd xmm2, eax
		mulsd xmm2, xmm1
		addsd xmm3, xmm2
		jmp short Fuss_Ende

	FZahl_Null_1:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Fuss_Ende:
		mulsd xmm1, dZehn
		test edi, edi
		je short Exponent_1
		sub edi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		ucomisd xmm0, xmm7
		jg short FZahl_Mul
		ucomisd xmm0, xmm7
		jl short FZahl_Div
		jmp short Ende

	FZahl_Mul:
		mulsd xmm3, xmm0
		jmp short Ende

	FZahl_Div:
		mulsd xmm0, dMinusEins
		movsd xmm2, xmm0
		divsd xmm3, xmm2

	Ende:
		pop edx
		movsd qword ptr [edx], xmm3
		mov eax, edx
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
?DOUBLE@COStringA@System@RePag@@QAQAANAAN@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COMMA4@COStringA@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z PROC ; COStringA::KOMMA4(pk4Zahl)
		push ebp
		push edi
		push esi
		push ebx
		sub esp, esp_Bytes

		mov ebp, ecx
		mov esi, dword ptr COStringA_vbInhalt[ebp]
		xorpd xmm7, xmm7
		xorps xmm0, xmm0
		xorps xmm3, xmm3
		movsd qword ptr [edx], xmm0
		push edx ; pk4Zahl
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je Ende_Double

		cld
		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 44

    add ecx, 1
		repne scasb
		sub ebx, ecx
		add ebx, 1
		push ebx ; ucKomma

		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 46

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		pop ebx ; ucKomma

		cmp eax, ebx ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp ebx, dword ptr COStringA_ulLange[ebp]
		je Komma_Gleich_Lange
		mov edi, ebx
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov edi, ebx
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 44
		je short EU_oder_US_Ende
		mov edi, eax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[ebp]
		je short Punkt_Gleich_Lange
		mov edi, eax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov edi, eax
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 46
		je short EU_oder_US_Ende
		mov edi, ebx
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[ebp]
		sub edi, 1

	EU_oder_US_Ende:
		push edi ; ucStelle
		xorpd xmm0, xmm0 ; Exponent
		movsd xmm1, dZehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[ebp]

	Kopf_Anfang:
		add edi, 1
		cmp edi, edx
		jae Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46 ; Punkt
		jne short Gleich_44
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_44:
		cmp eax, 44 ; Komma
		jne short Gleich_32
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_32:
		cmp eax, 32 
		je Kopf_Ende
		cmp eax, 95
		je Kopf_Ende
		cmp eax, 42
		jne Gleich_48
		add edi, 4
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 45
		je short Gleich_45
		addsd xmm0, dEins
		jmp short Lange_Stelle_2

	Gleich_45:
		addsd xmm0, dEins
		add edi, 1

	Lange_Stelle_2:
		mov ecx, edx
		sub ecx, edi
		cmp ecx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_2
		cmp eax, 57
		ja short Faktor_Null_2
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		movsd xmm1, xmm7

	Einer_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_3
		cmp eax, 57
		ja short Faktor_Null_3
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		movsd xmm1, xmm7

	Kopf_2:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_1
		cmp eax, 57
		ja short Faktor_Null_1
		sub eax, 48
		cvtsi2sd xmm1, eax
		jmp short Kopf_1

	Faktor_Null_1:
		movsd xmm1, xmm7

	Kopf_1:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp ecx, 3
		jl Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_4
		cmp eax, 57
		ja short Faktor_Null_4
		sub eax, 48
		imul eax, 100
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		movsd xmm1, xmm7

	Zehner_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_5
		cmp eax, 57
		ja short Faktor_Null_5
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		add edi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		movsd xmm1, xmm7

	Einer_Stelle_2:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		ja short Faktor_Null_6
		cmp eax, 57
		jl short Faktor_Null_6
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		movsd xmm1, xmm7

	Faktor_38:
		ucomisd xmm1, dDreihunderacht
		jbe short Kopf_3
		ucomisd xmm1, dMinusDreihunderacht
		jge short Kopf_3
		movsd xmm1, xmm7

	Kopf_3:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_3

	Exponent_Eins:
		movsd xmm0, dEins

	Kopf_4:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZwei
		jmp short Kopf_4

	Gleich_48:
		cmp eax, 48
		jl short FZahl_Null
		cmp eax, 57
		ja short FZahl_Null
		sub eax, 48
		cvtsi2sd xmm2, eax
		divsd xmm2, xmm1
		addsd xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Faktor_Zehn:
		mulsd xmm1, dZehn
		jmp Kopf_Anfang

	Kopf_Ende:
		pop edi ; ucStelle
		movsd xmm1, dEins

		test edi, edi
		jne Fuss_Anfang
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Exponent_1
		cmp eax, 46
		je short Exponent_1

	Fuss_Anfang:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46
		je short Stelle_Minus
		cmp eax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]

	Stelle_45:
		cmp eax, 45
		jne short Stelle_32
		mulsd xmm3, dMinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp eax, 32
		je short Exponent_1
		cmp eax, 95
		je short Exponent_1
		cmp eax, 48
		jb short FZahl_Null_1
		cmp eax, 57
		ja short FZahl_Null_1
		sub eax, 48
		cvtsi2sd xmm2, eax
		mulsd xmm2, xmm1
		addsd xmm3, xmm2
		jmp short Fuss_Ende

	FZahl_Null_1:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Fuss_Ende:
		mulsd xmm1, dZehn
		test edi, edi
		je short Exponent_1
		sub edi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		ucomisd xmm0, xmm7
		jg short FZahl_Mul
		ucomisd xmm0, xmm7
		jl short FZahl_Div
		jmp short Ende_Double

	FZahl_Mul:
		mulsd xmm3, xmm0
		jmp short Ende_Double

	FZahl_Div:
		mulsd xmm0, dMinusEins
		movsd xmm2, xmm0
		divsd xmm3, xmm2

	Ende_Double:
		pop ecx ; pk4Zahl
		movsd xmm0, xmm3

		stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    movsd xmm1, xmm0
    cvttsd2si eax, xmm1
    cvtsi2sd xmm1, eax
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    cmp ebx, 0
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    add eax, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    sub eax, 1

  Ende:
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx

		mov eax, ecx
		ldmxcsr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
?COMMA4@COStringA@System@RePag@@QAQPAVCOComma4@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COMMA4_80@COStringA@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z PROC ; COStringA::KOMMA4_80(pk4_80Zahl)
		push ebp
		push edi
		push esi
		push ebx
		sub esp, esp_Bytes

		mov ebp, ecx
		mov esi, dword ptr COStringA_vbInhalt[ebp]
		xorpd xmm7, xmm7
		xorps xmm0, xmm0
		xorps xmm3, xmm3
		movsd qword ptr [edx], xmm0
		push edx ; pk4_80Zahl
		mov eax, dword ptr COStringA_ulLange[ebp]
		test eax, eax
		je Ende_Double

		cld
		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 44

    add ecx, 1
		repne scasb
		sub ebx, ecx
		add ebx, 1
		push ebx ; ucKomma

		mov edi, esi
		mov ecx, dword ptr COStringA_ulLange[ebp]
		mov ebx, ecx
    sub ebx, 1
		mov al, 46

    add ecx, 1
		repne scasb
		mov eax, ebx
		sub eax, ecx
		add eax, 1

		pop ebx ; ucKomma

		cmp eax, ebx ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp ebx, dword ptr COStringA_ulLange[ebp]
		je Komma_Gleich_Lange
		mov edi, ebx
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov edi, ebx
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 44
		je short EU_oder_US_Ende
		mov edi, eax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[ebp]
		je short Punkt_Gleich_Lange
		mov edi, eax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov edi, eax
		mov ecx, dword ptr COStringA_ulLange[ebp]
		sub ecx, 1
		mov edx, esi
		add edx, ecx
		cmp esi, 46
		je short EU_oder_US_Ende
		mov edi, ebx
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[ebp]
		sub edi, 1

	EU_oder_US_Ende:
		push edi ; ucStelle
		xorpd xmm0, xmm0 ; Exponent
		movsd xmm1, dZehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[ebp]

	Kopf_Anfang:
		add edi, 1
		cmp edi, edx
		jae Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46 ; Punkt
		jne short Gleich_44
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_44:
		cmp eax, 44 ; Komma
		jne short Gleich_32
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		jmp short Gleich_32

	Gleich_32:
		cmp eax, 32 
		je Kopf_Ende
		cmp eax, 95
		je Kopf_Ende
		cmp eax, 42
		jne Gleich_48
		add edi, 4
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 45
		je short Gleich_45
		addsd xmm0, dEins
		jmp short Lange_Stelle_2

	Gleich_45:
		addsd xmm0, dEins
		add edi, 1

	Lange_Stelle_2:
		mov ecx, edx
		sub ecx, edi
		cmp ecx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_2
		cmp eax, 57
		ja short Faktor_Null_2
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		movsd xmm1, xmm7

	Einer_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_3
		cmp eax, 57
		ja short Faktor_Null_3
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		movsd xmm1, xmm7

	Kopf_2:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_1
		cmp eax, 57
		ja short Faktor_Null_1
		sub eax, 48
		cvtsi2sd xmm1, eax
		jmp short Kopf_1

	Faktor_Null_1:
		movsd xmm1, xmm7

	Kopf_1:
		ucomisd xmm1, xmm7
		je Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp ecx, 3
		jl Kopf_Ende
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_4
		cmp eax, 57
		ja short Faktor_Null_4
		sub eax, 48
		imul eax, 100
		cvtsi2sd xmm1, eax
		add edi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		movsd xmm1, xmm7

	Zehner_Stelle_1:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		jb short Faktor_Null_5
		cmp eax, 57
		ja short Faktor_Null_5
		sub eax, 48
		imul eax, 10
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		add edi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		movsd xmm1, xmm7

	Einer_Stelle_2:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 48
		ja short Faktor_Null_6
		cmp eax, 57
		jl short Faktor_Null_6
		sub eax, 48
		cvtsi2sd xmm2, eax
		addsd xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		movsd xmm1, xmm7

	Faktor_38:
		ucomisd xmm1, dDreihunderacht
		jbe short Kopf_3
		ucomisd xmm1, dMinusDreihunderacht
		jge short Kopf_3
		movsd xmm1, xmm7

	Kopf_3:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZehn
		jmp short Kopf_3

	Exponent_Eins:
		movsd xmm0, dEins

	Kopf_4:
		ucomisd xmm1, xmm7
		jmp short Kopf_Ende
		subsd xmm1, dEins
		mulsd xmm0, dZwei
		jmp short Kopf_4

	Gleich_48:
		cmp eax, 48
		jl short FZahl_Null
		cmp eax, 57
		ja short FZahl_Null
		sub eax, 48
		cvtsi2sd xmm2, eax
		divsd xmm2, xmm1
		addsd xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Faktor_Zehn:
		mulsd xmm1, dZehn
		jmp Kopf_Anfang

	Kopf_Ende:
		pop edi ; ucStelle
		movsd xmm1, dEins

		test edi, edi
		jne Fuss_Anfang
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Exponent_1
		cmp eax, 46
		je short Exponent_1

	Fuss_Anfang:
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]
		cmp eax, 46
		je short Stelle_Minus
		cmp eax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub edi, 1
		mov eax, esi
		add eax, edi
		movzx eax, byte ptr [eax]

	Stelle_45:
		cmp eax, 45
		jne short Stelle_32
		mulsd xmm3, dMinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp eax, 32
		je short Exponent_1
		cmp eax, 95
		je short Exponent_1
		cmp eax, 48
		jb short FZahl_Null_1
		cmp eax, 57
		ja short FZahl_Null_1
		sub eax, 48
		cvtsi2sd xmm2, eax
		mulsd xmm2, xmm1
		addsd xmm3, xmm2
		jmp short Fuss_Ende

	FZahl_Null_1:
		movsd xmm2, xmm7
		divsd xmm2, xmm1
		addsd xmm3, xmm2

	Fuss_Ende:
		mulsd xmm1, dZehn
		test edi, edi
		je short Exponent_1
		sub edi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		ucomisd xmm0, xmm7
		jg short FZahl_Mul
		ucomisd xmm0, xmm7
		jl short FZahl_Div
		jmp short Ende_Double

	FZahl_Mul:
		mulsd xmm3, xmm0
		jmp short Ende_Double

	FZahl_Div:
		mulsd xmm0, dMinusEins
		movsd xmm2, xmm0
		divsd xmm3, xmm2

	Ende_Double:
		pop ecx ; pk4_80Zahl
		movsd xmm0, xmm3

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

	  movsd	qword ptr s_dZahl[esp], xmm0
    fld qword ptr s_dZahl[esp]
    fistp qword ptr s_dZahl[esp]
    fild qword ptr s_dZahl[esp]
    movq xmm2, qword ptr s_dZahl[esp]
    fstp qword ptr s_dZahl[esp]
    movsd xmm1, qword ptr s_dZahl[esp]
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    cmp ebx, 0
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    paddq xmm2, llEins
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    psubq xmm2, llEins
    
  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm2
    mov word ptr COComma4_80_sNachKomma[ecx], dx
    mov word ptr COComma4_80_sNachKomma_A[ecx], dx

		mov eax, ecx
    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
?COMMA4_80@COStringA@System@RePag@@QAQPAVCOComma4_80@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?BIT128fromGUID@COStringA@System@RePag@@QAQAAY0BA@EAAY0BA@E@Z PROC ; COStringA::BIT128fromGUID(BIT128& bit128Zahl)
		push ebp
		push esi
		push edi
		push ebx

		mov ebp, ecx
		mov esi, dword ptr COStringA_vbInhalt[ebp]
		mov edi, edx

		xorpd xmm0, xmm0
		xorpd xmm1, xmm1
		xorpd xmm2, xmm2
		xor eax, eax
		xor edx, edx
		xor ecx, ecx
		jmp short Fuss_Anfang

  Trennung:
		sub ch, 1

	Nachste_Zeichen:
		add esi, 1
		add ch, 1

	Fuss_Anfang:
		mov al, byte ptr [esi]
		cmp al, 2dh
		je short Trennung

		cmp al, 60h
		jbe short Grossbuchstaben
		sub al, 57h
		jmp short Hexwert

	Grossbuchstaben:
	  cmp al, 40h
		jbe short Zahlen
		sub al, 37h
		jmp short Hexwert

	Zahlen:
		sub al, 30h

	Hexwert:
		test cl, cl
		jne short Copy_8bit

		add cl, 1
		shl eax, 12
		jmp short Nachste_Zeichen

	Copy_8bit:
		add ah, al
		mov bl, ah

		cmp ch, 7
		jae short Copy_32bit

		shl ebx, 8
		xor cl, cl
		jmp short Nachste_Zeichen

	Copy_32bit:
		movd xmm1, ebx
		paddd xmm2, xmm1

		test dl, dl
		je short Shift_32
		xor dl, dl

		test dh, dh
		je short Copy_Quad
		paddq xmm0, xmm2
		jmp short Ende

  Copy_Quad:
		movlhps xmm0, xmm2
		pxor xmm2, xmm2
		add dh, 1
		xor cx, cx
		jmp short Nachste_Zeichen

	Shift_32:
		psllq xmm2, 32
		add dl, 1
		xor cx, cx
		jmp short Nachste_Zeichen

	Ende:
		movdqu xmmword ptr [edi], xmm0
		pop ebx
		pop edi
		pop esi
		pop ebp
		ret
?BIT128fromGUID@COStringA@System@RePag@@QAQAAY0BA@EAAY0BA@E@Z ENDP
;----------------------------------------------------------------------------
?IsIntegralNumber@COStringA@System@RePag@@QAQ_NXZ PROC ; COStringA::IsIntegralNumber(void)
		push ebx
		
		xor eax, eax
		mov edx, dword ptr COStringA_ulLange[ecx]
		test edx, edx
		je Ende

		xor ebx, ebx
		xor edx, edx

	Kopf_1_Anfang:
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, ebx
		movzx eax, byte ptr [eax]
		cmp eax, 32
		je short StellePlus
		cmp eax, 95
		je short StellePlus
		jmp Kopf_1_Ende

	StellePlus:
		add ebx, 1
		jmp short Kopf_1_Anfang

	Kopf_1_Ende:
		cmp eax, 44
		je Ende
		cmp eax, 46
		je Ende
		cmp eax, 45
		je short StellePlus_1
		jmp short Kopf_2_Anfang

	StellePlus_1:
		add ebx, 1

	Kopf_2_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[ecx]
		jae short True
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		add eax, ebx
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Z44_Punkt
		cmp eax, 46
		je short Z44_Punkt
		cmp eax, 47
		jbe short False
		cmp eax, 58
		jae short False

	Z44_Punkt:
		cmp eax, 44
		jne short Z44_0ucKomma_0ucPunkt
		test dh, dh
		jne short False

	Z44_0ucKomma_0ucPunkt:
		cmp eax, 44
		jne short Z44_ucKomma_ucPunkt
		test dh, dh
		jne short Z44_ucKomma_ucPunkt
		test dl, dl
		jne short Z44_ucKomma_ucPunkt
		mov dl, bl
		jmp short Kopf_2_Ende

	Z44_ucKomma_ucPunkt:
		cmp eax, 44
		jne short Z46_ucKomma
		test dl, dl
		je short Z46_ucKomma
		test dh, dh
		je short Z46_ucKomma
		jmp short False

	Z46_ucKomma:
		cmp eax, 46
		jne short Z46_0ucKomma_0ucPunkt
		test dl, dl
		jne short False

	Z46_0ucKomma_0ucPunkt:
		cmp eax, 46
		jne short Z46_ucKomma_ucPunkt
		test dh, dh
		jne short Z46_ucKomma_ucPunkt
		test dl, dl
		jne short Z46_ucKomma_ucPunkt
		mov dh, bl
		jmp short Kopf_2_Ende

	Z46_ucKomma_ucPunkt:
		cmp eax, 46
		jne short Kopf_2_Ende
		test dh, dh
		jne short Kopf_2_Ende
		test dl, dl
		jne short Kopf_2_Ende
		jmp short False


	Kopf_2_Ende:
		add ebx, 1
		jmp short Kopf_2_Anfang

	True:
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
	  pop ebx
		ret
?IsIntegralNumber@COStringA@System@RePag@@QAQ_NXZ ENDP
;----------------------------------------------------------------------------
?IsFloatingPointNumber@COStringA@System@RePag@@QAQ_NXZ PROC ; COStringA::IsFloatingPointNumber(void)
		push ebx
		push ebp
		
		xor eax, eax
		mov ebp, ecx
		mov edx, dword ptr COStringA_ulLange[ebp]
		test edx, edx
		je Ende

		xor ebx, ebx
		xor edx, edx
		xor ecx, ecx

	Kopf_1_Anfang:
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]
		cmp eax, 32
		je short StellePlus
		cmp eax, 95
		je short StellePlus
		jmp Kopf_1_Ende

	StellePlus:
		add ebx, 1
		jmp short Kopf_1_Anfang

	Kopf_1_Ende:
		cmp eax, 44
		je Ende
		cmp eax, 46
		je Ende
		cmp eax, 45
		je short StellePlus_1
		jmp short Kopf_2_Anfang

	StellePlus_1:
		add ebx, 1

	Kopf_2_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[ebp]
		jae True
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]
		cmp eax, 44
		je short Z44_0ucKomma
		cmp eax, 46
		je short Z44_0ucKomma
		cmp eax, 47
		jbe short Z42_bExponent
		cmp eax, 58
		jae short Z42_bExponent

	Z44_0ucKomma:
		cmp eax, 44
		jne short Z44_ucKomma_ucPunkt
		test dl, dl
		jne short Z44_ucKomma_ucPunkt
		mov dl, bl
		jmp Kopf_2_Ende

	Z44_ucKomma_ucPunkt:
		cmp eax, 44
		jne short Z46_0ucPunkt
		test dl, dl
		je short Z46_0ucPunkt
		test dh, dh
		je short Z46_0ucPunkt
		jmp False

	Z46_0ucPunkt:
		cmp eax, 46
		jne short Z46_ucKomma_ucPunkt
		test dh, dh
		jne short Z46_ucKomma_ucPunkt
		mov dh, bl
		jmp short Kopf_2_Ende

	Z46_ucKomma_ucPunkt:
		cmp eax, 46
		jne short Kopf_2_Ende
		test dh, dh
		jne short Kopf_2_Ende
		test dl, dl
		jne short Kopf_2_Ende
		jmp short False

	Z42_bExponent:
		cmp eax, 42
		jne short False
		test cl, cl
		jne short False
		add ebx, 1
		mov cl, 1

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]
		cmp eax, 49
		jne short Z50
		add ebx, 3
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]
		jmp short Z45

	Z50:
		cmp eax, 50
		jne short False
		add ebx, 2
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]

	Z45:
		cmp eax, 45
		jne short Kopf_3_Anfang
		add ebx, 1
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]

	Kopf_3_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[ebp]
		jb short True
		cmp eax, 47
		jb short False
		cmp eax, 58
		ja short False
		add ebx, 1
		mov eax, dword ptr COStringA_vbInhalt[ebp]
		add eax, ebx
		movzx eax, byte ptr [eax]
		jmp Kopf_3_Anfang

	Kopf_2_Ende:
		add ebx, 1
		jmp Kopf_2_Anfang

	True:
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		pop ebp
	  pop ebx
		ret
?IsFloatingPointNumber@COStringA@System@RePag@@QAQ_NXZ ENDP
;----------------------------------------------------------------------------
?Uppercase@COStringA@System@RePag@@QAQXXZ PROC ; COStringA::Uppercase(void)
		push edi

		mov eax, dword ptr COStringA_ulLange[ecx]
		test eax, eax
		je short Ende
		xor edx, edx

	For_Anfang:
		cmp edx, dword ptr COStringA_ulLange[ecx]
		je short Ende
		mov edi, dword ptr COStringA_vbInhalt[ecx]
		add edi, edx
		movzx eax, byte ptr [edi]
		cmp eax, 97
		jb short For_Ende
		cmp eax, 122
		ja short For_Ende
		sub byte ptr [edi], 32

	For_Ende:
		add edx, 1
		jmp short For_Anfang

	Ende:
		pop edi
		ret
?Uppercase@COStringA@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
?c_Str@COStringA@System@RePag@@QAQPADXZ PROC ; COStringA::c_Str(void)
		mov eax, dword ptr COStringA_vbInhalt[ecx]
		ret
?c_Str@COStringA@System@RePag@@QAQPADXZ ENDP
;----------------------------------------------------------------------------
?Length@COStringA@System@RePag@@QAQKXZ PROC ; COStringA::Length(void)
		mov eax, dword ptr COStringA_ulLange[ecx]
		ret
?Length@COStringA@System@RePag@@QAQKXZ ENDP
;----------------------------------------------------------------------------
?SetLength@COStringA@System@RePag@@QAQXK@Z PROC ; COStringA::SetLength(ulStrLange)
		push ebp

		mov ebp, ecx
		push edx

		mov eax, dword ptr COStringA_vbInhalt[ebp]
		test eax, eax
    je short Freigeben_Kopie
    mov edx, dword ptr COStringA_vbInhalt[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov eax, dword ptr COStringA_vbInhalt[ebp]
    cmp eax, dword ptr COStringA_vbInhalt_A[ebp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov eax, dword ptr COStringA_vbInhalt_A[ebp]
    test eax, eax
    je short Freigeben_Ende
    mov edx, dword ptr COStringA_vbInhalt_A[ebp]
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		pop edx
		mov dword ptr COStringA_ulLange[ebp], edx
		mov dword ptr COStringA_ulLange_A[ebp], edx

		test edx, edx
		je short Inhalt_Null
		push edx
		;push ecx
		add edx, 1
    mov ecx, dword ptr COStringA_vmSpeicher[ebp]
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		;pop ecx
		pop edx
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax
		add eax, edx
		xor dl, dl
		mov byte ptr [eax], dl
		jmp short Ende

	Inhalt_Null:
	  xor eax, eax
		mov dword ptr COStringA_vbInhalt[ebp], eax
		mov dword ptr COStringA_vbInhalt_A[ebp], eax

	Ende:
		pop ebp
		ret
?SetLength@COStringA@System@RePag@@QAQXK@Z ENDP
;----------------------------------------------------------------------------
CS_OStringA ENDS
END