ORG 00H
SJMP MAIN
;swap works only on accumulator
ORG 40H
	
	MAIN: ACALL INIT
		  ACALL ALU
		  SJMP MAIN
	
	INIT:MOV P0,#0XFF
		 MOV A, P0
		 ANL A,#0X0F
		 MOV R1,A
		 MOV A, P0
		 ANL A,#0XF0
		 SWAP A
		 MOV R2,A
		 MOV P1, #0XFF
		 MOV A, P1
		 ANL A,#0X3
		 RET 
		 
	ALU:CJNE A,#0X00,SUBB1
		MOV A,R1
		ADD A,R2
		SJMP RESULT
		
	SUBB1:CJNE A,#0X01,ANDL
		  MOV A,R1
		  SUBB A,R2
		  SJMP RESULT
		  
    ANDL:CJNE A,#0X02,ORL1
		 MOV A,R1
		 ANL A,R2
		 SJMP RESULT
		 
	ORL1:
		 MOV A,R1
		 ORL A,R2
		 SJMP RESULT
		 
	RESULT:MOV P2,A
		   RET
END