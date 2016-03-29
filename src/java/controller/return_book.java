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
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rushabh
 */
public class return_book extends HttpServlet {

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
            String username = request.getParameter("username");
            String BookName = request.getParameter("books");
            String ukey = username + ":" + BookName;
            
            
            try(Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root"))
            {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        Calendar c = Calendar.getInstance();
                        SimpleDateFormat formatter= new SimpleDateFormat("dd/MM/yyyy");
                        String dateReturn = formatter.format(c.getTime());             //Todays Date is saved here.
                    
                String query2 = "SELECT * FROM ROOT.\"Transact\" WHERE UKEY='"+ukey+"'";
                String query1 = "DELETE FROM ROOT.\"Transact\" WHERE UKEY='"+ukey+"'";
                
                
                Statement st = con.createStatement();
                
                ResultSet rs1 = st.executeQuery(query2);
                if(rs1.next())
                {
                    String expiryDate = rs1.getString("EXPIRYDATE");
                    int rs = st.executeUpdate(query1);
                    if(rs==1)
                    {
                        String query = "INSERT INTO ROOT.\"RETURN_TRANSACTION\"(USERNAME, BOOKNAME, UKEY,EXOIRYDATE,RETURNREQUEST) VALUES('"+username+"','"+BookName+"','"+ukey+"','"+expiryDate+"','"+dateReturn+"')";                        rs = st.executeUpdate(query);
                        if(rs==1)
                        {
                            request.setAttribute("status","success");
                            RequestDispatcher rd = request.getRequestDispatcher("returnBook.jsp");
                            rd.forward(request, response);
                        }else
                        {
                            out.println("Error");
                        }
                    }
                }
                else
                {
                    out.println("No book found");
                }
                
                
                        
            }
            catch(Exception e)
            {
                request.setAttribute("status","Error");
                    RequestDispatcher rd = request.getRequestDispatcher("returnBook.jsp");
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
