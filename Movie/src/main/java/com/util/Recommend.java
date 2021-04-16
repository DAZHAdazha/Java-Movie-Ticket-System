package com.util;

import com.entity.Movie;
import com.entity.Order;
import com.entity.Schedule;
import com.entity.User;
import com.mapper.MovieMapper;
import com.mapper.OrderMapper;
import com.mapper.ScheduleMapper;
import com.mapper.UserMapper;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.*;


public class Recommend {
    private  UserMapper userMapper;
    private  MovieMapper movieMapper;
    private  OrderMapper orderMapper;
    private  ScheduleMapper scheduleMapper;


    public User getUser(){
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        userMapper = app.getBean(UserMapper.class);
        return userMapper.findUserById(6);
    }

    public List<Movie> getMovieList(){
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        movieMapper = app.getBean(MovieMapper.class);
        return movieMapper.findAllMovies(1);
    }

    public List<Order> getRecentMovieList(String username){
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        orderMapper = app.getBean(OrderMapper.class);
        return orderMapper.findOrdersByUserName(username);
    }

    public Movie getMovieById(long id){
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        movieMapper = app.getBean(MovieMapper.class);
        return movieMapper.findMovieById(id);
    }

    public Schedule getScheduleById(long id){
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        scheduleMapper = app.getBean(ScheduleMapper.class);
        return scheduleMapper.findScheduleById(id);
    }

    public boolean typeMatch(Movie recent, Movie current){
        String[] recentTypes = recent.getMovie_type().split(",");
        String[] currentTypes = current.getMovie_type().split(",");
        for (String recentType : recentTypes) {
            for (String currentType : currentTypes) {
                if (recentType.equals(currentType)){
                    return true;
                }
            }
        }
        return false;
    }

    public boolean starMatch(Movie recent, Movie current){
        String[] recentStars = recent.getMovie_actor().split(",");
        String[] currentStars = current.getMovie_actor().split(",");
        for (String recentStar : recentStars) {
            for (String currentStar : currentStars) {
                if(recentStar.split(":")[0].equals(currentStar.split(":")[0])){
                    System.out.println(currentStar + "hit!");
                    return true;
                }
            }
        }
        return false;
    }

    public boolean directorMatch(Movie recent, Movie current){
        String recentDirector = recent.getMovie_director();
        String currentDirector = current.getMovie_director();
        if(recentDirector.equals(currentDirector)){
            System.out.println(currentDirector + "hit!");
            return true;
        }
        return false;
    }

    public LinkedList<Movie> recommendMovies(int count,LinkedList<Movie> recommendList){

        LinkedList<Movie> newList = new LinkedList<Movie>();
        for(int i=0;i<count && i<=recommendList.size();i++){
            newList.addLast(recommendList.get(i));
        }
        Collections.sort(newList);
        return newList;
    }

    public static LinkedList<Movie> returnMovies(User user){
        Recommend recommend = new Recommend();
//        User user = recommend.getUser();
        List<Movie> movieList = recommend.getMovieList();
        List<Order> recentOrderList = recommend.getRecentMovieList(user.getUser_name());
        Movie recentMovie = null;
        Order recentOrder = null;
        Schedule recentSchedule = null;
        if(recentOrderList!=null){
            recentOrder = recentOrderList.get(0);
            recentSchedule = recommend.getScheduleById(recentOrder.getSchedule_id());
            recentMovie = recommend.getMovieById(recentSchedule.getMovie_id());
        }

        Set<Long> watchedId = new HashSet<Long>();
        for (Order order : recentOrderList) {
            Long cureentMovieId = recommend.getScheduleById(order.getSchedule_id()).getMovie_id();
            if(!watchedId.contains(cureentMovieId)){
                watchedId.add(cureentMovieId);
            }
        }

        LinkedList<Movie> recommendList = new LinkedList<Movie>();
        for (Movie movie : movieList) {
            if(!watchedId.contains(movie.getMovie_id())){
                recommendList.add(movie);
            }
        }

        int size = recommendList.size();
        int pointer = size-1;
        for(int i=0;i<size;i++){
            if(recommend.typeMatch(recentMovie,recommendList.get(pointer))){
                recommendList.addFirst(recommendList.remove(pointer));

            }
            else {
                pointer--;
            }
        }


        size = recommendList.size();
        pointer = size-1;
        for(int i=0;i<size;i++){
            if(recommend.starMatch(recentMovie,recommendList.get(pointer))){
                recommendList.addFirst(recommendList.remove(pointer));
            }
            else {
                pointer--;
            }
        }

        size = recommendList.size();
        pointer = size-1;
        for(int i=0;i<size;i++){
            if(recommend.directorMatch(recentMovie,recommendList.get(pointer))){
                recommendList.addFirst(recommendList.remove(pointer));
            }
            else {
                pointer--;
            }
        }

        LinkedList<Movie> finaleList = recommend.recommendMovies(6,recommendList);

        return finaleList;
    }


}
