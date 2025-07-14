<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --dark-blue: #363753;
            --light-gray: #DFE3EE;
            --pure-white: #FFFFFE;
            --teal: #5CD2C6;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color:#fcfcfc;
            background-image: url("${pageContext.request.contextPath}/resources/img/fond3.jpg");
            background-size: cover;         
            background-repeat: no-repeat;  
            background-position: center;
            background-attachment: fixed;
            color: var(--dark-blue);
        }
        
        /* Hero Section */
        .hero-section {
            padding: 8rem 0;
        }
        
        .hero-content {
            max-width: 600px;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            line-height: 1.2;
            color: #363753;
        }
        
        .hero-divider {
            border-top: 3px solid var(--teal);
            width: 100px;
            margin: 2rem 0;
        }
        
        .hero-text {
            font-size: 1.2rem;
            margin-bottom: 2.5rem;
            color: #363753;
            opacity: 0.8;
        }
        
        .hero-button {
            background-color: #5CD2C6;
            border: none;
            color: white;
            padding: 1rem 2.5rem;
            font-weight: 600;
            border-radius: 0.3rem;
            font-size: 1.1rem;
        }
        
        /* Image Container */
        .img-container {
            padding: 0.5em;
            height: 100%;
            min-height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        img{
            border-radius: 3.5em;
            box-shadow: 1px 0px 0px 4px #FFFFFE;
        }
    </style>
</head>
<body>
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="hero-content">
                        <h1 class="hero-title">Bienvenue sur <br><strong>BIBLIO-TECHNO</strong></h1>
                        
                        <p class="hero-text">Une solution moderne pour gérer vos prêts, réservations, pénalités et utilisateurs.<br>
                Explorez une bibliothèque intelligente, organisée et toujours accessible.</p>
                        
                        <a href="login">
                            <button class="hero-button">Get started</button>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="img-container">
                        <!-- Placeholder for your image -->
                        <img src="${pageContext.request.contextPath}/resources/img/fond2.jpg" alt="Marketing Image" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>