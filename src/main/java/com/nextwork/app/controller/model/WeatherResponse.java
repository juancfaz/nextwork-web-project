package com.nextwork.app.model;

import java.util.Map;
import java.util.List;

public class WeatherResponse {
    private String name;
    private Sys sys;
    private Main main;
    private List<Weather> weather;

    // Getters y Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Sys getSys() { return sys; }
    public void setSys(Sys sys) { this.sys = sys; }

    public Main getMain() { return main; }
    public void setMain(Main main) { this.main = main; }

    public List<Weather> getWeather() { return weather; }
    public void setWeather(List<Weather> weather) { this.weather = weather; }

    // Clases internas para mapear la respuesta JSON
    public static class Sys {
        private String country;
        
        public String getCountry() { return country; }
        public void setCountry(String country) { this.country = country; }
    }

    public static class Main {
        private double temp;
        private double feels_like;
        private int humidity;
        
        public double getTemp() { return temp; }
        public void setTemp(double temp) { this.temp = temp; }
        
        public double getFeels_like() { return feels_like; }
        public void setFeels_like(double feels_like) { this.feels_like = feels_like; }
        
        public int getHumidity() { return humidity; }
        public void setHumidity(int humidity) { this.humidity = humidity; }
    }

    public static class Weather {
        private String description;
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
    }
}