;****************************************************************************
;  OStringA_x64.asm
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
dbi_BY_COSTRINGA DB 32
dqd_Zwei DQ 2.0
dqd_Eins DQ 1.0
dqd_Zehn DQ 10.0
dqd_MinusEins DQ -1.0
dds_MinusEins DD -1.0
dds_Eins DD 1.0
dds_Zehn DD 10.0
dqd_Dreihunderacht DQ 308.0
dqd_MinusDreihunderacht DQ -308.0
dds_Achtunddreizig DD 38.0
dds_MinusAchtunddreizig DD -38.0
dqd_Zehntausend DQ 10000.0
dqi_Eins DQ 1

CS_OStringA SEGMENT EXECUTE
;----------------------------------------------------------------------------
??0COStringA@System@RePag@@QEAA@XZ PROC ; COStringA::COStringA(void)
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rcx], ymm0
    ret
??0COStringA@System@RePag@@QEAA@XZ ENDP
;----------------------------------------------------------------------------
??0COStringA@System@RePag@@QEAA@PEBX@Z PROC ; COStringA::COStringA(vmSpeicher)
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rcx], ymm0
    mov qword ptr COStringA_vmSpeicher[rcx], rdx
    ret
??0COStringA@System@RePag@@QEAA@PEBX@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_StringLange = 48 + s_push
sqp_this = 40 + s_push
??0COStringA@System@RePag@@QEAA@PEBD@Z PROC ; COStringA::COStringA(pcString)
    push rdi
    sub rsp, s_ShadowRegister

		mov rdi, rdx
		test rdi, rdi
		jne Lange_Ermitteln
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rcx], ymm0
		jmp short Ende

	Lange_Ermitteln:
    mov r9, rcx
    mov qword ptr sqp_this[rsp], rcx

    xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rax, -2
		sub rax, rcx
    sub rdi, rax
		sub rdi, 1
    mov qword ptr sqi_StringLange[rsp], rax

		xor rdx, rdx
    mov qword ptr COStringA_vmSpeicher[r9], rdx
    mov dword ptr COStringA_ulLange[r9], eax
    mov dword ptr COStringA_ulLange_A[r9], eax

    mov rdx, rax
		add rdx, 1
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov r8, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[r8], rax
    mov qword ptr COStringA_vbInhalt_A[r8], rax

		mov r8, qword ptr sqi_StringLange[rsp]
    mov rdx, rdi
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_StringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

	Ende:
    add rsp, s_ShadowRegister
    pop rdi
    ret
??0COStringA@System@RePag@@QEAA@PEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_StringLange = 48 + s_push
sqp_this = 40 + s_push
??0COStringA@System@RePag@@QEAA@PEBXPEBD@Z PROC ; COStringA::COStringA(vmSpeicher, pcString)
    push rdi
    sub rsp, s_ShadowRegister

		mov rdi, r8
		test rdi, rdi
		jne Lange_Ermitteln

		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rcx], ymm0
    mov qword ptr COStringA_vmSpeicher[rcx], rdx
		jmp short Ende

	Lange_Ermitteln:
    mov qword ptr COStringA_vmSpeicher[rcx], rdx
    mov qword ptr sqp_this[rsp], rcx
    mov r9, rcx

    xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rax, -2
		sub rax, rcx
    sub rdi, rax
		sub rdi, 1
    mov qword ptr sqi_StringLange[rsp], rax

    mov dword ptr COStringA_ulLange[r9], eax
    mov dword ptr COStringA_ulLange_A[r9], eax

    mov rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[r9]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov r8, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[r8], rax
    mov qword ptr COStringA_vbInhalt_A[r8], rax

    mov r8, qword ptr sqi_StringLange[rsp]
    mov rdx, rdi
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_StringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

	Ende:
    add rsp, s_ShadowRegister
    pop rdi
    ret
??0COStringA@System@RePag@@QEAA@PEBXPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
??1COStringA@System@RePag@@QEAA@XZ PROC ; COStringA::~COStringA(void)
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_this[rsp], rcx

		mov rdx, qword ptr COStringA_vbInhalt[rcx]
    test rdx, rdx
    je short Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov r8, qword ptr sqp_this[rsp]
    mov rax, qword ptr COStringA_vbInhalt[r8]
    cmp rax, qword ptr COStringA_vbInhalt_A[r8]
    je short Ende

  Kopie:
    mov r8, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COStringA_vbInhalt_A[r8]
    test rdx, rdx
    je short Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[r8]
    mov rcx, qword ptr COStringA_vmSpeicher[r8]
    call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

  Ende:    
    add rsp, s_ShadowRegister
    ret
??1COStringA@System@RePag@@QEAA@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
?COFreiV@COStringA@System@RePag@@QEAQPEBXXZ PROC ; COStringA::COFreiV(void)
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_this[rsp], rcx

		mov rdx, qword ptr COStringA_vbInhalt[rcx]
    test rdx, rdx
    je short Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov r8, qword ptr sqp_this[rsp]
    mov rax, qword ptr COStringA_vbInhalt[r8]
    cmp rax, qword ptr COStringA_vbInhalt_A[r8]
    je short Ende

  Kopie:
    mov r8, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COStringA_vbInhalt_A[r8]
    test rdx, rdx
    je short Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[r8]
    mov rcx, qword ptr COStringA_vmSpeicher[r8]
    call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov r8, qword ptr sqp_this[rsp]

  Ende:    
  	mov rax, qword ptr COStringA_vmSpeicher[r8]
    add rsp, s_ShadowRegister
    ret
?COFreiV@COStringA@System@RePag@@QEAQPEBXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COStringAV@System@RePag@@YQPEAVCOStringA@12@XZ PROC ; COStringAV(void)
    sub rsp, s_ShadowRegister
    movzx rdx, dbi_BY_COSTRINGA
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
    add rsp, s_ShadowRegister
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 40
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBX@Z PROC ; COStringAV(vmSpeicher)
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_vmSpeicher[rsp], rcx

    movzx rdx, dbi_BY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
    mov rcx, qword ptr sqp_vmSpeicher[rsp]
    mov qword ptr COStringA_vmSpeicher[rax], rcx

    add rsp, s_ShadowRegister
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_StringLange = 56 + s_push
sqp_pcString = 48 + s_push
sqp_this = 40 + s_push
?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBD@Z PROC ; COStringAV(pcString) 
    push rdi
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_pcString[rsp], rcx

    movzx rdx, dbi_BY_COSTRINGA
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdi, qword ptr sqp_pcString[rsp]
		test rdi, rdi
		jne short Lange

		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp short Ende
		
	Lange:
    mov qword ptr sqp_this[rsp], rax
    mov r9, rax

    xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		sub rdi, rdx
		sub rdi, 1

		xor rax, rax
    mov qword ptr COStringA_vmSpeicher[r9], rax
    mov dword ptr COStringA_ulLange[r9], edx
    mov dword ptr COStringA_ulLange_A[r9], edx
    mov qword ptr sqi_StringLange[rsp], rdx

    ;mov rdx, rax
		add rdx, 1
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov r9, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[r9], rax
    mov qword ptr COStringA_vbInhalt_A[r9], rax

    mov r8d, dword ptr COStringA_ulLange[r9]
    mov rdx, rdi
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_StringLange[rsp]
    xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr sqp_this[rsp]

	Ende:
    add rsp, s_ShadowRegister
    pop rdi
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_vmSpeicher = 64 + s_push
sqi_StringLange = 56 + s_push
sqp_pcString = 48 + s_push
sqp_this = 40 + s_push
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBD@Z PROC ; COStringAV(vmSpeicher, pcString)
    push rdi
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_vmSpeicher[rsp], rcx
    mov qword ptr sqp_pcString[rsp], rdx

    movzx rdx, dbi_BY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdi, qword ptr sqp_pcString[rsp]
		test rdi, rdi
		jne short Lange

		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp short Ende
		
	Lange:
    mov qword ptr sqp_this[rsp], rax
    mov r9, rax

    xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		sub rdi, rdx
		sub rdi, 1

		mov rax, qword ptr sqp_vmSpeicher[rsp]
    mov qword ptr COStringA_vmSpeicher[r9], rax
    mov dword ptr COStringA_ulLange[r9], edx
    mov dword ptr COStringA_ulLange_A[r9], edx
    mov qword ptr sqi_StringLange[rsp], rdx

    ;mov rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[r9]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov r9, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[r9], rax
    mov qword ptr COStringA_vbInhalt_A[r9], rax

    mov r8d, dword ptr COStringA_ulLange[r9]
    mov rdx, rdi
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_StringLange[rsp]
    xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr sqp_this[rsp]

	Ende:
    add rsp, s_ShadowRegister
    pop rdi
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_llStringLange_A = 64
sqi_llStringLange = 56
sqp_pasString = 48
sqp_this = 40
?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBV312@@Z PROC ; COStringAV(pasString)
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_pasString[rsp], rcx

    movzx rdx, dbi_BY_COSTRINGA
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pasString[rsp]
    test rcx, rcx
		jne short Lange
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp Ende

	Lange:
    mov qword ptr sqp_this[rsp], rax

		xor rdx, rdx
    mov qword ptr COStringA_vmSpeicher[rax], rdx

    mov edx, dword ptr COStringA_ulLange_A[rcx]
    mov dword ptr COStringA_ulLange_A[rax], edx
    mov qword ptr sqi_llStringLange_A[rsp], rdx
    mov edx, dword ptr COStringA_ulLange[rcx]
		mov dword ptr COStringA_ulLange[rax], edx
    mov qword ptr sqi_llStringLange[rsp], rdx 

    ;mov rdx, qword ptr sqi_llStringLange[rsp]
		add rdx, 1
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[rcx], rax

    mov r9, qword ptr sqp_pasString[rsp]
    mov r8d, dword ptr COStringA_ulLange[r9]
    mov rdx, qword ptr COStringA_vbInhalt[r9]
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_llStringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

    mov rdx, qword ptr sqi_llStringLange_A[rsp]
		add rdx, 1
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt_A[rcx], rax

    mov r9, qword ptr sqp_pasString[rsp]
    mov r8d, dword ptr COStringA_ulLange_A[r9]
    mov rdx, qword ptr COStringA_vbInhalt_A[r9]
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add rax, qword ptr sqi_llStringLange_A[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr sqp_this[rsp]

	Ende:
    add rsp, s_ShadowRegister
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@PEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_lBytes = 16

sqi_llStringLange_A = 64 + s_lBytes
sqi_llStringLange = 56 + s_lBytes
sqp_pasString = 48 + s_lBytes
sqp_this = 40 + s_lBytes

sqp_vmSpeicher = 0 + s_ShadowRegister
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBV312@@Z PROC ; COStringAV(vmSpeicher, pasString)
    sub rsp, s_ShadowRegister + s_lBytes
    mov qword ptr sqp_vmSpeicher[rsp], rcx
    mov qword ptr sqp_pasString[rsp], rdx

    movzx rdx, dbi_BY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pasString[rsp]
    test rcx, rcx
		jne short Lange
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp Ende

	Lange:
    mov qword ptr sqp_this[rsp], rax

		mov r8, qword ptr sqp_vmSpeicher[rsp]
    mov qword ptr COStringA_vmSpeicher[rax], r8

    mov edx, dword ptr COStringA_ulLange_A[rcx]
    mov dword ptr COStringA_ulLange_A[rax], edx
    mov qword ptr sqi_llStringLange_A[rsp], rdx
    mov edx, dword ptr COStringA_ulLange[rcx]
		mov dword ptr COStringA_ulLange[rax], edx
    mov qword ptr sqi_llStringLange[rsp], rdx 

    ;mov rdx, qword ptr sqi_llStringLange[rsp]
		add rdx, 1
    mov rcx, r8
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[rcx], rax

    mov r9, qword ptr sqp_pasString[rsp]
    mov r8d, dword ptr COStringA_ulLange[r9]
    mov rdx, qword ptr COStringA_vbInhalt[r9]
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_llStringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

    mov rdx, qword ptr sqi_llStringLange_A[rsp]
		add rdx, 1
    mov rcx, qword ptr sqp_vmSpeicher[rsp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt_A[rcx], rax

    mov r9, qword ptr sqp_pasString[rsp]
    mov r8d, dword ptr COStringA_ulLange_A[r9]
    mov rdx, qword ptr COStringA_vbInhalt_A[r9]
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add rax, qword ptr sqi_llStringLange_A[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr sqp_this[rsp]

	Ende:
    add rsp, s_ShadowRegister + s_lBytes
    ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXPEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 48
sdi_ulLange = 40
?COStringAV@System@RePag@@YQPEAVCOStringA@12@K@Z PROC ; COStringAV(ulLange)
		sub rsp, s_ShadowRegister
    mov dword ptr sdi_ulLange[rsp], ecx

    movzx rdx, dbi_BY_COSTRINGA
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov edx, dword ptr sdi_ulLange[rsp]
		test rdx, rdx
		jne short Lange
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp short Ende

	Lange:
		mov qword ptr sqp_this[rsp], rax

		xor rcx, rcx
		mov qword ptr COStringA_vmSpeicher[rax], rcx

		mov dword ptr COStringA_ulLange[rax], edx
		mov dword ptr COStringA_ulLange_A[rax], edx

		add edx, 1
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[rcx], rax
    mov qword ptr COStringA_vbInhalt_A[rcx], rax

		mov rax, rcx

	Ende:
    add rsp, s_ShadowRegister
		ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@K@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 56
sqp_this = 48
sdi_ulLange = 40
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXK@Z PROC ; COStringAV(vmSpeicher, ulLange)
		sub rsp, s_ShadowRegister
    mov qword ptr sqp_vmSpeicher[rsp], rcx
    mov dword ptr sdi_ulLange[rsp], edx

    movzx rdx, dbi_BY_COSTRINGA
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

    mov edx, dword ptr sdi_ulLange[rsp]
		test rdx, rdx
		jne short Lange
		vpxor ymm0, ymm0, ymm0
    vmovdqu ymmword ptr [rax], ymm0
		jmp short Ende

	Lange:
		mov qword ptr sqp_this[rsp], rax

		xor rcx, rcx
		mov qword ptr COStringA_vmSpeicher[rax], rcx

		mov dword ptr COStringA_ulLange[rax], edx
		mov dword ptr COStringA_ulLange_A[rax], edx

		add edx, 1
    mov rcx, qword ptr sqp_vmSpeicher[rsp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov rcx, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[rcx], rax
    mov qword ptr COStringA_vbInhalt_A[rcx], rax

		mov rax, rcx
	
	Ende:
    add rsp, s_ShadowRegister
		ret
?COStringAV@System@RePag@@YQPEAVCOStringA@12@QEBXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_StringLange = 48 + s_push
sqp_this = 40 + s_push
??4COStringA@System@RePag@@QEAQXPEBD@Z PROC ; COStringA::operator=(pcString)
		push rdi
    sub rsp, s_ShadowRegister
    mov qword ptr sqp_this[rsp], rcx
		mov rdi, rdx

		mov rax, qword ptr COStringA_vbInhalt[rcx] 
		test rax, rax
    je short Freigeben
    mov rdx, qword ptr COStringA_vbInhalt[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov r8, qword ptr sqp_this[rsp]
    mov rax, qword ptr COStringA_vbInhalt[r8]
    cmp rax, qword ptr COStringA_vbInhalt_A[r8]
    je short Lange

  Freigeben:
		mov r8, qword ptr sqp_this[rsp]
		mov rax, qword ptr COStringA_vbInhalt_A[r8]
    test rax, rax
    je short Lange
    mov rdx, qword ptr COStringA_vbInhalt_A[r8]
    mov rcx, qword ptr COStringA_vmSpeicher[r8]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Lange:
		test rdi, rdi
		je short Ende_Null

		xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		sub rdi, rdx
		sub rdi, 1

    mov r8, qword ptr sqp_this[rsp]
		mov dword ptr COStringA_ulLange[r8], edx
		mov dword ptr COStringA_ulLange_A[r8], edx
    mov qword ptr sqi_StringLange[rsp], rdx

		;mov rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[r8]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov r8, qword ptr sqp_this[rsp]
    mov qword ptr COStringA_vbInhalt[r8], rax
    mov qword ptr COStringA_vbInhalt_A[r8], rax

    mov r8, qword ptr sqi_StringLange[rsp]
    mov rdx, rdi
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		add rax, qword ptr sqi_StringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl
		jmp short Ende

	Ende_Null:
	  mov r8, qword ptr sqp_this[rsp]
		xor rax, rax
		mov dword ptr COStringA_ulLange[r8], eax
    mov qword ptr COStringA_vbInhalt[r8], rax
    mov dword ptr COStringA_ulLange_A[r8], eax
    mov qword ptr COStringA_vbInhalt_A[r8], rax

	Ende:
		add rsp, s_ShadowRegister
		pop rdi
    ret
??4COStringA@System@RePag@@QEAQXPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 16
sqi_llStringLange = 40 + s_push
??4COStringA@System@RePag@@QEAQXAEBV012@@Z PROC ; COStringA::operator=(&asString)
    push rdi
    push rsi
		sub rsp, s_ShadowRegister
    mov rdi, rcx
		mov rsi, rdx

		mov rdx, qword ptr COStringA_vbInhalt[rcx]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rdi]
    cmp rax, qword ptr COStringA_vbInhalt_A[rdi]
    je short Lange

  Freigeben_Kopie:
	  mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
    test rdx, rdx
    je short Lange
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
    mov rcx, qword ptr COStringA_vmSpeicher[rdi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Lange:
		test rsi, rsi
		je short Lange_Null
		mov edx, dword ptr COStringA_ulLange_A[rsi]
		test rdx, rdx
		je short Lange_Null

		;mov edx, dword ptr COStringA_ulLange_A[rsi]
		mov dword ptr COStringA_ulLange[rdi], edx
		mov dword ptr COStringA_ulLange_A[rdi], edx
    mov qword ptr sqi_llStringLange[rsp], rdx

		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rdi]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
    mov qword ptr COStringA_vbInhalt[rdi], rax
		mov qword ptr COStringA_vbInhalt_A[rdi], rax

    mov r8d, dword ptr COStringA_ulLange[rdi]
    mov rdx, qword ptr COStringA_vbInhalt_A[rsi]
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    add rax, qword ptr sqi_llStringLange[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr COStringA_vbInhalt[rsi]
		cmp rax, qword ptr COStringA_vbInhalt_A[rsi]
		je short Ende
		mov rdx, qword ptr COStringA_vbInhalt_A[rsi]
		mov rcx, qword ptr COStringA_vmSpeicher[rsi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[rsi]
		mov dword ptr COStringA_ulLange_A[rsi], ecx
		mov rax, qword ptr COStringA_vbInhalt[rsi]
		mov qword ptr COStringA_vbInhalt_A[rsi], rax

	Lange_Null:
		xor rax, rax
		mov dword ptr COStringA_ulLange[rdi], eax
    mov qword ptr COStringA_vbInhalt[rdi], rax
		mov dword ptr COStringA_ulLange_A[rdi], eax
    mov qword ptr COStringA_vbInhalt_A[rdi], rax
		
	Ende:
    add rsp, s_ShadowRegister
    pop rsi
    pop rdi
		ret
??4COStringA@System@RePag@@QEAQXAEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??YCOStringA@System@RePag@@QEAQXPEBD@Z PROC ; COStringA::operator+=(pcString)
		push rsi
		push rdi
    push rbx
    sub rsp, s_ShadowRegister
		mov rsi, rcx
		mov rdi, rdx

		test rdx, rdx
		je Ende

		xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov rbx, rdx
		sub rdi, rdx
		sub rdi, 1

		mov eax, dword ptr COStringA_ulLange[rsi]
		test rax, rax
		je short Lange_Null

		;mov edx, dword ptr COStringA_ulLange[rsi]
		;add rdx, rbx
		add rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rsi]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rsi]
		mov rdx, qword ptr COStringA_vbInhalt[rsi]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rdx, rdi
		mov rcx, rax
    mov r8d, dword ptr COStringA_ulLange[rsi]
		add rcx, r8 
	  mov r8, rbx
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r8d, dword ptr COStringA_ulLange[rsi]
    sub rax, r8
		mov rdi, rax
		add ebx, dword ptr COStringA_ulLange[rsi]
		jmp short Freigeben

	Lange_Null:
		mov rdx, rbx
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rsi]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8, rbx
		mov rdx, rdi
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax

	Freigeben:
	  mov rax, qword ptr COStringA_vbInhalt[rsi]
		test rax, rax
    je short Freigeben_Ende
    mov rdx, qword ptr COStringA_vbInhalt[rsi]
    mov rcx, qword ptr COStringA_vmSpeicher[rsi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov dword ptr COStringA_ulLange[rsi], ebx
		mov qword ptr COStringA_vbInhalt[rsi], rdi

		mov dword ptr COStringA_ulLange_A[rsi], ebx
		mov qword ptr COStringA_vbInhalt_A[rsi], rdi

	Ende:
    add rsp, s_ShadowRegister
    pop rbx
		pop rdi
		pop rsi
		ret
??YCOStringA@System@RePag@@QEAQXPEBD@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 16
sqp_vbInhalt_Neu = 40 + s_push
??YCOStringA@System@RePag@@QEAQXAEBV012@@Z PROC ; COStringA::operator+=(&asString)
		push rbp
		push rdi
    sub rsp, s_ShadowRegister
		mov rbp, rcx
		mov rdi, rdx

		mov edx, dword ptr COStringA_ulLange_A[rdi]
		test rdx, rdx
		je Ende

		mov eax, dword ptr COStringA_ulLange[rbp]
		test rax, rax
		je short Lange_Null

		;mov edx, dword ptr COStringA_ulLange[rbp]
		;add edx, dword ptr COStringA_ulLange_A[rdi]
		add rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rdi]
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, rax
    mov r9d, dword ptr COStringA_ulLange[rbp]
		add rcx, r9
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r9d, dword ptr COStringA_ulLange[rbp]
    sub rax, r9
    mov qword ptr sqp_vbInhalt_Neu[rsp], rax
		jmp short Freigeben

	Lange_Null:
		mov edx, dword ptr COStringA_ulLange_A[rdi]
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rdi]
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    mov qword ptr sqp_vbInhalt_Neu[rsp], rax

	;---------------------------------------------------------
	Freigeben:
	  mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
	
	Freigeben_Ende:
	;---------------------------------------------------------
	  mov ecx, dword ptr COStringA_ulLange_A[rdi]
		add dword ptr COStringA_ulLange[rbp], ecx
		add dword ptr COStringA_ulLange_A[rbp], ecx
    mov rax, qword ptr sqp_vbInhalt_Neu[rsp]
		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

    mov r8d, dword ptr COStringA_ulLange[rbp]
		add rax, r8
		xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr COStringA_vbInhalt[rdi]
		cmp rax, qword ptr COStringA_vbInhalt_A[rdi]
		je short Ende
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, qword ptr COStringA_vmSpeicher[rdi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[rdi]
		mov dword ptr COStringA_ulLange_A[rdi], ecx
		mov rax, qword ptr COStringA_vbInhalt[rdi]
		mov qword ptr COStringA_vbInhalt_A[rdi], rax

	Ende:
    add rsp, s_ShadowRegister
		pop rdi
		pop rbp
		ret
??YCOStringA@System@RePag@@QEAQXAEBV012@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??HCOStringA@System@RePag@@QEAQAEAV012@PEBD@Z PROC ; COStringA::operator+(pcString)
		push rbp
		push rbx
		push rdi
		sub rsp, s_ShadowRegister
		mov rbp, rcx
		mov rdi, rdx

		test rdx, rdx
		je Ende

		xor al, al
		mov rcx, -1
		cld
		repnz scasb
		mov rax, -2
		sub rax, rcx
		mov rbx, rax
		sub rdi, rax
		sub rdi, 1

		mov edx, dword ptr COStringA_ulLange_A[rbp]
		test rdx, rdx
		je short Lange_Null

		;mov edx, dword ptr COStringA_ulLange_A[rbp]
		add rdx, rbx
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rbp]
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8, rbx
		mov rdx, rdi
		mov rcx, rax
		mov r9d, dword ptr COStringA_ulLange_A[rbp]
		add rcx, r9 
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r9d, dword ptr COStringA_ulLange_A[rbp]
		sub rax, r9
		mov rdi, rax
		add rbx, r9
		jmp short Schluss

	Lange_Null:
		mov rdx, rbx
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8, rbx
		mov rdx, rdi
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax

	Schluss:
		mov dword ptr COStringA_ulLange_A[rbp], ebx
		mov qword ptr COStringA_vbInhalt_A[rbp], rdi

		add rdi, rbx
		xor dl, dl
		mov byte ptr [rdi], dl

	Ende:
		mov rax, rbp

	  add rsp, s_ShadowRegister
	  pop rdi
		pop rbx
		pop rbp
		ret
??HCOStringA@System@RePag@@QEAQAEAV012@PEBD@Z ENDP
;----------------------------------------------------------------------------
??HCOStringA@System@RePag@@QEAQAEAV012@AEBV012@@Z PROC ; COStringA::operator+(&asString)
		push rbp
		push rdi
		sub rsp, s_ShadowRegister
		mov rbp, rcx
		mov rdi, rdx

		mov eax, dword ptr COStringA_ulLange_A[rdi]
		test rax, rax
		je Ende

		mov edx, dword ptr COStringA_ulLange_A[rbp]
		test rdx, rdx
		je short Lange_Null

		;mov edx, dword ptr COStringA_ulLange_A[rbp]
		add rdx, rax ;dword ptr COStringA_ulLange_A[rdi]
		add edx, 1
		mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rbp]
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rdi]
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, rax
		mov r9d, dword ptr COStringA_ulLange_A[rbp]
		add rcx, r9 
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r9d, dword ptr COStringA_ulLange_A[rbp]
		sub rax, r9
		jmp short Schluss

	Lange_Null:
		;mov edx, dword ptr COStringA_ulLange_A[rdi]
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange_A[rdi]
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Schluss:
	  mov ecx, dword ptr COStringA_ulLange_A[rdi]
		add dword ptr COStringA_ulLange_A[rbp], ecx
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

		mov r9d, dword ptr COStringA_ulLange_A[rbp]
		add rax, r9
		xor dl, dl
		mov byte ptr [rax], dl

		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		cmp rdx, qword ptr COStringA_vbInhalt[rdi]
		je short Ende
		;mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
		mov rcx, qword ptr COStringA_vmSpeicher[rdi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov ecx, dword ptr COStringA_ulLange[rdi]
		mov dword ptr COStringA_ulLange_A[rdi], ecx
		mov rax, qword ptr COStringA_vbInhalt[rdi]
		mov qword ptr COStringA_vbInhalt_A[rdi], rax

	Ende:
		mov rax, rbp
		add rsp, s_ShadowRegister
		pop rdi
		pop rbp
		ret
??HCOStringA@System@RePag@@QEAQAEAV012@AEBV012@@Z ENDP
;----------------------------------------------------------------------------
??8COStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::operator==(pcString)
		push rdi
		push rsi

		xor rax, rax
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx] 
		test r9, r9
		je short Ende
		mov r8, rcx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov rsi, rdi
		sub rsi, rdx
		sub rsi, 1

		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, rdx
		;jbe short RefKleinerGleich
		;mov rcx, rdx
		cmova rcx, rdx

	;RefKleinerGleich:
		xor r9, r9
		mov rax, 1
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jne short Ungleich
		cmovne rax, r9

		cmp edx, dword ptr COStringA_ulLange[r8]
		;jne short Ungleich
		;jmp short Ende
		cmovne rax, r9

	;Ungleich:
		;xor rax, rax

	Ende:
		pop rsi
		pop	rdi
		ret
??8COStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
??8COStringA@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COStringA::operator==(&asString)
		push rsi
		push rdi

		xor rax, rax
		mov r9, qword ptr COStringA_vbInhalt[rdx]
		test r9, r9
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		mov r10d, dword ptr COStringA_ulLange[rdx]
		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, r10
		;jbe short RefKleinerGleich
		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmova rcx, r10

	;RefKleinerGleich:
		xor r9, r9
		mov rax, 1
		cld
	  mov rsi, qword ptr COStringA_vbInhalt[rdx]
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jne short Ungleich
		cmovne rax, r9

		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmp r10d, dword ptr COStringA_ulLange[r8]
		;jne short Ungleich
		;jmp short Ende
		cmovne rax, r9

	;Ungleich:
		;xor rax, rax

	Ende:
		pop	rdi
		pop	rsi
		ret
??8COStringA@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??9COStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::operator!=(pcString)
		push rsi
		push rdi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov rsi, rdi
		sub rsi, rdx
		sub rsi, 1

		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, rdx
		;jbe short RefKleinerGleich
		;mov rcx, rdx
		cmova rcx, rdx

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jne short Ungleich
		cmovne rax, r9

		cmp edx, dword ptr COStringA_ulLange[r8]
		;jne short Ungleich
		;jmp short Ende
		cmovne rax, r9

	;Ungleich:
		;mov eax, 1

	Ende:
		pop	rdi
		pop rsi
		ret
??9COStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
??9COStringA@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COStringA::operator!=(&asString)
		push rsi
		push rdi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		mov r10d, dword ptr COStringA_ulLange[rdx]
		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, r10
		;jbe short RefKleinerGleich
		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmova rcx, r10

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax
		cld
		mov rsi, qword ptr COStringA_vbInhalt[rdx]
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jne short Ungleich
		cmovne rax, r9

		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmp r10d, dword ptr COStringA_ulLange[r8]
		;jne short Ungleich
		;jmp short Ende
		cmovne rax, r9

	;Ungleich:
		;mov rax, 1

	Ende:
		pop	rdi
		pop	rsi
		ret
??9COStringA@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??MCOStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::operator<(pcString)
		push rdi
		push rsi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov rsi, rdi
		sub rsi, rdx
		sub rsi, 1

		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, rdx
		cmova rcx, rdx

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax		
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;ja short Ungleich
		cmova rax, r9

		cmp edx, dword ptr COStringA_ulLange[r8]
		;ja short Ungleich
		;jmp short Ende
		cmova rax, r9

	;Ungleich:
		;mov rax, 1

	Ende:
		pop rsi
		pop	rdi
		ret
??MCOStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
??MCOStringA@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COStringA::operator<(&asString)
		push rsi
		push rdi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		mov r10d, dword ptr COStringA_ulLange[rdx]
		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, r10
		;jbe short RefKleinerGleich
		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmovbe rcx, r10

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax
		cld
		mov rsi, qword ptr COStringA_vbInhalt[rdx]
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;ja short Ungleich
		cmova rax, r9

		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmp r10d, dword ptr COStringA_ulLange[r8]
		;ja short Ungleich
		;jmp short Ende
		cmova rax, r9

	;Ungleich:
		;mov rax, 1

	Ende:
		pop	rdi
		pop	rsi
		ret
??MCOStringA@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::operator>(pcString)
		push rsi
		push rdi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov rsi, rdi
		sub rsi, rdx
		sub rsi, 1

		mov ecx, dword ptr COStringA_ulLange[r8]
		cmp rcx, rdx
		cmova rcx, rdx

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax		
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jb short Ungleich
		cmovb rax, r9

		cmp edx, dword ptr COStringA_ulLange[r8]
		;jb short Ungleich
		;jmp short Ende
		cmovb rax, r9

	;Ungleich:
		;mov rax, 1

	Ende:
		pop	rdi
		pop	rsi
		ret
??OCOStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
??OCOStringA@System@RePag@@QEAQ_NAEBV012@@Z  PROC ; COStringA::operator>(&asString)
		push rsi
		push rdi

		mov rax, 1
		test rdx, rdx
		je short Ende
		mov r9, qword ptr COStringA_vbInhalt[rcx]
		test r9, r9
		je short Ende
		mov r8, rcx

		mov r10d, dword ptr COStringA_ulLange[rdx]
		mov ecx, dword ptr COStringA_ulLange[r8]
		;jbe short RefKleinerGleich
		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmp rcx, r10
		cmovbe rcx, r10

	;RefKleinerGleich:
		mov r9, 1
		xor rax, rax
		cld
		mov rsi, qword ptr COStringA_vbInhalt[rdx]
		mov rdi, qword ptr COStringA_vbInhalt[r8]
		repe cmpsb
		;jb short Ungleich
		cmovb rax, r9

		;mov ecx, dword ptr COStringA_ulLange[rdx]
		cmp r10d, dword ptr COStringA_ulLange[r8]
		;jb short Ungleich
		;jmp short Ende
		cmovb rax, r9

	;Ungleich:
		;mov rax, 1

	Ende:
		pop	rdi
		pop	rsi
		ret
??OCOStringA@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??ACOStringA@System@RePag@@QEAQAEADK@Z PROC ; COStringA::operator[](ulIndex)
	  mov rax, qword ptr COStringA_vbInhalt[rcx]
		cmp edx, dword ptr COStringA_ulLange[rcx]
		jb short Index
		xor rdx, rdx

	Index:
		add rax, rdx

	Ende:		
		ret
??ACOStringA@System@RePag@@QEAQAEADK@Z ENDP
;----------------------------------------------------------------------------
?Contain@COStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::Contain(pcString)
		push rsi
		push rdi

		mov r9, rcx

		mov rax, qword ptr COStringA_vbInhalt[r9]
		test rax, rax
		je short Return_0
		test rdx, rdx
		je short Return_0

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov r8, -2
		sub r8, rcx

		test r8, r8
		je short Return_0

		xor rax, rax

    mov rdi, qword ptr COStringA_vbInhalt[r9]
		mov rsi, rdx

		mov edx, dword ptr COStringA_ulLange[r9]
		add rdx, 1
		add r8, 1

		cmp r8, rdx
		ja short Return_0

		mov r9, rdx

		cmp r8, 2
		je short EinBuchstabe
		lodsb
		repne scasb

	NachsterBuchstabe:
		test rax, rax
		je short Return_1
		lodsb
		scasb
		je NachsterBuchstabe
		test rax, rax
		je short Return_1
		jmp short Return_0

	EinBuchstabe:
		lodsb
		repne scasb
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?Contain@COStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
?Contain@COStringA@System@RePag@@QEAQ_NAEBV123@@Z PROC ; COStringA::Contain(&asString)
		push rsi
		push rdi

		mov rax, qword ptr COStringA_vbInhalt[rcx]
		test rax, rax
		je short Return_0
		mov rax, qword ptr COStringA_vbInhalt[rdx]
		test rax, rax
		je short Return_0

		cld
		xor rax, rax

		mov rsi, qword ptr COStringA_vbInhalt[rdx]
		mov r8d, dword ptr COStringA_ulLange[rdx]
		add r8, 1

    mov rdi, qword ptr COStringA_vbInhalt[rcx]
		mov edx, dword ptr COStringA_ulLange[rcx]
		add rdx, 1

		cmp r8, rdx
		ja short Return_0

		mov rcx, rdx

		cmp r8, 2
		je short EinBuchstabe
		lodsb
		repne scasb

	NachsterBuchstabe:
		test rax, rax
		je short Return_1
		lodsb
		scasb
		je NachsterBuchstabe
		test rax, rax
		je short Return_1
		jmp short Return_0

	EinBuchstabe:
		lodsb
		repne scasb
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?Contain@COStringA@System@RePag@@QEAQ_NAEBV123@@Z ENDP
;----------------------------------------------------------------------------
?ContainLeft@COStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::ContainLeft(pcString)
		push rsi
		push rdi

		mov r9, rcx

		mov rax, qword ptr COStringA_vbInhalt[rcx]
		test rax, rax
		je short Return_0
		test rdx, rdx
		je short Return_0

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov r8, -2
		sub r8, rcx

		test r8, r8
		je short Return_0

		xor rax, rax

    mov rdi, qword ptr COStringA_vbInhalt[r9]
    mov rsi, rdx

		mov edx, dword ptr COStringA_ulLange[r9]
		add rdx, 1
		add r8, 1

		cmp r8, rdx
		ja short Return_0

    cmp r8, 1
    ja short Vergleich
    cmp rdx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov rcx, r8
		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?ContainLeft@COStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
?ContainLeft@COStringA@System@RePag@@QEAQ_NAEBV123@@Z PROC ; COStringA::ContainLeft(&asString)
		push rsi
		push rdi

		mov rax, qword ptr COStringA_vbInhalt[rcx] 
		test rax, rax
		je short Return_0
		mov rax, qword ptr COStringA_vbInhalt[rdx]
		test rax, rax
		je short Return_0

		cld
		xor rax, rax

    mov rsi, qword ptr COStringA_vbInhalt[rdx]
    mov r8d, dword ptr COStringA_ulLange[rdx]
		add r8, 1

    mov rdi, qword ptr COStringA_vbInhalt[rcx]
		mov edx, dword ptr COStringA_ulLange[rcx]
		add rdx, 1

		cmp r8, rdx
		ja short Return_0

    cmp r8, 1
    ja short Vergleich
    cmp rdx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov rcx, r8
		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?ContainLeft@COStringA@System@RePag@@QEAQ_NAEBV123@@Z ENDP
;----------------------------------------------------------------------------
?ContainRight@COStringA@System@RePag@@QEAQ_NPEBD@Z PROC ; COStringA::ContainRight(pcString)
		push rsi
		push rdi

		mov r9, rcx

		mov rax, qword ptr COStringA_vbInhalt[rcx]
		test rax, rax
		je short Return_0
		test rdx, rdx
		je short Return_0

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov r8, -2
		sub r8, rcx

		test r8, r8
		je short Return_0

		xor rax, rax

    mov rdi, qword ptr COStringA_vbInhalt[r9]
    mov rsi, rdx

		mov edx, dword ptr COStringA_ulLange[r9]
		add rdx, 1
		add r8, 1

		cmp r8, rdx
		ja Return_0

		mov rcx, r8

		sub rdx, r8
		add rdi, rdx

		repe cmpsb
		test rcx, rcx
		je Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?ContainRight@COStringA@System@RePag@@QEAQ_NPEBD@Z ENDP
;----------------------------------------------------------------------------
?ContainRight@COStringA@System@RePag@@QEAQ_NAEBV123@@Z PROC ; COStringA::ContainRight(&asString)
		push rsi
		push rdi

		mov rax, qword ptr COStringA_vbInhalt[rcx]
		test rax, rax
		je short Return_0
		mov rax, qword ptr COStringA_vbInhalt[rdx]
		test rax, rax
		je short Return_0

		cld
		xor rax, rax

    mov rsi, qword ptr COStringA_vbInhalt[rdx]
    mov r8d, dword ptr COStringA_ulLange[rdx]
		add r8, 1

    mov rdi, qword ptr COStringA_vbInhalt[rcx]
		mov edx, dword ptr COStringA_ulLange[rcx]
		add rdx, 1

		cmp r8, rdx
		ja Return_0

		mov rcx, r8

		sub rdx, r8
		add rdi, rdx

		repe cmpsb
		test rcx, rcx
		je Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret
?ContainRight@COStringA@System@RePag@@QEAQ_NAEBV123@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqi_ulBis = 64
sqi_ulVon = 56
sqp_vbString = 48
sqp_this = 40
?SubString@COStringA@System@RePag@@QEAQKAEAPEADKK@Z PROC ; COStringA::SubString(&vbString, ulVon, ulBis)
		sub rsp, s_ShadowRegister
		
		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_vbString[rsp], rdx

		xor rax, rax
		mov qword ptr sqi_ulVon[rsp], r8 
		test r8, r8
		je short Ende
		test r9, r9
		je short Ende
		cmp r9d, dword ptr COStringA_ulLange[rcx]
		ja short Ende
		
		add r9, 1
		sub r9, r8
		mov qword ptr sqi_ulBis[rsp], r9

		mov rdx, r9
		add rdx, 1
    xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_this[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rdx]
    mov r8, qword ptr sqi_ulBis[rsp]
		add rdx, qword ptr sqi_ulVon[rsp]
		sub rdx, 1
    mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdx, qword ptr sqp_vbString[rsp]
		mov qword ptr [rdx], rax
		add rax, qword ptr sqi_ulBis[rsp]
		xor dl, dl
		mov byte ptr [rax], dl

		mov rax, qword ptr sqi_ulBis[rsp]

	Ende:
		add rsp, s_ShadowRegister
		ret
?SubString@COStringA@System@RePag@@QEAQKAEAPEADKK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_ulBis = 56 + s_push
sqi_ulVon = 48 + s_push
sqp_vbInhalt = 40 + s_push
?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z PROC ; COStringA::SubString(pasString, ulVon, ulBis)
		push rdi
		sub rsp, s_ShadowRegister

		mov rdi, rdx
		
		xor rax, rax
		mov qword ptr sqi_ulVon[rsp], r8
		test r8, r8
		je Ende
		mov qword ptr sqi_ulBis[rsp], r9
		test r9, r9
		je Ende
		cmp r8d, dword ptr COStringA_ulLange[rcx]
		ja Ende

		mov rax, qword ptr COStringA_vbInhalt[rcx]
		mov qword ptr sqp_vbInhalt[rsp], rax
		
		add r9, 1
		sub r9, r8
		mov qword ptr sqi_ulBis[rsp], r9

		mov rdx, qword ptr COStringA_vbInhalt[rdi] 
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rdi]
		mov rcx, qword ptr COStringA_vmSpeicher[rdi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rdi]
    cmp rax, qword ptr COStringA_vbInhalt_A[rdi]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rdi]
    mov rcx, qword ptr COStringA_vmSpeicher[rdi]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
	  mov rdx, qword ptr sqi_ulBis[rsp]
		mov dword ptr COStringA_ulLange[rdi], edx
		mov dword ptr COStringA_ulLange_A[rdi], edx

		test rdx, rdx
		je short Inhalt_Null
		;mov rdx, r9
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rdi]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr COStringA_vbInhalt[rdi], rax
		mov qword ptr COStringA_vbInhalt_A[rdi], rax
		mov rcx, rax
		mov r8, qword ptr sqi_ulBis[rsp]
		add rax, r8
		xor dl, dl
		mov byte ptr [rax], dl
		jmp short Inhalt

	Inhalt_Null:
		xor rax, rax
		mov qword ptr COStringA_vbInhalt[rdi], rax
		mov qword ptr COStringA_vbInhalt_A[rdi], rax
		jmp short Ende

	Inhalt:
		;mov r8, qword ptr sqi_ulBis[rsp]
		mov rdx, qword ptr sqp_vbInhalt[rsp]
		add rdx, qword ptr sqi_ulVon[rsp]
		sub rdx, 1
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov rax, rdi

	Ende:
		add rsp, s_ShadowRegister
		pop rdi
		ret
?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ENDP
_Text ENDs
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 16
sqi_ulBytes = 56 + s_push
sqi_ulPosition = 48 + s_push
sqp_pcString = 40 + s_push
?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBDK@Z PROC ; COStringA::Insert(pcString, ulPosition)
		push rbp
		push rdi
		sub rsp, s_ShadowRegister

		mov rbp, rcx

		test rdx, rdx
		je Ende
		mov qword ptr sqi_ulPosition[rsp], r8

		mov qword ptr sqp_pcString[rsp], rdx

		xor al, al
		mov rdi, rdx
		mov rcx, -1
		cld
		repnz scasb
		mov rdx, -2
		sub rdx, rcx
		mov qword ptr sqi_ulBytes[rsp], rdx

		add edx, dword ptr COStringA_ulLange[rbp]
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8, qword ptr sqi_ulPosition[rsp]
		cmp r8d, dword ptr COStringA_ulLange[rbp]
		jb short Einfugen

		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8, qword ptr sqi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pcString[rsp]
		mov rcx, rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		add rcx, r9
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		sub rdi, r9 
		jmp short Lange

	Einfugen:
		;mov r8, qword ptr sqi_ulPosition[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8, qword ptr sqi_ulBytes[rsp]
		mov rdx, qword ptr sqp_pcString[rsp]
		mov rcx, rax
		add rcx, qword ptr sqi_ulPosition[rsp]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r9, qword ptr sqi_ulPosition[rsp]
		mov r8d, dword ptr COStringA_ulLange[rbp]
		sub r8, r9
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		add rdx, r9
		mov rcx, rax
		add rcx, qword ptr sqi_ulBytes[rsp]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax
		sub rdi, qword ptr sqi_ulBytes[rsp]
		sub rdi, qword ptr sqi_ulPosition[rsp]

	Lange:
		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov r9, qword ptr sqi_ulBytes[rsp]
		add r9, r8
		mov dword ptr COStringA_ulLange[rbp], r9d
		mov dword ptr COStringA_ulLange_A[rbp], r9d
		mov rax, rdi
		add rax, r9
		xor dl, dl
		mov byte ptr [rax], dl

		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov qword ptr COStringA_vbInhalt[rbp], rdi
		mov qword ptr COStringA_vbInhalt_A[rbp], rdi

	Ende:
		mov rax, rbp
		
		add rsp, s_ShadowRegister
		pop rdi
		pop rbp
		ret
?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBDK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
sqi_ulPosition = 40 + s_push
?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBV123@K@Z PROC ; COStringA::Insert(pasString, ulPosition)
		push rbp
		push rbx
		push rdi
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov rbx, rdx
		test rdx, rdx
		je Ende
		mov qword ptr sqi_ulPosition[rsp], r8

		mov edx, dword ptr COStringA_ulLange[rbx]
		add edx, dword ptr COStringA_ulLange[rbp]
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8, qword ptr sqi_ulPosition[rsp]
		cmp r8d, dword ptr COStringA_ulLange[rbp]
		jb short Einfugen

		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rbx]
		mov rdx, qword ptr COStringA_vbInhalt[rbx]
		mov rcx, rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		add rcx, r9 
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		sub rdi, r9
		jmp short Lange

	Einfugen:
		;mov r8, qword ptr sqi_ulPosition[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rbx]
		mov rdx, qword ptr COStringA_vbInhalt[rbx]
		mov rcx, rax
		add rcx, qword ptr sqi_ulPosition[rsp]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rbp]
		sub r8, qword ptr sqi_ulPosition[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		add rdx, qword ptr sqi_ulPosition[rsp]
		mov rcx, rax
		mov r9d, dword ptr COStringA_ulLange[rbx]
		add rcx, r9
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov rdi, rax
		mov r9d, dword ptr COStringA_ulLange[rbx]
		sub rdi, r9 
		sub rdi, qword ptr sqi_ulPosition[rsp]

	Lange:
		mov ebx, dword ptr COStringA_ulLange[rbx]
		add ebx, dword ptr COStringA_ulLange[rbp]
		mov dword ptr COStringA_ulLange[rbp], ebx
		mov dword ptr COStringA_ulLange_A[rbp], ebx
		mov rax, rdi
		add rax, rbx
		xor dl, dl
		mov byte ptr [rax], dl

		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov qword ptr COStringA_vbInhalt[rbp], rdi
		mov qword ptr COStringA_vbInhalt_A[rbp], rdi

	Ende:
		mov rax, rbp

		add rsp, s_ShadowRegister
		pop rdi
		pop rbx
		pop rbp
		ret
?Insert@COStringA@System@RePag@@QEAQPEAV123@PEBV123@K@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 16
sqp_vbNeuerInhalt = 48 + s_push
sqi_ulAnzahl = 40 + s_push
?Delete@COStringA@System@RePag@@QEAQPEAV123@KK@Z PROC ; COStringA::Delete(ulPosition, ulAnzahl)
		push rbp
		push rbx
		sub rsp, s_ShadowRegister

		mov rbp, rcx

		cmp edx, dword ptr COStringA_ulLange[rbp]
		ja Ende
		mov rbx, rdx
		test r8, r8
		je Ende
		mov qword ptr sqi_ulAnzahl[rsp], r8

		mov rax, rdx
		add rax, r8
		cmp dword ptr COStringA_ulLange[rbp], eax
		jb Position_Null
		mov edx, dword ptr COStringA_ulLange[rbp]
		sub rdx, qword ptr sqi_ulAnzahl[rsp]
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8, rbx
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov qword ptr sqp_vbNeuerInhalt[rsp], rax

		mov r8d, dword ptr COStringA_ulLange[rbp]
		sub r8, rbx
		sub r8, qword ptr sqi_ulAnzahl[rsp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		add rdx, rbx
		add rdx, qword ptr sqi_ulAnzahl[rsp]
		mov rcx, rax
		add rcx, rbx
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov ecx, dword ptr COStringA_ulLange[rbp]
		sub rcx, qword ptr sqi_ulAnzahl[rsp]
		mov dword ptr COStringA_ulLange[rbp], ecx
		mov dword ptr COStringA_ulLange_A[rbp], ecx

		mov rbx, qword ptr sqp_vbNeuerInhalt[rsp]
		add rbx, rcx
		xor dl, dl
		mov byte ptr [rbx], dl
		sub rbx, rcx

		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie_1
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende_1

  Freigeben_Kopie_1:
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende_1
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende_1:
		mov qword ptr COStringA_vbInhalt[rbp], rbx
		mov qword ptr COStringA_vbInhalt_A[rbp], rbx
		jmp short Ende

	Position_Null:
		test rdx, rdx
		jne short Position_Eins
		mov rax, qword ptr sqi_ulAnzahl[rsp]
		cmp dword ptr COStringA_ulLange[rbp], eax
		je Freigeben_2

	Position_Eins:
		cmp rdx, 1
		jne short Ende
		cmp dword ptr COStringA_ulLange[rbp], 1
		jne short Ende
		cmp qword ptr sqi_ulAnzahl[rbp], 1
		jne short Ende

	Freigeben_2:
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie_2
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende_2

  Freigeben_Kopie_2:
		mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende_2
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende_2:
		xor rax, rax
		mov dword ptr COStringA_ulLange[rbp], eax
		mov dword ptr COStringA_ulLange_A[rbp], eax
		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

	Ende:
		mov rax, rcx
		
		add rsp, s_ShadowRegister
		pop rbx
		pop rbp
		ret
?Delete@COStringA@System@RePag@@QEAQPEAV123@KK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?SearchCharacters@COStringA@System@RePag@@QEAQKPEBD@Z PROC ; COStringA::SearchCharacters(pcZeichen)
		push rdi

		cld
		mov rdi, qword ptr COStringA_vbInhalt[rcx]
		mov ecx, dword ptr COStringA_ulLange[rcx]
		mov r8, rcx
		movzx rax, byte ptr [rdx]

    add rcx, 1
		repne scasb
		mov rax, r8
		sub rax, rcx
		add rax, 1

		add r8, 1
		cmp rax, r8
		jne short Ende
		xor rax, rax

	Ende:
		pop	rdi
		ret
?SearchCharacters@COStringA@System@RePag@@QEAQKPEBD@Z ENDP
;----------------------------------------------------------------------------
?SearchCharacters@COStringA@System@RePag@@QEAQKPEBDKK@Z PROC ; COStringA::SearchCharacters(pcZeichen, ulVon, ulBis)
		push rdi

		xor rax, rax
		test r8, r8
		je short Ende
		test r9, r9 
		je short Ende
		cmp r9d, dword ptr COStringA_ulLange[rcx]
		ja short Ende

		cld
		mov rdi, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rdx]
		add rdi, r8 
		mov rcx, r9
		add r8, r9

    add rcx, 1
		repne scasb
		mov rax, r8
		sub rax, rcx
		add rax, 1

		add r8, 1
		cmp rax, r8
		jne short Ende
		xor rax, rax

	Ende:
		pop	rdi
		ret
?SearchCharacters@COStringA@System@RePag@@QEAQKPEBDKK@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_vbNeuerInhalt = 40 + s_push
?ShortRight@COStringA@System@RePag@@QEAQXK@Z PROC ; COStringA::ShortRight(ulStrLange)
		push rbp
		sub rsp, s_ShadowRegister

		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende
		test rdx, rdx
		je Ende
		cmp rdx, rax
		ja Ende

		mov rbp, rcx

		;sub dword ptr COStringA_ulLange[rbp], edx
		;mov eax, dword ptr COStringA_ulLange[rbp]
		;mov dword ptr COStringA_ulLange_A[rbp], eax

		;mov ecx, dword ptr COStringA_ulLange[rbp]
		;test rcx, rcx
		mov eax, dword ptr COStringA_ulLange[rbp]
		sub rax, rdx
		mov dword ptr COStringA_ulLange[rbp], eax
		mov dword ptr COStringA_ulLange_A[rbp], eax
		test rax, rax
		je short Freigeben

		mov rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov qword ptr sqp_vbNeuerInhalt[rsp], rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		add rax, r9
		xor dl, dl
		mov byte ptr [rax], dl

	Freigeben:
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		xor rax, rax
		mov ecx, dword ptr COStringA_ulLange[rbp]
		test rcx, rcx
		cmovne rax, qword ptr sqp_vbNeuerInhalt[rsp]

		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

		;mov eax, dword ptr COStringA_ulLange[rbp]
		;test rax, rax
		;je short Inhalt_Null
		;mov rax, qword ptr sqp_vbNeuerInhalt[rsp]
		;mov qword ptr COStringA_vbInhalt[rbp], rax
		;mov qword ptr COStringA_vbInhalt_A[rbp], rax
		;jmp short Ende

	;Inhalt_Null:
		;xor rax, rax
		;mov qword ptr COStringA_vbInhalt[rbp], rax
		;mov qword ptr COStringA_vbInhalt_A[rbp], rax

	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?ShortRight@COStringA@System@RePag@@QEAQXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqi_ulStrLange = 48 + s_push
sqp_vbNeuerInhalt = 40 + s_push
?ShortLeft@COStringA@System@RePag@@QEAQXK@Z PROC ; COStringA::ShortLeft(ulStrLange)
		push rbp
		sub rsp, s_ShadowRegister

		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende
		test rdx, rdx
		je Ende
		cmp rdx, rax
		ja Ende

		mov rbp, rcx
		mov qword ptr sqi_ulStrLange[rsp], rdx

		;sub dword ptr COStringA_ulLange[rbp], edx
		;mov eax, dword ptr COStringA_ulLange[rbp]
		;mov dword ptr COStringA_ulLange_A[rbp], eax

		;mov ecx, dword ptr COStringA_ulLange[rbp]
		;test rcx, rcx
		mov eax, dword ptr COStringA_ulLange[rbp]
		sub rax, rdx
		mov dword ptr COStringA_ulLange[rbp], eax
		mov dword ptr COStringA_ulLange_A[rbp], eax
		test rax, rax
		je short Freigeben

		;push edx ; ulStrLange
		;mov dword ptr sdi_ulStrLange[rsp], eax
		mov rdx, rax
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		;pop ecx  ; ulStrLange
		mov r8d, dword ptr COStringA_ulLange[rbp]
		mov rdx, qword ptr COStringA_vbInhalt[rbp]
		add rdx, qword ptr sqi_ulStrLange[rsp]
		mov rcx, rax
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		;push eax ; vbNeuerInhalt
		mov qword ptr sqp_vbNeuerInhalt[rsp], rax
		mov r9d, dword ptr COStringA_ulLange[rbp]
		add rax, r9
		xor dl, dl
		mov byte ptr [rax], dl

	Freigeben:
	  mov rdx, qword ptr COStringA_vbInhalt[rbp]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    test rdx, rdx
		je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
	  xor rax, rax
	  mov ecx, dword ptr COStringA_ulLange[rbp]
		test rcx, rcx
		cmovne rax, qword ptr sqp_vbNeuerInhalt[rsp]

		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

	  ;mov eax, dword ptr COStringA_ulLange[rbp]
		;test rax, rax
		;je short Inhalt_Null
		;pop eax ; vbNeuerInhalt
		;mov rax, qword ptr sqp_vbNeuerInhalt[rsp]
		;mov qword ptr COStringA_vbInhalt[rbp], rax
		;mov qword ptr COStringA_vbInhalt_A[rbp], rax
		;jmp short Ende

	;Inhalt_Null:
	  ;xor rax, rax
		;mov qword ptr COStringA_vbInhalt[rbp], rax
		;mov qword ptr COStringA_vbInhalt_A[rbp], rax

	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?ShortLeft@COStringA@System@RePag@@QEAQXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
?ShortRightOne@COStringA@System@RePag@@QEAQXXZ PROC ; COStringA::ShortRightOne(void)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je short Ende
		
		sub dword ptr COStringA_ulLange[rcx], 1
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je short Freigeben
		mov dword ptr COStringA_ulLange_A[rcx], eax
		
		;mov rdx, qword ptr COStringA_vbInhalt[rcx]
		;add rdx, rax
		;xor r8b, r8b
		;mov byte ptr [rdx], r8b
		;sub rdx, rax
		;mov qword ptr COStringA_vbInhalt_A[rcx], rdx
		mov r8, qword ptr COStringA_vbInhalt[rcx]
		add r8, rax
		xor dl, dl
		mov byte ptr [r8], dl
		sub r8, rax
    mov qword ptr COStringA_vbInhalt_A[rcx], r8
		jmp short Ende

	Freigeben:
	  mov rdx, qword ptr COStringA_vbInhalt[rcx]
		test rdx, rdx
    je short Freigeben_Kopie
    ;mov rdx, qword ptr COStringA_vbInhalt[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		mov rcx, qword ptr sqp_this[rsp]
    mov rax, qword ptr COStringA_vbInhalt[rcx]
    cmp rax, qword ptr COStringA_vbInhalt_A[rcx]
    je short Freigeben_Ende

  Freigeben_Kopie:
	  mov rdx, qword ptr COStringA_vbInhalt_A[rcx]
    test rdx, rdx
    je short Freigeben_Ende
    ;mov rdx, qword ptr COStringA_vbInhalt_A[rcx]
    mov rcx, qword ptr COStringA_vmSpeicher[rcx]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov rcx, qword ptr sqp_this[rsp]
		xor rax, rax
		mov dword ptr COStringA_ulLange_A[rcx], eax
		mov qword ptr COStringA_vbInhalt[rcx], rax
		mov qword ptr COStringA_vbInhalt_A[rcx], rax

	Ende:
		add rsp, s_ShadowRegister
		ret
?ShortRightOne@COStringA@System@RePag@@QEAQXXZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?CHAR@COStringA@System@RePag@@QEAQAEADAEAD@Z PROC ; COStringA::CHAR(&cZahl)
		xor rax, rax
		mov byte ptr [rdx], al
		mov eax, dword ptr COStringA_ulLange[rcx] 
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Minus

	Punkt:
		cmp rax, 46
		jne short Minus
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Minus:
		cmp rax, 45
		jne Leerzeichen
		mov al, byte ptr [rdx]
		imul ax, -1
		mov byte ptr [rdx], al
		jmp short Ende

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add byte ptr [rdx], al
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov rax, rdx
		ret
?CHAR@COStringA@System@RePag@@QEAQAEADAEAD@Z ENDP
;----------------------------------------------------------------------------
?BYTE@COStringA@System@RePag@@QEAQAEAEAEAE@Z PROC ; COStringA::BYTE(&ucZahl)
		xor rax, rax
		mov byte ptr [rdx], al
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Leerzeichen

	Punkt:
		cmp rax, 46
		jne short Leerzeichen
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add byte ptr [rdx], al
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov rax, rdx
		ret
?BYTE@COStringA@System@RePag@@QEAQAEAEAEAE@Z ENDP
;----------------------------------------------------------------------------
?SHORT@COStringA@System@RePag@@QEAQAEAFAEAF@Z PROC ; COStringA::SHORT(&sZahl)
		xor rax, rax
		mov word ptr [rdx], ax
		mov eax, dword ptr COStringA_ulLange[rcx] 
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Minus

	Punkt:
		cmp rax, 46
		jne short Minus
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Minus:
		cmp rax, 45
		jne Leerzeichen
		mov ax, word ptr [rdx]
		imul ax, -1
		mov word ptr [rdx], ax
		jmp short Ende

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add word ptr [rdx], ax
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov rax, rdx
		ret
?SHORT@COStringA@System@RePag@@QEAQAEAFAEAF@Z ENDP
;----------------------------------------------------------------------------
?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z PROC ; COStringA::USHORT(&usZahl)
		xor rax, rax
		mov word ptr [rdx], ax
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Leerzeichen

	Punkt:
		cmp rax, 46
		jne short Leerzeichen
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add word ptr [rdx], ax
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov rax, rdx
		ret
?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ENDP
;----------------------------------------------------------------------------
?LONG@COStringA@System@RePag@@QEAQAEAJAEAJ@Z PROC ; COStringA::LONG(&lZahl)
		xor rax, rax
		mov dword ptr [rdx], eax
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Minus

	Punkt:
		cmp rax, 46
		jne short Minus
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Minus:
		cmp rax, 45
		jne Leerzeichen
		mov eax, dword ptr [rdx]
		imul rax, -1
		mov dword ptr [rdx], eax
		jmp short Ende

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add dword ptr [rdx], eax
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov eax, edx
		ret
?LONG@COStringA@System@RePag@@QEAQAEAJAEAJ@Z ENDP
;----------------------------------------------------------------------------
?ULONG@COStringA@System@RePag@@QEAQAEAKAEAK@Z PROC ; COStringA::ULONG(&ulZahl)
		xor rax, rax
		mov dword ptr [rdx], eax
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Ende
		cmp rax, 46
		je short Ende

	Zahl:
		mov r9, 1

		add r8, 1
	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Leerzeichen

	Punkt:
		cmp rax, 46
		jne short Leerzeichen
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Leerzeichen:
		cmp rax, 32
		je short Ende
		cmp rax, 95
		je short Ende
		
		sub rax, 48
		imul rax, r9
		add dword ptr [rdx], eax
		imul r9, 10

		test r8, r8
		jne short Fuss_Anfang

	Ende:
		mov rax, rdx
		ret
?ULONG@COStringA@System@RePag@@QEAQAEAKAEAK@Z ENDP
;----------------------------------------------------------------------------
?LONGLONG@COStringA@System@RePag@@QEAQAEA_JAEA_J@Z PROC ; COStringA::LONGLONG(&llZahl)
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je Ende

		mov r8d, dword ptr COStringA_ulLange[rcx]
		sub r8, 1
		test r8, r8
		jne short Zahl
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je Ende
		cmp rax, 46
		je Ende

	Zahl:
		vmovsd xmm1, dqd_Eins
		add r8, 1

	Fuss_Anfang:
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		cmp rax, 44
		jne short Punkt
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]
		jmp short Minus

	Punkt:
		cmp rax, 46
		jne short Minus
		sub r8, 1
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, r8
		movzx rax, byte ptr [rax]

	Minus:
		cmp rax, 45
		jne Leerzeichen
		vmulsd xmm2, xmm2, dqd_MinusEins
		jmp short Fuss_Ende

	Leerzeichen:
		cmp rax, 32
		je short Fuss_Ende
		cmp rax, 95
		je short Fuss_Ende
		
		sub rax, 48
		vcvtsi2sd xmm0, xmm0, rax
	  vfmadd231sd xmm2, xmm0, xmm1
		vmulsd xmm1, xmm1, dqd_Zehn

		test r8, r8
		jne Fuss_Anfang

	Fuss_Ende:
		vcvttsd2si rax, xmm2
		mov qword ptr [rdx], rax

	Ende:
		mov rax, rdx
		ret
?LONGLONG@COStringA@System@RePag@@QEAQAEA_JAEA_J@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_MXCSR_Alt = 24 + s_push
sdi_MXCSR = 16 + s_push
sqp_fZahl = 8 + s_push
?FLOAT@COStringA@System@RePag@@QEAQAEAMAEAM@Z PROC ; COStringA::FLOAT(&fZahl)
		push rdi

		mov r8, rcx
		mov r10, qword ptr COStringA_vbInhalt[r8]
		vxorps xmm5, xmm5, xmm5
		vxorps xmm0, xmm0, xmm0
		vxorps xmm3, xmm3, xmm3
		
		mov qword ptr sqp_fZahl[rsp], rdx
		
		mov eax, dword ptr COStringA_ulLange[r8]
		test rax, rax
		je Ende

		cld
		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 44

    add rcx, 1
		repne scasb
		sub r9, rcx
		add r9, 1

		vmovd xmm0, r9

		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 46

    add rcx, 1
		repne scasb
		mov rax, r9
		sub rax, rcx
		add rax, 1

		vmovd r9, xmm0

		cmp rax, r9 ; rax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp r9d, dword ptr COStringA_ulLange[r8]
		je Komma_Gleich_Lange
		mov rdi, r9
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov rdi, r9
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 44
		je short EU_oder_US_Ende
		mov rdi, rax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[r8]
		je short Punkt_Gleich_Lange
		mov rdi, rax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov rdi, rax
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 46
		je short EU_oder_US_Ende
		mov rdi, r9
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[r8]
		sub rdi, 1

	EU_oder_US_Ende:
		vmovq xmm4, rdi

		vxorpd xmm0, xmm0, xmm0 ; Exponent
		vmovss xmm1, dds_Zehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[r8]

		vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

	Kopf_Anfang:
		add rdi, 1
		cmp rdi, rdx
		jae Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46 ; Punkt
		jne short Gleich_44
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_44:
		cmp rax, 44 ; Komma
		jne short Gleich_32
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_32:
		cmp rax, 32 
		je Kopf_Ende
		cmp rax, 95
		je Kopf_Ende
		cmp rax, 42
		jne Gleich_48
		add rdi, 4
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 45
		je short Gleich_45
		vaddsd xmm0, xmm0, dqd_Eins
		jmp short Lange_Stelle_2

	Gleich_45:
		vaddsd xmm0, xmm0, dqd_Eins
		add rdi, 1

	Lange_Stelle_2:
		mov rcx, rdx
		sub rcx, rdi
		cmp rcx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_2
		cmp rax, 57
		ja short Faktor_Null_2
		sub rax, 48
		imul rax, 10
		vcvtsi2ss xmm1, xmm1, rax
		add rdi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		vmovss xmm1, xmm1, xmm5

	Einer_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_3
		cmp rax, 57
		ja short Faktor_Null_3
		sub rax, 48
		vcvtsi2ss xmm2, xmm2, rax
		vaddss xmm1, xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		vmovss xmm1, xmm1, xmm5

	Kopf_2:
		vucomiss xmm1, xmm5
		je Kopf_Ende
		vsubss xmm1, xmm1, dds_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_1
		cmp rax, 57
		ja short Faktor_Null_1
		sub rax, 48
		vcvtsi2ss xmm1, xmm1, rax
		jmp short Kopf_1

	Faktor_Null_1:
		vmovss xmm1, xmm1, xmm5

	Kopf_1:
		vucomiss xmm1, xmm5
		je Kopf_Ende
		vsubss xmm1, xmm1, dds_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp rcx, 3
		jl Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_4
		cmp rax, 57
		ja short Faktor_Null_4
		sub rax, 48
		imul eax, 100
		vcvtsi2ss xmm1, xmm1, rax
		add rdi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		vmovss xmm1, xmm1, xmm5

	Zehner_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_5
		cmp rax, 57
		ja short Faktor_Null_5
		sub rax, 48
		imul rax, 10
		vcvtsi2ss xmm2, xmm2, rax
		addss xmm1, xmm2
		add rdi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		vmovss xmm1, xmm1, xmm5

	Einer_Stelle_2:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		ja short Faktor_Null_6
		cmp rax, 57
		jl short Faktor_Null_6
		sub rax, 48
		vcvtsi2ss xmm2, xmm2, rax
		vaddss xmm1, xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		vmovss xmm1, xmm1, xmm5

	Faktor_38:
		vucomiss xmm1, dds_Achtunddreizig
		jbe short Kopf_3
		vucomiss xmm1, dds_MinusAchtunddreizig
		jge short Kopf_3
		vmovss xmm1, xmm1, xmm5

	Kopf_3:
		vucomiss xmm1, xmm5
		jmp short Kopf_Ende
		vsubss xmm1, xmm1, dds_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_3

	Exponent_Eins:
		vmovsd xmm0, dqd_Eins

	Kopf_4:
		vucomiss xmm1, xmm5
		jmp short Kopf_Ende
		vsubss xmm1, xmm1, dds_Eins
		vmulsd xmm0, xmm0, dqd_Zwei
		jmp short Kopf_4

	Gleich_48:
		cmp rax, 48
		jl short FZahl_Null
		cmp rax, 57
		ja short FZahl_Null
		sub rax, 48
		vcvtsi2ss xmm2, xmm2, rax
		vdivss xmm2, xmm2, xmm1
		vaddss xmm3, xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		vmovss xmm2, xmm2, xmm5
		vdivss xmm2, xmm2, xmm1
		vaddss xmm3, xmm3, xmm2

	Faktor_Zehn:
		vmulss xmm1, xmm1, dds_Zehn
		jmp Kopf_Anfang

	Kopf_Ende:
		vmovq rdi, xmm4 ; ucStelle
		vmovss xmm4, xmm3, xmm3

		vmovss xmm1, dds_Eins

		test rdi, rdi
		jne Fuss_Anfang
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je Exponent_1
		cmp rax, 46
		je Exponent_1

	Fuss_Anfang:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46
		je short Stelle_Minus
		cmp rax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]

	Stelle_45:
		cmp rax, 45
		jne short Stelle_32
		vmulss xmm3, xmm3, dds_MinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp rax, 32
		je short Exponent_1
		cmp rax, 95
		je short Exponent_1
		cmp rax, 48
		jb short FZahl_Null_1
		cmp rax, 57
		ja short FZahl_Null_1
		sub rax, 48
		vcvtsi2ss xmm2, xmm2, rax
		vfmadd231ss xmm3, xmm2, xmm1
		jmp short Fuss_Ende

	FZahl_Null_1:
		vmovss xmm2, xmm2, xmm5
		vdivss xmm2, xmm2, xmm1
		vaddss xmm3, xmm3, xmm2

	Fuss_Ende:
		vmulss xmm1, xmm1, dds_Zehn
		test rdi, rdi
		je short Exponent_1
		sub rdi, 1
		jmp Fuss_Anfang

	Exponent_1:
	  vxorpd xmm5, xmm5, xmm5
		vucomisd xmm0, xmm5
		jg short FZahl_Mul
		vucomisd xmm0, xmm5
		jl short FZahl_Div
		jmp short Ende

	FZahl_Mul:
		vcvtsd2ss xmm2, xmm2, xmm0
		vmulss xmm3, xmm3, xmm2
		jmp short Ende

	FZahl_Div:
		vmulsd xmm0, xmm0, dqd_MinusEins
		vmovss xmm2, xmm2, xmm0
		vdivss xmm3, xmm3, xmm2

	Ende:
		mov rdx, qword ptr sqp_fZahl[rsp]
		vmovss dword ptr [rdx], xmm3
		mov rax, rdx
		vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
		pop rdi
		ret
?FLOAT@COStringA@System@RePag@@QEAQAEAMAEAM@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_MXCSR_Alt = 24 + s_push
sdi_MXCSR = 16 + s_push
sqp_dZahl = 8 + s_push
?DOUBLE@COStringA@System@RePag@@QEAQAEANAEAN@Z PROC ; COStringA::DOUBLE(&dZahl)
		push rdi

		mov r8, rcx
		mov r10, qword ptr COStringA_vbInhalt[r8]
		vxorpd xmm0, xmm0, xmm0
		vxorpd xmm3, xmm3, xmm3
		vxorpd xmm5, xmm5, xmm5

		mov qword ptr sqp_dZahl[rsp], rdx

		mov eax, dword ptr COStringA_ulLange[r8]
		test rax, rax
		je Ende

		cld
		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 44

    add rcx, 1
		repne scasb
		sub r9, rcx
		add r9, 1

		vmovq xmm0, r9 ; ucKomma

		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 46

    add rcx, 1
		repne scasb
		mov rax, r9
		sub rax, rcx
		add rax, 1

		vmovq r9, xmm0 ; ucKomma

		cmp rax, r9 ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp r9d, dword ptr COStringA_ulLange[r8]
		je Komma_Gleich_Lange
		mov rdi, r9
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov rdi, r9
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 44
		je short EU_oder_US_Ende
		mov rdi, rax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[r8]
		je short Punkt_Gleich_Lange
		mov rdi, rax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov rdi, rax
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 46
		je short EU_oder_US_Ende
		mov rdi, r9
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[r8]
		sub rdi, 1

	EU_oder_US_Ende:
		vmovq xmm4, rdi ; ucStelle

		vxorpd xmm0, xmm0, xmm0 ; Exponent
		vmovsd xmm1, dqd_Zehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[r8]

		vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

	Kopf_Anfang:
		add rdi, 1
		cmp rdi, rdx
		jae Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46 ; Punkt
		jne short Gleich_44
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_44:
		cmp rax, 44 ; Komma
		jne short Gleich_32
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_32:
		cmp rax, 32 
		je Kopf_Ende
		cmp rax, 95
		je Kopf_Ende
		cmp rax, 42
		jne Gleich_48
		add rdi, 4
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 45
		je short Gleich_45
		vaddsd xmm0, xmm0, dqd_Eins
		jmp short Lange_Stelle_2

	Gleich_45:
		vaddsd xmm0, xmm0, dqd_Eins
		add rdi, 1

	Lange_Stelle_2:
		mov rcx, rdx
		sub rcx, rdi
		cmp rcx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_2
		cmp rax, 57
		ja short Faktor_Null_2
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm1, xmm1, rax
		add rdi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_3
		cmp rax, 57
		ja short Faktor_Null_3
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		vmovsd xmm1, xmm1, xmm5

	Kopf_2:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_1
		cmp rax, 57
		ja short Faktor_Null_1
		sub rax, 48
		vcvtsi2sd xmm1, xmm1, rax
		jmp short Kopf_1

	Faktor_Null_1:
		vmovsd xmm1, xmm1, xmm5

	Kopf_1:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp rcx, 3
		jl Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_4
		cmp rax, 57
		ja short Faktor_Null_4
		sub rax, 48
		imul rax, 100
		vcvtsi2sd xmm1, xmm1, eax
		add rdi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		vmovsd xmm1, xmm1, xmm5

	Zehner_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_5
		cmp rax, 57
		ja short Faktor_Null_5
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		add rdi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_2:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		ja short Faktor_Null_6
		cmp rax, 57
		jl short Faktor_Null_6
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		vmovsd xmm1, xmm1, xmm5

	Faktor_38:
		vucomisd xmm1, dqd_Dreihunderacht
		jbe short Kopf_3
		vucomisd xmm1, dqd_MinusDreihunderacht
		jge short Kopf_3
		vmovsd xmm1, xmm1, xmm5

	Kopf_3:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_3

	Exponent_Eins:
		vmovsd xmm0, dqd_Eins

	Kopf_4:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zwei
		jmp short Kopf_4

	Gleich_48:
		cmp rax, 48
		jl short FZahl_Null
		cmp rax, 57
		ja short FZahl_Null
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Faktor_Zehn:
		vmulsd xmm1, xmm1, dqd_Zehn
		jmp Kopf_Anfang

	Kopf_Ende:
		vmovq rdi, xmm4  ; ucStelle

		vmovsd xmm1, dqd_Eins

		test rdi, rdi
		jne Fuss_Anfang
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je Exponent_1
		cmp rax, 46
		je Exponent_1

	Fuss_Anfang:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46
		je short Stelle_Minus
		cmp rax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]

	Stelle_45:
		cmp rax, 45
		jne short Stelle_32
		vmulsd xmm3, xmm3, dqd_MinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp rax, 32
		je short Exponent_1
		cmp rax, 95
		je short Exponent_1
		cmp rax, 48
		jb short FZahl_Null_1
		cmp rax, 57
		ja short FZahl_Null_1
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vfmadd231sd xmm3, xmm2, xmm1
		jmp short Fuss_Ende

	FZahl_Null_1:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Fuss_Ende:
		vmulsd xmm1, xmm1, dqd_Zehn
		test rdi, rdi
		je short Exponent_1
		sub rdi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		vucomisd xmm0, xmm5
		jg short FZahl_Mul
		vucomisd xmm0, xmm5
		jl short FZahl_Div
		jmp short Ende

	FZahl_Mul:
		vmulsd xmm3, xmm3, xmm0
		jmp short Ende

	FZahl_Div:
		vmulsd xmm0, xmm0, dqd_MinusEins
		vmovsd xmm2, xmm2, xmm0
		vdivsd xmm3, xmm3, xmm2

	Ende:
		mov rdx, qword ptr sqp_dZahl[rsp]
		vmovsd qword ptr [rdx], xmm3
		mov rax, rdx
		vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
		pop rdi
		ret
?DOUBLE@COStringA@System@RePag@@QEAQAEANAEAN@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_MXCSR_Alt = 20 + s_push
sdi_MXCSR = 16 + s_push
sqp_pk4Zahl = 8 + s_push
?COMMA4@COStringA@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z PROC ; COStringA::KOMMA4(pk4Zahl)
		push rdi

		mov r8, rcx
		mov r10, qword ptr COStringA_vbInhalt[r8]
		vxorpd xmm5, xmm5, xmm5
		vxorps xmm0, xmm0, xmm0
		vxorps xmm3, xmm3, xmm3

		mov qword ptr sqp_pk4Zahl[rsp], rdx
		
		mov eax, dword ptr COStringA_ulLange[r8]
		test rax, rax
		je Ende_Double

		cld
		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 44

    add rcx, 1
		repne scasb
		sub r9, rcx
		add r9, 1

		vmovq xmm0, r9  ; ucKomma

		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 46

    add rcx, 1
		repne scasb
		mov rax, r9
		sub rax, rcx
		add rax, 1

		vmovq r9, xmm0  ; ucKomma

		cmp rax, r9 ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp r9d, dword ptr COStringA_ulLange[r8]
		je Komma_Gleich_Lange
		mov rdi, r9
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov rdi, r9
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 44
		je short EU_oder_US_Ende
		mov rdi, rax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[r8]
		je short Punkt_Gleich_Lange
		mov rdi, rax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov rdi, rax
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 46
		je short EU_oder_US_Ende
		mov rdi, r9
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[r8]
		sub rdi, 1

	EU_oder_US_Ende:
		vmovq xmm4, rdi ; ucStelle
		
		vxorpd xmm0, xmm0, xmm0 ; Exponent
		vmovsd xmm1, dqd_Zehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[r8]

		vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

	Kopf_Anfang:
		add rdi, 1
		cmp rdi, rdx
		jae Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46 ; Punkt
		jne short Gleich_44
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_44:
		cmp rax, 44 ; Komma
		jne short Gleich_32
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_32:
		cmp rax, 32 
		je Kopf_Ende
		cmp rax, 95
		je Kopf_Ende
		cmp rax, 42
		jne Gleich_48
		add rdi, 4
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 45
		je short Gleich_45
		vaddsd xmm0, xmm0, dqd_Eins
		jmp short Lange_Stelle_2

	Gleich_45:
		vaddsd xmm0, xmm0, dqd_Eins
		add rdi, 1

	Lange_Stelle_2:
		mov rcx, rdx
		sub rcx, rdi
		cmp rcx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_2
		cmp rax, 57
		ja short Faktor_Null_2
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm1, xmm1, rax
		add rdi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_3
		cmp rax, 57
		ja short Faktor_Null_3
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		vmovsd xmm1, xmm1, xmm5

	Kopf_2:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_1
		cmp rax, 57
		ja short Faktor_Null_1
		sub rax, 48
		vcvtsi2sd xmm1, xmm1, rax
		jmp short Kopf_1

	Faktor_Null_1:
		vmovsd xmm1, xmm1, xmm5

	Kopf_1:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp rcx, 3
		jl Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_4
		cmp rax, 57
		ja short Faktor_Null_4
		sub rax, 48
		imul rax, 100
		vcvtsi2sd xmm1,xmm1,  rax
		add rdi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		vmovsd xmm1, xmm1, xmm5

	Zehner_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_5
		cmp rax, 57
		ja short Faktor_Null_5
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		add rdi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_2:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		ja short Faktor_Null_6
		cmp rax, 57
		jl short Faktor_Null_6
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		vmovsd xmm1, xmm1, xmm5

	Faktor_38:
		vucomisd xmm1, dqd_Dreihunderacht
		jbe short Kopf_3
		vucomisd xmm1, dqd_MinusDreihunderacht
		jge short Kopf_3
		vmovsd xmm1, xmm1, xmm5

	Kopf_3:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_3

	Exponent_Eins:
		vmovsd xmm0, dqd_Eins

	Kopf_4:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zwei
		jmp short Kopf_4

	Gleich_48:
		cmp rax, 48
		jl short FZahl_Null
		cmp rax, 57
		ja short FZahl_Null
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Faktor_Zehn:
		vmulsd xmm1, xmm1, dqd_Zehn
		jmp Kopf_Anfang

	Kopf_Ende:
		vmovq rdi, xmm4 ; ucStelle
		vmovsd xmm1, dqd_Eins

		test rdi, rdi
		jne Fuss_Anfang
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je Exponent_1
		cmp rax, 46
		je Exponent_1

	Fuss_Anfang:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46
		je short Stelle_Minus
		cmp rax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]

	Stelle_45:
		cmp rax, 45
		jne short Stelle_32
		vmulsd xmm3, xmm3, dqd_MinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp rax, 32
		je short Exponent_1
		cmp rax, 95
		je short Exponent_1
		cmp rax, 48
		jb short FZahl_Null_1
		cmp rax, 57
		ja short FZahl_Null_1
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vfmadd231sd xmm3, xmm2, xmm1
		jmp short Fuss_Ende

	FZahl_Null_1:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Fuss_Ende:
		vmulsd xmm1, xmm1, dqd_Zehn
		test rdi, rdi
		je short Exponent_1
		sub rdi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		vucomisd xmm0, xmm5
		jg short FZahl_Mul
		ucomisd xmm0, xmm5
		jl short FZahl_Div
		jmp short Ende_Double

	FZahl_Mul:
		vmulsd xmm3, xmm3, xmm0
		jmp short Ende_Double

	FZahl_Div:
		vmulsd xmm0, xmm0, dqd_MinusEins
		vmovsd xmm2, xmm2, xmm0
		vdivsd xmm3, xmm3, xmm2

	Ende_Double:
		vmovsd xmm0, xmm0, xmm3

    vmovsd xmm1, xmm1, xmm0
    vcvttsd2si rax, xmm1
    vcvtsi2sd xmm1, xmm1, rax
    vsubsd xmm0, xmm0, xmm1
    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, edx
    vsubsd xmm0, xmm0, xmm1
    vmulsd xmm0, xmm0, dqd_Zehn
    vcvtsd2si r9, xmm0

    cmp r9, 0
    je short Ende
    jl short Minus
    cmp r9, 5
    jb short Ende
    add rdx, 1
    cmp rdx, 10000
    jb short Ende
    xor rdx, rdx
    add rax, 1
    jmp short Ende

  Minus:
    cmp r9, -5
    jg short Ende
    sub rdx, 1
    cmp rdx, -10000
    jg short Ende
    xor rdx, rdx
    sub rax, 1

  Ende:
		mov rcx, qword ptr sqp_pk4Zahl[rsp]
    mov dword ptr COComma4_lVorKomma[rcx], eax
    mov dword ptr COComma4_lVorKomma_A[rcx], eax
    mov word ptr COComma4_sNachKomma[rcx], dx
    mov word ptr COComma4_sNachKomma_A[rcx], dx

		mov rax, rcx
		vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
		pop rdi
		ret
?COMMA4@COStringA@System@RePag@@QEAQPEAVCOComma4@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
s_lBytes = 16

swi_Runden_Alt = 28 + s_lBytes + s_push
swi_Runden = 24 + s_lBytes + s_push
sdi_MXCSR_Alt = 20 + s_lBytes + s_push
sdi_MXCSR = 16 + s_lBytes + s_push
sqp_dZahl = 8 + s_lBytes + s_push

sqd_Zahl = 0
?COMMA4_80@COStringA@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z PROC ; COStringA::KOMMA4_80(pk4_80Zahl)
		push rdi
		sub rsp, s_lBytes
		
		mov r8, rcx
		mov r10, qword ptr COStringA_vbInhalt[r8]
		vxorpd xmm5, xmm5, xmm5
		vxorpd xmm0, xmm0, xmm0
		vxorpd xmm3, xmm3, xmm3

		mov qword ptr sqp_dZahl[rsp], rdx

		mov eax, dword ptr COStringA_ulLange[r8]
		test rax, rax
		je Ende_Double

		cld
		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 44

    add rcx, 1
		repne scasb
		sub r9, rcx
		add r9, 1

		vmovq xmm0, r9 ; ucKomma

		mov rdi, r10
		mov ecx, dword ptr COStringA_ulLange[r8]
		mov r9, rcx
    sub r9, 1
		mov al, 46

    add rcx, 1
		repne scasb
		mov rax, r9
		sub rax, rcx
		add rax, 1

		vmovq r9, xmm0 ; ucKomma

		cmp rax, r9 ; eax -> Punkt
		je short Lange_Minus_Eins
		ja short Punkt_Grosser

		cmp r9d, dword ptr COStringA_ulLange[r8]
		je Komma_Gleich_Lange
		mov rdi, r9
		jmp EU_oder_US_Ende

	Komma_Gleich_Lange:
		mov rdi, r9
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 44
		je short EU_oder_US_Ende
		mov rdi, rax
		jmp short EU_oder_US_Ende		

	Punkt_Grosser:
		cmp eax, dword ptr COStringA_ulLange[r8]
		je short Punkt_Gleich_Lange
		mov rdi, rax
		jmp EU_oder_US_Ende

	Punkt_Gleich_Lange:
		mov rdi, rax
		mov ecx, dword ptr COStringA_ulLange[r8]
		sub rcx, 1
		mov rdx, r10
		add rdx, rcx
		cmp r10, 46
		je short EU_oder_US_Ende
		mov rdi, r9
		jmp short EU_oder_US_Ende

	Lange_Minus_Eins:
		mov edi, dword ptr COStringA_ulLange[r8]
		sub rdi, 1

	EU_oder_US_Ende:
		vmovq xmm4, rdi ; ucStelle

		vxorpd xmm0, xmm0, xmm0 ; Exponent
		vmovsd xmm1, dqd_Zehn ; Faktor
		mov edx, dword ptr COStringA_ulLange[r8]

		vstmxcsr dword ptr sdi_MXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_MXCSR[rsp]
    or dword ptr sdi_MXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_MXCSR[rsp]

	Kopf_Anfang:
		add rdi, 1
		cmp rdi, rdx
		jae Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46 ; Punkt
		jne short Gleich_44
		sub rdi, 1
		mov rax, r10
		add rax, r10
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_44:
		cmp rax, 44 ; Komma
		jne short Gleich_32
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		jmp short Gleich_32

	Gleich_32:
		cmp rax, 32 
		je Kopf_Ende
		cmp rax, 95
		je Kopf_Ende
		cmp rax, 42
		jne Gleich_48
		add rdi, 4
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 45
		je short Gleich_45
		vaddsd xmm0, xmm0, dqd_Eins
		jmp short Lange_Stelle_2

	Gleich_45:
		vaddsd xmm0, xmm0, dqd_Eins
		add rdi, 1

	Lange_Stelle_2:
		mov rcx, rdx
		sub rcx, rdi
		cmp rcx, 2
		jb short Lange_Stelle_1
		ja Lange_Stelle_3
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_2
		cmp rax, 57
		ja short Faktor_Null_2
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm1, xmm1, rax
		add rdi, 1
		jmp short Einer_Stelle_1

	Faktor_Null_2:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_3
		cmp rax, 57
		ja short Faktor_Null_3
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Kopf_2

	Faktor_Null_3:
		vmovsd xmm1, xmm1, xmm5

	Kopf_2:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_2

	Lange_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_1
		cmp rax, 57
		ja short Faktor_Null_1
		sub rax, 48
		vcvtsi2sd xmm1, xmm1, eax
		jmp short Kopf_1

	Faktor_Null_1:
		vmovsd xmm1, xmm1, xmm5

	Kopf_1:
		vucomisd xmm1, xmm5
		je Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_1

	Lange_Stelle_3:
		cmp rcx, 3
		jl Kopf_Ende
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_4
		cmp rax, 57
		ja short Faktor_Null_4
		sub rax, 48
		imul eax, 100
		vcvtsi2sd xmm1, xmm1, rax
		add rdi, 1
		jmp short Zehner_Stelle_1

	Faktor_Null_4:
		vmovsd xmm1, xmm1, xmm5

	Zehner_Stelle_1:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		jb short Faktor_Null_5
		cmp rax, 57
		ja short Faktor_Null_5
		sub rax, 48
		imul rax, 10
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		add rdi, 1
		jmp short Einer_Stelle_2

	Faktor_Null_5:
		vmovsd xmm1, xmm1, xmm5

	Einer_Stelle_2:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 48
		ja short Faktor_Null_6
		cmp rax, 57
		jl short Faktor_Null_6
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		vaddsd xmm1, xmm1, xmm2
		jmp short Faktor_38

	Faktor_Null_6:
		vmovsd xmm1, xmm1, xmm5

	Faktor_38:
		vucomisd xmm1, dqd_Dreihunderacht
		jbe short Kopf_3
		vucomisd xmm1, dqd_MinusDreihunderacht
		jge short Kopf_3
		vmovsd xmm1, xmm1, xmm5

	Kopf_3:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zehn
		jmp short Kopf_3

	Exponent_Eins:
		vmovsd xmm0, dqd_Eins

	Kopf_4:
		vucomisd xmm1, xmm5
		jmp short Kopf_Ende
		vsubsd xmm1, xmm1, dqd_Eins
		vmulsd xmm0, xmm0, dqd_Zwei
		jmp short Kopf_4

	Gleich_48:
		cmp rax, 48
		jl short FZahl_Null
		cmp rax, 57
		ja short FZahl_Null
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, eax
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2 
		jmp short Faktor_Zehn

	FZahl_Null:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Faktor_Zehn:
		vmulsd xmm1, xmm1, dqd_Zehn
		jmp Kopf_Anfang

	Kopf_Ende:

		vmovq rdi, xmm4 ; ucStelle

		vmovsd xmm1, dqd_Eins

		test rdi, rdi
		jne Fuss_Anfang
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je Exponent_1
		cmp rax, 46
		je Exponent_1

	Fuss_Anfang:
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]
		cmp rax, 46
		je short Stelle_Minus
		cmp rax, 44
		je short Stelle_Minus
		jmp short Stelle_45

	Stelle_Minus:
		sub rdi, 1
		mov rax, r10
		add rax, rdi
		movzx rax, byte ptr [rax]

	Stelle_45:
		cmp rax, 45
		jne short Stelle_32
		vmulsd xmm3, xmm3, dqd_MinusEins
		jmp short Exponent_1

	Stelle_32:
		cmp rax, 32
		je short Exponent_1
		cmp rax, 95
		je short Exponent_1
		cmp rax, 48
		jb short FZahl_Null_1
		cmp rax, 57
		ja short FZahl_Null_1
		sub rax, 48
		vcvtsi2sd xmm2, xmm2, rax
		;vmulsd xmm2, xmm2, xmm1
		;vaddsd xmm3, xmm3, xmm2
		vfmadd231sd xmm3, xmm2, xmm1
		jmp short Fuss_Ende

	FZahl_Null_1:
		vmovsd xmm2, xmm2, xmm5
		vdivsd xmm2, xmm2, xmm1
		vaddsd xmm3, xmm3, xmm2

	Fuss_Ende:
		vmulsd xmm1, xmm1, dqd_Zehn
		test rdi, rdi
		je short Exponent_1
		sub rdi, 1
		jmp short Fuss_Anfang

	Exponent_1:
		vucomisd xmm0, xmm5
		jg short FZahl_Mul
		vucomisd xmm0, xmm5
		jl short FZahl_Div
		jmp short Ende_Double

	FZahl_Mul:
		vmulsd xmm3, xmm3, xmm0
		jmp short Ende_Double

	FZahl_Div:
		vmulsd xmm0, xmm0, dqd_MinusEins
		vmovsd xmm2, xmm2, xmm0
		vdivsd xmm3, xmm3, xmm2

	Ende_Double:
		vmovsd xmm0, xmm0, xmm3

    fstcw swi_Runden_Alt[rsp]
    fstcw swi_Runden[rsp]
    bts word ptr swi_Runden[rsp], 10
    bts word ptr swi_Runden[rsp], 11
    fldcw swi_Runden[rsp]
    fclex

	  vmovsd qword ptr sqd_Zahl[rsp], xmm0
    fld qword ptr sqd_Zahl[rsp]
    fistp qword ptr sqd_Zahl[rsp]
    fild qword ptr sqd_Zahl[rsp]
    vmovq xmm2, qword ptr sqd_Zahl[rsp]
    fstp qword ptr sqd_Zahl[rsp]
    vmovsd xmm1, qword ptr sqd_Zahl[rsp]
    vsubsd xmm0, xmm0, xmm1
    vmulsd xmm0, xmm0, dqd_Zehntausend
    vcvtsd2si rdx, xmm0
    vcvtsi2sd xmm1, xmm1, rdx
    vsubsd xmm0, xmm0, xmm1
    vmulsd xmm0, xmm0, dqd_Zehn
    vcvtsd2si r9, xmm0

    cmp r9, 0
    je short Ende
    jl short Minus
    cmp r9, 5
    jb short Ende
    add rdx, 1
    cmp rdx, 10000
    jb short Ende
    xor rdx, rdx
    vpaddq xmm2, xmm2, dqi_Eins
    jmp short Ende

  Minus:
    cmp r9, -5
    jg short Ende
    sub rdx, 1
    cmp rdx, -10000
    jg short Ende
    xor rdx, rdx
    vpsubq xmm2, xmm2, dqi_Eins
    
  Ende:
		mov rcx, qword ptr sqp_dZahl[rsp]
    movq qword ptr COComma4_80_llVorKomma[rcx], xmm2
    movq qword ptr COComma4_80_llVorKomma_A[rcx], xmm2
    mov word ptr COComma4_80_sNachKomma[rcx], dx
    mov word ptr COComma4_80_sNachKomma_A[rcx], dx

		mov rax, rcx
    fldcw swi_Runden_Alt[rsp]
    vldmxcsr dword ptr sdi_MXCSR_Alt[rsp]
		
		add rsp, s_lBytes
		pop rdi
		ret
?COMMA4_80@COStringA@System@RePag@@QEAQPEAVCOComma4_80@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sqp_bit128Zahl = 8 + s_push
?BIT128fromGUID@COStringA@System@RePag@@QEAQAEAY0BA@EAEAY0BA@E@Z PROC ; COStringA::BIT128fromGUID(BIT128& bit128Zahl)
		push rbx

		mov r8, qword ptr COStringA_vbInhalt[rcx]
		mov qword ptr sqp_bit128Zahl[rsp], rdx

		vxorpd xmm0, xmm0, xmm0
		vxorpd xmm1, xmm1, xmm1
		vxorpd xmm2, xmm2, xmm2
		xor rax, rax
		xor rdx, rdx
		xor rcx, rcx
		xor rbx, rbx
		jmp short Fuss_Anfang

  Trennung:
		sub ch, 1

	Nachste_Zeichen:
		add r8, 1
		add ch, 1

	Fuss_Anfang:
		mov al, byte ptr [r8]
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
		shl rax, 12
		jmp short Nachste_Zeichen

	Copy_8bit:
		add ah, al
		mov bl, ah

		cmp ch, 7
		jae short Copy_32bit

		shl rbx, 8
		xor cl, cl
		jmp short Nachste_Zeichen

	Copy_32bit:
		vmovd xmm1, ebx
		vpaddd xmm2, xmm2, xmm1

		test dl, dl
		je short Shift_32
		xor dl, dl

		test dh, dh
		je short Copy_Quad
		vpaddq xmm0, xmm0, xmm2
		jmp short Ende

  Copy_Quad:
		vmovlhps xmm0, xmm0, xmm2
		vpxor xmm2, xmm2, xmm2
		add dh, 1
		xor cx, cx
		jmp short Nachste_Zeichen

	Shift_32:
		vpsllq xmm2, xmm2, 32
		add dl, 1
		xor cx, cx
		jmp short Nachste_Zeichen

	Ende:
		mov rdx, qword ptr sqp_bit128Zahl[rsp]
		vmovdqu xmmword ptr [rdx], xmm0
		pop rbx
		ret
?BIT128fromGUID@COStringA@System@RePag@@QEAQAEAY0BA@EAEAY0BA@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?IsIntegralNumber@COStringA@System@RePag@@QEAQ_NXZ PROC ; COStringA::IsIntegralNumber(void)
		push rbx
		
		xor rax, rax
		mov edx, dword ptr COStringA_ulLange[rcx]
		test rdx, rdx
		je Ende

		xor rbx, rbx
		xor rdx, rdx

	Kopf_1_Anfang:
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, rbx
		movzx rax, byte ptr [rax]
		cmp rax, 32
		je short StellePlus
		cmp rax, 95
		je short StellePlus
		jmp Kopf_1_Ende

	StellePlus:
		add rbx, 1
		jmp short Kopf_1_Anfang

	Kopf_1_Ende:
		cmp rax, 44
		je Ende
		cmp rax, 46
		je Ende
		cmp rax, 45
		je short StellePlus_1
		jmp short Kopf_2_Anfang

	StellePlus_1:
		add rbx, 1

	Kopf_2_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[rcx]
		jae True
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		add rax, rbx
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Z44_Punkt
		cmp rax, 46
		je short Z44_Punkt
		cmp rax, 47
		jbe short False
		cmp rax, 58
		jae short False

	Z44_Punkt:
		cmp rax, 44
		jne short Z44_0ucKomma_0ucPunkt
		test dh, dh
		jne short False

	Z44_0ucKomma_0ucPunkt:
		cmp rax, 44
		jne short Z44_ucKomma_ucPunkt
		test dh, dh
		jne short Z44_ucKomma_ucPunkt
		test dl, dl
		jne short Z44_ucKomma_ucPunkt
		mov dl, bl
		jmp short Kopf_2_Ende

	Z44_ucKomma_ucPunkt:
		cmp rax, 44
		jne short Z46_ucKomma
		test dl, dl
		je short Z46_ucKomma
		test dh, dh
		je short Z46_ucKomma
		jmp short False

	Z46_ucKomma:
		cmp rax, 46
		jne short Z46_0ucKomma_0ucPunkt
		test dl, dl
		jne short False

	Z46_0ucKomma_0ucPunkt:
		cmp rax, 46
		jne short Z46_ucKomma_ucPunkt
		test dh, dh
		jne short Z46_ucKomma_ucPunkt
		test dl, dl
		jne short Z46_ucKomma_ucPunkt
		mov dh, bl
		jmp short Kopf_2_Ende

	Z46_ucKomma_ucPunkt:
		cmp rax, 46
		jne short Kopf_2_Ende
		test dh, dh
		jne short Kopf_2_Ende
		test dl, dl
		jne short Kopf_2_Ende
		jmp short False


	Kopf_2_Ende:
		add rbx, 1
		jmp Kopf_2_Anfang

	True:
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
	  pop rbx
		ret
?IsIntegralNumber@COStringA@System@RePag@@QEAQ_NXZ ENDP
;----------------------------------------------------------------------------
?IsFloatingPointNumber@COStringA@System@RePag@@QEAQ_NXZ PROC ; COStringA::IsFloatingPointNumber(void)
		push rbx
		
		xor rax, rax
		mov r8, rcx
		mov edx, dword ptr COStringA_ulLange[r8]
		test rdx, rdx
		je Ende

		xor rbx, rbx
		xor rdx, rdx
		xor rcx, rcx

	Kopf_1_Anfang:
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]
		cmp rax, 32
		je short StellePlus
		cmp rax, 95
		je short StellePlus
		jmp Kopf_1_Ende

	StellePlus:
		add rbx, 1
		jmp short Kopf_1_Anfang

	Kopf_1_Ende:
		cmp rax, 44
		je Ende
		cmp rax, 46
		je Ende
		cmp rax, 45
		je short StellePlus_1
		jmp short Kopf_2_Anfang

	StellePlus_1:
		add rbx, 1

	Kopf_2_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[r8]
		jae True
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]
		cmp rax, 44
		je short Z44_0ucKomma
		cmp rax, 46
		je short Z44_0ucKomma
		cmp rax, 47
		jbe short Z42_bExponent
		cmp rax, 58
		jae short Z42_bExponent

	Z44_0ucKomma:
		cmp rax, 44
		jne short Z44_ucKomma_ucPunkt
		test dl, dl
		jne short Z44_ucKomma_ucPunkt
		mov dl, bl
		jmp Kopf_2_Ende

	Z44_ucKomma_ucPunkt:
		cmp rax, 44
		jne short Z46_0ucPunkt
		test dl, dl
		je short Z46_0ucPunkt
		test dh, dh
		je short Z46_0ucPunkt
		jmp False

	Z46_0ucPunkt:
		cmp rax, 46
		jne short Z46_ucKomma_ucPunkt
		test dh, dh
		jne short Z46_ucKomma_ucPunkt
		mov dh, bl
		jmp Kopf_2_Ende

	Z46_ucKomma_ucPunkt:
		cmp rax, 46
		jne Kopf_2_Ende
		test dh, dh
		jne Kopf_2_Ende
		test dl, dl
		jne Kopf_2_Ende
		jmp False

	Z42_bExponent:
		cmp rax, 42
		jne False
		test cl, cl
		jne False
		add ebx, 1
		mov cl, 1

		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]
		cmp rax, 49
		jne short Z50
		add rbx, 3
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]
		jmp short Z45

	Z50:
		cmp rax, 50
		jne short False
		add rbx, 2
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]

	Z45:
		cmp rax, 45
		jne short Kopf_3_Anfang
		add rbx, 1
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx eax, byte ptr [eax]

	Kopf_3_Anfang:
		cmp ebx, dword ptr COStringA_ulLange[r8]
		jb short True
		cmp rax, 47
		jb short False
		cmp rax, 58
		ja short False
		add rbx, 1
		mov rax, qword ptr COStringA_vbInhalt[r8]
		add rax, rbx
		movzx rax, byte ptr [rax]
		jmp Kopf_3_Anfang

	Kopf_2_Ende:
		add rbx, 1
		jmp Kopf_2_Anfang

	True:
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
	  pop rbx
		ret
?IsFloatingPointNumber@COStringA@System@RePag@@QEAQ_NXZ ENDP
;----------------------------------------------------------------------------
?Uppercase@COStringA@System@RePag@@QEAQXXZ PROC ; COStringA::Uppercase(void)
		mov eax, dword ptr COStringA_ulLange[rcx]
		test rax, rax
		je short Ende
		xor rdx, rdx

	For_Anfang:
		cmp edx, dword ptr COStringA_ulLange[rcx]
		je short Ende
		mov r8, qword ptr COStringA_vbInhalt[rcx]
		add r8, rdx
		movzx rax, byte ptr [r8]
		cmp rax, 97
		jb short For_Ende
		cmp rax, 122
		ja short For_Ende
		sub byte ptr [r8], 32

	For_Ende:
		add rdx, 1
		jmp short For_Anfang

	Ende:
		ret
?Uppercase@COStringA@System@RePag@@QEAQXXZ ENDP
;----------------------------------------------------------------------------
?c_Str@COStringA@System@RePag@@QEAQPEADXZ PROC ; COStringA::c_Str(void)
		mov rax, qword ptr COStringA_vbInhalt[rcx]
		ret
?c_Str@COStringA@System@RePag@@QEAQPEADXZ ENDP
;----------------------------------------------------------------------------
?Length@COStringA@System@RePag@@QEAQKXZ PROC ; COStringA::Length(void)
		mov eax, dword ptr COStringA_ulLange[rcx]
		ret
?Length@COStringA@System@RePag@@QEAQKXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 8
sdi_ulLange = 8 + s_push
?SetLength@COStringA@System@RePag@@QEAQXK@Z PROC ; COStringA::SetLength(ulStrLange)
		push rbp
		sub rsp, s_ShadowRegister

		mov rbp, rcx
		mov dword ptr sdi_ulLange[rsp], edx

		mov rax, qword ptr COStringA_vbInhalt[rbp]
		test rax, rax
    je short Freigeben_Kopie
    mov rdx, qword ptr COStringA_vbInhalt[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)
    mov rax, qword ptr COStringA_vbInhalt[rbp]
    cmp rax, qword ptr COStringA_vbInhalt_A[rbp]
    je short Freigeben_Ende

  Freigeben_Kopie:
		mov rax, qword ptr COStringA_vbInhalt_A[rbp]
    test rax, rax
    je short Freigeben_Ende
    mov rdx, qword ptr COStringA_vbInhalt_A[rbp]
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Freigeben_Ende:
		mov edx, dword ptr sdi_ulLange[rsp]
		mov dword ptr COStringA_ulLange[rbp], edx
		mov dword ptr COStringA_ulLange_A[rbp], edx

		test rdx, rdx
		je short Inhalt_Null
		add rdx, 1
    mov rcx, qword ptr COStringA_vmSpeicher[rbp]
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov edx, dword ptr sdi_ulLange[rsp]
		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax
		add rax, rdx
		xor dl, dl
		mov byte ptr [rax], dl
		jmp short Ende

	Inhalt_Null:
	  xor rax, rax
		mov qword ptr COStringA_vbInhalt[rbp], rax
		mov qword ptr COStringA_vbInhalt_A[rbp], rax

	Ende:
		add rsp, s_ShadowRegister
		pop rbp
		ret
?SetLength@COStringA@System@RePag@@QEAQXK@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OStringA ENDS
END
