package com.util;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;


import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

public class PDF {

    public void generatePdf(String time, String orderID,String moviePicture, String movieName, String theater, String seat, String startTime, String price, String contextPath) throws IOException, DocumentException {

        // 1.新建document对象
        Document document = new Document();

        BaseFont baseFontChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
        Font fontChinese =  new  Font(baseFontChinese , 18 , Font.NORMAL);

        // 2.建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中。
        // 创建 PdfWriter 对象 第一个参数是对文档对象的引用，第二个参数是文件的实际名称，在该名称中还会给出其输出路径。
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(contextPath + "\\ticket.pdf"));

        // 3.打开文档
        document.open();

        // 4.添加一个内容段落

//        String time = "2021-03-22 14:43:12";
//        String orderID = "2021032200290904";
//        String movieName = "猫和老鼠";
//        String theater = "团结九州星辰电影城（传媒店）";
//        String seat = "1号厅 9排4座";
//        String startTime = "2019-07-23 23:00";
//        String price = "￥32";

        document.add(new Paragraph(time + "                     Order ID:" + orderID));


        //图片1
        Image image1 = Image.getInstance(moviePicture);
        //设置图片位置的x轴和y周
        image1.setAbsolutePosition(35f, 580f);
        //设置图片的宽度和高度
        image1.scaleAbsolute(150, 200);
        //将图片1添加到pdf文件中
        document.add(image1);

        document.add(new Paragraph("                                                         " +movieName, fontChinese));
        document.add(new Paragraph("                                                         " +theater, fontChinese));
        document.add(new Paragraph("                                                         " +seat, fontChinese));
        document.add(new Paragraph("                                                         " +startTime, fontChinese));
        document.add(new Paragraph("                                                         " +price, fontChinese));

        // 5.关闭文档
        document.close();
    }





}
