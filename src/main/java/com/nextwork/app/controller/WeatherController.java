package com.nextwork.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.nextwork.app.model.WeatherResponse;

@Controller
public class WeatherController {

    private final String API_KEY = "0ad018c42b550f9ce0d3b06a7ec6174f";

    @GetMapping("/weather")
    public String getWeather(@RequestParam(required = false) String city, Model model) {
        if (city != null && !city.isEmpty()) {
            String url = String.format(
                "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric&lang=es",
                city, API_KEY
            );

            RestTemplate restTemplate = new RestTemplate();
            
            try {
                WeatherResponse response = restTemplate.getForObject(url, WeatherResponse.class);
                model.addAttribute("weather", response);
            } catch (Exception e) {
                model.addAttribute("error", "No se pudo obtener el clima. Verifica el nombre de la ciudad.");
            }
        }
        
        return "weather";
    }
}