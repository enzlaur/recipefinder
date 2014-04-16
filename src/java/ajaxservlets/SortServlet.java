/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ajaxservlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import sortingalgo.SortHelper;

/**
 *
 * @author paulo
 */
public class SortServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        
        try {
            
            HttpSession session = request.getSession();
            ArrayList recipeList = (ArrayList) session.getAttribute("recipe");
            int sortType = Integer.parseInt(request.getParameter("s").toString()); // data s
            SortHelper sortHelper = new SortHelper(sortType); // sortType to sorthelper to choose what kind of sort
            JSONObject json = new JSONObject();
            
            
            ArrayList sortedlist = sortHelper.merge_sort(recipeList);
            json.put("result", sortedlist);
            out.print(json);
        } catch (JSONException ex) {
            Logger.getLogger(SortServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {            
            out.close();
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
