void InitMain() {

  PORTA = 255;
  TRISA = 255;                        // configure PORTA pins as input
  PORTD = 0x00;                          // set PORTB to 0
  TRISD = 0xFF;                          // designate PORTB pins as output
  PORTC = 0x00;                          // set PORTC to 0
  TRISC = 0x00;                          // designate PORTC pins as output
  PWM1_Init(1000);                    // Initialize PWM1 module at 5KHz
  PWM2_Init(1000);                    // Initialize PWM2 module at 5KHz
}

void speed(float pwm1 , float pwm2)
{
  PWM1_Set_Duty(pwm1*255);
  PWM2_Set_Duty(pwm2*255);
}
void main() {
  int flag = 0;
  InitMain();
  PWM1_Start();                       // start PWM1
  PWM2_Start();                       // start PWM2
  PWM1_Set_Duty(0);        // Set current duty for PWM1
  PWM2_Set_Duty(0);       // Set current duty for PWM2

  while (1) 
  {
  
  //forward
  if((RD4_bit==0)&&(RD5_bit==1)&&(RD6_bit==1)&&(RD7_bit==0))
   {
    speed(0.80,0.80);
   }
   
  //move L1 slight left
  else if((RD4_bit==1)&&(RD5_bit==1)&&(RD6_bit==0)&&(RD7_bit==0))
   {
    speed(0.40,0.80);
   }
   
  //move L2 hard left
  else if((RD4_bit==1)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0))
   {
    speed(0.30,0.90);
    flag = 1;
   }
   
  //move L3 very hard left
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==1))
   {
    speed(0.20,0.95);
    flag = 0;
   }
   
  //move L1 slight right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==1)&&(RD7_bit==1))
   {
    speed(0.80,0.40);
   }
   
  //move L2 hard right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==1))
   {
    speed(0.90,0.30);
    flag = 2;
   }
   
  //move L3 very hard right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==2))
   {
    speed(0.95,0.20);
    flag = 0;
   }

  }
}