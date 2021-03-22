package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Cinema;
import com.entity.Movie;
import com.service.ICinemaService;
import com.service.IMovieService;
import com.util.CheckCodeUtil;
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
        System.out.println(searchType);
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

}
