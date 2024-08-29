package com.belogrudov.servermock.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class OpenAiApiConfiguration {

    @Bean
    public WebClient openAiWebClient(OpenAiProperties properties) {
        String url = properties.url().base() + properties.url().version() + properties.url().path();
        return WebClient.builder()
                .baseUrl(url)
                .defaultHeader("Authorization", "Bearer " + properties.token())
                .defaultHeader("Content-Type", "application/json")
                .build();
    }
}