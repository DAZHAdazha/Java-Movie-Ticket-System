package com.service.imp;

import com.entity.Movie;
import com.entity.Order;
import com.entity.Schedule;
import com.entity.User;
import com.mapper.MovieMapper;
import com.mapper.OrderMapper;
import com.mapper.ScheduleMapper;
import com.mapper.UserMapper;
import com.service.IRecommendService;
import com.util.Recommend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RecommendServiceImp implements IRecommendService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private MovieMapper movieMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private ScheduleMapper scheduleMapper;


    @Override
    public List<Movie> getMovieList(){
        return movieMapper.findAllMovies(1);
    }
    @Override
    public List<Order> getRecentMovieList(String username){
        return orderMapper.findOrdersByUserName(username);
    }
    @Override
    public Movie getMovieById(long id){
        return movieMapper.findMovieById(id);
    }
    @Override
    public Schedule getScheduleById(long id){
        return scheduleMapper.findScheduleById(id);
    }
    @Override
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
    @Override
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
    @Override
    public boolean directorMatch(Movie recent, Movie current){
        String recentDirector = recent.getMovie_director();
        String currentDirector = current.getMovie_director();
        if(recentDirector.equals(currentDirector)){
            System.out.println(currentDirector + "hit!");
            return true;
        }
        return false;
    }
    @Override
    public LinkedList<Movie> recommendMovies(int count, LinkedList<Movie> recommendList){

        LinkedList<Movie> newList = new LinkedList<Movie>();
        for(int i=0;i<count && i<=recommendList.size();i++){
            newList.addLast(recommendList.get(i));
        }
        Collections.sort(newList);
        return newList;
    }
    @Override
    public LinkedList<Movie> returnMovies(User user){

        List<Movie> movieList = this.getMovieList();
        List<Order> recentOrderList = this.getRecentMovieList(user.getUser_name());
        Movie recentMovie = null;
        Order recentOrder;
        Schedule recentSchedule;
        LinkedList<Movie> recommendList = new LinkedList<Movie>();
        if (recentOrderList.size()!=0){
            if(recentOrderList!=null){
                recentOrder = recentOrderList.get(0);
                recentSchedule = this.getScheduleById(recentOrder.getSchedule_id());
                recentMovie = this.getMovieById(recentSchedule.getMovie_id());
            }

            Set<Long> watchedId = new HashSet<Long>();
            for (Order order : recentOrderList) {
                Long cureentMovieId = this.getScheduleById(order.getSchedule_id()).getMovie_id();
                if(!watchedId.contains(cureentMovieId)){
                    watchedId.add(cureentMovieId);
                }
            }


            for (Movie movie : movieList) {
                if(!watchedId.contains(movie.getMovie_id())){
                    recommendList.add(movie);
                }
            }

            int size = recommendList.size();
            int pointer = size-1;
            for(int i=0;i<size;i++){
                if(this.typeMatch(recentMovie,recommendList.get(pointer))){
                    recommendList.addFirst(recommendList.remove(pointer));

                }
                else {
                    pointer--;
                }
            }


            size = recommendList.size();
            pointer = size-1;
            for(int i=0;i<size;i++){
                if(this.starMatch(recentMovie,recommendList.get(pointer))){
                    recommendList.addFirst(recommendList.remove(pointer));
                }
                else {
                    pointer--;
                }
            }

            size = recommendList.size();
            pointer = size-1;
            for(int i=0;i<size;i++){
                if(this.directorMatch(recentMovie,recommendList.get(pointer))){
                    recommendList.addFirst(recommendList.remove(pointer));
                }
                else {
                    pointer--;
                }
            }
        }
        else{
            for(Movie movie:movieList){
                recommendList.add(movie);
            }
            Collections.sort(recommendList);
        }
        LinkedList<Movie> finaleList = this.recommendMovies(6,recommendList);

        return finaleList;
    }


}
