<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display Details</title>
</head>
<body>
    <h2>Entered Details</h2>
    <%
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String[] hobbies = request.getParameterValues("hobby");

        if (name == null || name.trim().isEmpty() ||
            age == null || age.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            gender == null) {
            out.println("<h3>Invalid Input!</h3>");
        } else {
    %>
            Name: <%= name %><br><br>
            Age: <%= age %><br><br>
            Hobbies:
            <%
                if (hobbies != null) {
                    for (String hobby : hobbies) {
                        out.println(hobby + " ");
                    }
                } else {
                    out.println("No hobby selected");
                }
            %>
            <br><br>
            Email: <%= email %><br><br>
            Gender: <%= gender %>
    <% } %>
</body>
</html>
