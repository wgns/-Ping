TITLE ASM1 (EXE)
.MODEL SMALL
;=================================================================(AIDEN LODI)=====================================================================
.Data

RECORD_STR    DB 3000 DUP('$')  ;length = original length of record + 1 (for $)
FILEHANDLE    DW ?

SELECT          DB    ">>$"

GLOBAL_TIMER    DB      0,'$'

HISCORE         DB      "HI SCORE: ",'$'
SCORE           DB      "SCORE: ",'$'

KEY_INPUT       DB      0

FRAME1FILE  DB 'menu1.txt', 00H
FRAME2FILE  DB 'menu2.txt', 00H

HIFILE      DB 'hiScore.txt', 00H

;4,5,7,9
BG1FILE     DB 'frame1.txt', 00H
BG2FILE     DB 'frame2.txt', 00H
BG3FILE     DB 'frame3.txt', 00H
BG4FILE     DB 'frame4.txt', 00H
BG5FILE     DB 'frame5.txt', 00H
BG6FILE     DB 'frame6.txt', 00H
BG7FILE     DB 'frame7.txt', 00H
BG8FILE     DB 'frame8.txt', 00H
BG9FILE     DB 'frame9.txt', 00H

HISCORE_STR   DB 10   DUP('$')

;---------------------------------------------------------------------------------

_This           equ     es:[bx]         ;Provide a mnemonic name for THIS.

;---------------------------------------------------------------------------------
;**** Macros to simplify calling the various methods (Menu Data type) ****


_DISPLAY1      macro
    call _This._Display1_
    endm

_DISPLAY2     macro
    call _This._Display2_
    endm

_DISPLAYHI    macro
  
  call _This._DisplayHi_
  endm


;**** Macros to simplify calling the various methods (Menu Data type) ****

_DRAWSHIP    macro
  call _This._DrawShip_
  endm

_DrawHeart   macro
  call _This._DrawHeart_
  endm

_DrawBomb     macro
  call _This._DrawBomb_
  endm

_DrawScore     macro
  call _This._DrawScore_
  endm

;**** Macros to simplify calling the various methods (Bullet Data type) ****

_SETXY    macro
  call _This._SetXY_
  endm

_DrawBullet     macro
  call _This._DrawBullet_
  endm

_UpdateBullet   macro
  call _This._UpdateBullet_
  endm

;**** Macros to simplify calling the various methods (Bullet Data type) ****

_ICSETXY    macro
  call _This._icSetXY_
  endm

_DRAWIC     macro
  call _This._DRAWIC_
  endm

_UpdateIC  macro
  call _This._UpdateIC_
  endm

;---------------------------------------------------------------------------------
INTERCEPT       STRUC
  
  ic_X        DB      79
  ic_Y        DB      0

  active      DB      0

  _icSetXY_   DD      ?
  _DRAWIC_    DD      ?
  _UpdateIC_  DD      ? 

INTERCEPT       ends

IC_VAR      macro       var
var       INTERCEPT<,,,icSetXY,drawIC,updateIC>
endm

IC_VAR      ic1
ic1Addr       dd      ic1

IC_VAR      ic2
ic2Addr       dd      ic2

IC_VAR      ic3
ic3Addr       dd      ic3

IC_VAR      ic4
ic4Addr       dd      ic4

IC_VAR      ic5
ic5Addr       dd      ic5

IC_VAR      ic6
ic6Addr       dd      ic6

IC_VAR      ic7
ic7Addr       dd      ic7

IC_VAR      ic8
ic8Addr       dd      ic8

IC_VAR      ic9
ic9Addr       dd      ic9

IC_VAR      ic10
ic10Addr       dd      ic10

IC_VAR      ic11
ic11Addr       dd      ic11

IC_VAR      ic12
ic12Addr       dd      ic12

IC_VAR      ic13
ic13Addr       dd      ic13

IC_VAR      ic14
ic14Addr       dd      ic14

IC_VAR      ic15
ic15Addr       dd      ic15
;---------------------------------------------------------------------------------
BULLET      STRUC
  
  bullet_X    DB      0
  bullet_Y    DB      0

  onair       DB      0

  _SetXY_     dd      ?
  _DrawBullet_ dd     ?
  _UpdateBullet_ dd    ?

BULLET endS

BULLET_VAR      macro       var
var       BULLET<,,,bSetXY,drawBullet, updatebullet>
endm

BULLET_VAR      b1
b1Addr      dd      b1

BULLET_VAR      b2
b2Addr      dd      b2

BULLET_VAR      b3
b3Addr      dd      b3

BULLET_VAR      b4
b4Addr      dd      b4

BULLET_VAR      b5
b5Addr      dd      b5

BULLET_VAR      b6
b6Addr      dd      b6

BULLET_VAR      b7
b7Addr      dd      b7

BULLET_VAR      b8
b8Addr      dd      b8

BULLET_VAR      b9
b9Addr      dd      b9

BULLET_VAR      b10
b10Addr      dd      b10

BULLET_VAR      b11
b11Addr      dd      b11

BULLET_VAR      b12
b12Addr      dd      b12

BULLET_VAR      b13
b13Addr      dd      b13

BULLET_VAR      b14
b14Addr      dd      b14

BULLET_VAR      b15
b15Addr      dd      b15

BULLET_VAR      b16
b16Addr      dd      b16

BULLET_VAR      b17
b17Addr      dd      b17

BULLET_VAR      b18
b18Addr      dd      b18

BULLET_VAR      b19
b19Addr      dd      b19

BULLET_VAR      b20
b20Addr      dd      b20
;---------------------------------------------------------------------------------

SHIP      STRUC


  health_X        DB       5
  health          DW       3

  bomb            DW       2, '$'

  ship_X          DB      10
  ship_Y          DB      12
  shipFrame       DB       1

  ship_State      DB       1

  ship_Score      DB       0, '$'

  ship_Health     DB       3

  _DrawShip_      dd      ?
  _DrawHeart_     dd      ?
  _DrawBomb_      dd      ?
  _DrawScore_     dd      ?

SHIP ENDS

SHIP_VAR      macro     var
var         SHIP<,,,,,,,,,drawShip,drawHeart, drawBomb, drawScore>
endm

SHIP_VAR    myShip
myShipAddr      dd      myShip   
;---------------------------------------------------------------------------------
MENU      STRUC
  
  CURRENTFRAME    DB    1
  BGFRAME         DB    1
  SELECTION       DB    1

  X               DB    30
  Y               DB    15 


  _Display1_      dd     ?
  _Display2_      dd     ?
  _DisplayHi_ dd     ?



MENU ENDS


MENU_VAR      macro     var
var       MENU<,,,,,menuDisplay1, menuDisplay2, displayHi>
endm

MENU_VAR    HomeScreen
HomeScreenAddr           dd      HomeScreen              ;Provide convenient address for U1.


  ;INPUT2 DB ?, 0AH, 0DH
  ;INPUT3 DB ?,'$'

BACONS DB "I LOVe BACONSSS$"
;===================================================================================================================================
.CODE
;===================================================================================================================================
;**** methods for the MENU DATA TYPE ****
menuDisplay1     PROC      FAR

    MOV DL, 0
    MOV DH, 0
    CALL SET_CURSOR

    les   bx, HomeScreenAddr
    CMP _This.CURRENTFRAME, 1
    JE @DISPLAY1
    JNE @DISPLAY2

      @DISPLAY1:

        LEA DX, FRAME1FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.CURRENTFRAME, 2

        MOV DL, _This.X
        MOV DH, _This.Y
        CALL SET_CURSOR

        ;_DisplaySelect
        LEA DX, SELECT
        MOV AH, 09
        INT 21H

        ;les   bx, HomeScreenAddr
        ;MOV DL, _This.X
        ;MOV DH, _This.Y
        ;CALL SET_CURSOR

        CALL GET_KEY

        CALL DELAY

        JMP @PROCEED

      @DISPLAY2:
        LEA DX, FRAME2FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.CURRENTFRAME, 1

        MOV DL, _This.X
        MOV DH, _This.Y
        CALL SET_CURSOR

        ;_DisplaySelect
        LEA DX, SELECT
        MOV AH, 09
        INT 21H

        ;les   bx, HomeScreenAddr
        ;MOV DL, _This.X
        ;MOV DH, _This.Y
        ;CALL SET_CURSOR

        CALL GET_KEY

        CALL DELAY


        @PROCEED:

  ret
menuDisplay1     endP

menuDisplay2      PROC      FAR

    MOV AX, 0600H   ;full screen

    MOV CL, 00H   ;upper left row:column (50:50)
    MOV CH, 01H
    MOV DL, 79  ;lower right row:column (12:38)
    MOV DH, 23
    MOV BH, 0EH 
    INT 10H
    
    MOV DL, 0
    MOV DH, 1
    CALL SET_CURSOR

    les   bx, HomeScreenAddr
    CMP _This.BGFRAME, 1
    JNE @NEXTFRAME2

        LEA DX, BG1FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 2

        JMP @PROCEED1

    @NEXTFRAME2:
    CMP _This.BGFRAME, 2
    JNE @NEXTFRAME3

       LEA DX, BG2FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 3

        JMP @PROCEED1

    @NEXTFRAME3:
    CMP _This.BGFRAME, 3
    JNE @NEXTFRAME4

        LEA DX, BG3FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 4

        JMP @PROCEED1


    @NEXTFRAME4:
    CMP _This.BGFRAME, 4
    JNE @NEXTFRAME5

        LEA DX, BG4FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 5

        JMP @PROCEED1

    @NEXTFRAME5:
    CMP _This.BGFRAME, 5
    JNE @NEXTFRAME6

        LEA DX, BG5FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 6

        JMP @PROCEED1

    @NEXTFRAME6:
    CMP _This.BGFRAME, 6
    JNE @NEXTFRAME7

        LEA DX, BG6FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 7

        JMP @PROCEED1

    @NEXTFRAME7:
    CMP _This.BGFRAME, 7
    JNE @NEXTFRAME8

        LEA DX, BG7FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 8

        JMP @PROCEED1

    @NEXTFRAME8:
    CMP _This.BGFRAME, 8
    JNE @NEXTFRAME9

        LEA DX, BG8FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 9

        JMP @PROCEED1

    @NEXTFRAME9:
    CMP _This.BGFRAME, 9
    JNE @NEXTFRAME10

        LEA DX, BG9FILE
        CALL FILEREAD

        LEA DX, RECORD_STR
        MOV AH, 09
        INT 21H

        les   bx, HomeScreenAddr
        MOV _This.BGFRAME, 1

        JMP @PROCEED1

    @NEXTFRAME10:


        @PROCEED1:

        ;CALL DELAY
  

  ret
menuDisplay2      endp

displayHi      PROC     FAR
  
  MOV DL, 63
  MOV DH, 0
  CALL SET_CURSOR

  LEA DX, HISCORE
  MOV AH, 09
  INT 21H

  LEA DX, HIFILE

  MOV AX, 3D00H           ;requst open file            ;read only; 01 (write only); 10 (read/write)
  INT 21H

  MOV FILEHANDLE, AX

  MOV AH, 3FH           ;request read record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, 10           ;record length
  LEA DX, HISCORE_STR    ;address of input area
  INT 21H

  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H

  LEA DX, HISCORE_STR
  MOV AH, 09
  INT 21H

  ret
displayHi     endP


;**** MENU DATA TYPE end methods ****
;===================================================================================================================================
;===================================================================================================================================
;**** methods for the SHIP DATA TYPE ****

drawShip      PROC      FAR
  
  CMP _This.ship_State, 1
  JE  @DRAW_STATE1

  CMP _This.ship_State, 2
  ;JE  @DRAW_STATE2

  CMP _This.ship_State, 3
  ;JE @DRAW_STATE3

  @DRAW_STATE1:
    CALL DRAW_SHIPS1
  
  ;CALL DELAY


  @DRAW_STATE2:


  @DRAW_STATE3:

  ret
drawShip      endp

drawScore       PROC      FAR

  PUSH BX

  MOV DL, 32
  MOV DH, 0
  CALL SET_CURSOR

  LEA DX, SCORE
  MOV AH, 09
  INT 21H

  POP BX

  ADD _This.ship_Score, 48
  LEA DX, _This.ship_Score
  MOV AH, 09
  INT 21H

  SUB _This.ship_Score, 48

  MOV DL, _This.ship_X
  MOV DH, _This.ship_Y
  CALL SET_CURSOR

  ret
drawScore       endp

drawHeart       PROC      FAR
  
  MOV DL, 1
  MOV DH, 0
  CALL SET_CURSOR

  MOV   AL, 72  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  MOV   AL, 80  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  MOV   AL, 58  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr

  MOV CX, _This.health

  @HEARTLOOP:

    PUSH BX
    PUSH CX

    MOV AX, 0600H   ;full screen

    MOV CL, _This.health_X   ;upper left row:column (50:50)
    MOV CH, 00H
    MOV DL, _This.health_X  ;lower right row:column (12:38)
    MOV DH, 00H
    MOV BH, 04H 
    INT 10H

    POP CX
    POP BX

    les   bx, myShipAddr
    MOV DL, _This.health_X
    MOV DH, 0
    CALL SET_CURSOR

    MOV   AL, 03  ; "payting"
    MOV   AH, 02H
    MOV   DL, AL
    INT   21H    

    les   bx, myShipAddr
    ADD _This.health_X, 1

    LOOP @HEARTLOOP

    les   bx, myShipAddr
    MOV _This.health_X, 5

    ;CALL DELAY

  ret
drawHeart       endp

drawBomb      PROC      FAR
  
  les   bx, myShipAddr
  MOV DL, 1
  MOV DH, 24
  CALL SET_CURSOR

  MOV   AL, 237  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  MOV   AL, 00  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  MOV   AL, 120  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  MOV   AL, 00  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr

  ADD _This.Bomb, 48
  LEA DX, _This.Bomb
  MOV AH, 09H
  INT 21H

  SUB _This.Bomb, 48   

  ret
drawBomb      endp


;**** SHIP DATA TYPE end methods ****
;===================================================================================================================================
;===================================================================================================================================
;**** methods for the BULLET DATA TYPE ****
bSetXY      PROC      FAR
  
  PUSH BX

  les bx, myShipAddr

  MOV AL, _This.ship_X
  ADD AL, 4

  POP BX
  PUSH BX

  MOV _This.Bullet_X, AL

  les bx, myShipAddr

  MOV AL, _This.ship_Y

  POP BX
  MOV _This.Bullet_Y, AL

  ret
bSetXY      endp

drawBullet   PROC       FAR
  
  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.Bullet_X   ;upper left row:column (50:50)
  MOV CH, _This.Bullet_Y
  MOV DL, _This.Bullet_X  ;lower right row:column (12:38)
  MOV DH, _This.Bullet_Y
  MOV BH, 09H 
  INT 10H

  POP BX

  MOV DL, _This.Bullet_X
  MOV DH, _This.Bullet_Y
  CALL SET_CURSOR

  MOV   AL, 21  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  ADD _This.Bullet_X, 3

  les bx, myShipAddr

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR
  
  ret
drawBullet      endp

updateBullet      PROC      FAR
  
  CMP _This.Bullet_X, 75
  JL @KEEPUPDATING 

    MOV _This.onair, 0

    ret

  @KEEPUPDATING:
  ADD _This.Bullet_X, 5

  ret
updateBullet    endp

;**** BULLET DATA TYPE end methods ****
;===================================================================================================================================
;===================================================================================================================================
;**** methods for the INTERCEPTOR DATA TYPE ****
icSetXY       PROC      FAR
  
  ; should be something random (3 - 21)
  MOV _This.ic_Y, 12
  ret
icSetXY       endP

drawIC      PROC      FAR

  MOV DL, _This.ic_X
  MOV DH, _This.ic_Y
  CALL SET_CURSOR

  MOV   AL, 32  ; "payting"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  SUB _This.ic_X, 3

  les bx, myShipAddr

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR
  
  ret
drawIC      endP

updateIC      PROC      FAR

  CMP _This.ic_X, 5
  JL @KEEPUPDATINGIC 

    MOV _This.active, 0

    ret

  @KEEPUPDATINGIC:
  ADD _This.ic_X, 5

  ret
updateIC      endP 



;**** INTERCEPTOR DATA TYPE end methods ****
;===================================================================================================================================
;===================================================================================================================================

;----------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------

START PROC FAR
  MOV AX, @data
  MOV DS, AX


  @MAINMENU:

    CALL CLEAR_SCREEN

      les   bx, HomeScreenAddr
      _DISPLAY1


        CMP KEY_INPUT, 00
        JNE @ISACTION

        JMP @MAINMENU

        @ISACTION:
          CALL ACTION

    JMP @MAINMENU


  @TEMP_ENDLOOP:

  MOV AH, 4CH
  INT 21H

 START ENDP
 ;----------------------------------------------------------------------------------------
 ;----------------------------------------------------------------------------------------
 ;----------------------------------------------------------------------------------------
MAIN_GAME PROC NEAR
  
  @FIXEDUPDATE:

    CALL CLEAR_SCREEN

    les   bx, HomeScreenAddr
    _DISPLAY2
    _DISPLAYHI
    CALL DISPLAY_TIMER

    les   bx, myShipAddr
    _DRAWBOMB
    les   bx, myShipAddr
    _DRAWHEART
    les   bx, myShipAddr
    _DRAWSHIP
    _DrawScore

    CALL DRAWBULLETS
    CALL UPDATE_BULLETS

    CALL GENERATEIC

    CALL GET_KEY
    CALL DELAYEVENT

    CMP KEY_INPUT, 00
    JNE @ISEVENT

    JMP @FIXEDUPDATE

    @ISEVENT:
      CALL EVENT


        JMP @FIXEDUPDATE

  RET
MAIN_GAME ENDP

 ;----------------------------------------------------------------------------------------
 ;----------------------------------------------------------------------------------------
 ;----------------------------------------------------------------------------------------
EVENT    PROC   NEAR

  CMP KEY_INPUT, 01H ; if 'ESC'
  JE @EXITPRG1
  JNE @SHIPLISTENER

    @EXITPRG1:
    MOV AH, 4CH
    INT 21H

  @SHIPLISTENER:

    les   bx, myShipAddr

    CMP KEY_INPUT, 48H
    JE @MOVEUP

    CMP KEY_INPUT, 50H
    JE @MOVEDOWN

    CMP KEY_INPUT, 4BH
    JE @MOVELEFT

    CMP KEY_INPUT, 4DH
    JE @MOVERIGHT

    CMP KEY_INPUT, 39H
    JE @FIRE
    JNE @PORTAL


    @MOVEUP:
      DEC _This.ship_Y
      JMP @PORTAL

    @MOVEDOWN:
      INC _This.ship_Y
      JMP @PORTAL

    @MOVELEFT:
      DEC _This.ship_X
      JMP @PORTAL

    @MOVERIGHT:
      INC _This.ship_X
      JMP @PORTAL

    @FIRE:
      CALL FIREBULLET

  @PORTAL:
  MOV KEY_INPUT, 00

  ret
EVENT endp

 ;----------------------------------------------------------------------------------------
ACTION PROC NEAR

  CMP KEY_INPUT, 01H ; if 'ESC'
  JE @EXITPRG
  JNE @CONT

        @EXITPRG:
        MOV AH, 4CH
        INT 21H

        @CONT:
        
  CMP KEY_INPUT, 1CH ; if 'Enter Key'
  JE @CHECK_SELECTION
  JNE @CHECK_ARROWKEYS

          @CHECK_SELECTION:

            les   bx, HomeScreenAddr

            CMP _This.Selection, 1
            CALL MAIN_GAME

            CMP _This.Selection, 2
            ; CALL TUTORIAL

            CMP _This.Selection, 3
            JE @EXITPRG

            JMP @RETURNPOINT


          @CHECK_ARROWKEYS:

            CMP KEY_INPUT, 48H
            JE @CHECK_SELECTIONUP

            CMP KEY_INPUT, 50H
            JE @CHECK_SELECTIONDOWN
            JNE @RETURNPOINT

              @CHECK_SELECTIONUP:

              les   bx, HomeScreenAddr

              CMP _This.Selection, 1
              JE  @RETURNPOINT

              CMP _This.Selection, 2
              JE  @SELECTION2_UPDATEUP

              CMP _This.Selection, 3
              JE  @SELECTION3_UPDATEUP


                  @SELECTION2_UPDATEUP:

                  SUB _This.Y, 3
                  MOV _This.SELECTION, 1

                  JMP @RETURNPOINT


                  @SELECTION3_UPDATEUP:

                  SUB _This.Y, 3
                  MOV _This.SELECTION, 2

                  JMP @RETURNPOINT


              @CHECK_SELECTIONDOWN:

              les   bx, HomeScreenAddr

              CMP _This.Selection, 1
              JE  @SELECTION1_UPDATEDOWN

              CMP _This.Selection, 2
              JE  @SELECTION2_UPDATEDOWN

              CMP _This.Selection, 3
              JE  @RETURNPOINT

                  @SELECTION1_UPDATEDOWN:

                  ADD _This.Y, 3
                  MOV _This.SELECTION, 2

                  JMP @RETURNPOINT


                  @SELECTION2_UPDATEDOWN:

                  ADD _This.Y, 3
                  MOV _This.SELECTION, 3

                  JMP @RETURNPOINT


        @RETURNPOINT:
        MOV KEY_INPUT, 00

  RET
ACTION ENDP
  ;----------------------------------------------------------------------------------------
CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   ;full screen

  MOV BH, 0FH 
  MOV CX, 0000H   ;upper left row:column (50:50)
  MOV DX, 184FH   ;lower right row:column (12:38)
  INT 10H

  ;MOV BH, 01H     ;white background (7), blue foreground (1)
  ;MOV CX, 0101H   ;upper left row:column (50:50)
  ;MOV DX, 174EH   ;lower right row:column (12:38)
  ;INT 10H

  RET
CLEAR_SCREEN ENDP
;----------------------------------------------------------------------------------------
DELAYEVENT PROC NEAR
      mov bp, 2 ;lower value faster
      mov si, 2 ;lower value faster

    delay3:
      dec bp
      nop
      jnz delay3
      dec si
      cmp si,0
      jnz delay3
      RET
DELAYEVENT ENDP
;----------------------------------------------------------------------------------------

DELAY PROC NEAR
      mov bp, 4 ;lower value faster
      mov si, 4 ;lower value faster

    delay2:
      dec bp
      nop
      jnz delay2
      dec si
      cmp si,0
      jnz delay2
      RET
DELAY ENDP
;----------------------------------------------------------------------------------------
FILEREAD     PROC      NEAR

  MOV AX, 3D00H           ;requst open file            ;read only; 01 (write only); 10 (read/write)
  INT 21H

  MOV FILEHANDLE, AX

  MOV AH, 3FH           ;request read record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, 3000            ;record length
  LEA DX, RECORD_STR    ;address of input area
  INT 21H

  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H

  ret
FILEREAD ENDP
;----------------------------------------------------------------------------------------
DISPLAY_TIMER       PROC      NEAR
  MOV   DL, 78
  MOV   DH, 24
  CALL  SET_CURSOR

  LEA DX, GLOBAL_TIMER
  MOV AH, 09
  INT 21H

  INC GLOBAL_TIMER

  ret
DISPLAY_TIMER       ENDP
;----------------------------------------------------------------------------------------

SET_CURSOR PROC  NEAR
      MOV   AH, 02H
      MOV   BH, 00
      INT   10H
      RET
SET_CURSOR ENDP
;----------------------------------------------------------------------------------------
GET_KEY  PROC  NEAR
      MOV   AH, 01H   ;check for input
      INT   16H

      JZ    LEAVETHIS

      MOV   AH, 00H   ;get input  MOV AH, 10H; INT 16H
      INT   16H

      MOV   KEY_INPUT, AH

  LEAVETHIS:
      RET
GET_KEY  ENDP
;----------------------------------------------------------------------------------------
DRAW_SHIPS1     PROC    NEAR

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 0FH 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 219  ; "x"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H


  les   bx, myShipAddr
  ADD _This.Ship_x, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 0FH 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 91  ; "["
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  ADD _This.Ship_x, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 62  ; "="
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.Ship_x, 3

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 0FH 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 221  ; "K"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.Ship_y, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 192  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  ADD _This.Ship_y, 2

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 218  ; "/"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.ship_x, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 124  ; "/"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.ship_y, 2

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 124  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  ADD _This.ship_y, 1
  SUB _This.ship_x, 1


  ;240 - equivalence
  ;205 - =
  ;196 - -

  les   bx, myShipAddr
  CMP _This.shipFrame, 1
  JE @Thruster1

  @Thruster2:

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 0EH 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 61  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.ship_X, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 45  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  ADD _This.ship_X, 4

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  les   bx, myShipAddr
  MOV _This.shipFrame, 1

  RET


  @Thruster1:

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 240  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.ship_X, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 0EH 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 61  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  SUB _This.ship_X, 1

  PUSH BX

  MOV AX, 0600H   ;full screen

  MOV CL, _This.ship_X   ;upper left row:column (50:50)
  MOV CH, _This.ship_Y
  MOV DL, _This.ship_X  ;lower right row:column (12:38)
  MOV DH, _This.ship_Y
  MOV BH, 04H 
  INT 10H

  POP BX

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  MOV   AL, 45  ; "\"
  MOV   AH, 02H
  MOV   DL, AL
  INT   21H

  les   bx, myShipAddr
  ADD _This.ship_X, 5

  MOV   DL, _This.ship_X
  MOV   DH, _This.ship_Y
  CALL  SET_CURSOR

  les   bx, myShipAddr
  MOV _This.shipFrame, 2


  RET
DRAW_SHIPS1 ENDP
;----------------------------------------------------------------------------------------
FIREBULLET      PROC      NEAR
  
  les   bx, b1Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b2Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b3Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b4Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b5Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b6Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b7Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b8Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b9Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b10Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  les   bx, b11Addr
  CMP _This.onair, 0
  JE @INSTANTIATE


  les   bx, b12Addr
  CMP _This.onair, 0
  JE @INSTANTIATE

  @INSTANTIATE:
  MOV _This.onair, 1
  _SETXY

  ret
FIREBULLET  ENDP
;----------------------------------------------------------------------------------------
UPDATE_BULLETS      PROC      NEAR
  
  les   bx, b1Addr
  CMP _This.onair, 1
  JNE @NEXT2up

  _UpdateBullet

  @NEXT2up:
  les   bx, b2Addr
  CMP _This.onair, 1
  JNE @NEXT3up

  _UpdateBullet

  @NEXT3up:
  les   bx, b3Addr
  CMP _This.onair, 1
  JNE @NEXT4up

  _UpdateBullet

  @NEXT4up:
  les   bx, b4Addr
  CMP _This.onair, 1
  JNE @NEXT5up

  _UpdateBullet

  @NEXT5up:
  les   bx, b5Addr
  CMP _This.onair, 1
  JNE @NEXT6up

  _UpdateBullet

  @NEXT6up:
  les   bx, b6Addr
  CMP _This.onair, 1
  JNE @NEXT7up

  _UpdateBullet

  @NEXT7up:
  les   bx, b7Addr
  CMP _This.onair, 1
  JNE @NEXT8up

  _UpdateBullet

  @NEXT8up:
  les   bx, b8Addr
  CMP _This.onair, 1
  JNE @NEXT9up

  _UpdateBullet

  @NEXT9up:
  les   bx, b9Addr
  CMP _This.onair, 1
  JNE @NEXT10up

  _UpdateBullet

  @NEXT10up:
  les   bx, b10Addr
  CMP _This.onair, 1
  JNE @NEXT11up

  _UpdateBullet


  @NEXT11up:
  les   bx, b11Addr
  CMP _This.onair, 1
  JNE @NEXT12up

  _UpdateBullet

  @NEXT12up:
  les   bx, b12Addr
  CMP _This.onair, 1
  JNE @NEXT13up

  _UpdateBullet

  @NEXT13up:
  les   bx, b13Addr
  CMP _This.onair, 1
  JNE @NEXT14up

  _UpdateBullet

  @NEXT14up:
  les   bx, b14Addr
  CMP _This.onair, 1
  JNE @NEXT15up

  _UpdateBullet

  @NEXT15up:
  les   bx, b15Addr
  CMP _This.onair, 1
  JNE @NEXT16up

  _UpdateBullet

  @NEXT16up:
  les   bx, b16Addr
  CMP _This.onair, 1
  JNE @NEXT17up

  _UpdateBullet

  @NEXT17up:
  les   bx, b17Addr
  CMP _This.onair, 1
  JNE @NEXT18up

  _UpdateBullet

  @NEXT18up:
  les   bx, b18Addr
  CMP _This.onair, 1
  JNE @NEXT19up

  _UpdateBullet

  @NEXT19up:
  les   bx, b19Addr
  CMP _This.onair, 1
  JNE @NEXT20up

  _UpdateBullet

  @NEXT20up:
  les   bx, b20Addr
  CMP _This.onair, 1
  JNE @NEXT21up

  _UpdateBullet

  @NEXT21up:
  
  ret
UPDATE_BULLETS      ENDP
;----------------------------------------------------------------------------------------
DRAWBULLETS       PROC      NEAR
  
  les   bx, b1Addr
  CMP _This.onair, 1
  JNE @NEXT2

  _DrawBullet

  @NEXT2:
  les   bx, b2Addr
  CMP _This.onair, 1
  JNE @NEXT3

  _DrawBullet

  @NEXT3:
  les   bx, b3Addr
  CMP _This.onair, 1
  JNE @NEXT4

  _DrawBullet

  @NEXT4:
  les   bx, b4Addr
  CMP _This.onair, 1
  JNE @NEXT5

  _DrawBullet

  @NEXT5:
  les   bx, b5Addr
  CMP _This.onair, 1
  JNE @NEXT6

  _DrawBullet

  @NEXT6:
  les   bx, b6Addr
  CMP _This.onair, 1
  JNE @NEXT7

  _DrawBullet

  @NEXT7:
  les   bx, b7Addr
  CMP _This.onair, 1
  JNE @NEXT8

  _DrawBullet

  @NEXT8:
  les   bx, b8Addr
  CMP _This.onair, 1
  JNE @NEXT9

  _DrawBullet

  @NEXT9:
  les   bx, b9Addr
  CMP _This.onair, 1
  JNE @NEXT10

  _DrawBullet

  @NEXT10:

  les   bx, b10Addr
  CMP _This.onair, 1
  JNE @NEXT11

  _DrawBullet

  @NEXT11:

  les   bx, b11Addr
  CMP _This.onair, 1
  JNE @NEXT12

  _DrawBullet

  @NEXT12:

  les   bx, b12Addr
  CMP _This.onair, 1
  JNE @NEXT13

  _DrawBullet

  @NEXT13:

  les   bx, b13Addr
  CMP _This.onair, 1
  JNE @NEXT14

  _DrawBullet

  @NEXT14:

  les   bx, b14Addr
  CMP _This.onair, 1
  JNE @NEXT15

  _DrawBullet

  @NEXT15:

  les   bx, b15Addr
  CMP _This.onair, 1
  JNE @NEXT16

  _DrawBullet

  @NEXT16:

  les   bx, b16Addr
  CMP _This.onair, 1
  JNE @NEXT17

  _DrawBullet

  @NEXT17:

  les   bx, b17Addr
  CMP _This.onair, 1
  JNE @NEXT18

  _DrawBullet

  @NEXT18:

  les   bx, b18Addr
  CMP _This.onair, 1
  JNE @NEXT19

  _DrawBullet

  @NEXT19:
  les   bx, b19Addr
  CMP _This.onair, 1
  JNE @NEXT20

  _DrawBullet

  @NEXT20:
  les   bx, b20Addr
  CMP _This.onair, 1
  JNE @NEXT21

  _DrawBullet

  @NEXT21:

  ret
DRAWBULLETS   ENDP

;----------------------------------------------------------------------------------------
GENERATEIC      PROC      NEAR
  
  les   bx, ic1Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic2Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic3Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic4Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic5Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic6Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic7Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic8Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic9Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic10Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic11Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  les   bx, ic12Addr
  CMP _This.active, 0
  JE @INSTANTIATEIC

  @INSTANTIATEIC:
  MOV _This.active, 1
  _ICSETXY

  ret
GENERATEIC      ENDP
;----------------------------------------------------------------------------------------
DRAWICS      PROC      NEAR

  les   bx, ic1Addr
  CMP _This.active, 1
  JNE @ICNEXT2

  _DRAWIC
  _UpdateIC

  @ICNEXT2:
  les   bx, ic2Addr
  CMP _This.active, 1
  JNE @ICNEXT3

  _DRAWIC
  _UpdateIC
  @ICNEXT3:
  les   bx, ic3Addr
  CMP _This.active, 1
  JNE @ICNEXT4

  _DRAWIC
  _UpdateIC

  @ICNEXT4:
  les   bx, ic4Addr
  CMP _This.active, 1
  JNE @ICNEXT5

  _DRAWIC
  _UpdateIC

  @ICNEXT5:
  les   bx, ic5Addr
  CMP _This.active, 1
  JNE @ICNEXT6

  _DRAWIC
  _UpdateIC

  @ICNEXT6:
  les   bx, ic6Addr
  CMP _This.active, 1
  JNE @ICNEXT7

  _DRAWIC
  _UpdateIC

  @ICNEXT7:
  les   bx, ic7Addr
  CMP _This.active, 1
  JNE @ICNEXT8

  _DRAWIC
  _UpdateIC

  @ICNEXT8:
  les   bx, ic8Addr
  CMP _This.active, 1
  JNE @ICNEXT9

  _DRAWIC
  _UpdateIC

  @ICNEXT9:
  les   bx, ic9Addr
  CMP _This.active, 1
  JNE @ICNEXT10

  _DRAWIC
  _UpdateIC

  @ICNEXT10:
  les   bx, ic10Addr
  CMP _This.active, 1
  JNE @ICNEXT11

  _DRAWIC
  _UpdateIC

  @ICNEXT11:
  les   bx, ic11Addr
  CMP _This.active, 1
  JNE @ICNEXT12

  _DRAWIC
  _UpdateIC

  @ICNEXT12:
  les   bx, ic12Addr
  CMP _This.active, 1
  JNE @ICNEXT13

  _DRAWIC
  _UpdateIC

  @ICNEXT13:
  
  ret
DRAWICS      ENDP
;----------------------------------------------------------------------------------------
UPDATEICS      PROC      NEAR
  
  ret
UPDATEICS      ENDP
;----------------------------------------------------------------------------------------

END START