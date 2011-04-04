// Graphing sketch
 
 
 // This program takes ASCII-encoded strings
 // from the serial port at 9600 baud and graphs them. It expects values in the
 // range 0 to 1023, followed by a newline, or newline and carriage return
 
 // Created 20 Apr 2005
 // Updated 18 Jan 2008
 // by Tom Igoe
 // This example code is in the public domain.
 
 import processing.serial.*;
 
 Serial myPort;        // The serial port
 int[] readings = {25, 10, 25, 40, 50, 75};
 int[] mins = {100,100,100,100,100,100};
 int[] maxs = {100,100,100,100,100,100};
 
 
 void setup () {
 // set the window size:
  size(800, 600);        
 
 // List all the available serial ports
  println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 115200);
 // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
 // set inital background:
  background(0);
}
 void draw () {  background(0);
  background(0);
  draw_graph();
 }
 
 void draw_graph(){
   for(int i = 0; i < readings.length; i++){
     draw_bar(i);
   }
 }
 
 void draw_bar(int i){
   int x = width / 6*i;
   int y = -10;
   int w = width / 7;
   int h = readings[i];
   fill(255);
   rect(x, height - h, w, h);
   fill(204, 102, 0);
   text("Max: "+maxs[i], x, 10);
   text("Min: "+mins[i], x, 20);
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
   if (inString != null) {
   // trim off any whitespace:
     inString = trim(inString);
     String strings[] = inString.split(",");
     for(int i = 0; i < strings.length; i++) {
       int reading = int(trim(strings[i]));
       readings[i] = reading;
       if (reading > maxs[i]){
         maxs[i] = reading;
       }
       if (reading < mins[i]){
         mins[i] = reading;
       }
     }
   }
 }
