#pragma once
#ifdef HADT
#define _Export __declspec(dllexport)
#else
#define _Export
#endif
#include "OListe.h"
#include "OStringA.h"
//---------------------------------------------------------------------------
namespace RePag
{
  namespace System
  {
    _Export void __vectorcall StringAtoList(COList* plNumberList, COStringA& asNumberChain);
    _Export COStringA* __vectorcall ListtoStringA(COList* plNumberList, COStringA* pasNumber);
    //---------------------------------------------------------------------------
  }
}