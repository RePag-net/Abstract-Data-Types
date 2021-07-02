;****************************************************************************
;  String_x64.asm
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
INCLUDELIB OLDNAMES

CS_Strings SEGMENT EXECUTE
;----------------------------------------------------------------------------
?StrLength@System@RePag@@YQKPEBD@Z  PROC ; StrLength(pcString)
		push rdi

		xor al, al
    mov rdi, rcx
		mov rcx, -1
		cld
		repnz scasb
		mov rax, -2
		sub rax, rcx

		pop	rdi
		ret
?StrLength@System@RePag@@YQKPEBD@Z ENDP
;----------------------------------------------------------------------------
?CharactersPosition@System@RePag@@YQKPEBDD_N@Z PROC ; CharactersPosition(pcString, cCharacters, bFromLefttoRight)
		push rdi

    xor al, al
    mov rdi, rcx
		mov rcx, -1
		cld
		repnz scasb
    mov al, dl
		mov rdx, -2
		sub rdx, rcx

		mov rcx, rdx
    sub rdx, 1
		cmp r8b, 1  ; cRichtung
		je short VonLinksNachRechts
		std
		jmp short Scan

	VonLinksNachRechts:
		sub rdi, rcx

	Scan:
    add rcx, 1
    sub rdi, 1
		repne scasb
		mov rax, rdx
		sub rax, rcx
		add rax, 1

		cld
		pop	rdi
		ret 0
?CharactersPosition@System@RePag@@YQKPEBDD_N@Z ENDP
;----------------------------------------------------------------------------
?CharactersPosition@System@RePag@@YQKPBDKD_N@Z PROC ; CharactersPosition(pcString, ulLength, cCharacters, bFromLefttoRight)
		push rdi

		cld
		mov rdi, rcx
		mov rcx, rdx
    sub rdx, 1
		mov al, r8b ; cCharacters

		cmp r9b, 1 ; cRichtung
		je short Scan
		std
		add rdi, rcx

	Scan:
    add rcx, 1
		repne scasb
		mov rax, rdx
		sub rax, rcx
		add rax, 1

		cld
		pop	rdi
		ret 0
?CharactersPosition@System@RePag@@YQKPBDKD_N@Z ENDP
;----------------------------------------------------------------------------
?StrCompare@System@RePag@@YQDPEBD0@Z PROC PUBLIC ; StrCompare(pcRefString, pcCmpString)
		push rdi
		push rsi

		cld
		xor rax, rax
    mov rdi, rcx
    mov rsi, rcx

		mov rcx, -1 
		repnz scasb
		mov r8, -2 
		sub r8, rcx

    mov rdi, rdx
		mov rcx, -1 
		repnz scasb
    mov rdi, rsi
    mov rsi, rdx

		mov rdx, -2
		sub rdx, rcx

		mov rcx, r8

    cmp r8, rdx
		jbe  short RefKleinerGleich
		mov rcx, rdx

	RefKleinerGleich:
		repe cmpsb
		ja  short Grosser
		jb  short Kleiner

    cmp rdx, r8
		ja  short Grosser
		jb  short Kleiner

		add rax, -1
	Kleiner:
		add rax, 2
	Grosser:
		add rax, -1

		pop rsi
		pop	rdi
		ret 0
?StrCompare@System@RePag@@YQDPEBD0@Z ENDP
;----------------------------------------------------------------------------
?StrCompare@System@RePag@@YQDPEBDK0K@Z PROC PUBLIC ; StrCompare(pcRefString, ulRefLength, pcVglString, ulCmpLength)
		;push ebx
		push rsi
		push rdi

		cld
		xor rax, rax

		mov rdi, rcx
		mov rcx, rdx

		cmp rdx, r9
		jbe short RefKleinerGleich
		mov rcx, r9

	RefKleinerGleich:
		mov rsi, r8 
		repe cmpsb
		ja short Grosser
		jb short Kleiner

		cmp r9, rdx
		ja short Grosser
		jb short Kleiner
		jmp short Ende

	Kleiner:
		mov rax, 1
		jmp short Ende

	Grosser:
		mov rax, -1

	Ende:
		pop	rdi
		pop	rsi
		;pop	ebx
		ret 0
?StrCompare@System@RePag@@YQDPEBDK0K@Z ENDP
;----------------------------------------------------------------------------
?StrContain@System@RePag@@YQ_NPEBD0@Z PROC PUBLIC ; StrContain(pcRefString, pcCmpString)
		push rsi
		push rdi

    mov rdi, rcx
    mov rsi, rcx

		cld
		xor rax, rax

		mov rcx, -1 
		repnz scasb

    mov rdi, rdx
    mov r8, rdx

		mov rdx, -1 
		sub rdx, rcx

		mov rcx, -1 
		repnz scasb
		
    mov rdi, rsi
    mov rsi, r8

    mov r8, -1 
		sub r8, rcx

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
		je short Return_Tmp
		jmp short Return_0

	Return_Tmp:
		xor rax, rax
		jmp short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret 0
?StrContain@System@RePag@@YQ_NPEBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContain@System@RePag@@YQ_NPEBDK0K@Z PROC PUBLIC ; StrContain(pcRefString, ulRefLength, pcCmpString, ulVglLength)
		push rsi
		push rdi

		cld
		xor rax, rax

    mov rdi, rcx
    mov rsi, r8

		add rdx, 1
		add r9, 1

		cmp r9, rdx
		ja Return_0

		mov rcx, rdx

		cmp r9, 2
		je EinBuchstabe
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
		je short Return_Tmp
		jmp short Return_0

	Return_Tmp:
		xor rax, rax
		jmp short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret 0
?StrContain@System@RePag@@YQ_NPEBDK0K@Z ENDP
;----------------------------------------------------------------------------
?StrContainLeft@System@RePag@@YQ_NPEBD0@Z PROC ; StrContainLeft(pcRefString, pcCmpString)
		;push ebx
		push rsi
		push rdi

		cld
		xor rax, rax

    mov rdi, rcx
    mov rsi, rcx

		mov rcx, -1 
		repnz scasb

    mov rdi, rdx
    mov r9, rdx

		mov rdx, -1 
    sub rdx, rcx

		mov rcx, -1 
		repnz scasb

    mov rdi, rsi
    mov rsi, r9

		mov r9, -1 
		sub r9, rcx

		cmp r9, rdx
		ja short Return_0

    cmp r9, 1
    ja short Vergleich
    cmp rdx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov rcx, r9
		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		;pop	ebx
		ret 0
?StrContainLeft@System@RePag@@YQ_NPEBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContainLeft@System@RePag@@YQ_NPEBDK0K@Z PROC ; StrContainLeft(pcRefString, ulRefLength, pcCmpString, ulCmpLength)
		push rsi
		push rdi

		cld
		xor rax, rax

    mov rdi, rcx
    mov rsi, r8 

		add rdx, 1
		add r9, 1

		cmp r9, rdx
		ja short Return_0

    cmp r9, 1
    ja short Vergleich
    cmp rdx, 1
    je short Return_1
    jmp short Return_0

  Vergleich:
		mov rcx, r9
		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret 0
?StrContainLeft@System@RePag@@YQ_NPEBDK0K@Z ENDP
;----------------------------------------------------------------------------
?StrContainRight@System@RePag@@YQ_NPEBD0@Z PROC PUBLIC
		push rsi
		push rdi

		cld
		xor rax, rax

    mov rdi, rcx
    mov rsi, rcx

		mov rcx, -1 
		repnz scasb

    mov rdi, rdx
    mov r8, rdx

		mov rdx, -1 
		sub rdx, rcx

		mov rcx, -1 
		repnz scasb

    mov rdi, rsi
    mov rsi, r8

		mov r8, -1 
		sub r8, rcx

		cmp r8, rdx
		ja short Return_0

		mov rcx, r8

		sub rdx, r8
		add rdi, rdx

		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret 0
?StrContainRight@System@RePag@@YQ_NPEBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContainRight@System@RePag@@YQ_NPEBDK0K@Z PROC PUBLIC ; StrContainRight(pcRefString, ulRefLength, pcCmpString, ulCmpLength)
		push rsi
		push rdi

		cld
		xor rax, rax

    mov rdi, rcx
    mov rsi, r8 

		add rdx, 1
		add r9, 1

		cmp r9, rdx
		ja short Return_0

		mov rcx, r9

		sub rdx, r9
		add rdi, rdx

		repe cmpsb
		test rcx, rcx
		je short Return_1

	Return_0:
		mov rax, -1

	Return_1:
		add rax, 1

		pop	rdi
		pop	rsi
		ret 0
?StrContainRight@System@RePag@@YQ_NPEBDK0K@Z ENDP
;----------------------------------------------------------------------------
CS_Strings ENDS
;----------------------------------------------------------------------------
CS_Compare SEGMENT EXECUTE
;----------------------------------------------------------------------------
?BIT128Compare@System@RePag@@YQDQEBE0@Z PROC PUBLIC ; BIT128Compare(bit128Value_1, bit128Value_2)
    push rsi
    push rdi

    xor rax, rax
    mov rdi, rcx
    mov rsi, rdx
    mov rcx, 16

		repe cmpsb
    je short Ende
		ja short Grosser
		jb short Kleiner

	Kleiner:
		mov rax, 1
		jmp short Ende

	Grosser:
		mov rax, -1

  Ende:
    pop rdi
    pop rsi
    ret 0
?BIT128Compare@System@RePag@@YQDQEBE0@Z ENDP
;----------------------------------------------------------------------------
CS_Compare ENDS
;----------------------------------------------------------------------------
END
