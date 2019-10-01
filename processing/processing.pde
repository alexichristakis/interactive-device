int NUM_SHAPES = 3;
int RES = 200;
Shape[] shapes;
Input input;

void setup() {
    // size(1000, 1000);
    fullScreen();
    strokeWeight(12);
    noFill();

    input = new Input();
    
    shapes = new Shape[NUM_SHAPES];
    shapes[0] = new Shape(this, width / 2.0, height / 3.0, 100, RES, input);
    shapes[1] = new Shape(this, width / 3.0, 2.0 * height / 3.0, 100, RES, input);
    shapes[2] = new Shape(this, 2.0 * width / 3.0, 2.0 * height / 3.0, 100, RES, input);
}

void draw() {
    background(0);
    for (Shape shape : shapes) {
        shape.display();
    }
}

void mousePressed() {
    input.pressMouse();
}

void mouseReleased() {
    input.releaseMouse();
}