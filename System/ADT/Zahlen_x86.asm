;****************************************************************************
;  Zahlen_x86.asm
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
INCLUDE listing.inc
INCLUDE ..\..\Include\CompSys.inc
INCLUDE ..\..\Include\ADT.inc
.MODEL FLAT
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

EXTRN ?__LONGtoCHAR@@YQXQADJ@Z:PROC        ; __LONGzuCAHR
EXTRN ?__LONGLONGtoCHAR@@YQXQAD_J@Z:PROC   ; __LONGLONGtoCHAR

.DATA
sNull WORD 0
sEins WORD 1
sFunf WORD 5
sMinusFunf WORD -5
sZehn WORD 10
dZehn DQ 10.0
dFunf DQ 5.0
dNull DQ 0.0
dEins DQ 1.0
dMinusFunf DQ -5.0
dMinusEins DQ -1.0

fMinusEins DD -1.0
fEins DD 1.0
fZehn DD 10.0

fNull_2 DD 100.0
fNull_3 DD 1000.0
fNull_4 DD 10000.0
fNull_5 DD 100000.0
fNull_6 DD 1000000.0
fNull_7 DD 10000000.0
fNull_8 DD 100000000.0

fNeun_1 DD 94900000.0
fNeun_2 DD 99490000.0
fNeun_3 DD 99949000.0
fNeun_4 DD 99994900.0
fNeun_5 DD 99999490.0
fNeun_6 DD 99999945.0
fNeun_7 DD 99999994.0

llEins DQ 1
dNullEins DQ 0.1

dNull_2 DQ 100.0
dNull_3 DQ 1000.0
dNull_4 DQ 10000.0
dNull_5 DQ 100000.0
dNull_6 DQ 1000000.0
dNull_7 DQ 10000000.0
dNull_8 DQ 100000000.0
dNull_9 DQ 1000000000.0
dNull_10 DQ 10000000000.0
dNull_11 DQ 100000000000.0
dNull_12 DQ 1000000000000.0
dNull_13 DQ 10000000000000.0
dNull_14 DQ 100000000000000.0
dNull_15 DQ 1000000000000000.0
dNull_16 DQ 10000000000000000.0

dNeun_1 DQ 9400000000000000.0
dNeun_2 DQ 9940000000000000.0
dNeun_3 DQ 9994000000000000.0
dNeun_4 DQ 9999400000000000.0
dNeun_5 DQ 9999940000000000.0
dNeun_6 DQ 9999994000000000.0
dNeun_7 DQ 9999999400000000.0
dNeun_8 DQ 9999999940000000.0
dNeun_9 DQ 9999999994000000.0
dNeun_10 DQ 9999999999400000.0
dNeun_11 DQ 9999999999940000.0
dNeun_12 DQ 9999999999994000.0
dNeun_13 DQ 9999999999999400.0
dNeun_14 DQ 9999999999999940.0
dNeun_15 DQ 9999999999999994.0

CS_ZahlZuString SEGMENT EXECUTE
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 32
s_c11VorKomma = 20
s_c11NachKomma = 9
s_ucNachKommaStellen = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
a_ucStellen = esp_Bytes + 16
?Comma4toCHAR@System@RePag@@YQPADQADPAVCOComma4@12@E@Z PROC ; Comma4toCHAR(pc20Number[20], pk4Number, ucPositions)
    push ebx
    push esi
    push edi
    sub esp, esp_Bytes

    mov esi, ecx ; pcZahl[20]
    mov edi, edx ; pk4Zahl

    movsx eax, word ptr COComma4_sNachKomma[edi]

    mov bl, byte ptr a_ucStellen[esp]
    test bl, bl
    jz Stellen_4
    cmp bl, 4
    jae Stellen_4

    xor edx, edx ; bNull = false

    cmp bl, 2 ; ucStellen
    ja short Stellen_3
    jb short Stellen_1
    
    ; ucStellen = 2
    mov byte ptr s_ucNachKommaStellen[esp], 9
    cmp eax, 9950
    jge short VorKommaPlusMinus
    cmp eax, -9950
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_1:
    mov byte ptr s_ucNachKommaStellen[esp], 10
    cmp eax, 9500
    jge short VorKommaPlusMinus
    cmp eax, -9500
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_3:
    mov byte ptr s_ucNachKommaStellen[esp], 8
    cmp eax, 9995
    jge short VorKommaPlusMinus
    cmp eax, -9995
    jle short VorKommaPlusMinus
    jmp short Runden    

  VorKommaPlusMinus:
    xor eax, eax ; sNachKomma
    mov edx, 1 ; bNull

    test dword ptr COComma4_lVorKomma[edi], 0
    jge short VorKommaPlus
    sub dword ptr COComma4_lVorKomma[edi], 1
    jmp short Runden
  VorKommaPlus:
    add dword ptr COComma4_lVorKomma[edi], 1

  Runden:
    test edx, edx ; bNull
    jne Runden_Ende

    mov edx, 10 ; Faktor
    cmp bl, 3 ; ucStellen
    je short NachKomma
    imul dx, 10
    cmp bl, 2
    je short NachKomma
    imul dx, 10

  NachKomma:
    cvtsi2sd xmm2, edx ; sFaktor

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    cvtsi2sd xmm0, eax ; sNachKomma
    movsd xmm1, xmm0
    divsd xmm0, xmm2
    cvttsd2si eax, xmm0
    cvtsi2sd xmm0, eax
    mulsd xmm0, xmm2
    subsd xmm1, xmm0
    divsd xmm2, dZehn
    divsd xmm1, xmm2

    comisd xmm1, dNull
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    cvtsi2sd xmm0, eax
    addsd xmm0, dEins
    cvttsd2si eax, xmm0 
    jmp short EndeRunden

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    cvtsi2sd xmm0, eax
    subsd xmm0, dEins
    cvttsd2si eax, xmm0 

  EndeRunden:
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

  Runden_Ende:
    movsx edx, ax ; sNachKomma
    lea ecx, dword ptr s_c11NachKomma[esp]
    call ?__LONGtoCHAR@@YQXQADJ@Z ; __LongzuCHAR(pc11Zahl, lZahl)
    jmp short Lange

  Stellen_4:
    movsx edx, ax ; sNachKomma
    lea ecx, dword ptr s_c11NachKomma[esp]
    call ?__LONGtoCHAR@@YQXQADJ@Z
    mov byte ptr s_ucNachKommaStellen[esp], 7

  Lange:
    movzx eax, byte ptr s_ucNachKommaStellen[esp] 
    mov ebx, 11 ; ucLange
    sub ebx, eax

    mov edx, dword ptr COComma4_lVorKomma[edi]
    lea ecx, dword ptr s_c11VorKomma[esp]
    call ?__LONGtoCHAR@@YQXQADJ@Z ; __LongzuCHAR(pc11Zahl, lZahl)

    xor edx, edx ; ucVorKommaStellen
  while_1:
    movsx eax, byte ptr s_c11VorKomma[esp+edx]
    cmp eax, 48
    jne short while_1_Ende
    add edx, 1
    cmp edx, 11
    jb short while_1
    sub edx, 2
  while_1_Ende:
    add edx, 1

    mov ecx, 11
    sub ecx, edx ; ucVorKommaStellen
    add bl, cl ; ucLange

    cmp edx, 2 ; ucVorKommaStellen
    jae short VorKomma_5
    add ebx, 3 ; ucLange
    jmp short VorKomma_Ende
  VorKomma_5:
    cmp edx, 5
    jae short VorKomma_8
    add ebx, 2
    jmp short VorKomma_Ende
  VorKomma_8:
    cmp edx, 8
    jae short VorKomma_Ende
    add ebx, 1

  VorKomma_Ende:
    add ebx, 1 ; ucLange

    cmp byte ptr s_c11VorKomma[esp+10], 0
    je short Vor_Nach_Komma_0
    cmp byte ptr s_c11NachKomma[esp+10], 0
    je short Vor_Nach_Komma_0
    jmp short Zahl
  Vor_Nach_Komma_0:
    add ebx, 1

  Zahl:
    mov dword ptr [esi+ebx], 0 ; pcZahl[ucLange] = 0

    mov ecx, 11
    sub cl, byte ptr s_ucNachKommaStellen[esp]
    sub ebx, ecx ; ucLange

    movzx edi, byte ptr s_ucNachKommaStellen[esp]
    sub edi, 1 
    mov ecx, 10
    sub ecx, edi
    push ecx
    lea edx, dword ptr s_c11NachKomma[esp+edi+4]
    lea ecx, dword ptr [esi+ebx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

    sub ebx, 1
    mov byte ptr [esi+ebx], 2ch ; pcZahl[--ucLange] = 2ch

    mov edi, 9 ; ucVorKommaStellen

    cmp byte ptr s_c11VorKomma[esp+10], 0
    je short Zahl_1
    cmp byte ptr s_c11NachKomma[esp+10], 0
    je short Zahl_1
    jmp short Zahl_2

  Zahl_1:
    mov byte ptr [esi], 2dh ; pcZahl[0] = 2dh
    
  while_2:
    sub ebx, 1 ; ucLange
    test ebx, ebx
    je short Ende

    cmp edi, 6 ; ucVorKommaStellen
    je short Zahl_1a
    cmp edi, 3
    je short Zahl_1a
    test edi, edi
    je short Zahl_1a
    jmp short Zahl_1b

  Zahl_1a:
    mov byte ptr [esi+ebx], 2eh ; pcZahl[ucLange--] = 2eh
    sub ebx, 1 ; ucLange

  Zahl_1b:
    mov ecx, 1
    push ecx
    lea edx, dword ptr s_c11VorKomma[esp+edi+4]
    sub edi, 1 ; ucVorKommaStellen
    lea ecx, dword ptr [esi+ebx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short while_2

  Zahl_2:
    test ebx, ebx ; ucLange
    je short Ende
    sub ebx, 1

    cmp edi, 6 ; ucVorKommaStellen
    je short Zahl_2a
    cmp edi, 3
    je short Zahl_2a
    test edi, edi
    je short Zahl_2a
    jmp short Zahl_2b

  Zahl_2a:
    mov byte ptr [esi+ebx], 2eh ; pcZahl[ucLange--] = 2eh
    sub ebx, 1

  Zahl_2b:
    mov ecx, 1
    push ecx
    lea edx, dword ptr s_c11VorKomma[esp+edi+4]
    sub edi, 1 ; ucVorKommaStellen
    lea ecx, dword ptr [esi+ebx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short Zahl_2

  Ende:
    lea eax, dword ptr [esi] ; pcZahl
    add esp, esp_Bytes
    pop edi
    pop esi
    pop ebx
    ret 4
?Comma4toCHAR@System@RePag@@YQPADQADPAVCOComma4@12@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 40
s_c20VorKomma = 20
s_c11NachKomma = 9
s_ucNachKommaStellen = 8
s_dwMXCSR_Alt = 4
s_dwMXCSR = 0
a_ucStellen = esp_Bytes + 16
?Comma4_80toCHAR@System@RePag@@YQPADQADPAVCOComma4_80@12@E@Z PROC ; Comma4_80toCHAR(pc32Number[32], pk4_80Number, ucPositions)
    push ebx
    push esi
    push edi
    sub esp, esp_Bytes

    mov esi, ecx ; pc32Zahl
    lea edi, dword ptr [edx]; pk4_80Zahl

    movsx eax, word ptr COComma4_80_sNachKomma[edi]

    mov bl, byte ptr a_ucStellen[esp]
    test bl, bl
    jz Stellen_4
    cmp bl, 4
    jae Stellen_4

    xor edx, edx ; bNull = false

    cmp bl, 2 ; ucStellen
    ja short Stellen_3
    jb short Stellen_1
    
    ; ucStellen = 2
    mov byte ptr s_ucNachKommaStellen[esp], 9
    cmp eax, 9950
    jge short VorKommaPlusMinus
    cmp eax, -9950
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_1:
    mov byte ptr s_ucNachKommaStellen[esp], 10
    cmp eax, 9500
    jge short VorKommaPlusMinus
    cmp eax, -9500
    jle short VorKommaPlusMinus
    jmp short Runden

  Stellen_3:
    mov byte ptr s_ucNachKommaStellen[esp], 8
    cmp eax, 9995
    jge short VorKommaPlusMinus
    cmp eax, -9995
    jle short VorKommaPlusMinus
    jmp short Runden  

  VorKommaPlusMinus:
    cmp	dword ptr COComma4_80_llVorKomma[edi+4], 0
	  jl short VorKommaMinus
	  jg short VorKommaPlus
	  cmp	dword ptr COComma4_80_llVorKomma[edi], 0
	  jb short VorKommaMinus
  VorKommaPlus:
	  mov	eax, dword ptr COComma4_80_llVorKomma[edi]
	  add	eax, 1
	  mov	ecx, dword ptr COComma4_80_llVorKomma[edi+4]
	  adc	ecx, 0
	  mov	dword ptr COComma4_80_llVorKomma[edi], eax
	  mov	dword ptr COComma4_80_llVorKomma[edi+4], ecx
	  jmp	SHORT VorKomma_Ende
  VorKommaMinus:
	  mov	edx, dword ptr COComma4_80_llVorKomma[edi]
	  sub	edx, 1
	  mov	eax, dword ptr COComma4_80_llVorKomma[edi+4]
	  sbb	eax, 0
	  mov	dword ptr COComma4_80_llVorKomma[edi], edx
	  mov	dword ptr COComma4_80_llVorKomma[edi+4], eax
  VorKomma_Ende:
    xor eax, eax ; sNachKomma
    mov edx, 1 ; bNull = true

  Runden:
    test edx, edx ; bNull
    jne Runden_Ende

    mov edx, 10 ; Faktor
    cmp bl, 3 ; ucStellen
    je short NachKomma
    imul dx, 10
    cmp bl, 2
    je short NachKomma
    imul dx, 10

  NachKomma:
    cvtsi2sd xmm2, edx ; sFaktor

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    cvtsi2sd xmm0, eax ; sNachKomma
    movsd xmm1, xmm0
    divsd xmm0, xmm2
    cvttsd2si eax, xmm0
    cvtsi2sd xmm0, eax
    mulsd xmm0, xmm2
    subsd xmm1, xmm0
    divsd xmm2, dZehn
    divsd xmm1, xmm2

    comisd xmm1, dNull
    je short EndeRunden
    comisd xmm1, dFunf
    jb short Minus5
    cvtsi2sd xmm0, eax
    addsd xmm0, dEins
    cvttsd2si eax, xmm0 
    jmp short EndeRunden

  Minus5:
    comisd xmm1, dMinusFunf
    ja short EndeRunden
    cvtsi2sd xmm0, eax
    subsd xmm0, dEins
    cvttsd2si eax, xmm0 

  EndeRunden:
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]

  Runden_Ende:
    movsx edx, ax ; sNachKomma
    lea ecx, dword ptr s_c11NachKomma[esp]
    call ?__LONGtoCHAR@@YQXQADJ@Z ;  __LONGzuCAHR(pc11Zahl, lZahl)
    jmp short Lange

  Stellen_4:
    movsx edx, ax ; sNachKomma
    lea ecx, dword ptr s_c11NachKomma[esp]
    call ?__LONGtoCHAR@@YQXQADJ@Z ;  __LONGzuCAHR(pc11Zahl, lZahl)
    mov byte ptr s_ucNachKommaStellen[esp], 7

  Lange:
    movzx eax, byte ptr s_ucNachKommaStellen[esp] 
    mov ebx, 11 ; ucLange
    sub ebx, eax

    mov	ecx, dword ptr COComma4_80_llVorKomma[edi+4]
	  push ecx
	  mov	ecx, dword ptr COComma4_80_llVorKomma[edi]
	  push ecx
	  lea	ecx, dword ptr s_c20VorKomma[esp+8]
	  call ?__LONGLONGtoCHAR@@YQXQAD_J@Z ; __LONGLONGtoCHAR(pc20Zahl, llZahl)

    xor edx, edx ; ucVorKommaStellen
  while_1:
    movsx eax, byte ptr s_c20VorKomma[esp+edx]
    cmp eax, 48
    jne short while_1_Ende
    add edx, 1
    cmp edx, 20
    jb short while_1
    sub edx, 2
  while_1_Ende:
    add edx, 1

    mov ecx, 20
    sub ecx, edx ; ucVorKommaStellen
    add bl, cl ; ucLange

    cmp edx, 2
    jae Lange_5
    add ebx, 6
    jmp Lange_Ende
  Lange_5:
    cmp edx, 5
    jae Lange_8
    add ebx, 5
    jmp Lange_Ende
  Lange_8:
    cmp edx, 8
    jae Lange_11
    add ebx, 4
    jmp Lange_Ende
  Lange_11:
    cmp edx, 11
    jae Lange_14
    add ebx, 3
    jmp Lange_Ende
  Lange_14:
    cmp edx, 14
    jae Lange_17
    add ebx, 2
    jmp Lange_Ende
  Lange_17:
    cmp edx, 17
    jae Lange_Ende
    add ebx, 1

  Lange_Ende:
    add ebx, 1 ; ucLange

    cmp byte ptr s_c20VorKomma[esp+19], 0
    je short Vor_Nach_Komma_0
    cmp byte ptr s_c11NachKomma[esp+10], 0
    je short Vor_Nach_Komma_0
    jmp short Zahl
  Vor_Nach_Komma_0:
    add ebx, 1

  Zahl:
    mov dword ptr [esi+ebx], 0 ; pc32Zahl[ucLange] = 0

    mov ecx, 11
    sub cl, byte ptr s_ucNachKommaStellen[esp]
    sub ebx, ecx ; ucLange

    movzx edi, byte ptr s_ucNachKommaStellen[esp]
    sub edi, 1 
    mov ecx, 10
    sub ecx, edi
    push ecx
    lea edx, dword ptr s_c11NachKomma[esp+edi+4]
    lea ecx, dword ptr [esi+ebx] ; pc32Zahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

    sub ebx, 1
    mov byte ptr [esi+ebx], 2ch ; pc32Zahl[--ucLange] = 2ch

    mov edi, 18 ; ucVorKommaStellen

    cmp byte ptr s_c20VorKomma[esp+19], 0
    je short Zahl_1
    cmp byte ptr s_c11NachKomma[esp+10], 0
    je short Zahl_1
    jmp short Zahl_2

  Zahl_1:
    mov byte ptr [esi], 2dh ; pc32Zahl[0] = 2dh
    
  while_2:
    sub ebx, 1 ; ucLange
    test ebx, ebx
    je Ende

    cmp edi, 15 ; ucVorKommaStellen
    je short Zahl_1a
    cmp edi, 12 
    je short Zahl_1a
    cmp edi, 9 
    je short Zahl_1a
    cmp edi, 6 
    je short Zahl_1a
    cmp edi, 3
    je short Zahl_1a
    test edi, edi
    je short Zahl_1a
    jmp short Zahl_1b

  Zahl_1a:
    mov byte ptr [esi+ebx], 2eh ; pc32Zahl[ucLange--] = 2eh
    sub ebx, 1 ; ucLange

  Zahl_1b:
    mov ecx, 1
    push ecx
    lea edx, dword ptr s_c20VorKomma[esp+edi+4]
    sub edi, 1 ; ucVorKommaStellen
    lea ecx, dword ptr [esi+ebx] ; pcZahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short while_2

  Zahl_2:
    test ebx, ebx ; ucLange
    je short Ende
    sub ebx, 1

    cmp edi, 15 ; ucVorKommaStellen
    je short Zahl_2a
    cmp edi, 12 
    je short Zahl_2a
    cmp edi, 9 
    je short Zahl_2a
    cmp edi, 6 
    je short Zahl_2a
    cmp edi, 3
    je short Zahl_2a
    test edi, edi
    je short Zahl_2a
    jmp short Zahl_2b

  Zahl_2a:
    mov byte ptr [esi+ebx], 2eh ; pc32Zahl[ucLange--] = 2eh
    sub ebx, 1

  Zahl_2b:
    mov ecx, 1
    push ecx
    lea edx, dword ptr s_c20VorKomma[esp+edi+4]
    sub edi, 1 ; ucVorKommaStellen
    lea ecx, dword ptr [esi+ebx] ; pc32Zahl[ucLange]
    call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
    jmp short Zahl_2

  Ende:
    lea eax, dword ptr [esi]
    add esp, esp_Bytes
    pop edi
    pop esi
    pop ebx
    ret 4
?Comma4_80toCHAR@System@RePag@@YQPADQADPAVCOComma4_80@12@E@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 12
s_c2Runden_Alt = 10
s_c2Runden = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
a_llNachKomma$ = esp_Bytes + 16
a_ucStellen = a_llNachKomma$ + 4
?__DOUBLE_B10toCHAR@@YQXAAF0NAA_JE@Z PROC ; __DOUBLE_B10toCHAR((&sExponent, &sVorKomma, dZahl, &llNachKomma, ucStellen)
    push ebx
    push esi
    push edi
    sub esp, esp_Bytes

    mov esi, ecx
    mov edi, edx

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    xor ecx, ecx
    xorpd xmm1, xmm1
    comisd xmm0, xmm1
    ja short Init
    movq xmm1, dMinusEins
    mulsd xmm0, xmm1

  Init:
    movq xmm1, dEins
    movq xmm2, dZehn

  Exponent_Minus:
    comisd xmm0, xmm1
    jae short Exponent
    sub cx, 1
    mulsd xmm0, xmm2
    jmp short Exponent_Minus

  Exponent:
    comisd xmm0, xmm2
    jb short Komma

  Exponent_Plus:
    add cx, 1
    divsd xmm0, xmm2
    comisd xmm0, xmm2
    ja short Exponent_Plus

  Komma:
    mov word ptr [esi], cx
    cvttsd2si ebx, xmm0
    mov word ptr [edi], bx
    cvtsi2sd xmm1, ebx
    subsd xmm0, xmm1
    movq xmm1, dNull_16
    mulsd xmm0, xmm1

    fstcw s_c2Runden_Alt[esp]
    fstcw s_c2Runden[esp]
    btr word ptr s_c2Runden[esp], 10
    btr word ptr s_c2Runden[esp], 11
    fclex
    fldcw s_c2Runden[esp]

    mov ebx, dword ptr a_llNachKomma$[esp]
    movq qword ptr [ebx], xmm0
    fld qword ptr [ebx] ; Runde double zu Quadword Integer
    fistp qword ptr [ebx]
    movq xmm3, qword ptr [ebx]

    mov eax, dword ptr a_ucStellen[esp]
    test eax, eax
    je Ende
    cmp eax, 16
    jae Ende

    fild qword ptr [ebx]
    fstp qword ptr [ebx] ; Runde Quadword Integer zu double 
    movq xmm0, qword ptr [ebx]

    cmp eax, 7
    jb short Stellen_4
    ja Stellen_11
    comisd xmm0, dNeun_7
    ja VorKomma
    movq xmm2, dNull_9
    jmp Runden

  Stellen_4:
    cmp eax, 4
    jb short Stellen_2
    ja short Stellen_6
    comisd xmm0, dNeun_4
    ja VorKomma
    movq xmm2, dNull_12
    jmp Runden

  Stellen_2:
    cmp eax, 2
    jb short Stellen_1
    ja short Stellen_3
    comisd xmm0, dNeun_2
    ja VorKomma
    movq xmm2, dNull_14
    jmp Runden

  Stellen_1:
    comisd xmm0, dNeun_1
    ja VorKomma
    movq xmm2, dNull_15
    jmp Runden

  Stellen_3:
    comisd xmm0, dNeun_3
    ja VorKomma
    movq xmm2, dNull_13
    jmp Runden

  Stellen_6:
    cmp eax, 6
    jb short Stellen_5
    comisd xmm0, dNeun_6
    ja VorKomma
    movq xmm2, dNull_10
    jmp Runden

  Stellen_5:
    comisd xmm0, dNeun_5
    ja VorKomma
    movq xmm2, dNull_11
    jmp Runden

  Stellen_11:
    cmp eax, 11
    jb short Stellen_9
    ja short Stellen_13
    comisd xmm0, dNeun_11
    ja VorKomma
    movq xmm2, dNull_5
    jmp Runden

  Stellen_9:
    cmp eax, 9
    jb short Stellen_8
    ja short Stellen_10
    comisd xmm0, dNeun_9
    ja VorKomma
    movq xmm2, dNull_7
    jmp Runden

  Stellen_8:
    comisd xmm0, dNeun_8
    ja VorKomma
    movq xmm2, dNull_8
    jmp Runden

  Stellen_10:
    comisd xmm0, dNeun_10
    ja short VorKomma
    movq xmm2, dNull_6
    jmp Runden

  Stellen_13:
    cmp eax, 13
    jb short Stellen_12
    ja short Kleiner_15
    comisd xmm0, dNeun_13
    ja short VorKomma
    movq xmm2, dNull_3
    jmp short Runden

  Stellen_12:
    comisd xmm0, dNeun_12
    ja short VorKomma
    movq xmm2, dNull_4
    jmp short Runden

  Kleiner_15:
    cmp eax, 15
    jb short Kleiner_14
    comisd xmm0, dNeun_15
    ja short VorKomma
    addsd xmm0, dNullEins
    movq xmm2, dZehn
    jmp short Runden

  Kleiner_14:
    comisd xmm0, dNeun_14
    ja short VorKomma
    movq xmm2, dNull_2
    jmp short Runden

  VorKomma:
    xorpd xmm3, xmm3
    movzx edx, word ptr [edi]
    cmp edx, 9
    jae short VorKommaGrosser
    add edx, 1
    mov word ptr [edi], dx
    jmp short Ende

  VorKommaGrosser:
    mov edx, 1
    mov word ptr [edi], dx
    movzx ecx, word ptr [esi]
    add ecx, 1
    mov word ptr [esi], cx
    jmp short Ende

  Runden:
    movsd xmm1, xmm0
    divsd xmm0, xmm2

    fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fclex
    fldcw s_c2Runden[esp]

    ;cvttsd2si eax, xmm0
    ;cvtsi2sd xmm0, eax
    movq qword ptr [ebx], xmm0
    fld qword ptr [ebx] ; Runde double zu Quadword Integer
    fistp qword ptr [ebx]
    movq xmm3, qword ptr [ebx]
    fild qword ptr [ebx]
    fstp qword ptr [ebx]
    movq xmm0, qword ptr [ebx]

    mulsd xmm0, xmm2
    subsd xmm1, xmm0
    divsd xmm2, dZehn
    divsd xmm1, xmm2

    addsd xmm1, dNullEins ; Korrektur Runden
    cvttsd2si eax, xmm1

    test eax, eax
    je short Ende
    cmp eax, 5
    jb short Ende
    movq xmm2, llEins
    paddq xmm3, xmm2

  Ende:
    movq qword ptr [ebx], xmm3

    fclex
    fldcw s_c2Runden_Alt[esp]
    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop edi
    pop esi
    pop ebx
    ret 8
?__DOUBLE_B10toCHAR@@YQXAAF0NAA_JE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_dwMXCSR = 4
s_dwMXCSR_Alt = 0
a_lNachKomma$ = esp_Bytes + 12
a_ucStellen = a_lNachKomma$ + 4
?__FLOAT_B10zuCHAR@@YQXAAF0MAAJE@Z PROC ; __FLOAT_B10zuCHAR(&Exponent, &sVorKomma, &lNachKomma, &fZahl, &ucStellen)
    push esi
    push edi
    sub esp, esp_Bytes

    mov esi, ecx
    mov edi, edx

    stmxcsr dword ptr s_dwMXCSR_Alt[esp]
    stmxcsr dword ptr s_dwMXCSR[esp]
    bts dword ptr s_dwMXCSR[esp], 13
    bts dword ptr s_dwMXCSR[esp], 14
    ldmxcsr dword ptr s_dwMXCSR[esp]

    xor ecx, ecx
    xorps xmm1, xmm1
    comiss xmm0, xmm1
    ja short Init
    movd xmm1, fMinusEins
    mulss xmm0, xmm1

  Init:
    movd xmm1, fEins
    movd xmm2, fZehn

  Exponent_Minus:
    comiss xmm0, xmm1
    jae short Exponent
    sub cx, 1
    mulss xmm0, xmm2
    jmp short Exponent_Minus

  Exponent:
    comiss xmm0, xmm2
    jb short Komma

  Exponent_Plus:
    add cx, 1
    divss xmm0, xmm2
    comiss xmm0, xmm2
    ja short Exponent_Plus

  Komma:
    mov word ptr [esi], cx
    cvttss2si eax, xmm0
    mov word ptr [edi], ax
    cvtsi2ss xmm1, eax
    subss xmm0, xmm1
    movd xmm1, fNull_8
    mulss xmm0, xmm1
    cvttss2si edx, xmm0

    mov eax, dword ptr a_ucStellen[esp]
    test eax, eax
    je Ende
    cmp eax, 8
    jae Ende

    cvtsi2ss xmm0, edx

    cmp eax, 4
    jb short Stellen_2
    ja short Stellen_6
    comiss xmm0, fNeun_4
    ja VorKomma
    movd xmm2, fNull_4
    jmp Runden

  Stellen_2:
    cmp eax, 2
    jb short Stellen_1
    ja short Stellen_3
    comiss xmm0, fNeun_2
    ja short VorKomma
    movd xmm2, fNull_6
    jmp Runden

  Stellen_1:
    comiss xmm0, fNeun_1
    ja short VorKomma
    movd xmm2, fNull_7
    jmp short Runden

  Stellen_3:
    comiss xmm0, fNeun_3
    ja short VorKomma
    movd xmm2, fNull_5
    jmp short Runden

  Stellen_6:
    cmp eax, 6
    jb short Stellen_5
    ja short Stellen_7
    comiss xmm0, fNeun_6
    ja short VorKomma
    movd xmm2, fNull_2
    jmp short Runden

  Stellen_5:
    comiss xmm0, fNeun_5
    ja short VorKomma
    movd xmm2, fNull_3
    jmp short Runden

  Stellen_7:
    cmp eax, 7
    comiss xmm0, fNeun_7
    ja short VorKomma
    movd xmm2, fZehn
    jmp short Runden

  VorKomma:
    xor edx, edx
    movzx ecx, word ptr [edi]
    cmp ecx, 9
    jae short VorKommaGrosser
    add ecx, 1
    mov word ptr [edi], cx
    jmp short Ende

  VorKommaGrosser:
    mov ecx, 1
    mov word ptr [edi], cx
    movzx ecx, word ptr [esi]
    add ecx, 1
    mov word ptr [esi], cx
    jmp short Ende

  Runden:
    movss xmm1, xmm0
    divss xmm0, xmm2

    cvttss2si edx, xmm0
    cvtsi2ss xmm0, edx

    mulss xmm0, xmm2
    subss xmm1, xmm0
    divss xmm2, fZehn
    divss xmm1, xmm2

    cvttss2si eax, xmm1

    test eax, eax
    je short Ende
    cmp eax, 5
    jb short Ende
    add edx, 1

  Ende:
    mov eax, dword ptr a_lNachKomma$[esp]
    mov dword ptr [eax], edx

    ldmxcsr dword ptr s_dwMXCSR_Alt[esp]
    add esp, esp_Bytes
    pop edi
    pop esi
    ret 8
?__FLOAT_B10zuCHAR@@YQXAAF0MAAJE@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_ZahlZuString ENDS
;----------------------------------------------------------------------------
END