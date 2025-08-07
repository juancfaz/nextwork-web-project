package com.juanfaz.weather;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.http.ResponseEntity;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/weather")
public class WeatherController {

    private final String API_KEY = "0ad018c42b550f9ce0d3b06a7ec6174f"; // tu API key

    @GetMapping("/{city}")
    public ResponseEntity<Map<String, Object>> getWeather(@PathVariable String city) {
        String url = String.format(
            "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric&lang=es",
            city, API_KEY
        );

        RestTemplate restTemplate = new RestTemplate();

        try {
            Map<String, Object> response = restTemplate.getForObject(url, Map.class);
            return ResponseEntity.ok(response);
        } catch (HttpClientErrorException e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "No se pudo obtener el clima. Verifica la ciudad o la API key.");
            error.put("status", e.getStatusCode().value());
            return ResponseEntity.status(e.getStatusCode()).body(error);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Error interno del servidor");
            return ResponseEntity.status(500).body(error);
        }
    }
}
