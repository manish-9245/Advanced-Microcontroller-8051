org 00h	
	sjmp main
	org 40h
		
		main:acall init
			 acall dac
			 sjmp main
			 
		init:mov r0,#5
			 mov r1,#0
			 mov p1,#0xff
			 mov a,p1
			 anl a,#0x03
			 mov r2,a
			 ret
			 
		dac:cjne r2,#0x00,tri
			mov p0,r1
			acall delay
			mov p0,r0
			acall delay
			ret
			
		tri:cjne r2,#0x01,sawR
			mov r3,#0x1
			rise:mov p0,r3
				 inc r3
				 ;acall delay
				 mov a,r3
				 subb a,r0
				 jc rise
				 
			fall:dec r3
				 ;acall delay
				 mov p0,r3
				 mov a,r3
				 subb a,r1
				 jnc fall
				 
			ret
			
		sawR:cjne r2,#0x02,sawF
			 mov r3,#0x1
			 sawRise:mov p0,r3
					 ;acall delay
					 inc r3
					 mov a,r3
					 subb a,r0
					 jc sawRise
					 
			ret
			
		sawF:mov r3,#0x0
			 sawFall:mov p0,r3
					 ;acall delay
					 dec r3
					 mov a,r3
					 subb a,r1
					 jnc sawFall
					 
			ret
			
		delay:djnz r4,delay
			  djnz r5,delay
			  ret
			  
		end