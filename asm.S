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

;void TurnLEDOn()
.global TurnLEDOn

;void TurnLEDOff()
.global TurnLEDOff



.func TurnLEDOn

TurnLEDOn:
    ldi r17, ( 1<<PINB5 )           ; shift 1 into bit 5
    out _SFR_IO_ADDR( DDRB ), r17   ; set DDRB direction register bit 5 to output
    out _SFR_IO_ADDR( PORTB ), r17  ; now write a 1 to PORTB bit 5, turn LED on
    ret                             ; return to C/C++
  
.endfunc



.func TurnLEDOff

TurnLEDOff:
    ldi r17, ( 1<<PINB5 )           ; shift 1 into bit 5
    out _SFR_IO_ADDR( DDRB ), r17   ; set DDRB direction register bit 5 to output
    ldi r17, 0x00                   ; load 0 into temp register
    out _SFR_IO_ADDR( PORTB ), r17  ; now write a 0 to PORTB bit 5, turn LED off
    ret                             ; return to C/C++

.endfunc
