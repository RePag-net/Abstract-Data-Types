; up Fileversion 2.3.7.0
;--------------------------------------------------------------------------------------------------
EXTRN	?MemCopy@System@RePag@@YQPAXPAXPBXK@Z:PROC         ; MemCopy(pvZiel, pvQuelle, ulBytes)
EXTRN	?VMBlock@System@RePag@@YQPADPBXK@Z:PROC            ; VMBlock(vmSpeicher, ulBytes)
EXTRN	?VMBlockS@System@RePag@@YQPADPBXK@Z:PROC           ; VMBlockS(vmSpeicher, ulBytes)
EXTRN ?VMFrei@System@RePag@@YQXPBXPAX@Z:PROC             ; VMFrei(vmSpeicher, vbAdresse)
EXTRN ?VMFreiS@System@RePag@@YQXPBXPAX@Z:PROC            ; VMFreiS(vmSpeicher, vbAdresse)
;--------------------------------------------------------------------------------------------------