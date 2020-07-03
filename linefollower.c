void InitMain() {

  PORTA = 255;
  TRISA = 255;                        // configure PORTA pins as input
  PORTD = 0x00;                          // set PORTB to 0
  TRISD = 0xFF;                          // designate PORTD pins as output
  PORTC = 0x00;                          // set PORTC to 0
  TRISC = 0x00;                          // designate PORTC pins as output

  //most motors work on 1khz so I have used the same frequency
  PWM1_Init(1000);                    // Initialize PWM1 module at 1KHz
  PWM2_Init(1000);                    // Initialize PWM2 module at 1KHz
}


//speed
//both pwms speed ranges from 0.00 to 0.99
void speed(float pwm1 , float pwm2)
{
  PWM1_Set_Duty(pwm1*255);
  PWM2_Set_Duty(pwm2*255);
}





void main() {

  int flag = 0;                       //for memory
  InitMain();
  PWM1_Start();                       // start PWM1
  PWM2_Start();                       // start PWM2
  PWM1_Set_Duty(0);        // Set current duty for PWM1
  PWM2_Set_Duty(0);       // Set current duty for PWM2
  RC3_bit = 0;            //I1
  RC4_bit = 0;            //I2

  RC6_bit = 0;            //I3
  RC7_bit = 0;            //I4

  // C3 C4
  // 0  0   stop
  // 1  0   forward
  // 0  1   reverse
  // 1  1   stop
  
  // C6 C7
  // 0  0   stop
  // 1  0   forward
  // 0  1   reverse
  // 1  1   stop

  /*
  while(1)
  {
    RC3_bit = 1;
    RC4_bit = 0;

    RC6_bit = 1;
    RC7_bit = 0;
    speed(0.80,0.80);

  }
  */
  while (1) 
  {
  
  //forward
  if((RD4_bit==0)&&(RD5_bit==1)&&(RD6_bit==1)&&(RD7_bit==0))
   {
    RC3_bit = 1;
    RC4_bit = 0;
    
    RC6_bit = 1;
    RC7_bit = 0;
    speed(0.80,0.80);
    
   }
   
  //move L1 slight left
  else if((RD4_bit==1)&&(RD5_bit==1)&&(RD6_bit==0)&&(RD7_bit==0))
   {
    RC3_bit = 0;
    RC4_bit = 1;

    RC6_bit = 1;
    RC7_bit = 0;

    speed(0.50,0.80);
   }
   
  //move L2 hard left
  else if((RD4_bit==1)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0))
   {
    RC3_bit = 0;
    RC4_bit = 1;

    RC6_bit = 1;
    RC7_bit = 0;

    speed(0.60,0.90);
    //saving the last position using flag var	
    flag = 1;
   }
   
  //move L3 very hard left
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==1))
   {
    // checking for flag = 1 indicates that the last robot's position was *when only one sensor was on line
    // and it goes further right so you have to give pwm which makes robot go left with faster momentum
    RC3_bit = 0;
    RC4_bit = 1;

    RC6_bit = 1;
    RC7_bit = 0;

    speed(0.70,0.95);
    flag = 0;
   }
   
  //move L1 slight right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==1)&&(RD7_bit==1))
   {
    RC3_bit = 1;
    RC4_bit = 0;

    RC6_bit = 0;
    RC7_bit = 1;

    speed(0.80,0.50);
   }
   
  //move L2 hard right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==1))
   {
    RC3_bit = 1;
    RC4_bit = 0;

    RC6_bit = 0;
    RC7_bit = 1;

    speed(0.90,0.60);
   //saving the last position using flag var
    flag = 2;
   }
   
  //move L3 very hard right
  else if((RD4_bit==0)&&(RD5_bit==0)&&(RD6_bit==0)&&(RD7_bit==0)&&(flag==2))
   {
    // checking for flag = 2 indicates that the last robot's position was *when only one sensor was on line
    // and it goes further left so you have to give pwm which makes robot go right with faster momentum
    RC3_bit = 1;
    RC4_bit = 0;

    RC6_bit = 0;
    RC7_bit = 1;

    speed(0.95,0.70);

    //resetting the flag
    flag = 0;
   }

  }
}