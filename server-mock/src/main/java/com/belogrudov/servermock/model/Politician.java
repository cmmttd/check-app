package com.belogrudov.servermock.model;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Value;
import lombok.extern.jackson.Jacksonized;

@Value
@Builder
@Jacksonized
@JsonIgnoreProperties(ignoreUnknown = true)
public class Politician {
    String name;
    String surname;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    LocalDate birthdate;
    @JsonProperty("country_code")
    String countryCode;
    String bio;
    List<Promise> promises;

    public String toJson() {
        return """
                {
                    "name":"%s",
                    "surname":"%s",
                    "birthdate":"%s",
                    "country_code":"%s",
                    "bio":"%s",
                    "promises":%s
                }"""
                .formatted(name, surname, birthdate, countryCode, bio, promises);
    }
}
