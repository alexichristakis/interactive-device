class Input {
    int initializeCounter = 0;
    Point center;
    float restingX, restingY;
    float joyX, joyY;
    boolean joyPressed, buttonPressed;

    Input(Point center) {
        this.center = center;

        this.restingX = 2600;
        this.restingY = 2700;
        this.joyX = 0;
        this.joyY = 0;

        this.buttonPressed = false;
        this.joyPressed = false;
    }

    void initialize() {
        // wait 500ms to establish restingX & restingY
    }

    void update(int joyX, int joyY, boolean joyPressed, boolean buttonPressed) {
        if (joyX >= restingX) {
            this.joyX = map(joyX, restingX, 4095, this.center.x, this.center.x + 150);
        } else {
            this.joyX = map(joyX, 0, restingX, this.center.x - 150, this.center.x);
        }

        if (joyY >= restingY) {
            this.joyY = map(joyY, restingY, 4095, this.center.y, this.center.y + 150);
        } else {
            this.joyY = map(joyY, 0, restingY, this.center.y - 150, this.center.y);
        }

        println(this.joyX + " " + this.joyY);

        this.joyPressed = joyPressed;
        this.buttonPressed = buttonPressed;
    }

}