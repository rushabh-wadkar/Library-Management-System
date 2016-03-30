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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rushabh
 */
public class validate_requests extends HttpServlet {

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
            
            String red_status = request.getParameter("req");
            
            if(red_status!=null)
            {
                try(Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root"))
                {
                    RequestDispatcher redirect = request.getRequestDispatcher("requests.jsp");
                    
                    Statement st = con.createStatement();
                    
                    String temp[] = red_status.split("#");
                    String dec = temp[0];
                    String ukey = temp[1];
                    
                    // for splitting ukey to get the bookname and publisher name
                    String temp1[] = ukey.split(":");
                    String bname = temp1[1];
                    String pname = temp1[2];
                    
                    if(dec.equalsIgnoreCase("GRANT"))
                    {
                       SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        Calendar c = Calendar.getInstance();
                        SimpleDateFormat formatter= new SimpleDateFormat("dd/MM/yyyy");
                        String dateIssue = formatter.format(c.getTime());             //Todays Date is saved here.
                        
                        c.setTime(new Date()); // Now use today date.
                        c.add(Calendar.DATE, 7); // Adding 7 days
                        String dateExpire = sdf.format(c.getTime());                    //Contains the expiry date.
                        
                        String query = "UPDATE ROOT.\"Transact\" SET ISSUEDATE='"+dateIssue+"', EXPIRYDATE='"+dateExpire+"', STATUS='A' WHERE UKEY='"+ukey+"'";
                        String updateQuantityQuery = "UPDATE ROOT.\"BOOKS\" SET QUANTITY = QUANTITY - 1 WHERE BOOKNAME='"+bname+"' AND PUBLISHERNAME='"+pname+"'";
                        
                        int rs = st.executeUpdate(query);
                        if(rs==1)
                        {
                            int rs1 = st.executeUpdate(updateQuantityQuery);
                            if(rs1==1)
                            {
                                request.setAttribute("st", "success");
                                redirect.forward(request, response);
                            }
                            else
                            {
                                request.setAttribute("st", "error");
                                redirect.forward(request, response);
                            }
                        }
                        else
                        {
                            request.setAttribute("st", "error");
                            redirect.forward(request, response);
                        }
                        
                    }
                    if(dec.equalsIgnoreCase("REVOKE"))
                    {
                        String query = "DELETE FROM ROOT.\"Transact\" WHERE UKEY='"+ukey+"'";
                        int rs = st.executeUpdate(query);
                        if(rs==1)
                        {
                            request.setAttribute("st", "success");
                            redirect.forward(request, response);
                        }
                        else
                        {
                            request.setAttribute("st", "error");
                            redirect.forward(request, response);
                        }
                    }
                    if(dec.equalsIgnoreCase("RETURN"))
                    {
                        String query = "SELECT * FROM ROOT.\"RETURN_TRANSACTION\" WHERE UKEY='"+ukey+"'";
                        ResultSet rs = st.executeQuery(query);
                        if(rs.next())
                        {
                            
                            String issueRequest = rs.getString("RETURNREQUEST");
                            String expiryRequest = rs.getString("EXOIRYDATE");
                            SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
                            
                            String query1 = "DELETE FROM ROOT.\"RETURN_TRANSACTION\" WHERE UKEY='"+ukey+"'";
                            
                            int rs1 = st.executeUpdate(query1);
                            if(rs1==1)
                            {
                                
                                String updateQuantityQuery = "UPDATE ROOT.\"BOOKS\" SET QUANTITY = QUANTITY + 1 WHERE BOOKNAME='"+bname+"' AND PUBLISHERNAME='"+pname+"'";
                                
                                int rs2 = st.executeUpdate(updateQuantityQuery);
                                if(rs2==1)
                                {
                                    try {
                                        Date date1 = myFormat.parse(issueRequest);
                                        Date date2 = myFormat.parse(expiryRequest);
                                        long diff = date2.getTime() - date1.getTime();
                                        long calc_days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
                                        long calc_fine = 0;
                                        if(calc_days<0)
                                        {
                                            calc_fine = Math.abs(calc_days) * 10;
                                        }
                                        String redirectInfo = ukey + ":" + issueRequest + ":" + expiryRequest + ":" + calc_fine;
                                        request.setAttribute("info", redirectInfo);
                                        RequestDispatcher rd1 = request.getRequestDispatcher("displayFine.jsp");
                                        rd1.forward(request, response);
                                    } catch (ParseException e) {
                                    e.printStackTrace();
                                }
                                }
                                    else
                                    {
                                            out.println("Error in updating quantity");
                                            }
                                    
                                
                            }
                            
                        }
                        
                    }
                }
                catch(Exception e)
                {
                    out.println(e);
                }
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
