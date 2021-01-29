/****************************************************************************
  ListeZuString.cpp
  For more information see https://github.com/RePag-net/Core
*****************************************************************************/

/****************************************************************************
  The MIT License(MIT)

  Copyright(c) 2021 René Pagel

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this softwareand associated documentation files(the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions :

  The above copyright noticeand this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
******************************************************************************/

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