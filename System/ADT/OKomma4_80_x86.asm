;/****************************************************************************
;  OKomma4_80_x86.asm
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

.DATA
ucBY_COKOMMMA4_80 DB 24
dHalbkreis DQ 180.0
dNull DQ 0.0
llEins DQ 1
dMinusEins DQ -1.0
dEins DQ 1.0
dZehn DQ 10.0
dHundert DQ 100.0
dTausend DQ 1000.0
dZehntausend DQ 10000.0
dEinsNullAcht DQ 100000000.0
fZehntausend DD 10000.0
dFunf DQ 5.0
dMinusFunf DQ -5.0
llPi_Kurz DQ 3
llPi_Lang DQ 3141592653589793238

CS_OKomma4_80 SEGMENT EXECUTE
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@XZ	PROC ; COComma4_80V(void)
    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor edx, edx
    mov dword ptr COComma4_80_vmSpeicher[eax], edx
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@XZ	ENDP
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX@Z PROC ; COComma4_80V(vmSpeicher)
		push ecx ; vmSpeicher
    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    
		pop ecx ; vmSpeicher
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@N@Z PROC ; COComma4_80V(dZahl)
    push ebx
    sub esp, esp_Bytes

    movsd qword ptr s_dZahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

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

	  movsd	xmm0, qword ptr s_dZahl[esp]
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

		xor ecx, ecx
    cmp ebx, ecx
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
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXN@Z PROC ; COComma4_80V(vmSpeicher, dZahl)
    push ebx
    sub esp, esp_Bytes

    mov ebx, ecx
    movsd qword ptr s_dZahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov dword ptr COComma4_80_vmSpeicher[eax], ebx

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

	  movsd	xmm0, qword ptr s_dZahl[esp]
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

		xor ecx, ecx
    cmp ebx, ecx
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
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@H@Z PROC ; COComma4_80V(iZahl)
		sub esp, esp_Bytes

		mov dword ptr s_llZahl[esp], ecx
		fild dword ptr s_llZahl[esp]
		fistp qword ptr s_llZahl[esp]

    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		movq xmm2, qword ptr s_llZahl[esp]
		xor ecx, ecx
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], cx
    mov word ptr COComma4_80_sNachKomma_A[eax], cx

		add esp, esp_Bytes
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXH@Z PROC ; COComma4_80V(vmSpeicher, iZahl)
		sub esp, esp_Bytes
		push ecx ; vmSpeicher

		mov dword ptr s_llZahl[esp + 4], edx
		fild dword ptr s_llZahl[esp + 4]
		fistp qword ptr s_llZahl[esp + 4]

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; vmSpeicher
		movq xmm2, qword ptr s_llZahl[esp + 4]
		xor edx, edx
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

		add esp, esp_Bytes
    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXH@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_llZahl$ = 4
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@_J@Z PROC ; COComma4_80V(llZahl)
    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    movq xmm2, qword ptr a_llZahl$[esp]
		xor ecx, ecx
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], cx
    mov word ptr COComma4_80_sNachKomma_A[eax], cx

    ret 8
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_llZahl$ = 8
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX_J@Z PROC ; COComma4_80V(vmSpeicher, llZahl)
		push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; vmSpeicher

    movq xmm2, qword ptr a_llZahl$[esp]
		xor edx, edx
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    ret 8
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBX_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBVCOComma4@12@@Z PROC ; COComma4_80V(pk4Zahl)
		push ecx ; pk4Zahl

    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; pk4Zahl

		xor edx, edx
    mov dword ptr COComma4_80_vmSpeicher[eax], edx
    movd xmm2, dword ptr COComma4_lVorKomma[ecx]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movd xmm2, dword ptr COComma4_lVorKomma_A[ecx]
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    movsx edx, word ptr COComma4_sNachKomma[ecx]
    mov word ptr COComma4_80_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_sNachKomma_A[ecx]
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPAVCOComma4@12@@Z PROC ; COComma4_80V(vmSpeicher, pk4Zahl)
		push edx ; pk4Zahl
		push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; vmSpeicher
		pop ecx ; pk4Zahl

    mov dword ptr COComma4_80_vmSpeicher[eax], edx
    movd xmm2, dword ptr COComma4_lVorKomma[ecx]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movd xmm2, dword ptr COComma4_lVorKomma_A[ecx]
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    movsx edx, word ptr COComma4_sNachKomma[ecx]
    mov word ptr COComma4_80_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_sNachKomma_A[ecx]
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPAVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBV312@@Z PROC ; COComma4_80V(pk4_80Zahl)
		push ecx ; pk4_80Zahl

    movzx edx, ucBY_COKOMMMA4_80
    xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; pk4_80Zahl

		xor edx, edx
    mov dword ptr COComma4_80_vmSpeicher[eax], edx
    movq xmm2, qword ptr COComma4_80_llVorKomma[ecx]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq xmm2, qword ptr COComma4_80_llVorKomma_A[ecx]
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    movsx edx, word ptr COComma4_80_sNachKomma[ecx]
    mov word ptr COComma4_80_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_80_sNachKomma_A[ecx]
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@PBV312@@Z ENDP
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPBV312@@Z PROC ; COComma4_80V(vmSpeicher, pk4_80Zahl)
		push edx ; pk4_80Zahl
		push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; vmSpeicher
		pop ecx ; pk4_80Zahl

    mov dword ptr COComma4_80_vmSpeicher[eax], edx
    movq xmm2, qword ptr COComma4_80_llVorKomma[ecx]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq xmm2, qword ptr COComma4_80_llVorKomma_A[ecx]
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    movsx edx, word ptr COComma4_80_sNachKomma[ecx]
    mov word ptr COComma4_80_sNachKomma[eax], dx
    movsx edx, word ptr COComma4_80_sNachKomma_A[ecx]
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXPBV312@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_mi128Zahl = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@T__m128i@@@Z PROC ; COComma4_80V(m128iZahl)
		sub esp, esp_Bytes

		movq qword ptr s_mi128Zahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4_80
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor ecx, ecx
		mov dword ptr COComma4_80_vmSpeicher[eax], ecx
		movq xmm0, qword ptr s_mi128Zahl[esp]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm0
    mov word ptr COComma4_80_sNachKomma[eax], cx
    mov word ptr COComma4_80_sNachKomma_A[eax], cx

		add esp, esp_Bytes
		ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@T__m128i@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_mi128Zahl = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXT__m128i@@@Z PROC ; COComma4_80V(vmSpeicher, m128iZahl)
		sub esp, esp_Bytes

		movq qword ptr s_mi128Zahl[esp], xmm0
		push ecx ; vmSpeicher

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; vmSpeicher

		xor edx, edx
		mov dword ptr COComma4_80_vmSpeicher[eax], ecx
		movq xmm0, qword ptr s_mi128Zahl[esp]
    movq qword ptr COComma4_80_llVorKomma[eax], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm0
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

		add esp, esp_Bytes
		ret 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXT__m128i@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden = 10
s_c2Runden_Alt = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@U__m128d@@@Z PROC ; COComma4_80V(m128dZahl)
    push ebx
    sub esp, esp_Bytes

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

		movsd qword ptr s_dZahl[esp], xmm0

    movzx edx, ucBY_COKOMMMA4_80
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

	  movsd	xmm0, qword ptr s_dZahl[esp]
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

		xor ecx, ecx
    cmp ebx, ecx
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
    mov dword ptr COComma4_80_vmSpeicher[eax], ecx
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden = 10
s_c2Runden_Alt = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXU__m128d@@@Z PROC ; COComma4_80V(vmSpeicher, m128dZahl)
    push ebx
    sub esp, esp_Bytes

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

		movsd qword ptr s_dZahl[esp], xmm0
		mov ebx, ecx

    movzx edx, ucBY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov dword ptr COComma4_80_vmSpeicher[eax], ebx

	  movsd	xmm0, qword ptr s_dZahl[esp]
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

		xor ecx, ecx
    cmp ebx, ecx
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
    movq qword ptr COComma4_80_llVorKomma[eax], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[eax], xmm2
    mov word ptr COComma4_80_sNachKomma[eax], dx
    mov word ptr COComma4_80_sNachKomma_A[eax], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
?COComma4_80V@System@RePag@@YQPAVCOComma4_80@12@QBXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COFreiV@COComma4_80@System@RePag@@QAQPBXXZ PROC ; COComma4_80::COFreiV(void)
    mov eax, dword ptr COComma4_80_vmSpeicher[ecx]
    ret 0
?COFreiV@COComma4_80@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QAE@XZ PROC ; COComma4_80::COComma4_80(void)
    xor eax, eax
		mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    xorpd xmm0, xmm0
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    ret
??0COComma4_80@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??0COComma4_80@System@RePag@@QAE@N@Z PROC ; COComma4_80::COComma4_80(dZahl)
    push ebx
    sub esp, esp_Bytes

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

		xor eax, eax
    cmp ebx, eax
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
    mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm2
    mov word ptr COComma4_80_sNachKomma[ecx], dx
    mov word ptr COComma4_80_sNachKomma_A[ecx], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 8
??0COComma4_80@System@RePag@@QAE@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
a_iZahl = esp_Bytes + 4
??0COComma4_80@System@RePag@@QAE@H@Z PROC ; COComma4_80::COComma4_80(iZahl)
    sub esp, esp_Bytes

		xor eax, eax
    mov dword ptr COComma4_80_vmSpeicher[ecx], eax
		fild dword ptr a_iZahl[esp]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    
		add esp, esp_Bytes
		ret 4
??0COComma4_80@System@RePag@@QAE@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_llZahl = 4
??0COComma4_80@System@RePag@@QAE@_J@Z PROC ; COComma4_80::COComma4_80(llZahl)
    xor eax, eax
		mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    movq xmm0, qword ptr a_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    ret 8
??0COComma4_80@System@RePag@@QAE@_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
a_k4Zahl$ = esp_Bytes + 4
??0COComma4_80@System@RePag@@QAE@ABVCOComma4@12@@Z PROC ; COComma4_80::COComma4_80(&k4Zahl)
		sub esp, esp_Bytes

		xor eax, eax
    mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    mov eax, dword ptr a_k4Zahl$[esp]

		fild dword ptr COComma4_lVorKomma[eax]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
		fild dword ptr COComma4_lVorKomma_A[eax]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    movsx edx, word ptr COComma4_sNachKomma[eax]
    mov word ptr COComma4_80_sNachKomma[ecx], dx
    movsx edx, word ptr COComma4_sNachKomma_A[eax]
    mov word ptr COComma4_80_sNachKomma_A[ecx], dx

		add esp, esp_Bytes
    ret 4
??0COComma4_80@System@RePag@@QAE@ABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_k4_80Zahl$ = 4
??0COComma4_80@System@RePag@@QAE@ABV012@@Z PROC ; COComma4_80::COComma4_80(&k4_80Zahl)
    xor eax, eax
		mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    mov eax, dword ptr a_k4_80Zahl$[esp]
    movq xmm0, qword ptr COComma4_80_llVorKomma[eax]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq xmm0, qword ptr COComma4_80_llVorKomma_A[eax]
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    movsx edx, word ptr COComma4_80_sNachKomma[eax]
    mov word ptr COComma4_80_sNachKomma[ecx], dx
    movsx edx, word ptr COComma4_80_sNachKomma_A[eax]
    mov word ptr COComma4_80_sNachKomma_A[ecx], dx
    ret 4
??0COComma4_80@System@RePag@@QAE@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QAE@T__m128i@@@Z PROC ; COComma4_80::COComma4_80(m128iZahl)
		xor eax, eax
		mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
		ret
??0COComma4_80@System@RePag@@QAE@T__m128i@@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden = 10
s_c2Runden_Alt = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??0COComma4_80@System@RePag@@QAE@U__m128d@@@Z PROC ; COComma4_80::COComma4_80(m128dZahl)
    push ebx
    sub esp, esp_Bytes

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

		xor eax, eax
    cmp ebx, eax
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
    mov dword ptr COComma4_80_vmSpeicher[ecx], eax
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm2
    mov word ptr COComma4_80_sNachKomma[ecx], dx
    mov word ptr COComma4_80_sNachKomma_A[ecx], dx

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??0COComma4_80@System@RePag@@QAE@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??4COComma4_80@System@RePag@@QAQXN@Z PROC ; COComma4_80::operator=(dZahl)
    push ebx
    sub esp, esp_Bytes

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

		xor eax, eax
    cmp ebx, eax
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

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??4COComma4_80@System@RePag@@QAQXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
??4COComma4_80@System@RePag@@QAQXH@Z PROC ; COComma4_80::operator=(iZahl)
    sub esp, esp_Bytes

		mov dword ptr s_llZahl[esp], edx
		fild dword ptr s_llZahl[esp]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    xor eax, eax
		mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    
		add esp, esp_Bytes
		ret
??4COComma4_80@System@RePag@@QAQXH@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_k4Zahl$ = 4
??4COComma4_80@System@RePag@@QAQX_J@Z PROC ; COComma4_80::operator=(llZahl)
    xor eax, eax
		movq xmm0, qword ptr a_k4Zahl$[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
		ret 8
??4COComma4_80@System@RePag@@QAQX_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llZahl = 0
??4COComma4_80@System@RePag@@QAQXABVCOComma4@@@Z PROC ; COComma4_80::operator=(&k4Zahl)
		sub esp, esp_Bytes

		fild dword ptr COComma4_lVorKomma_A[edx]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

    movsx eax, word ptr COComma4_sNachKomma_A[edx]
    mov word ptr COComma4_80_sNachKomma[ecx], ax

		fild dword ptr COComma4_lVorKomma[edx]
		fistp qword ptr s_llZahl[esp]
		movq xmm0, qword ptr s_llZahl[esp]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

		add esp, esp_Bytes
    ret
??4COComma4_80@System@RePag@@QAQXABVCOComma4@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QAQXABV0@@Z PROC ; COComma4_80::operator=(&k4_80Zahl)
    movq xmm0, qword ptr COComma4_80_llVorKomma_A[edx]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma_A[edx]
    mov word ptr COComma4_80_sNachKomma[ecx], ax

    movq xmm0, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax
    ret
??4COComma4_80@System@RePag@@QAQXABV0@@Z ENDP
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QAQXT__m128i@@@Z PROC ; COComma4_80::operator=(m128iZahl)
    xor eax, eax
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
		ret
??4COComma4_80@System@RePag@@QAQXT__m128i@@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden = 10
s_c2Runden_Alt = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??4COComma4_80@System@RePag@@QAQXU__m128d@@@Z PROC ; COComma4_80::operator=(m128dZahl)
    push ebx
    sub esp, esp_Bytes

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

		xor eax, eax
    cmp ebx, eax
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

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret 0
??4COComma4_80@System@RePag@@QAQXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??YCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z PROC ; COComma4_80::operator+=(&k4Zahl)
    push ebx
		sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
		fild dword ptr COComma4_lVorKomma_A[edx]
		fistp qword ptr s_llVorKomma[esp]
		movq xmm1, qword ptr s_llVorKomma[esp]
    paddq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    add bx, word ptr COComma4_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl Ende
    sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg Ende
    sub bx, -10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp Ende

  NachKomma_Plus_Einer_Minus:
		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    jge short Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
		jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    pop ebx
    ret
??YCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??HCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z PROC ; COComma4_80::operator+(&k4Zahl)
    push ebx
		sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
		fild dword ptr COComma4_lVorKomma_A[edx]
		fistp qword ptr s_llVorKomma[esp]
		movq xmm1, qword ptr s_llVorKomma[esp]
    paddq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    add bx, word ptr COComma4_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma_A[ecx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl Ende
    sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma_A[ecx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg Ende
    sub bx, -10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp Ende

  NachKomma_Plus_Einer_Minus:
		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge short Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

    mov eax, ecx
    
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    pop ebx
    ret
??HCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??YCOComma4_80@System@RePag@@QAQXABV012@@Z PROC ; COComma4_80::operator+=(&k4_80Zahl)
    push ebx
		sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    movq xmm1, qword ptr COComma4_80_llVorKomma_A[edx]
    paddq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    add bx, word ptr COComma4_80_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl Ende
    sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg Ende
    sub bx, -10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp Ende

  NachKomma_Plus_Einer_Minus:
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
		xorpd xmm7, xmm7
    ucomisd xmm1, xmm7
    jge short Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    movq xmm0, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    pop ebx
    ret
??YCOComma4_80@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??HCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4_80::operator+(&k4_80Zahl)
    push ebx
		sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
    movq xmm1, qword ptr COComma4_80_llVorKomma_A[edx]
    paddq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    add bx, word ptr COComma4_80_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma_A[ecx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jl short NachKomma_Plus_Einer_Minus
    cmp bx, 10000
    jl Ende
    sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma_A[ecx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jg short NachKomma_Minus_Einer_Plus
    cmp bx, -10000
    jg Ende
    sub bx, -10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp Ende

  NachKomma_Plus_Einer_Minus:
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge short Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    movq xmm0, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

    mov eax, ecx
    
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    pop ebx
    ret
??HCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??ZCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z PROC ; COComma4_80::operator-=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
		fild dword ptr COComma4_lVorKomma_A[edx]
		fistp qword ptr s_llVorKomma[esp]
		movq xmm1, qword ptr s_llVorKomma[esp]
    psubq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    sub bx, word ptr COComma4_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jl NachKomma_Plus_Zweiter_Minus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma_A[edx], ax
    jge short NachKomma_Minus_Zweiter_Plus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
    add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??ZCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??ZCOComma4_80@System@RePag@@QAQXABV012@@Z PROC ; COComma4_80::operator-=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
		movq xmm1, qword ptr COComma4_80_llVorKomma_A[edx]
    psubq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    sub bx, word ptr COComma4_80_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jl NachKomma_Plus_Zweiter_Minus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jge short NachKomma_Minus_Zweiter_Plus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
    add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

  Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    movq xmm1, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm1

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??ZCOComma4_80@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??GCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z PROC ; COComma4_80::operator-(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
		fild dword ptr COComma4_lVorKomma_A[edx]
		fistp qword ptr s_llVorKomma[esp]
		movq xmm1, qword ptr s_llVorKomma[esp]
    psubq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    sub bx, word ptr COComma4_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_sNachKomma[edx], ax
    jl NachKomma_Plus_Zweiter_Minus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_sNachKomma[edx], ax
    jge short NachKomma_Minus_Zweiter_Plus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
    add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

	Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    movq xmm0, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

    mov eax, ecx

		fldcw s_c2Runden_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??GCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??GCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4_80::operator-(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]

    movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
		movq xmm1, qword ptr COComma4_80_llVorKomma_A[edx]
    psubq xmm0, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    sub bx, word ptr COComma4_80_sNachKomma_A[edx]

		xor eax, eax
    test bx, bx
    je Ende
    jl short NachKomma_Minus

    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jl NachKomma_Plus_Zweiter_Minus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jge Ende
    ;imul bx, -1
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp Ende

  NachKomma_Minus:
    cmp word ptr COComma4_80_sNachKomma_A[edx], ax
    jge short NachKomma_Minus_Zweiter_Plus

		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq qword ptr s_llVorKomma[esp], xmm0
		fild qword ptr s_llVorKomma[esp]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    xorpd xmm7, xmm7
		ucomisd xmm1, xmm7
    jbe short Ende
    ;imul bx, -1
		add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp bx, 10000
		jl short Ende
		sub bx, 10000
		movq xmm1, llEins
		paddq xmm0, xmm1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp bx, -10000
    jg short Ende
    add bx, 10000
		movq xmm1, llEins
		psubq xmm0, xmm1

	Ende:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    movq xmm0, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm0

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

    mov eax, ecx

		fldcw s_c2Runden_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??GCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??XCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z PROC ; COComma4_80::operator*=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm4, xmm0
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma_A[edx]
    mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm4
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??XCOComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??XCOComma4_80@System@RePag@@QAQXABV012@@Z PROC ; COComma4_80::operator*=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm4, xmm0
		fild qword ptr COComma4_80_llVorKomma_A[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_80_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm4
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    movq xmm1, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm1

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??XCOComma4_80@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??DCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z PROC ; COComma4_80::operator*(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma_A[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm4, xmm0
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma_A[edx]
    mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm4
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
		mov eax, ecx

		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??DCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??DCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4_80::operator*(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma_A[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm4, xmm0
		fild qword ptr COComma4_80_llVorKomma_A[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]
    mulsd xmm4, xmm1

    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx 
    movsx ebx, word ptr COComma4_80_sNachKomma_A[edx]
    cvtsi2sd xmm3, ebx 

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, xmm3
		divsd xmm0, dZehntausend
		addsd xmm4, xmm0

		mulsd xmm1, xmm2
		divsd xmm1, dZehntausend
		addsd xmm4, xmm1

		mulsd xmm2, xmm3
		divsd xmm2, dEinsNullAcht
		addsd xmm4, xmm2

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm4
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm4, xmm0
		mulsd xmm4, dZehntausend
		cvtsd2si ebx, xmm4
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    movq xmm1, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm1

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

		mov eax, ecx
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??DCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??_0COComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z PROC ; COComma4_80::operator/=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma_A[edx]

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx
		addsd xmm0, xmm2

		mulsd xmm1, dZehntausend
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm2, ebx
		addsd xmm1, xmm2

		divsd xmm0, xmm1
		movsd xmm1, xmm0

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm1
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm1, xmm0
		mulsd xmm1, dZehntausend
		cvtsd2si ebx, xmm1
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??_0COComma4_80@System@RePag@@QAQXABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??_0COComma4_80@System@RePag@@QAQXABV012@@Z PROC ; COComma4_80::operator/=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma_A[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm2, ebx
		addsd xmm0, xmm2

		mulsd xmm1, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma_A[edx]
    cvtsi2sd xmm2, ebx
		addsd xmm1, xmm2

		divsd xmm0, xmm1
		movsd xmm1, xmm0

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm1
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm1, xmm0
		mulsd xmm1, dZehntausend
		cvtsd2si ebx, xmm1
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx
    mov word ptr COComma4_80_sNachKomma_A[ecx], bx

    movq xmm1, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm1

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??_0COComma4_80@System@RePag@@QAQXABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??KCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z PROC ; COComma4_80::operator/(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma_A[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma_A[edx]

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx
		addsd xmm0, xmm2

		mulsd xmm1, dZehntausend
    movsx ebx, word ptr COComma4_sNachKomma_A[edx]
    cvtsi2sd xmm2, ebx
		addsd xmm1, xmm2

		divsd xmm0, xmm1
		movsd xmm1, xmm0

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm1
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm1, xmm0
		mulsd xmm1, dZehntausend
		cvtsd2si ebx, xmm1
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    mov eax, dword ptr COComma4_lVorKomma[edx]
    mov dword ptr COComma4_lVorKomma_A[edx], eax

    movsx eax, word ptr COComma4_sNachKomma[edx]
    mov word ptr COComma4_sNachKomma_A[edx], ax

		mov eax, ecx
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??KCOComma4_80@System@RePag@@QAQAAV012@ABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma  = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
??KCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z PROC ; COComma4_80::operator/(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fild qword ptr COComma4_80_llVorKomma_A[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma_A[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

		btr dword ptr s_dwMXCSR[esp], 13
    btr dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		mulsd xmm0, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma_A[ecx]
    cvtsi2sd xmm2, ebx
		addsd xmm0, xmm2

		mulsd xmm1, dZehntausend
    movsx ebx, word ptr COComma4_80_sNachKomma_A[edx]
    cvtsi2sd xmm2, ebx
		addsd xmm1, xmm2

		divsd xmm0, xmm1
		movsd xmm1, xmm0

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movsd qword ptr s_llVorKomma[esp], xmm1
		fld qword ptr s_llVorKomma[esp]
		fistp qword ptr s_llVorKomma[esp]
		fild qword ptr s_llVorKomma[esp]
		fst qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		subsd xmm1, xmm0
		mulsd xmm1, dZehntausend
		cvtsd2si ebx, xmm1
		fistp qword ptr s_llVorKomma[esp]
		movq xmm0, qword ptr s_llVorKomma[esp]

    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], bx

    movq xmm1, qword ptr COComma4_80_llVorKomma[edx]
    movq qword ptr COComma4_80_llVorKomma_A[edx], xmm1

    movsx eax, word ptr COComma4_80_sNachKomma[edx]
    mov word ptr COComma4_80_sNachKomma_A[edx], ax

		mov eax, ecx
    
		fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop ebx
    ret
??KCOComma4_80@System@RePag@@QAQAAV012@ABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
?Compare@COComma4_80@System@RePag@@QAQDPBVCOComma4@23@@Z PROC ; COComma4_80::Compare(pk4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

    mov eax, -1
		ucomisd xmm0, xmm1
    jb short Ende
    mov eax, 1
    ja short Ende
    mov eax, -1
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jb short Ende
    mov eax, 1
    ja short Ende
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
?Compare@COComma4_80@System@RePag@@QAQDPBVCOComma4@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
?Compare@COComma4_80@System@RePag@@QAQDPBV123@@Z PROC ; COComma4_80::Compare(pk4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, -1
		ucomisd xmm0, xmm1
    jb short Ende
    mov eax, 1
    ja short Ende
    mov eax, -1
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    jb short Ende
    mov eax, 1
    ja short Ende
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
?Compare@COComma4_80@System@RePag@@QAQDPBV123@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??MCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator<(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

    mov eax, 1
		ucomisd xmm0, xmm1
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jb short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??MCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??MCOComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator<(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    jb short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??MCOComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??OCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator>(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

    mov eax, 1
		ucomisd xmm0, xmm1
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    ja short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??OCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??OCOComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator>(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    ja short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??OCOComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??NCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator<=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

    mov eax, 1
		ucomisd xmm0, xmm1
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jbe short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??NCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??NCOComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator<=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    jb short Ende
    ja short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    jbe short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??NCOComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??PCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator>=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

    mov eax, 1
		ucomisd xmm0, xmm1
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jae short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??PCOComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??PCOComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator>=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    ja short Ende
    jb short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    jae short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??PCOComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??8COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator==(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

		mov eax, 1
		ucomisd xmm0, xmm1
    jne short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    je short Ende

  Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??8COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??8COComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator==(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    jne short Ungleich
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    je short Ende

	Ungleich:
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??8COComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??9COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z PROC ; COComma4_80::operator!=(&k4Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		cvtsi2sd xmm1, dword ptr COComma4_lVorKomma[edx]

		mov eax, 1
		ucomisd xmm0, xmm1
    jne short Ende
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_sNachKomma[edx]
    jne short Ende
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??9COComma4_80@System@RePag@@QAQ_NABVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??9COComma4_80@System@RePag@@QAQ_NABV012@@Z PROC ; COComma4_80::operator!=(&k4_80Zahl)
    push ebx
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fild qword ptr COComma4_80_llVorKomma[edx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm1, qword ptr s_llVorKomma[esp]

    mov eax, 1
		ucomisd xmm0, xmm1
    jne short Ende
    movsx ebx, word ptr COComma4_80_sNachKomma[ecx]
    cmp bx, word ptr COComma4_80_sNachKomma[edx]
    jne short Ende
    xor eax, eax

  Ende:
		fldcw s_c2Runden_Alt[esp]
	  add esp, esp_Bytes
    pop ebx
    ret
??9COComma4_80@System@RePag@@QAQ_NABV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??ECOComma4_80@System@RePag@@QAQXXZ PROC ; COComma4_80::operator++(void)
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq xmm2, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    paddq xmm0, xmm2
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

		movq xmm1, qword ptr COComma4_80_llVorKomma_A[ecx]
    paddq xmm1, xmm2
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm1

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm1, dEins

		ucomisd xmm0, xmm1
    jne Ende
		xor ax, ax
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jge Ende
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

  Ende:
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    ret
??ECOComma4_80@System@RePag@@QAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??ECOComma4_80@System@RePag@@QAQXH@Z PROC ; COComma4_80::operator++(int i)
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq xmm2, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    paddq xmm0, xmm2
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

		movq xmm1, qword ptr COComma4_80_llVorKomma_A[ecx]
    paddq xmm1, xmm2
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm1

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm1, dEins

		ucomisd xmm0, xmm1
    jne Ende
		xor ax, ax
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jge Ende
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

  Ende:
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    ret
??ECOComma4_80@System@RePag@@QAQXH@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??FCOComma4_80@System@RePag@@QAQXXZ PROC ; COComma4_80::operator--(void)
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq xmm2, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    psubq xmm0, xmm2
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

		movq xmm1, qword ptr COComma4_80_llVorKomma_A[ecx]
    psubq xmm1, xmm2
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm1

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm1, dMinusEins

		ucomisd xmm0, xmm1
    jne Ende
		xor ax, ax
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jle Ende
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

  Ende:
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    ret
??FCOComma4_80@System@RePag@@QAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_llVorKomma  = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
??FCOComma4_80@System@RePag@@QAQXH@Z PROC ; COComma4_80::operator--(int i)
    sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		movq xmm2, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    psubq xmm0, xmm2
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0

		movq xmm1, qword ptr COComma4_80_llVorKomma_A[ecx]
    psubq xmm1, xmm2
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm1

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		movsd xmm1, dMinusEins

		ucomisd xmm0, xmm1
    jne Ende
		xor ax, ax
    cmp word ptr COComma4_80_sNachKomma[ecx], ax
    jle Ende
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

  Ende:
		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    ret 0
??FCOComma4_80@System@RePag@@QAQXH@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Read@COComma4_80@System@RePag@@QAQXQBD@Z PROC ; COComma4_80::Read(cZahl[10])
    test edx, edx
    je short Ende

    movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    movq qword ptr [edx], xmm0
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    mov word ptr [edx + 8], ax

  Ende:
    ret
?Read@COComma4_80@System@RePag@@QAQXQBD@Z ENDP
;----------------------------------------------------------------------------
?Write@COComma4_80@System@RePag@@QAQXQBD@Z PROC ; COComma4_80::Write(cZahl[10])
    test edx, edx
    je short Null

    movq xmm0, qword ptr [edx]
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    movsx eax, word ptr [edx + 8]
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    jmp short Ende

  Null:
		xorpd xmm0, xmm0
		xor ax, ax
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_sNachKomma[ecx], ax
    mov word ptr COComma4_sNachKomma_A[ecx], ax

  Ende:
    ret
?Write@COComma4_80@System@RePag@@QAQXQBD@Z ENDP
;----------------------------------------------------------------------------
?PreComma@COComma4_80@System@RePag@@QAQ_JXZ PROC ; COComma4_80::PreComma(void)
		mov	eax, dword ptr COComma4_80_llVorKomma[ecx]
		mov	edx, dword ptr COComma4_80_llVorKomma[ecx + 4]
		ret
?PreComma@COComma4_80@System@RePag@@QAQ_JXZ ENDP
;----------------------------------------------------------------------------
?AfterComma@COComma4_80@System@RePag@@QAQFXZ PROC ; COComma4_80::AfterComma(void)
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    ret
?AfterComma@COComma4_80@System@RePag@@QAQFXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 4
s_lVorKomma  = 0
?FLOAT@COComma4_80@System@RePag@@QAQMXZ PROC ; COComma4_80::FLOAT(void)
		sub esp, esp_Bytes

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp dword ptr s_lVorKomma[esp]
		movss xmm0, dword ptr s_lVorKomma[esp]
    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2ss xmm1, eax
    divss xmm1, fZehntausend
    addss xmm0, xmm1

		add esp, esp_Bytes
    ret
?FLOAT@COComma4_80@System@RePag@@QAQMXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llVorKomma  = 0
?DOUBLE@COComma4_80@System@RePag@@QAQNXZ PROC ; COComma4_80::DOUBLE(void)
		sub esp, esp_Bytes

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]

    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm1, eax
    divsd xmm1, dZehntausend
    addsd xmm0, xmm1

		add esp, esp_Bytes
    ret
?DOUBLE@COComma4_80@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llVorKomma  = 0
?M128D@COComma4_80@System@RePag@@QAQ?AU__m128d@@XZ PROC ; COComma4_80::M128D(void)
		sub esp, esp_Bytes

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]	
		
		movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    cvtsi2sd xmm1, eax
    divsd xmm1, dZehntausend
    addsd xmm0, xmm1

		add esp, esp_Bytes
		ret
?M128D@COComma4_80@System@RePag@@QAQ?AU__m128d@@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?SetZero@COComma4_80@System@RePag@@QAQXXZ PROC ; COComma4_80::SetZero(void)
		xorpd xmm0, xmm0
		xor ax, ax
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
    ret
?SetZero@COComma4_80@System@RePag@@QAQXXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_llVorKomma = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?Round@COComma4_80@System@RePag@@QAQPAV123@E@Z PROC ; COComma4_80::Round(ucStellen)
    sub esp, esp_Bytes

    movsx eax, word ptr COComma4_80_sNachKomma[ecx]

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
    jmp Runden

  Stellen_1:
    test dl, dl
    je short Stellen_0
    cmp eax, 9500
    jge short VorKommaPlusMinus
    cmp eax, -9500
    jle short VorKommaPlusMinus
    movsd xmm2, dTausend
    jmp Runden

  Stellen_3:
    cmp eax, 9995
    jge short VorKommaPlusMinus
    cmp eax, -9995
    jle short VorKommaPlusMinus
    movsd xmm2, dZehn
    jmp Runden   
    
  Stellen_0:
    cmp eax, 5000
    jge short VorKommaPlusMinus
    cmp eax, -5000
    jle short VorKommaPlusMinus
    movsd xmm2, dZehntausend
    jmp Runden

  VorKommaPlusMinus:
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    xor eax, eax
		fild qword ptr COComma4_80_llVorKomma[ecx]
		fstp qword ptr s_llVorKomma[esp]
		movsd xmm0, qword ptr s_llVorKomma[esp]
		fldcw s_c2Runden_Alt[esp]

		xorpd xmm1, xmm1
		ucomisd xmm0, xmm1
    jae short VorKommaPlus
		movq xmm1, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    psubq xmm0, xmm1
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
		movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
    psubq xmm0, xmm1
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    jmp Ende

  VorKommaPlus:
		movq xmm1, llEins
		movq xmm0, qword ptr COComma4_80_llVorKomma[ecx]
    paddq xmm0, xmm1
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
		movq xmm0, qword ptr COComma4_80_llVorKomma_A[ecx]
    paddq xmm0, xmm1
		movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    jmp Ende

  Runden:
    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

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
    comisd xmm1, xmm7
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
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

  Ende:
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

    mov eax, ecx

    add esp, esp_Bytes
    ret
?Round@COComma4_80@System@RePag@@QAQPAV123@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 4
s_c2Runden_Alt = 2
s_c2Runden = 0
?PresignChange@COComma4_80@System@RePag@@QAQXXZ PROC ; COComma4_80::PresignChange(void)
		sub esp, esp_Bytes
		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild qword ptr COComma4_80_llVorKomma[ecx]
		fmul dMinusEins
		fistp qword ptr COComma4_80_llVorKomma[ecx]
		fild qword ptr COComma4_80_llVorKomma_A[ecx]
		fmul dMinusEins
		fistp qword ptr COComma4_80_llVorKomma_A[ecx]

    movsx eax, word ptr COComma4_80_sNachKomma[ecx]
    imul eax, -1
    mov word ptr COComma4_80_sNachKomma[ecx], ax
		mov word ptr COComma4_80_sNachKomma_A[ecx], ax

		fldcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
    ret
?PresignChange@COComma4_80@System@RePag@@QAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?pi@COComma4_80@System@RePag@@QAQPAV123@XZ PROC ; COComma4_80::pi(void)
		movq xmm0, llPi_Kurz
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], 1416
    mov word ptr COComma4_80_sNachKomma_A[ecx], 1416

    mov eax, ecx
    ret
?pi@COComma4_80@System@RePag@@QAQPAV123@XZ ENDP
;----------------------------------------------------------------------------
?pi_10e18@COComma4_80@System@RePag@@QAQPAV123@XZ PROC ; COComma4_80::pi_10e18(void)
    movq xmm0, llPi_Lang
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], 4626
    mov word ptr COComma4_80_sNachKomma_A[ecx], 4626

    mov eax, ecx
    ret 0  
?pi_10e18@COComma4_80@System@RePag@@QAQPAV123@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
?sin@COComma4_80@System@RePag@@QAQNXZ PROC ; COComma4_80::sin(void)
    sub esp, esp_Bytes

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    btr word ptr s_c2Runden[esp], 10
    btr word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    fild dword ptr COComma4_80_llVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_80_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fsin

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    fstp qword ptr s_dZahl[esp]
    movsd xmm0, qword ptr s_dZahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
		mov dword ptr s_dZahl[esp], edx
		fild dword ptr s_dZahl[esp]
		fistp qword ptr s_dZahl[esp]
		movq xmm3, qword ptr s_dZahl[esp]
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
		movq xmm4, llEins
		paddq xmm3, xmm4

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
		movq xmm4, llEins
		psubq xmm3, xmm4

  EndeRunden:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm3
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm3
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

    add esp, esp_Bytes
    ret
?sin@COComma4_80@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
?cos@COComma4_80@System@RePag@@QAQNXZ PROC ; COComma4_80::cos(void)
    sub esp, esp_Bytes

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    btr word ptr s_c2Runden[esp], 10
    btr word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    fild dword ptr COComma4_80_llVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_80_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fcos

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    fstp qword ptr s_dZahl[esp]
    movsd xmm0, qword ptr s_dZahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
		mov dword ptr s_dZahl[esp], edx
		fild dword ptr s_dZahl[esp]
		fistp qword ptr s_dZahl[esp]
		movq xmm3, qword ptr s_dZahl[esp]
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
		movq xmm4, llEins
		paddq xmm3, xmm4

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
		movq xmm4, llEins
		psubq xmm3, xmm4

  EndeRunden:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm3
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm3
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

    add esp, esp_Bytes
    ret
?cos@COComma4_80@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
?tan@COComma4_80@System@RePag@@QAQNXZ PROC ; COComma4_80::tan(void)
    sub esp, esp_Bytes

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    btr word ptr s_c2Runden[esp], 10
    btr word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    fild dword ptr COComma4_80_llVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_80_sNachKomma[ecx]
    fdiv dZehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dHalbkreis
    fdivp ST(1), ST(0)
    fptan

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    fstp qword ptr s_dZahl[esp]
		fstp qword ptr s_dZahl[esp]
    movsd xmm0, qword ptr s_dZahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
		mov dword ptr s_dZahl[esp], edx
		fild dword ptr s_dZahl[esp]
		fistp qword ptr s_dZahl[esp]
		movq xmm3, qword ptr s_dZahl[esp]
    subsd xmm1, xmm2
    mulsd xmm1, dZehntausend
    cvtsd2si eax, xmm1
    cvtsi2sd xmm2, eax
    subsd xmm1, xmm2
    mulsd xmm1, dZehn

		xorpd xmm7, xmm7
    comisd xmm1, xmm7
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
		movq xmm4, llEins
		paddq xmm3, xmm4

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
		movq xmm4, llEins
		psubq xmm3, xmm4

  EndeRunden:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm3
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm3
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

    add esp, esp_Bytes
    ret
?tan@COComma4_80@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_dZahl = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
?Squareroot@COComma4_80@System@RePag@@QAQNXZ PROC ; COComma4_80::Squareroot(void)
    sub esp, esp_Bytes

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    btr word ptr s_c2Runden[esp], 10
    btr word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

    fild dword ptr COComma4_80_llVorKomma[ecx]
    fmul dZehntausend
    fiadd word ptr COComma4_80_sNachKomma[ecx]
    fdiv dZehntausend

    fcom dNull
    fstsw ax
    sahf
    ja short Wurzel
		xorpd xmm0, xmm0
		xor ax, ax
		movq qword ptr COComma4_80_llVorKomma[ecx], xmm0
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm0
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax
		jmp Ende

	Wurzel:
    fsqrt

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

		fstp qword ptr s_dZahl[esp]
		movsd xmm0, qword ptr s_dZahl[esp]
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    cvtsd2si edx, xmm2
    cvtsi2sd xmm2, edx
		mov dword ptr s_dZahl[esp], edx
		fild dword ptr s_dZahl[esp]
		fistp qword ptr s_dZahl[esp]
		movq xmm3, qword ptr s_dZahl[esp]
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
    movq xmm4, llEins
		paddq xmm3, xmm4

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    movq xmm4, llEins
		psubq xmm3, xmm4

  EndeRunden:
    movq qword ptr COComma4_80_llVorKomma[ecx], xmm3
    movq qword ptr COComma4_80_llVorKomma_A[ecx], xmm3
    mov word ptr COComma4_80_sNachKomma[ecx], ax
    mov word ptr COComma4_80_sNachKomma_A[ecx], ax

    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

	Ende:
    add esp, esp_Bytes
    ret
?Squareroot@COComma4_80@System@RePag@@QAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OKomma4_80 ENDS
END
