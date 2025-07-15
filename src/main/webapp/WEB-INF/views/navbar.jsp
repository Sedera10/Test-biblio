<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar text-center">
        <a class="sidebar-brand d-flex align-items-center justify-content-center mb-3" href="#">
            <img src="${pageContext.request.contextPath}/resources/img/logo.jpg" alt="Logo" style="height: 40px; margin-right: 0.5rem;  border-radius: 50%;">
            <span class="align-middle">
                <span style="color: #363753;">BIBLIO</span>-<span style="color: #5CD2C6;">TECHNO</span>
            </span>
        </a>
        <!-- Prêts -->

        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Tableau de bord
            </li>
            <c:if test="${not empty sessionScope.admin}">
                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <span class="align-middle">Dashboard</span>
                    </a>
                </li>
            </c:if>
            <li class="sidebar-header">
                Gestion de prêt
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/pret/liste">
                    <span class="align-middle">Liste des prêts<table></table></span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/pret/form">
                    <span class="align-middle">Prêter un livre</span>
                </a>
            </li>
        </ul>

        <!-- Reservations -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Reservations
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/reservation/liste">
                    <span class="align-middle">Liste des reservations</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/reservation/form">
                    <span class="align-middle">Reserver un livre</span>
                </a>
            </li>
        </ul>

        <!-- Livres -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Gestion des livres
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/livres/liste">
                    <span class="align-middle">Liste de livre</span>
                </a>
            </li>
            <c:if test="${not empty sessionScope.admin}">
                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/livres/ajouter">
                        <span class="align-middle">Nouveau livre</span>
                    </a>
                </li>
            </c:if>
        </ul>

        <!-- Ressources Humaines -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Ressources Humaines
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/adherent/liste">
                    <span class="align-middle">Les membres</span>
                </a>
            </li>
            
            <c:if test="${not empty sessionScope.admin}">
                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/signin">
                        <span class="align-middle">Nouvel adherent</span>
                    </a>
                </li>
            </c:if>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/adherent/reinscription">
                    <span class="align-middle">Réabonnement</span>
                </a>
            </li>
        </ul>

        <!-- Administration -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Administration
            </li>
            <c:if test="${not empty sessionScope.admin}">
                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/config">
                        <span class="align-middle">Configuration</span>
                    </a>
                </li>
            </c:if>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/logout">
                    <span class="align-middle">Se deconnecter</span>
                </a>
            </li>
        </ul>
    </div>
</nav>