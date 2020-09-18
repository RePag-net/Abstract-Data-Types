COStringA_vbInhalt = 0
COStringA_ulLange = 4
COStringA_vbInhalt_A = COStringA_ulLange + 4
COStringA_ulLange_A = COStringA_vbInhalt_A + 4
COStringA_vmSpeicher = COStringA_ulLange_A + 4
;----------------------------------------------------------------------------
COComma4_lVorKomma = 0
COComma4_lVorKomma_A = 4
COComma4_sNachKomma = COComma4_lVorKomma_A + 4
COComma4_sNachKomma_A = COComma4_sNachKomma + 2
COComma4_vmSpeicher = COComma4_sNachKomma_A + 2
;----------------------------------------------------------------------------
COComma4_80_llVorKomma = 0
COComma4_80_llVorKomma_A = 8
COComma4_80_sNachKomma = COComma4_80_llVorKomma_A + 8
COComma4_80_sNachKomma_A = COComma4_80_sNachKomma + 2
COComma4_80_vmSpeicher = COComma4_80_sNachKomma_A + 2
;----------------------------------------------------------------------------
COList_pstErster = 0
COList_pstLetzer = 4
COList_pvDaten = 4
COList_csIterator = COList_pstLetzer + 4
COList_ulAnzahl = COList_csIterator + 24
COList_bThread = COList_ulAnzahl + 4
COList_vmSpeicher = COList_bThread + 4
;----------------------------------------------------------------------------
COTime_FZeit_dwLowDateTime = 0
COTime_FZeit_dwHighDateTime = 4
COTime_FZeit_A_dwLowDateTime = COTime_FZeit_dwHighDateTime + 4
COTime_FZeit_A_dwHighDateTime = COTime_FZeit_A_dwLowDateTime + 4
COTime_vmSpeicher = COTime_FZeit_A_dwHighDateTime + 4
;----------------------------------------------------------------------------
COStream = 0
COStream_COList = 0
COStream_COList_pstErster = 0
COStream_COList_pstLetzer = 4
COStream_COList_pvDaten = 4
COStream_COList_csIterator = COList_pstLetzer + 4
COStream_COList_ulAnzahl = COList_csIterator + 24
COStream_COList_bThread = COList_ulAnzahl + 4
COStream_COList_vmSpeicher = COList_bThread + 4
COStream_csStream = COStream_COList_vmSpeicher + 4;
COStream_ulBytes = COStream_csStream + 24;
COStream_ulPosition = COStream_ulBytes + 4;
COStream_bThread = COStream_ulPosition + 4;
COStream_ucInfo = COStream_bThread + 1;
COStream_vmSpeicher = COStream_ucInfo + 3;
;----------------------------------------------------------------------------