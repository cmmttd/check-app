package com.belogrudov.servermock.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;

import lombok.Builder;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class MockController {

    private static final List<PoliticianData> data = List.of(
            PoliticianData.builder().name("George").surname("Washington").birthdate(1732).countryCode("US").build(),
            PoliticianData.builder().name("Winston").surname("Churchill").birthdate(1874).countryCode("UK").build(),
            PoliticianData.builder().name("Otto").surname("von Bismarck").birthdate(1815).countryCode("DE").build(),
            PoliticianData.builder().name("Kassym-Jomart").surname("Tokayev").birthdate(1953).countryCode("KZ").build()
    );

    @GetMapping(value = "/mock/promises/{uuid}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(originPatterns = "*")
    public String getMockPromises(@PathVariable String uuid) throws InterruptedException {
        log.trace(uuid);
        TimeUnit.SECONDS.sleep(1);
        return """
                {
                  "politician_id": 123,
                  "promises": [
                    {
                      "timestamp": 1234,
                      "promise_name": "test_name",
                      "description": "test_description",
                      "evidences": [
                        {
                          "name": "test_evidence_name1",
                          "fulfilled": 0.8
                        }
                      ],
                      "links": [
                        {
                          "name": "test_link_name1",
                          "link": "http://google.com"
                        }
                      ],
                      "is_fulfilled": true
                    }
                  ]
                }""";
    }

    @SneakyThrows
    @GetMapping(value = "/mock/completion/{input}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(originPatterns = "*")
    public String getCompletion(@PathVariable String input) {
        TimeUnit.SECONDS.sleep(1);
        List<PoliticianData> options = data.stream()
                .filter(x -> x.toString().toLowerCase().contains(input.toLowerCase()))
                .toList();
        log.debug("Completion found for input: {}  {}", input, options.size());
        return """
                {
                  "input": "%s",
                  "options": %s
                }""".formatted(input, options);
    }

    @SneakyThrows
    @GetMapping(value = "/mock/completions", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(originPatterns = "*")
    public String getCompletion() {
        TimeUnit.SECONDS.sleep(1);
        log.debug("All completions requested: {}", data.size());
        return """
                {
                  "input": "",
                  "options": %s
                }""".formatted(data);
    }

    @Builder
    record PoliticianData(String name, String surname, int birthdate, String countryCode) {
        @Override
        public String toString() {
            return "{\"name\":\"%s\",\"surname\":\"%s\",\"birthdate\":%d,\"countryCode\":\"%s\"}"
                    .formatted(name, surname, birthdate, countryCode);
        }
    }
}
