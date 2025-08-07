<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Detector de Clima - NextWork</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f7fa;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 25px;
        }
        .search-form {
            display: flex;
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 16px;
        }
        .search-form input[type="submit"] {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            font-size: 16px;
        }
        .search-form input[type="submit"]:hover {
            background-color: #2980b9;
        }
        .weather-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            text-align: center;
        }
        .weather-header {
            font-size: 24px;
            margin-bottom: 15px;
            color: #2c3e50;
        }
        .weather-details {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .weather-item {
            margin: 10px;
            min-width: 120px;
        }
        .weather-value {
            font-size: 20px;
            font-weight: bold;
            color: #3498db;
        }
        .weather-label {
            font-size: 14px;
            color: #7f8c8d;
            text-transform: uppercase;
        }
        .error-message {
            background-color: #fdecea;
            color: #c62828;
            padding: 15px;
            border-radius: 4px;
            margin: 20px 0;
            text-align: center;
        }
        .info-message {
            background-color: #e3f2fd;
            color: #1565c0;
            padding: 15px;
            border-radius: 4px;
            margin: 20px 0;
            text-align: center;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌤️ Detector de Clima</h1>
        
        <form method="get" class="search-form">
            <input type="text" name="city" value="${fn:escapeXml(searchedCity)}" placeholder="Ingresa una ciudad...">
            <input type="submit" value="Buscar">
        </form>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ⚠️ ${error}
            </div>
        </c:if>
        
        <c:if test="${empty weatherData and empty error and empty searchedCity}">
            <div class="info-message">
                🔍 Ingresa una ciudad para consultar el clima actual
            </div>
        </c:if>
        
        <c:if test="${not empty weatherData}">
            <div class="weather-card">
                <div class="weather-header">
                    Clima en ${fn:escapeXml(searchedCity)}
                </div>
                
                <div class="weather-details">
                    <c:set var="weatherJson" value="${fn:replace(weatherData, 'null', '\"\"')}"/>
                    <c:set var="weatherMap" value="${fn:substringAfter(weatherJson, '{')}"/>
                    <c:set var="weatherMap" value="${fn:substringBefore(weatherMap, '}')}"/>
                    
                    <div class="weather-item">
                        <div class="weather-value">${fn:substringBefore(fn:substringAfter(weatherJson, '\"temp\":'), ',')}°C</div>
                        <div class="weather-label">Temperatura</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-value">${fn:substringBefore(fn:substringAfter(weatherJson, '\"humidity\":'), ','}%</div>
                        <div class="weather-label">Humedad</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-value">${fn:substringBefore(fn:substringAfter(weatherJson, '\"feels_like\":'), ','}°C</div>
                        <div class="weather-label">Sensación</div>
                    </div>
                    
                    <div class="weather-item">
                        <div class="weather-value">${fn:substringBefore(fn:substringAfter(fn:substringAfter(weatherJson, '\"weather\":['), '\"description\":\"'), '\"')}</div>
                        <div class="weather-label">Condición</div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">← Volver al inicio</a>
    </div>
</body>
</html>