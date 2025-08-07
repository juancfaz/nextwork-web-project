<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detector de Clima NextWork</title>
    <style>
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
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .search-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        input[type="text"] {
            padding: 12px;
            width: 60%;
            border: 2px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        input[type="submit"] {
            background: #3498db;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
            transition: background 0.3s;
        }
        
        input[type="submit"]:hover {
            background: #2980b9;
        }
        
        .weather-card {
            display: none; /* Inicialmente oculto */
            background: linear-gradient(135deg, #3498db, #2c3e50);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .weather-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .location {
            font-size: 24px;
            font-weight: 600;
        }
        
        .temp {
            font-size: 48px;
            font-weight: 300;
        }
        
        .description {
            font-size: 20px;
            margin-bottom: 20px;
            text-transform: capitalize;
        }
        
        .details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        
        .detail-item {
            background: rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 5px;
        }
        
        .detail-label {
            font-size: 14px;
            opacity: 0.8;
        }
        
        .detail-value {
            font-size: 18px;
            font-weight: 500;
        }
        
        .error-message {
            background: #e74c3c;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
            text-align: center;
            display: none;
        }
        
        .info-message {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
            text-align: center;
            color: #7f8c8d;
        }
        
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
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
        <h1>🌤️ Detector de Clima NextWork</h1>
        
        <div class="search-box">
            <form method="get">
                <input type="text" name="city" id="cityInput" placeholder="Ingresa una ciudad (ej. Madrid, Buenos Aires)">
                <input type="submit" value="Buscar Clima">
            </form>
        </div>
        
        <!-- Mensaje de información inicial -->
        <div class="info-message" id="infoMessage">
            Ingresa el nombre de una ciudad para consultar el clima actual
        </div>
        
        <!-- Tarjeta de resultados del clima -->
        <div class="weather-card" id="weatherCard">
            <div class="weather-header">
                <div>
                    <div class="location" id="location">Ciudad, País</div>
                    <div class="description" id="description">Descripción</div>
                </div>
                <div class="temp" id="temperature">0°C</div>
            </div>
            
            <div class="details">
                <div class="detail-item">
                    <div class="detail-label">Sensación Térmica</div>
                    <div class="detail-value" id="feelsLike">0°C</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Humedad</div>
                    <div class="detail-value" id="humidity">0%</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Mínima</div>
                    <div class="detail-value" id="tempMin">0°C</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Máxima</div>
                    <div class="detail-value" id="tempMax">0°C</div>
                </div>
            </div>
        </div>
        
        <!-- Mensaje de error -->
        <div class="error-message" id="errorMessage"></div>
        
        <a href="index.jsp" class="back-link">← Volver al inicio</a>
    </div>
    
    <script>
        // Procesar los datos del servidor y mostrarlos en la interfaz
        window.onload = function() {
            const weatherData = <%= request.getAttribute("weatherData") != null ? 
                                request.getAttribute("weatherData") : "null" %>;
            const error = "<%= request.getAttribute("error") != null ? 
                         request.getAttribute("error") : "" %>";
            const searchedCity = "<%= request.getParameter("city") != null ? 
                                request.getParameter("city") : "" %>";
            
            // Mostrar ciudad buscada en el input
            if(searchedCity) {
                document.getElementById("cityInput").value = searchedCity;
            }
            
            // Manejar errores
            if(error) {
                document.getElementById("infoMessage").style.display = "none";
                document.getElementById("errorMessage").innerText = error;
                document.getElementById("errorMessage").style.display = "block";
                return;
            }
            
            // Mostrar datos del clima si existen
            if(weatherData && weatherData !== "null") {
                try {
                    const data = JSON.parse(weatherData);
                    
                    document.getElementById("infoMessage").style.display = "none";
                    document.getElementById("weatherCard").style.display = "block";
                    
                    // Actualizar la interfaz con los datos
                    document.getElementById("location").textContent = 
                        `${data.name}, ${data.sys.country}`;
                    document.getElementById("temperature").textContent = 
                        `${Math.round(data.main.temp)}°C`;
                    document.getElementById("description").textContent = 
                        data.weather[0].description;
                    document.getElementById("feelsLike").textContent = 
                        `${Math.round(data.main.feels_like)}°C`;
                    document.getElementById("humidity").textContent = 
                        `${data.main.humidity}%`;
                    document.getElementById("tempMin").textContent = 
                        `${Math.round(data.main.temp_min)}°C`;
                    document.getElementById("tempMax").textContent = 
                        `${Math.round(data.main.temp_max)}°C`;
                    
                } catch(e) {
                    console.error("Error parsing weather data:", e);
                }
            }
        };
    </script>
</body>
</html>