package com.belogrudov.servermock.controller;

import java.time.LocalDate;
import java.util.List;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class Subject {
    String uuid;
    String name;
    String surname;
    LocalDate birthdate;
    String countryCode;
    String bio;
    List<Promise> promises;

    public String toSimpleJson() {
        return """
                {
                    "uuid":"%s",
                    "name":"%s",
                    "surname":"%s",
                    "birthdate":"%s",
                    "country_code":"%s"
                }"""
                .formatted(uuid, name, surname, birthdate, countryCode);
    }

    public String toFullJson() {
        return """
                {
                    "uuid":"%s",
                    "name":"%s",
                    "surname":"%s",
                    "birthdate":"%s",
                    "country_code":"%s",
                    "bio":"%s",
                    "promises":%s
                }"""
                .formatted(uuid, name, surname, birthdate, countryCode, bio, promises);
    }
}
