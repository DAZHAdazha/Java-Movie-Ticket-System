package com.spring_mvc.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring_mvc.domain.User;
import com.spring_mvc.domain.VO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.List;

@Controller
// @RequestMapping(value = "/user", method = RequestMethod.GET, params = {"username"})
@RequestMapping( "/user")
//value请求地址,method指定请求方式,params限定请求参数条件
// params = {"accountName"}, 表示请求参数必须有accountName
// params = {"money!100"}, 表示money不能等于100
public class UserController {

    @RequestMapping("/quick")
    public String save(){
        System.out.println("Controller save running...");
        return "success";
        // 使用内部资源解析器指定前后缀
        // return "/jsp/success.jsp";
        // forward 转发(默认)
        // redirect 重定向
    }

    @RequestMapping("/quick2")
    public ModelAndView save2(){
        //Model: 模型,封装数据
        //View:  视图,展示数据
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("username","quick2");
        modelAndView.setViewName("success");
        return modelAndView;
    }

    @RequestMapping("/quick3")
    public ModelAndView save3(ModelAndView modelAndView){
        modelAndView.addObject("username","quick3");
        modelAndView.setViewName("success");
        return modelAndView;
    }

    @RequestMapping("/quick4")
    public String save4(Model model){
        model.addAttribute("username", "quick4");
        return "success";
    }

    @RequestMapping("/quick5")
    public String save5(HttpServletRequest request){
        request.setAttribute("username", "quick5");
        return "success";
    }

    @RequestMapping("/quick6")
    public void save6(HttpServletResponse response) throws IOException {
        response.getWriter().print("hello quick6");
    }

    @RequestMapping("/quick7")
    public void save7(HttpServletResponse response) throws IOException {
        response.getWriter().print("hello quick7");
    }

    @RequestMapping("/quick8")
    @ResponseBody
    //告知springmvc该方法直接返回数据不进行跳转
    public String save8() throws IOException {
        return "hello quick8";
    }

    @RequestMapping("/quick9")
    @ResponseBody
    public String save9() throws IOException {
        User user = new User();
        user.setAge(18);
        user.setName("admin");
        //使用json工具转换字符串
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(user);
        return json;
    }
    // 返回对象或集合
    // 期望spring自动将user转换为json
    @RequestMapping("/quick10")
    @ResponseBody
    public User save10() throws IOException {
        User user = new User();
        user.setAge(28);
        user.setName("admin2");
        return user;
    }

    @RequestMapping("/quick11")
    @ResponseBody
    //localhost:8080/user/quick11?name=admin&age=18
    public void save11(String name,int age){
        //获取数据
        System.out.println("Username: " + name);
        System.out.println("Age     : " + age);
    }

    @RequestMapping("/quick12")
    @ResponseBody
    //POJO类型自动封装
    public void save12(User user){
        //获取数据
        System.out.println(user.toString());
    }

    @RequestMapping("/quick13")
    @ResponseBody
    //获得数组类型参数
    //user/quick13?strs=aaa&strs=ccc
    public void save13(String[] strs){
        //获取数据

        System.out.println(Arrays.asList(strs));
    }

    @RequestMapping("/quick14")
    @ResponseBody
    //获得集合类型参数,先包装到POJO中
    public void save14(VO vo){
        System.out.println(Arrays.asList(vo));
    }

    @RequestMapping("/quick15")
    @ResponseBody

    //使用ajax提交可以指定json格式使用RequestBody可以直接收集集合
    public void save15(@RequestBody List<User> userList){
        System.out.println(Arrays.asList(userList));
    }
}
