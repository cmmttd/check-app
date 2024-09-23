package com.belogrudov.servermock.model;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder
public record Promise(LocalDate date, String title, String description, @JsonProperty("is_fulfilled") boolean isFulfilled) {
    @Override
    public String toString() {
        return """
                {
                    "date":"%s",
                    "title":"%s",
                    "description":"%s",
                    "is_fulfilled":%b
                }"""
                .formatted(date, title, description, isFulfilled);
    }
}
