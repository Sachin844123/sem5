package com.example;

import java.io.IOException; 
import java.io.PrintWriter; 
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
 
@WebServlet("/CalculatorServlet") 
public class CalculatorServlet extends HttpServlet { 
    @Override 
    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response) 
            throws ServletException, IOException { 
 
        response.setContentType("text/html"); 
        PrintWriter out = response.getWriter(); 
        double num1 = Double.parseDouble(request.getParameter("num1")); 
        double num2 = Double.parseDouble( 
                request.getParameter("num2")); 
        String operation = request.getParameter("operation"); 
        double result = 0; 
 
        if (operation.equals("add")) { 
            result = num1 + num2; 
        } else if (operation.equals("sub")) { 
            result = num1 - num2; 
} 
else if (operation.equals("mul")) { 
result = num1 * num2; 
}
else if (operation.equals("div")) { 
if (num2 == 0) { 
out.println("<h2>Cannot divide by zero</h2>"); 
return; 
} 
result = num1 / num2; 
} 
out.println("<html>"); 
out.println("<head>"); 
out.println("<title>Calculator Result</title>"); 
out.println("</head>"); 
out.println("<body>"); 
out.println("<h2>Calculator Result</h2>"); 
out.println("<p>First Number: " + num1 + "</p>"); 
out.println("<p>Second Number: " + num2 + "</p>"); 
out.println("<p>Result: " + result + "</p>"); 
out.println("<br>"); 
out.println("<a href='index.html'>Back to Calculator</a>"); 
out.println("</body>"); 
out.println("</html>"); 
} 
}
