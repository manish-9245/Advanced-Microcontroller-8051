ORG 00H
sjmp main
org 40h
	
	rv0: db 00h,01h,02h,03h,04h
	rv1: db 05h,06h,07h,08h,09h
	rv2:db 0Ah,0bh,0ch,0dh,0eh
	rv3:db 0fh,10h,11h,12h,13h
	
	main:acall init
	main2:acall checkrow
		 sjmp main2
		 
	init:mov p0,#0xff
		 mov p1,#0x00 ;Enabling one row at a time
		 
	checkrow:mov p1,#0x0e
			 mov a,p0
			 anl a,#0x1f
			 cjne a,#0x1f,k_p_0
			 
			 mov p1,#0x0d
			 mov a,p0
			 anl a,#0x1f
			 cjne a,#0x1f,k_p_1
			 
			 mov p1,#0x0b
			 mov a,p0
			 anl a,#0x1f
			 cjne a,#0x1f,k_p_2
			 
			 mov p1,#0x07
			 mov a,p0
			 anl a,#0x1f
			 cjne a,#0x1f,k_p_3
			 
			 ret
			 
		k_p_0:mov dptr,#rv0
			  sjmp find
			  
		k_p_1:mov dptr,#rv1
			  sjmp find
		
		k_p_2:mov dptr,#rv2
			 sjmp find
			 
		k_p_3:mov dptr,#rv3
			 sjmp find
			 
		find:rrc a   ;rrc is done only for accumulator
			 jnc match
			 inc dptr
			 sjmp find
			 
		match:mov a,#00h
			  movc a,@a + dptr
			  mov p2,a
			  sjmp main2
			  
		end