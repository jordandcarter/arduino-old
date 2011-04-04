void setup() {
  // put your setup code here, to run once:
  Serial1.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly: 
  static boolean run = false;
  if(!run){
    run = true;
    clear_screen();
    set_back_light(70);
    Serial1.write(0x7C);
    Serial1.write(0x0F);
    Serial1.write(byte(10));
    Serial1.write(byte(10));
    Serial1.write(byte(20));
    Serial1.write(byte(20));
  }
}

void screen(byte command, byte values[], int array_size){
  Serial1.write("|");
  for(int i=0;i<array_size;i++){
    Serial1.write(values[i]);
  }
}

void screen(byte command, byte value){
  Serial1.write("|");
  Serial1.write(command);
  Serial1.write(value);
}

void screen(byte command){
  Serial1.write("|");
  Serial1.write(command);
}

void clear_screen(){
  screen(byte(0));
}

void set_back_light(int value){
  screen(0x02, value);
}

void set_x_y(int x, int y){
  screen(0x18, x);
  screen(0x19, y);
}

void text(String value){
  Serial1.print(value);
}

void reverse_mode(){
  screen(0x12);
}

void box(int x, int y, int x2, int y2){
  box(x, y, x2, y2, 0);
}

void box(int x, int y, int x2, int y2, boolean fill){
  byte data[] =  {byte(x), byte(y), byte(x2), byte(y2), byte(fill)};
  screen(0x0F, data, 5);
}
