<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detector de Clima</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .weather-container { max-width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .weather-form { margin-bottom: 20px; }
        .weather-info { margin-top: 20px; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="weather-container">
        <h2>Detector de Clima</h2>
        
        <form class="weather-form" action="/weather" method="get">
            <input type="text" name="city" placeholder="Ingresa una ciudad" required>
            <button type="submit">Buscar</button>
        </form>
        
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        
        <c:if test="${not empty weather}">
            <div class="weather-info">
                <h3>Clima en ${weather.name}, ${weather.sys.country}</h3>
                <p><strong>Temperatura:</strong> ${weather.main.temp}°C</p>
                <p><strong>Sensación térmica:</strong> ${weather.main.feels_like}°C</p>
                <p><strong>Humedad:</strong> ${weather.main.humidity}%</p>
                <p><strong>Descripción:</strong> ${weather.weather[0].description}</p>
            </div>
        </c:if>
    </div>
</body>
</html>