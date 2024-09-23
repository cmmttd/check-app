package com.belogrudov.servermock.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JsonConfiguration {

    @Bean
    public ObjectMapper objectMapper() {
        JsonMapper mapper = JsonMapper.builder()
                .findAndAddModules()
                .build();
        mapper.findAndRegisterModules();
        return mapper;
    }
}
