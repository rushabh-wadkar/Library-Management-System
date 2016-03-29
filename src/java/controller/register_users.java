/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rushabh
 */
public class register_users extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String temp1 = request.getParameter("fname");
        
            String temp2 = request.getParameter("lname");
        
            String name = temp1+" "+temp2;
            name = name.toLowerCase();
            int fine = 0;
            String password = request.getParameter("pass");
            String gender = request.getParameter("Gender");
            String contact = request.getParameter("contact");
            String birthDay = request.getParameter("Day");
            String birthMonth = request.getParameter("Month");
            String birthYear = request.getParameter("year");
            String birth = birthDay + "/" + birthMonth + "/" + birthYear;
            String contactNumber = request.getParameter("contact");

            String url = "jdbc:derby://localhost:1527/library";
            String user_name = "root";
            String pass_word = "root";
            try(Connection con = DriverManager.getConnection(url, user_name, pass_word))
            {
                Statement st1 = con.createStatement();
                int rs = st1.executeUpdate("insert into ROOT.\"users\"(USERNAME,PASSWORD,FINE,GENDER,CONTACT,BIRTH) values"
                        + "('"+name+"','"+password+"',"+fine+",'"+gender+"','"+contactNumber+"','"+birth+"')");

                if(rs==1)
                {
                        request.setAttribute("success", "suc");
                        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                        rd.forward(request, response);
                }
                else
                {
                    request.setAttribute("success", "err");
                    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                    rd.forward(request, response);
                }

            }
            catch(Exception e)
            {
                request.setAttribute("success", "err");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            }
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
