
_InitMain:

;pwmsample.c,1 :: 		void InitMain() {
;pwmsample.c,3 :: 		PORTA = 255;
	MOVLW      255
	MOVWF      PORTA+0
;pwmsample.c,4 :: 		TRISA = 255;                        // configure PORTA pins as input
	MOVLW      255
	MOVWF      TRISA+0
;pwmsample.c,5 :: 		PORTD = 0x00;                          // set PORTB to 0
	CLRF       PORTD+0
;pwmsample.c,6 :: 		TRISD = 0xFF;                          // designate PORTB pins as output
	MOVLW      255
	MOVWF      TRISD+0
;pwmsample.c,7 :: 		PORTC = 0x00;                          // set PORTC to 0
	CLRF       PORTC+0
;pwmsample.c,8 :: 		TRISC = 0x00;                          // designate PORTC pins as output
	CLRF       TRISC+0
;pwmsample.c,9 :: 		PWM1_Init(1000);                    // Initialize PWM1 module at 5KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;pwmsample.c,10 :: 		PWM2_Init(1000);                    // Initialize PWM2 module at 5KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;pwmsample.c,11 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_speed:

;pwmsample.c,13 :: 		void speed(float pwm1 , float pwm2)
;pwmsample.c,15 :: 		PWM1_Set_Duty(pwm1*255);
	MOVF       FARG_speed_pwm1+0, 0
	MOVWF      R0+0
	MOVF       FARG_speed_pwm1+1, 0
	MOVWF      R0+1
	MOVF       FARG_speed_pwm1+2, 0
	MOVWF      R0+2
	MOVF       FARG_speed_pwm1+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;pwmsample.c,16 :: 		PWM2_Set_Duty(pwm2*255);
	MOVF       FARG_speed_pwm2+0, 0
	MOVWF      R0+0
	MOVF       FARG_speed_pwm2+1, 0
	MOVWF      R0+1
	MOVF       FARG_speed_pwm2+2, 0
	MOVWF      R0+2
	MOVF       FARG_speed_pwm2+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;pwmsample.c,17 :: 		}
L_end_speed:
	RETURN
; end of _speed

_main:

;pwmsample.c,18 :: 		void main() {
;pwmsample.c,19 :: 		int flag = 0;
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;pwmsample.c,20 :: 		InitMain();
	CALL       _InitMain+0
;pwmsample.c,21 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;pwmsample.c,22 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;pwmsample.c,23 :: 		PWM1_Set_Duty(0);        // Set current duty for PWM1
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;pwmsample.c,24 :: 		PWM2_Set_Duty(0);       // Set current duty for PWM2
	CLRF       FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;pwmsample.c,26 :: 		while (1)
L_main0:
;pwmsample.c,30 :: 		if((RD4_bit==0)&&(RD5_bit==1)&&(RD6_bit==1)&&(RD7_bit==0))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main4
	BTFSS      RD5_bit+0, 5
	GOTO       L_main4
	BTFSS      RD6_bit+0, 6
	GOTO       L_main4
	BTFSC      RD7_bit+0, 7
	GOTO       L_main4
L__main35:
;pwmsample.c,32 :: 		speed(0.80,0.80);
	MOVLW      205
	MOVWF      FARG_speed_pwm1+0
	MOVLW      204
	MOVWF      FARG_speed_pwm1+1
	MOVLW      76
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      205
	MOVWF      FARG_speed_pwm2+0
	MOVLW      204
	MOVWF      FARG_speed_pwm2+1
	MOVLW      76
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,33 :: 		}
	GOTO       L_main5
L_main4:
;pwmsample.c,36 :: 		else if((RD4_bit==1)&&(RD5_bit==1)&&(RD6_bit==0)&&(RD7_bit==0))
	BTFSS      RD4_bit+0, 4
	GOTO       L_main8
	BTFSS      RD5_bit+0, 5
	GOTO       L_main8
	BTFSC      RD6_bit+0, 6
	GOTO       L_main8
	BTFSC      RD7_bit+0, 7
	GOTO       L_main8
L__main34:
;pwmsample.c,38 :: 		speed(0.40,0.80);
	MOVLW      205
	MOVWF      FARG_speed_pwm1+0
	MOVLW      204
	MOVWF      FARG_speed_pwm1+1
	MOVLW      76
	MOVWF      FARG_speed_pwm1+2
	MOVLW      125
	MOVWF      FARG_speed_pwm1+3
	MOVLW      205
	MOVWF      FARG_speed_pwm2+0
	MOVLW      204
	MOVWF      FARG_speed_pwm2+1
	MOVLW      76
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,39 :: 		}
	GOTO       L_main9
L_main8:
;pwmsample.c,42 :: 		else if((RD4_bit==1)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0))
	BTFSS      RD4_bit+0, 4
	GOTO       L_main12
	BTFSC      RD5_bit+0, 5
	GOTO       L_main12
	BTFSC      RD6_bit+0, 6
	GOTO       L_main12
	BTFSC      RD7_bit+0, 7
	GOTO       L_main12
L__main33:
;pwmsample.c,44 :: 		speed(0.30,0.90);
	MOVLW      154
	MOVWF      FARG_speed_pwm1+0
	MOVLW      153
	MOVWF      FARG_speed_pwm1+1
	MOVLW      25
	MOVWF      FARG_speed_pwm1+2
	MOVLW      125
	MOVWF      FARG_speed_pwm1+3
	MOVLW      102
	MOVWF      FARG_speed_pwm2+0
	MOVLW      102
	MOVWF      FARG_speed_pwm2+1
	MOVLW      102
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,45 :: 		flag = 1;
	MOVLW      1
	MOVWF      main_flag_L0+0
	MOVLW      0
	MOVWF      main_flag_L0+1
;pwmsample.c,46 :: 		}
	GOTO       L_main13
L_main12:
;pwmsample.c,49 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==1))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main16
	BTFSC      RD5_bit+0, 5
	GOTO       L_main16
	BTFSC      RD6_bit+0, 6
	GOTO       L_main16
	BTFSC      RD7_bit+0, 7
	GOTO       L_main16
	MOVLW      0
	XORWF      main_flag_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVLW      1
	XORWF      main_flag_L0+0, 0
L__main39:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
L__main32:
;pwmsample.c,51 :: 		speed(0.20,0.95);
	MOVLW      205
	MOVWF      FARG_speed_pwm1+0
	MOVLW      204
	MOVWF      FARG_speed_pwm1+1
	MOVLW      76
	MOVWF      FARG_speed_pwm1+2
	MOVLW      124
	MOVWF      FARG_speed_pwm1+3
	MOVLW      51
	MOVWF      FARG_speed_pwm2+0
	MOVLW      51
	MOVWF      FARG_speed_pwm2+1
	MOVLW      115
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,52 :: 		flag = 0;
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;pwmsample.c,53 :: 		}
	GOTO       L_main17
L_main16:
;pwmsample.c,56 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==1)&&(RD7_bit==1))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main20
	BTFSC      RD5_bit+0, 5
	GOTO       L_main20
	BTFSS      RD6_bit+0, 6
	GOTO       L_main20
	BTFSS      RD7_bit+0, 7
	GOTO       L_main20
L__main31:
;pwmsample.c,58 :: 		speed(0.80,0.40);
	MOVLW      205
	MOVWF      FARG_speed_pwm1+0
	MOVLW      204
	MOVWF      FARG_speed_pwm1+1
	MOVLW      76
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      205
	MOVWF      FARG_speed_pwm2+0
	MOVLW      204
	MOVWF      FARG_speed_pwm2+1
	MOVLW      76
	MOVWF      FARG_speed_pwm2+2
	MOVLW      125
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,59 :: 		}
	GOTO       L_main21
L_main20:
;pwmsample.c,62 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==1))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main24
	BTFSC      RD5_bit+0, 5
	GOTO       L_main24
	BTFSC      RD6_bit+0, 6
	GOTO       L_main24
	BTFSS      RD7_bit+0, 7
	GOTO       L_main24
L__main30:
;pwmsample.c,64 :: 		speed(0.90,0.30);
	MOVLW      102
	MOVWF      FARG_speed_pwm1+0
	MOVLW      102
	MOVWF      FARG_speed_pwm1+1
	MOVLW      102
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      154
	MOVWF      FARG_speed_pwm2+0
	MOVLW      153
	MOVWF      FARG_speed_pwm2+1
	MOVLW      25
	MOVWF      FARG_speed_pwm2+2
	MOVLW      125
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,65 :: 		flag = 2;
	MOVLW      2
	MOVWF      main_flag_L0+0
	MOVLW      0
	MOVWF      main_flag_L0+1
;pwmsample.c,66 :: 		}
	GOTO       L_main25
L_main24:
;pwmsample.c,69 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==2))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main28
	BTFSC      RD5_bit+0, 5
	GOTO       L_main28
	BTFSC      RD6_bit+0, 6
	GOTO       L_main28
	BTFSC      RD7_bit+0, 7
	GOTO       L_main28
	MOVLW      0
	XORWF      main_flag_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
	MOVLW      2
	XORWF      main_flag_L0+0, 0
L__main40:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
L__main29:
;pwmsample.c,71 :: 		speed(0.95,0.20);
	MOVLW      51
	MOVWF      FARG_speed_pwm1+0
	MOVLW      51
	MOVWF      FARG_speed_pwm1+1
	MOVLW      115
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      205
	MOVWF      FARG_speed_pwm2+0
	MOVLW      204
	MOVWF      FARG_speed_pwm2+1
	MOVLW      76
	MOVWF      FARG_speed_pwm2+2
	MOVLW      124
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;pwmsample.c,72 :: 		flag = 0;
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;pwmsample.c,73 :: 		}
L_main28:
L_main25:
L_main21:
L_main17:
L_main13:
L_main9:
L_main5:
;pwmsample.c,75 :: 		}
	GOTO       L_main0
;pwmsample.c,76 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
