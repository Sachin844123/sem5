<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
</head>
<body>
    <h2>Registration Form</h2>
    <form action="display.jsp" method="post">
        Name: <input type="text" name="name" required><br><br>
        Age: <input type="number" name="age" min="1" max="100" required><br><br>
        Hobbies:
        <input type="checkbox" name="hobby" value="Reading"> Reading
        <input type="checkbox" name="hobby" value="Sports"> Sports
        <input type="checkbox" name="hobby" value="Music"> Music
        <br><br>
        Email: <input type="email" name="email" required><br><br>
        Gender:
        <input type="radio" name="gender" value="Male" required> Male
        <input type="radio" name="gender" value="Female"> Female
        <br><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
