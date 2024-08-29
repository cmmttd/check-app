package com.belogrudov.servermock.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Slf4j
@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Value("${cors.allowed-origins}")
    private String allowedOrigins;

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        log.info("Configuring CORS to allow from: {}", allowedOrigins);
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry
                        .addMapping("/completions/**")
                        .allowedOrigins(allowedOrigins)
                        .allowedMethods("GET", "POST");
                registry
                        .addMapping("/promises/**")
                        .allowedOrigins(allowedOrigins)
                        .allowedMethods("GET", "POST");
            }
        };
    }
}