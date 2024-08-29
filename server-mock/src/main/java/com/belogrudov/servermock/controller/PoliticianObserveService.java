package com.belogrudov.servermock.controller;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import com.belogrudov.servermock.model.Completion;
import com.belogrudov.servermock.model.Politician;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class PoliticianObserveService {

    static ConcurrentHashMap<String, String> completionsCache = new ConcurrentHashMap<>();
    static ConcurrentHashMap<String, String> politiciansProxyCache = new ConcurrentHashMap<>();
    static ConcurrentHashMap<String, Politician> politiciansCache = new ConcurrentHashMap<>();
    static String COMPLETION_TEMPLATE = """
            {
              "model": "gpt-4o-2024-08-06",
              "response_format": {
                "type": "json_object"
              },
              "temperature": 0,
              "messages": [
                {
                  "role": "system",
                  "content": "You are an intelligent and very precise searching engine. You need to provide a list of politicians data, which could be uniquely identified by user-passed string (usually user expect match by name when passing the string and the birthday match when passing the date or number, in case of mismatch or empty input return the 5 most mentioned politicians). The response have to be a valid json and consists of array of objects in format: {\\"completions\\":[\\"$name $surname, $birthdate, $country_code\\"]}, where $name - first name or first names only, do not duplicate the surname!, $surname - surname of the politician, only if exists, $birthdate - the birthdate of the politician in format YYYY-MM-DD, $country_code - ISO-3166 country code of the politician's birthplace and all parameters in single formatted by pattern string"
                },
                {
                  "role": "user",
                  "content": "%s"
                }
              ]
            }
            """;
    static String PROMISES_TEMPLATE = """
            {
              "model": "gpt-4o-2024-08-06",
              "response_format": {
                "type": "json_object"
              },
              "temperature": 0,
              "messages": [
                {
                  "role": "system",
                  "content": "You are an intelligent and very precise searching engine. You need to provide a list of last 20 promises for the single politician, which could be uniquely identified by user-passed string. Please pay attention to add only required number of LAST by time promises made! The response have to be a valid json and consists of array of objects in format: {\\"name\\": \\"string - first name or first names only, do not duplicate the surname!\\", \\"surname\\": \\"string - surname of the politician, if exists\\", \\"birthdate\\": \\"1874-11-20 - the birthdate of the politician in format YYYY-MM-DD\\", \\"country_code\\": \\"string - ISO-3166 country code of the politician's birthplace\\", \\"bio\\": \\"string - brief politician bio with main focus on politician activities, not on the private life\\", \\"promises\\": [ { \\"date\\": \\"string - the promise date in format YYYY-MM-DD\\", \\"title\\": \\"string - a short name of the promise\\", \\"description\\": \\"string - exhaustive description with provable evidences and valid web-links\\", \\"is_fulfilled\\": \\"boolean (true or false only) - is the promise was fulfilled or not, HIGHLY IMPORTANT to be consistent with the previous description field\\"}]}"
                },
                {
                  "role": "user",
                  "content": "%s"
                }
              ]
            }
            """;

    OpenAiClient openAiClient;
    ObjectMapper objectMapper;

    @SneakyThrows
    public List<Completion> suggestCompletions(String input) {
        String completionsString = openAiClient.call(COMPLETION_TEMPLATE.formatted(input));
        Completions completions = objectMapper.readValue(completionsString, Completions.class);
        return completions.completions().stream()
                .map(stringCompletion -> {
                    completionsCache.putIfAbsent(stringCompletion, UUID.randomUUID().toString());
                    politiciansProxyCache.put(completionsCache.get(stringCompletion), stringCompletion);
                    return Completion.builder()
                            .uuid(completionsCache.get(stringCompletion))
                            .name(stringCompletion)
                            .build();
                })
                .toList();
    }

    @SneakyThrows
    public Politician findPolitician(String uuid) {
        if (!politiciansCache.containsKey(uuid)) {
            String politicianName = politiciansProxyCache.get(uuid);
            String politicianString = openAiClient.call(PROMISES_TEMPLATE.formatted(politicianName));
            Politician politician = objectMapper.readValue(politicianString, Politician.class);
            politiciansCache.putIfAbsent(uuid, politician);
        }
        return politiciansCache.get(uuid);
    }

    private record Completions(List<String> completions) {
    }
}
