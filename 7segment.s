org 00h
	sjmp main
	org 40h
		
		seg7:db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x7, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
		
	main:acall init
		 acall segmentdisplay
		 sjmp main
	
	init:mov p0,#0xff
		 mov a,p0
		 anl a,#0xf0
		 swap a
	     mov r1,a
		 mov p0,#0xff
		 mov a,p0
		 anl a,#0x03
		 mov r2,a
		  
	segmentdisplay:cjne r2,#0x00,down
				   mov dptr,#seg7
				   mov r0,#0x00
			   up1:mov a,r0
				   movc a,@a+dptr
				   mov p2,a
				   acall delay
				   inc r0
				   mov a,r1
				   subb a,r0
				   jnc up1
				   sjmp main
				   
	down:cjne r2,#0x01,stop
		 mov dptr,#seg7
		 mov r0,#0x0f
		 down1:mov a,r0
			   movc a,@a+dptr
			   mov p2,a
			   acall delay
			   dec r0
			   mov a,r1
			   subb a,r0
			   jc down1
			   sjmp main
			   
	stop:sjmp main
	
	delay:;djnz r5,delay
		  ;djnz r6,delay
		  ;djnz r7,delay
		  ret
	end