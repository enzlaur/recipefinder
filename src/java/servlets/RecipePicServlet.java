/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import settings.Database;

/**
 *
 * @author cheskaalindao
 */
public class RecipePicServlet extends HttpServlet {

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
        
        List<FileItem> image = null;

        try {
            image = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
        } catch (Exception ex) {
            response.getWriter().write("error");
        }
        
        String image_name = "";
        String fileExtension = "";
        Boolean status_sql = false;
        Boolean status_file = false;

        int id = Integer.parseInt(request.getParameter("id"));

        Connection con = null;
        PreparedStatement statement = null;
        ResultSet result = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            if (request.getParameter("upload-type").matches("recipe-pic")) {
                statement = con.prepareStatement("select id as filename from recipe where id=?");
                statement.setInt(1, id);
            }
            
            result = statement.executeQuery();
            result.next();
            image_name = result.getString("filename") + '.';
            
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }

        for (FileItem item : image) {
            if (item.isFormField()) {
                //caption = item.getFieldName();
            } else {

                fileExtension = FilenameUtils.getExtension(item.getName());
                fileExtension = fileExtension.toLowerCase();
                image_name = image_name + fileExtension;
                
                 if(fileExtension.equals("png") || fileExtension.equals("jpg") || fileExtension.equals("gif") || fileExtension.equals("jpeg")){
                    try {
                        File image_file = null;
                        if (request.getParameter("upload-type").matches("recipe-pic")) {
                            image_file = new File(getServletContext().getRealPath("/") + "\\images\\recipe", image_name);
                        }
                        item.write(image_file);
                        status_file = true;
                    } catch (Exception ex) {
                        //Logger.getLogger(FileUploaderServlet.class.getName()).log(Level.SEVERE, null, ex);
                        status_file = false;
                    }
                 }
            }
        }

        if (image_name.equals("")) {
            response.sendRedirect("admin-edit-recipe.jsp?id=" + id);
        } else {
            if(fileExtension.equals("png") || fileExtension.equals("jpg") || fileExtension.equals("gif") || fileExtension.equals("jpeg")){
                try {
                    response.getWriter().write(request.getParameter("upload-type"));
                    if (request.getParameter("upload-type").matches("recipe-pic")) {
                        statement = con.prepareStatement("UPDATE recipe SET "
                                + "picture = ? "
                                + "WHERE id=?");
                        statement.setString(1, image_name);
                        statement.setInt(2, id);     
                    } 

                    int rows = statement.executeUpdate();

                    if (rows > 0) {
                        status_sql = true;
                    } else {
                        status_sql = false;
                    }

                    if (status_sql == true && status_file == true) {
                        response.sendRedirect("admin-edit-recipe.jsp?id=" + id + "&status=true");
                    } else if (status_sql == false || status_file == false) {
                        response.sendRedirect("admin-edit-recipe.jsp?id=" + id + "&status=false");
                    }

                } catch (Exception ex) {
                    response.getWriter().write(ex.getMessage());
                }
            }else{
                response.sendRedirect("admin-edit-recipe.jsp?id=" + id + "&status=false");
            }
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
