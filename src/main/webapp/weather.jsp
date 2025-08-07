<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Clima en ${param.city}</title>
    <style>
        .weather-container { margin: 20px; padding: 20px; border: 1px solid #ccc; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Detector de Clima</h1>
    
    <form method="get">
        Ciudad: <input type="text" name="city" value="${param.city}">
        <input type="submit" value="Buscar">
    </form>
    
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    
    <c:if test="${not empty weatherData}">
        <div class="weather-container">
            <h2>Clima en ${fn:escapeXml(param.city)}</h2>
            <pre>${weatherData}</pre>
            <p>Para una vista más bonita, podríamos parsear el JSON y mostrar los datos formateados.</p>
        </div>
    </c:if>
    
    <p><a href="/nextwork-web-project/">Volver al inicio</a></p>
</body>
</html>