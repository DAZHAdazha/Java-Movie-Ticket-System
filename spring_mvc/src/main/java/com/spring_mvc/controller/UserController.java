package com.spring_mvc.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring_mvc.domain.User;
import com.spring_mvc.domain.VO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.wildfly.swarm.config.IO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Date;
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

    @RequestMapping("/quick16")
    @ResponseBody
    //localhost:8080/user/quick16?username=admin3
    //当请求参数名称和Controller业务方法参数名称不一样时，通过@ResquestOaram注解显示绑定
    //value:请求参数名称
    //required:指定请求参数是否必须包括，默认是true，提交时若没有此参数会报错
    //defaultValue:当没有指定参数时，在则使用指定的默认值
    public void save16(@RequestParam(value = "username", required = false, defaultValue = "tester") String name){
        //获取数据
        System.out.println("Username: " + name);
    }

    @RequestMapping("/quick17/{username}&{age}")
    @ResponseBody
    public void save17(@PathVariable(value = "username", required = true) String name, @PathVariable(value = "age") int age){
        //获取数据
        System.out.println("Username: " + name);
        System.out.println("Age     : " + age);
    }

    @RequestMapping("/quick18")
    @ResponseBody
    //自定义类型转换器
    //定义转换器接口
    //配置文件中声明转换器
    //在<annotation-driven>中引用转换器
    public void save18(Date date){
        //获取数据
        System.out.println(date);
    }

    @RequestMapping("/quick19")
    @ResponseBody
    public void save19(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        System.out.println(request);
        System.out.println(response);
        System.out.println(session);
    }

    @RequestMapping("/quick20")
    @ResponseBody
    //获取请求头
    public void save20(@RequestHeader(value = "Cookie", required = false) String cookie){
        System.out.println(cookie);
    }

    @RequestMapping("/quick21")
    @ResponseBody
    //获取Cookie
    //value是键
    public void save21(@CookieValue(value = "Pycharm-bb2bdaa4") String jsessionId){
        System.out.println(jsessionId);
    }


    @RequestMapping("/quick22")
    @ResponseBody
    //文件上传原理
    //当form表单修改为多部分表单, request.getParameter()将失效。
    //enctype= "application/x-www-form-urlencoded"时,form表单正文内容格式是:
    //key=value&key=value&key=value
    //当form表单是Multipart/form-data时,请求正文内容就变成多部分形式。
    public void save22(@CookieValue(value = "Pycharm-bb2bdaa4") String jsessionId){
        System.out.println(jsessionId);
    }
}
