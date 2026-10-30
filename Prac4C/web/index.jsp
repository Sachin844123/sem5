<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>JSTL Example</title>
    </head>

    <body>

        <h1>JSTL Demonstration</h1>

        <!-- c:set -->
        <h2>1. c:set</h2>

        <c:set var="name" value="Vikas"/>
        <c:set var="age" value="21"/>

        Name: ${name}
        <br>

        Age: ${age}


        <!-- c:if -->
        <h2>2. c:if</h2>

        <c:if test="${age >= 18}">
            <p>You are eligible to vote.</p>
        </c:if>


        <!-- c:choose -->
        <h2>3. c:choose</h2>

        <c:choose>

            <c:when test="${age < 18}">
                You are a Minor.
            </c:when>

            <c:when test="${age >= 18 && age < 60}">
                You are an Adult.
            </c:when>

            <c:otherwise>
                You are a Senior Citizen.
            </c:otherwise>

        </c:choose>


        <!-- c:forEach -->
        <h2>4. c:forEach</h2>

        <c:forEach var="i" begin="1" end="5">

            Number: ${i}
            <br>

        </c:forEach>


        <!-- c:remove -->
        <h2>5. c:remove</h2>

        <c:set var="city" value="Ahmedabad"/>

        City before remove:
        ${city}

        <br>

        <c:remove var="city"/>

        City after remove:
        ${city}

    </body>
</html>