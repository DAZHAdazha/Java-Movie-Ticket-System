package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Cinema;
import com.entity.Movie;
import com.itextpdf.text.DocumentException;
import com.service.ICinemaService;
import com.service.IMovieService;
import com.util.CheckCodeUtil;
import com.util.PDF;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/search")
public class MainPageController {
    @Resource
    private IMovieService movieService;
    @Resource
    private ICinemaService cinemaService;

    @RequestMapping("all")
    @ResponseBody
    public JSONObject searchAll(@RequestParam("searchKeyword") String searchKeyword,@RequestParam("searchType") String searchType) {
//        System.out.println(searchType);
        if (searchType.equals("movie")){
            JSONObject obj = new JSONObject();
            List<Movie> list = movieService.findMoviesLikeName(searchKeyword);
            obj.put("code", 0);
            obj.put("count", list.size());
            obj.put("data", list);
            return obj;
        } else  if(searchType.equals("theater")){
            JSONObject obj = new JSONObject();
            List<Cinema> cinemasLikeName = cinemaService.findCinemasLikeName(searchKeyword);obj.put("code", 0);
            obj.put("count", cinemasLikeName.size());
            obj.put("data", cinemasLikeName);
            return obj;
        } else {
            JSONObject obj = new JSONObject();
            List<Movie> moviesLikeActor = movieService.findMoviesLikeActor(searchKeyword);obj.put("code", 0);
            obj.put("count", moviesLikeActor.size());
            obj.put("data", moviesLikeActor);
            return obj;
        }
    }

    @RequestMapping("checkCode")
    @ResponseBody
    public void checkCode(HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        String verifyCode = CheckCodeUtil.generateVerifyCode(4);
        HttpSession session = request.getSession(true);
        session.setAttribute("verifyCode",verifyCode);
        CheckCodeUtil.outputImage(130, 40, response.getOutputStream(), verifyCode);
    }

    @RequestMapping("pdf")
    @ResponseBody
    public void pdf(HttpServletResponse response, HttpServletRequest request) throws IOException, DocumentException {
        String time = request.getParameter("time");
        System.out.println(time);
        String orderID = request.getParameter("orderID");
        System.out.println(orderID);
        String moviePicture = request.getParameter("moviePicture");
        System.out.println(moviePicture);
        String movieName = request.getParameter("movieName");
        System.out.println(movieName);
        String theater = request.getParameter("theater");
        System.out.println(theater);
        String seat = request.getParameter("seat");
        System.out.println(seat);
        String startTime = request.getParameter("startTime");
        System.out.println(startTime);
        String price = request.getParameter("price");
        System.out.println(price);
        String path = request.getServletContext().getRealPath(moviePicture.replace("..",""));
        System.out.println(path);

        String contextPath = request.getServletContext().getRealPath("/upload/movies");

        PDF pdf = new PDF();
        pdf.generatePdf(time,orderID,path,movieName,theater,seat,startTime,price,contextPath);


        response.sendRedirect("../upload/movies/ticket.pdf");

    }

}
