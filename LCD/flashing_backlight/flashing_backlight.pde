void setup() {
  // put your setup code here, to run once:
  Serial1.begin(115200);
  clear_screen();
}

void loop() {
    for(int i=0;i<=100;i+=2){
      set_back_light(i);
      delay(10);
    }
    for(int i=99;i>=0;i-=2){
      set_back_light(i);
      delay(10);
    }
    reverse_mode();
}
void screen(byte command, byte value, byte value2){
  Serial1.write("|");
  Serial1.write(command);
  Serial1.write(value);
  Serial1.write(value2);
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

void box(int x, int y){
  screen(0x0F, byte(x), byte(y));
}
