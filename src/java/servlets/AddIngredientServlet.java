/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DatabaseTransactions.IngredientsDataContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import validation.ValidationStateRecipe;

/**
 *
 * @author cheskaalindao
 */
public class AddIngredientServlet extends HttpServlet {

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
        
        String purpose = request.getParameter("purpose");
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet result = null;
        
        if (purpose.equals("validate-ingredient")) {
            String name = request.getParameter("name");
            response.setStatus(200);
            response.setContentType("text/json;charset=UTF-8");
            response.getWriter().write("{\"message\": \"" + getNameValidation(name) + "\"}");

        }
        else if (purpose.equals("add-ingredient")) {
            int category = Integer.parseInt(request.getParameter("category"));
            String name = request.getParameter("name");
            
            ValidationStateRecipe validation = new ValidationStateRecipe();
            validation.addError("name", getNameValidation(name));
            
            String statusJSON = "";
            String dataJSON = "";
            
             if (validation.isValid()) {
                //to do save
                IngredientsDataContext.addIngredient(name, category);
                statusJSON = "success";
                dataJSON = "\"Successfully added an ingredient.\"";
            } else {
                validation.setErrorSummary("Can't add ingredient. Fix errors");
                statusJSON = "failed";
                dataJSON = validation.getJSON();
            }

            String responseJSON = "{"
                    + "\"status\" :\"" + statusJSON + "\","
                    + "\"data\" :" + dataJSON + ""
                    + "}";

            response.setContentType("text/json;charset=UTF-8");
            response.getWriter().write(responseJSON);
        }
     
    }
    
    public String getNameValidation(String name) {
        if (name.equals("")) {
            return "Required";
        } 
        else if(IngredientsDataContext.isIngredientExists(name)){
            return "Ingredient already exists";
        }
        else {
            return "";
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
