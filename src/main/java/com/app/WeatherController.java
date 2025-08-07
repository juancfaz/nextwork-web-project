package com.nextwork.app.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.http.ResponseEntity;

import com.nextwork.app.model.WeatherResponse;

import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/weather")
public class WeatherController {

    private final String API_KEY = "0ad018c42b550f9ce0d3b06a7ec6174f";

    @GetMapping("/{city}")
    public ResponseEntity<?> getWeather(@PathVariable String city) {
        String url = String.format(
            "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric&lang=es",
            city, API_KEY
        );

        RestTemplate restTemplate = new RestTemplate();

        try {
            Map<String, Object> response = restTemplate.getForObject(url, Map.class);

            // Extraer campos necesarios con seguridad
            String ciudad = (String) response.get("name");

            Map<String, String> sys = (Map<String, String>) response.get("sys");
            String pais = sys != null ? sys.get("country") : "";

            Map<String, Object> main = (Map<String, Object>) response.get("main");
            double temperatura = main != null ? ((Number) main.get("temp")).doubleValue() : 0.0;
            double sensacion = main != null ? ((Number) main.get("feels_like")).doubleValue() : 0.0;
            int humedad = main != null ? ((Number) main.get("humidity")).intValue() : 0;

            // weather es una lista, extraemos la primera descripción
            java.util.List<Map<String, Object>> weatherList = (java.util.List<Map<String, Object>>) response.get("weather");
            String descripcion = "";
            if (weatherList != null && !weatherList.isEmpty()) {
                descripcion = (String) weatherList.get(0).get("description");
            }

            WeatherResponse weatherResponse = new WeatherResponse(
                ciudad, pais, temperatura, sensacion, humedad, descripcion
            );

            return ResponseEntity.ok(weatherResponse);

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