package com.belogrudov.servermock.controller;

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
public class PromisesController {

    private final PoliticianObserveService politicianObserveService;

    @GetMapping(value = "/promises/{uuid}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(origins = "${cors.allowed-origins}")
    public String getMockPromises(@PathVariable String uuid) {
        log.debug("Promises requested for {}", uuid);
        String fullJson = politicianObserveService.findPolitician(uuid).toJson();
        log.debug("Full json: {}", fullJson);
        return fullJson;
    }
}