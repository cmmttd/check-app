package com.belogrudov.servermock.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "open-ai")
public record OpenAiProperties(Url url, String token, Conversation conversation) {
    public record Url(String base, String version, String path) {
    }

    public record Conversation(String temperature) {
    }
}