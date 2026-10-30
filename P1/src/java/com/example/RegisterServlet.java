/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example;

import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vashishta
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter(); 
 
        String username = request.getParameter("username"); 
        String password = request.getParameter("password"); 
        String email = request.getParameter("email"); 
        String country = request.getParameter("country"); 
        
        try { 
            // Load MySQL JDBC Driver 
            Class.forName("com.mysql.cj.jdbc.Driver"); 
 
            // Establish database connection 
            Connection con = DriverManager.getConnection( 
                    "jdbc:mysql://localhost:3306/demo?useSSL=false&allowPublicKeyRetrieval=true", 
                    "root", 
                    "password" 
            ); 
 
            // SQL query 
            String sql = "INSERT INTO registration " 
                    + "(username, password, email, country) " 
                    + "VALUES (?, ?, ?, ?)"; 
 
            // Create PreparedStatement 
            PreparedStatement ps = con.prepareStatement(sql); 
 
            ps.setString(1, username); 
            ps.setString(2, password); 
            ps.setString(3, email); 
            ps.setString(4, country); 
 
            // Execute query 
            int result = ps.executeUpdate(); 
 
            if (result > 0) { 
                out.println("<h2>Registration Successful</h2>"); 
            }  
            else { 
                out.println("<h2>Registration Failed</h2>"); 
            } 
            ps.close(); 
            con.close(); 
 
        } catch (Exception e) { 
            out.println("<h2>Error: " + e.getMessage() + "</h2>"); 
        }  
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
