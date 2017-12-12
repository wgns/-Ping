TITLE GAME
.MODEL SMALL
;----------------------------------------------------------------------------------------------------------
.STACK 128
;----------------------------------------------------------------------------------------------------------
.DATA
	FILE1					DB	'bgframe1.txt', 00H
	FILE2					DB	'bgframe2.txt', 00H
	FILE3					DB 	'hiscore.txt', 00H
	HANDLE				DW	?
	FRAME1				DB	1837	DUP		(' ')
	FRAME2				DB	1837	DUP		(' ')
	HISCORE 			DB 	4			DUP		('0')
	TXT_HI				DB 	"HI SCORE:"
	BOX_UP				DB	218, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 191
	TXT_START			DB	179, " START GAME ", 179
	TXT_HOWTO			DB	179, "   HOW TO   ", 179
	TXT_EXIT			DB	179, "    EXIT    ", 179
	TXT_BACK			DB	179, "    BACK    ", 179
	BOX_DOWN			DB	192, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 217
	TITLE_L1			DB	"      :::    ::::::::: ::::::::::: ::::    :::  ::::::::"
	TITLE_L2			DB	"      :+:   :+:    :+:    :+:     :+:+:   :+: :+:    :+:"
	TITLE_L3			DB	"      +:+  +:+    +:+    +:+     :+:+:+  +:+ +:+        "
	TITLE_L4			DB	"      +#+ +#++:++#+     +#+     +#+ +:+ +#+ :#:         "
	TITLE_L5			DB	"    +#+  +#+           +#+     +#+  +#+#+# +#+   +#+#   "
	TITLE_L6			DB	"  #+#   #+#           #+#     #+#   #+#+# #+#    #+#    "
	TITLE_L7			DB	"###    ###       ########### ###    ####  ########      "
	ROCKETUP1			DB 	"                     __       "
	ROCKETUP2			DB 	"                     \ \_____ "
	ROCKETUP3			DB 	"-  -  -  =  =  =  ###[==_____>"
	ROCKETUP4			DB 	"                     /_/      "
	ROCKETDOWN1		DB 	"       __                     "
	ROCKETDOWN2		DB 	" _____/ /                     "
	ROCKETDOWN3		DB 	"<_____==]###  =  =  =  -  -  -"
	ROCKETDOWN4		DB 	"      \_\                     "
	ROCKETUPDL		DB 	00
	ROCKETDOWNDL	DB 	32H
	HOWTOUP				DB 	"Arrow up    - move spaceship up   "
	HOWTODOWN			DB 	"Arrow down  - move spaceship down "
	HOWTOLEFT			DB 	"Arrow left  - move spaceship left "
	HOWTORIGHT		DB 	"Arrow right - move spaceship right"
	HOWTOSPACE		DB 	"Space       - shoot               "
	CHOICE				DB	01
	CTR						DB 	01
	BUTTON				DB 	00
	QUIT					DB 	00

;----------------------------------------------------------------------------------------------------------
.CODE
MAIN PROC FAR
	MOV		AX, @data
	MOV		DS, AX
	MOV 	ES, AX

	LEA		DX, FRAME1
	PUSH 	DX
	LEA		DX, FILE1
	CALL	__FILEGET

	LEA		DX, FRAME2
	PUSH 	DX
	LEA		DX, FILE2
	CALL	__FILEGET

	LEA		DX, HISCORE
	PUSH 	DX
	LEA		DX, FILE3
	CALL	__FILEGET

_START:
	LEA		BP, FRAME1
	CALL	__DISPLAYBG
	CALL	__DISPLAYHI
	CALL	__GETINPUT
	CALL	__ACTIONHOME
	CALL	__DISPLAYALLTITLE	
	CALL	__DISPLAYALLOPTIONS
	CALL	__DELAY

	LEA		BP, FRAME2
	CALL	__DISPLAYBG
	CALL	__DISPLAYHI
	CALL	__GETINPUT
	CALL	__ACTIONHOME
	CALL	__DISPLAYALLTITLE
	CALL	__DISPLAYALLOPTIONS
	CALL	__DELAY

	CMP		QUIT, 01
	JE 		_EXIT
	JMP		_START

_EXIT:
	MOV		AH, 4CH
	INT		21H
MAIN ENDP
;------------------------------------------------
__STARTGAME PROC NEAR					; game logic here

	RET
__STARTGAME ENDP
;------------------------------------------------
__ACTIONGAME PROC NEAR				; ingame 'key listener' here

	RET
__ACTIONGAME ENDP
;------------------------------------------------
__DISPLAYHOWTO PROC NEAR
	MOV		BUTTON, 00

_HOW:
	MOV 	AX, 0600H
  MOV 	BH, 0FH
  MOV 	CX, 0000H
  MOV 	DX, 184FH
  INT 	10H

  LEA		BP, ROCKETUP1
  MOV 	DH, 00
  MOV 	DL, ROCKETUPDL
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETUP2
  INC 	DH
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETUP3
  INC 	DH
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETUP4
  INC 	DH
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETDOWN1
  MOV 	DH, 21
  MOV 	DL, ROCKETDOWNDL
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETDOWN2
  INC 	DH
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETDOWN3
  INC 	DH
  CALL	__DISPLAYROCKET

  LEA		BP, ROCKETDOWN4
  INC 	DH
  CALL	__DISPLAYROCKET

  MOV		BL, 0DH 							; print back 'button'
	MOV		DX, 0602H
	CALL	__PRINTUPPERBOX

	LEA		BP, TXT_BACK
	CALL	__DISPLAYOPTIONS
	INC		DH

	CALL	__PRINTLOWERBOX

	LEA		BP, HOWTOUP						; print controls
	MOV 	DX, 0914H
	CALL	__DISPLAYCONTROL

	LEA		BP, HOWTODOWN
	ADD 	DH, 02
	CALL	__DISPLAYCONTROL

	LEA		BP, HOWTOLEFT
	ADD 	DH, 02
	CALL	__DISPLAYCONTROL

	LEA		BP, HOWTORIGHT
	ADD 	DH, 02
	CALL	__DISPLAYCONTROL

	LEA		BP, HOWTOSPACE
	ADD 	DH, 02
	CALL	__DISPLAYCONTROL

	CALL 	__GETINPUT						; check if back
	CMP		BUTTON, 1CH
	JE 		_BACK

	CMP		ROCKETUPDL, 4BH
	JE 		_RESETUP
	ADD 	ROCKETUPDL, 19H

	CMP		ROCKETDOWNDL, -25
	JE 		_RESETDOWN
	SUB		ROCKETDOWNDL, 19H

	CALL	__DELAY

	JMP		_HOW

_RESETUP:
	MOV 	ROCKETUPDL, 00
	JMP		_HOW

_RESETDOWN:
	MOV 	ROCKETDOWNDL, 32H
	JMP		_HOW

_BACK:
	MOV		BUTTON, 00
	RET
__DISPLAYHOWTO ENDP
;------------------------------------------------
__DISPLAYCONTROL PROC NEAR
	MOV		AX, 1300H
  MOV		BX, 000FH
  MOV		CX, 34
  INT 	10H

	RET
__DISPLAYCONTROL ENDP
;------------------------------------------------
__DISPLAYROCKET PROC NEAR
	MOV		AX, 1300H
  MOV		BX, 000AH
  MOV		CX, 30
  INT 	10H

	RET
__DISPLAYROCKET ENDP
;------------------------------------------------
__ACTIONHOME PROC NEAR				; start screen 'key listener'
	CMP		BUTTON, 48H
	JE 		_UP

	CMP		BUTTON, 50H
	JE 		_DOWN

	CMP		BUTTON, 1CH
	JE 		_ENTER
	JNE		_NONE

_UP:
	CMP		CHOICE, 01
	JE 		_NONE
	DEC		CHOICE
	JMP		_NONE

_DOWN:
	CMP		CHOICE, 03
	JE 		_NONE
	INC		CHOICE
	JMP		_NONE

_ENTER:
	CMP		CHOICE, 03
	JE 		_ISQUIT

	CMP		CHOICE, 02
	JE 		_ISHOWTO

	CALL	__STARTGAME
	RET

_ISHOWTO:
	CALL	__DISPLAYHOWTO
	RET

_ISQUIT:
	MOV		QUIT, 01

_NONE:
	MOV		BUTTON, 00
	RET
__ACTIONHOME ENDP
;------------------------------------------------
__GETINPUT PROC NEAR
  MOV 	AH, 01H
  INT 	16H
  JZ 		_NO_INPUT

  MOV 	AH, 00H
  INT 	16H
  MOV 	BUTTON, AH

_NO_INPUT:
  RET
__GETINPUT ENDP
;------------------------------------------------
__DISPLAYALLOPTIONS PROC NEAR
	MOV		DX, 0D20H

_PRINTUP:
	MOV		AL, CTR
	MOV		AH, CHOICE
	CMP		AL, AH
	JE 		_ISSELECTEDUP

	MOV		BL, 0FH
	JMP		_PRINT_UP

_ISSELECTEDUP:
	MOV		BL, 0DH

_PRINT_UP:
	CALL	__PRINTUPPERBOX

	CMP		CTR, 02
	JL 		_PRINTSTART
	JE 		_PRINTHOWTO
	JG		_PRINTEXIT

_PRINTSTART:
	CMP		CHOICE, 01
	JE 		_STARTSELECTED
	MOV		BL, 0FH
	JMP		_DISPLAYSTART

_STARTSELECTED:
	MOV		BL, 0DH

_DISPLAYSTART:
	CALL	__PRINTSTART
	JMP		_PRINTDOWN

_PRINTHOWTO:
	CMP		CHOICE, 02
	JE 		_HOWTOSELECTED
	MOV		BL, 0FH
	JMP		_DISPLAYHOWTO

_HOWTOSELECTED:
	MOV		BL, 0DH

_DISPLAYHOWTO:
	CALL	__PRINTHOWTO
	JMP		_PRINTDOWN

_PRINTEXIT:
	CMP		CHOICE, 03
	JE 		_EXITSELECTED
	MOV		BL, 0FH
	JMP		_DISPLAYEXIT

_EXITSELECTED:
	MOV		BL, 0DH

_DISPLAYEXIT:
	CALL	__PRINTEXIT

_PRINTDOWN:
	MOV		AL, CTR
	MOV		AH, CHOICE
	CMP		AL, AH
	JE 		_ISSELECTEDDOWN

	MOV		BL, 0FH
	JMP		_PRINT_DOWN

_ISSELECTEDDOWN:
	MOV		BL, 0DH

_PRINT_DOWN:
	CALL 	__PRINTLOWERBOX

	INC		CTR
	CMP		CTR, 03
	JLE		_PRINTUP

	MOV		CTR, 01
	RET
__DISPLAYALLOPTIONS ENDP
;------------------------------------------------
__PRINTEXIT PROC NEAR
	LEA		BP, TXT_EXIT
	CALL	__DISPLAYOPTIONS
	INC 	DH

	RET
__PRINTEXIT ENDP
;------------------------------------------------
__PRINTHOWTO PROC NEAR
	LEA		BP, TXT_HOWTO
	CALL	__DISPLAYOPTIONS
	INC 	DH

	RET
__PRINTHOWTO ENDP
;------------------------------------------------
__PRINTSTART PROC NEAR
	LEA		BP, TXT_START
	CALL	__DISPLAYOPTIONS
	INC 	DH

	RET
__PRINTSTART ENDP
;------------------------------------------------
__PRINTUPPERBOX PROC NEAR
	LEA		BP, BOX_UP
	CALL	__DISPLAYOPTIONS
	INC 	DH

	RET
__PRINTUPPERBOX ENDP
;------------------------------------------------
__PRINTLOWERBOX PROC NEAR
	LEA		BP, BOX_DOWN
	CALL	__DISPLAYOPTIONS
	INC 	DH

	RET
__PRINTLOWERBOX ENDP
;------------------------------------------------
__DISPLAYOPTIONS PROC NEAR
	MOV		AX, 1300H
  MOV		BH, 00
  MOV		CX, 14
  INT 	10H

	RET
__DISPLAYOPTIONS ENDP
;------------------------------------------------
__DISPLAYALLTITLE PROC NEAR
	LEA		BP, TITLE_L1
	MOV		DX, 020BH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L2
	INC		DH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L3
	INC		DH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L4
	INC		DH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L5
	INC		DH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L6
	INC		DH
	CALL	__DISPLAYTITLE

	LEA		BP, TITLE_L7
	INC		DH
	CALL	__DISPLAYTITLE

	RET
__DISPLAYALLTITLE ENDP
;------------------------------------------------
__DISPLAYTITLE PROC NEAR
	MOV		AX, 1300H
  MOV		BX, 000BH
  MOV		CX, 56
  INT 	10H

	RET
__DISPLAYTITLE ENDP
;------------------------------------------------
__DISPLAYBG PROC NEAR
  MOV		AX, 1300H
  MOV		BX, 000EH
  MOV		CX, 1837
  MOV 	DX, 0100H
  INT 	10H

	RET
__DISPLAYBG ENDP
;------------------------------------------------
__DISPLAYHI PROC NEAR
	LEA		BP, TXT_HI
  MOV		AX, 1300H
  MOV		BX, 000FH
  MOV		CX, 9
  MOV 	DX, 1440H
  INT 	10H

  LEA		BP, HISCORE
  MOV		AX, 1300H
  MOV		BX, 000FH
  MOV		CX, 4
  MOV 	DX, 1540H
  INT 	10H

	RET
__DISPLAYHI ENDP
;------------------------------------------------
__FILEGET PROC NEAR
	MOV 	AX, 3D00H
  INT 	21H
  MOV		HANDLE, AX

  POP		BX
  POP		DX
  PUSH	BX
  MOV 	AH, 3FH
  MOV 	BX, HANDLE
  MOV 	CX, 1837
  INT 	21H

  MOV 	AH, 3EH
  MOV 	BX, HANDLE
  INT 	21H

  RET
__FILEGET ENDP
;------------------------------------------------
__DELAY PROC NEAR
  MOV 	BP, 6
  MOV 	SI, 6

  _DELAY2:
    DEC BP
    NOP
    JNZ _DELAY2

    DEC SI
    CMP SI, 0
    JNZ _DELAY2

   RET
__DELAY ENDP
END MAIN