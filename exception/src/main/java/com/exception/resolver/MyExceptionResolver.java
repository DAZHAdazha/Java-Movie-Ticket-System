package com.exception.resolver;

import com.exception.exception.MyException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyExceptionResolver implements HandlerExceptionResolver {
    /*
    参数Exception: 异常对象
    返回值ModelAndView: 跳转的错误试图信息
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        ModelAndView modelAndView = new ModelAndView();
        if (ex instanceof MyException){
            modelAndView.addObject("info","自定义的异常");
        }
        else {
            modelAndView.addObject("info","类转换异常");
        }
        modelAndView.setViewName("error");
        return modelAndView;
    }
}
