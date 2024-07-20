package com.belogrudov.servermock.controller;

import java.time.LocalDate;

import lombok.Builder;

@Builder
public record Promise(LocalDate date, String title, String description, boolean isFulfilled) {
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
