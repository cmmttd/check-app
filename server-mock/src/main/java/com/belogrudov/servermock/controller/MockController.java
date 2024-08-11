package com.belogrudov.servermock.controller;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.stream.IntStream;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class MockController {

    private static final Map<String, Subject> data = new HashMap<>();
    private static final Random RANDOM = new Random();

    static {
        fillAndStore("George", "Washington", LocalDate.of(1732, 1, 2), "US");
        fillAndStore("Winston", "Churchill", LocalDate.of(1874, 11, 20), "UK");
        fillAndStore("Otto", "von Bismarck", LocalDate.of(1815, 3, 22), "DE");
        fillAndStore("Kassym-Jomart", "Tokayev", LocalDate.of(1953, 5, 2), "KZ");
    }

    @GetMapping(value = "/mock/promises/{uuid}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getMockPromises(@PathVariable String uuid) {
        log.debug("Promises requested for {}", uuid);
        return data.get(uuid).toFullJson();
    }

    @GetMapping(value = "/mock/completion/{input}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getCompletion(@PathVariable String input) {
        List<String> options = data.values().stream()
                .filter(x -> x.toSimpleJson().toLowerCase().contains(input.toLowerCase()))
                .sorted((Comparator.comparing(Subject::getName)))
                .map(Subject::toSimpleJson)
                .toList();
        log.debug("Completion found for input: {}  {}", input, options.size());
        return """
                {
                  "input": "%s",
                  "options": %s
                }""".formatted(input, options);
    }

    @GetMapping(value = "/mock/completions", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getCompletion() {
        List<String> options = data.values().stream()
                .sorted((Comparator.comparing(Subject::getName)))
                .map(Subject::toSimpleJson)
                .toList();
        String formatted = """
                {
                  "input": "",
                  "options": %s
                }""".formatted(options);
        log.debug("All completions requested: {} - {}", data.size(), formatted);
        return formatted;
    }

    private static void fillAndStore(String name, String surname, LocalDate birthdate, String countryCode) {
        String uuid = UUID.randomUUID().toString();
        Subject subject = Subject.builder()
                .uuid(uuid)
                .name(name)
                .surname(surname)
                .birthdate(birthdate)
                .countryCode(countryCode)
                .bio("%s %s %s".formatted(name, surname, birthdate))
                .promises(generateRandomPromises())
                .build();
        data.put(uuid, subject);
    }

    private static List<Promise> generateRandomPromises() {
        return IntStream.range(0, RANDOM.nextInt(13, 25))
                .mapToObj(x -> Promise.builder()
                        .date(LocalDate.now().minusYears(RANDOM.nextInt(3, 42)))
                        .title("Random title: " + x)
                        .description("Random description" + x)
                        .isFulfilled(RANDOM.nextBoolean())
                        .build())
                .sorted((o1, o2) -> o2.date().compareTo(o1.date()))
                .toList();
    }
}