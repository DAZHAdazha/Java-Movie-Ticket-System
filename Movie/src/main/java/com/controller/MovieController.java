package com.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.entity.Cinema;
import com.entity.Movie;
import com.service.ICinemaService;
import com.service.IMovieService;
import com.util.UUIDUtil;

/**
 * 电影管理模块
 */
@Controller
@RequestMapping("/movie")
public class MovieController {
	@Resource
	private IMovieService movieService;
	@Resource
	private ICinemaService cinemaService;
	//1.电影详情页 findid
	//2.首页电影列表 + name搜索 + type搜素 + 时间、参评人数、评分排序 
	//3.增加、删除、修改
	@RequestMapping("findMovieById")
	@ResponseBody
	public JSONObject findMovieById(@RequestParam("movie_id")long movie_id) {
		JSONObject obj = new JSONObject();
		Movie movie = movieService.findMovieById(movie_id);
		List<Cinema> list = this.cinemaService.findCinemasByMovieId(movie_id);
		obj.put("code", 0);
		obj.put("data", movie);
		obj.put("cinemaList",list);
		obj.put("cinemaCount",list.size());
		return obj;
	}
	
	@RequestMapping("findAllMovies")
	@ResponseBody
	public JSONObject findAllMovies() {
		JSONObject obj = new JSONObject();
		List<Movie> list = movieService.findAllMovies(1);
		List<Movie> upcomingList = movieService.findAllMovies(0);
		List<Movie> offList = movieService.sortMovieByBoxOffice();
		String type[] = {"喜剧","动作","爱情","动画","科幻","惊悚","冒险","犯罪","悬疑"};
		ArrayList<Object> typeArr = new ArrayList<Object>();
		for(int i = 0;i < type.length;i++) {
			List<Movie> movieList = this.movieService.findMoviesLikeType(type[i]);
			float boxOffice = 0;
			for(int j = 0; j < movieList.size();j++) {
				boxOffice += movieList.get(j).getMovie_boxOffice();
			}
			JSONObject typeJson = new JSONObject();
			typeJson.put(type[i], boxOffice);
			typeArr.add(typeJson);
		}
		obj.put("code", 0);
		obj.put("count", list.size());
		obj.put("upcomingCount",upcomingList.size());
		obj.put("data", list);
		obj.put("data1", upcomingList);
		obj.put("sort", offList);
		obj.put("type", typeArr);
		return obj;
	}
	
//	@RequestMapping("findMoviesByName")
//	@ResponseBody
//	public JSONObject findMoviesByName(@RequestParam("searchMovie") String searchMovie) {
//		JSONObject obj = new JSONObject();
//		List<Movie> list = movieService.findMoviesLikeName(searchMovie);
//		obj.put("code", 0);
//		obj.put("count", list.size());
//		obj.put("data", list);
//		return obj;
//	}
	
//	@RequestMapping("findMoviesByType")
//	@ResponseBody
//	public JSONObject findMoviesByType(@RequestParam("type") String type) {
//		JSONObject obj = new JSONObject();
//		List<Movie> list = movieService.findMoviesLikeType(type);
//		obj.put("code", 0);
//		obj.put("count", list.size());
//		obj.put("data", list);
//		return obj;
//	}

	@RequestMapping("findMoviesByTAY")
	@ResponseBody
	public JSONObject findMoviesByTAY(@RequestParam("type") String type,@RequestParam("area") String area,@RequestParam("year") String year) {
		JSONObject obj = new JSONObject();
		List<Movie> list = movieService.findMoviesLikeTAY(type,area,year);
		obj.put("code", 0);
		obj.put("count", list.size());
		obj.put("data", list);
		return obj;
	}
	
	@RequestMapping("sortAllMovies")
	@ResponseBody
	public JSONObject sortAllMovies(@RequestParam("order") String order) {
		JSONObject obj = new JSONObject();
		List<Movie> list = new ArrayList<Movie>();
		switch (order) {
			case "热门":
				list = movieService.sortMovieByCount();
				break;
			case "时间":
				list = movieService.sortMovieByDate();
				break;
			case "评价":
				list = movieService.sortMovieByScore();
				break;
		}
		obj.put("code",0);
		obj.put("count", list.size());
		obj.put("data", list);
		return obj;
	}
	
	@RequestMapping("deleteMovie")
	@ResponseBody
	public JSONObject deleteMovie(@RequestParam("movie_id") long movie_id) {
		JSONObject obj = new JSONObject();
		Integer rs = movieService.deleteMovie(movie_id);
		if(rs > 0) {
			obj.put("code",0);
//			obj.put("msg","下架成功~");
			obj.put("msg","Delete Movie successfully");
		}else {
			obj.put("code", 200);
//			obj.put("msg", "下架失败~");
			obj.put("msg", "Deleted Movie failed");
		}
		return obj;
	}
	
	@RequestMapping("addMovie")
	@ResponseBody
	public JSONObject addMovie(@RequestParam(value="file",required=false) MultipartFile file,Movie movie,HttpServletRequest request) throws IOException  {
		String str = file.getOriginalFilename();
//		System.out.println("file:" + str);
		String name = UUIDUtil.getUUID() + str.substring(str.lastIndexOf("."));
//		System.out.println("name:" + name);
		String path = request.getServletContext().getRealPath("/upload/movies") + "/" + name;
//		System.out.println("path:" + path);
		String filePath = "../upload/movies/" + name;
		movie.setMovie_picture(filePath);
		Date date = new Date();
		java.sql.Date releaseDate = new java.sql.Date(date.getYear(), date.getMonth(), date.getDay());
		//SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
		float random = 5 + (new Random().nextFloat() * 4);
		DecimalFormat fnum = new DecimalFormat("##0.0");  
		String score = fnum.format(random);
		movie.setMovie_score(Float.parseFloat(score));
		movie.setReleaseDate(releaseDate);
		Integer rs = movieService.addMovie(movie);
		JSONObject obj = new JSONObject();
		if(rs > 0) {
			file.transferTo(new File(path));
//			System.out.println("文件写入成功,Path:" + path);
			obj.put("code", 0);
//			obj.put("msg", "添加成功~");
			obj.put("msg", "Add file successfully");
		}else {
			obj.put("code", 200);
//			obj.put("msg", "添加失败~");
			obj.put("msg", "Add file failed");
		}
		return obj;
	}
	
	@RequestMapping("updateMovie")
	@ResponseBody
	public JSONObject updateMovie(@RequestParam(value="file",required=false)MultipartFile file,Movie movie,HttpServletRequest request) throws IOException{
		JSONObject obj = new JSONObject();
		if(file != null) {
			String str = file.getOriginalFilename();
//			System.out.println("file:" + str);
			String name = UUIDUtil.getUUID() + str.substring(str.lastIndexOf("."));
//			System.out.println("name:" + name);
			String path = request.getServletContext().getRealPath("/upload/movies") + "/" + name;
//			System.out.println("path:" + path);
			String filePath = "../upload/movies/" + name;
			file.transferTo(new File(path));
//			System.out.println("文件写入成功,Path:" + path);
			movie.setMovie_picture(filePath);
		}else {
			Movie oldMovie = this.movieService.findMovieById(movie.getMovie_id());
			movie.setMovie_picture(oldMovie.getMovie_picture());
		}
		Integer rs = movieService.updateMovie(movie);
		if(rs > 0) {
			obj.put("code", 0);
//			obj.put("msg", "修改成功~");
			obj.put("msg", "Modified successfully");
		}else {
			obj.put("code", 200);
//			obj.put("msg", "修改失败~");
			obj.put("msg", "Modified failed");
		}
		return obj;
	}
	@RequestMapping("findMovieByDB")
	@ResponseBody
	public JSONObject findMovieByDB(@RequestParam("movie_id") int movie_id,@RequestParam("date") int date,@RequestParam("brand") int brand) {
		String[] dateStr = {"今天","明天","后天","大后天"};
		String[] brandStr = {"全部","万达影城（蜀都万达广场店）",
		"太平洋影城（时代豪廷店）",
		"太平洋影城（龙城国际店）",
		"横店电影城（郫县店）",
		"SFC上影影城（成都龙湖IMAX店）",
		"越界影城（郫县店）",
		"中影星美国际影城（犀浦百伦店）",
		"C+影城（双铁广场RealD店）",
		"CGV影城（犀浦IMAX店）",
		"EVO艺威影院（龙湖时代天街店）",
		"中影文星影城（郫都店）",
		"嘉裕国际影城（郫县店）",
		"团结九州星辰电影城（传媒店）",
		"天智国际影城（红光店）",
		"太平洋院线影城（安靖店）",
		"德源菁创影城",
		"星光影城（美乐广场店）",
		"水乡记忆电影院"};

		JSONObject obj = new JSONObject();
		Movie movie = this.movieService.findMovieById(movie_id);
		System.out.println(movie.getMovie_id());
		System.out.println("-----------------");
		List<Cinema> list = this.cinemaService.findCinemasLikeNameAndMovie(brandStr[brand],movie_id);
		System.out.println(list);
		obj.put("code", 0);
		obj.put("data", movie);
		obj.put("cinemaList",list);
		obj.put("cinemaCount",list.size());
		System.out.println(obj);
		return obj;
	}
}