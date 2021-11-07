ORG 00h
  first:
             MOV P1,#0xFF ;create P1 as an input port by passing high value
			 MOV R0,#255  ;create R0 as an input port by passing high value
			 MOV R1,#255   ;create R1 as an input port by passing high value

	BACK1:		 DJNZ R0,BACK1   ;used to create delay
				DJNZ R1,BACK1        ;used to create delay DJNZ means decrement and jump if not equal to zero so it keeps decrementing from 255 to 0

             MOV P1,#0x00  ;passing low input to turn off the led
			 	 MOV R0,#255
			 MOV R1,#255
	BACK2:		 DJNZ R0,BACK2
				  DJNZ R1,BACK2
              sjmp first  ;to turn on the led again
              END
