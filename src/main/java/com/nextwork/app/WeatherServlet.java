package com.nextwork.app;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class WeatherServlet extends HttpServlet {
    private static final String API_KEY = "0ad018c42b550f9ce0d3b06a7ec6174f";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String city = request.getParameter("city");
        if (city == null || city.isEmpty()) {
            city = "London"; // Ciudad por defecto
        }
        
        try {
            Client client = ClientBuilder.newClient();
            String url = String.format(
                "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric",
                city, API_KEY
            );
            
            Response apiResponse = client.target(url)
                .request(MediaType.APPLICATION_JSON)
                .get();
            
            if (apiResponse.getStatus() == 200) {
                String jsonResponse = apiResponse.readEntity(String.class);
                request.setAttribute("weatherData", jsonResponse);
            } else {
                request.setAttribute("error", "No se pudo obtener el clima para " + city);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error al conectar con el servicio del clima");
        }
        
        request.getRequestDispatcher("/weather.jsp").forward(request, response);
    }
}