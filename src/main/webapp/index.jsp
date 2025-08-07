<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>NextWork - Clima</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>Bienvenido a NextWork!</h2>
<p>Consulta el clima de cualquier ciudad</p>

<div>
    <input type="text" id="city" placeholder="Ingresa una ciudad">
    <button onclick="getWeather()">Consultar Clima</button>
</div>

<div id="weatherResult" style="margin-top: 20px;"></div>

<script>
function getWeather() {
    const city = $('#city').val();
    if (!city) {
        alert('Por favor ingresa una ciudad');
        return;
    }
    
    $.get('/api/weather/' + city, function(data) {
        if (data.error) {
            $('#weatherResult').html('<p style="color:red;">' + data.error + '</p>');
            return;
        }
        
        const html = `
            <h3>Clima en ${data.ciudad}, ${data.pais}</h3>
            <p>Temperatura: ${data.temperatura}°C</p>
            <p>Sensación térmica: ${data.sensacionTermica}°C</p>
            <p>Humedad: ${data.humedad}%</p>
            <p>Descripción: ${data.descripcion}</p>
        `;
        
        $('#weatherResult').html(html);
    }).fail(function() {
        $('#weatherResult').html('<p style="color:red;">Error al consultar el clima</p>');
    });
}
</script>
</body>
</html>