
_InitMain:

;linefollower.c,1 :: 		void InitMain() {
;linefollower.c,3 :: 		PORTA = 255;
	MOVLW      255
	MOVWF      PORTA+0
;linefollower.c,4 :: 		TRISA = 255;                        // configure PORTA pins as input
	MOVLW      255
	MOVWF      TRISA+0
;linefollower.c,5 :: 		PORTD = 0x00;                          // set PORTB to 0
	CLRF       PORTD+0
;linefollower.c,6 :: 		TRISD = 0xFF;                          // designate PORTD pins as output
	MOVLW      255
	MOVWF      TRISD+0
;linefollower.c,7 :: 		PORTC = 0x00;                          // set PORTC to 0
	CLRF       PORTC+0
;linefollower.c,8 :: 		TRISC = 0x00;                          // designate PORTC pins as output
	CLRF       TRISC+0
;linefollower.c,11 :: 		PWM1_Init(1000);                    // Initialize PWM1 module at 1KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;linefollower.c,12 :: 		PWM2_Init(1000);                    // Initialize PWM2 module at 1KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;linefollower.c,13 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_speed:

;linefollower.c,18 :: 		void speed(float pwm1 , float pwm2)
;linefollower.c,20 :: 		PWM1_Set_Duty(pwm1*255);
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
;linefollower.c,21 :: 		PWM2_Set_Duty(pwm2*255);
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
;linefollower.c,22 :: 		}
L_end_speed:
	RETURN
; end of _speed

_main:

;linefollower.c,28 :: 		void main() {
;linefollower.c,30 :: 		int flag = 0;                       //for memory
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;linefollower.c,31 :: 		InitMain();
	CALL       _InitMain+0
;linefollower.c,32 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;linefollower.c,33 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;linefollower.c,34 :: 		PWM1_Set_Duty(0);        // Set current duty for PWM1
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;linefollower.c,35 :: 		PWM2_Set_Duty(0);       // Set current duty for PWM2
	CLRF       FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;linefollower.c,36 :: 		RC3_bit = 0;            //I1
	BCF        RC3_bit+0, 3
;linefollower.c,37 :: 		RC4_bit = 0;            //I2
	BCF        RC4_bit+0, 4
;linefollower.c,39 :: 		RC6_bit = 0;            //I3
	BCF        RC6_bit+0, 6
;linefollower.c,40 :: 		RC7_bit = 0;            //I4
	BCF        RC7_bit+0, 7
;linefollower.c,66 :: 		while (1)
L_main0:
;linefollower.c,70 :: 		if((RD4_bit==0)&&(RD5_bit==1)&&(RD6_bit==1)&&(RD7_bit==0))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main4
	BTFSS      RD5_bit+0, 5
	GOTO       L_main4
	BTFSS      RD6_bit+0, 6
	GOTO       L_main4
	BTFSC      RD7_bit+0, 7
	GOTO       L_main4
L__main35:
;linefollower.c,72 :: 		RC3_bit = 1;
	BSF        RC3_bit+0, 3
;linefollower.c,73 :: 		RC4_bit = 0;
	BCF        RC4_bit+0, 4
;linefollower.c,75 :: 		RC6_bit = 1;
	BSF        RC6_bit+0, 6
;linefollower.c,76 :: 		RC7_bit = 0;
	BCF        RC7_bit+0, 7
;linefollower.c,77 :: 		speed(0.80,0.80);
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
;linefollower.c,79 :: 		}
	GOTO       L_main5
L_main4:
;linefollower.c,82 :: 		else if((RD4_bit==1)&&(RD5_bit==1)&&(RD6_bit==0)&&(RD7_bit==0))
	BTFSS      RD4_bit+0, 4
	GOTO       L_main8
	BTFSS      RD5_bit+0, 5
	GOTO       L_main8
	BTFSC      RD6_bit+0, 6
	GOTO       L_main8
	BTFSC      RD7_bit+0, 7
	GOTO       L_main8
L__main34:
;linefollower.c,84 :: 		RC3_bit = 0;
	BCF        RC3_bit+0, 3
;linefollower.c,85 :: 		RC4_bit = 1;
	BSF        RC4_bit+0, 4
;linefollower.c,87 :: 		RC6_bit = 1;
	BSF        RC6_bit+0, 6
;linefollower.c,88 :: 		RC7_bit = 0;
	BCF        RC7_bit+0, 7
;linefollower.c,90 :: 		speed(0.50,0.80);
	MOVLW      0
	MOVWF      FARG_speed_pwm1+0
	MOVLW      0
	MOVWF      FARG_speed_pwm1+1
	MOVLW      0
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
;linefollower.c,91 :: 		}
	GOTO       L_main9
L_main8:
;linefollower.c,94 :: 		else if((RD4_bit==1)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0))
	BTFSS      RD4_bit+0, 4
	GOTO       L_main12
	BTFSC      RD5_bit+0, 5
	GOTO       L_main12
	BTFSC      RD6_bit+0, 6
	GOTO       L_main12
	BTFSC      RD7_bit+0, 7
	GOTO       L_main12
L__main33:
;linefollower.c,96 :: 		RC3_bit = 0;
	BCF        RC3_bit+0, 3
;linefollower.c,97 :: 		RC4_bit = 1;
	BSF        RC4_bit+0, 4
;linefollower.c,99 :: 		RC6_bit = 1;
	BSF        RC6_bit+0, 6
;linefollower.c,100 :: 		RC7_bit = 0;
	BCF        RC7_bit+0, 7
;linefollower.c,102 :: 		speed(0.60,0.90);
	MOVLW      154
	MOVWF      FARG_speed_pwm1+0
	MOVLW      153
	MOVWF      FARG_speed_pwm1+1
	MOVLW      25
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
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
;linefollower.c,104 :: 		flag = 1;
	MOVLW      1
	MOVWF      main_flag_L0+0
	MOVLW      0
	MOVWF      main_flag_L0+1
;linefollower.c,105 :: 		}
	GOTO       L_main13
L_main12:
;linefollower.c,108 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==1))
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
;linefollower.c,112 :: 		RC3_bit = 0;
	BCF        RC3_bit+0, 3
;linefollower.c,113 :: 		RC4_bit = 1;
	BSF        RC4_bit+0, 4
;linefollower.c,115 :: 		RC6_bit = 1;
	BSF        RC6_bit+0, 6
;linefollower.c,116 :: 		RC7_bit = 0;
	BCF        RC7_bit+0, 7
;linefollower.c,118 :: 		speed(0.70,0.95);
	MOVLW      51
	MOVWF      FARG_speed_pwm1+0
	MOVLW      51
	MOVWF      FARG_speed_pwm1+1
	MOVLW      51
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
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
;linefollower.c,119 :: 		flag = 0;
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;linefollower.c,120 :: 		}
	GOTO       L_main17
L_main16:
;linefollower.c,123 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==1)&&(RD7_bit==1))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main20
	BTFSC      RD5_bit+0, 5
	GOTO       L_main20
	BTFSS      RD6_bit+0, 6
	GOTO       L_main20
	BTFSS      RD7_bit+0, 7
	GOTO       L_main20
L__main31:
;linefollower.c,125 :: 		RC3_bit = 1;
	BSF        RC3_bit+0, 3
;linefollower.c,126 :: 		RC4_bit = 0;
	BCF        RC4_bit+0, 4
;linefollower.c,128 :: 		RC6_bit = 0;
	BCF        RC6_bit+0, 6
;linefollower.c,129 :: 		RC7_bit = 1;
	BSF        RC7_bit+0, 7
;linefollower.c,131 :: 		speed(0.80,0.50);
	MOVLW      205
	MOVWF      FARG_speed_pwm1+0
	MOVLW      204
	MOVWF      FARG_speed_pwm1+1
	MOVLW      76
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      0
	MOVWF      FARG_speed_pwm2+0
	MOVLW      0
	MOVWF      FARG_speed_pwm2+1
	MOVLW      0
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;linefollower.c,132 :: 		}
	GOTO       L_main21
L_main20:
;linefollower.c,135 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==1))
	BTFSC      RD4_bit+0, 4
	GOTO       L_main24
	BTFSC      RD5_bit+0, 5
	GOTO       L_main24
	BTFSC      RD6_bit+0, 6
	GOTO       L_main24
	BTFSS      RD7_bit+0, 7
	GOTO       L_main24
L__main30:
;linefollower.c,137 :: 		RC3_bit = 1;
	BSF        RC3_bit+0, 3
;linefollower.c,138 :: 		RC4_bit = 0;
	BCF        RC4_bit+0, 4
;linefollower.c,140 :: 		RC6_bit = 0;
	BCF        RC6_bit+0, 6
;linefollower.c,141 :: 		RC7_bit = 1;
	BSF        RC7_bit+0, 7
;linefollower.c,143 :: 		speed(0.90,0.60);
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
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;linefollower.c,145 :: 		flag = 2;
	MOVLW      2
	MOVWF      main_flag_L0+0
	MOVLW      0
	MOVWF      main_flag_L0+1
;linefollower.c,146 :: 		}
	GOTO       L_main25
L_main24:
;linefollower.c,149 :: 		else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==2))
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
;linefollower.c,153 :: 		RC3_bit = 1;
	BSF        RC3_bit+0, 3
;linefollower.c,154 :: 		RC4_bit = 0;
	BCF        RC4_bit+0, 4
;linefollower.c,156 :: 		RC6_bit = 0;
	BCF        RC6_bit+0, 6
;linefollower.c,157 :: 		RC7_bit = 1;
	BSF        RC7_bit+0, 7
;linefollower.c,159 :: 		speed(0.95,0.70);
	MOVLW      51
	MOVWF      FARG_speed_pwm1+0
	MOVLW      51
	MOVWF      FARG_speed_pwm1+1
	MOVLW      115
	MOVWF      FARG_speed_pwm1+2
	MOVLW      126
	MOVWF      FARG_speed_pwm1+3
	MOVLW      51
	MOVWF      FARG_speed_pwm2+0
	MOVLW      51
	MOVWF      FARG_speed_pwm2+1
	MOVLW      51
	MOVWF      FARG_speed_pwm2+2
	MOVLW      126
	MOVWF      FARG_speed_pwm2+3
	CALL       _speed+0
;linefollower.c,162 :: 		flag = 0;
	CLRF       main_flag_L0+0
	CLRF       main_flag_L0+1
;linefollower.c,163 :: 		}
L_main28:
L_main25:
L_main21:
L_main17:
L_main13:
L_main9:
L_main5:
;linefollower.c,165 :: 		}
	GOTO       L_main0
;linefollower.c,166 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
