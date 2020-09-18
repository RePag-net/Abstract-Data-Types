;/****************************************************************************
;  String_x86.asm
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
INCLUDE listing.inc
.MODEL FLAT
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

CS_Strings SEGMENT PARA PRIVATE FLAT EXECUTE
;----------------------------------------------------------------------------
?StrLength@System@RePag@@YQKPBD@Z PROC ; StrLength(ulLange)
		push edi

		xor al, al
    mov edi, ecx
		mov ecx, -1
		cld
		repnz scasb
		mov eax, -2
		sub eax, ecx

		pop	edi
		ret 0
?StrLength@System@RePag@@YQKPBD@Z ENDP
;----------------------------------------------------------------------------
?CharactersPosition@System@RePag@@YQKPBDD_N@Z PROC ; CharactersPosition(pcString, cCharacters, bFromLefttoRight)
		push edi

    xor al, al
    mov edi, ecx
		mov ecx, -1
		cld
		repnz scasb
    mov al, dl
		mov edx, -2
		sub edx, ecx

		mov ecx, edx
    sub edx, 1
		cmp byte ptr [esp + 8], 1  ; cRichtung
		je short VonLinksNachRechts
		std
		jmp short Scan

	VonLinksNachRechts:
		sub edi, ecx

	Scan:
    add ecx, 1
    sub edi, 1
		repne scasb
		mov eax, edx
		sub eax, ecx
		add eax, 1

		cld
		pop	edi
		ret 4
?CharactersPosition@System@RePag@@YQKPBDD_N@Z ENDP
;----------------------------------------------------------------------------
?CharactersPosition@System@RePag@@YQKPBDKD_N@Z PROC ; CharactersPosition(pcString, ulLength, cCharacters, bFromLefttoRight)
		push edi

		cld
		mov edi, ecx
		mov ecx, edx
    sub edx, 1
		mov al, byte ptr [esp+8] ; cCharacters

		cmp byte ptr [esp+12], 1 ; cRichtung
		je short Scan
		std
		add edi, ecx

	Scan:
    add ecx, 1
		repne scasb
		mov eax, edx
		sub eax, ecx
		add eax, 1

		cld
		pop	edi
		ret 8
?CharactersPosition@System@RePag@@YQKPBDKD_N@Z ENDP
;----------------------------------------------------------------------------
?StrCompare@System@RePag@@YQDPBD0@Z PROC PUBLIC ; StrCompare(pcRefString, pcCmpString)
		push ebx
		push esi
		push edi

		cld
		xor eax, eax
    mov edi, ecx
    mov esi, ecx

		mov ecx, -1 
		repnz scasb
		mov ebx, -2 
		sub ebx, ecx

    mov edi, edx
		mov ecx, -1 
		repnz scasb
    mov edi, esi
    mov esi, edx

		mov edx, -2
		sub edx, ecx

		mov ecx, ebx

    cmp ebx, edx
		jbe short RefKleinerGleich
		mov ecx, edx

	RefKleinerGleich:
		repe cmpsb
		ja  short Grosser
		jb  short Kleiner

    cmp edx, ebx
		ja  short Grosser
		jb  short Kleiner

		add eax, -1
	Kleiner:
		add eax, 2
	Grosser:
		add eax, -1

		pop	edi
		pop	esi
		pop	ebx
		ret 0
?StrCompare@System@RePag@@YQDPBD0@Z ENDP
;----------------------------------------------------------------------------
?StrCompare@System@RePag@@YQDPBDK0K@Z PROC PUBLIC ; StrCompare(pcRefString, ulRefLength, pcVglString, ulCmpLength)
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

		mov edi, ecx
		mov ecx, edx

		mov ebx, dword ptr [esp+20] ; ulVergLange

		cmp edx, ebx
		jbe short RefKleinerGleich
		mov ecx, ebx

	RefKleinerGleich:
		mov esi, dword ptr [esp+16] ; pcVergString
		repe cmpsb
		ja short Grosser
		jb short Kleiner

		cmp ebx, edx
		ja short Grosser
		jb short Kleiner
		jmp short Ende

	Kleiner:
		mov eax, 1
		jmp short Ende

	Grosser:
		mov eax, -1

	Ende:
		pop	edi
		pop	esi
		pop	ebx
		ret 8
?StrCompare@System@RePag@@YQDPBDK0K@Z ENDP
;----------------------------------------------------------------------------
?StrContain@System@RePag@@YQ_NPBD0@Z PROC PUBLIC ; StrContain(pcRefString, pcCmpString)
		push ebx
		push esi
		push edi

    mov edi, ecx
    mov esi, ecx

		cld
		xor eax, eax

		mov ecx, -1 
		repnz scasb

    mov edi, edx
    mov ebx, edx

		mov edx, -1 
		sub edx, ecx

		mov ecx, -1 
		repnz scasb
		
    mov edi, esi
    mov esi, ebx

    mov ebx, -1 
		sub ebx, ecx

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
		je short Return_Tmp
		jmp short Return_0

	Return_Tmp:
		xor eax, eax
		jmp short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 0
?StrContain@System@RePag@@YQ_NPBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContain@System@RePag@@YQ_NPBDK0K@Z PROC PUBLIC ; StrContain(pcRefString, ulRefLength, pcCmpString, ulVglLength)
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

    mov edi, ecx
    mov esi, dword ptr [esp+16] ; pcVergString

		add edx, 1
		mov ebx, dword ptr [esp+20] ; ulVergLange
		add ebx, 1

		cmp ebx, edx
		ja Return_0

		mov ecx, edx

		cmp ebx, 2
		je EinBuchstabe
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
		je short Return_Tmp
		jmp short Return_0

	Return_Tmp:
		xor eax, eax
		jmp short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 8
?StrContain@System@RePag@@YQ_NPBDK0K@Z ENDP
;----------------------------------------------------------------------------
_pcRefString_1 = 8
_pcVglString_2  = 12
?StrContainLeft@System@RePag@@YQ_NPBD0@Z PROC PUBLIC
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

    mov edi, ecx
    mov esi, ecx

		mov ecx, -1 
		repnz scasb

    mov edi, edx
    mov ebx, edx

		mov edx, -1 
    sub edx, ecx

		mov ecx, -1 
		repnz scasb

    mov edi, esi
    mov esi, ebx

		mov ebx, -1 
		sub ebx, ecx

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
		cmp ecx, 0
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 0
?StrContainLeft@System@RePag@@YQ_NPBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContainLeft@System@RePag@@YQ_NPBDK0K@Z PROC PUBLIC
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

    mov edi, ecx
    mov esi, dword ptr [esp+16] ; pcVergString

		add edx, 1
		mov ebx, dword ptr [esp+20] ; ulVergLange
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
		cmp ecx, 0
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 8
?StrContainLeft@System@RePag@@YQ_NPBDK0K@Z ENDP
;----------------------------------------------------------------------------
?StrContainRight@System@RePag@@YQ_NPBD0@Z PROC PUBLIC
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

    mov edi, ecx
    mov esi, ecx

		mov ecx, -1 
		repnz scasb

    mov edi, edx
    mov ebx, edx

		mov edx, -1 
		sub edx, ecx

		mov ecx, -1 
		repnz scasb

    mov edi, esi
    mov esi, ebx

		mov ebx, -1 
		sub ebx, ecx

		cmp ebx, edx
		ja short Return_0

		mov ecx, ebx

		sub edx, ebx
		add edi, edx

		repe cmpsb
		cmp ecx, 0
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 0
?StrContainRight@System@RePag@@YQ_NPBD0@Z ENDP
;----------------------------------------------------------------------------
?StrContainRight@System@RePag@@YQ_NPBDK0K@Z PROC PUBLIC
		push ebx
		push esi
		push edi

		cld
		xor eax, eax

    mov edi, ecx
    mov esi, dword ptr [esp+16] ; pcVergString

		add edx, 1
		mov ebx, dword ptr [esp+20] ; ulVergLange
		add ebx, 1

		cmp ebx, edx
		ja short Return_0

		mov ecx, ebx

		sub edx, ebx
		add edi, edx

		repe cmpsb
		cmp ecx, 0
		je short Return_1

	Return_0:
		mov eax, -1

	Return_1:
		add eax, 1

		pop	edi
		pop	esi
		pop	ebx
		ret 8
?StrContainRight@System@RePag@@YQ_NPBDK0K@Z ENDP
;----------------------------------------------------------------------------
CS_Strings ENDS
;----------------------------------------------------------------------------
CS_Compare SEGMENT PARA PRIVATE FLAT EXECUTE
;----------------------------------------------------------------------------
?BIT128Compare@System@RePag@@YQDQBE0@Z PROC PUBLIC
    push esi
    push edi

    xor eax, eax
    mov edi, ecx
    mov esi, edx
    mov ecx, 16

		repe cmpsb
    je short Ende
		ja short Grosser
		jb short Kleiner

	Kleiner:
		mov eax, 1
		jmp short Ende

	Grosser:
		mov eax, -1

  Ende:
    pop edi
    pop esi
    ret 0
?BIT128Compare@System@RePag@@YQDQBE0@Z ENDP
;----------------------------------------------------------------------------
CS_Compare ENDS
;----------------------------------------------------------------------------
END