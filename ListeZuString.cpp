#include "HADT.h"
#include "ListeZuString.h"
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    void __vectorcall StringAtoList(COList* plZahlenListe, COStringA& asZahlenKette)
    {
      if(asZahlenKette.Length()){
        char cZeichen[2] = { 0,0 }; cZeichen[1] = 0;
        COStringA* vasZahl = COStringAV(); ULONG ulLange = asZahlenKette.Length();
        for(ULONG ulx = 0; ulx < ulLange; ulx++){
          if(asZahlenKette[ulx] != 59){ cZeichen[0] = asZahlenKette[ulx]; *vasZahl += cZeichen; }
          else{ plZahlenListe->ToEndS(vasZahl); vasZahl = COStringAV(); }
        }
        plZahlenListe->ToEndS(vasZahl);
      }
    }
    //---------------------------------------------------------------------------
    COStringA* __vectorcall ListtoStringA(COList* plZahlenListe, COStringA* pasZahl)
    {
      void* pvIterator = plZahlenListe->IteratorToBegin();
      while(pvIterator){
        *pasZahl += *(COStringA*)plZahlenListe->Element(pvIterator); *pasZahl += ";";
        plZahlenListe->NextElement(pvIterator);
      }
      pasZahl->ShortRightOne();
      return pasZahl;
    }
    //---------------------------------------------------------------------------
  }
}