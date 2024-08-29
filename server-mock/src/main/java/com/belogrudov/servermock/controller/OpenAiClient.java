package com.belogrudov.servermock.controller;

import java.time.Duration;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.scheduler.Schedulers;

@Slf4j
@Service
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class OpenAiClient {

    WebClient openAiWebClient;

    public String call(String body) {
        log.debug("Start calling the OpenAi api with {}", body.replaceAll("\\s", " "));
        String responseString = openAiWebClient.post()
                .bodyValue(body)
                .exchangeToMono(resp -> resp.bodyToMono(OpenAiResponseContainer.class))
                .subscribeOn(Schedulers.parallel())
                .timeout(Duration.ofMinutes(2))
//                .retryWhen(setupRetry())
                .doOnError(err -> {
                    String exceptionMessage = "OpenAi invocation failed";
                    log.error(exceptionMessage, err);
                    throw new RuntimeException(exceptionMessage, err);
                })
                .map(OpenAiResponseContainer::getStringResponse)
                .block();
        log.debug("Response received for {} -> {}", body.replaceAll("\\s", " "), responseString);
        return responseString;
    }
}
