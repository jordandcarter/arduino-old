 
int dirpin = 3;
int steppin = 12;
const long low_vel_limit = 39; //Base microseconds between steps, max speed
const long high_vel_limit = 100000; //microseconds above low_vel_limit, min speed

const float wheel_cm = 28.2743339;//mm around 90mm wheel

void setup() {
Serial.begin(9600);

pinMode(dirpin, OUTPUT);
pinMode(steppin, OUTPUT);
}
void loop()
{
  static boolean run = false;
  if(!run){
    run = true;
    int st = 350;
    int i = 0;
    for(; i < 500; i+=2){
      step_motor(true, 200, st-i);
    }
    step_motor(true, 10000, st-i);
    for(; i > 0; i-=2){
      step_motor(true, 200, st-i);
    }
  }
}

//distance in cm
//duration in milliseconds
void move(boolean dir, float distance, long duration){
  //Based on a 90mm wheel
  float ideal_steps = (distance/wheel_cm) * 800.0;//800 steps for a full rotation
  float ideal_vel = (duration / ideal_steps) * 1000.0;//convert to microseconds
  long vel = (long) constrain(ideal_vel, low_vel_limit, high_vel_limit);
  long steps = (long) ((duration * 1000.0) / vel);
  step_motor(dir, (long) ideal_steps, (long) ideal_vel);
  long error = (long) ideal_steps - steps;
}

//vel is a number 0 < vel < 1024
float step_motor(boolean dir, long steps, long vel){
  static boolean moving = false;
  vel = constrain(vel, low_vel_limit, high_vel_limit);
  if (dir){
    digitalWrite(dirpin, HIGH);     // Set the direction.
  } else {
    digitalWrite(dirpin, LOW);     // Set the direction.
  }
  
  if(!moving){
  int waits[] = {1000, 950, 900, 850, 800, 750, 600, 400, 350, 300};
  for(int i=0; i<10; i++){
    digitalWrite(steppin, LOW);
    digitalWrite(steppin, HIGH);
    delayMicroseconds(waits[i]);
  }
  }
  moving = true;
  
  if(vel < 5000){// Cut off between using microseconds and milliseconds
    for(long i=steps; i>0; i--){
      digitalWrite(steppin, LOW);
      digitalWrite(steppin, HIGH);
      delayMicroseconds(vel);
    }
  } else {
    vel = vel / 1000;
    for(long i=steps; i>0; i--){
      digitalWrite(steppin, LOW);
      digitalWrite(steppin, HIGH);
      delay(vel);
    }
  }
}

void print(String label, String value){
  Serial.print(label);
  Serial.print(": ");
  Serial.print(value);
  Serial.println();
}
