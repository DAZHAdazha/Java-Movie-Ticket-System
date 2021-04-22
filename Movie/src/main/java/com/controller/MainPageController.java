package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Cinema;
import com.entity.Movie;
import com.entity.User;
import com.itextpdf.text.DocumentException;
import com.mapper.UserMapper;
import com.service.ICinemaService;
import com.service.IMovieService;
import com.service.IRecommendService;
import com.service.IUserService;
import com.service.imp.UserServiceImp;
import com.util.CheckCodeUtil;
import com.util.PDF;
import com.util.Recommend;
import com.util.Zedis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;

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
    @Resource
    private IUserService userService;
    @Resource
    private IRecommendService recommendService;
    @Autowired
    private Zedis zedis;

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
    public void recommend(@RequestParam("userId") long userId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = userService.findUserById(userId);
        JSONObject obj = new JSONObject();
        LinkedList<Movie> list = recommendService.returnMovies(user);

        obj.put("code", 0);
        obj.put("count", list.size());
        obj.put("data", list);
        request.setAttribute("searchObj",obj);
        request.getRequestDispatcher("../jsp/recommend.jsp").forward(request,response);
    }

    @RequestMapping("myRedis")
    @ResponseBody
    public String myRedis(@RequestParam("scheduleId") int scheduleId,@RequestParam("i") int i,@RequestParam("j") int j, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(i);
        System.out.println(j);
        System.out.println(scheduleId);

        //1.获取链接 默认6379端口
        Jedis jedis = new Jedis("localhost",6379);
        //2.操作
        String key = String.valueOf(scheduleId) + "-" +  String.valueOf(i) + "-" + String.valueOf(j);


        String seat = jedis.get(key);
        System.out.println(seat);

        if(seat!=null){
            jedis.close();
            if(seat.equals("userId")){
                // cancel seat
                jedis.del(key);
                return "cancel";
            }
            //seat had been taken
            return "no";
        } else {
            jedis.setex(key,120,"userId");
            jedis.close();
            //seat available
            return "yes";
        }

        //3.关闭链接

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

    @RequestMapping("myZedis")
    @ResponseBody
    public String myZedis(@RequestParam("scheduleId") int scheduleId,@RequestParam("i") int i,@RequestParam("j") int j, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(i);
        System.out.println(j);
        System.out.println(scheduleId);

        //1.连接
        zedis.connect();

        //2.操作
        String key = String.valueOf(scheduleId) + "-" +  String.valueOf(i) + "-" + String.valueOf(j);
        System.out.println(key);
        System.out.println(zedis.get(key));
        String seat = zedis.get(key);
        System.out.println("1");
        if(seat!=null){
            if(seat.equals("userId")){
                // cancel seat
                zedis.remove(key);
                zedis.close();
                return "cancel";
            }
            zedis.close();
            //seat had been taken
            return "no";
        } else {
            zedis.set(key,123);
            zedis.setTime(key,120);
            zedis.close();
            //seat available
            return "yes";
        }

        //3.关闭链接

    }

}
