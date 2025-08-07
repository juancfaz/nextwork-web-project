<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<html>
<head>
    <title>Detector de Clima - NextWork</title>
    <style>
        :root {
            --primary: #3498db;
            --secondary: #2c3e50;
            --light: #ecf0f1;
            --danger: #e74c3c;
            --success: #2ecc71;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
            color: #333;
        }
        
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
        }
        
        .weather-header {
            text-align: center;
            margin-bottom: 30px;
            color: var(--secondary);
        }
        
        .search-box {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
        }
        
        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border 0.3s;
        }
        
        .search-input:focus {
            border-color: var(--primary);
            outline: none;
        }
        
        .search-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }
        
        .search-btn:hover {
            background-color: #2980b9;
        }
        
        .weather-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            display: none; /* Inicialmente oculto */
        }
        
        .weather-card.active {
            display: block;
        }
        
        .weather-location {
            background: var(--secondary);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .weather-location h2 {
            margin: 0;
            font-size: 24px;
        }
        
        .weather-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            padding: 25px;
        }
        
        .weather-item {
            text-align: center;
        }
        
        .weather-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        
        .weather-value {
            font-size: 28px;
            font-weight: bold;
            color: var(--secondary);
        }
        
        .weather-label {
            font-size: 14px;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .weather-description {
            grid-column: 1 / -1;
            text-align: center;
            font-style: italic;
            padding: 15px;
            background: var(--light);
            border-radius: 4px;
        }
        
        .error-message {
            background-color: #fdecea;
            color: var(--danger);
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
        
        .error-message.active {
            display: block;
        }
        
        .info-message {
            text-align: center;
            padding: 30px;
            color: #7f8c8d;
            font-size: 18px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: var(--primary);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: var(--secondary);
            text-decoration: underline;
        }
        
        /* Iconos meteorológicos */
        .wi {
            font-family: 'Weather Icons';
        }
    </style>
    <!-- Para íconos del clima (opcional) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.10/css/weather-icons.min.css">
</head>
<body>
    <div class="container">
        <div class="weather-header">
            <h1>Detector de Clima</h1>
            <p>Consulta las condiciones meteorológicas actuales en cualquier ciudad del mundo</p>
        </div>
        
        <div class="search-box">
            <form class="search-form" method="get">
                <input type="text" 
                       class="search-input" 
                       name="city" 
                       placeholder="Ingresa una ciudad (ej. Madrid, Buenos Aires, Tokyo)" 
                       value="${fn:escapeXml(searchedCity)}">
                <button type="submit" class="search-btn">Buscar</button>
            </form>
        </div>
        
        <div class="error-message ${not empty error ? 'active' : ''}">
            ${error}
        </div>
        
        <c:if test="${not empty weatherData}">
            <div class="weather-card active" id="weatherResult">
                <div class="weather-location">
                    <h2>${fn:escapeXml(searchedCity)}</h2>
                </div>
                
                <div class="weather-details">
                    <div class="weather-item">
                        <div class="weather-icon">
                            <i class="wi wi-thermometer"></i>
                        </div>
                        <div class="weather-value" id="temperature">--</div>
                        <div class="weather-label">Temperatura</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-icon">
                            <i class="wi wi-humidity"></i>
                        </div>
                        <div class="weather-value" id="humidity">--</div>
                        <div class="weather-label">Humedad</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-icon">
                            <i class="wi wi-barometer"></i>
                        </div>
                        <div class="weather-value" id="pressure">--</div>
                        <div class="weather-label">Presión</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-icon">
                            <i class="wi wi-strong-wind"></i>
                        </div>
                        <div class="weather-value" id="wind">--</div>
                        <div class="weather-label">Viento</div>
                    </div>
                    
                    <div class="weather-description" id="weatherDescription">
                        Cargando descripción...
                    </div>
                </div>
            </div>
            
            <script>
                // Parsear el JSON y mostrar los datos
                const weatherData = ${weatherData};
                document.getElementById('temperature').textContent = weatherData.main.temp + '°C';
                document.getElementById('humidity').textContent = weatherData.main.humidity + '%';
                document.getElementById('pressure').textContent = weatherData.main.pressure + ' hPa';
                document.getElementById('wind').textContent = weatherData.wind.speed + ' m/s';
                document.getElementById('weatherDescription').textContent = 
                    weatherData.weather[0].description.charAt(0).toUpperCase() + 
                    weatherData.weather[0].description.slice(1);
                
                // Cambiar ícono según el clima
                const weatherIcon = document.querySelector('.weather-icon i');
                const weatherCode = weatherData.weather[0].id;
                
                if(weatherCode >= 200 && weatherCode < 300) {
                    weatherIcon.className = 'wi wi-thunderstorm';
                } else if(weatherCode >= 300 && weatherCode < 400) {
                    weatherIcon.className = 'wi wi-sprinkle';
                } else if(weatherCode >= 500 && weatherCode < 600) {
                    weatherIcon.className = 'wi wi-rain';
                } else if(weatherCode >= 600 && weatherCode < 700) {
                    weatherIcon.className = 'wi wi-snow';
                } else if(weatherCode >= 700 && weatherCode < 800) {
                    weatherIcon.className = 'wi wi-fog';
                } else if(weatherCode === 800) {
                    weatherIcon.className = 'wi wi-day-sunny';
                } else if(weatherCode > 800) {
                    weatherIcon.className = 'wi wi-cloudy';
                }
            </script>
        </c:if>
        
        <c:if test="${empty weatherData and empty error and empty searchedCity}">
            <div class="info-message">
                <p>Ingresa el nombre de una ciudad en el campo de búsqueda para ver el clima actual</p>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">← Volver al inicio</a>
    </div>
</body>
</html>