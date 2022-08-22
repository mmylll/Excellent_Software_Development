package com.example.art_backend.config;

import com.example.art_backend.interceptor.UserLoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * 配置拦截器
 */
@Configuration
public class InterceptorConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(
                        new UserLoginInterceptor()).
                addPathPatterns("/**").
                excludePathPatterns("/Login").
                excludePathPatterns("/Register")
                .excludePathPatterns("/getPopularPaintings")
                .excludePathPatterns("/getAllPaintings/**")
                .excludePathPatterns("/getSearchPaintings/**")
                .excludePathPatterns("/getSearchPaintingsAndSort/**")
                .excludePathPatterns("/getAllPaintingsCount")
                .excludePathPatterns("/getSearchPaintingsCount")
                .excludePathPatterns("/getAllPaintingsAndSort")
                .excludePathPatterns("/getTime")
                .excludePathPatterns("/updateViews")
                .excludePathPatterns("/getArtUserByEmail")
                .excludePathPatterns("/**");
        super.addInterceptors(registry);
    }
}