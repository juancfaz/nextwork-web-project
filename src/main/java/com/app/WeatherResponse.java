package com.nextwork.app.model;

public class WeatherResponse {
    private String ciudad;
    private String pais;
    private double temperatura;
    private double sensacionTermica;
    private int humedad;
    private String descripcion;

    // Constructor, getters y setters
    public WeatherResponse(String ciudad, String pais, double temperatura,
                         double sensacionTermica, int humedad, String descripcion) {
        this.ciudad = ciudad;
        this.pais = pais;
        this.temperatura = temperatura;
        this.sensacionTermica = sensacionTermica;
        this.humedad = humedad;
        this.descripcion = descripcion;
    }

    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }

    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }

    public double getTemperatura() { return temperatura; }
    public void setTemperatura(double temperatura) { this.temperatura = temperatura; }

    public double getSensacionTermica() { return sensacionTermica; }
    public void setSensacionTermica(double sensacionTermica) { this.sensacionTermica = sensacionTermica; }

    public int getHumedad() { return humedad; }
    public void setHumedad(int humedad) { this.humedad = humedad; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}