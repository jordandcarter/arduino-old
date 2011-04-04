// Released under Creative Commons License 

// Sparkfun Razor 6DOF and Arduino - basic read of gyroscope and acceleromete data

// This is "Helo World" of acquiring sensor data from 6 DOF Razor board

//

// Gyro, from the amplified outputs, and accelerometer data are read and diplayed

// Power is obtained from 3V3, not 5V

// 3.3V is also connected to AREF pin, as we want to scale ADC data

// Pinout connection is at

// http://voidbot.net/razor-6dof.html

//

// - by automatik

//------------------------------------------------------------------



int val = 0;                    //value of individual accelerometer or gyroscope sensor

unsigned long timer=0;          //timer

unsigned long  delta_t;         //delta time or how long it takes to execute data acquisition 



void setup()
{
  delay (2000); //dealy just in case - to get things stabilized if need be....
  analogReference(EXTERNAL);     //using external analog ref of 3.3V for ADC scaling
  Serial.begin(115200);          //setup serial
  Serial.println("t[ms] \t gy \t gx \t gz \t az \t ay \t ax "); //print data header
 timer=millis(); 
}



void loop()
{
  Serial.print((String) analogRead(10));      //print data
  Serial.print (",");
  Serial.print((String) analogRead(11));      //print data
  Serial.print (",");
  Serial.print((String) analogRead(12));      //print data
  Serial.print (",");
  Serial.print((String) analogRead(13));      //print data
  Serial.print (",");
  Serial.print((String) analogRead(14));      //print data
  Serial.print (",");
  Serial.print((String) analogRead(15));      //print data
  Serial.println("");
  delay(16);             //loop delay; loop executed at ~ 50Hz or 20ms
}
