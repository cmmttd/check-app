package com.belogrudov.servermock.controller;

import java.util.List;
import java.util.stream.Collectors;

import com.belogrudov.servermock.model.Completion;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class CompletionController {

    private final PoliticianObserveService politicianObserveService;

    @GetMapping(value = "/completions/{input}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getCompletion(@PathVariable String input) {
        log.debug("Received request for completions for: {}", input);
        List<Completion> completions = politicianObserveService.suggestCompletions(input);
        String completionsArray = completions.stream()
                .map(Completion::toJson)
                .collect(Collectors.joining(",", "[", "]"));
        log.info("For input '{}' {} options to completion were found", input, completions.size());
        return completionsArray;
    }

    @GetMapping(value = "/completions", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getCompletion() {
        log.debug("Received request for completion without parameters");
        return getCompletion("");
    }
}