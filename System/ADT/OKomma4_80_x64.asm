;****************************************************************************
;  OKomma4_80_x64.asm
;  For more information see https://github.com/RePag-net/Abstract-Data-Types
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

.DATA
dbi_BY_COKOMMMA4_80 DB 32
dqd_Halbkreis DQ 180.0
dqd_Zehn DQ 10.0
dqd_Hundert DQ 100.0
dqd_Tausend DQ 1000.0
dqd_Zehntausend DQ 10000.0
dqd_EinsNullAcht DQ 100000000.0
dqd_Null DQ 0.0
dqd_Funf DQ 5.0
dqd_MinusFunf DQ -5.0
dqd_Eins DQ 1.0
dds_Zehntausend DD 10000.0
dqi_Pi_Lang DQ 3141592653589793238

CS_OKomma4_80 SEGMENT EXECUTE
;----------------------------------------------------------------------------
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@XZ	PROC ; COComma4_80V(void)
    sub rsp, s_ShadowRegister

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		xor rdx, rdx
    mov qword ptr COComma4_80_vmSpeicher[rax], rdx
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@XZ	ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX@Z PROC ; COComma4_80V(vmSpeicher)
		sub rsp, s_ShadowRegister
    mov qword ptr sqp_vmSpeicher[rsp], rcx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    
    mov rcx, qword ptr sqp_vmSpeicher[rsp] 
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_Zahl = 48
sdi_MXCSR_Alt = 44
sdi_MXCSR = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@N@Z PROC ; COComma4_80V(dZahl)
    sub rsp, s_ShadowRegister

    vmovsd qword ptr sqd_Zahl[rsp], xmm0

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm0, qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, xmm0, xmm0
    vcvttsd2si rcx, xmm1
    vcvtsi2sd xmm1, xmm1, rcx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

		test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rcx, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rcx, 1

  Ende:
    xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rax], r8
    mov qword ptr COComma4_80_llVorKomma[rax], rcx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rcx
    mov word ptr COComma4_80_sNachKomma[rax], dx
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_Zahl = 64
sdi_MXCSR_Alt = 56
sdi_MXCSR = 48
sqp_this = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXN@Z PROC ; COComma4_80V(vmSpeicher, dZahl)
    sub rsp, s_ShadowRegister

    mov qword ptr sqp_this[rsp], rcx
    vmovsd qword ptr sqd_Zahl[rsp], xmm1

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov r8, qword ptr sqp_this[rsp]
    mov qword ptr COComma4_80_vmSpeicher[rax], r8

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

	  vmovsd	xmm0, qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, xmm0, xmm0
    vcvttsd2si rcx, xmm1
    vcvtsi2sd xmm1, xmm1, rcx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rcx, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rcx, 1

  Ende:
    mov qword ptr COComma4_80_llVorKomma[rax], rcx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rcx
    mov word ptr COComma4_80_sNachKomma[rax], dx
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Zahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@H@Z PROC ; COComma4_80V(iZahl)
		sub rsp, s_ShadowRegister
		mov dword ptr sdi_Zahl[rsp], ecx

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sdi_Zahl[rsp]
		xor rcx, rcx
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    mov word ptr COComma4_80_sNachKomma[rax], cx
    mov word ptr COComma4_80_sNachKomma_A[rax], cx

		add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@H@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 48
sdi_iZahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXH@Z PROC ; COComma4_80V(vmSpeicher, iZahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_vmSpeicher[rsp], rcx
    mov dword ptr sdi_Zahl[rsp], edx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vmSpeicher[rsp]
		mov edx, dword ptr sdi_iZahl[rsp]
		xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov dword ptr COComma4_80_llVorKomma[rax], edx
    mov dword ptr COComma4_80_llVorKomma_A[rax], edx
    mov word ptr COComma4_80_sNachKomma[rax], r8w
    mov word ptr COComma4_80_sNachKomma_A[rax], r8w

		add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXH@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_llZahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@_J@Z PROC ; COComma4_80V(llZahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqi_llZahl[rsp], rcx

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov rdx, qword ptr sqi_llZahl[rsp]
		xor rcx, rcx
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    mov word ptr COComma4_80_sNachKomma[rax], cx
    mov word ptr COComma4_80_sNachKomma_A[rax], cx

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_llZahl = 48
sqp_vmSpeicher = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX_J@Z PROC ; COComma4_80V(vmSpeicher, llZahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqi_llZahl[rsp], rdx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_vmSpeicher[rsp]
		mov rdx, qword ptr sqi_llZahl[rsp]
		xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    mov word ptr COComma4_80_sNachKomma[rax], r8w
    mov word ptr COComma4_80_sNachKomma_A[rax], r8w

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBX_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pk4Zahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBVCOComma4@12@@Z PROC ; COComma4_80V(pk4Zahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_pk4Zahl[rsp], rcx

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pk4Zahl[rsp]
		xor rdx, rdx
    mov qword ptr COComma4_80_vmSpeicher[rax], rdx
    mov rdx, qword ptr COComma4_lVorKomma[rcx]
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov rdx, qword ptr COComma4_lVorKomma_A[rcx]
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    movsx rdx, word ptr COComma4_sNachKomma[rcx]
    mov word ptr COComma4_80_sNachKomma[rax], dx
    movsx rdx, word ptr COComma4_sNachKomma_A[rcx]
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pk4Zahl = 48
sqp_vmSpeicher = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEAVCOComma4@12@@Z PROC ; COComma4_80V(vmSpeicher, pk4Zahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_pk4Zahl[rsp], rdx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_vmSpeicher[rsp]
		mov rcx, qword ptr sqp_pk4Zahl[rsp]
    mov qword ptr COComma4_80_vmSpeicher[rax], rdx
    mov rdx, qword ptr COComma4_lVorKomma[rcx]
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov rdx, qword ptr COComma4_lVorKomma_A[rcx]
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    movsx rdx, word ptr COComma4_sNachKomma[rcx]
    mov word ptr COComma4_80_sNachKomma[rax], dx
    movsx rdx, word ptr COComma4_sNachKomma_A[rcx]
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEAVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pk4_80Zahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBV312@@Z PROC ; COComma4_80V(pk4_80Zahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_pk4_80Zahl[rsp], rcx

    movzx rdx, dbi_BY_COKOMMMA4_80
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pk4_80Zahl[rsp]
		xor rdx, rdx
    mov qword ptr COComma4_80_vmSpeicher[rax], rdx
    mov rdx, qword ptr COComma4_80_llVorKomma[rcx]
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov rdx, qword ptr COComma4_80_llVorKomma_A[rcx]
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    movsx rdx, word ptr COComma4_80_sNachKomma[rcx]
    mov word ptr COComma4_80_sNachKomma[rax], dx
    movsx rdx, word ptr COComma4_80_sNachKomma_A[rcx]
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@PEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pk4_80Zahl = 48
sqp_vmSpeicher = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEBV312@@Z PROC ; COComma4_80V(vmSpeicher, pk4_80Zahl)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_pk4_80Zahl[rsp], rdx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_vmSpeicher[rsp]
		mov rcx, qword ptr sqp_pk4_80Zahl[rsp]

    mov qword ptr COComma4_80_vmSpeicher[rax], rdx
    mov rdx, qword ptr COComma4_80_llVorKomma[rcx]
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov rdx, qword ptr COComma4_80_llVorKomma_A[rcx]
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    movsx rdx, word ptr COComma4_80_sNachKomma[rcx]
    mov word ptr COComma4_80_sNachKomma[rax], dx
    movsx rdx, word ptr COComma4_80_sNachKomma_A[rcx]
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXPEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_m128dZahl = 48
sdi_MXCSR_Alt = 44
sdi_MXCSR = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@U__m128d@@@Z PROC ; COComma4_80V(m128dZahl)
    sub rsp, s_ShadowRegister

		vmovsd qword ptr sqd_m128dZahl[rsp], xmm0

    movzx rdx, dbi_BY_COKOMMMA4_80
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]	 
   
	  vmovsd	xmm0, qword ptr sqd_m128dZahl[rsp]
    vmovsd xmm1, xmm0, xmm0
    vcvttsd2si rcx, xmm1
    vcvtsi2sd xmm1, xmm1, rcx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rcx, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rcx, 1
    
  Ende:
    xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rax], r8
    mov qword ptr COComma4_80_llVorKomma[rax], rcx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rcx
    mov word ptr COComma4_80_sNachKomma[rax], dx
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 64
sqd_m128dZahl = 48
sdi_MXCSR_Alt = 44
sdi_MXCSR = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXU__m128d@@@Z PROC ; COComma4_80V(vmSpeicher, m128dZahl)
    sub rsp, s_ShadowRegister

    mov qword ptr sqp_vmSpeicher[rsp], rcx
		vmovsd qword ptr sqd_m128dZahl[rsp], xmm1

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov rdx, qword ptr sqp_vmSpeicher[rsp]
    mov qword ptr COComma4_vmSpeicher[rax], rdx

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]	 
   
	  vmovsd	xmm0, qword ptr sqd_m128dZahl[rsp]
    vmovsd xmm1, xmm0, xmm0
    vcvttsd2si rcx, xmm1
    vcvtsi2sd xmm1, xmm1, rcx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rcx, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rcx, 1
    
  Ende:
    mov qword ptr COComma4_80_llVorKomma[rax], rcx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rcx
    mov word ptr COComma4_80_sNachKomma[rax], dx
    mov word ptr COComma4_80_sNachKomma_A[rax], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    add rsp, s_ShadowRegister
    ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_m128iZahl = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@T__m128i@@@Z PROC ; COComma4_80V(m128iZahl)
		sub rsp, s_ShadowRegister

		vmovq qword ptr sqi_m128iZahl[rsp], xmm0

    movzx rdx, dbi_BY_COKOMMMA4_80
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov rdx, qword ptr sqi_m128iZahl[rsp]
		xor rcx, rcx
		mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    mov word ptr COComma4_80_sNachKomma[rax], cx
    mov word ptr COComma4_80_sNachKomma_A[rax], cx

		add rsp, s_ShadowRegister
		ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@T__m128i@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_m128iZahl = 48
sqp_vmSpeicher = 40
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXT__m128i@@@Z PROC ; COComma4_80V(vmSpeicher, m128iZahl)
		sub rsp, s_ShadowRegister

		vmovq qword ptr sqi_m128iZahl[rsp], xmm0
		mov qword ptr sqp_vmSpeicher[rsp], rcx

    movzx rdx, dbi_BY_COKOMMMA4_80
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov rcx, qword ptr sqp_vmSpeicher[rsp]
    mov rdx, qword ptr sqi_m128iZahl[rsp]
    xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rax], rcx
    mov qword ptr COComma4_80_llVorKomma[rax], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rax], rdx
    mov word ptr COComma4_80_sNachKomma[rax], r8w
    mov word ptr COComma4_80_sNachKomma_A[rax], r8w

		add rsp, s_ShadowRegister
		ret
?COComma4_80V@System@RePag@@YQPEAVCOComma4_80@12@QEBXT__m128i@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COFreiV@COComma4_80@System@RePag@@QEAQPEBXXZ PROC ; COComma4_80::COFreiV(void)
    mov rax, qword ptr COComma4_80_vmSpeicher[rcx]
    ret
?COFreiV@COComma4_80@System@RePag@@QEAQPEBXXZ ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@XZ PROC ; COComma4_80::COComma4_80(void)
    xor rax, rax
		mov qword ptr COComma4_80_vmSpeicher[rcx], rax
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    ret
??0COComma4_80@System@RePag@@QEAA@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_dZahl = 48
sdi_MXCSR_Alt = 44
sdi_MXCSR = 40
??0COComma4_80@System@RePag@@QEAA@N@Z PROC ; COComma4_80::COComma4_80(dZahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm0, xmm1, xmm1
    vcvttsd2si rax, xmm1
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

		test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rax, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rax, 1
    
  Ende:
  	xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rcx], r8
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??0COComma4_80@System@RePag@@QEAA@N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@T__m128i@@@Z PROC ; COComma4::COComma4(m128iZahl)
		xor rdx, rdx
    mov qword ptr COComma4_80_vmSpeicher[rcx], rdx
    vmovq qword ptr COComma4_80_llVorKomma[rcx], xmm0
    vmovq qword ptr COComma4_80_llVorKomma_A[rcx], xmm0
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx
    ret
??0COComma4_80@System@RePag@@QEAA@T__m128i@@@Z ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@H@Z PROC ; COComma4_80::COComma4_80(iZahl)
		xor rax, rax
    mov qword ptr COComma4_80_vmSpeicher[rcx], rax
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
		ret
??0COComma4_80@System@RePag@@QEAA@H@Z ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@_J@Z PROC ; COComma4_80::COComma4_80(llZahl)
    xor rax, rax
		mov qword ptr COComma4_80_vmSpeicher[rcx], rax
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    ret
??0COComma4_80@System@RePag@@QEAA@_J@Z ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@AEBVCOComma4@12@@Z PROC ; COComma4_80::COComma4_80(&k4Zahl)
		xor rax, rax
    mov qword ptr COComma4_80_vmSpeicher[rcx], rax
    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov eax, dword ptr COComma4_lVorKomma_A[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    movsx rax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    movsx rax, word ptr COComma4_sNachKomma_A[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    ret
??0COComma4_80@System@RePag@@QEAA@AEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??0COComma4_80@System@RePag@@QEAA@AEBV012@@Z PROC ; COComma4_80::COComma4_80(&k4_80Zahl)
    xor rax, rax
		mov qword ptr COComma4_80_vmSpeicher[rcx], rax
    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov rax, qword ptr COComma4_80_llVorKomma_A[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    movsx eax, word ptr COComma4_80_sNachKomma_A[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    ret
??0COComma4_80@System@RePag@@QEAA@AEBV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??0COComma4_80@System@RePag@@QEAA@U__m128d@@@Z PROC ; COComma4_80::COComma4_80(m128dZahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm1, xmm0, xmm0
    vcvttsd2si rax, xmm1
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rax, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rax, 1
    
  Ende:
  	xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rcx], r8
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??0COComma4_80@System@RePag@@QEAA@U__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??4COComma4_80@System@RePag@@QEAQXN@Z PROC ; COComma4_80::operator=(dZahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm0, xmm1, xmm1
    vcvttsd2si rax, xmm1
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp r8, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rax, 1
    jmp short Ende

  Minus:
    cmp r8, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rax, 1
    
  Ende:
  	xor r8, r8
    mov qword ptr COComma4_80_vmSpeicher[rcx], r8
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??4COComma4_80@System@RePag@@QEAQXN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QEAQXH@Z PROC ; COComma4_80::operator=(iZahl)
    xor rax, rax
    mov dword ptr COComma4_80_llVorKomma[rcx], edx
    mov dword ptr COComma4_80_llVorKomma_A[rcx], edx
		mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
		ret
??4COComma4_80@System@RePag@@QEAQXH@Z ENDP
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QEAQX_J@Z PROC ; COComma4_80::operator=(llZahl)
    xor rax, rax
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
		ret
??4COComma4_80@System@RePag@@QEAQX_J@Z ENDP
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z PROC ; COComma4_80::operator=(&k4Zahl)
		mov eax, dword ptr COComma4_lVorKomma_A[rdx]
    mov dword ptr COComma4_80_llVorKomma[rcx], eax

    movsx rax, word ptr COComma4_sNachKomma_A[rdx]
    mov word ptr COComma4_80_sNachKomma[rcx], ax

		mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_80_llVorKomma_A[rcx], eax

    movsx rax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    ret
??4COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QEAQXAEBV012@@Z PROC ; COComma4_80::operator=(&k4_80Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma_A[rdx]
    mov qword ptr COComma4_80_llVorKomma[rcx], rax

    movsx rax, word ptr COComma4_80_sNachKomma_A[rdx]
    mov word ptr COComma4_80_sNachKomma[rcx], ax

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx rax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax
    ret
??4COComma4_80@System@RePag@@QEAQXAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??4COComma4_80@System@RePag@@QEAQXT__m128i@@@Z PROC ; COComma4_80::operator=(m128iZahl)
    xor rax, rax
		vmovq qword ptr COComma4_80_llVorKomma[rcx], xmm1
    vmovq qword ptr COComma4_80_llVorKomma_A[rcx], xmm1
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
		ret
??4COComma4_80@System@RePag@@QEAQXT__m128i@@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??4COComma4_80@System@RePag@@QEAQXU__m128d@@@Z PROC ; COComma4_80::operator=(m128dZahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm0, xmm1, xmm1
    vcvttsd2si rax, xmm1
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0,  xmm2, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm2, xmm0, xmm1
    vmulsd xmm0, xmm2, dqd_Zehn
    vcvtsd2si r8, xmm0

    test r8, r8
    je short Ende
    jl short Minus
    cmp ebx, 5
    jb short Ende
    add dx, 1
    cmp dx, 10000
    jb short Ende
    xor dx, dx
    add rax, 1
    jmp short Ende

  Minus:
    cmp ebx, -5
    jg short Ende
    sub dx, 1
    cmp dx, -10000
    jg short Ende
    xor dx, dx
    sub rax, 1
    
  Ende:
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??4COComma4_80@System@RePag@@QEAQXU__m128d@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??YCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z PROC ; COComma4_80::operator+=(&k4Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
    add eax, dword ptr COComma4_lVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    add r8w, word ptr COComma4_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_80_sNachKomma[rcx]
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    movsx r9, word ptr COComma4_sNachKomma_A[rdx] 
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    cmp r8w, 10000
    jl short Ende
    sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_80_sNachKomma[rcx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    movsx r9, word ptr COComma4_sNachKomma_A[rdx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    cmp r8w, -10000
    jg short Ende
    sub r8w, -10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Einer_Minus:
		test rax, rax
    jge short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
    test rax, rax
		jbe short Ende
		add r8w, 10000
    sub rax, 1

  Ende:
    mov dword ptr COComma4_80_llVorKomma[rcx], eax
    mov dword ptr COComma4_80_llVorKomma_A[rcx], eax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
    ret
??YCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z PROC ; COComma4_80::operator+=(&k4_80Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
    add rax, qword ptr COComma4_80_llVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    add r8w, word ptr COComma4_80_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_80_sNachKomma[rcx]
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    cmp r8w, 10000
    jl short Ende
    sub bx, 10000
    add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_80_sNachKomma[rcx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    cmp r8w, -10000
    jg short Ende
    sub r8w, -10000
    sub rax, 1
    jmp short Ende

  NachKomma_Plus_Einer_Minus:
    test rax, rax
    jge short Ende
		sub r8w, 10000
    add rax, 1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
    test rax, rax
    jbe short Ende
		add bx, 10000
    sub rax, 1

  Ende:
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx rax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax
    
    ret
??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z ENDP
;----------------------------------------------------------------------------
??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z PROC ; COComma4_80::operator+(&k4Zahl)
    mov eax, dword ptr COComma4_80_llVorKomma_A[rcx]
    add eax, dword ptr COComma4_lVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    add r8w, word ptr COComma4_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_80_sNachKomma_A[rcx]
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    movsx r9, word ptr COComma4_sNachKomma_A[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Einer_Minus
    cmp r8w, 10000
    jl short Ende
    sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_80_sNachKomma_A[rcx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    movsx r9, word ptr COComma4_sNachKomma_A[rdx]
    test r9w, r9w
    jg short NachKomma_Minus_Einer_Plus
    cmp r8w, -10000
    jg short Ende
    sub r8w, -10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Einer_Minus:
    test rax, rax
    jge short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus_Einer_Plus:
    test rax, rax
    jbe short Ende
		add bx, 10000
		sub rax, 1

  Ende:
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax

    mov rax, rcx
    ret
??HCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??ZCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z PROC ; COComma4_80::operator-=(&k4Zahl)
    mov eax, dword ptr COComma4_80_llVorKomma[rcx]
    sub eax, dword ptr COComma4_lVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    sub r8w, word ptr COComma4_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_sNachKomma_A[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Zweiter_Minus
    test rax, rax
    jge short Ende
		sub r8w, 10000
    add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_sNachKomma_A[rdx]
    test r9w, r9w
    jge short NachKomma_Minus_Zweiter_Plus
    test rax, rax
    jbe short Ende
		add r8w, 10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp r8w, 10000
		jl short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp r8w, -10000
    jg short Ende
    add r8w, 10000
		sub rax, 1

  Ende:
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], bx
    mov word ptr COComma4_80_sNachKomma_A[rcx], bx

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
    ret
??ZCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??ZCOComma4_80@System@RePag@@QEAQXAEBV012@@Z PROC ; COComma4_80::operator-=(&k4_80Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		sub rax, qword ptr COComma4_80_llVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    sub r8w, word ptr COComma4_80_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Zweiter_Minus
    test rax, rax
    jge short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jge short NachKomma_Minus_Zweiter_Plus
    test rax, rax
    jbe short Ende
		add r8w, 10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp r8w, 10000
		jl short Ende
		sub r8w, 10000
	  add rax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp r8w, -10000
    jg short Ende
    add r8w, 10000
		sub rax, 1

  Ende:
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax
    
    ret
??ZCOComma4_80@System@RePag@@QEAQXAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z PROC ; COComma4_80::operator-(&k4Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma_A[rcx]
	  sub eax, dword ptr COComma4_lVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    sub r8w, word ptr COComma4_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_sNachKomma[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Zweiter_Minus
    test r9w, r9w
    jge short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_sNachKomma[rdx]
    test r9w, r9w
    jge short NachKomma_Minus_Zweiter_Plus
    test rax, rax
    jle short Ende
		add r8w, 10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp r8w, 10000
		jl short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp r8w, -10000
    jg short Ende
    add r8w, 10000
		sub rax, 1

	Ende:
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax

    mov rax, rcx
    ret
??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z PROC ; COComma4_80::operator-(&k4_80Zahl)
    mov rax, qword ptr COComma4_80_llVorKomma_A[rcx]
    sub rax, qword ptr COComma4_80_llVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    sub r8w, word ptr COComma4_80_sNachKomma_A[rdx]

    test r8w, r8w
    je short Ende
    jl short NachKomma_Minus

    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jl short NachKomma_Plus_Zweiter_Minus
    test rax, rax
    jge short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus:
    movsx r9, word ptr COComma4_80_sNachKomma_A[rdx]
    test r9w, r9w
    jge short NachKomma_Minus_Zweiter_Plus
    test rax, rax
    jle short Ende
		add r8w, 10000
		sub rax, 1
    jmp short Ende

  NachKomma_Plus_Zweiter_Minus:
	  cmp r8w, 10000
		jl short Ende
		sub r8w, 10000
		add rax, 1
    jmp short Ende

  NachKomma_Minus_Zweiter_Plus:
    cmp r8w, -10000
    jg short Ende
    add r8w, 10000
		sub rax, 1

	Ende:
    mov dword ptr COComma4_80_llVorKomma[rcx], eax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax

    mov rax, rcx
    ret
??GCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??XCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z PROC ; COComma4_80::operator*=(&k4Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx] 
		vcvtsi2sd xmm1, xmm1, dword ptr COComma4_lVorKomma_A[rdx]
    vmulsd xmm4, xmm0, xmm1

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm2, xmm2, r8d
    movsx r8, word ptr COComma4_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		vmulsd xmm0, xmm0, xmm3
		vdivsd xmm0, xmm0, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm0

		vmulsd xmm1, xmm1, xmm2
		vdivsd xmm1, xmm1, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm1

		vmulsd xmm2, xmm2, xmm3
		vdivsd xmm2, xmm2, dqd_EinsNullAcht
		vaddsd xmm4, xmm4, xmm2

    vroundpd xmm0, xmm4, 00000011b
    vcvtsd2si rax, xmm0
		vsubsd xmm4, xmm4, xmm0
		vmulsd xmm4, xmm4, dqd_Zehntausend
		vcvtsd2si r8, xmm4

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov rax, qword ptr COComma4_lVorKomma[rdx]
    mov qword ptr COComma4_lVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??XCOComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??XCOComma4_80@System@RePag@@QEAQXAEBV012@@Z PROC ; COComma4_80::operator*=(&k4_80Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx] 
		vcvtsi2sd xmm1, xmm1, dword ptr COComma4_80_llVorKomma_A[rdx]
    vmulsd xmm4, xmm0, xmm1

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm2, xmm2, r8d 
    movsx r8, word ptr COComma4_80_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		vmulsd xmm0, xmm0, xmm3
		vdivsd xmm0, xmm0, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm0

		vmulsd xmm1, xmm1, xmm2
		vdivsd xmm1, xmm1, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm1

		vmulsd xmm2, xmm2, xmm3
		vdivsd xmm2, xmm2, dqd_EinsNullAcht
		vaddsd xmm4, xmm4, xmm2

    vroundpd xmm0, xmm4, 00000011b
    vcvtsd2si rax, xmm0
		vsubsd xmm4, xmm4, xmm0
		vmulsd xmm4, xmm4, dqd_Zehntausend
		vcvtsd2si r8, xmm4

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??XCOComma4_80@System@RePag@@QEAQXAEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z PROC ; COComma4_80::operator*(&k4Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, qword ptr COComma4_80_llVorKomma_A[rcx]
		vcvtsi2sd xmm1, xmm1, dword ptr COComma4_lVorKomma_A[rdx]
    vmulsd xmm4, xmm0, xmm1

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    vcvtsi2sd xmm2, xmm2, r8d 
    movsx r8, word ptr COComma4_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d 

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		vmulsd xmm0, xmm0, xmm3
		vdivsd xmm0, xmm0, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm0

		vmulsd xmm1, xmm1, xmm2
		vdivsd xmm1, xmm1, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm1

		vmulsd xmm2, xmm2, xmm3
		vdivsd xmm2, xmm2, dqd_EinsNullAcht
		vaddsd xmm4, xmm4, xmm2

    vroundpd xmm0, xmm4, 00000011b
    vcvtsd2si rax, xmm0
		vsubsd xmm4, xmm4, xmm0
		vmulsd xmm4, xmm4, dqd_Zehntausend
		vcvtsd2si r8, xmm4

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
		mov rax, rcx

    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MdXCSR = 8
??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z PROC ; COComma4_80::operator*(&k4_80Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		vcvtsi2sd xmm0, xmm0, qword ptr COComma4_80_llVorKomma_A[rcx]
		vcvtsi2sd xmm1, xmm1, qword ptr COComma4_80_llVorKomma_A[rdx]
    vmulsd xmm4, xmm0, xmm1

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    vcvtsi2sd xmm2, xmm2, r8d 
    movsx r8, word ptr COComma4_80_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d 

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		vmulsd xmm0, xmm0, xmm3
		vdivsd xmm0, xmm0, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm0

		vmulsd xmm1, xmm1, xmm2
		vdivsd xmm1, xmm1, dqd_Zehntausend
		vaddsd xmm4, xmm4, xmm1

		vmulsd xmm2, xmm2, xmm3
		vdivsd xmm2, xmm2, dqd_EinsNullAcht
		vaddsd xmm4, xmm4, xmm2

    vroundpd xmm0, xmm4, 00000011b
    vcvtsd2si rax, xmm0
		vsubsd xmm4, xmm4, xmm0
		vmulsd xmm4, xmm4, dqd_Zehntausend
		vcvtsd2si r8, xmm4
		vcvtsd2si r8, xmm4

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w

    mov rax, qword ptr COComma4_80_llVorKomma[rdx]
    mov qword ptr COComma4_80_llVorKomma_A[rdx], rax

    movsx eax, word ptr COComma4_80_sNachKomma[rdx]
    mov word ptr COComma4_80_sNachKomma_A[rdx], ax

		mov rax, rcx
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??DCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??_0COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z PROC ; COComma4_80::operator/=(&k4Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx]
		vcvtsi2sd xmm1, xmm1, dword ptr COComma4_lVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm2, xmm2, r8
    movsx r8, word ptr COComma4_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8

    vdivsd xmm2, xmm2, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm2
    vdivsd xmm3, xmm3, dqd_Zehntausend
    vaddsd xmm1, xmm1, xmm3

    vdivsd xmm0, xmm0, xmm1
    vcvtsd2si rax, xmm0
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm0, xmm0, xmm1

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si r8d, xmm0

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??_0COComma4_80@System@RePag@@QEAQXAEBVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??_0COComma4_80@System@RePag@@QEAQXAEBV012@@Z PROC ; COComma4_80::operator/=(&k4_80Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx]
		vcvtsi2sd xmm1, xmm1, dword ptr COComma4_80_llVorKomma_A[rdx]

    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm2, xmm2, r8
    movsx r8, word ptr COComma4_80_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8

    vdivsd xmm2, xmm2, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm2
    vdivsd xmm3, xmm3, dqd_Zehntausend
    vaddsd xmm1, xmm1, xmm3

    vdivsd xmm0, xmm0, xmm1
    vcvtsd2si rax, xmm0
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm0, xmm0, xmm1

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si r8d, xmm0

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], r8w
    mov word ptr COComma4_80_sNachKomma_A[rcx], r8w

    mov eax, dword ptr COComma4_80_llVorKomma[rdx]
    mov dword ptr COComma4_80_llVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??_0COComma4_80@System@RePag@@QEAQXAEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z PROC ; COComma4_80::operator/(&k4Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    mov r8, qword ptr COComma4_80_llVorKomma_A[rcx]
    vcvtsi2sd xmm0, xmm0, r8 
    mov r8d, dword ptr COComma4_lVorKomma_A[rdx]
    vcvtsi2sd xmm1, xmm1, r8d 

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    vcvtsi2sd xmm2, xmm2, r8d
    movsx r8, word ptr COComma4_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d

    vdivsd xmm2, xmm2, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm2
    vdivsd xmm3, xmm3, dqd_Zehntausend
    vaddsd xmm1, xmm1, xmm3

    vdivsd xmm0, xmm0, xmm1
    vcvtsd2si rax, xmm0
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm0, xmm0, xmm1

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si r8d, xmm0

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], bx

    mov eax, dword ptr COComma4_lVorKomma[rdx]
    mov dword ptr COComma4_lVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax

		mov rax, rcx
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBVCOComma4@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z PROC ; COComma4_80::operator/(&k4_80Zahl)
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    mov r8, qword ptr COComma4_80_llVorKomma_A[rcx]
    vcvtsi2sd xmm0, xmm0, r8 
    mov r8d, dword ptr COComma4_80_llVorKomma_A[rdx]
    vcvtsi2sd xmm1, xmm1, r8d 

    movsx r8, word ptr COComma4_80_sNachKomma_A[rcx]
    vcvtsi2sd xmm2, xmm2, r8d
    movsx r8, word ptr COComma4_80_sNachKomma_A[rdx]
    vcvtsi2sd xmm3, xmm3, r8d

    vdivsd xmm2, xmm2, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm2
    vdivsd xmm3, xmm3, dqd_Zehntausend
    vaddsd xmm1, xmm1, xmm3

    vdivsd xmm0, xmm0, xmm1
    vcvtsd2si rax, xmm0
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm0, xmm0, xmm1

    xor dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si r8d, xmm0

    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], bx

    mov eax, dword ptr COComma4_80_llVorKomma[rdx]
    mov dword ptr COComma4_80_llVorKomma_A[rdx], eax

    movsx eax, word ptr COComma4_sNachKomma[rdx]
    mov word ptr COComma4_sNachKomma_A[rdx], ax

		mov rax, rcx
    
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
??KCOComma4_80@System@RePag@@QEAQAEAV012@AEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Compare@COComma4_80@System@RePag@@QEAQDPEBVCOComma4@23@@Z PROC ; COComma4_80::Compare(pk4Zahl)
    mov rax, -1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    jb short Ende
    mov rax, 1
    ja short Ende
    mov rax, -1
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    jb short Ende
    mov rax, 1
    ja short Ende
    xor rax, rax

  Ende:
    ret
?Compare@COComma4_80@System@RePag@@QEAQDPEBVCOComma4@23@@Z ENDP
;----------------------------------------------------------------------------
?Compare@COComma4_80@System@RePag@@QEAQDPEBV123@@Z PROC ; COComma4_80::Compare(pk4_80Zahl)
    mov rax, -1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8, qword ptr COComma4_80_llVorKomma[rdx]
    jb short Ende
    mov rax, 1
    ja short Ende
    mov rax, -1
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    jb short Ende
    mov rax, 1
    ja short Ende
    xor rax, rax

  Ende:
    ret
?Compare@COComma4_80@System@RePag@@QEAQDPEBV123@@Z ENDP
;----------------------------------------------------------------------------
??MCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4_80::operator<(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    jb short Ende
    ja short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    jb short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret 
??MCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??MCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4_80::operator<(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8, qword ptr COComma4_80_llVorKomma[rdx]
    jb short Ende
    ja short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    jb short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??MCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4::operator>(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    ja short Ende
    jb short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    ja short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??OCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??OCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4::operator>(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8, qword ptr COComma4_80_llVorKomma[rdx]
    ja short Ende
    jb short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    ja short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??OCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??NCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4::operator<=(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    jb short Ende
    ja short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    jbe short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret 
??NCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??NCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4_80::operator<=(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_80_llVorKomma[rdx]
    jb short Ende
    ja short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    jbe short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret 
??NCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??PCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4_80::operator>=(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    ja short Ende
    jb short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    jae short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??PCOComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??PCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4_80::operator>=(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8, qword ptr COComma4_80_llVorKomma[rdx]
    ja short Ende
    jb short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    jae short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??PCOComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??8COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4_80::operator==(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    jne short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    je short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??8COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??8COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4_80::operator==(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8, qword ptr COComma4_80_llVorKomma[rdx]
    jne short Ungleich
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    je short Ende

  Ungleich:
    xor rax, rax

  Ende:
    ret
??8COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??9COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z PROC ; COComma4_80::operator!=(&k4Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_lVorKomma[rdx]
    jne short Ende
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_sNachKomma[rdx]
    jne short Ende
    xor rax, rax

  Ende:
    ret
??9COComma4_80@System@RePag@@QEAQ_NAEBVCOComma4@12@@Z ENDP
;----------------------------------------------------------------------------
??9COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COComma4_80::operator!=(&k4_80Zahl)
    mov rax, 1
    mov r8, qword ptr COComma4_80_llVorKomma[rcx]
    cmp r8d, dword ptr COComma4_80_llVorKomma[rdx]
    jne short Ende
    movsx r8, word ptr COComma4_80_sNachKomma[rcx]
    cmp r8w, word ptr COComma4_80_sNachKomma[rdx]
    jne short Ende
    xor rax, rax

  Ende:
    ret
??9COComma4_80@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??ECOComma4_80@System@RePag@@QEAQXXZ PROC ; COComma4_80::operator++(void)
		mov rax, qword ptr COComma4_80_llVorKomma[rcx] 
		test rax, rax
		jne short UngleichNull
		xor rax, rax
		cmp word ptr COComma4_80_sNachKomma[rcx], ax
		jge short UngleichNull
		add word ptr COComma4_80_sNachKomma[rcx], 10000
		jmp short Ende

	UngleichNull:
    add dword ptr COComma4_80_llVorKomma[rcx], 1

  Ende:
		mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
		movsx rax, word ptr COComma4_80_sNachKomma[rcx]
		mov word ptr COComma4_80_llVorKomma_A[rcx], ax
    ret 
??ECOComma4_80@System@RePag@@QEAQXXZ ENDP
;----------------------------------------------------------------------------
??ECOComma4_80@System@RePag@@QEAQXH@Z PROC ; COComma4_80::operator++(int i)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		test rax, rax
		jne short UngleichNull
		xor rax, rax
		cmp word ptr COComma4_80_sNachKomma[rcx], ax
		jge short UngleichNull
		add word ptr COComma4_80_sNachKomma[rcx], 10000
		jmp short Ende

	UngleichNull:
    add qword ptr COComma4_80_llVorKomma[rcx], 1

  Ende:
		mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
		movsx rax, word ptr COComma4_80_sNachKomma[rcx]
		mov word ptr COComma4_80_llVorKomma_A[rcx], ax
    ret
??ECOComma4_80@System@RePag@@QEAQXH@Z ENDP
;----------------------------------------------------------------------------
??FCOComma4_80@System@RePag@@QEAQXH@Z PROC ; COComma4_80::operator--(void)
		mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		test rax, rax
		jne short UngleichNull
		xor rax, rax
		cmp word ptr COComma4_80_sNachKomma[rcx], ax
		jle short UngleichNull
		add word ptr COComma4_80_sNachKomma[rcx], -10000
		jmp short Ende

	UngleichNull:
    sub dword ptr COComma4_80_llVorKomma[rcx], 1

  Ende:
		mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		mov qword ptr COComma4_lVorKomma_A[rcx], rax
		movsx rax, word ptr COComma4_80_sNachKomma[rcx]
		mov word ptr COComma4_80_llVorKomma_A[rcx], ax
    ret
??FCOComma4_80@System@RePag@@QEAQXH@Z ENDP
;----------------------------------------------------------------------------
??FCOComma4_80@System@RePag@@QEAQXXZ PROC ; COComma4_80::operator--(int i)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
		test rax, rax
		jne short UngleichNull
		xor rax, rax
		cmp word ptr COComma4_sNachKomma[rcx], ax
		jle short UngleichNull
		add word ptr COComma4_sNachKomma[rcx], -10000
		jmp short Ende

	UngleichNull:
    sub dword ptr COComma4_lVorKomma[rcx], 1

  Ende:
		mov rax, qword ptr COComma4_lVorKomma[rcx]
		mov qword ptr COComma4_lVorKomma_A[rcx], rax
		movsx eax, word ptr COComma4_sNachKomma[rcx]
		mov word ptr COComma4_lVorKomma_A[rcx], ax
    ret
??FCOComma4_80@System@RePag@@QEAQXXZ ENDP
;----------------------------------------------------------------------------
?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z PROC ; COComma4_80::Read(cZahl[10])
    test rdx, rdx
    je short Ende

    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
    mov qword ptr [rdx], rax
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]
    mov word ptr [rdx + 8], ax

  Ende:
    ret
?Read@COComma4_80@System@RePag@@QEAQXQEBD@Z ENDP
;----------------------------------------------------------------------------
?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z PROC ; COComma4_80::Write(cZahl[10])
    test rdx, rdx
    je short Null

    mov rax, qword ptr [rdx]
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    movsx rax, word ptr [rdx + 4]
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
    jmp short Ende

  Null:
		xor rax, rax
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax

  Ende:
    ret
?Write@COComma4_80@System@RePag@@QEAQXQEBD@Z ENDP
;----------------------------------------------------------------------------
?PreComma@COComma4_80@System@RePag@@QEAQ_JXZ PROC ; COComma4_80::PreComma(void)
		xor rax, rax
    mov rax, qword ptr COComma4_lVorKomma[rcx]
    ret
?PreComma@COComma4_80@System@RePag@@QEAQ_JXZ ENDP
;----------------------------------------------------------------------------
?AfterComma@COComma4_80@System@RePag@@QEAQFXZ PROC ; COComma4_80::AfterComma(void)
		movsx eax, word ptr COComma4_sNachKomma[rcx]
    ret
?AfterComma@COComma4_80@System@RePag@@QEAQFXZ ENDP
;----------------------------------------------------------------------------
?FLOAT@COComma4_80@System@RePag@@QEAQMXZ PROC ; COComma4_80::FLOAT(void)
    vcvtsi2ss xmm0, xmm0, qword ptr COComma4_80_llVorKomma[rcx]
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2ss xmm1, xmm1, rax
    vdivss xmm1, xmm1, dds_Zehntausend
    vaddss xmm0, xmm0, xmm1
    ret
?FLOAT@COComma4_80@System@RePag@@QEAQMXZ ENDP
;----------------------------------------------------------------------------
?DOUBLE@COComma4_80@System@RePag@@QEAQNXZ PROC ; COComma4_80::DOUBLE(void)
    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx]
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm1, xmm1, rax
    vdivsd xmm1, xmm1, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm1
    ret
?DOUBLE@COComma4_80@System@RePag@@QEAQNXZ ENDP
;----------------------------------------------------------------------------
?M128D@COComma4_80@System@RePag@@QEAQ?AU__m128d@@XZ PROC ; COComma4_80::M128D(void)
    vcvtsi2sd xmm0, xmm0, dword ptr COComma4_80_llVorKomma[rcx]
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]
    vcvtsi2sd xmm1, xmm1, rax
    vdivsd xmm1, xmm1, dqd_Zehntausend
    vaddsd xmm0, xmm0, xmm1
    ret
?M128D@COComma4_80@System@RePag@@QEAQ?AU__m128d@@XZ ENDP
;----------------------------------------------------------------------------
?SetZero@COComma4_80@System@RePag@@QEAQXXZ PROC ; COComma4_80::SetZero(void)
		vpxor xmm0, xmm0, xmm0
    vmovdqu xmmword ptr [rcx], xmm0
    vmovdqu xmmword ptr [rcx + 4], xmm0
    ret
?SetZero@COComma4_80@System@RePag@@QEAQXXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_MXCSR_Alt = 12
sdi_MXCSR = 8
?Round@COComma4_80@System@RePag@@QEAQPEAV123@E@Z PROC ; COComma4_80::Round(ucStellen)
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]

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
    movsd xmm2, dqd_Hundert
    jmp short Runden

  Stellen_1:
    test dl, dl
    je short Stellen_0
    cmp eax, 9500
    jge short VorKommaPlusMinus
    cmp eax, -9500
    jle short VorKommaPlusMinus
    movsd xmm2, dqd_Tausend
    jmp short Runden

  Stellen_3:
    cmp eax, 9995
    jge short VorKommaPlusMinus
    cmp eax, -9995
    jle short VorKommaPlusMinus
    movsd xmm2,  dqd_Zehn
    jmp short Runden   
    
  Stellen_0:
    cmp eax, 5000
    jge short VorKommaPlusMinus
    cmp eax, -5000
    jle short VorKommaPlusMinus
    movsd xmm2,  dqd_Zehntausend
    jmp short Runden

  VorKommaPlusMinus:
    xor rax, rax
    cmp qword ptr COComma4_80_llVorKomma[rcx], rax
    jge short VorKommaPlus
    sub dword ptr COComma4_80_llVorKomma[rcx], 1
    sub dword ptr COComma4_80_llVorKomma_A[rcx], 1
    jmp Ende
  VorKommaPlus:
    add dword ptr COComma4_80_llVorKomma[rcx], 1
    add dword ptr COComma4_80_llVorKomma_A[rcx], 1
    jmp Ende

  Runden:
    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    vmovsd xmm3, xmm2, xmm2
    vcvtsi2sd xmm0, xmm0, eax
    vmovsd xmm1, xmm1, xmm0
    vdivsd xmm0, xmm1, xmm2
    vcvttsd2si eax, xmm0
    vcvtsi2sd xmm0, xmm0, eax
    vmulsd xmm0, xmm0, xmm2
    vsubsd xmm1, xmm1, xmm0
    vdivsd xmm2, xmm2, dqd_Zehn
    vdivsd xmm1, xmm1, xmm2

		vxorpd xmm5, xmm5, xmm5
    vucomisd xmm1, xmm5
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    vcvtsi2sd xmm0, xmm0, eax
    vaddsd xmm0, xmm0, dqd_Eins
    vmulsd xmm0, xmm0, xmm3
    jmp short EndeRunden

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    vcvtsi2sd xmm0, xmm0, eax
    vsubsd xmm0, xmm0, dqd_Eins
    vmulsd xmm0, xmm0, xmm3

  EndeRunden:
    vcvtsd2si eax, xmm0
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]

  Ende:
    mov word ptr COComma4_sNachKomma[rcx], ax
    mov rax, rcx
    ret 
?Round@COComma4_80@System@RePag@@QEAQPEAV123@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?PresignChange@COComma4_80@System@RePag@@QEAQXXZ PROC ; COComma4_80::PresignChange(void)
    mov rax, qword ptr COComma4_80_llVorKomma[rcx]
    imul rax, -1
    mov qword ptr COComma4_80_llVorKomma[rcx], rax
    movsx rax, word ptr COComma4_80_sNachKomma[rcx]
    imul rax, -1
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    ret
?PresignChange@COComma4_80@System@RePag@@QEAQXXZ ENDP
;----------------------------------------------------------------------------
?pi@COComma4_80@System@RePag@@QEAQPEAV123@XZ PROC ; COComma4_80::pi(void)
    mov qword ptr COComma4_80_llVorKomma[rcx], 3
    mov word ptr COComma4_80_sNachKomma[rcx], 1416
    mov rax, rcx
    ret
?pi@COComma4_80@System@RePag@@QEAQPEAV123@XZ ENDP
;----------------------------------------------------------------------------
?pi_10e18@COComma4_80@System@RePag@@QEAQPEAV123@XZ PROC ; COComma4_80::pi_10e18(void)
    vmovq xmm0, dqi_Pi_Lang
    vmovq qword ptr COComma4_80_llVorKomma[rcx], xmm0
    vmovq qword ptr COComma4_80_llVorKomma_A[rcx], xmm0
    mov word ptr COComma4_80_sNachKomma[rcx], 4626
    mov word ptr COComma4_80_sNachKomma_A[rcx], 4626

    mov rax, rcx
    ret 
?pi_10e18@COComma4_80@System@RePag@@QEAQPEAV123@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sdi_Zahl = 20
swi_Runden_Alt = 18
swi_Runden = 16
sdi_MXCSR = 12
sdi_MXCSR_Alt = 8
?sin@COComma4_80@System@RePag@@QEAQNXZ PROC ; COComma4_80::sin(void)
    fstcw swi_Runden_Alt[rsp]
    fstcw swi_Runden[rsp]
    btr word ptr swi_Runden[rsp], 10
    btr word ptr swi_Runden[rsp], 11
    fclex
    fldcw swi_Runden[rsp]

    fild dword ptr COComma4_80_llVorKomma[rcx]
    fmul dqd_Zehntausend
    fiadd word ptr COComma4_80_sNachKomma[rcx]
    fdiv dqd_Zehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dqd_Halbkreis
    fdivp ST(1), ST(0)
    fsin

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    fstp qword ptr sdi_Zahl[rsp]
    vmovsd xmm0, qword ptr sdi_Zahl[rsp]
    vmovsd xmm1, xmm0, xmm0
    vmovsd xmm2, xmm0, xmm0
    vcvtsd2si rdx, xmm2
    vcvtsi2sd xmm2, xmm2, rdx
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehntausend
    vcvtsd2si eax, xmm1
    vcvtsi2sd xmm2, xmm2, eax
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehn

		vxorpd xmm5, xmm5, xmm5
    vucomisd xmm1, xmm5
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add rdx, 1

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub rdx, 1

  EndeRunden:
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    fldcw swi_Runden_Alt[rsp]
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
?sin@COComma4_80@System@RePag@@QEAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_Zahl = 20
swi_Runden_Alt = 18
swi_Runden = 16
sdi_MXCSR = 12
sdi_MXCSR_Alt = 8
?cos@COComma4_80@System@RePag@@QEAQNXZ PROC ; COComma4_80::cos(void)
    fstcw swi_Runden_Alt[rsp]
    fstcw swi_Runden[rsp]
    btr word ptr swi_Runden[rsp], 10
    btr word ptr swi_Runden[rsp], 11
    fclex
    fldcw swi_Runden[rsp]

    fild dword ptr COComma4_80_llVorKomma[rcx]
    fmul  dqd_Zehntausend
    fiadd word ptr COComma4_80_sNachKomma[rcx]
    fdiv  dqd_Zehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dqd_Halbkreis
    fdivp ST(1), ST(0)
    fcos

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    fstp qword ptr sqd_Zahl[rsp]
    vmovsd xmm0, qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, xmm1, xmm0
    vmovsd xmm2, xmm2, xmm0
    vcvtsd2si rdx, xmm2
    vcvtsi2sd xmm2, xmm2, rdx
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehntausend
    vcvtsd2si eax, xmm1
    vcvtsi2sd xmm2, xmm2, eax
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehn

		vxorpd xmm5, xmm5, xmm5
    vucomisd xmm1, xmm5
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add rdx, 1

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub rdx, 1

  EndeRunden:
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    fldcw swi_Runden_Alt[rsp]
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
?cos@COComma4_80@System@RePag@@QEAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_Zahl = 20
swi_Runden_Alt = 18
swi_Runden = 16
sdi_MXCSR = 12
sdi_MXCSR_Alt = 8
?tan@COComma4_80@System@RePag@@QEAQNXZ PROC ; COComma4_80::tan(void)
    fstcw swi_Runden_Alt[rsp]
    fstcw swi_Runden[rsp]
    btr word ptr swi_Runden[rsp], 10
    btr word ptr swi_Runden[rsp], 11
    fclex
    fldcw swi_Runden[rsp]

    fild dword ptr COComma4_80_llVorKomma[rcx]
    fmul dqd_Zehntausend
    fiadd word ptr COComma4_80_sNachKomma[rcx]
    fdiv dqd_Zehntausend

    fldpi
    fmulp ST(1), ST(0)
    fld dqd_Halbkreis
    fdivp ST(1), ST(0)
    fptan

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

		fstp qword ptr sqd_Zahl[rsp]
    fstp qword ptr sqd_Zahl[rsp]
    vmovsd xmm0, qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, xmm1, xmm0
    vmovsd xmm2, xmm2, xmm0
    vcvtsd2si rdx, xmm2
    vcvtsi2sd xmm2, xmm2, rdx
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehntausend
    vcvtsd2si eax, xmm1
    vcvtsi2sd xmm2, xmm2, eax
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehn

		vxorpd xmm5, xmm5, xmm5
    vucomisd xmm1, xmm5
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add rdx, 1

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -10000
    ja EndeRunden
    xor eax, eax
    sub rdx, 1

  EndeRunden:
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    fldcw swi_Runden_Alt[rsp]
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    ret
?tan@COComma4_80@System@RePag@@QEAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqd_Zahl = 20
swi_Runden_Alt = 18
swi_Runden = 16
sdi_MXCSR = 12
sdi_MXCSR_Alt = 8
?Squareroot@COComma4_80@System@RePag@@QEAQNXZ PROC ; COComma4_80::Squareroot(void)
    fstcw swi_Runden_Alt[rsp]
    fstcw swi_Runden[rsp]
    btr word ptr swi_Runden[rsp], 10
    btr word ptr swi_Runden[rsp], 11
    fclex
    fldcw swi_Runden[rsp]

    fild dword ptr COComma4_80_llVorKomma[rcx]
    fmul dqd_Zehntausend
    fiadd word ptr COComma4_80_sNachKomma[rcx]
    fdiv dqd_Zehntausend

    fcom dqd_Null
    fstsw ax
    sahf
    ja short Wurzel
		xor rax, rax
		mov qword ptr COComma4_80_llVorKomma[rcx], rax
    mov qword ptr COComma4_80_llVorKomma_A[rcx], rax
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    mov word ptr COComma4_80_sNachKomma_A[rcx], ax
		jmp Ende

	Wurzel:
    fsqrt

    vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

    fstp qword ptr sqd_Zahl[rsp]
    vmovsd xmm0, qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, xmm1, xmm0
    vmovsd xmm2, xmm2, xmm0
    vcvtsd2si rdx, xmm2
    vcvtsi2sd xmm2, xmm2, rdx
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehntausend
    vcvtsd2si eax, xmm1
    vcvtsi2sd xmm2, xmm2, eax
    vsubsd xmm1, xmm1, xmm2
    vmulsd xmm1, xmm1, dqd_Zehn

		vxorpd xmm5, xmm5, xmm5
    vucomisd xmm1, xmm5
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    add eax, 1
    cmp eax, 10000
    jb EndeRunden
    xor eax, eax
    add rdx, 1

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    sub eax, 1
    cmp eax, -1000
    ja EndeRunden
    xor eax, eax
    sub rdx, 1

  EndeRunden:
    mov qword ptr COComma4_80_llVorKomma[rcx], rdx
    mov word ptr COComma4_80_sNachKomma[rcx], ax
    fldcw swi_Runden_Alt[rsp]
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]

	Ende:
    ret
?Squareroot@COComma4_80@System@RePag@@QEAQNXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OKomma4_80 ENDS
END
