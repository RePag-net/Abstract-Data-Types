#include "HADT.h"
#include "ZahlZuHexalString.h"
#include "ZahlZuString.h"
//-------------------------------------------------------------------------------------------------------------------------------------------
char* __vectorcall RePag::System::ULONGtoHexCHAR(_Out_writes_z_(10) char pc10HexNumber[10], _In_ unsigned long ulZahl)
{
  BYTE ucNibble = 0, ucPosition = 8; pc10HexNumber[4] = 58; pc10HexNumber[9] = 0;

  for(unsigned char ucBit = 0; ucBit < 32; ucBit++){
    switch(ucBit){
    case 0: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 1: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 2: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 3: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition); ucPosition--;  break;
    case 4: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 5: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 6: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 7: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition); ucPosition--; break;
    case 8: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 9: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 10: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 11: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition); ucPosition--; break;
    case 12: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 13: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 14: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 15: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition); ucPosition -= 2; break;
    case 16: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 17: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 18: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 19: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition);  ucPosition--; break;
    case 20: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 21: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 22: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 23: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition);  ucPosition--; break;
    case 24: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 25: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 26: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 27: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition);  ucPosition--; break;
    case 28: if(ulZahl & (1 << ucBit)){ ucNibble += 1; } break;
    case 29: if(ulZahl & (1 << ucBit)){ ucNibble += 2; } break;
    case 30: if(ulZahl & (1 << ucBit)){ ucNibble += 4; } break;
    case 31: if(ulZahl & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(pc10HexNumber, ucNibble, ucPosition);  ucPosition--; break;
    }
  }
  return pc10HexNumber;
}
//-------------------------------------------------------------------------------------------------------------------------------------------
void __vectorcall RePag::System::NibbleAnHex(_Out_writes_z_(37) char c37Zahl[37], _In_ BYTE& ucNibble, _In_ BYTE& ucPosition)
{
 if(ucNibble < 10) c37Zahl[ucPosition] = ucNibble + 48;
 else if(ucNibble == 10) c37Zahl[ucPosition] = 65;
 else if(ucNibble == 11) c37Zahl[ucPosition] = 66;
 else if(ucNibble == 12) c37Zahl[ucPosition] = 67;
 else if(ucNibble == 13) c37Zahl[ucPosition] = 68;
 else if(ucNibble == 14) c37Zahl[ucPosition] = 69;
 else if(ucNibble == 15) c37Zahl[ucPosition] = 70;
 ucNibble = 0;
}
//-------------------------------------------------------------------------------------------------------------------------------------------
char* __vectorcall RePag::System::BIT128toGUID(_Out_writes_z_(37) char c37GUID[37], _In_ const BIT128 bit128Value)
{
  BYTE ucNibble = 0, ucPosition = 35, ucByte, ucBit; c37GUID[36] = 0;

  for(ucByte = 0; ucByte < 16; ucByte++){
    for(ucBit = 0; ucBit < 8; ucBit++){
      switch(ucBit){
        case 0: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 1; } break;
        case 1: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 2; } break;
        case 2: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 4; } break;
        case 3: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(c37GUID, ucNibble, ucPosition); break;
        case 4: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 1; } break;
        case 5: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 2; } break;
        case 6: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 4; } break;
        case 7: if(bit128Value[ucByte] & (1 << ucBit)){ ucNibble += 8; } NibbleAnHex(c37GUID, ucNibble, --ucPosition); break;
      }
    }
    if(ucPosition == 9 || ucPosition == 14 || ucPosition == 19 || ucPosition == 24){ c37GUID[--ucPosition] = 45; ucPosition--; }
    else ucPosition--;
  }
  return c37GUID;
}