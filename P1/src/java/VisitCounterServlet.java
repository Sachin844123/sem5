/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;


/**
 *
 * @author Vashishta
 */
@WebServlet(urlPatterns = {"/VisitCounterServlet"})
public class VisitCounterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
         int count = 0; 
        Cookie[] cookies = request.getCookies(); 
        if (cookies != null) { 
            for (Cookie cookie : cookies) { 
                if (cookie.getName().equals("visitCount")) { 
                    count = Integer.parseInt(cookie.getValue()); 
                } 
            } 
        } 
        count++; 
        Cookie visitCookie = 
                new Cookie("visitCount", String.valueOf(count)); 
        visitCookie.setMaxAge(24 * 60 * 60); 
        response.addCookie(visitCookie); 
        out.println("<html>"); 
        out.println("<body>"); 
        out.println("<h2>Cookie Visit Counter</h2>"); 
        out.println("<h3>You have visited this Servlet " 
                + count + " time(s).</h3>"); 
        out.println("</body>"); 
        out.println("</html>");
        }
    }

   