<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Student Details</title>

        <script>
            function validateForm() {

                var name = document.getElementById("name").value;
                var age = document.getElementById("age").value;
                var email = document.getElementById("email").value;

                // Validate Name
                if (name == "") {
                    alert("Please enter Name");
                    return false;
                }

                // Validate Age
                if (age == "" || age < 1 || age > 100) {
                    alert("Please enter valid Age");
                    return false;
                }

                // Validate Email
                var pattern =
                    /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (!pattern.test(email)) {
                    alert("Please enter valid Email");
                    return false;
                }

                // Validate Gender
                var gender =
                    document.querySelector(
                        'input[name="gender"]:checked'
                    );

                if (gender == null) {
                    alert("Please select Gender");
                    return false;
                }

                // Validate Hobbies
                var hobbies =
                    document.querySelectorAll(
                        'input[name="hobby"]:checked'
                    );

                if (hobbies.length == 0) {
                    alert("Please select at least one Hobby");
                    return false;
                }

                return true;
            }
        </script>

    </head>

    <body>

        <h1>Student Registration Form</h1>

        <form action="display.jsp" method="post" onsubmit="return validateForm()">

            Name:
            <input type="text" id="name" name="name">

            <br><br>

            Age:
            <input type="number" id="age" name="age">

            <br><br>

            Email:
            <input type="text" id="email" name="email">

            <br><br>

            Gender:

            <input type="radio" name="gender" value="Male">
            Male

            <input type="radio" name="gender" value="Female">
            Female

            <br><br>

            Hobbies:

            <input type="checkbox" name="hobby" value="Reading">
            Reading

            <input type="checkbox" name="hobby" value="Sports">
            Sports

            <input type="checkbox" name="hobby" value="Gaming">
            Gaming

            <br><br>

            <input type="submit" value="Submit">

        </form>

    </body>
</html>