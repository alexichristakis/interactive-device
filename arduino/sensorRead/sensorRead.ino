int switch1Pin = 23;
int switch2Pin = 21;
int switch3Pin = 19;

int button1Pin = 18;
int button2Pin = 5;
int button3Pin = 17;

int joystick1Y = 0;
int joystick1X = 4;
int joystick1Button = 14;

int joystick2Y = 32;
int joystick2X = 33;
int joystick2Button = 13;

int joystick3Y = 25;
int joystick3X = 26;
int joystick3Button = 12;

void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  pinMode(switch1Pin, INPUT);
  pinMode(switch2Pin, INPUT);
  pinMode(switch3Pin, INPUT);
  pinMode(button1Pin, INPUT);
  pinMode(button2Pin, INPUT);
  pinMode(button3Pin, INPUT);

  pinMode(joystick1X, INPUT);
  pinMode(joystick1Y, INPUT);

  pinMode(joystick1Button, INPUT_PULLUP);
  pinMode(joystick2Button, INPUT_PULLUP);
  pinMode(joystick3Button, INPUT_PULLUP);

}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  int joystick1XValue = analogRead(joystick1X);
  int joystick1YValue = analogRead(joystick1Y);
  int joystick2XValue = analogRead(joystick2X);
  int joystick2YValue = analogRead(joystick2Y);
  int joystick3XValue = analogRead(joystick3X);
  int joystick3YValue = analogRead(joystick3Y);

  
  int switch1Value = digitalRead(switch1Pin);
  int switch2Value = digitalRead(switch2Pin);
  int switch3Value = digitalRead(switch3Pin);
  int button1Value = digitalRead(button1Pin);
  int button2Value = digitalRead(button2Pin);
  int button3Value = digitalRead(button3Pin);

  int joystick1ButtonValue = digitalRead(joystick1Button);
  int joystick2ButtonValue = digitalRead(joystick2Button);
  int joystick3ButtonValue = digitalRead(joystick3Button);
  
  // print out the value you read:
  Serial.print(switch1Value);
  Serial.print(',');
  Serial.print(switch2Value);
  Serial.print(',');
  Serial.print(switch3Value);
  Serial.print(',');
  Serial.print(button1Value);
  Serial.print(',');
  Serial.print(button2Value);
  Serial.print(',');
  Serial.print(button3Value);
  Serial.print("//");
  Serial.print(joystick1XValue);
  Serial.print(",");
  Serial.print(joystick1YValue);
  Serial.print(",");
  Serial.print(joystick1ButtonValue);
  Serial.print("//");
  Serial.print(joystick2XValue);
  Serial.print(",");
  Serial.print(joystick2YValue);
  Serial.print(",");
  Serial.print(joystick2ButtonValue);
  Serial.print("//");
  Serial.print(joystick3XValue);
  Serial.print(",");
  Serial.print(joystick3YValue);
  Serial.print(",");
  Serial.println(joystick3ButtonValue);
//  Serial.print(",");
//  Serial.println(joystick3ButtonValue);

  delay(1);        // delay in between reads for stability
}
