package com.belogrudov.servermock;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;

@SpringBootApplication
@ConfigurationPropertiesScan
public class ServerMockApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServerMockApplication.class, args);
    }

}
