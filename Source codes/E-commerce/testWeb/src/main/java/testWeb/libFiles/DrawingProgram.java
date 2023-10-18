package testWeb.libFiles;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;

public class DrawingProgram  {

    private int x, y;
    private ArrayList<Point> path;

    public DrawingProgram() {
        x = 100;
        y = 100;
        path = new ArrayList<>();
    }

    public void processInput(String input) {
        String[] lines = input.split("\n");
        for (String line : lines) {
            String[] parts = line.trim().split(" ");
            if (parts.length == 2) {
                String direction = parts[0];
                int distance = Integer.parseInt(parts[1]);

                switch (direction) {
                    case "L":
                        moveLeft(distance);
                        break;
                    case "R":
                        moveRight(distance);
                        break;
                    case "U":
                        moveUp(distance);
                        break;
                    case "D":
                        moveDown(distance);
                        break;
                }
            }
        }
    }


    private void moveLeft(int distance) {
        x -= distance;
        path.add(new Point(x, y));
    }

    private void moveRight(int distance) {
        x += distance;
        path.add(new Point(x, y));
    }

    private void moveUp(int distance) {
        y -= distance;
        path.add(new Point(x, y));
    }

    private void moveDown(int distance) {
        y += distance;
        path.add(new Point(x, y));
    }

    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        g.setColor(Color.BLACK);
        for (int i = 1; i < path.size(); i++) {
            Point p1 = path.get(i - 1);
            Point p2 = path.get(i);
            g.drawLine(p1.x, p1.y, p2.x, p2.y);
        }

        // 绘制起始位置的标记
        g.setColor(Color.RED);
        g.fillRect(path.get(0).x - 5, path.get(0).y - 5, 10, 10);

        // 绘制结束位置的标记
        g.setColor(Color.BLUE);
        g.fillRect(path.get(path.size() - 1).x - 5, path.get(path.size() - 1).y - 5, 10, 10);
    }

    public static void main(String[] args) {
        DrawingProgram drawingProgram = new DrawingProgram();
        drawingProgram.processInput("C:\\Users\\86157\\Desktop\\instructions.txt");

        // 创建 BufferedImage
        BufferedImage image = new BufferedImage(500, 500, BufferedImage.TYPE_INT_ARGB);
        Graphics g = image.getGraphics();
        drawingProgram.paintComponent(g);
}
