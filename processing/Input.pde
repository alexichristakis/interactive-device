class Input {
    boolean mousePressed;
    Input() {
        this.mousePressed = false;
    }

    void pressMouse() {
        this.mousePressed = true;
    }

    void releaseMouse() {
        this.mousePressed = false;
    }
}