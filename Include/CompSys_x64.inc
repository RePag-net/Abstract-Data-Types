; up Fileversion 2.3.7.0
EXTRN	?MemCopy@System@RePag@@YQPEAXPEAXPEBXK@Z:PROC         ; MemCopy(pvZiel, pvQuelle, ulBytes)
EXTRN ?VMBlock@System@RePag@@YQPEADPEBXK@Z:PROC             ; VMBlock(vmSpeicher, ulBytes)
EXTRN	?VMBlockS@System@RePag@@YQPEADPEBXK@Z:PROC            ; VMBlockS(vmSpeicher, ulBytes)
EXTRN ?VMFrei@System@RePag@@YQXPEBXPEAX@Z:PROC              ; VMFrei(vmSpeicher, vbAdresse)
EXTRN ?VMFreiS@System@RePag@@YQXPEBXPEAX@Z:PROC             ; VMFreiS(vmSpeicher, vbAdresse)
;----------------------------------------------------------------------------------------------------
s_ShadowRegister = 32