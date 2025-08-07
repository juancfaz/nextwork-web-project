<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Clima en ${not empty param.city ? param.city : 'ciudad desconocida'}</title>
    <style>
        .weather-container { margin: 20px; padding: 20px; border: 1px solid #ccc; }
        .error { color: red; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h1>Detector de Clima</h1>
    
    <form method="get">
        Ciudad: <input type="text" name="city" value="${fn:escapeXml(param.city)}">
        <input type="submit" value="Buscar">
    </form>
    
    <c:if test="${not empty error}">
        <div class="error">
            <h3>Error:</h3>
            <p>${fn:escapeXml(error)}</p>
            <p>Por favor intenta con otra ciudad o prueba más tarde.</p>
        </div>
    </c:if>
    
    <c:if test="${empty error and empty weatherData}">
        <div class="info">
            <p>Ingresa una ciudad para ver el clima actual.</p>
        </div>
    </c:if>
    
    <c:if test="${not empty weatherData}">
        <div class="weather-container">
            <h2>Clima en ${fn:escapeXml(param.city)}</h2>
            <pre>${fn:escapeXml(weatherData)}</pre>
        </div>
    </c:if>
    
    <p><a href="${pageContext.request.contextPath}/">Volver al inicio</a></p>
</body>
</html>