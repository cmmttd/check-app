package com.belogrudov.servermock.controller;

import java.util.concurrent.TimeUnit;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MockController {

    @GetMapping(value = "/mock/promises/{uuid}", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin(originPatterns = "*")
    String getMockPromises(@PathVariable String uuid) throws InterruptedException {
        System.out.println(uuid);
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
}
