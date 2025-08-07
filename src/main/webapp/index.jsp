<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>NextWork - Aplicación Web</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 40px;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .feature-box {
            background: white;
            padding: 15px;
            margin: 15px 0;
            border-left: 4px solid #3498db;
        }
        .btn {
            display: inline-block;
            background: #3498db;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
        }
        .btn:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenido a NextWork</h1>
        
        <div class="feature-box">
            <h2>Aplicación Web Integrada</h2>
            <p>Esta aplicación demuestra un pipeline completo de CI/CD con:</p>
            <ul>
                <li>Integración continua con GitHub</li>
                <li>Build automatizado con AWS CodeBuild</li>
                <li>Despliegue continuo con AWS CodeDeploy</li>
            </ul>
        </div>
        
        <div class="feature-box">
            <h2>Servicio de Clima Integrado</h2>
            <p>Consulta el clima actual de cualquier ciudad usando nuestra integración con OpenWeatherMap API.</p>
            <a href="weather" class="btn">Probar el Detector de Clima</a>
        </div>
        
        <div class="feature-box">
            <h2>Estado del Sistema</h2>
            <p><strong>Último despliegue:</strong> ${pageContext.servletContext.serverInfo}</p>
            <p><strong>Versión:</strong> 1.0.0</p>
        </div>
    </div>
</body>
</html>