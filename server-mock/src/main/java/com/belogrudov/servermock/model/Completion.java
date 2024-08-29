package com.belogrudov.servermock.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Builder;
import lombok.Value;
import lombok.extern.jackson.Jacksonized;

@Value
@Builder
@Jacksonized
@JsonIgnoreProperties(ignoreUnknown = true)
public class Completion {
    String uuid;
    String name;

    public String toJson() {
        return """
                {
                    "uuid":"%s",
                    "name":"%s"
                }"""
                .formatted(uuid, name);
    }
}
