#line 1 "E:/OS Systems/Compressed/PWM/PWM/pwmsample.c"
void InitMain() {

 PORTA = 255;
 TRISA = 255;
 PORTD = 0x00;
 TRISD = 0xFF;
 PORTC = 0x00;
 TRISC = 0x00;
 PWM1_Init(1000);
 PWM2_Init(1000);
}

void speed(float pwm1 , float pwm2)
{
 PWM1_Set_Duty(pwm1*255);
 PWM2_Set_Duty(pwm2*255);
}
void main() {
 int flag = 0;
 InitMain();
 PWM1_Start();
 PWM2_Start();
 PWM1_Set_Duty(0);
 PWM2_Set_Duty(0);

 while (1)
 {


 if((RD4_bit==0)&&(RD5_bit==1)&&(RD6_bit==1)&&(RD7_bit==0))
 {
 speed(0.80,0.80);
 }


 else if((RD4_bit==1)&&(RD5_bit==1)&&(RD6_bit==0)&&(RD7_bit==0))
 {
 speed(0.40,0.80);
 }


 else if((RD4_bit==1)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0))
 {
 speed(0.30,0.90);
 flag = 1;
 }


 else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==1))
 {
 speed(0.20,0.95);
 flag = 0;
 }


 else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==1)&&(RD7_bit==1))
 {
 speed(0.80,0.40);
 }


 else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==1))
 {
 speed(0.90,0.30);
 flag = 2;
 }


 else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==2))
 {
 speed(0.95,0.20);
 flag = 0;
 }

 }
}
