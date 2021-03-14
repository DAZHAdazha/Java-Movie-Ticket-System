package com.util;

import java.awt.image.BufferedImage;

import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

public class QrcodeGenerator {

    public static BufferedImage encode(String content, int width, int height) {
        try {
            BitMatrix matrix = MatrixToImageWriterEx.createQRCode(content, width, height);
            BufferedImage image = MatrixToImageWriter.toBufferedImage(matrix);
            return image;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}