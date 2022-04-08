// C implementation of mux

#include <svdpi.h>

unsigned int mux_dpi_model( unsigned int i0, unsigned int i1, unsigned int sel)
{
  switch(sel){
   case 0 : return i0;
    case 1 : return i1;
    default : return i0;
  }
  return 0;
}
