// __SFR_OFFSET notes
// if you reset __SFR_OFFSET to 0x00 then you do NOT need to use the _SFR_IO_ADDR() macro when
// using the in/out instructions and the port registers, however, if you leave this line commented 
// then you must use code like:
//
//  out _SFR_IO_ADDR( PORTB ), rxx // this code assumes __SFR_OFFSET = 0x20 
// 
// rather than code like this:
//
//  out PORTB, rxx   // this code assumes __SFR_OFFSET = 0x00 

//#define __SFR_OFFSET 0x00  
#include "avr/io.h"

;--------------------------------------------------------------------------------

.equ    counter, 0xFFFF

;--------------------------------------------------------------------------------

; export ASM functions to C/C++

;r25:r24          r25:r24  , r23:r22
;int16_t Multiply(int16_t x, int16_t y);
.global Multiply

.func Multiply


  ; Params are sent into registers left to right r25 -> r8 (always as pairs)
  ; Bytes use TWO registers
  ; Param1 is stored in r25:r24
  ; Param2 is stored in r23:r22

Multiply:
  
  push r0                         ; save r0, r1. C/C++ always use them
  push r1

  muls r24, r22                   ; multiply registers r24 and r22 together
                                  ; the result is stored in r0, r1

  movw r24, r0                    ; copy the register pair from r1:r0 -> r25:r24
                                  ; assembly syntax infers r25:r24 from providing r24

  pop r1                          ; pop stack and restore r0, r1
  pop r0
  ret

.endfunc
