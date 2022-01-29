org 00H
SJMP MAIN
org 64h
	
	main:acall init
		 acall stepper
		 sjmp main

	init:mov p1,#0xff
		 mov a, p1
		 anl a,#0x03
		 mov r2,a
		 ret
		 
	stepper:cjne r2,#0x00,aclk
		 mov p0,#8
		 acall delay
		 mov p0,#4
		 acall delay
		 mov p0,#2
		 acall delay
		 mov p0,#1
		 
	aclk:cjne r2,#0x01,stop
		 mov p0, #2
		 acall delay
		 mov p0,#4
		 acall delay
		 mov p0,#8
		 acall delay
		 mov p0,#1
		 
	stop:sjmp main
		 
	delay: djnz r4,delay
		   djnz r5,delay
		   ret
		 
		 end