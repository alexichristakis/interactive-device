import processing.serial.*;

Serial myPort;  // The serial port
int NUM_SHAPES = 3;
int RES = 200;
Shape[] shapes;
Input[] userInputs;

boolean switch1 = false;
boolean switch2 = false;
boolean switch3 = false;

void setup() {
    // List all the available serial ports
    printArray(Serial.list());
    // Open the port you are using at the rate you want:
    myPort = new Serial(this, Serial.list()[3], 115200);


    size(1000, 1000);
    // fullScreen();
    strokeWeight(12);
    noFill();

    userInputs = new Input[NUM_SHAPES];
    shapes = new Shape[NUM_SHAPES];

    for (int i = 0; i < NUM_SHAPES; i++) {
        Point center = new Point(((i + 1) *width) / 4, height / 2.0);
        
        userInputs[i] = new Input(center);
        shapes[i] = new Shape(this, center, 100, RES, userInputs[i]);
    }
}

void parseInputs(String[] inputs) {
    switch1 = int(inputs[0]) > 0;
    switch2 = int(inputs[1]) > 0;
    switch3 = int(inputs[2]) > 0;

    int index = 0;
    for (int i = 3; i < inputs.length; i += 4) {
        userInputs[index++].update(
            int(inputs[i]), 
            int(inputs[i+1]), 
            int(inputs[i+2]) > 0, 
            int(inputs[i+3]) > 0
        );
    }
}

void draw() {
    background(0);

    while (myPort.available() > 0) {
        String inputString = myPort.readStringUntil('\n');
        if (inputString != null && inputString.length() > 1) {
            String[] inputs = inputString.split(",");
            // print(inputs.length);
            if (inputs.length == 15) parseInputs(inputs);
        }
    }
    
    for (Shape shape : shapes) {
        shape.display();
    }
}