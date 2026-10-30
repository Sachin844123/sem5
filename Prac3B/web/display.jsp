<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Student Details</title>
    </head>

    <body>

        <h1>Student Details</h1>

        <%
            String name = request.getParameter("name");
            String age = request.getParameter("age");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");

            String[] hobbies =
                    request.getParameterValues("hobby");
        %>

        <b>Name:</b>
        <%= name %>

        <br><br>

        <b>Age:</b>
        <%= age %>

        <br><br>

        <b>Email:</b>
        <%= email %>

        <br><br>

        <b>Gender:</b>
        <%= gender %>

        <br><br>

        <b>Hobbies:</b>

        <%
            if (hobbies != null) {

                for (String hobby : hobbies) {
                    out.println(hobby + " ");
                }
            }
        %>

        <br><br>

        <a href="index.jsp">Back</a>

    </body>
</html>