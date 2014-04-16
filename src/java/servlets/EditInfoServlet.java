/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DatabaseTransactions.EditRecipeDataContext;
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
public class EditInfoServlet extends HttpServlet {

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
        
        if (purpose.equals("edit")) {
            
            String recipeId = request.getParameter("recipe-id");
            String rname = request.getParameter("rname");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String serving = request.getParameter("serving");
            String time = request.getParameter("time");
            String procedures = request.getParameter("procedures");
            String mealType = request.getParameter("meal-type");
            String selectedMealType = request.getParameter("selected-meal-type");
            String cuisine = request.getParameter("cuisine");
            String selectedCuisine = request.getParameter("selected-cuisine");
            String[] ingredientQuantities = request.getParameterValues("ingredient-quantity");
            String[] ingredientIds = request.getParameterValues("ingredient-id");
            String[] ingredientDescriptions = request.getParameterValues("ingredient-description");
            
            System.out.println(mealType);
            
            ValidationStateRecipe validation = new ValidationStateRecipe();
            validation.addError("rname", getRecipeNameValidation(rname));
            validation.addError("price", getPriceValidation(price));
            validation.addError("serving", getServingValidation(serving));
            validation.addError("time", getTimeValidation(time));
            validation.addError("procedures", getProceduresValidation(procedures));
            validation.addError("ingredients", getIngredientsValidation(ingredientIds, ingredientQuantities, ingredientDescriptions));
            
            String statusJSON = "";
            String dataJSON = "";

            if (validation.isValid()) {
                //to do edit
            
                EditRecipeDataContext.editRecipe(recipeId, rname, description, price, serving, time, procedures,  ingredientIds, ingredientQuantities, ingredientDescriptions);
                EditRecipeDataContext.editRecipePreference(recipeId, selectedMealType, mealType); 
                EditRecipeDataContext.editRecipePreference(recipeId, selectedCuisine, cuisine); 
                
                statusJSON = "success";
                dataJSON = "\"Successfully edited information\"";
                
            } else {
           
                validation.setErrorSummary("Can't edit information. Fix errors");
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
    
    public String getRecipeNameValidation(String rname) {
        if (rname.equals("")) {
            return "Required";
        } else {
            return "";
        }
    }
    
    public String getPriceValidation(String price) {
        if (price.equals("")) {
            return "Required";
        } else {
            return "";
        }
    }
    
    public String getServingValidation(String serving) {
        if (serving.equals("")) {
            return "Required";
        } else {
            return "";
        }
    }
    
    public String getTimeValidation(String time) {
        if (time.equals("")) {
            return "Required";
        } else {
            return "";
        }
    }
    
    public String getProceduresValidation(String procedures) {
        if (procedures.equals("")) {
            return "Required";
        } else {
            return "";
        }
    }
    
    
    public String getIngredientsValidation(String[] ids, String[] quantities, String[] descriptions)
    {
        String error = "";
        if(ids != null){
            for(int index=0; index<ids.length; index++){
                if(ids[index].equals("")){
                    error = "Please select ingredient.";
                    break;
                }
            }
        }else{
            error = "Please add ingredients.";
        }
        
        return error;
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
