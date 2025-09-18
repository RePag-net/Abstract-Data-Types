;******************************************************************************
;MIT License

;Copyright(c) 2025 René Pagel

;Filename: OKomma40_x86.asm
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
.686P
.XMM
.MODEL FLAT
INCLUDE listing.inc
INCLUDE ..\..\Include\CompSys.inc
INCLUDE ..\..\Include\ADT.inc
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

.DATA
ucBY_COKOMMMA4 DB 24
dHalbkreis DQ 180.0
dZehn DQ 10.0
dHundert DQ 100.0
dTausend DQ 1000.0
dZehntausend DQ 10000.0
dEinsNullAcht DQ 100000000.0
dNull DQ 0.0
dMinusEins DQ -1.0
dFunf DQ 5.0
dMinusFunf DQ -5.0
dEins DQ 1.0
fZehntausend DD 10000.0

CS_OKomma4 SEGMENT EXECUTE
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@XZ PROC ; COComma4V(void)
    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor ecx, ecx
    mov dword ptr COComma4_vmSpeicher[eax], ecx
    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@XZ ENDP
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBX@Z PROC ; COComma4V(vmSpeicher)
    push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    
		pop ecx ; vmSpeicher
    mov dword ptr COComma4_vmSpeicher[eax], ecx
    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBX@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
sqd_Zahl = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@N@Z PROC ; COComma4V(dZahl)
    push ebx
    sub esp, esp_Bytes

    movsd qword ptr sqd_Zahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

	  movsd	xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    cvttsd2si ecx, xmm1
    cvtsi2sd xmm1, ecx
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    test ebx, ebx
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    add ecx, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    sub ecx, 1

  Ende:
		xor ebx, ebx
    mov dword ptr COComma4_vmSpeicher[eax], ebx
    mov dword ptr COComma4_lVorKomma[eax], ecx
    mov dword ptr COComma4_lVorKomma_A[eax], ecx
    mov word ptr COComma4_sNachKomma[eax], dx
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
sqd_Zahl = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXN@Z PROC ; COComma4V(vmSpeicher, dZahl)
    push ebx
    sub esp, esp_Bytes

    mov ebx, ecx
    movsd qword ptr sqd_Zahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov dword ptr COComma4_vmSpeicher[eax], ebx

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

	  movsd	xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    cvttsd2si ecx, xmm1
    cvtsi2sd xmm1, ecx
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    test ebx, ebx
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    add ecx, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    sub ecx, 1

  Ende:
    mov dword ptr COComma4_lVorKomma[eax], ecx
    mov dword ptr COComma4_lVorKomma_A[eax], ecx
    mov word ptr COComma4_sNachKomma[eax], dx
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@H@Z PROC ; COComma4V(iZahl)
		push ecx ; iZahl

    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; iZahl

		xor edx, edx
    mov dword ptr COComma4_vmSpeicher[eax], edx
    mov dword ptr COComma4_lVorKomma[eax], ecx
    mov dword ptr COComma4_lVorKomma_A[eax], ecx
    mov word ptr COComma4_sNachKomma[eax], dx
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@H@Z ENDP
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXH@Z PROC ; COComma4V(vmSpeicher, iZahl)
		push ecx ; vmSpeicher
		push edx ; iZahl

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; iZahl
		pop ecx ; vmSpeicher

    mov dword ptr COComma4_vmSpeicher[eax], ecx
    mov dword ptr COComma4_lVorKomma[eax], edx
    mov dword ptr COComma4_lVorKomma_A[eax], edx
		xor ecx, ecx
    mov word ptr COComma4_sNachKomma[eax], cx
    mov word ptr COComma4_sNachKomma_A[eax], cx

    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXH@Z ENDP
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@PBV312@@Z PROC ; COComma4V(pk4Zahl)
		push ecx ; pk4Zahl

    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; pk4Zahl

		xor edx, edx
    mov dword ptr COComma4_vmSpeicher[eax], edx
    mov edx, dword ptr COComma4_lVorKomma[ecx]
    mov dword ptr COComma4_lVorKomma[eax], edx
    mov edx, dword ptr COComma4_lVorKomma_A[ecx]
    mov dword ptr COComma4_lVorKomma_A[eax], edx
    movsx edx, word ptr COComma4_sNachKomma[ecx]
    mov word ptr COComma4_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_sNachKomma_A[ecx]
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@PBV312@@Z ENDP
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXPBV312@@Z PROC ; COComma4V(vmSpeicher, pk4Zahl)
		push ecx ; vmSpeicher
		push edx ; pk4Zahl

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; pk4Zahl
		pop edx ; vmSpeicher

    mov dword ptr COComma4_vmSpeicher[eax], edx
    mov edx, dword ptr COComma4_lVorKomma[ecx]
    mov dword ptr COComma4_lVorKomma[eax], edx
    mov edx, dword ptr COComma4_lVorKomma_A[ecx]
    mov dword ptr COComma4_lVorKomma_A[eax], edx
    movsx edx, word ptr COComma4_sNachKomma[ecx]
    mov word ptr COComma4_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_sNachKomma_A[ecx]
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXPBV312@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
sxd_m128dZahl = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@U__m128d@@@Z PROC ; COComma4V(m128dZahl)
    push ebx
    sub esp, esp_Bytes

    movsd qword ptr sxd_m128dZahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

	  movsd	xmm0, qword ptr sxd_m128dZahl[esp]
    movsd xmm1, xmm0
    cvttsd2si ecx, xmm1
    cvtsi2sd xmm1, ecx
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    test ebx, ebx
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    add ecx, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    sub ecx, 1

  Ende:
		xor ebx, ebx
    mov dword ptr COComma4_vmSpeicher[eax], ebx
    mov dword ptr COComma4_lVorKomma[eax], ecx
    mov dword ptr COComma4_lVorKomma_A[eax], ecx
    mov word ptr COComma4_sNachKomma[eax], dx
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
sxd_m128dZahl = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXU__m128d@@@Z PROC ; COComma4V(vmSpeicher, m128dZahl)
    push ebx
    sub esp, esp_Bytes

    mov ebx, ecx
    movsd qword ptr sxd_m128dZahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov dword ptr COComma4_vmSpeicher[eax], ebx

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

	  movsd	xmm0, qword ptr sxd_m128dZahl[esp]
    movsd xmm1, xmm0
    cvttsd2si ecx, xmm1
    cvtsi2sd xmm1, ecx
    subsd xmm0, xmm1
    mulsd xmm0, dZehntausend
    cvtsd2si edx, xmm0
    cvtsi2sd xmm1, edx
    subsd xmm0, xmm1
    mulsd xmm0, dZehn
    cvtsd2si ebx, xmm0

    test ebx, ebx
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add edx, 1
    cmp edx, 10000
    jb short Ende
    xor edx, edx
    add ecx, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub edx, 1
    cmp edx, -10000
    jg short Ende
    xor edx, edx
    sub ecx, 1

  Ende:
    mov dword ptr COComma4_lVorKomma[eax], ecx
    mov dword ptr COComma4_lVorKomma_A[eax], ecx
    mov word ptr COComma4_sNachKomma[eax], dx
    mov word ptr COComma4_sNachKomma_A[eax], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@T__m128i@@@Z PROC ; COComma4V(mi128Zahl)
    push ebx

    movd ebx, xmm0

    movzx edx, ucBY_COKOMMMA4
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor ecx, ecx
    mov dword ptr COComma4_vmSpeicher[eax], ecx
    mov dword ptr COComma4_lVorKomma[eax], ebx
    mov dword ptr COComma4_lVorKomma_A[eax], ebx
    mov word ptr COComma4_sNachKomma[eax], cx
    mov word ptr COComma4_sNachKomma_A[eax], cx

    pop ebx
    ret
?COComma4V@System@RePag@@YQPAVCOComma4@12@T__m128i@@@Z ENDP
;----------------------------------------------------------------------------
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXT__m128i@@@Z PROC ;  COComma4V(vmSpeicher, m128iZahl)
    push ebx

    movd ebx, xmm0
		push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; vmSpeicher

    mov dword ptr COComma4_vmSpeicher[eax], edx
    mov dword ptr COComma4_lVorKomma[eax], ebx
    mov dword ptr COComma4_lVorKomma_A[eax], ebx
		xor ecx, ecx
    mov word ptr COComma4_sNachKomma[eax], cx
    mov word ptr COComma4_sNachKomma_A[eax], cx

    pop ebx
    ret
?COComma4V@System@RePag@@YQPAVCOComma4@12@QBXT__m128i@@@Z ENDP
;----------------------------------------------------------------------------
?COFreiV@COComma4@System@RePag@@QAQPBXXZ PROC ; COComma4::COFreiV(void)
    mov eax, dword ptr COComma4_vmSpeicher[ecx]
    ret
?COFreiV@COComma4@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
??0COComma4@System@RePag@@QAE@XZ PROC ; COComma4::COComma4(void)
    xor eax, eax
    mov dword ptr COComma4_vmSpeicher[ecx], eax
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax
    ret
??0COComma4@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_iZahl = 4
??0COComma4@System@RePag@@QAE@H@Z PROC; COComma4::COComma4(iZahl)
		xor edx, edx
    mov eax, dword ptr a_iZahl[esp]
    mov dword ptr COComma4_vmSpeicher[ecx], edx
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx
    ret 4
??0COComma4@System@RePag@@QAE@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_k4Zahl$ = 4
??0COComma4@System@RePag@@QAE@ABV012@@Z PROC ; COComma4::COComma4(&k4Zahl)
		xor eax, eax
    mov dword ptr COComma4_vmSpeicher[ecx], eax
    mov eax, dword ptr a_k4Zahl$[esp]
    mov edx, dword ptr COComma4_lVorKomma[eax]
    mov dword ptr COComma4_lVorKomma[ecx], edx
    mov edx, dword ptr COComma4_lVorKomma_A[eax]
    mov dword ptr COComma4_lVorKomma_A[ecx], edx
    movsx edx, word ptr COComma4_sNachKomma[eax]
    mov word ptr COComma4_sNachKomma[ecx], dx
    movsx edx, word ptr COComma4_sNachKomma_A[eax]
    mov word ptr COComma4_sNachKomma_A[ecx], dx
    ret 4
??0COComma4@System@RePag@@QAE@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??0COComma4@System@RePag@@QAE@N@Z PROC ; COComma4::COComma4(dZahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

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

    test ebx, ebx
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
	  xor ebx, ebx
    mov dword ptr COComma4_vmSpeicher[ecx], ebx
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 8
??0COComma4@System@RePag@@QAE@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??0COComma4@System@RePag@@QAE@T__m128i@@@Z PROC ; COComma4::COComma4(m128iZahl)
    movd eax, xmm0
		xor edx, edx
    mov dword ptr COComma4_vmSpeicher[ecx], edx
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx
    ret
??0COComma4@System@RePag@@QAE@T__m128i@@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??0COComma4@System@RePag@@QAE@U__m128d@@@Z PROC ; COComma4::COComma4(m128dZahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

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

    test ebx, ebx
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
		xor ebx, ebx
    mov dword ptr COComma4_vmSpeicher[ecx], ebx
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??0COComma4@System@RePag@@QAE@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??4COComma4@System@RePag@@QAQXN@Z PROC ; COComma4::operator=(dZahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

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

    test ebx, ebx
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

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??4COComma4@System@RePag@@QAQXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COComma4@System@RePag@@QAQXH@Z PROC ; COComma4_80::operator=(iZahl)
    xor eax, eax
		mov dword ptr COComma4_lVorKomma[ecx], edx
    mov dword ptr COComma4_lVorKomma_A[ecx], edx
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax
		ret 0
??4COComma4@System@RePag@@QAQXH@Z ENDP
;----------------------------------------------------------------------------
??4COComma4@System@RePag@@QAQXABV012@@Z PROC ; COComma4::operator=(&k4Zahl)
    mov eax, dword ptr COComma4_lVorKomma_A[edx]
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax

    movsx eax, word ptr COComma4_sNachKomma_A[edx]
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    ret 0
??4COComma4@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
??4COComma4@System@RePag@@QAQXT__m128i@@@Z PROC ; COComma4::operator=(m128iZahl)
    movd eax, xmm0

		xor edx, edx
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], dx
    mov word ptr COComma4_sNachKomma_A[ecx], dx

    ret 0
??4COComma4@System@RePag@@QAQXT__m128i@@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??4COComma4@System@RePag@@QAQXU__m128d@@@Z PROC ; COComma4::operator=(m128dZahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

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

    test ebx, ebx
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

    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??4COComma4@System@RePag@@QAQXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??YCOComma4@System@RePag@@QAQXABV012@@Z PROC ; COComma4::operator+=(&k4Zahl)
    push ebx

    mov eax, dword ptr COComma4_lVorKomma[ecx]
    add eax, dword ptr COComma4_lVorKomma_A[edx]

    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    add bx, word ptr COComma4_sNachKomma_A[edx]

    test bx, bx
    je short Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma[ecx], 0
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl short Ende
    sub bx, 10000
    add eax, 1
    jmp short Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma[ecx], 0
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg short Ende
    sub bx, -10000
    sub eax, 1
    jmp short Ende

  NachKomma_Plus_Einer_Minus:
    test eax, eax
    jge short Ende
		sub bx, 10000
    ;imul bx, -1
    add eax, 1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
    test eax, eax
    jle short Ende
    add bx, 10000
		;imul bx, -1
    sub eax, 1
    jmp short Ende

  Ende:
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], bx
    mov word ptr COComma4_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
    pop ebx
    ret 0
??YCOComma4@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
??HCOComma4@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4::operator+(&k4Zahl)
    push ebx

    mov eax, dword ptr COComma4_lVorKomma_A[ecx]
    add eax, dword ptr COComma4_lVorKomma_A[edx]

    movsx ebx, word ptr COComma4_sNachKomma_A[ecx]
    add bx, word ptr COComma4_sNachKomma_A[edx]

    test bx, bx
    je short Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma_A[ecx], 0
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl short Ende
    sub bx, 10000
    add eax, 1
    jmp short Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma_A[ecx], 0
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg short Ende
    sub bx, -10000
    sub eax, 1
    jmp short Ende

  NachKomma_Plus_Einer_Minus:
    test eax, eax
    jge short Ende
		sub bx, 10000
    ;imul bx, -1
    add eax, 1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
    test eax, eax
    jle short Ende
		add bx, 10000
    ;imul bx, -1
    sub eax, 1
    jmp short Ende

  Ende:
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma_A[ecx], bx

		mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    mov eax, ecx
    
    pop ebx
    ret 0
??HCOComma4@System@RePag@@QAQAAV012@ABV012@@Z ENDP
;----------------------------------------------------------------------------
??ZCOComma4@System@RePag@@QAQXABV012@@Z PROC ; COComma4::operator-=(&k4Zahl)
    push ebx

    mov eax, dword ptr COComma4_lVorKomma[ecx]
    sub eax, dword ptr COComma4_lVorKomma_A[edx]

    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    sub bx, word ptr COComma4_sNachKomma_A[edx]

    test bx, bx
    je short Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jl short NachKomma_Plus_Zweiter_Minus
    test eax, eax
    jge short Ende
    ;imul bx, -1
		sub bx, 10000
    add eax, 1
    jmp short Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jge short NachKomma_Minus_Zweiter_Plus
    test eax, eax
    jle short Ende
    ;imul bx, -1
		add bx, 10000
    sub eax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		add eax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
		add bx, 10000
    sub eax, 1   

  Ende:
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], bx
    mov word ptr COComma4_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
    pop ebx
    ret 0
??ZCOComma4@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
??GCOComma4@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4::operator-(&k4Zahl)
    push ebx

		mov eax, dword ptr COComma4_lVorKomma_A[ecx]
    sub eax, dword ptr COComma4_lVorKomma_A[edx]

    movsx ebx, word ptr COComma4_sNachKomma_A[ecx]
    sub bx, word ptr COComma4_sNachKomma_A[edx]

    test bx, bx
    je short Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jl short NachKomma_Plus_Zweiter_Minus
    test eax, eax
    jge short Ende
		sub bx, 10000
    add eax, 1
    jmp short Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma_A[edx], 0
    jge short NachKomma_Minus_Zweiter_Plus
    test eax, eax
    jle short Ende
		add bx, 10000
    sub eax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		add eax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
    add bx, 10000
    sub eax, 1  

  Ende:
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma_A[ecx], bx

		mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    mov eax, ecx
    
    pop ebx
    ret 0
??GCOComma4@System@RePag@@QAQAAV012@ABV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqi_VorKomma  = 12
swi_c2Runden_Alt = 10
swi_c2Runden = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??XCOComma4@System@RePag@@QAQXABV012@@Z PROC ; COComma4::operator*=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mov eax, dword ptr COComma4_lVorKomma[ecx]
    cvtsi2sd xmm0, eax 
		movsd xmm4, xmm0
    mov eax, dword ptr COComma4_lVorKomma_A[edx]
		cvtsi2sd xmm1, eax
		mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

    xor dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw swi_Runden_Alt[esp]
		fstcw swi_Runden[esp]
    bts word ptr swi_Runden[esp], 10
    bts word ptr swi_Runden[esp], 11
    fldcw swi_Runden[esp]
    fclex

		movsd qword ptr sqi_VorKomma[esp], xmm4
		fld qword ptr sqi_VorKomma[esp]
		fistp qword ptr sqi_VorKomma[esp]
		fild qword ptr sqi_VorKomma[esp]
		fst qword ptr sqi_VorKomma[esp]
		movsd xmm0, qword ptr sqi_VorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp dword ptr sqi_VorKomma[esp]
		mov eax, dword ptr sqi_VorKomma[esp]

    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], bx
    mov word ptr COComma4_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??XCOComma4@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqi_VorKomma  = 12
swi_Runden_Alt = 10
swi_Runden = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??DCOComma4@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4::operator*(&k4Zahl)
    push ebx
    sub esp, esp_Bytes

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    bts dword ptr sdi_MXCSR[esp], 14
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mov eax, dword ptr COComma4_lVorKomma_A[ecx]
    cvtsi2sd xmm0, eax 
		movsd xmm4, xmm0
    mov eax, dword ptr COComma4_lVorKomma_A[edx]
		cvtsi2sd xmm1, eax
		mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

    xor dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw swi_Runden_Alt[esp]
		fstcw swi_Runden[esp]
    bts word ptr swi_Runden[esp], 10
    bts word ptr swi_Runden[esp], 11
    fldcw swi_Runden[esp]
    fclex

		movsd qword ptr sqi_VorKomma[esp], xmm4
		fld qword ptr sqi_VorKomma[esp]
		fistp qword ptr sqi_VorKomma[esp]
		fild qword ptr sqi_VorKomma[esp]
		fst qword ptr sqi_VorKomma[esp]
		movsd xmm0, qword ptr sqi_VorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp dword ptr sqi_VorKomma[esp]
		mov eax, dword ptr sqi_VorKomma[esp]

    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma_A[ecx], bx

		mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    mov eax, ecx
    
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??DCOComma4@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??_0COComma4@System@RePag@@QAQXABV012@@Z PROC ; COComma4::operator/=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cvtsi2sd xmm0, ebx 
    mov ebx, dword ptr COComma4_lVorKomma_A[edx]
    cvtsi2sd xmm1, ebx 

    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx

    divsd xmm2, dZehntausend
    addsd xmm0, xmm2
    divsd xmm3, dZehntausend
    addsd xmm1, xmm3

    divsd xmm0, xmm1
    cvtsd2si eax, xmm0
    cvtsi2sd xmm1, eax
    subsd xmm0, xmm1

    xor dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mulsd xmm0, dZehntausend
    cvtsd2si ebx, xmm0

    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], bx
    mov word ptr COComma4_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??_0COComma4@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
??KCOComma4@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4::operator/(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mov ebx, dword ptr COComma4_lVorKomma_A[ecx]
    cvtsi2sd xmm0, ebx 
    mov ebx, dword ptr COComma4_lVorKomma_A[edx]
    cvtsi2sd xmm1, ebx 

    movsx ebx, word ptr COComma4_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx

    divsd xmm2, dZehntausend
    addsd xmm0, xmm2
    divsd xmm3, dZehntausend
    addsd xmm1, xmm3

    divsd xmm0, xmm1
    cvtsd2si eax, xmm0
    cvtsi2sd xmm1, eax
    subsd xmm0, xmm1

    xor dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    mulsd xmm0, dZehntausend
    cvtsd2si ebx, xmm0

    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma_A[ecx], bx

		mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    mov eax, ecx
    
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??KCOComma4@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Compare@COComma4@System@RePag@@QAQDPBV123@@Z PROC ; COComma4::Compare(pk4Zahl)
    push ebx

    mov eax, -1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    jb short Ende
    mov eax, 1
    ja short Ende
    mov eax, -1
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jb short Ende
    mov eax, 1
    ja short Ende
    xor eax, eax

  Ende:
    pop ebx
    ret 0
?Compare@COComma4@System@RePag@@QAQDPBV123@@Z ENDP
;----------------------------------------------------------------------------
??MCOComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator<(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jb short Ende

  Ungleich:
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??MCOComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator>(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    ja short Ende

  Ungleich:
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??OCOComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??NCOComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator<=(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jbe short Ende

  Ungleich:
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??NCOComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??PCOComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator>=(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jae short Ende

  Ungleich:
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??PCOComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??8COComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator==(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    jne short Ungleich
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    je short Ende

  Ungleich:
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??8COComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??9COComma4@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4::operator!=(&k4Zahl)
    push ebx

    mov eax, 1
    mov ebx, dword ptr COComma4_lVorKomma[ecx]
    cmp ebx, dword ptr COComma4_lVorKomma[edx]
    jne short Ende
    movsx ebx, word ptr COComma4_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jne short Ende
    xor eax, eax

  Ende:
    pop ebx
    ret 0
??9COComma4@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??ECOComma4@System@RePag@@QAQXXZ PROC ; COComma4::operator++(void)
		mov eax, dword ptr COComma4_lVorKomma[ecx] 
		test eax, eax
		jne short UngleichNull
		xor ax, ax
		cmp word ptr COComma4_sNachKomma[ecx], ax
		jge short UngleichNull
		add word ptr COComma4_sNachKomma[ecx], 10000
		jmp short Ende

	UngleichNull:
    add dword ptr COComma4_lVorKomma[ecx], 1

  Ende:
		mov eax, dword ptr COComma4_lVorKomma[ecx]
		mov dword ptr COComma4_lVorKomma_A[ecx], eax
		movsx eax, word ptr COComma4_sNachKomma[ecx]
		mov word ptr COComma4_lVorKomma_A[ecx], ax
    ret 0
??ECOComma4@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
??ECOComma4@System@RePag@@QAQXH@Z PROC ; COComma4::operator++(int i)
    mov eax, dword ptr COComma4_lVorKomma[ecx]
		test eax, eax
		jne short UngleichNull
		xor ax, ax
		cmp word ptr COComma4_sNachKomma[ecx], ax
		jge short UngleichNull
		add word ptr COComma4_sNachKomma[ecx], 10000
		jmp short Ende

	UngleichNull:
    add dword ptr COComma4_lVorKomma[ecx], 1

  Ende:
		mov eax, dword ptr COComma4_lVorKomma[ecx]
		mov dword ptr COComma4_lVorKomma_A[ecx], eax
		movsx eax, word ptr COComma4_sNachKomma[ecx]
		mov word ptr COComma4_lVorKomma_A[ecx], ax
    ret
??ECOComma4@System@RePag@@QAQXH@Z ENDP
;----------------------------------------------------------------------------
??FCOComma4@System@RePag@@QAQXXZ	PROC ; COComma4::operator--(void)
		mov eax, dword ptr COComma4_lVorKomma[ecx]
		test eax, eax
		jne short UngleichNull
		xor ax, ax
		cmp word ptr COComma4_sNachKomma[ecx], ax
		jle short UngleichNull
		add word ptr COComma4_sNachKomma[ecx], -10000
		jmp short Ende

	UngleichNull:
    sub dword ptr COComma4_lVorKomma[ecx], 1

  Ende:
		mov eax, dword ptr COComma4_lVorKomma[ecx]
		mov dword ptr COComma4_lVorKomma_A[ecx], eax
		movsx eax, word ptr COComma4_sNachKomma[ecx]
		mov word ptr COComma4_lVorKomma_A[ecx], ax
    ret
??FCOComma4@System@RePag@@QAQXXZ	ENDP
;----------------------------------------------------------------------------
??FCOComma4@System@RePag@@QAQXH@Z PROC ; COComma4::operator--(int i)
    mov eax, dword ptr COComma4_lVorKomma[ecx]
		test eax, eax
		jne short UngleichNull
		xor ax, ax
		cmp word ptr COComma4_sNachKomma[ecx], ax
		jle short UngleichNull
		add word ptr COComma4_sNachKomma[ecx], -10000
		jmp short Ende

	UngleichNull:
    sub dword ptr COComma4_lVorKomma[ecx], 1

  Ende:
		mov eax, dword ptr COComma4_lVorKomma[ecx]
		mov dword ptr COComma4_lVorKomma_A[ecx], eax
		movsx eax, word ptr COComma4_sNachKomma[ecx]
		mov word ptr COComma4_lVorKomma_A[ecx], ax
    ret
??FCOComma4@System@RePag@@QAQXH@Z ENDP
;----------------------------------------------------------------------------
?Read@COComma4@System@RePag@@QAQXQBD@Z PROC ; COComma4::Read(cZahl[6])
    test edx, edx
    je short Ende

    mov eax, dword ptr COComma4_lVorKomma[ecx]
    mov dword ptr [edx], eax
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    mov word ptr [edx + 4], ax

  Ende:
    ret 0
?Read@COComma4@System@RePag@@QAQXQBD@Z ENDP
;----------------------------------------------------------------------------
?Write@COComma4@System@RePag@@QAQXQBD@Z PROC ; COComma4::Write(cZahl[6])
    test edx, edx
    je short Null

    mov eax, dword ptr [edx]
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    movsx eax, word ptr [edx + 4]
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax
    jmp short Ende

  Null:
		xor eax, eax
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax

  Ende:
    ret
?Write@COComma4@System@RePag@@QAQXQBD@Z ENDP
;----------------------------------------------------------------------------
?PreComma@COComma4@System@RePag@@QAQJXZ PROC ; long COComma4::PreComma(void)
    mov eax, dword ptr COComma4_lVorKomma[ecx]
    ret
?PreComma@COComma4@System@RePag@@QAQJXZ ENDP
;----------------------------------------------------------------------------
?AfterComma@COComma4@System@RePag@@QAQFXZ PROC ; short COComma4::AfterComma(void)
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    ret
?AfterComma@COComma4@System@RePag@@QAQFXZ ENDP
;----------------------------------------------------------------------------
?FLOAT@COComma4@System@RePag@@QAQMXZ PROC ; float COComma4::FLOAT(void)
    cvtsi2ss xmm0, dword ptr COComma4_lVorKomma[ecx]
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    cvtsi2ss xmm1, eax
    divss xmm1, fZehntausend
    addss xmm0, xmm1
    ret
?FLOAT@COComma4@System@RePag@@QAQMXZ ENDP
;----------------------------------------------------------------------------
?DOUBLE@COComma4@System@RePag@@QAQNXZ PROC ; double COComma4::DOUBLE(void)
    cvtsi2sd xmm0, dword ptr COComma4_lVorKomma[ecx]
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    cvtsi2sd xmm1, eax
    divsd xmm1, dZehntausend
    addsd xmm0, xmm1
    ret
?DOUBLE@COComma4@System@RePag@@QAQNXZ ENDP
;----------------------------------------------------------------------------
?M128D@COComma4@System@RePag@@QAQ?AU__m128d@@XZ PROC ; COComma4::M128D(void)
    cvtsi2sd xmm0, dword ptr COComma4_lVorKomma[ecx]
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    cvtsi2sd xmm1, eax
    divsd xmm1, dZehntausend
    addsd xmm0, xmm1
    ret
?M128D@COComma4@System@RePag@@QAQ?AU__m128d@@XZ ENDP
;----------------------------------------------------------------------------
?SetZero@COComma4@System@RePag@@QAQXXZ PROC ; COComma4::SetZero(void)
		xor eax, eax
    mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax
    ret
?SetZero@COComma4@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
sdi_MXCSR_Alt = 4
sdi_MXCSR = 0
?Round@COComma4@System@RePag@@QAQPAV123@E@Z PROC ; COComma4::Round(ucStellen)
    sub esp, esp_Bytes

    movsx eax, word ptr COComma4_sNachKomma[ecx]

    cmp dl, 4 ; ucStellen
    jae Ende
    cmp dl, 2 
    ja short Stellen_3
    jb short Stellen_1
    
; ucStellen = 2
    cmp eax, 9950
    jge short VorKommaPlusMinus
    cmp eax, -9950
    jle short VorKommaPlusMinus
    movsd xmm2, dHundert
    jmp short Runden

  Stellen_1:
    test dl, dl
    je short Stellen_0
    cmp eax, 9500
    jge short VorKommaPlusMinus
    cmp eax, -9500
    jle short VorKommaPlusMinus
    movsd xmm2, dTausend
    jmp short Runden

  Stellen_3:
    cmp eax, 9995
    jge short VorKommaPlusMinus
    cmp eax, -9995
    jle short VorKommaPlusMinus
    movsd xmm2, dZehn
    jmp short Runden   
    
  Stellen_0:
    cmp eax, 5000
    jge short VorKommaPlusMinus
    cmp eax, -5000
    jle short VorKommaPlusMinus
    movsd xmm2, dZehntausend
    jmp short Runden

  VorKommaPlusMinus:
    xor eax, eax
    cmp dword ptr COComma4_lVorKomma[ecx], eax
    jge short VorKommaPlus
    sub dword ptr COComma4_lVorKomma[ecx], 1
    sub dword ptr COComma4_lVorKomma_A[ecx], 1
    jmp Ende
  VorKommaPlus:
    add dword ptr COComma4_lVorKomma[ecx], 1
    add dword ptr COComma4_lVorKomma_A[ecx], 1
    jmp Ende

  Runden:
    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    movsd xmm3, xmm2
    cvtsi2sd xmm0, eax
    movsd xmm1, xmm0
    divsd xmm0, xmm2
    cvttsd2si eax, xmm0
    cvtsi2sd xmm0, eax
    mulsd xmm0, xmm2
    subsd xmm1, xmm0
    divsd xmm2, dZehn
    divsd xmm1, xmm2

		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    cvtsi2sd xmm0, eax
    addsd xmm0, dEins
    mulsd xmm0, xmm3
    jmp short EndeRunden

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    cvtsi2sd xmm0, eax
    subsd xmm0, dEins
    mulsd xmm0, xmm3

  EndeRunden:
    cvtsd2si eax, xmm0
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]

  Ende:
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov eax, ecx

    add esp, esp_Bytes
    ret 0
?Round@COComma4@System@RePag@@QAQPAV123@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?PresignChange@COComma4@System@RePag@@QAQXXZ PROC ; COComma4::PresignChange(void)
    mov eax, dword ptr COComma4_lVorKomma[ecx]
    imul eax, -1
    mov dword ptr COComma4_lVorKomma[ecx], eax
    movsx eax, word ptr COComma4_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_sNachKomma[ecx], ax
    ret
?PresignChange@COComma4@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
?pi@COComma4@System@RePag@@QAQPAV123@XZ PROC ; COComma4::pi(void)
    mov dword ptr COComma4_lVorKomma[ecx], 3
    mov word ptr COComma4_sNachKomma[ecx], 1416
    mov eax, ecx
    ret 0
?pi@COComma4@System@RePag@@QAQPAV123@XZ ENDP
;----------------------------------------------------------------------------
?pi_10e8@COComma4@System@RePag@@QAQPAV123@XZ PROC ; COComma4::pi_10e8(void)
    mov dword ptr COComma4_lVorKomma[ecx], 314159265
    mov word ptr COComma4_sNachKomma[ecx], 3590
    mov eax, ecx
    ret 0
?pi_10e8@COComma4@System@RePag@@QAQPAV123@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqd_Zahl = 12
swi_Runden_Alt = 10
swi_Runden = 8
sdi_MXCSR = 4
sdi_MXCSR_Alt = 0
?sin@COComma4@System@RePag@@QAQNXZ PROC ; COComma4::sin(void)
    sub esp, esp_Bytes

    fstcw swi_Runden_Alt[esp]
    fstcw swi_Runden[esp]
    btr word ptr swi_Runden[esp], 10
    btr word ptr swi_Runden[esp], 11
    fclex
    fldcw swi_Runden[esp]

    fild dword ptr COComma4_lVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fsin

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    fstp qword ptr sqd_Zahl[esp]
    movsd xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
    subsd xmm1, xmm2
    mulsd xmm1, dZehntausend
    cvtsd2si eax, xmm1
    cvtsi2sd xmm2, eax
    subsd xmm1, xmm2
    mulsd xmm1, dZehn

		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add edx, 1

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub edx, 1

  EndeRunden:
    mov dword ptr COComma4_lVorKomma[ecx], edx
    mov word ptr COComma4_sNachKomma[ecx], ax
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]

    add esp, esp_Bytes
    ret 0
?sin@COComma4@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqd_Zahl = 12
swi_Runden_Alt = 10
swi_Runden = 8
sdi_MXCSR = 4
sdi_MXCSR_Alt = 0
?cos@COComma4@System@RePag@@QAQNXZ PROC ; COComma4::cos(void)
    sub esp, esp_Bytes

    fstcw swi_Runden_Alt[esp]
    fstcw swi_Runden[esp]
    btr word ptr swi_Runden[esp], 10
    btr word ptr swi_Runden[esp], 11
    fclex
    fldcw swi_Runden[esp]

    fild dword ptr COComma4_lVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fcos

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    fstp qword ptr sqd_Zahl[esp]
    movsd xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
    subsd xmm1, xmm2
    mulsd xmm1, dZehntausend
    cvtsd2si eax, xmm1
    cvtsi2sd xmm2, eax
    subsd xmm1, xmm2
    mulsd xmm1, dZehn

		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add edx, 1

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub edx, 1

  EndeRunden:
    mov dword ptr COComma4_lVorKomma[ecx], edx
    mov word ptr COComma4_sNachKomma[ecx], ax
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]

    add esp, esp_Bytes
    ret 0
?cos@COComma4@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqd_Zahl = 12
swi_Runden_Alt = 10
swi_Runden = 8
sdi_MXCSR = 4
sdi_MXCSR_Alt = 0
?tan@COComma4@System@RePag@@QAQNXZ PROC ; COComma4::tan(void)
    sub esp, esp_Bytes

    fstcw swi_Runden_Alt[esp]
    fstcw swi_Runden[esp]
    btr word ptr swi_Runden[esp], 10
    btr word ptr swi_Runden[esp], 11
    fclex
    fldcw swi_Runden[esp]

    fild dword ptr COComma4_lVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fptan

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

		fstp qword ptr sqd_Zahl[esp]
    fstp qword ptr sqd_Zahl[esp]
    movsd xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
    subsd xmm1, xmm2
    mulsd xmm1, dZehntausend
    cvtsd2si eax, xmm1
    cvtsi2sd xmm2, eax
    subsd xmm1, xmm2
    mulsd xmm1, dZehn

		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add edx, 1

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub edx, 1

  EndeRunden:
    mov dword ptr COComma4_lVorKomma[ecx], edx
    mov word ptr COComma4_sNachKomma[ecx], ax
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]

    add esp, esp_Bytes
    ret 0
?tan@COComma4@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
sqd_Zahl = 12
swi_Runden_Alt = 10
swi_Runden = 8
sdi_MXCSR = 4
sdi_MXCSR_Alt = 0
?Squareroot@COComma4@System@RePag@@QAQNXZ PROC ; COComma4::Squareroot(void)
    sub esp, esp_Bytes

    fstcw swi_Runden_Alt[esp]
    fstcw swi_Runden[esp]
    btr word ptr swi_Runden[esp], 10
    btr word ptr swi_Runden[esp], 11
    fclex
    fldcw swi_Runden[esp]

    fild dword ptr COComma4_lVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_sNachKomma[ecx]
    fdiv dZehntausend

    fcom dNull
    fstsw ax
    sahf
    ja short Wurzel
		xor eax, eax
		mov dword ptr COComma4_lVorKomma[ecx], eax
    mov dword ptr COComma4_lVorKomma_A[ecx], eax
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax
		jmp Ende

	Wurzel:
    fsqrt

    stmxcsr dword ptr sdi_MXCSR_Alt[esp]
    stmxcsr dword ptr sdi_MXCSR[esp]
    or dword ptr sdi_MXCSR[esp], 6000h
    ldmxcsr dword ptr sdi_MXCSR[esp]

    fstp qword ptr sqd_Zahl[esp]
    movsd xmm0, qword ptr sqd_Zahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
    subsd xmm1, xmm2
    mulsd xmm1, dZehntausend
    cvtsd2si eax, xmm1
    cvtsi2sd xmm2, eax
    subsd xmm1, xmm2
    mulsd xmm1, dZehn

		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add edx, 1

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -1000
    ja EndeRunden
    xor eax, eax
    sub edx, 1

  EndeRunden:
    mov dword ptr COComma4_lVorKomma[ecx], edx
    mov word ptr COComma4_sNachKomma[ecx], ax
    fldcw swi_Runden_Alt[esp]
    ldmxcsr dword ptr sdi_MXCSR_Alt[esp]

	Ende:
    add esp, esp_Bytes
    ret 0
?Squareroot@COComma4@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OKomma4 ENDS
END
