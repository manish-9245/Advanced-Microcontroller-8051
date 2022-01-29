ORG 00H
 SJMP MAIN
ORG 40H

D0:db 'Microcontroller '
D1:db 'LCD             '
D2:db 'Switch = 2      '
D3:db 'Switch = 3      '


 MAIN:  
      
      ACALL INIT
      SJMP CI

INIT:
       
        MOV     R0, #0x38        ;       1 DL               N Fm X X
        ACALL   INST_LCD         ;   1 (datalengt8=1)	   (no of lines2 =1)(F(7x5dotmat)=0)
        ACALL   DELAY3reg
        MOV     R0, #0x38
        ACALL   INST_LCD
        ACALL   DELAY3reg
        MOV     R0, #0x38
        ACALL   INST_LCD
        ACALL   DELAY3reg
        MOV     R0, #0xF         ;1 D C B
        ACALL   INST_LCD         ;1 (Display on D=1)(Cursor on C=1)(Blink On B=1)
        ACALL   DELAY2reg
        MOV     R0, #0x1	     ;1
        ACALL   INST_LCD	     ;(Clear Display)
        ACALL   DELAY2reg
        RET
INST_LCD:
		
        CLR     P3.7	    ;RS BIT
        CLR     P3.6	    ;write=0
        
        MOV     P2, R0
        
        SETB    P3.5        ;enable =1
        ACALL   DELAY2reg
        CLR     P3.5
        	             ;enable =0
        RET
        
DATA_LCD:
        SETB    P3.7	      ;RS=1
        CLR     P3.6	      ;WRITE=0
        
        MOV     P2, R0
        
        SETB    P3.5	       ;Enable=1
        ACALL   DELAY2reg
        CLR     P3.5           ;Enable=0
        RET


CI:
         MOV P0,#0XFF
         MOV A,P0
         ANL A,#0x03
    
      CJNE A,#0X00,W1
      MOV DPTR,#D0
      SJMP DD
        
   W1: CJNE A,#0X01,W2
       MOV DPTR,#D1
       SJMP DD
   
   W2: CJNE A,#0X02,W3
       MOV DPTR,#D2
       SJMP DD
    
   W3: MOV DPTR,#D3  
       SJMP DD
       
 DELAY3reg:
        DJNZ    R4, DELAY3reg  
        DJNZ    R5, DELAY3reg  
     ; I tried to use only one delay register and it worked in both delay2 and delay3
        
DELAY2reg:
        DJNZ    R4, DELAY2reg
        ;DJNZ    R5, DELAY2reg
        RET
DD:    	  
        MOV     R0, #0x01	 ;CLEAR DISPLAY
        ACALL   INST_LCD
        ACALL   DELAY2reg

        MOV     R1, #0

  DISPLAY:
        MOV     A, R1
        MOVC    A, @A+DPTR
        MOV     R0, A
        ACALL   DATA_LCD
        ACALL   DELAY2reg
        INC     R1
        CJNE    R1, #0xF, DISPLAY

        END