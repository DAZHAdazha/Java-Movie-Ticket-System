package com.aop.anno;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Component("myAspect")
@Aspect//标注MyAspect是切面
public class MyAspect {

    //配置前置增强
    @Before("pointcut()")
    public void before(){
        System.out.println("前置增强");
    }

    @AfterReturning("MyAspect.pointcut()")
    public void afterReturning(){
        System.out.println("后置增强");
    }

    //Proceeding JoinPoint: 正在执行的连接点
    @Around("execution(* com.aop.anno.*.*(..))")
    public Object around(ProceedingJoinPoint pjp) throws Throwable{
        System.out.println("环绕前增强");
        Object proceed = pjp.proceed();//切点方法
        System.out.println("环绕后增强");
        return proceed;
    }

    public void afterThrowing(){
        System.out.println("异常抛出");
    }

    public void after(){
        System.out.println("最终增强");
    }

    //定义切点表达式
    @Pointcut("execution(* com.aop.anno.*.*(..))")
    public void pointcut(){}
}
