package com.service;

import com.entity.Movie;
import com.entity.Order;
import com.entity.Schedule;
import com.entity.User;

import java.util.LinkedList;
import java.util.List;

public interface IRecommendService {
    public LinkedList<Movie> returnMovies(User user);

    List<Order> getRecentMovieList(String username);

    Movie getMovieById(long id);

    Schedule getScheduleById(long id);

    boolean typeMatch(Movie recent, Movie current);

    boolean starMatch(Movie recent, Movie current);

    boolean directorMatch(Movie recent, Movie current);

    LinkedList<Movie> recommendMovies(int count, LinkedList<Movie> recommendList);


    List<Movie> getMovieList();
}
