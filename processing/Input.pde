class Input {
    int initializeCounter = 0;
    float restingX, restingY;
    float joyX, joyY;
    boolean joyPressed, buttonPressed;

    Input() {
        this.restingX = 2600;
        this.restingY = 2600;
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
            this.joyX = map(joyX, restingX, 4095, width / 2, 2*width);
        } else {
            this.joyX = map(joyX, 0, restingX, -width, width / 2);
        }

        if (joyY >= restingY) {
            this.joyY = map(joyY, restingY, 4095, height / 2, 2*height);
        } else {
            this.joyY = map(joyY, 0, restingY, -height, height / 2);
        }

        println(joyX + " " + joyY);

        this.joyPressed = joyPressed;
        this.buttonPressed = buttonPressed;
    }

}