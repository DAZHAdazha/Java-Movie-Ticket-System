package com.spring_interceptor.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor1 implements HandlerInterceptor{
    @Override
    //在目标方法执行之前执行
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("preHandler");
        String param = request.getParameter("param");
        if ("yes".equals(param)){
            return true;
        }
        else {
            request.getRequestDispatcher("/error.jsp").forward(request,response);
        }
        return false;
        //返回false则之后的方法不再执行
        //返回true则后续方法继续执行
    }

    @Override
    //在目标方法执行之后视图返回之前执行
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandler");
        //修改name为changed
        modelAndView.addObject("name","changed");
    }

    @Override
    //在目标方法完全执行之后再执行
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion");
    }
}
