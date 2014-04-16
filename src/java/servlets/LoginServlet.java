/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import settings.Database;

/**
 *
 * @author cheskaalindao
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet result = null;
       
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password); 
            statement = con.prepareStatement("SELECT id, username FROM `admin` WHERE username = ? AND password = ?");
            statement.setString(1, username);
            statement.setString(2, password);
            result = statement.executeQuery();
            
            if(result.next()){
                HttpSession session = request.getSession();
                session.setAttribute("id", result.getString("id"));
                session.setAttribute("username", result.getString("username"));
            }
            else{
                response.setStatus(403);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Either username or password is incorrect.");
            }

        }
        catch(Exception ex){
            response.sendError(500, ex.getMessage());
        }
        
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
