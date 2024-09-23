package com.belogrudov.servermock.controller;

import java.util.List;

import lombok.Builder;

public record OpenAiResponseContainer(List<Choice> choices) {
    public record Choice(int index, Message message) {
    }

    @Builder
    public record Message(String content) {
    }

    public String getStringResponse() {
        if (choices().isEmpty()) {
            throw new EmptyResponseException("No choices found");
        }
        return choices().get(0).message().content();
    }
}

class EmptyResponseException extends RuntimeException {
    public EmptyResponseException(String message) {
        super(message);
    }
}