;****************************************************************************
;  OZeit_x86.asm
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

.686P
.XMM
.MODEL FLAT
INCLUDE listing.inc
INCLUDE ..\..\Include\CompSys.inc
INCLUDE ..\..\Include\ADT.inc
INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

EXTRN	__imp__SystemTimeToFileTime@8:PROC
EXTRN __imp__GetLocalTime@4:PROC
EXTRN __imp__FileTimeToSystemTime@8:PROC
EXTRN __imp__GetDateFormatA@24:PROC
EXTRN __imp__GetTimeFormatA@24:PROC
EXTRN	__imp__CompareFileTime@8:PROC
EXTRN	??0COStringA@System@RePag@@QAE@PBD@Z:PROC
EXTRN ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z:PROC
EXTRN ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z:PROC
EXTRN ?CharactersPosition@System@RePag@@YQKPBDKD_N@Z:PROC
EXTRN ??1COStringA@System@RePag@@QAE@XZ:PROC
EXTRN ??4COStringA@System@RePag@@QAQXPBD@Z:PROC
EXTRN ??YCOStringA@System@RePag@@QAQXPBD@Z:PROC

.DATA
ucBY_COZEIT DB 20
llMorgen DQ 864000000000
pcLeer DB " ", 0
llMillisekunde DQ 10000
llSekunde DQ 10000000
llMinute DQ 600000000
llStunde DQ 36000000000
llTag DQ 864000000000
dwSieben_Null DD 10000000

CS_OZeit SEGMENT EXECUTE
;----------------------------------------------------------------------------
?COTimeV@System@RePag@@YQPAVCOTime@12@XZ PROC ; COTimeV(void)
    movzx edx, ucBY_COZEIT
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pxor xmm7, xmm7
		movdqu xmmword ptr [eax], xmm7
		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@XZ ENDP
;----------------------------------------------------------------------------
?COTimeV@System@RePag@@YQPAVCOTime@12@PBX@Z PROC ; COTimeV(vmSpeicher)
		push ecx ; vmSpeicher

    movzx edx, ucBY_COZEIT
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; vmSpeicher

		pxor xmm7, xmm7
		movdqu xmmword ptr [eax], xmm7
		mov dword ptr COTime_vmSpeicher[eax], ecx
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBX@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 56
s_asZiffer = 36
s_asString = 16
s_stSystemTime = 0
wYear = 0;
wMonth = 2;
wDayOfWeek = 4;
wDay = 6;
wHour = 8;
wMinute = 10;
wSecond = 12;
wMilliseconds = 14;
StringZuFILETIME PROC PRIVATE
		sub esp, esp_Bytes
		push eax ; COTime

		mov word ptr s_stSystemTime[esp + 4 + wYear], 2006
		mov word ptr s_stSystemTime[esp + 4 + wMonth], 11
		mov word ptr s_stSystemTime[esp + 4 + wDayOfWeek], 3
		mov word ptr s_stSystemTime[esp + 4 + wDay], 29
		mov dword ptr s_stSystemTime[esp + 4 + wHour], 0
		mov dword ptr s_stSystemTime[esp + 4 + wSecond], 0	

		push ecx ; pcString
		push ecx
		lea ecx, s_asString[esp + 12]
		call ??0COStringA@System@RePag@@QAE@PBD@Z ; COStringA::COStringA(pcString)

		pop ecx ; pcString

		mov dword ptr s_asZiffer[esp + 4 + COStringA_vbInhalt], 0
		mov dword ptr s_asZiffer[esp + 4 + COStringA_ulLange], 0
		mov dword ptr s_asZiffer[esp + 4 + COStringA_vbInhalt_A], 0
		mov dword ptr s_asZiffer[esp + 4 + COStringA_ulLange_A], 0
		mov dword ptr s_asZiffer[esp + 4 + COStringA_vmSpeicher], 0

		;mov eax, dword ptr s_asString[esp + 4 + COStringA_ulLange]
		cmp dword ptr s_asString[esp + 4 + COStringA_ulLange], 10
		jb short Lange_8
		ja Lange_17
		push 2
		push 1
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wDay]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 5
		push 4
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMonth]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 10
		push 7
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wYear]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		mov dword ptr s_stSystemTime[esp + 4 + wHour], 0
		mov dword ptr s_stSystemTime[esp + 4 + wSecond], 0
		jmp Ende

	Lange_8:
		push 1
		push 58
		mov edx, dword ptr s_asString[esp + 12 + COStringA_ulLange]
		call ?CharactersPosition@System@RePag@@YQKPBDKD_N@Z ; CharactersPosition(pcString, ulLength, cCharacters, bFromLefttoRight)
		cmp eax, 2
		jne Lange_8A

		push 2
		push 1
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wHour]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 5
		push 4
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMinute]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 8
		push 7
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wSecond]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr s_stSystemTime[esp + 4 + wMilliseconds], 0
		jmp Ende

	Lange_8A:
		push 2
		push 1
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wDay]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 5
		push 4
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMonth]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 8
		push 7
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp+ 4 + wYear]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		add word ptr s_stSystemTime[esp + 4 + wYear], 2000
		mov dword ptr s_stSystemTime[esp + 4 + wHour], 0
		mov dword ptr s_stSystemTime[esp + 4 + wSecond], 0
		jmp Ende

	Lange_17:
		cmp dword ptr s_asString[esp + 4 + COStringA_ulLange], 19
		je Lange_19

		push 2
		push 1
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wDay]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 5
		push 4
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMonth]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 8
		push 7
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wYear]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		add word ptr s_stSystemTime[esp + 4 + wYear], 2000

		push 11
		push 10
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wHour]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 14
		push 13
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMinute]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 17
		push 16
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wSecond]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr s_stSystemTime[esp + 4 + wMilliseconds], 0
		jmp Ende

	Lange_19:
		push 2
		push 1
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wDay]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 5
		push 4
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMonth]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 10
		push 7
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wYear]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 13
		push 12
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wHour]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 16
		push 15
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wMinute]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)

		push 19
		push 18
		lea edx, s_asZiffer[esp + 12]
		lea ecx, s_asString[esp + 12]
		call ?SubString@COStringA@System@RePag@@QAQPAV123@PBV123@KK@Z ; COStringA::SubString(pasString, ulVon, ulBis)
		lea edx, s_stSystemTime[esp + 4 + wSecond]
		lea ecx, s_asZiffer[esp + 4]
		call ?USHORT@COStringA@System@RePag@@QAQAAGAAG@Z ; COStringA::USHORT(&usZahl)
		mov word ptr s_stSystemTime[esp + 4 + wMilliseconds], 0

	Ende:
		pop eax ; COTime
		push eax ; COTime
		push eax
		lea edx, s_stSystemTime[esp + 8]
		push edx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		lea ecx, dword ptr s_asZiffer[esp + 4]
		call ??1COStringA@System@RePag@@QAE@XZ ; ~COStringA(void)
		lea ecx, dword ptr s_asString[esp + 4]
		call ??1COStringA@System@RePag@@QAE@XZ ; ~COStringA(void)

		pop eax ; COTime
		
		add esp, esp_Bytes
		ret 0
StringZuFILETIME ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COTimeV@System@RePag@@YQPAVCOTime@12@PBD@Z PROC ; COTimeV(const pcString)
		push ecx ; pcString

    movzx edx, ucBY_COZEIT
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		
		pop ecx ; pcString

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBD@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pcString = 4
s_vmSpeicher = 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBD@Z PROC ; COTimeV(vmSpeicher, pcString)
		sub esp, esp_Bytes

		mov dword ptr s_vmSpeicher[esp], ecx
		mov dword ptr s_pcString[esp], edx

    movzx edx, ucBY_COZEIT
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov edx, dword ptr s_vmSpeicher[esp]
		mov ecx, dword ptr s_pcString[esp]

		mov dword ptr COTime_vmSpeicher[eax], edx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 4
s_Temp = 0
?COTimeV@System@RePag@@YQPAVCOTime@12@ABU_SYSTEMTIME@@@Z PROC ; COTimeV(stSystemTime)
		sub esp, esp_Bytes

		;push ecx ; stSystemTime
		mov dword ptr s_Temp[esp], ecx  ; stSystemTime

    movzx edx, ucBY_COZEIT
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		;pop ecx ; stSystemTime
		mov ecx, dword ptr s_Temp[esp]  ; stSystemTime

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		;push eax
		mov dword ptr s_Temp[esp], eax
		push eax
		push ecx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		;pop eax
		mov eax, dword ptr s_Temp[esp]
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@ABU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_Temp = 4
s_vmSpeicher = 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABU_SYSTEMTIME@@@Z PROC ; COTimeV(vmSpeicher, stSystemTime)
		sub esp, esp_Bytes

		mov dword ptr s_Temp[esp], edx ; SystemTime
		mov dword ptr s_vmSpeicher[esp], ecx

    movzx edx, ucBY_COZEIT
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		mov ecx, dword ptr s_Temp[esp] ; SystemTime
		mov edx, dword ptr s_vmSpeicher[esp]

		mov dword ptr COTime_vmSpeicher[eax], edx

		;push eax
		mov dword ptr s_Temp[esp], eax ; COTime
		push eax
		push ecx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		;pop eax
		mov eax, dword ptr s_Temp[esp] ; COTime
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COTimeV@System@RePag@@YQPAVCOTime@12@PBV312@@Z PROC ; COTimeV(pzZeit)
		push ecx ; pzZeit

    movzx edx, ucBY_COZEIT
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; pzZeit

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_dwLowDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_dwHighDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_A_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_A_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], edx

		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBV312@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_pzZeit = 4
s_vmSpeicher = 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBV312@@Z PROC ; COTimeV(vmSpeicher, pzZeit)
		sub esp, esp_Bytes

		;push edx ; pzZeit
		;push ecx ; vmSpeicher
		mov dword ptr s_pzZeit[esp], edx
		mov dword ptr s_vmSpeicher[esp], ecx

    movzx edx, ucBY_COZEIT
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		;pop edx ; vmSpeicher
		;pop ecx ; pzZeit
		mov edx, dword ptr s_vmSpeicher[esp]
		mov ecx, dword ptr s_pzZeit[esp]

		mov dword ptr COTime_vmSpeicher[eax], edx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_dwLowDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_dwHighDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_A_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], edx
		mov edx, dword ptr COTime_FZeit_A_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], edx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXPBV312@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSystemTime = 0
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
?COTimeV@System@RePag@@YQPAVCOTime@12@ABUSTTime@12@@Z PROC ; COTimeV(&stZeit)
		sub esp, esp_Bytes
		push ecx ; stZeit

    movzx edx, ucBY_COZEIT
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop ecx ; stZeit

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		mov word ptr s_stSystemTime[esp + wYear], 2011
		mov word ptr s_stSystemTime[esp + wMonth], 7
		mov word ptr s_stSystemTime[esp + wDayOfWeek], 3
		mov word ptr s_stSystemTime[esp + wDay], 23
		mov dword ptr s_stSystemTime[esp + wHour], edx
		mov dword ptr s_stSystemTime[esp + wSecond], edx

		movzx edx, word ptr [ecx + usJahr]
		mov word ptr s_stSystemTime[esp + wYear], dx
		movzx edx, byte ptr [ecx + ucMonat]
		mov word ptr s_stSystemTime[esp + wMonth], dx
		mov edx, dword ptr [ecx + ulTag]
		mov word ptr s_stSystemTime[esp + wDay], dx
		movzx edx, byte ptr [ecx + ucStunde]
		mov word ptr s_stSystemTime[esp + wHour], dx
		movzx edx, byte ptr [ecx + ucMinute]
		mov word ptr s_stSystemTime[esp + wMinute], dx
		movzx edx, byte ptr [ecx + ucSekunde]
		mov word ptr s_stSystemTime[esp + wSecond], dx
		movzx edx, word ptr [ecx + usMillisekunde]
		mov word ptr s_stSystemTime[esp + wMilliseconds], dx

		push eax
		push eax
		lea ecx, s_stSystemTime[esp + 8]
		push ecx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		pop eax

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@ABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSystemTime = 0
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
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABUSTTime@12@@Z PROC ; COTimeV(vmSpeicher, &stZeit)
		sub esp, esp_Bytes

		push edx ; stZeit
		push ecx ; vmSpeicher

    movzx edx, ucBY_COZEIT
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)

		pop edx ; vmSpeicher
		pop ecx ; stZeit

		mov dword ptr COTime_vmSpeicher[eax], edx

		mov word ptr s_stSystemTime[esp + wYear], 2011
		mov word ptr s_stSystemTime[esp + wMonth], 7
		mov word ptr s_stSystemTime[esp + wDayOfWeek], 3
		mov word ptr s_stSystemTime[esp + wDay], 23
		mov dword ptr s_stSystemTime[esp + wHour], edx
		mov dword ptr s_stSystemTime[esp + wSecond], edx

		movzx edx, word ptr [ecx + usJahr]
		mov word ptr s_stSystemTime[esp + wYear], dx
		movzx edx, byte ptr [ecx + ucMonat]
		mov word ptr s_stSystemTime[esp + wMonth], dx
		mov edx, dword ptr [ecx + ulTag]
		mov word ptr s_stSystemTime[esp + wDay], dx
		movzx edx, byte ptr [ecx + ucStunde]
		mov word ptr s_stSystemTime[esp + wHour], dx
		movzx edx, byte ptr [ecx + ucMinute]
		mov word ptr s_stSystemTime[esp + wMinute], dx
		movzx edx, byte ptr [ecx + ucSekunde]
		mov word ptr s_stSystemTime[esp + wSecond], dx
		movzx edx, word ptr [ecx + usMillisekunde]
		mov word ptr s_stSystemTime[esp + wMilliseconds], dx

		push eax
		push eax
		lea ecx, s_stSystemTime[esp + 8]
		push ecx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		pop eax

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		add esp, esp_Bytes
		ret 0
?COTimeV@System@RePag@@YQPAVCOTime@12@PBXABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?COFreiV@COTime@System@RePag@@QAQPBXXZ PROC ; COTime::COFreiV(void)
		mov eax, dword ptr COTime_vmSpeicher[ecx]
		ret 0
?COFreiV@COTime@System@RePag@@QAQPBXXZ ENDP
;----------------------------------------------------------------------------
??0COTime@System@RePag@@QAE@XZ PROC ; COTime::COTime(void)
		pxor xmm7, xmm7
		movdqu xmmword ptr COTime_FZeit_dwLowDateTime[ecx], xmm7
		xor eax, eax
		mov dword ptr COTime_vmSpeicher[ecx], eax

		ret 0
??0COTime@System@RePag@@QAE@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
a_pcString = 4
??0COTime@System@RePag@@QAE@PBD@Z PROC ; COTime::COTime(const pcString)
		mov eax, ecx
		mov ecx, a_pcString[esp]

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[eax], edx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		ret 4
??0COTime@System@RePag@@QAE@PBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_pzZeit = 4
??0COTime@System@RePag@@QAE@PBV0@@Z PROC ; COTime::COTime(pzZeit)
		mov eax, dword ptr a_pzZeit[esp]

		mov edx, edx
		mov dword ptr COTime_vmSpeicher[ecx], edx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_dwHighDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_A_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_A_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		ret 4
??0COTime@System@RePag@@QAE@PBV0@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSystemTime = 0
a_stZeit = esp_bytes + 4
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
??0COTime@System@RePag@@QAE@ABUSTTime@12@@Z PROC ; COTime::COTime(&stZeit)
		sub esp, esp_Bytes
		mov eax, dword ptr a_stZeit[esp]

		xor edx, edx
		mov dword ptr COTime_vmSpeicher[ecx], edx

		mov word ptr s_stSystemTime[esp + wYear], 2019
		mov word ptr s_stSystemTime[esp + wMonth], 3
		mov word ptr s_stSystemTime[esp + wDayOfWeek], 4
		mov word ptr s_stSystemTime[esp + wDay], 13
		mov dword ptr s_stSystemTime[esp + wHour], edx
		mov dword ptr s_stSystemTime[esp + wSecond], edx

		movzx edx, word ptr [eax + usJahr]
		mov word ptr s_stSystemTime[esp + wYear], dx
		movzx edx, byte ptr [eax + ucMonat]
		mov word ptr s_stSystemTime[esp + wMonth], dx
		mov edx, dword ptr [eax + ulTag]
		mov word ptr s_stSystemTime[esp + wDay], dx
		movzx edx, byte ptr [eax + ucStunde]
		mov word ptr s_stSystemTime[esp + wHour], dx
		movzx edx, byte ptr [eax + ucMinute]
		mov word ptr s_stSystemTime[esp + wMinute], dx
		movzx edx, byte ptr [eax + ucSekunde]
		mov word ptr s_stSystemTime[esp + wSecond], dx
		movzx edx, word ptr [eax + usMillisekunde]
		mov word ptr s_stSystemTime[esp + wMilliseconds], dx

		push ecx
		push ecx
		lea ecx, s_stSystemTime[esp + 8]
		push ecx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		pop ecx

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		add esp, esp_Bytes
		ret 4
??0COTime@System@RePag@@QAE@ABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
a_stSystemTime = 4
??0COTime@System@RePag@@QAE@ABU_SYSTEMTIME@@@Z PROC ; COTime::COTime(&stSystemTime)
		xor edx, edx
		mov dword ptr COTime_vmSpeicher[ecx], edx

		push ecx ; this
		push ecx
		push dword ptr a_stSystemTime[esp + 8]
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		pop eax ; this
		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		ret 4
??0COTime@System@RePag@@QAE@ABU_SYSTEMTIME@@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSZeit = 0
wMilliseconds = 14;
?Now@COTime@System@RePag@@QAQPAV123@XZ PROC ; COTime::Now(void)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx

		lea eax, s_stSZeit[esp]
		push eax
		call dword ptr __imp__GetLocalTime@4 ; GetLocalTime(lpSystemTime)

		xor eax, eax
		mov word ptr s_stSZeit[esp + wMilliseconds], ax

		push ebp
		lea eax, s_stSZeit[esp + 4]
		push eax
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ebp], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ebp], ecx

		mov eax, ebp

		add esp, esp_Bytes
		pop ebp
		ret 0
?Now@COTime@System@RePag@@QAQPAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSZeit = 0
wHour = 8;
wSecond = 12;
?Today@COTime@System@RePag@@QAQPAV123@XZ PROC ; COTime::Today(void)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx

		lea eax, s_stSZeit[esp]
		push eax
		call dword ptr __imp__GetLocalTime@4 ; GetLocalTime(lpSystemTime)

		xor eax, eax
		mov dword ptr s_stSZeit[esp + wHour], eax
		mov dword ptr s_stSZeit[esp + wSecond], eax

		push ebp
		lea eax, s_stSZeit[esp + 4]
		push eax
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ebp], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ebp], ecx

		mov eax, ebp

		add esp, esp_Bytes
		pop ebp
		ret 0
?Today@COTime@System@RePag@@QAQPAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_stSZeit = 0
wHour = 8;
wSecond = 12;
?Tommorow@COTime@System@RePag@@QAQPAV123@XZ PROC ; COTime::Tommorow(void)
		push ebp
		sub esp, esp_Bytes

		mov ebp, ecx

		lea eax, s_stSZeit[esp]
		push eax
		call dword ptr __imp__GetLocalTime@4 ; GetLocalTime(lpSystemTime)

		xor eax, eax
		mov dword ptr s_stSZeit[esp + wHour], eax
		mov dword ptr s_stSZeit[esp + wSecond], eax

		push ebp
		lea eax, s_stSZeit[esp + 4]
		push eax
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		movq xmm0, qword ptr [ebp]
		movq xmm1, llMorgen
		paddq xmm0, xmm1
		movq qword ptr [ebp], xmm0

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ebp], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ebp], ecx

		mov eax, ebp

		add esp, esp_Bytes
		pop ebp
		ret 0
?Tommorow@COTime@System@RePag@@QAQPAV123@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
?IsZero@COTime@System@RePag@@QAQ_NXZ PROC ; COTime::IsZero(void)
		xor eax, eax

		xor edx, edx
		cmp dword ptr COTime_FZeit_dwLowDateTime[ecx], edx
		jne short Ende

		cmp dword ptr COTime_FZeit_dwHighDateTime[ecx], edx
		jne short Ende
		add eax, 1

	Ende:
		ret 0
?IsZero@COTime@System@RePag@@QAQ_NXZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_pcDatum = 16
s_stSZeit = 0
?CHARDate@COTime@System@RePag@@QAQPADPAD@Z PROC ; COTime::CHARDate(pcDatum)
		sub esp, esp_Bytes

		mov dword ptr s_pcDatum[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 11
		push dword ptr s_pcDatum[esp + 4]
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 1
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, pcDatum, 11)

		mov eax, dword ptr s_pcDatum[esp]

		add esp, esp_Bytes
		ret 0
?CHARDate@COTime@System@RePag@@QAQPADPAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 32
s_pcZeit = 20
s_pasDatum = 16
s_stSZeit = 0
?StrDate@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z PROC ; COTime::StrDate(pasDatum)
		sub esp, esp_Bytes

		mov dword ptr s_pasDatum[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 11
		lea eax, s_pcZeit[esp + 4]
		push eax
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 1
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, s_pcZeit, 11)

		lea edx, s_pcZeit[esp]
		mov ecx, dword ptr s_pasDatum[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

		mov eax, dword ptr s_pasDatum[esp]

		add esp, esp_Bytes
		ret 0
?StrDate@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_pcZeit = 16
s_stSZeit = 0
?CHARTime@COTime@System@RePag@@QAQPADPAD@Z PROC ; COTime::CHARTime(pcZeit)
		sub esp, esp_Bytes

		mov dword ptr s_pcZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 9
		push dword ptr s_pcZeit[esp + 4]
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 8
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, pcZeit, 9)

		mov eax, dword ptr s_pcZeit[esp]

		add esp, esp_Bytes
		ret 0
?CHARTime@COTime@System@RePag@@QAQPADPAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 32
s_pcZeit = 20
s_pasZeit = 16
s_stSZeit = 0
?StrTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z PROC ; COTime::StrTime(pasZeit)
		sub esp, esp_Bytes

		mov dword ptr s_pasDatum[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 9
		lea eax, s_pcZeit[esp + 4]
		push eax
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 8
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, s_pcZeit, 9)

		lea edx, s_pcZeit[esp]
		mov ecx, dword ptr s_pasDatum[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

		mov eax, dword ptr s_pasDatum[esp]

		add esp, esp_Bytes
		ret 0
?StrTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 32
s_pcZeit = 20
s_pcDatumZeit = 16
s_stSZeit = 0
?CHARDateTime@COTime@System@RePag@@QAQPADPAD@Z PROC ; COTime::CHARDateTime(pcDatumZeit)
		sub esp, esp_Bytes

		mov dword ptr s_pcDatumZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 11
		push dword ptr s_pcDatumZeit[esp + 4]
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 1
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, s_pcDatumZeit, 11)

		mov ecx, dword ptr s_pcDatumZeit[esp]
		mov byte ptr [ecx + 10], 32

		push 9
		;lea eax, s_pcZeit[esp + 4]
		mov eax, dword ptr s_pcDatumZeit[esp + 4]
		add eax, 11
		push eax
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 8
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, s_pcZeit, 9)

		;push 9
		;lea edx, s_pcZeit[esp + 4]
		;mov ecx, dword ptr s_pcDatumZeit[esp + 4]
		;add ecx, 11
    ;call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov eax, dword ptr s_pcDatumZeit[esp]

		add esp, esp_Bytes
		ret 0
?CHARDateTime@COTime@System@RePag@@QAQPADPAD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 40
s_pcDatumZeit = 20
s_pasDatumZeit = 16
s_stSZeit = 0
?StrDateTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z PROC ; COTime::StrDateTime(pasDatumZeit)
		sub esp, esp_Bytes

		mov dword ptr s_pasDatumZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 11
		lea eax, dword ptr s_pcDatumZeit[esp + 4]
		push eax
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 1
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, dwFlags, stSZeit, NULL, s_pcDatum, 11)

		;lea edx, s_pcDatumZeit[esp]
		;mov ecx, dword ptr s_pasDatumZeit[esp]
		;call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)
		lea ecx, dword ptr s_pcDatumZeit[esp]
		mov byte ptr [ecx + 10], 32

		push 9
		lea eax, s_pcDatumZeit[esp + 4]
		add eax, 11
		push eax
		push 0
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 8
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, dwFlags, stSZeit, NULL, s_pcZeit, 9)

		;mov edx, offset pcLeer
		;mov ecx, dword ptr s_pasDatumZeit[esp]
		;call ??YCOStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator +=(pcString)

		lea edx, s_pcDatumZeit[esp]
		mov ecx, dword ptr s_pasDatumZeit[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

		mov eax, dword ptr s_pasDatumZeit[esp]

		add esp, esp_Bytes
		ret 0
?StrDateTime@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 28
s_iBytes = 24
s_vbZeit = 20
s_pasDatum = 16
s_stSZeit = 0
a_pcFormat = esp_Bytes + 4
?StrDateFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z PROC ; COTime::StrDateFormat(pasDatum, pcFormat)
		sub esp, esp_Bytes

		mov dword ptr s_pasDatum[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbZeit[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)

		test eax, eax
		je short Ende

		mov edx, dword ptr s_vbZeit[esp]
		mov ecx, dword ptr s_pasDatum[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

	Ende:
		mov edx, dword ptr s_vbZeit[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		mov eax, dword ptr s_pasDatum[esp]
		add esp, esp_Bytes
		ret 4
?StrDateFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 28
s_iBytes = 24
s_vbZeit = 20
s_pasZeit = 16
s_stSZeit = 0
a_pcFormat = esp_Bytes + 4
?StrTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z PROC ; COTime::StrTimeFormat(pasDatum, pcFormat)
		sub esp, esp_Bytes

		mov dword ptr s_pasZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbZeit[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)

		test eax, eax
		je short Ende

		mov edx, dword ptr s_vbZeit[esp]
		mov ecx, dword ptr s_pasZeit[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

	Ende:
		mov edx, dword ptr s_vbZeit[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)
		mov eax, dword ptr s_pasZeit[esp]
		add esp, esp_Bytes
		ret 4
?StrTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 32
s_iBytes = 28
s_vbZeit = 24
s_vbDatum = 20
s_pasDatumZeit = 16
s_stSZeit = 0
a_pcFormat_Datum = esp_Bytes + 4
a_pcFormat_Zeit = esp_Bytes + 8
a_bAnordnung_DatumZeit = esp_Bytes + 12
?StrDateTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD1_N@Z PROC ; COTime::StrDateTimeFormat(pasDatumZeit, pcFormat_Datum, pcFormatz_Zeit, bAnordnung_DatumZeit)
		sub esp, esp_Bytes

		mov dword ptr s_pasDatumZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat_Datum[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat_Datum, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbDatum[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat_Datum[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat_Datum, vbDatum, iBytes)

		push 0
		push 0
		push dword ptr a_pcFormat_Zeit[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat_Zeit, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbZeit[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat_Zeit[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat_Zeit, vbZeit, iBytes)

		mov eax, dword ptr a_bAnordnung_DatumZeit[esp]
		test eax, eax
		je short Zeit_Datum

		mov edx, dword ptr s_vbDatum[esp]
		mov ecx, dword ptr s_pasDatumZeit[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

		mov edx, dword ptr s_vbZeit[esp]
		mov ecx, dword ptr s_pasDatumZeit[esp]
		call ??YCOStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator +=(pcString)
		jmp short Ende

	Zeit_Datum:
		mov edx, dword ptr s_vbZeit[esp]
		mov ecx, dword ptr s_pasDatumZeit[esp]
		call ??4COStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator=(pcString)

		mov edx, dword ptr s_vbDatum[esp]
		mov ecx, dword ptr s_pasDatumZeit[esp]
		call ??YCOStringA@System@RePag@@QAQXPBD@Z ; COStringA::operator +=(pcString)

	Ende:
		mov edx, dword ptr s_vbDatum[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vbZeit[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_pasDatumZeit[esp]
		add esp, esp_Bytes
		ret 12
?StrDateTimeFormat@COTime@System@RePag@@QAQPAVCOStringA@23@PAV423@PBD1_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 24
s_iBytes = 20
s_vbDatum = 16
s_stSZeit = 0
a_pcFormat = esp_Bytes + 4
?VMBLOCKDateFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z PROC ; COTime::VMBLOCKDateFormat(&vbDatum, pcFormat)
		sub esp, esp_Bytes

		mov dword ptr s_vbDatum[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov edx, dword ptr s_vbDatum[esp]
		mov dword ptr [edx], eax

		push ecx
		push eax
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat, vbDatum, iBytes)

	Ende:
		mov eax, dword ptr s_vbDatum[esp]
		mov eax, dword ptr [eax]
		add esp, esp_Bytes
		ret 4
?VMBLOCKDateFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 24
s_iBytes = 20
s_vbZeit = 16
s_stSZeit = 0
a_pcFormat = esp_Bytes + 4
?VMBLOCKTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z PROC ; COTime::VMBLOCKTimeFormat(&vbZeit, pcFormat)
		sub esp, esp_Bytes

		mov dword ptr s_vbZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, NULL, NULL)
		mov dword ptr s_iBytes[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov edx, dword ptr s_vbZeit[esp]
		mov dword ptr [edx], eax

		push ecx
		push eax
		push dword ptr a_pcFormat[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat, vbZeit, iBytes)


	Ende:
		mov eax, dword ptr s_vbZeit[esp]
		mov eax, dword ptr [eax]
		add esp, esp_Bytes
		ret 4
?VMBLOCKTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 40
s_iBytes_Gesamt = 36
s_iBytes_Zeit = 32
s_iBytes_Datum = 28
s_vbZeit = 24
s_vbDatum = 20
s_vbDatumZeit = 16
s_stSZeit = 0
a_pcFormat_Datum = esp_Bytes + 4
a_pcFormat_Zeit = esp_Bytes + 8
a_bAnordnung_DatumZeit = esp_Bytes + 12
?VMBLOCKDateTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD1_N@Z PROC ; COTime::VMBLOCKDateTimeFormat(&vbDatumZeit, pcFormat_Datum, pcFormat_Zeit, bAnordnung_DatumZeit)
		sub esp, esp_Bytes

		mov dword ptr s_vbDatumZeit[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		push 0
		push 0
		push dword ptr a_pcFormat_Datum[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat_Datum, NULL, NULL)
		mov dword ptr s_iBytes_Datum[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes_Datum[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbDatum[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat_Datum[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetDateFormatA@24 ; GetDateFormat(Locale, NULL, stSZeit, a_pcFormat_Datum, vbDatum, iBytes)

		push 0
		push 0
		push dword ptr a_pcFormat_Zeit[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat_Zeit, NULL, NULL)
		mov dword ptr s_iBytes_Zeit[esp], eax

		mov edx, eax
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes_Zeit[esp]
		mov byte ptr [eax + ecx - 1], 0
		mov dword ptr s_vbZeit[esp], eax

		push ecx
		push eax
		push dword ptr a_pcFormat_Zeit[esp + 8]
		lea eax, s_stSZeit[esp + 12]
		push eax
		push 0
		push 1024
		call dword ptr __imp__GetTimeFormatA@24 ; GetTimeFormat(Locale, NULL, stSZeit, a_pcFormat_Zeit, vbZeit, iBytes)

		mov edx, dword ptr s_iBytes_Datum[esp]
		add edx, dword ptr s_iBytes_Zeit[esp]
		mov dword ptr s_iBytes_Gesamt[esp], edx
		add edx, 1
		xor ecx, ecx
    call ?VMBlock@System@RePag@@YQPADPBXK@Z ; VMBlock(vmSpeicher, ulBytes)
		mov ecx, dword ptr s_iBytes_Gesamt[esp]
		mov byte ptr [eax + ecx], 0
		mov edx, dword ptr s_vbDatumZeit[esp]
		mov dword ptr [edx], eax

		mov ecx, dword ptr a_bAnordnung_DatumZeit[esp]
		test ecx, ecx
		je short Zeit_Datum

		push dword ptr s_iBytes_Datum[esp]
		mov edx, dword ptr s_vbDatum[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr s_iBytes_Zeit[esp]
		mov edx, dword ptr s_vbZeit[esp + 4]
		mov ecx, eax
		add ecx, dword ptr s_iBytes_Datum[esp + 4]
		sub ecx, 1
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)
		jmp short Ende

	Zeit_Datum:
		push dword ptr s_iBytes_Zeit[esp]
		mov edx, dword ptr s_vbZeit[esp + 4]
		mov ecx, eax
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		push dword ptr s_iBytes_Datum[esp]
		mov edx, dword ptr s_vbDatum[esp + 4]
		mov ecx, eax
		add ecx, dword ptr s_iBytes_Zeit[esp + 4]
		sub ecx, 1
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Ende:
		mov edx, dword ptr s_vbDatum[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov edx, dword ptr s_vbZeit[esp]
		xor ecx, ecx
		call ?VMFrei@System@RePag@@YQXPBXPAX@Z ; VMFrei(vmSpeicher, vbAdresse)

		mov eax, dword ptr s_vbDatumZeit[esp]
		mov eax, dword ptr [eax]
		add esp, esp_Bytes
		ret 12
?VMBLOCKDateTimeFormat@COTime@System@RePag@@QAQPADAAPADPBD1_N@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COTime@System@RePag@@QAQXPBD@Z PROC ; COTime::operator=(pcString)
		mov eax, ecx
		mov ecx, edx

		call StringZuFILETIME

		mov ecx, dword ptr COTime_FZeit_dwLowDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[eax], ecx
		mov ecx, dword ptr COTime_FZeit_dwHighDateTime[eax]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[eax], ecx

		ret 0
??4COTime@System@RePag@@QAQXPBD@Z ENDP
;----------------------------------------------------------------------------
??4COTime@System@RePag@@QAQXABV012@@Z PROC ; COTime::operator=(&zZeit)
		movq xmm0, qword ptr COTime_FZeit_dwLowDateTime[edx]
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm0
		movq xmm0, qword ptr COTime_FZeit_A_dwLowDateTime[edx]
		movq qword ptr COTime_FZeit_A_dwLowDateTime[ecx], xmm0
		ret 0
??4COTime@System@RePag@@QAQXABV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_this = 16
s_stSZeit = 0
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
??4COTime@System@RePag@@QAQXABUSTTime@12@@Z PROC ; COTime::operator=(&stZeit)
		sub esp, esp_Bytes

		mov eax, dword ptr [edx + ulTag]
		mov word ptr s_stSZeit[esp + wDay], ax
		movzx eax, byte ptr [edx + ucMonat]
		mov word ptr s_stSZeit[esp + wMonth], ax
		movzx eax, word ptr [edx + usJahr]
		mov word ptr s_stSZeit[esp + wYear], ax
		movzx eax, byte ptr [edx + ucStunde]
		mov word ptr s_stSZeit[esp + wHour], ax
		movzx eax, byte ptr [edx + ucMinute]
		mov word ptr s_stSZeit[esp + wMinute], ax
		movzx eax, byte ptr [edx + ucSekunde]
		mov word ptr s_stSZeit[esp + wSecond], ax
		movzx eax, word ptr [edx + usMillisekunde]
		mov word ptr s_stSZeit[esp + wMilliseconds], ax

		mov dword ptr s_this[esp], ecx
		push ecx
		lea eax, s_stSZeit[esp + 4]
		push eax
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		mov ecx, dword ptr s_this[esp]
		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		add esp, esp_Bytes
		ret 0
??4COTime@System@RePag@@QAQXABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
??4COTime@System@RePag@@QAQXABU_SYSTEMTIME@@@Z PROC ; COTime::operator=(&stSystemTime)
		push ebp

		mov ebp, ecx
		push ecx
		push edx
		call dword ptr __imp__SystemTimeToFileTime@8 ; SystemTimeToFileTime(stSZeit, FZeit)

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ebp], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ebp], edx

		pop ebp
		ret 0
??4COTime@System@RePag@@QAQXABU_SYSTEMTIME@@@Z ENDP
;----------------------------------------------------------------------------
??MCOTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator<(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jle short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??MCOTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??OCOTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator>(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jge short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??OCOTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??NCOTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator<=(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jl short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??NCOTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??PCOTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator>=(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jg short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??PCOTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??8COTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator==(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		jne short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??8COTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
??9COTime@System@RePag@@QAQ_NABV012@@Z PROC ; COTime::operator!=(&zZeit)
		push ecx
		push edx
		call dword ptr __imp__CompareFileTime@8 ; CompareFileTime(FZeit_1, FZeit_2)
		test eax, eax
		je short False
		mov eax, 1
		jmp short Ende

	False:
		xor eax, eax

	Ende:
		ret 0
??9COTime@System@RePag@@QAQ_NABV012@@Z ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_llTemp = 8
s_llDiffZeit = 0
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??YCOTime@System@RePag@@QAQXABUSTTime@12@@Z PROC ; COTime::operator+=(&stZeit)
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		movzx eax, word ptr [edx + usMillisekunde]
		imul eax, 10000
		movd xmm0, eax
		
		movzx eax, byte ptr [edx + ucSekunde]
		test eax, eax
		je short Minute
		imul eax, 10000000
		movd xmm1, eax
		paddq xmm0, xmm1

	Minute:
		movzx eax, byte ptr [edx + ucMinute]
		test eax, eax
		je short Stunde
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llMinute
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Stunde:
		movzx eax, byte ptr [edx + ucStunde]
		test eax, eax
		je short Tag
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llStunde
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Tag:
		mov eax, dword ptr [edx + ulTag]
		test eax, eax
		je short Ende
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llTag
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Ende:
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx]
		paddq xmm0 , xmm1
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm0

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		ret 0
??YCOTime@System@RePag@@QAQXABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llDiffZeit = 0
a_llDiffSekunden = esp_Bytes + 4
??YCOTime@System@RePag@@QAQX_J@Z PROC ; COTime::operator+=(llDiffSekunden)
		sub esp, esp_Bytes

		pxor xmm0, xmm0
		pxor xmm1, xmm1

		fild qword ptr a_llDiffSekunden[esp]
		fild dwSieben_Null
		fmul ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)
		movq xmm0, qword ptr s_llDiffZeit[esp]
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx] 
		paddq xmm0, xmm1
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm0

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		add esp, esp_Bytes
		ret 8
??YCOTime@System@RePag@@QAQX_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_llTemp = 8
s_llDiffZeit = 0
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??ZCOTime@System@RePag@@QAQXABUSTTime@12@@Z PROC ; COTime::operator-=(&stZeit)
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		movzx eax, word ptr [edx + usMillisekunde]
		imul eax, 10000
		movd xmm0, eax
		
		movzx eax, byte ptr [edx + ucSekunde]
		test eax, eax
		je short Minute
		imul eax, 10000000
		movd xmm1, eax
		paddq xmm0, xmm1

	Minute:
		movzx eax, byte ptr [edx + ucMinute]
		test eax, eax
		je short Stunde
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llMinute
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Stunde:
		movzx eax, byte ptr [edx + ucStunde]
		test eax, eax
		je short Tag
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llStunde
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Tag:
		mov eax, dword ptr [edx + ulTag]
		test eax, eax
		je short Ende
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llTag
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Ende:
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx]
		psubq xmm1 , xmm0
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm1

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		ret 0
??ZCOTime@System@RePag@@QAQXABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llDiffZeit = 0
a_llDiffSekunden = esp_Bytes + 4
??ZCOTime@System@RePag@@QAQX_J@Z PROC ; COTime::operator-=(llDiffSekunden)
		sub esp, esp_Bytes

		pxor xmm0, xmm0
		pxor xmm1, xmm1

		fild qword ptr a_llDiffSekunden[esp]
		fild dwSieben_Null
		fmul ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)
		movq xmm0, qword ptr s_llDiffZeit[esp]
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx] 
		psubq xmm1, xmm0
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm1

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		add esp, esp_Bytes
		ret 8
??ZCOTime@System@RePag@@QAQX_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llDiffZeit = 0
a_llDiffSekunden = esp_Bytes + 4
??HCOTime@System@RePag@@QAQAAV012@_J@Z PROC ; COTime::operator+(llDiffSekunden)
		sub esp, esp_Bytes

		pxor xmm0, xmm0
		pxor xmm1, xmm1

		fild qword ptr a_llDiffSekunden[esp]
		fild dwSieben_Null
		fmul ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)
		movq xmm0, qword ptr s_llDiffZeit[esp]
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx] 
		paddq xmm0, xmm1
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm0

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		mov eax, ecx
		add esp, esp_Bytes
		ret 8
??HCOTime@System@RePag@@QAQAAV012@_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_llTemp = 8
s_llDiffZeit = 0
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
??HCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z PROC ; COTime::operator+(&stZeit)
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		movzx eax, word ptr [edx + usMillisekunde]
		imul eax, 10000
		movd xmm0, eax
		
		movzx eax, byte ptr [edx + ucSekunde]
		test eax, eax
		je short Minute
		imul eax, 10000000
		movd xmm1, eax
		paddq xmm0, xmm1

	Minute:
		movzx eax, byte ptr [edx + ucMinute]
		test eax, eax
		je short Stunde
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llMinute
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Stunde:
		movzx eax, byte ptr [edx + ucStunde]
		test eax, eax
		je short Tag
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llStunde
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Tag:
		mov eax, dword ptr [edx + ulTag]
		test eax, eax
		je short Ende
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llTag
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Ende:
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx]
		psubq xmm1 , xmm0
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm1

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		mov eax, ecx
		ret 0
??HCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llDiffZeit = 0
a_llDiffSekunden = esp_Bytes + 4
??GCOTime@System@RePag@@QAQAAV012@_J@Z PROC ; COTime::operator-(llDiffSekunden)
		sub esp, esp_Bytes

		pxor xmm0, xmm0
		pxor xmm1, xmm1

		fild qword ptr a_llDiffSekunden[esp]
		fild dwSieben_Null
		fmul ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)
		movq xmm0, qword ptr s_llDiffZeit[esp]
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx] 
		psubq xmm1, xmm0
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm1

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		mov eax, ecx
		add esp, esp_Bytes
		ret 8
??GCOTime@System@RePag@@QAQAAV012@_J@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 8
s_llDiffZeit = 0
a_llDiffSekunden = esp_Bytes + 4
??GCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z PROC ; COTime::operator-(&stZeit)
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		movzx eax, word ptr [edx + usMillisekunde]
		imul eax, 10000
		movd xmm0, eax
		
		movzx eax, byte ptr [edx + ucSekunde]
		test eax, eax
		je short Minute
		imul eax, 10000000
		movd xmm1, eax
		paddq xmm0, xmm1

	Minute:
		movzx eax, byte ptr [edx + ucMinute]
		test eax, eax
		je short Stunde
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llMinute
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Stunde:
		movzx eax, byte ptr [edx + ucStunde]
		test eax, eax
		je short Tag
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llStunde
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Tag:
		mov eax, dword ptr [edx + ulTag]
		test eax, eax
		je short Ende
		mov dword ptr s_llTemp[esp], eax
		fild dword ptr s_llTemp[esp]
		fild llTag
		fmul ST(0), ST(1)
		fistp qword ptr s_llTemp[esp]
		ffree ST(0)
		movq xmm1, qword ptr s_llTemp[esp]
		paddq xmm0, xmm1

	Ende:
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[ecx]
		psubq xmm1 , xmm0
		movq qword ptr COTime_FZeit_dwLowDateTime[ecx], xmm1

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ecx], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ecx], edx

		mov eax, ecx
		ret 0
??GCOTime@System@RePag@@QAQAAV0@ABUSTTime@12@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 16
s_c2Runden_Alt = 14
s_c2Runden = 12
s_lTemp = 8
s_llDiffZeit = 0
a_stZeit$ = esp_Bytes + 4
usJahr = 0
ucMonat = 2;
ulTag = 4;
ucStunde = 8;
ucMinute = 9;
ucSekunde = 10;
usMillisekunde = 12;
?DifferenceTime@COTime@System@RePag@@QAQXPBV123@AAUSTTime@23@@Z PROC ; COTime::DifferenceTime(pzZeit, &stZeit)
		sub esp, esp_Bytes

		movq xmm0, qword ptr COTime_FZeit_dwLowDateTime[ecx]
		movq xmm1, qword ptr COTime_FZeit_dwLowDateTime[edx]

		mov eax, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		cmp dword ptr COTime_FZeit_dwHighDateTime[edx], eax
		ja short Zweiter_Grosser

		mov eax, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		cmp dword ptr COTime_FZeit_dwLowDateTime[edx], eax
		ja short Zweiter_Grosser
		psubq xmm0, xmm1
		movq qword ptr s_llDiffZeit[esp], xmm0
		jmp short Ende

	Zweiter_Grosser:
		psubq xmm1, xmm0
		movq qword ptr s_llDiffZeit[esp], xmm1

	Ende:
		mov edx, dword ptr a_stZeit[esp]
		mov word ptr [edx + usJahr], 0
		mov byte ptr [edx + ucMonat], 0

		fstcw s_c2Runden_Alt[esp]
		fstcw s_c2Runden[esp]
    bts word ptr s_c2Runden[esp], 10
    bts word ptr s_c2Runden[esp], 11
    fldcw s_c2Runden[esp]
    fclex

		fild llTag
		fild qword ptr s_llDiffZeit[esp]
		fdiv ST(0), ST(1)
		fistp dword ptr [edx + ulTag]
		fild dword ptr [edx + ulTag]
		fmul ST(0), ST(1)
		ffree ST(1)		
		fild qword ptr s_llDiffZeit[esp]
		fsub ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)

		fild llStunde
		fild qword ptr s_llDiffZeit[esp]
		fdiv ST(0), ST(1)
		fistp dword ptr s_lTemp[esp]
		mov eax, dword ptr s_lTemp[esp]
		mov byte ptr [edx + ucStunde], al
		fild dword ptr s_lTemp[esp]
		fmul ST(0), ST(1)
		ffree ST(1)		
		fild qword ptr s_llDiffZeit[esp]
		fsub ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)

		fild llMinute
		fild qword ptr s_llDiffZeit[esp]
		fdiv ST(0), ST(1)
		fistp dword ptr s_lTemp[esp]
		mov eax, dword ptr s_lTemp[esp]
		mov byte ptr [edx + ucMinute], al
		fild dword ptr s_lTemp[esp]
		fmul ST(0), ST(1)
		ffree ST(1)		
		fild qword ptr s_llDiffZeit[esp]
		fsub ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)

		fild llSekunde
		fild qword ptr s_llDiffZeit[esp]
		fdiv ST(0), ST(1)
		fistp dword ptr s_lTemp[esp]
		mov eax, dword ptr s_lTemp[esp]
		mov byte ptr [edx + ucSekunde], al
		fild dword ptr s_lTemp[esp]
		fmul ST(0), ST(1)
		ffree ST(1)		
		fild qword ptr s_llDiffZeit[esp]
		fsub ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)

		fild llMillisekunde
		fild qword ptr s_llDiffZeit[esp]
		fdiv ST(0), ST(1)
		fistp dword ptr s_lTemp[esp]
		mov eax, dword ptr s_lTemp[esp]
		mov word ptr [edx + usMillisekunde], ax
		fild dword ptr s_lTemp[esp]
		fmul ST(0), ST(1)
		ffree ST(1)		
		fild qword ptr s_llDiffZeit[esp]
		fsub ST(0), ST(1)
		fistp qword ptr s_llDiffZeit[esp]
		ffree ST(0)

	Ende_1:
		fstcw s_c2Runden_Alt[esp]
		add esp, esp_Bytes
		ret 4
?DifferenceTime@COTime@System@RePag@@QAQXPBV123@AAUSTTime@23@@Z ENDP
_Text ENDS
;----------------------------------------------------------------------------
?Read@COTime@System@RePag@@QAQXPAD@Z PROC ; COTime::Read(pcInhalt)
		push ebp

		test edx, edx
		je short Ende

		mov ebp, ecx
		push edx ; pcInhalt

		push 4
		mov ecx, edx
		lea edx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		pop edx ; pcInhalt

		push 4
		mov ecx, edx
		add ecx, 4
		lea edx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

	Ende:
		pop ebp
		ret 0
?Read@COTime@System@RePag@@QAQXPAD@Z ENDP
;----------------------------------------------------------------------------
?Write@COTime@System@RePag@@QAQXPBD@Z PROC ; COTime::Write(pcInhalt)
		push ebp

		test edx, edx
		je short Ende

		mov ebp, ecx
		push edx ; pcInhalt

		push 4
		lea ecx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		pop edx ; pcInhalt

		push 4
		add edx, 4
		lea ecx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		call ?MemCopy@System@RePag@@YQPAXPAXPBXK@Z ; MemCopy(pvZiel, pvQuelle, ulBytes)

		mov edx, dword ptr COTime_FZeit_dwLowDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwLowDateTime[ebp], edx
		mov edx, dword ptr COTime_FZeit_dwHighDateTime[ebp]
		mov dword ptr COTime_FZeit_A_dwHighDateTime[ebp], edx

	Ende:
		pop ebp
		ret 0
?Write@COTime@System@RePag@@QAQXPBD@Z ENDP
;----------------------------------------------------------------------------
?FileTime@COTime@System@RePag@@QAQ?AU_FILETIME@@XZ PROC ; COTime::FileTime(void)
		mov eax, dword ptr COTime_FZeit_dwLowDateTime[ecx]
		mov dword ptr COTime_FZeit_dwLowDateTime[edx], eax
		mov eax, dword ptr COTime_FZeit_dwHighDateTime[ecx]
		mov dword ptr COTime_FZeit_dwHighDateTime[edx], eax
		mov eax, edx

		ret 0
?FileTime@COTime@System@RePag@@QAQ?AU_FILETIME@@XZ ENDP
;----------------------------------------------------------------------------
_Text SEGMENT
esp_Bytes = 20
s_SReturn = 16
s_stSZeit = 0
?SystemTime@COTime@System@RePag@@QAQ?AU_SYSTEMTIME@@XZ PROC ; COTime::SystemTime(void)
		sub esp, esp_Bytes

		mov dword ptr s_sReturn[esp], edx

		lea eax, s_stSZeit[esp]
		push eax
		push ecx
		call dword ptr __imp__FileTimeToSystemTime@8 ; FileTimeToSystemTime(FZeit, stSZeit)

		mov edx, dword ptr s_sReturn[esp]
		mov eax, dword ptr s_stSZeit[esp]
		mov dword ptr [edx], eax
		mov eax, dword ptr s_stSZeit[esp + 4]
		mov dword ptr [edx + 4], eax
		mov eax, dword ptr s_stSZeit[esp + 8]
		mov dword ptr [edx + 8], eax
		mov eax, dword ptr s_stSZeit[esp + 12]
		mov dword ptr [edx + 12], eax
		mov eax, edx

		add esp, esp_Bytes
		ret 0
?SystemTime@COTime@System@RePag@@QAQ?AU_SYSTEMTIME@@XZ ENDP
_Text ENDS
;----------------------------------------------------------------------------
CS_OZeit ENDS
END