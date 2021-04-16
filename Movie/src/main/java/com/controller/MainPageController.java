package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Cinema;
import com.entity.Movie;
import com.entity.User;
import com.itextpdf.text.DocumentException;
import com.service.ICinemaService;
import com.service.IMovieService;
import com.util.CheckCodeUtil;
import com.util.PDF;
import com.util.Recommend;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;
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
    public void searchAll(@RequestParam("searchKeyword") String searchKeyword,@RequestParam("searchType") String searchType, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (searchType.equals("movie")){
            JSONObject obj = new JSONObject();
            List<Movie> list = movieService.findMoviesLikeName(searchKeyword);
            obj.put("code", 0);
            obj.put("count", list.size());
            obj.put("data", list);
            request.setAttribute("searchObj",obj);
            request.getRequestDispatcher("../jsp/searchMovie.jsp").forward(request,response);
        } else  if(searchType.equals("theater")){
            JSONObject obj = new JSONObject();
            List<Cinema> cinemasLikeName = cinemaService.findCinemasLikeName(searchKeyword);obj.put("code", 0);
            obj.put("count", cinemasLikeName.size());
            obj.put("data", cinemasLikeName);
            request.setAttribute("searchObj",obj);
            request.getRequestDispatcher("../jsp/searchTheater.jsp").forward(request,response);
        } else {
            JSONObject obj = new JSONObject();
            List<Movie> moviesLikeActor = movieService.findMoviesLikeActor(searchKeyword);obj.put("code", 0);
            obj.put("count", moviesLikeActor.size());
            obj.put("data", moviesLikeActor);
            request.setAttribute("searchObj",obj);
            request.getRequestDispatcher("../jsp/searchMovie.jsp").forward(request,response);
        }
    }

    @RequestMapping("recommend")
    @ResponseBody
    public void recommend(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User)request.getSession().getAttribute("user");
        JSONObject obj = new JSONObject();
        LinkedList<Movie> list = Recommend.returnMovies(user);

        obj.put("code", 0);
        obj.put("count", list.size());
        obj.put("data", list);
        request.setAttribute("searchObj",obj);
        request.getRequestDispatcher("../jsp/recommend.jsp").forward(request,response);
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
        String orderID = request.getParameter("orderID");
        String moviePicture = request.getParameter("moviePicture");
        String movieName = request.getParameter("movieName");
        String theater = request.getParameter("theater");
        String seat = request.getParameter("seat");
        String startTime = request.getParameter("startTime");
        String price = request.getParameter("price");
        String path = request.getServletContext().getRealPath(moviePicture.replace("..",""));


        String contextPath = request.getServletContext().getRealPath("/upload/movies");

        PDF pdf = new PDF();
        pdf.generatePdf(time,orderID,path,movieName,theater,seat,startTime,price,contextPath);


        response.sendRedirect("../upload/movies/ticket.pdf");

    }

}
