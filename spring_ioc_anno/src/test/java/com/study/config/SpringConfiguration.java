package com.study.config;

import org.springframework.context.annotation.*;


@Configuration
//表示是spring的核心配置类
@Import(DataSourceConfiguration.class)
@ComponentScan("com.study")
//组件扫描
public class SpringConfiguration {

}
