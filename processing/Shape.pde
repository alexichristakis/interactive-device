import processing.sound.*;

class Point {
    float x, y;
    Point(float x, float y) {
        this.x = x;
        this.y = y;
    }
}

class Shape {
    Input input;
    Point center;
    Point[] poly;
    SinOsc[] chord;
    float radius;
    int n;

    int root = 30;
    int[] major = { 4, 5, 6 };
    int[] minor = { 10, 12, 15 };

    Shape(PApplet parent, Point center, float radius, int n, Input input) {
        this.center = center;
        this.radius = radius;   
        this.n = n;
        this.input = input;

        this.poly = new Point[n + 1];
        for (int i = 0; i <= n; i++) {
            float x = center.x + 100*sin(map(i, 0, n-1, 0, TAU));
            float y = center.y + 100*cos(map(i, 0, n-1, 0, TAU));
            this.poly[i] = new Point(x, y);
        }

        this.chord = new SinOsc[3];
        for (int i = 0; i < 3; i++) {
            this.chord[i] = new SinOsc(parent);
            this.chord[i].freq(major[i] * root);
            this.chord[i].stop();
        }

    }

    float logMap(float value, float start1, float stop1, float start2, float stop2) {
        start2 = log(start2);
        stop2 = log(stop2);

        float outgoing = exp(start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1)));

        return outgoing;
    }

    void warpOsc() {
        float bias = 0;
        for (int i = 0; i < n; i++) {
            bias = max(bias, dist(this.input.joyX, this.input.joyY, poly[i].x, poly[i].y));
        }

        for (int i = 0; i < chord.length; i++) {
            chord[i].freq(map(bias, width, 0, major[i], minor[i]) * root);
        }
    }

    void drawPoly(int dx, int dy) {
        float g = 0;
        if (this.input.buttonPressed) g = random(-2, 2);
            
        beginShape();
        for (int i = 0; i < n; i++) {
            float bias = dist(this.input.joyX, this.input.joyY, poly[i].x, poly[i].y);
            vertex(
                poly[i].x + dx / logMap(bias, 
                                        (float) (this.center.x + width), 
                                        (float) (this.center.x - width), 
                                        (float) dx, 45.0
                                        ) + g, 
                poly[i].y + dy / logMap(bias, 
                                        (float) (this.center.y + height), 
                                        (float) (this.center.y - height), 
                                        (float) dy, 45.0
                                        ) + g
            );
        }
        endShape();

        warpOsc();
    }

    void display() {
        blendMode(ADD);
        stroke(255, 0, 0);
        drawPoly(1000, 1000);
        
        stroke(0, 255, 0);
        drawPoly(1200, 1500);
        
        stroke(0, 0, 255);
        drawPoly(2000, 1700);

        // print(this.input.buttonPressed);

        if (this.input.buttonPressed) {
            for (int i = 0; i < chord.length; i++) {
                chord[i].play();
                chord[i].amp(0.3);
            }
        } else {
            for (int i = 0; i < chord.length; i++) {
                // chord[i].amp(0.0);
                chord[i].stop();
            }
        }
    }
}