package com.util;
import java.awt.Color;

public class MatrixToLogoImageConfig {
    //logo默认边框颜色
    public static final Color DEFAULT_BORDERCOLOR = Color.RED;
    //logo默认边框宽度
    public static final int DEFAULT_BORDER = 1;
    //logo大小默认为照片的1/5
    public static final int DEFAULT_LOGOPART = 5;

    private final int border = DEFAULT_BORDER;
    private final Color borderColor;
    private final int logoPart;
    public MatrixToLogoImageConfig() {
        this(DEFAULT_BORDERCOLOR, DEFAULT_LOGOPART);
    }
    public MatrixToLogoImageConfig(Color borderColor, int logoPart) {
        this.borderColor = borderColor;
        this.logoPart = logoPart;
    }
    public Color getBorderColor() {
        return borderColor;
    }
    public int getBorder() {
        return border;
    }
    public int getLogoPart() {
        return logoPart;
    }
}