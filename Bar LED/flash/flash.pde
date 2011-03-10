const int A_0 = 0;
const int A_3 = 128;
const int A_5 = 200;

long previousMillis = 0;        // will store last time LED was updated
long interval = 250;           // interval at which to blink (milliseconds)
boolean leds_dirty = true;      // does the leds need to be updated?

void setup() {
  //Set pinMode to OUTPUT for pins 2..12
  for (int i=1; i <= 12; i++){
    pinMode(i+1, OUTPUT);
  }
}

boolean seq[] = {false, false, true, false, true, false, true, false, false, false, false, false};

void loop() {
  unsigned long currentMillis = millis();
  if(leds_dirty) {
    update_leds();
  }
  
  if(currentMillis - previousMillis > interval) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;
    
    // Setup a simple sequence
    set_led(1, seq[0]);
    set_led(2, seq[1]);
    set_led(3, seq[2]);
    set_led(4, seq[3]);
    set_led(5, seq[4]);
    set_led(6, seq[5]);
    set_led(7, seq[6]);
    set_led(8, seq[7]);
    set_led(9, seq[8]);
    set_led(10, seq[9]);
    set_led(11, seq[10]);
    set_led(12, seq[11]);
    
    boolean temp = seq[0];
    seq[0] = seq[1];
    seq[1] = seq[2];
    seq[2] = seq[3];
    seq[3] = seq[4];
    seq[4] = seq[5];
    seq[5] = seq[6];
    seq[6] = seq[7];
    seq[7] = seq[8];
    seq[8] = seq[9];
    seq[9] = seq[10];
    seq[10] = seq[11];
    seq[11] = temp;
  }
  
}

// Setup the leds as all off
boolean leds[] = {false, false, false, false, false, false, false, false, false, false, false, false};

void set_led(int number, boolean val) {
  if(number_within_limit(number)) {
    leds[number-1] = val;
    leds_dirty = true;
  }
}

boolean get_led(int number) {
  if(number_within_limit(number)) {
    return leds[number-1];
  } else {
    return false;
  }
}

// Toggle led at position number
void toggle_led(int number) {
  if(number_within_limit(number)) {
    set_led(number, !get_led(number));
  }
}

// Ensure the led position is correct
boolean number_within_limit(int number) {
  return number >= 1 && number <= 12;
}

// Write out to LEDS appropreate values
void update_leds() {
  //Simple case of 1,4,9 where LED is not connected to others in series, Who the fuck built this bar led??
  if(get_led(1)){
    analogWrite(2, A_3); //2 = LED 1
  } else {
    analogWrite(2, A_0);
  }
  if(get_led(4)){
    analogWrite(5, A_3); //5 = LED 4
  } else {
    analogWrite(5, A_0);
  }
  if(get_led(9)){
    analogWrite(10, A_3); //10 = LED 9
  } else {
    analogWrite(10, A_0);
  }
  
  //Not enough analog pins so putting this on a digital pin with a 
  if(get_led(12)){
    analogWrite(13, A_3);
  } else {
    analogWrite(13, A_0);
  }
  
  //Complex case where led is connected in series
  if(get_led(2)) {
    if(get_led(3)){
      analogWrite(3, A_5); //3 = LED 2
      analogWrite(4, A_3); //4 = LED 3
    } else {
      analogWrite(3, A_3); //3 = LED 2
      analogWrite(4, A_0); //4 = LED 3
    }
  } else {
    if(get_led(3)){
      analogWrite(3, A_0); //3 = LED 2
      analogWrite(4, A_3); //4 = LED 3
    } else {
      analogWrite(3, A_0); //3 = LED 2
      analogWrite(4, A_0); //4 = LED 3
    }
  }
  
  if(get_led(5)) {
    if(get_led(6)){
      analogWrite(6, A_5); //6 = LED 5
      analogWrite(7, A_3); //4 = LED 6
    } else {
      analogWrite(6, A_3); //6 = LED 5
      analogWrite(7, A_0); //7 = LED 6
    }
  } else {
    if(get_led(6)){
      analogWrite(6, A_0); //6 = LED 5
      analogWrite(7, A_3); //7 = LED 6
    } else {
      analogWrite(6, A_0); //6 = LED 5
      analogWrite(7, A_0); //7 = LED 6
    }
  }
  
  if(get_led(7)) {
    if(get_led(8)){
      analogWrite(8, A_5); //8 = LED 7
      analogWrite(9, A_3); //9 = LED 8
    } else {
      analogWrite(8, A_3); //8 = LED 7
      analogWrite(9, A_0); //9 = LED 8
    }
  } else {
    if(get_led(8)){
      analogWrite(8, A_0); //8 = LED 7
      analogWrite(9, A_3); //9 = LED 8
    } else {
      analogWrite(8, A_0); //8 = LED 7
      analogWrite(9, A_0); //9 = LED 8
    }
  }
  
  if(get_led(10)) {
    if(get_led(11)){
      analogWrite(11, A_5); //11 = LED 10
      analogWrite(12, A_3); //12 = LED 11
    } else {
      analogWrite(11, A_3); //11 = LED 10
      analogWrite(12, A_0); //12 = LED 11
    }
  } else {
    if(get_led(11)){
      analogWrite(11, A_0); //11 = LED 10
      analogWrite(12, A_3); //12 = LED 11
    } else {
      analogWrite(11, A_0); //11 = LED 10
      analogWrite(12, A_0); //12 = LED 11
    }
  }
  
  
  //Clear the dirty bit
  leds_dirty = false;
}
