; __SFR_OFFSET notes
; if you reset __SFR_OFFSET to 0x00 then you do NOT need to use the _SFR_IO_ADDR() macro when
; using the in/out instructions and the port registers, however, if you leave this line commented 
; then you must use code like:
;
;  out _SFR_IO_ADDR( PORTB ), rxx // this code assumes __SFR_OFFSET = 0x20 
; 
; rather than code like this:
;
;  out PORTB, rxx   // this code assumes __SFR_OFFSET = 0x00 

;#define __SFR_OFFSET 0x00  
#include "avr/io.h"

;--------------------------------------------------------------------------------
.data                             ; global variables in the SRAM or "data space"

.comm powerLevel, 1               ; creates 1-byte variable powerLevel (unitialized)
.global powerLevel                ; pushed out to the linker

.comm livesLeft, 1
.global livesLeft

;--------------------------------------------------------------------------------
.text                             ; data in the .text section will end up in program flash storage

_powerLevel:  .byte 111           ; intialize values in flash memory
_livesLeft:   .byte 7             ; separate variables from those defined in .data

;--------------------------------------------------------------------------------

; The following ASM code is just doing this (C++ equivalent)
; powerLevel = _powerLevel;
; livesLeft = _livesLeft;
; return powerLevel * livesLeft;


; export ASM functions to C/C++

;r25:r24
;int16_t PlayerFitness();
.global PlayerFitness

.func PlayerFitness

  ; Params are sent into registers left to right r25 -> r8 (always as pairs)
  ; Bytes use TWO registers
  ; Param1 is stored in r25:r24

PlayerFitness:
  
  push r0                         ; save r0, r1. C/C++ always use them
  push r1
  push r18
  push r19

  ; ASM SRAM variables are just storage allcoation, cannot be initialized

  ldi ZL, lo8(_powerLevel)        ; load Z pointer to _powerLevel
  ldi ZH, hi8(_powerLevel)        ; now ZH:ZL -> _powerLevel
  lpm r18, Z                      ; load 1-byte pointed to by the Z register to the destination register
  sts powerLevel, r18             ; store _powerLevel in register into powerLevel space in SRAM

  ldi ZL, lo8(_livesLeft)         ; load Z pointer to _livesLeft
  ldi ZH, hi8(_livesLeft)         ; now ZH:ZL -> _livesLeft
  lpm r18, Z                      ; load 1-byte pointed to by the Z register to the destination register
  sts livesLeft, r18              ; store _livesLeft in register into powerLevel space in SRAM

  ldi r25, 0x00                   ; make sure upper byte is 0 of passed 8-bit param

  lds r18, powerLevel             ; load SRAM powerLevel into register
  lds r19, livesLeft              ; load SRAM livesLeft into register
                                  ; multiplication requires using available registers

  mul r19, r18                    ; multiply powerLevel by livesLeft

  movw r24, r0                    ; move multiplication product from r0 into return func register

  pop r19                         ; pop stack and restore r0, r1
  pop r18
  pop r1
  pop r0
  ret

.endfunc
