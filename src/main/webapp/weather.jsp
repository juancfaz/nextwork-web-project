<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Detector de Clima</title>
    <style>
        .weather-container { margin: 20px; padding: 20px; border: 1px solid #ccc; }
        .error { color: red; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h1>Detector de Clima</h1>
    
    <form method="get">
        Ciudad: <input type="text" name="city" value="${fn:escapeXml(searchedCity)}">
        <input type="submit" value="Buscar">
    </form>
    
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    
    <c:if test="${not empty weatherData}">
        <div class="weather-container">
            <h2>Clima en ${fn:escapeXml(searchedCity)}</h2>
            <pre>${weatherData}</pre>
        </div>
    </c:if>
    
    <c:if test="${empty weatherData and empty error and empty searchedCity}">
        <p class="info">Ingresa una ciudad para consultar el clima</p>
    </c:if>
    
    <p><a href="${pageContext.request.contextPath}/">Volver al inicio</a></p>
</body>
</html>