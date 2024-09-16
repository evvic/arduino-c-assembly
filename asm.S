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

; data in the .text section will end up in progrma flash storage
.text

; holds the first 16 prime numbers 
primeTable:
  ;indx 0 1 2 3 4  5  6  7  8  9  10 11 12 13 14 15
  .byte 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53

;--------------------------------------------------------------------------------

.equ    counter, 0xFFFF

;--------------------------------------------------------------------------------

; export ASM functions to C/C++

;r25:r24          r25:r24  , r23:r22
;int8_t PrimeNth(int8_t n);
.global PrimeNth

.func PrimeNth

  ; Params are sent into registers left to right r25 -> r8 (always as pairs)
  ; Bytes use TWO registers
  ; Param1 is stored in r25:r24

PrimeNth:
  
  push r0                         ; save r0, r1. C/C++ always use them
  push r1
  push r17
  push r30                        ; 31:30 z-pointer registers
  push r31                        ; acts as a 16-bit pointer to accesss all memory space

  ldi ZL, lo8(primeTable)         ; load Z pointer low and high addresses
  ldi ZH, hi8(primeTable)         ; now ZH:ZL -> primeTable

  ldi r25, 0x00                   ; make sure upper byteis 0 of passed 8-bit param

  clc                             ; clear the carry bit
  add ZL, r24                     ; add 8-bit index param to base of 16-bit table
  adc ZH, r25                     ; if the index param > 8-bit, the carryover is added to r25
                                  ; now ZH:ZL = primeTable[n]

  lpm r17, Z                      ; load 1-byte pointed to by the Z register to the destination register
  
  ldi r25, 0x00                   ; clear r25 because function has to return 8-bit number
  mov r24, r17                    ; move prime value into r24

  pop r31                         ; pop stack and restore r0, r1
  pop r30
  pop r17
  pop r1
  pop r0
  ret

.endfunc
