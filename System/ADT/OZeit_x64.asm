;****************************************************************************
;  OZeit_x64.asm
;  For more information see https://github.com/RePag-net/Abstract-Data-Types
;****************************************************************************
;
;****************************************************************************
;  The MIT License(MIT)
;
;  Copyright(c) 2025 René Pagel
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

EXTRN __imp_SystemTimeToFileTime:PROC
EXTRN __imp_GetLocalTime:PROC
EXTRN __imp_FileTimeToSystemTime:PROC
EXTRN __imp_GetDateFormatA:PROC
EXTRN __imp_GetDateFormatEx:PROC
EXTRN __imp_GetTimeFormatA:PROC
EXTRN	__imp_CompareFileTime:PROC
EXTRN ??0COStringA@System@RePag@@QEAA@PEBD@Z:PROC
EXTRN ??1COStringA@System@RePag@@QEAA@XZ:PROC
EXTRN ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z:PROC
EXTRN ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z:PROC
EXTRN ??4COStringA@System@RePag@@QEAQXPEBD@Z:PROC
EXTRN ??YCOStringA@System@RePag@@QEAQXPEBD@Z:PROC
EXTRN ?CharactersPosition@System@RePag@@YQKPBDKD_N@Z:PROC

.DATA
dbi_BY_COZEIT DB 24
llMorgen DQ 864000000000
dqi_Millisekunde DQ 10000
dqi_Sekunde DQ 10000000
dqi_Minute DQ 600000000
dqi_Stunde DQ 36000000000
dqi_Tag DQ 864000000000

CS_OZeit SEGMENT EXECUTE
;----------------------------------------------------------------------------
?COTimeV@System@RePag@@YQPEAVCOTime@12@XZ PROC ; COTimeV(void)
    sub rsp, s_ShadowRegister
    movzx rdx, dbi_BY_COZEIT
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		vpxor xmm5, xmm5, xmm5
		vmovdqu xmmword ptr [rax], xmm5
		vmovdqu xmmword ptr [rax + 8], xmm5

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBX@Z PROC ; COTimeV(vmSpeicher)
    sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx

    movzx rdx, dbi_BY_COZEIT
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		vpxor xmm5, xmm5, xmm5
		vmovdqu xmmword ptr [rax], xmm5
		mov rcx, qword ptr sqp_vmSpeicher[rsp]
		mov qword ptr COTime_vmSpeicher[rax], rcx
		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBX@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sl_Bytes = 64
so32_asZiffer = 32 + s_ShadowRegister
so32_asString = 0 + s_ShadowRegister
sqp_pcString = 64 + sl_Bytes
sqp_COTime = 56 + sl_Bytes
so16_stSystemTime = 40 + sl_Bytes
wYear = 0
wMonth = 2
wDayOfWeek = 4
wDay = 6
wHour = 8
wMinute = 10 
wSecond = 12
wMilliseconds = 14;
StringZuFILETIME PROC PRIVATE
		sub rsp, s_ShadowRegister + sl_Bytes
		mov qword ptr sqp_COTime[rsp], rax
		mov qword ptr sqp_pcString[rsp], rcx

		mov word ptr so16_stSystemTime[rsp + wYear], 2006
		mov word ptr so16_stSystemTime[rsp + wMonth], 11
		mov word ptr so16_stSystemTime[rsp + wDayOfWeek], 3
		mov word ptr so16_stSystemTime[rsp + wDay], 29
		mov dword ptr so16_stSystemTime[rsp + wHour], 0
		mov dword ptr so16_stSystemTime[rsp + wSecond], 0	

		mov rdx, rcx
		lea rcx, so32_asString[rsp]
		call ??0COStringA@System@RePag@@QEAA@PEBD@Z ; COStringA::COStringA(pcString)


		vpxor ymm5, ymm5, ymm5
		vmovdqu ymmword ptr so32_asZiffer[rsp], ymm5

		cmp qword ptr so32_asString[rsp + COStringA_ulLange], 10
		jb Lange_8
		ja Lange_17
		mov r9, 2
		mov r8, 1
		lea edx, so32_asZiffer[rsp]
		lea ecx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)

		lea rdx, so16_stSystemTime[rsp + wDay]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 5
		mov r8, 4
		lea edx, so32_asZiffer[rsp]
		lea ecx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMonth]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 10
		mov r8, 7
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wYear]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		mov dword ptr so16_stSystemTime[rsp + wHour], 0
		mov dword ptr so16_stSystemTime[rsp + wSecond], 0
		jmp Ende

	Lange_8:
		mov r9, 1
		mov r8, 58
		mov rdx, qword ptr so32_asString[rsp + COStringA_ulLange]
		mov rcx, qword ptr sqp_pcString[rsp]
		call ?CharactersPosition@System@RePag@@YQKPBDKD_N@Z ; CharactersPosition(pcString, ulLength, cCharacters, bFromLefttoRight)
		cmp rax, 2
		jne Lange_8A

		mov r9, 2
		mov r8, 1
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wHour]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 5
		mov r8, 4
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMinute]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 8
		mov r8, 7
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wSecond]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], 0
		jmp Ende

	Lange_8A:
		mov r9, 2
		mov r8, 1
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wDay]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 5
		mov r8, 4
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMonth]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 8
		mov r8, 7
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wYear]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		add word ptr so16_stSystemTime[rsp + wYear], 2000
		mov dword ptr so16_stSystemTime[rsp + wHour], 0
		mov dword ptr so16_stSystemTime[rsp + wSecond], 0
		jmp Ende

	Lange_17:
		cmp dword ptr so32_asString[rsp + COStringA_ulLange], 19
		je Lange_19

		mov r9, 2
		mov r8, 1
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wDay]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 5
		mov r8, 4
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMonth]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 8
		mov r8, 7
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wYear]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		add word ptr so16_stSystemTime[rsp + wYear], 2000

		mov r9, 11
		mov r8, 10
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wHour]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 14
		mov r8, 13
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMinute]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 17
		mov r8, 16
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wSecond]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], 0
		jmp Ende

	Lange_19:
		mov r9, 2
		mov r8, 1
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wDay]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 5
		mov r8, 4
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMonth]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 10
		mov r8, 7
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wYear]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 13
		mov r8, 12
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wHour]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 16
		mov r8, 15
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wMinute]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)

		mov r9, 19
		mov r8, 18
		lea rdx, so32_asZiffer[rsp]
		lea rcx, so32_asString[rsp]
		call ?SubString@COStringA@System@RePag@@QEAQPEAV123@PEBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea rdx, so16_stSystemTime[rsp + wSecond]
		lea rcx, so32_asZiffer[rsp]
		call ?USHORT@COStringA@System@RePag@@QEAQAEAGAEAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], 0

	Ende:
		mov rdx, qword ptr sqp_COTime[rsp]
		lea rcx, so16_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		lea rcx, qword ptr so32_asZiffer[rsp]
		call ??1COStringA@System@RePag@@QEAA@XZ ; COStringA::~COStringA(void)
		lea rcx, qword ptr so32_asString[rsp]
		call ??1COStringA@System@RePag@@QEAA@XZ ; COStringA::~COStringA(void)

		mov rax, qword ptr sqp_COTime[rsp]
		
		add rsp, s_ShadowRegister + sl_Bytes
		ret
StringZuFILETIME ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pcString = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBD@Z PROC ; COTimeV(const pcString)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_pcString[rsp], rcx

    movzx edx, dbi_BY_COZEIT
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		
		mov rcx, qword ptr sqp_pcString[rsp]

		xor rdx, rdx
		mov qword ptr COTime_vmSpeicher[rax], rdx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pcString = 48
sqp_vmSpeicher = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBD@Z PROC ; COTimeV(vmSpeicher, pcString)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_pcString[rsp], rdx

    movzx rdx, dbi_BY_COZEIT
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rdx, qword ptr sqp_vmSpeicher[rsp]
		mov rcx, qword ptr sqp_pcString[rsp]

		mov qword ptr COTime_vmSpeicher[rax], rdx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_stSystemTime = 48
sqp_this = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBU_SYSTEMTIME@@@Z PROC ; COTimeV(stSystemTime)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_stSystemTime[rsp], rcx

    movzx rdx, dbi_BY_COZEIT
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		xor rdx, rdx
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov rdx, rax
		mov rcx, qword ptr sqp_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 56
sqp_stSystemTime = 48
sqp_this = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBU_SYSTEMTIME@@@Z PROC ; COTimeV(vmSpeicher, stSystemTime)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_stSystemTime[rsp], rdx

    movzx rdx, dbi_BY_COZEIT
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		mov rdx, qword ptr sqp_vmSpeicher[rsp]
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov rdx, rax
		mov rcx, qword ptr sqp_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_pzZeit = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBV312@@Z PROC ; COTimeV(pzZeit)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_pzZeit[rsp], rcx

    movzx rdx, dbi_BY_COZEIT
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pzZeit[rsp]

		xor rdx, rdx
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_dwLowDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_dwHighDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_A_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_A_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], edx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_vmSpeicher = 48
sqp_pzZeit = 40
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBV312@@Z PROC ; COTimeV(vmSpeicher, pzZeit)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_pzZeit[rsp], rdx

    movzx rdx, dbi_BY_COZEIT
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov rcx, qword ptr sqp_pzZeit[rsp]

		mov rdx, qword ptr sqp_vmSpeicher[rsp] 
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_dwLowDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_dwHighDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_A_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], edx
		mov edx, dword ptr COTime_FZeit_A_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], edx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXPEBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 64
sqp_stZeit = 56
so16_stSystemTime = 40
wYear = 0;
wMonth = 2;
wDayOfWeek = 4;
wDay = 6;
wHour = 8;
wMinute = 10;
wSecond = 12;
wMilliseconds = 14;
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBUSTTime@12@@Z PROC ; COTimeV(&stZeit)
		sub rsp, s_ShadowRegister
		mov qword ptr sqp_stZeit[rsp], rcx

    movzx rdx, dbi_BY_COZEIT
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax
		mov rcx, qword ptr sqp_stZeit[rsp]

		xor rdx, rdx
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov word ptr so16_stSystemTime[rsp + wYear], 2011
		mov word ptr so16_stSystemTime[rsp + wMonth], 7
		mov word ptr so16_stSystemTime[rsp + wDayOfWeek], 3
		mov word ptr so16_stSystemTime[rsp + wDay], 23
		mov dword ptr so16_stSystemTime[rsp + wHour], edx
		mov dword ptr so16_stSystemTime[rsp + wSecond], edx

		movzx rdx, word ptr [rcx + usJahr]
		mov word ptr so16_stSystemTime[rsp + wYear], dx
		movzx rdx, byte ptr [rcx + ucMonat]
		mov word ptr so16_stSystemTime[rsp + wMonth], dx
		mov edx, dword ptr [rcx + ulTag]
		mov word ptr so16_stSystemTime[rsp + wDay], dx
		movzx rdx, byte ptr [rcx + ucStunde]
		mov word ptr so16_stSystemTime[rsp + wHour], dx
		movzx rdx, byte ptr [rcx + ucMinute]
		mov word ptr so16_stSystemTime[rsp + wMinute], dx
		movzx rdx, byte ptr [rcx + ucSekunde]
		mov word ptr so16_stSystemTime[rsp + wSecond], dx
		movzx rdx, word ptr [rcx + usMillisekunde]
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], dx

		mov rdx, rax
		lea rcx, so16_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@AEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sl_Bytes = 16
sqp_vmSpeicher = 0 + s_Shadowregister
sqp_this = 64 + sl_Bytes
sqp_stZeit = 56 + sl_Bytes
so16_stSystemTime = 40 + sl_Bytes
wYear = 0;
wMonth = 2;
wDayOfWeek = 4;
wDay = 6;
wHour = 8;
wMinute = 10;
wSecond = 12;
wMilliseconds = 14;
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBUSTTime@12@@Z PROC ; COTimeV(vmSpeicher, &stZeit)
		sub rsp, s_ShadowRegister + sl_Bytes

		mov qword ptr sqp_vmSpeicher[rsp], rcx
		mov qword ptr sqp_stZeit[rsp], rdx

    movzx rdx, dbi_BY_COZEIT
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov qword ptr sqp_this[rsp], rax

		mov rcx, qword ptr sqp_stZeit[rsp]

		mov rdx, qword ptr sqp_vmSpeicher[rsp]
		mov qword ptr COTime_vmSpeicher[rax], rdx

		mov word ptr so16_stSystemTime[rsp + wYear], 2011
		mov word ptr so16_stSystemTime[rsp + wMonth], 7
		mov word ptr so16_stSystemTime[rsp + wDayOfWeek], 3
		mov word ptr so16_stSystemTime[rsp + wDay], 23
		mov dword ptr so16_stSystemTime[rsp + wHour], edx
		mov dword ptr so16_stSystemTime[rsp + wSecond], edx

		movzx rdx, word ptr [rcx + usJahr]
		mov word ptr so16_stSystemTime[rsp + wYear], dx
		movzx rdx, byte ptr [rcx + ucMonat]
		mov word ptr so16_stSystemTime[rsp + wMonth], dx
		mov edx, dword ptr [rcx + ulTag]
		mov word ptr so16_stSystemTime[rsp + wDay], dx
		movzx rdx, byte ptr [rcx + ucStunde]
		mov word ptr so16_stSystemTime[rsp + wHour], dx
		movzx rdx, byte ptr [rcx + ucMinute]
		mov word ptr so16_stSystemTime[rsp + wMinute], dx
		movzx rdx, byte ptr [rcx + ucSekunde]
		mov word ptr so16_stSystemTime[rsp + wSecond], dx
		movzx rdx, word ptr [rcx + usMillisekunde]
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], dx

		mov rdx, rax
		lea rcx, so16_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister + sl_Bytes
		ret
?COTimeV@System@RePag@@YQPEAVCOTime@12@PEBXAEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COFreiV@COTime@System@RePag@@QEAQPEBXXZ PROC ; COTime::COFreiV(void)
		mov rax, qword ptr COTime_vmSpeicher[rcx]
		ret
?COFreiV@COTime@System@RePag@@QEAQPEBXXZ ENDP
;----------------------------------------------------------------------------
??0COTime@System@RePag@@QEAA@XZ PROC ; COTime::COTime(void)
		vpxor xmm5, xmm5, xmm5
		vmovdqu xmmword ptr COTime_FZeit_dwLowDateTime[rcx], xmm5
		vmovdqu xmmword ptr COTime_FZeit_dwLowDateTime[rcx + 8], xmm5
		ret
??0COTime@System@RePag@@QEAA@XZ ENDP
;----------------------------------------------------------------------------
??0COTime@System@RePag@@QEAA@PEBD@Z PROC ; COTime::COTime(const pcString)
		sub rsp, s_ShadowRegister
		mov rax, rcx
		mov rcx, rdx

		xor rdx, rdx
		mov qword ptr COTime_vmSpeicher[rax], rdx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
??0COTime@System@RePag@@QEAA@PEBD@Z ENDP
;----------------------------------------------------------------------------
??0COTime@System@RePag@@QEAA@PEBV012@@Z PROC ; COTime::COTime(pzZeit)
		mov rax, rax
		mov qword ptr COTime_vmSpeicher[rcx], rax

		mov eax, dword ptr COTime_FZeit_dwLowDateTime[rdx]
		mov dword ptr COTime_FZeit_dwLowDateTime[rcx], eax
		mov eax, dword ptr COTime_FZeit_dwHighDateTime[rdx]
		mov dword ptr COTime_FZeit_dwHighDateTime[rcx], eax
		mov eax, dword ptr COTime_FZeit_A_dwLowDateTime[rdx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], eax
		mov eax, dword ptr COTime_FZeit_A_dwHighDateTime[rdx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], eax

		ret
??0COTime@System@RePag@@QEAA@PEBV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
so16_stSystemTime = 48
sqp_this = 40
wYear = 0;
wMonth = 2;
wDayOfWeek = 4;
wDay = 6;
wHour = 8;
wMinute = 10;
wSecond = 12;
wMilliseconds = 14;
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??0COTime@System@RePag@@QEAA@AEBUSTTime@12@@Z PROC ; COTime::COTime(&stZeit)
		sub rsp, s_ShadowRegister
		mov rax, rdx

		xor r8, r8
		mov qword ptr COTime_vmSpeicher[rcx], r8

		mov word ptr so16_stSystemTime[rsp + wYear], 2019
		mov word ptr so16_stSystemTime[rsp + wMonth], 3
		mov word ptr so16_stSystemTime[rsp + wDayOfWeek], 4
		mov word ptr so16_stSystemTime[rsp + wDay], 13
		mov dword ptr so16_stSystemTime[rsp + wHour], r8d
		mov dword ptr so16_stSystemTime[rsp + wSecond], r8d

		movzx rdx, word ptr [rax + usJahr]
		mov word ptr so16_stSystemTime[rsp + wYear], dx
		movzx rdx, byte ptr [rax + ucMonat]
		mov word ptr so16_stSystemTime[rsp + wMonth], dx
		mov edx, dword ptr [rax + ulTag]
		mov word ptr so16_stSystemTime[rsp + wDay], dx
		movzx rdx, byte ptr [rax + ucStunde]
		mov word ptr so16_stSystemTime[rsp + wHour], dx
		movzx rdx, byte ptr [rax + ucMinute]
		mov word ptr so16_stSystemTime[rsp + wMinute], dx
		movzx rdx, byte ptr [rax + ucSekunde]
		mov word ptr so16_stSystemTime[rsp + wSecond], dx
		movzx rdx, word ptr [rax + usMillisekunde]
		mov word ptr so16_stSystemTime[rsp + wMilliseconds], dx

		mov qword ptr sqp_this[rsp], rcx

		mov rdx, rcx
		lea rcx, so16_stSystemTime[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rcx, qword ptr sqp_this[rsp]

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		add rsp, s_ShadowRegister
		ret
??0COTime@System@RePag@@QEAA@AEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
??0COTime@System@RePag@@QEAA@AEBU_SYSTEMTIME@@@Z PROC ; COTime::COTime(&stSystemTime)
		sub rsp, s_ShadowRegister
		xor rax, rax
		mov qword ptr COTime_vmSpeicher[rcx], rax

		mov qword ptr sqp_this[rsp], rcx
		mov r8, rdx
		mov rdx, rcx
		mov rcx, rdx
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
??0COTime@System@RePag@@QEAA@AEBU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so16_stSZeit = 48
sqp_this = 40
wMilliseconds = 14;
?Now@COTime@System@RePag@@QEAQPEAV123@XZ PROC ; COTime::Now(void)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_GetLocalTime ; GetLocalTime(lpSystemTime)

		xor rax, rax
		mov word ptr so16_stSZeit[rsp + wMilliseconds], ax

		mov rdx, qword ptr sqp_this[rsp]
		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?Now@COTime@System@RePag@@QEAQPEAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so16_stSZeit = 48
sqp_this = 40 
wHour = 8;
wSecond = 12;
?Today@COTime@System@RePag@@QEAQPEAV123@XZ PROC ; COTime::Today(void)
		sub rsp, s_ShadowRegister 

		mov qword ptr sqp_this[rsp], rcx

		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_GetLocalTime ; GetLocalTime(lpSystemTime)

		xor rax, rax
		mov dword ptr so16_stSZeit[rsp + wHour], eax
		mov dword ptr so16_stSZeit[rsp + wSecond], eax

		mov rdx, qword ptr sqp_this[rsp]
		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?Today@COTime@System@RePag@@QEAQPEAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
so16_stSZeit = 48
sqp_this = 40
wHour = 8;
wSecond = 12;
?Tommorow@COTime@System@RePag@@QEAQPEAV123@XZ PROC ; COTime::Tommorow(void)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx

		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_GetLocalTime ; GetLocalTime(lpSystemTime)

		xor rax, rax
		mov dword ptr so16_stSZeit[rsp + wHour], eax
		mov dword ptr so16_stSZeit[rsp + wSecond], eax

		mov rdx, qword ptr sqp_this[rsp]
		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rax, qword ptr sqp_this[rsp]
		vmovq xmm0, qword ptr [rax]
		vmovq xmm1, llMorgen
		vpaddq xmm0, xmm0, xmm1
		vmovq qword ptr [rax], xmm0

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
?Tommorow@COTime@System@RePag@@QEAQPEAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?IsZero@COTime@System@RePag@@QEAQ_NXZ PROC ; COTime::IsZero(void)
		xor rax, rax

		xor rdx, rdx
		cmp qword ptr COTime_FZeit_dwLowDateTime[rcx], rdx
		jne short Ende

		cmp qword ptr COTime_FZeit_dwHighDateTime[rcx], rdx
		jne short Ende
		add rax, 1

	Ende:
		ret
?IsZero@COTime@System@RePag@@QEAQ_NXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateStr = 0 + s_ShadowRegister
sqp_pcDatum = 56 + sa_Bytes
so16_stSZeit = 40 + sa_Bytes
?CHARDate@COTime@System@RePag@@QEAQPEADPEAD@Z PROC ; COTime::CHARDate(pcDatum)
		sub rsp, s_ShadowRegister + sa_Bytes

		mov qword ptr sqp_pcDatum[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 11
		mov r8, qword ptr sqp_pcDatum[rsp]
		mov qword ptr aqp_DateStr[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 1
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, pcDatum, 11)

		mov rax, qword ptr sqp_pcDatum[rsp]

		add rsp, s_ShadowRegister + sa_Bytes
		ret
?CHARDate@COTime@System@RePag@@QEAQPEADPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sl_Bytes = 16
sa_Bytes = 16
so11_pcDatum = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateStr = 0 + s_ShadowRegister
sqp_pasDatum = 56 + sa_Bytes + sl_Bytes
so16_stSZeit = 40 + sa_Bytes + sl_Bytes
?StrDate@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z PROC ; COTime::StrDate(pasDatum)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasDatum[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 11
		lea r8, so11_pcDatum[rsp]
		mov qword ptr aqp_DateStr[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 1
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, pcDatum, 11)

		lea rdx, so11_pcDatum[rsp]
		mov rcx, qword ptr sqp_pasDatum[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator=(pcString)

		mov rax, qword ptr sqp_pasDatum[rsp]

		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrDate@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
adi_BufferSize = 8 + s_ShadowRegister
aqp_ZeitString = 0 + s_ShadowRegister
sqp_pcZeit = 56 + sa_Bytes
so16_stSZeit = 40 + sa_Bytes
?CHARTime@COTime@System@RePag@@QEAQPEADPEAD@Z PROC ; COTime::CHARTime(pcZeit)
		sub rsp, s_ShadowRegister + sa_Bytes

		mov qword ptr sqp_pcZeit[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 9
		mov r8, qword ptr sqp_pcZeit[rsp]
		mov qword ptr aqp_ZeitString[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 8
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, pcZeit, 9)

		mov rax, qword ptr sqp_pcZeit[rsp]

		add rsp, s_ShadowRegister + sa_Bytes
		ret
?CHARTime@COTime@System@RePag@@QEAQPEADPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sl_Bytes = 16
sa_Bytes = 16
so11_pcZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_ZeitSring = 0 + s_ShadowRegister
sqp_pasZeit = 56 + sa_Bytes + sl_Bytes
so16_stSZeit = 40 + sa_Bytes + sl_Bytes
?StrTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z PROC ; COTime::StrTime(pasZeit)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasZeit[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 9
		lea r8, so11_pcZeit[rsp]
		mov qword ptr aqp_ZeitSring[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 8
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, s_pcZeit, 9)

		lea rdx, so11_pcZeit[rsp]
		mov rcx, qword ptr sqp_pasZeit[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator=(pcString)

		mov rax, qword ptr sqp_pasZeit[rsp]

		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 16
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateTimeString = 0 + s_ShadowRegister
sqp_pcDatumZeit = 40 + sa_Bytes + sl_Bytes
?CHARDateTime@COTime@System@RePag@@QEAQPEADPEAD@Z PROC ; COTime::CHARDateTime(pcDatumZeit)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pcDatumZeit[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 11
		mov r8, qword ptr sqp_pcDatumZeit[rsp]
		mov qword ptr aqp_DateTimeString[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 1
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, sqp_pcDatumZeit, 11)

		mov rcx, qword ptr sqp_pcDatumZeit[rsp]
		mov byte ptr [rcx + 10], 32

		mov dword ptr adi_BufferSize[rsp], 9
		mov r8, qword ptr sqp_pcDatumZeit[rsp]
		add r8, 11
		mov qword ptr aqp_DateTimeString[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 8
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, pcZeit, 9)

		mov rax, qword ptr sqp_pcDatumZeit[rsp]

		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?CHARDateTime@COTime@System@RePag@@QEAQPEADPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 16
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
aqp_Calender = 12 + s_ShadowRegister
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateTimeString = 0 + s_ShadowRegister
sqp_pasDatumZeit = 64 + sa_Bytes + sl_Bytes
so20_pcDatumZeit = 40 + sa_Bytes + sl_Bytes
?StrDateTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z PROC ; COTime::StrDateTime(pasDatumZeit)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasDatumZeit[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov dword ptr adi_BufferSize[rsp], 11
		lea r8, qword ptr so20_pcDatumZeit[rsp]
		mov qword ptr aqp_DateTimeString[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 1
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, so20_pcDatumZeit, 11)

		lea rcx, qword ptr so20_pcDatumZeit[rsp]
		mov byte ptr [rcx + 10], 32

		mov dword ptr adi_BufferSize[rsp], 9
		lea r8, qword ptr so20_pcDatumZeit[rsp]
		add r8, 11
		mov qword ptr aqp_DateTimeString[rsp], r8
		xor r9, r9
		lea r8, so16_stSZeit[rsp]
		mov rdx, 8
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, so20_pcDatumZeit, 9)

		lea rdx, qword ptr so20_pcDatumZeit[rsp]
		mov rcx, qword ptr sqp_pasDatumZeit[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator=(pcString)

		mov rax, qword ptr sqp_pasDatumZeit[rsp]

		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrDateTime@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@@Z ENDP

_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 16
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateString = 0 + s_ShadowRegister
sqp_vbDatum = 56 + sa_Bytes + sl_Bytes
sqp_pcFormat = 48 + sa_Bytes + sl_Bytes
sqp_pasDatum = 40 + sa_Bytes + sl_Bytes
?StrDateFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z PROC ; COTime::StrDateFormat(pasDatum, pcFormat)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasDatum[rsp], rdx
		mov qword ptr sqp_pcFormat[rsp], r8

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je short Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov qword ptr sqp_vbDatum[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_DateString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat, vbZeit, iBytes)

		test rax, rax
		je short VMFrei

		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov rcx, qword ptr sqp_pasDatum[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator=(pcString)

	VMFrei:
		mov rdx, qword ptr sqp_vbDatum[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov rax, qword ptr sqp_pasDatum[rsp]
		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrDateFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 16
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_TimeString = 0 + s_ShadowRegister
sqp_vbZeit = 56 + sa_Bytes + sl_Bytes
sqp_pcFormat = 48 + sa_Bytes + sl_Bytes
sqp_pasZeit = 40 + sa_Bytes + sl_Bytes
?StrTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z PROC ; COTime::StrTimeFormat(pasDatum, pcFormat)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasZeit[rsp], rdx
		mov qword ptr sqp_pcFormat[rsp], r8

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_TimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je short Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov qword ptr sqp_vbZeit[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_TimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)

		test rax, rax
		je short VMFrei

		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov rcx, qword ptr sqp_pasZeit[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator=(pcString)

	VMFrei:
		mov rdx, qword ptr sqp_vbZeit[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov rax, qword ptr sqp_pasZeit[rsp]
		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 32
sqp_vbZeit = 16 + s_ShadowRegister + sa_Bytes
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateTimeString = 0 + s_ShadowRegister
abi_Anordnung = 72 + sa_Bytes + sl_Bytes
sqp_vbDatum = 64 + sa_Bytes + sl_Bytes
sqp_pcFormat_Zeit = 56 + sa_Bytes + sl_Bytes
sqp_pcFormat_Datum = 48 + sa_Bytes + sl_Bytes
sqp_pasDatumZeit = 40 + sa_Bytes + sl_Bytes
?StrDateTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD1_N@Z PROC ; COTime::StrDateTimeFormat(pasDatumZeit, pcFormat_Datum, pcFormatz_Zeit, bAnordnung_DatumZeit)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_pasDatumZeit[rsp], rdx
		mov qword ptr sqp_pcFormat_Datum[rsp], r8
		mov qword ptr sqp_pcFormat_Zeit[rsp], r9
		xor rax, rax

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Datum[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat_Datum, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov qword ptr sqp_vbDatum[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Datum[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat_Datum, vbZeit, iBytes)

		test rax, rax
		je VMFrei_Datum

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Zeit[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je VMFrei_Datum

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov qword ptr sqp_vbZeit[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Zeit[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)

		test rax, rax
		je short VMFrei_Zeit

		mov al, byte ptr abi_Anordnung[rsp]
		test al, al
		jne short Datum_Zeit

		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov rcx, qword ptr sqp_pasDatumZeit[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator =(pcString)

		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov rcx, qword ptr sqp_pasDatumZeit[rsp]
		call ??YCOStringA@System@RePag@@QEAQXPEBD@Z ; COStringA::operator +=(pcString)
		jmp short VMFrei_Zeit

	Datum_Zeit:
		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov rcx, qword ptr sqp_pasDatumZeit[rsp]
		call ??4COStringA@System@RePag@@QEAQXPEBD@Z  ; COStringA::operator =(pcString)

		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov rcx, qword ptr sqp_pasDatumZeit[rsp]
		call ??YCOStringA@System@RePag@@QEAQXPEBD@Z ; COStringA::operator +=(pcString)

	VMFrei_Zeit:
		mov rdx, qword ptr sqp_vbZeit[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	VMFrei_Datum:
		mov rdx, qword ptr sqp_vbDatum[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov rax, qword ptr sqp_pasDatumZeit[rsp]
		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?StrDateTimeFormat@COTime@System@RePag@@QEAQPEAVCOStringA@23@PEAV423@PEBD1_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateString = 0 + s_ShadowRegister
so16_stSZeit = 56 + sa_Bytes
sqp_pcFormat = 48 + sa_Bytes
sqp_vbDatum = 40 + sa_Bytes
?VMBLOCKDateFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z PROC ; COTime::VMBLOCKDateFormat(&vbDatum, pcFormat)
		sub rsp, s_ShadowRegister + sa_Bytes

		mov qword ptr sqp_vbDatum[rsp], rdx
		mov qword ptr sqp_pcFormat[rsp], r8

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je short Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov qword ptr [rdx], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_DateString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat, vbZeit, iBytes)

	Ende:
		mov rax, qword ptr sqp_vbDatum[rsp]
		mov rax, qword ptr [rax]
		add rsp, s_ShadowRegister + sa_Bytes
		ret
?VMBLOCKDateFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
adi_BufferSize = 8 + s_ShadowRegister
aqp_TimeString = 0 + s_ShadowRegister
so16_stSZeit = 56 + sa_Bytes
sqp_pcFormat = 48 + sa_Bytes
sqp_vbZeit = 40 + sa_Bytes
?VMBLOCKTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z PROC ; COTime::VMBLOCKTimeFormat(&vbZeit, pcFormat)
		sub rsp, s_ShadowRegister + sa_Bytes

		mov qword ptr sqp_vbZeit[rsp], rdx
		mov qword ptr sqp_pcFormat[rsp], r8

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_TimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GeTimeFormat(Locale, NULL, stSZeit, sqp_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je short Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov qword ptr [rdx], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		mov qword ptr aqp_TimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, sqp_pcFormat, vbZeit, iBytes)

	Ende:
		mov rax, qword ptr sqp_vbZeit[rsp]
		mov rax, qword ptr [rax]
		add rsp, s_ShadowRegister + sa_Bytes
		ret
?VMBLOCKTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sa_Bytes = 16
sl_Bytes = 32
sdi_Bytes_Datum = 28 + s_ShadowRegister + sa_Bytes
sdi_Bytes_Zeit = 24 + s_ShadowRegister + sa_Bytes
sqp_vbZeit = 16 + s_ShadowRegister + sa_Bytes
so16_stSZeit = 0 + s_ShadowRegister + sa_Bytes
adi_BufferSize = 8 + s_ShadowRegister
aqp_DateTimeString = 0 + s_ShadowRegister
abi_Anordnung = 72 + sa_Bytes + sl_Bytes
sqp_vbDatum = 64 + sa_Bytes + sl_Bytes
sqp_pcFormat_Zeit = 56 + sa_Bytes + sl_Bytes
sqp_pcFormat_Datum = 48 + sa_Bytes + sl_Bytes
sqp_vbDatumZeit = 40 + sa_Bytes + sl_Bytes
?VMBLOCKDateTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD1_N@Z PROC ; COTime::VMBLOCKDateTimeFormat(&vbDatumZeit, pcFormat_Datum, pcFormat_Zeit, bAnordnung_DatumZeit)
		sub rsp, s_ShadowRegister + sa_Bytes + sl_Bytes

		mov qword ptr sqp_vbDatumZeit[rsp], rdx
		mov qword ptr sqp_pcFormat_Datum[rsp], r8
		mov qword ptr sqp_pcFormat_Zeit[rsp], r9
		xor rax, rax

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Datum[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat_Datum, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je Ende

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov qword ptr sqp_vbDatum[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		sub ecx, 1
		mov dword ptr sdi_Bytes_Datum[rsp], ecx

		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Datum[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetDateFormatA ; GetDateFormat(Locale, NULL, stSZeit, sqp_pcFormat_Datum, vbZeit, iBytes)

		test rax, rax
		je VMFrei_Datum

		xor rax, rax
		mov dword ptr adi_BufferSize[rsp], eax
		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Zeit[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr adi_BufferSize[rsp], eax

		test eax, eax
		je VMFrei_Datum

		mov rdx, rax
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov qword ptr sqp_vbZeit[rsp], rax

		mov dword ptr adi_BufferSize[rsp], ecx
		sub rcx, 1
		mov dword ptr sdi_Bytes_Zeit[rsp], ecx

		mov qword ptr aqp_DateTimeString[rsp], rax
		mov r9, qword ptr sqp_pcFormat_Zeit[rsp]
		lea r8, so16_stSZeit[rsp]
		xor rdx, rdx
		mov rcx, 1024
		call qword ptr __imp_GetTimeFormatA ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)

		test rax, rax
		je VMFrei_Zeit

		mov edx, dword ptr sdi_Bytes_Zeit[rsp]
		add edx, dword ptr sdi_Bytes_Datum[rsp]
		add rdx, 1
		mov dword ptr adi_BufferSize[rsp], edx
		xor rcx, rcx
    call ?VMBlock@System@RePag@@YQPEADPEBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr adi_BufferSize[rsp]
		mov byte ptr [rax + rcx - 1], 0
		mov rdx, qword ptr sqp_vbDatumZeit[rsp]
		mov qword ptr [rdx], rax

		mov al, byte ptr abi_Anordnung[rsp]
		test al, al
		jne short Datum_Zeit

		mov r8d, dword ptr sdi_Bytes_Zeit[rsp]
		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr sdi_Bytes_Datum[rsp]
		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov rcx, rax
		mov r9d, dword ptr sdi_Bytes_Zeit[rsp]
		add rcx, r9
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r9d, dword ptr sdi_Bytes_Zeit[rsp]
		sub rax, r9
		mov rdx, qword ptr sqp_vbDatumZeit[rsp]
		mov qword ptr [rdx], rax
		jmp short VMFrei_Zeit

	Datum_Zeit:
		mov r8d, dword ptr sdi_Bytes_Datum[rsp]
		mov rdx, qword ptr sqp_vbDatum[rsp]
		mov rcx, rax
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r8d, dword ptr sdi_Bytes_Zeit[rsp]
		mov rdx, qword ptr sqp_vbZeit[rsp]
		mov rcx, rax
		mov r9d, dword ptr sdi_Bytes_Datum[rsp]
		add rcx, r9
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		mov r9d, dword ptr sdi_Bytes_Datum[rsp]
		sub rax, r9
		mov rdx, qword ptr sqp_vbDatumZeit[rsp]
		mov qword ptr [rdx], rax

	VMFrei_Zeit:
		mov rdx, qword ptr sqp_vbZeit[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	VMFrei_Datum:
		mov rdx, qword ptr sqp_vbDatum[rsp]
		xor rcx, rcx
		call ?VMFrei@System@RePag@@YQXPEBXPEAX@Z ; VMFrei(vmSpeicher, vbAdresse)

	Ende:
		mov rax, qword ptr sqp_vbDatumZeit[rsp]
		mov rax, qword ptr [rax]
		add rsp, s_ShadowRegister + sa_Bytes + sl_Bytes
		ret
?VMBLOCKDateTimeFormat@COTime@System@RePag@@QEAQPEADAEAPEADPEBD1_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COTime@System@RePag@@QEAQXPEBD@Z PROC ; COTime::operator=(pcString)
		sub rsp, s_ShadowRegister
		mov rax, rcx
		mov rcx, rdx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[rax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rax], ecx

		add rsp, s_ShadowRegister
		ret
??4COTime@System@RePag@@QEAQXPEBD@Z ENDP
;----------------------------------------------------------------------------
??4COTime@System@RePag@@QEAQXAEBV012@@Z PROC ; COTime::operator=(&zZeit)
		mov rax, qword ptr COTime_FZeit_dwLowDateTime[rdx]
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], rax
		mov rax, qword ptr COTime_FZeit_A_dwLowDateTime[rdx]
		mov qword ptr COTime_FZeit_A_dwLowDateTime[rcx], rax
		ret
??4COTime@System@RePag@@QEAQXAEBV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
so16_stSZeit = 48
sqp_this = 40
wYear = 0;
wMonth = 2;
wDayOfWeek = 4;
wDay = 6;
wHour = 8;
wMinute = 10;
wSecond = 12;
wMilliseconds = 14;
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??4COTime@System@RePag@@QEAQXAEBUSTTime@12@@Z PROC ; COTime::operator=(&stZeit)
		sub rsp, s_ShadowRegister

		mov eax, dword ptr [rdx + ulTag]
		mov word ptr so16_stSZeit[rsp + wDay], ax
		movzx eax, byte ptr [rdx + ucMonat]
		mov word ptr so16_stSZeit[rsp + wMonth], ax
		movzx eax, word ptr [rdx + usJahr]
		mov word ptr so16_stSZeit[rsp + wYear], ax
		movzx eax, byte ptr [rdx + ucStunde]
		mov word ptr so16_stSZeit[rsp + wHour], ax
		movzx eax, byte ptr [rdx + ucMinute]
		mov word ptr so16_stSZeit[rsp + wMinute], ax
		movzx eax, byte ptr [rdx + ucSekunde]
		mov word ptr so16_stSZeit[rsp + wSecond], ax
		movzx eax, word ptr [rdx + usMillisekunde]
		mov word ptr so16_stSZeit[rsp + wMilliseconds], ax

		mov qword ptr sqp_this[rsp], rcx
		mov rdx, rcx
		lea rcx, so16_stSZeit[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		add rsp, s_ShadowRegister
		ret
??4COTime@System@RePag@@QEAQXAEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_this = 40
??4COTime@System@RePag@@QEAQXAEBU_SYSTEMTIME@@@Z PROC ; COTime::operator=(&stSystemTime)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_this[rsp], rcx
		mov rcx, rdx
		mov rdx, qword ptr sqp_this[rsp]
		call qword ptr __imp_SystemTimeToFileTime ; SystemTimeToFileTime(stSZeit, FZeit)

		mov rcx, qword ptr sqp_this[rsp]
		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		add rsp, s_ShadowRegister
		ret
??4COTime@System@RePag@@QEAQXAEBU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??MCOTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator<(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jle short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??MCOTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator>(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jge short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??OCOTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??NCOTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator<=(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jl short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??NCOTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??PCOTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator>=(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jg short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??PCOTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??8COTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator==(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jne short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??8COTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
??9COTime@System@RePag@@QEAQ_NAEBV012@@Z PROC ; COTime::operator!=(&zZeit)
		sub rsp, s_ShadowRegister

		xchg rdx, rcx
		call qword ptr __imp_CompareFileTime ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		je short False
		mov rax, 1
		jmp short Ende

	False:
		xor rax, rax

	Ende:
		add rsp, s_ShadowRegister
		ret
??9COTime@System@RePag@@QEAQ_NAEBV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??YCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z PROC ; COTime::operator+=(&stZeit)
		movzx rax, word ptr [rdx + usMillisekunde]
		imul rax, 10000
		mov r8, rax
		
		movzx rax, byte ptr [rdx + ucSekunde]
		test rax, rax
		je short Minute
		imul rax, 10000000
		add r8, rax

	Minute:
		movzx rax, byte ptr [rdx + ucMinute]
		test rax, rax
		je short Stunde
		imul rax, 600000000
		add r8, rax

	Stunde:
		movzx rax, byte ptr [rdx + ucStunde]
		test rax, rax
		je short Tag
		imul rax, dqi_Stunde
		add r8, rax

	Tag:
		mov eax, dword ptr [rdx + ulTag]
		test rax, rax
		je short Ende
		imul rax, dqi_Tag
		add r8, rax

	Ende:
		mov r9, qword ptr COTime_FZeit_dwLowDateTime[rcx]
		add r8, r9
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], r8

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		ret
??YCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??YCOTime@System@RePag@@QEAQX_J@Z PROC ; COTime::operator+=(llDiffSekunden)
		imul rdx, 10000000

		mov rax, qword ptr COTime_FZeit_dwLowDateTime[rcx] 
		add rdx, rax
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], rdx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		ret
??YCOTime@System@RePag@@QEAQX_J@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??ZCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z PROC ; COTime::operator-=(&stZeit)
		movzx rax, word ptr [rdx + usMillisekunde]
		imul rax, 10000
		mov r8, rax
		
		movzx rax, byte ptr [rdx + ucSekunde]
		test rax, rax
		je short Minute
		imul rax, 10000000
		add r8, rax

	Minute:
		movzx rax, byte ptr [rdx + ucMinute]
		test rax, rax
		je short Stunde
		imul rax, 600000000
		add r8, rax

	Stunde:
		movzx rax, byte ptr [rdx + ucStunde]
		test rax, rax
		je short Tag
		imul rax, dqi_Stunde
		add r8, rax

	Tag:
		mov eax, dword ptr [rdx + ulTag]
		test rax, rax
		je short Ende
		imul rax, dqi_Tag
		add r8, rax

	Ende:
		mov r9, qword ptr COTime_FZeit_dwLowDateTime[rcx]
		sub r9, r8
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], r9

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		ret
??ZCOTime@System@RePag@@QEAQXAEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??ZCOTime@System@RePag@@QEAQX_J@Z PROC ; COTime::operator-=(llDiffSekunden)
		imul rdx, 10000000

		mov rax, qword ptr COTime_FZeit_dwLowDateTime[rcx] 
		sub rax, rdx
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], rax

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		ret
??ZCOTime@System@RePag@@QEAQX_J@Z ENDP
;----------------------------------------------------------------------------
??HCOTime@System@RePag@@QEAQAEAV012@_J@Z PROC ; COTime::operator+(llDiffSekunden)
		imul rdx, 10000000

		mov rax, qword ptr COTime_FZeit_dwLowDateTime[rcx] 
		add rdx, rax
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], rdx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		mov rax, rcx
		ret
??HCOTime@System@RePag@@QEAQAEAV012@_J@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??HCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z PROC ; COTime::operator+(&stZeit)
		movzx rax, word ptr [rdx + usMillisekunde]
		imul rax, 10000
		mov r8, rax
		
		movzx rax, byte ptr [rdx + ucSekunde]
		test rax, rax
		je short Minute
		imul rax, 10000000
		add r8, rax

	Minute:
		movzx rax, byte ptr [rdx + ucMinute]
		test rax, rax
		je short Stunde
		imul rax, 600000000
		add r8, rax

	Stunde:
		movzx rax, byte ptr [rdx + ucStunde]
		test rax, rax
		je short Tag
		imul rax, dqi_Stunde
		add r8, rax

	Tag:
		mov eax, dword ptr [rdx + ulTag]
		test rax, rax
		je short Ende
		imul rax, dqi_Tag
		add r8, rax

	Ende:
		mov r9, qword ptr COTime_FZeit_dwLowDateTime[rcx]
		add r8, r9
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], r8

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		mov rax, rcx
		ret
??HCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??GCOTime@System@RePag@@QEAQAEAV012@_J@Z PROC ; COTime::operator-(llDiffSekunden)
		imul rdx, 10000000

		mov rax, qword ptr COTime_FZeit_dwLowDateTime[rcx] 
		sub rax, rdx
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], rax

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		mov rax, rcx
		ret
??GCOTime@System@RePag@@QEAQAEAV012@_J@Z ENDP
;----------------------------------------------------------------------------
??GCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z PROC ; COTime::operator-(&stZeit)
		movzx rax, word ptr [rdx + usMillisekunde]
		imul rax, 10000
		mov r8, rax
		
		movzx rax, byte ptr [rdx + ucSekunde]
		test rax, rax
		je short Minute
		imul rax, 10000000
		add r8, rax

	Minute:
		movzx rax, byte ptr [rdx + ucMinute]
		test rax, rax
		je short Stunde
		imul rax, 600000000
		add r8, rax

	Stunde:
		movzx rax, byte ptr [rdx + ucStunde]
		test rax, rax
		je short Tag
		imul rax, dqi_Stunde
		add r8, rax

	Tag:
		mov eax, dword ptr [rdx + ulTag]
		test rax, rax
		je short Ende
		imul rax, dqi_Tag
		add r8, rax

	Ende:
		mov r9, qword ptr COTime_FZeit_dwLowDateTime[rcx]
		sub r9, r8
		mov qword ptr COTime_FZeit_dwLowDateTime[rcx], r9

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[rcx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[rcx], edx

		mov rax, rcx
		ret
??GCOTime@System@RePag@@QEAQAEAV012@AEBUSTTime@12@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
?DifferenceTime@COTime@System@RePag@@QEAQXPEBV123@AEAUSTTime@23@@Z PROC ; COTime::DifferenceTime(pzZeit, &stZeit)
		mov r9, qword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov r10, qword ptr COTime_FZeit_dwLowDateTime[rdx]

		mov eax, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		cmp dword ptr COTime_FZeit_dwHighDateTime[rdx], eax
		ja short Zweiter_Grosser

		mov eax, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		cmp dword ptr COTime_FZeit_dwLowDateTime[rdx], eax
		ja short Zweiter_Grosser
		sub r9, r10
		mov rax, r9
		jmp short Ende

	Zweiter_Grosser:
		sub r10, r9
		mov rax, r10

	Ende:
		mov word ptr [r8 + usJahr], 0
		mov byte ptr [r8 + ucMonat], 0

		xor rdx, rdx
		div dqi_Tag
		mov dword ptr [r8 + ulTag], eax
		mov rax, rdx
		xor rdx, rdx
		div dqi_Stunde
		mov byte ptr [r8 + ucStunde], al
		mov rax, rdx
		xor rdx, rdx
		div dqi_Minute
		mov byte ptr [r8 + ucMinute], al
		mov rax, rdx
		xor rdx, rdx
		div dqi_Sekunde
		mov byte ptr [r8 + ucSekunde], al
		mov rax, rdx
		xor rdx, rdx
		div dqi_Millisekunde
		mov word ptr [r8 + usMillisekunde], ax

	Ende_1:
		ret
?DifferenceTime@COTime@System@RePag@@QEAQXPEBV123@AEAUSTTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Inhalt = 48
sqp_this = 40
?Read@COTime@System@RePag@@QEAQXPEAD@Z PROC ; COTime::Read(pcInhalt)
		sub rsp, s_ShadowRegister

		test rdx, rdx
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Inhalt[rsp], rdx

		mov r8, 4
		lea rdx, COTime_FZeit_dwHighDateTime[rcx]
		mov rcx, qword ptr sqp_Inhalt[rsp]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r9, qword ptr sqp_this[rsp]
		;mov rdx, qword ptr sqp_Inhalt[rsp]

		mov r8, 4
		lea rdx, COTime_FZeit_dwLowDateTime[r9]
		mov rcx, qword ptr sqp_Inhalt[rsp]
		add rcx, 4
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Ende:
	  add rsp, s_ShadowRegister
		ret
?Read@COTime@System@RePag@@QEAQXPEAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Inhalt = 48
sqp_this = 40
?Write@COTime@System@RePag@@QEAQXPEBD@Z PROC ; COTime::Write(pcInhalt)
		sub rsp, s_ShadowRegister
		
		test rdx, rdx
		je short Ende

		mov qword ptr sqp_this[rsp], rcx
		mov qword ptr sqp_Inhalt[rsp], rdx

		mov r8, 4
		lea rcx, COTime_FZeit_dwHighDateTime[rcx]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r9, qword ptr sqp_this[rsp]
		mov rdx, qword ptr sqp_Inhalt[rsp]

		mov r8, 4
		add rdx, 4
		lea rcx, COTime_FZeit_dwLowDateTime[r9]
		call ?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov r9, qword ptr sqp_this[rsp]
		mov edx, dword ptr COTime_FZeit_dwLowDateTime[r9]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[r9], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[r9]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[r9], edx

	Ende:
		add rsp, s_ShadowRegister
		ret
?Write@COTime@System@RePag@@QEAQXPEBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?FileTime@COTime@System@RePag@@QEAQ?AU_FILETIME@@XZ PROC ; COTime::FileTime(void)
		mov eax, dword ptr COTime_FZeit_dwLowDateTime[rcx]
		mov dword ptr COTime_FZeit_dwLowDateTime[rdx], eax
		mov eax, dword ptr COTime_FZeit_dwHighDateTime[rcx]
		mov dword ptr COTime_FZeit_dwHighDateTime[rdx], eax
		mov rax, rdx
		ret
?FileTime@COTime@System@RePag@@QEAQ?AU_FILETIME@@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
sqp_Return = 56
so16_stSZeit = 40
?SystemTime@COTime@System@RePag@@QEAQ?AU_SYSTEMTIME@@XZ PROC ; COTime::SystemTime(void)
		sub rsp, s_ShadowRegister

		mov qword ptr sqp_Return[rsp], rdx

		lea rdx, so16_stSZeit[rsp]
		call qword ptr __imp_FileTimeToSystemTime ; FileTimeToSystemTime(FZeit, stSZeit)

		mov rdx, qword ptr sqp_Return[rsp]
		mov rax, qword ptr so16_stSZeit[rsp]
		mov dword ptr [rdx], eax
		mov eax, dword ptr so16_stSZeit[rsp + 4]
		mov dword ptr [rdx + 4], eax
		mov eax, dword ptr so16_stSZeit[rsp + 8]
		mov dword ptr [rdx + 8], eax
		mov eax, dword ptr so16_stSZeit[rsp + 12]
		mov dword ptr [rdx + 12], eax
		mov rax, rdx

		add rsp, s_ShadowRegister
		ret
?SystemTime@COTime@System@RePag@@QEAQ?AU_SYSTEMTIME@@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OZeit ENDS
END