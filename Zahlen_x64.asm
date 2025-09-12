INCLUDE listing.inc

INCLUDE ..\..\Include\CompSys_x64.inc
INCLUDE ..\..\Include\ADT_x64.inc
INCLUDELIB OLDNAMES

EXTRN ?__LONGtoCHAR@@YQXQEADJ@Z:PROC        ; __LONGzuCAHR
EXTRN ?__LONGLONGtoCHAR@@YQXQEAD_J@Z:PROC   ; __LONGLONGtoCHAR

.DATA
dqd_Zehn DQ 10.0
dqd_Funf DQ 5.0
dqd_Null DQ 0.0
dqd_Eins DQ 1.0
dqd_MinusFunf DQ -5.0
dqd_MinusEins DQ -1.0

ddf_MinusEins DD -1.0
ddf_Eins DD 1.0
ddf_Zehn DD 10.0

ddf_Null_2 DD 100.0
ddf_Null_3 DD 1000.0
ddf_Null_4 DD 10000.0
ddf_Null_5 DD 100000.0
ddf_Null_6 DD 1000000.0
ddf_Null_7 DD 10000000.0
ddf_Null_8 DD 100000000.0

ddf_Neun_1 DD 94900000.0
ddf_Neun_2 DD 99490000.0
ddf_Neun_3 DD 99949000.0
ddf_Neun_4 DD 99994900.0
ddf_Neun_5 DD 99999490.0
ddf_Neun_6 DD 99999945.0
ddf_Neun_7 DD 99999994.0

dqi_llEins DQ 1
dqd_NullEins DQ 0.1

dqd_Null_2 DQ 100.0
dqd_Null_3 DQ 1000.0
dqd_Null_4 DQ 10000.0
dqd_Null_5 DQ 100000.0
dqd_Null_6 DQ 1000000.0
dqd_Null_7 DQ 10000000.0
dqd_Null_8 DQ 100000000.0
dqd_Null_9 DQ 1000000000.0
dqd_Null_10 DQ 10000000000.0
dqd_Null_11 DQ 100000000000.0
dqd_Null_12 DQ 1000000000000.0
dqd_Null_13 DQ 10000000000000.0
dqd_Null_14 DQ 100000000000000.0
dqd_Null_15 DQ 1000000000000000.0
dqd_Null_16 DQ 10000000000000000.0

dqd_Neun_1 DQ 9400000000000000.0
dqd_Neun_2 DQ 9940000000000000.0
dqd_Neun_3 DQ 9994000000000000.0
dqd_Neun_4 DQ 9999400000000000.0
dqd_Neun_5 DQ 9999940000000000.0
dqd_Neun_6 DQ 9999994000000000.0
dqd_Neun_7 DQ 9999999400000000.0
dqd_Neun_8 DQ 9999999940000000.0
dqd_Neun_9 DQ 9999999994000000.0
dqd_Neun_10 DQ 9999999999400000.0
dqd_Neun_11 DQ 9999999999940000.0
dqd_Neun_12 DQ 9999999999994000.0
dqd_Neun_13 DQ 9999999999999400.0
dqd_Neun_14 DQ 9999999999999940.0
dqd_Neun_15 DQ 9999999999999994.0

CS_ZahlZuString SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
so11_cVorKomma = 60 + s_push
so11_cNachKomma = 49 + s_push
sbi_ucNachKommaStellen = 48 + s_push
sdi_dwMXCSR = 44 + s_push
sdi_dwMXCSR_Alt = 40 + s_push
?Comma4toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4@12@E@Z PROC ; Comma4toCHAR(pc20Number[20], pk4Number, ucPositions)
    push rbx
    push rsi
    push rdi
    sub rsp, s_ShadowRegister

    mov rsi, rcx ; pcZahl[20]
    mov rdi, rdx ; pk4Zahl

    movsx rax, word ptr COComma4_sNachKomma[rdi]

    ;mov bl, byte ptr a_ucStellen[rsp]
		mov rbx, r8
    test rbx, rbx
    jz Stellen_4
    cmp rbx, 4
    jae Stellen_4

    xor rdx, rdx ; bNull = false

    cmp rbx, 2 ; ucStellen
    ja short Stellen_3
    jb short Stellen_1
    
    ; ucStellen = 2
    mov byte ptr sbi_ucNachKommaStellen[rsp], 9
    cmp rax, 9950
    jge short VorKommaPlusMinus
    cmp rax, -9950
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_1:
    mov byte ptr sbi_ucNachKommaStellen[rsp], 10
    cmp rax, 9500
    jge short VorKommaPlusMinus
    cmp rax, -9500
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_3:
    mov byte ptr sbi_ucNachKommaStellen[rsp], 8
    cmp rax, 9995
    jge short VorKommaPlusMinus
    cmp rax, -9995
    jle short VorKommaPlusMinus
    jmp short Runden    

  VorKommaPlusMinus:
    xor rax, rax ; sNachKomma
    mov rdx, 1 ; bNull

		mov r8d, dword ptr COComma4_lVorKomma[rdi]
		test r8, r8
    jge short VorKommaPlus
    sub dword ptr COComma4_lVorKomma[rdi], 1
    jmp short Runden
  VorKommaPlus:
    add dword ptr COComma4_lVorKomma[rdi], 1

  Runden:
    test rdx, rdx ; bNull
    jne Runden_Ende

    mov rdx, 10 ; Faktor
    cmp rbx, 3 ; ucStellen
    je short NachKomma
    imul dx, 10
    cmp rbx, 2
    je short NachKomma
    imul dx, 10

  NachKomma:
    vcvtsi2sd xmm2, xmm2, edx ; sFaktor

    vstmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_dwMXCSR[rsp]
    or dword ptr sdi_dwMXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_dwMXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, eax ; sNachKomma
    vmovsd xmm1, xmm1, xmm0
    vdivsd xmm0, xmm0, xmm2
    vcvttsd2si eax, xmm0
    vcvtsi2sd xmm0, xmm0, eax
    vmulsd xmm0, xmm0, xmm2
    vsubsd xmm1, xmm1, xmm0
    vdivsd xmm2, xmm2, dqd_Zehn
    vdivsd xmm1, xmm1, xmm2

    vcomisd xmm1, dqd_Null
    je short EndeRunden
    vcomisd xmm1, dqd_Funf
    jb short Minus5
    vcvtsi2sd xmm0, xmm0, eax
    vaddsd xmm0, xmm0, dqd_Eins
    vcvttsd2si eax, xmm0 
    jmp short EndeRunden

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    vcvtsi2sd xmm0, xmm0, eax
    vsubsd xmm0, xmm0, dqd_Eins
    vcvttsd2si eax, xmm0 

  EndeRunden:
    vldmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]

  Runden_Ende:
    movsx rdx, ax ; sNachKomma
    lea rcx, so11_cNachKomma[rsp]
    call ?__LONGtoCHAR@@YQXQEADJ@Z ; __LongzuCHAR(pc11Zahl, lZahl)
    jmp short Lange

  Stellen_4:
    movsx rdx, ax ; sNachKomma
    lea rcx, so11_cNachKomma[rsp]
    call ?__LONGtoCHAR@@YQXQEADJ@Z ; __LongzuCHAR(pc11Zahl, lZahl)
    mov byte ptr sbi_ucNachKommaStellen[rsp], 7

  Lange:
    movzx rax, byte ptr sbi_ucNachKommaStellen[rsp] 
    mov rbx, 11 ; ucLange
    sub rbx, rax

    mov edx, dword ptr COComma4_lVorKomma[rdi]
    lea rcx, so11_cVorKomma[rsp]
    call ?__LONGtoCHAR@@YQXQEADJ@Z ; __LongzuCHAR(pc11Zahl, lZahl)

    xor rdx, rdx ; ucVorKommaStellen
  while_1:
    movsx rax, byte ptr so11_cVorKomma[rsp + rdx]
    cmp rax, 48
    jne short while_1_Ende
    add rdx, 1
    cmp rdx, 11
    jb short while_1
    sub rdx, 2
  while_1_Ende:
    add rdx, 1

    mov rcx, 11
    sub rcx, rdx ; ucVorKommaStellen
    add bl, cl ; ucLange

    cmp rdx, 2 ; ucVorKommaStellen
    jae short VorKomma_5
    add rbx, 3 ; ucLange
    jmp short VorKomma_Ende
  VorKomma_5:
    cmp rdx, 5
    jae short VorKomma_8
    add rbx, 2
    jmp short VorKomma_Ende
  VorKomma_8:
    cmp rdx, 8
    jae short VorKomma_Ende
    add rbx, 1

  VorKomma_Ende:
    add rbx, 1 ; ucLange

    cmp byte ptr so11_cVorKomma[rsp + 10], 0
    je short Vor_Nach_Komma_0
    cmp byte ptr so11_cNachKomma[rsp + 10], 0
    je short Vor_Nach_Komma_0
    jmp short Zahl
  Vor_Nach_Komma_0:
    add rbx, 1

  Zahl:
    mov dword ptr [rsi + rbx], 0 ; pcZahl[ucLange] = 0

    mov rcx, 11
    sub cl, byte ptr sbi_ucNachKommaStellen[rsp]
    sub rbx, rcx ; ucLange

    movzx rdi, byte ptr sbi_ucNachKommaStellen[rsp]
    sub rdi, 1 
		mov r8, 10
		sub r8, rdi
    lea rdx, so11_cNachKomma[rsp + rdi]
    lea rcx, [rsi + rbx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

    sub rbx, 1
    mov byte ptr [rsi + rbx], 2ch ; pcZahl[--ucLange] = 2ch

    mov rdi, 9 ; ucVorKommaStellen

    cmp byte ptr so11_cVorKomma[rsp + 10], 0
    je short Zahl_1
    cmp byte ptr so11_cNachKomma[rsp + 10], 0
    je short Zahl_1
    jmp short Zahl_2

  Zahl_1:
    mov byte ptr [rsi], 2dh ; pcZahl[0] = 2dh
    
  while_2:
    sub rbx, 1 ; ucLange
    test rbx, rbx
    je short Ende

    cmp rdi, 6 ; ucVorKommaStellen
    je short Zahl_1a
    cmp rdi, 3
    je short Zahl_1a
    test rdi, rdi
    je short Zahl_1a
    jmp short Zahl_1b

  Zahl_1a:
    mov byte ptr [rsi + rbx], 2eh ; pcZahl[ucLange--] = 2eh
    sub rbx, 1 ; ucLange

  Zahl_1b:
		mov r8, 1
    lea rdx, so11_cVorKomma[rsp + rdi]
    sub rdi, 1 ; ucVorKommaStellen
    lea rcx, [rsi + rbx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short while_2

  Zahl_2:
    test rbx, rbx ; ucLange
    je short Ende
    sub rbx, 1

    cmp rdi, 6 ; ucVorKommaStellen
    je short Zahl_2a
    cmp rdi, 3
    je short Zahl_2a
    test rdi, rdi
    je short Zahl_2a
    jmp short Zahl_2b

  Zahl_2a:
    mov byte ptr [rsi + rbx], 2eh ; pcZahl[ucLange--] = 2eh
    sub rbx, 1

  Zahl_2b:
		mov r8, 1
    lea rdx, so11_cVorKomma[rsp + rdi]
    sub rdi, 1 ; ucVorKommaStellen
    lea rcx, [rsi + rbx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short Zahl_2

  Ende:
    lea rax, [rsi] ; pcZahl
    add rsp, s_ShadowRegister
    pop rdi
    pop rsi
    pop rbx
    ret
?Comma4toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4@12@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
s_push = 24
s_Bytes = 32
so20_cVorKomma = 0 + s_ShadowRegister
so11_cNachKomma = 49 + s_push + s_Bytes
sbi_ucNachKommaStellen = 48 + s_push + s_Bytes
sdi_dwMXCSR = 44 + s_push + s_Bytes
sdi_dwMXCSR_Alt = 40 + s_push + s_Bytes
?Comma4_80toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4_80@12@E@Z PROC ; Comma4_80toCHAR(pc32Number[32], pk4_80Number, ucPositions)
    push rbx
    push rsi
    push rdi
    sub rsp, s_ShadowRegister + s_Bytes

    mov rsi, rcx ; pc32Zahl
    lea rdi, [rdx]; pk4_80Zahl

    movsx rax, word ptr COComma4_80_sNachKomma[rdi]

		mov rbx, r8
    test rbx, rbx
    jz Stellen_4
    cmp rbx, 4
    jae Stellen_4

    xor rdx, rdx ; bNull = false

    cmp rbx, 2 ; ucStellen
    ja short Stellen_3
    jb short Stellen_1
    
    ; ucStellen = 2
    mov byte ptr sbi_ucNachKommaStellen[rsp], 9
    cmp rax, 9950
    jge short VorKommaPlusMinus
    cmp rax, -9950
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_1:
    mov byte ptr sbi_ucNachKommaStellen[rsp], 10
    cmp rax, 9500
    jge short VorKommaPlusMinus
    cmp rax, -9500
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_3:
    mov byte ptr sbi_ucNachKommaStellen[rsp], 8
    cmp rax, 9995
    jge short VorKommaPlusMinus
    cmp rax, -9995
    jle short VorKommaPlusMinus
    jmp short Runden  

  VorKommaPlusMinus:
    cmp	qword ptr COComma4_80_llVorKomma[rdi + 4], 0
	  jl short VorKommaMinus
	  jg short VorKommaPlus
	  cmp	dword ptr COComma4_80_llVorKomma[rdi], 0
	  jb short VorKommaMinus
  VorKommaPlus:
	  mov	eax, dword ptr COComma4_80_llVorKomma[rdi]
	  add	rax, 1
	  mov	ecx, dword ptr COComma4_80_llVorKomma[rdi + 4]
	  adc	rcx, 0
	  mov	dword ptr COComma4_80_llVorKomma[rdi], eax
	  mov	dword ptr COComma4_80_llVorKomma[rdi + 4], ecx
	  jmp	SHORT VorKomma_Ende
  VorKommaMinus:
	  mov	edx, dword ptr COComma4_80_llVorKomma[rdi]
	  sub	rdx, 1
	  mov	eax, dword ptr COComma4_80_llVorKomma[rdi + 4]
	  sbb	rax, 0
	  mov	dword ptr COComma4_80_llVorKomma[rdi], edx
	  mov	dword ptr COComma4_80_llVorKomma[rdi + 4], eax
  VorKomma_Ende:
    xor rax, rax ; sNachKomma
    mov rdx, 1 ; bNull = true

  Runden:
    test rdx, rdx ; bNull
    jne Runden_Ende

    mov rdx, 10 ; Faktor
    cmp rbx, 3 ; ucStellen
    je short NachKomma
    imul dx, 10
    cmp rbx, 2
    je short NachKomma
    imul dx, 10

  NachKomma:
    vcvtsi2sd xmm2, xmm2, rdx ; sFaktor

    vstmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_dwMXCSR[rsp]
    or dword ptr sdi_dwMXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_dwMXCSR[rsp]

    vcvtsi2sd xmm0, xmm0, rax ; sNachKomma
    vmovsd xmm1, xmm1, xmm0
    vdivsd xmm0, xmm0, xmm2
    vcvttsd2si rax, xmm0
    vcvtsi2sd xmm0, xmm0, rax
    vmulsd xmm0,xmm0, xmm2
    vsubsd xmm1, xmm1, xmm0
    vdivsd xmm2, xmm2, dqd_Zehn
    vdivsd xmm1, xmm1, xmm2

    vcomisd xmm1, dqd_Null
    je short EndeRunden
    comisd xmm1, dqd_Funf
    jb short Minus5
    vcvtsi2sd xmm0, xmm0, rax
    vaddsd xmm0, xmm0, dqd_Eins
    vcvttsd2si rax, xmm0 
    jmp short EndeRunden

  Minus5:
    vcomisd xmm1, dqd_MinusFunf
    ja short EndeRunden
    vcvtsi2sd xmm0, xmm0, rax
    vsubsd xmm0, xmm0, dqd_Eins
    vcvttsd2si rax, xmm0 

  EndeRunden:
    vldmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]

  Runden_Ende:
    movsx rdx, ax ; sNachKomma
    lea rcx, so11_cNachKomma[rsp]
    call ?__LONGtoCHAR@@YQXQEADJ@Z ;  __LONGzuCAHR(pc11Zahl, lZahl)
    jmp short Lange

  Stellen_4:
    movsx rdx, ax ; sNachKomma
    lea rcx, so11_cNachKomma[rsp]
    call ?__LONGtoCHAR@@YQXQEADJ@Z ;  __LONGzuCAHR(pc11Zahl, lZahl)
    mov byte ptr sbi_ucNachKommaStellen[rsp], 7

  Lange:
    movzx rax, byte ptr sbi_ucNachKommaStellen[rsp] 
    mov rbx, 11 ; ucLange
    sub rbx, rax

		mov	rdx, qword ptr COComma4_80_llVorKomma[rdi]
	  lea	rcx, so20_cVorKomma[rsp]
	  call ?__LONGLONGtoCHAR@@YQXQEAD_J@Z ; __LONGLONGtoCHAR(pc20Zahl, llZahl)

    xor rdx, rdx ; ucVorKommaStellen
  while_1:
    movsx rax, byte ptr so20_cVorKomma[rsp + rdx]
    cmp rax, 48
    jne short while_1_Ende
    add rdx, 1
    cmp rdx, 20
    jb short while_1
    sub rdx, 2
  while_1_Ende:
    add rdx, 1

    mov rcx, 20
    sub rcx, rdx ; ucVorKommaStellen
    add bl, cl ; ucLange

    cmp rdx, 2
    jae Lange_5
    add rbx, 6
    jmp Lange_Ende
  Lange_5:
    cmp rdx, 5
    jae Lange_8
    add rbx, 5
    jmp Lange_Ende
  Lange_8:
    cmp rdx, 8
    jae Lange_11
    add rbx, 4
    jmp Lange_Ende
  Lange_11:
    cmp rdx, 11
    jae Lange_14
    add rbx, 3
    jmp Lange_Ende
  Lange_14:
    cmp rdx, 14
    jae Lange_17
    add rbx, 2
    jmp Lange_Ende
  Lange_17:
    cmp rdx, 17
    jae Lange_Ende
    add rbx, 1

  Lange_Ende:
    add rbx, 1 ; ucLange

    cmp byte ptr so20_cVorKomma[rsp + 19], 0
    je short Vor_Nach_Komma_0
    cmp byte ptr so11_cNachKomma[rsp + 10], 0
    je short Vor_Nach_Komma_0
    jmp short Zahl
  Vor_Nach_Komma_0:
    add rbx, 1

  Zahl:
    mov dword ptr [rsi + rbx], 0 ; pc32Zahl[ucLange] = 0

    mov rcx, 11
    sub cl, byte ptr sbi_ucNachKommaStellen[rsp]
    sub rbx, rcx ; ucLange

    movzx rdi, byte ptr sbi_ucNachKommaStellen[rsp]
    sub rdi, 1 
		mov r8, 10
		sub r8, rdi
    lea rdx, so11_cNachKomma[rsp + rdi]
    lea rcx, [rsi + rbx] ; pc32Zahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

    sub rbx, 1
    mov byte ptr [rsi + rbx], 2ch ; pc32Zahl[--ucLange] = 2ch

    mov rdi, 18 ; ucVorKommaStellen

    cmp byte ptr so20_cVorKomma[rsp + 19], 0
    je short Zahl_1
    cmp byte ptr so11_cNachKomma[rsp + 10], 0
    je short Zahl_1
    jmp short Zahl_2

  Zahl_1:
    mov byte ptr [rsi], 2dh ; pc32Zahl[0] = 2dh
    
  while_2:
    sub rbx, 1 ; ucLange
    test rbx, rbx
    je Ende

    cmp rdi, 15 ; ucVorKommaStellen
    je short Zahl_1a
    cmp rdi, 12 
    je short Zahl_1a
    cmp rdi, 9 
    je short Zahl_1a
    cmp rdi, 6 
    je short Zahl_1a
    cmp rdi, 3
    je short Zahl_1a
    test rdi, rdi
    je short Zahl_1a
    jmp short Zahl_1b

  Zahl_1a:
    mov byte ptr [rsi + rbx], 2eh ; pc32Zahl[ucLange--] = 2eh
    sub rbx, 1 ; ucLange

  Zahl_1b:
		mov r8, 1
    lea rdx, so20_cVorKomma[rsp + rdi]
    sub rdi, 1 ; ucVorKommaStellen
    lea rcx, [rsi + rbx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short while_2

  Zahl_2:
    test rbx, rbx ; ucLange
    je short Ende
    sub rbx, 1

    cmp rdi, 15 ; ucVorKommaStellen
    je short Zahl_2a
    cmp rdi, 12 
    je short Zahl_2a
    cmp rdi, 9 
    je short Zahl_2a
    cmp rdi, 6 
    je short Zahl_2a
    cmp rdi, 3
    je short Zahl_2a
    test rdi, rdi
    je short Zahl_2a
    jmp short Zahl_2b

  Zahl_2a:
    mov byte ptr [rsi + rbx], 2eh ; pc32Zahl[ucLange--] = 2eh
    sub rbx, 1

  Zahl_2b:
		mov r8, 1
    lea rdx, so20_cVorKomma[rsp + rdi]
    sub rdi, 1 ; ucVorKommaStellen
    lea rcx, [rsi + rbx] ; pc32Zahl[ucLange]
    call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short Zahl_2

  Ende:
    lea rax, qword ptr [rsi]
    add rsp, s_ShadowRegister + s_Bytes
    pop rdi
    pop rsi
    pop rbx
    ret
?Comma4_80toCHAR@System@RePag@@YQPEADQEADPEAVCOComma4_80@12@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
;s_Bytes = 16
;sdi_dwMXCSR = 4
;sdi_dwMXCSR_Alt = 0
sdi_dwMXCSR = 12
sdi_dwMXCSR_Alt = 8
abi_ucStellen = 40 ;+ s_Bytes
?__DOUBLE_B10toCHAR@@YQXAEAF0NAEA_JE@Z PROC ; __DOUBLE_B10toCHAR((&sExponent, &sVorKomma, dZahl, &llNachKomma, ucStellen)
    ;sub rsp, s_Bytes

    mov r10, rcx
    mov r11, rdx

    vstmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_dwMXCSR[rsp]
    or dword ptr sdi_dwMXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_dwMXCSR[rsp]

    xor rcx, rcx
    vxorpd xmm1, xmm1, xmm1
    vcomisd xmm0, xmm1
    ja short Init
    vmovq xmm1, dqd_MinusEins
    vmulsd xmm0, xmm0, xmm1

  Init:
    vmovq xmm1, dqd_Eins
    vmovq xmm2, dqd_Zehn

  Exponent_Minus:
    vcomisd xmm0, xmm1
    jae short Exponent
    sub cx, 1
    vmulsd xmm0, xmm0, xmm2
    jmp short Exponent_Minus

  Exponent:
    vcomisd xmm0, xmm2
    jb short Komma

  Exponent_Plus:
    add cx, 1
    vdivsd xmm0, xmm0, xmm2
    vcomisd xmm0, xmm2
    ja short Exponent_Plus

  Komma:
    mov word ptr [r10], cx
    vcvttsd2si r8d, xmm0
    mov word ptr [r11], r8w
    vcvtsi2sd xmm1, xmm1, r8d
    vsubsd xmm0, xmm0, xmm1
    movq xmm1, dqd_Null_16
    vmulsd xmm0, xmm0, xmm1

    vcvtsd2si rax, xmm0
    vmovq xmm3, rax

		movzx r8, byte ptr abi_ucStellen[rsp]
    test r8, r8
    je Ende
    cmp r8, 16
    jae Ende

    vcvtsi2sd xmm0, xmm0, rax

    cmp r8, 7
    jb short Stellen_4
    ja Stellen_11
    vcomisd xmm0, dqd_Neun_7
    ja VorKomma
    vmovq xmm2, dqd_Null_9
    jmp Runden

  Stellen_4:
    cmp r8, 4
    jb short Stellen_2
    ja short Stellen_6
    vcomisd xmm0, dqd_Neun_4
    ja VorKomma
    movq xmm2, dqd_Null_12
    jmp Runden

  Stellen_2:
    cmp r8, 2
    jb short Stellen_1
    ja short Stellen_3
    vcomisd xmm0, dqd_Neun_2
    ja VorKomma
    movq xmm2, dqd_Null_14
    jmp Runden

  Stellen_1:
    vcomisd xmm0, dqd_Neun_1
    ja VorKomma
    vmovq xmm2, dqd_Null_15
    jmp Runden

  Stellen_3:
    vcomisd xmm0, dqd_Neun_3
    ja VorKomma
    vmovq xmm2, dqd_Null_13
    jmp Runden

  Stellen_6:
    cmp r8, 6
    jb short Stellen_5
    vcomisd xmm0, dqd_Neun_6
    ja VorKomma
    vmovq xmm2, dqd_Null_10
    jmp Runden

  Stellen_5:
    vcomisd xmm0, dqd_Neun_5
    ja VorKomma
    vmovq xmm2, dqd_Null_11
    jmp Runden

  Stellen_11:
    cmp r8, 11
    jb short Stellen_9
    ja short Stellen_13
    vcomisd xmm0, dqd_Neun_11
    ja VorKomma
    vmovq xmm2, dqd_Null_5
    jmp Runden

  Stellen_9:
    cmp r8, 9
    jb short Stellen_8
    ja short Stellen_10
    vcomisd xmm0, dqd_Neun_9
    ja VorKomma
    vmovq xmm2, dqd_Null_7
    jmp Runden

  Stellen_8:
    vcomisd xmm0, dqd_Neun_8
    ja VorKomma
    vmovq xmm2, dqd_Null_8
    jmp Runden

  Stellen_10:
    vcomisd xmm0, dqd_Neun_10
    ja short VorKomma
    vmovq xmm2, dqd_Null_6
    jmp Runden

  Stellen_13:
    cmp r8, 13
    jb short Stellen_12
    ja short Kleiner_15
    vcomisd xmm0, dqd_Neun_13
    ja short VorKomma
    vmovq xmm2, dqd_Null_3
    jmp Runden

  Stellen_12:
    vcomisd xmm0, dqd_Neun_12
    ja short VorKomma
    vmovq xmm2, dqd_Null_4
    jmp short Runden

  Kleiner_15:
    cmp r8, 15
    jb short Kleiner_14
    vcomisd xmm0, dqd_Neun_15
    ja short VorKomma
    vaddsd xmm0, xmm9, dqd_NullEins
    vmovq xmm2, dqd_Zehn
    jmp short Runden

  Kleiner_14:
    vcomisd xmm0, dqd_Neun_14
    ja short VorKomma
    vmovq xmm2, dqd_Null_2
    jmp short Runden

  VorKomma:
    vxorpd xmm3, xmm3, xmm3
    movzx rdx, word ptr [r11]
    cmp rdx, 9
    jae short VorKommaGrosser
    add rdx, 1
    mov word ptr [r11], dx
    jmp Ende

  VorKommaGrosser:
    mov rdx, 1
    mov word ptr [r11], dx
    movzx ecx, word ptr [r10]
    add ecx, 1
    mov word ptr [r10], cx
    jmp Ende

  Runden:
    vmovsd xmm1, xmm1, xmm0
    vdivsd xmm0, xmm0, xmm2

    vcvttsd2si rax, xmm0
    vmovq xmm3, rax
    vcvtsi2sd xmm0, xmm0, rax

    vmulsd xmm0, xmm0, xmm2
    vsubsd xmm1, xmm1, xmm0
    vdivsd xmm2, xmm2, dqd_Zehn
    vdivsd xmm1, xmm1, xmm2

    vaddsd xmm1, xmm1, dqd_NullEins ; Korrektur Runden
    vcvttsd2si eax, xmm1

    test eax, eax
    je short Ende
    cmp eax, 5
    jb short Ende
    vmovq xmm2, dqi_llEins
    vpaddq xmm3, xmm3, xmm2

  Ende:
    vmovq qword ptr [r9], xmm3

    vldmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    ;add rsp, s_Bytes
    ret
?__DOUBLE_B10toCHAR@@YQXAEAF0NAEA_JE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
;s_Bytes = 16
;sdi_dwMXCSR = 4
;sdi_dwMXCSR_Alt = 0
sdi_dwMXCSR = 12
sdi_dwMXCSR_Alt = 8
abi_ucStellen = 40 ;+ s_Bytes
?__FLOAT_B10zuCHAR@@YQXAEAF0MAEAJE@Z PROC ; __FLOAT_B10zuCHAR(&Exponent, &sVorKomma, &lNachKomma, &fZahl, &ucStellen)
    ;sub rsp, s_Bytes

    mov r10, rcx
    mov r11, rdx

    vstmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    vstmxcsr dword ptr sdi_dwMXCSR[rsp]
    or dword ptr sdi_dwMXCSR[rsp], 6000h
    vldmxcsr dword ptr sdi_dwMXCSR[rsp]

    xor rcx, rcx
    vxorps xmm1, xmm1, xmm1
    vcomiss xmm0, xmm1
    ja short Init
    vmovd xmm1, ddf_MinusEins
    vmulss xmm0, xmm0, xmm1

  Init:
    vmovd xmm1, ddf_Eins
    vmovd xmm2, ddf_Zehn

  Exponent_Minus:
    vcomiss xmm0, xmm1
    jae short Exponent
    sub cx, 1
    vmulss xmm0, xmm0, xmm2
    jmp short Exponent_Minus

  Exponent:
    vcomiss xmm0, xmm2
    jb short Komma

  Exponent_Plus:
    add cx, 1
    vdivss xmm0, xmm0, xmm2
    vcomiss xmm0, xmm2
    ja short Exponent_Plus

  Komma:
    mov word ptr [r10], cx
    vcvttss2si eax, xmm0
    mov word ptr [r11], ax
    vcvtsi2ss xmm1, xmm1, eax
    vsubss xmm0, xmm0, xmm1
    vmovd xmm1, ddf_Null_8
    vmulss xmm0, xmm0, xmm1
    vcvttss2si edx, xmm0

    movzx rax, byte ptr abi_ucStellen[rsp]
    test rax, rax
    je Ende
    cmp rax, 8
    jae Ende

    vcvtsi2ss xmm0, xmm0, edx

    cmp rax, 4
    jb short Stellen_2
    ja short Stellen_6
    vcomiss xmm0, ddf_Neun_4
    ja VorKomma
    vmovd xmm2, ddf_Null_4
    jmp Runden

  Stellen_2:
    cmp rax, 2
    jb short Stellen_1
    ja short Stellen_3
    vcomiss xmm0, ddf_Neun_2
    ja VorKomma
    vmovd xmm2, ddf_Null_6
    jmp Runden

  Stellen_1:
    vcomiss xmm0, ddf_Neun_1
    ja short VorKomma
    vmovd xmm2, ddf_Null_7
    jmp Runden

  Stellen_3:
    vcomiss xmm0, ddf_Neun_3
    ja short VorKomma
    vmovd xmm2, ddf_Null_5
    jmp short Runden

  Stellen_6:
    cmp rax, 6
    jb short Stellen_5
    ja short Stellen_7
    vcomiss xmm0, ddf_Neun_6
    ja short VorKomma
    vmovd xmm2, ddf_Null_2
    jmp short Runden

  Stellen_5:
    vcomiss xmm0, ddf_Neun_5
    ja short VorKomma
    vmovd xmm2, ddf_Null_3
    jmp short Runden

  Stellen_7:
    cmp rax, 7
    vcomiss xmm0, ddf_Neun_7
    ja short VorKomma
    vmovd xmm2, ddf_Zehn
    jmp short Runden

  VorKomma:
    xor rdx, rdx
    movzx rcx, word ptr [r11]
    cmp ecx, 9
    jae short VorKommaGrosser
    add rcx, 1
    mov word ptr [r11], cx
    jmp short Ende

  VorKommaGrosser:
    mov rcx, 1
    mov word ptr [r11], cx
    movzx rcx, word ptr [r10]
    add rcx, 1
    mov word ptr [r10], cx
    jmp short Ende

  Runden:
    vmovss xmm1, xmm1, xmm0
    vdivss xmm0, xmm0, xmm2

    vcvttss2si edx, xmm0
    vcvtsi2ss xmm0, xmm0, edx

    vmulss xmm0, xmm0, xmm2
    vsubss xmm1, xmm1, xmm0
    vdivss xmm2, xmm2, ddf_Zehn
    vdivss xmm1, xmm1, xmm2

    vcvttss2si eax, xmm1

    test eax, eax
    je short Ende
    cmp eax, 5
    jb short Ende
    add rdx, 1

  Ende:
    mov dword ptr [r9], edx

    vldmxcsr dword ptr sdi_dwMXCSR_Alt[rsp]
    ;add rsp, s_Bytes
    ret
?__FLOAT_B10zuCHAR@@YQXAEAF0MAEAJE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_ZahlZuString ENDS
;----------------------------------------------------------------------------
END
