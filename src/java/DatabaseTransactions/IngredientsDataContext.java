/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseTransactions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import settings.Database;
/**
 *
 * @author cheskaalindao
 */
public class IngredientsDataContext {
    static Connection con = null;
    static PreparedStatement statement = null;
    static ResultSet result = null;
    
    public static ResultSet getIngredientList(String keyword, int page, int pageSize){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            
            String selectSql = "select i.*, ic.`name` as category  " +
                "from `ingredient` as i " +
                "inner join `ingredient_category` as ic " +
                "on i.id_category = ic.id " + 
                "where i.`name` like concat('%', ?, '%') " + 
                "order by i.`name` asc " + 
                "limit ? offset ?";
            
            /* get results */
            statement = con.prepareStatement(selectSql);    
            
            statement.setString(1, keyword);
            statement.setInt(2, pageSize);
            statement.setInt(3, (page - 1) * pageSize);
            
            result = statement.executeQuery();           
            
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
    }
    
    public static int getIngredientListCount(String keyword){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            
            String countSql = "select count(id) as totalRecords from `ingredient` where `name` like concat('%', ?, '%') ";
            
            /* get results */
            statement = con.prepareStatement(countSql);    
            
            statement.setString(1, keyword);
            
            result = statement.executeQuery();           
            
            int count = 0;
            if(result.next()){
                count = result.getInt("totalRecords");
            }
            
            return count;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return 0;
        }
    }
    
    public static ResultSet getAllIngredients(String keyword){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);

            statement = con.prepareStatement("select i.id, i.name as ingredient, ic.name as category "+
                                            "from ingredient as i "+
                                            "inner join ingredient_category as ic "+
                                            "on i.id_category = ic.id "+
                                            "where i.name like ?");    

            statement.setString(1, "%" + keyword + "%");

            result = statement.executeQuery();           
            
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
    }
    
    public static ResultSet getAllCategories(){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);

            statement = con.prepareStatement("select * from ingredient_category");    
            result = statement.executeQuery();           
            
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
    }
    
    public static void addIngredient(String ingredient, int category){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);

            statement = con.prepareStatement("insert into ingredient(`name`, `id_category`) values(?, ?)");    

            statement.setString(1, ingredient);
            statement.setInt(2, category);

            statement.executeUpdate();           
            
        }
        catch(Exception ex){
        }
    }
    
    public static boolean isIngredientExists(String name) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            statement = con.prepareStatement("SELECT name FROM `ingredient` where name = ?");
            statement.setString(1, name);
            result = statement.executeQuery();

            if (result.next()) {
                return true;
            } else {
                return false;
            }

        } catch (Exception ex) {
            return false;
        }
    }
    
    public static ResultSet getIngredientToEdit(int id){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);

            statement = con.prepareStatement("select i.name as ingredient, ic.id, ic.name as category "+
                                            "from ingredient as i "+
                                            "inner join ingredient_category as ic "+
                                            "on i.id_category = ic.id "+
                                            "where i.id = ? ");    

            statement.setInt(1, id);
            result = statement.executeQuery();           
            
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
    }
    
    public static void editIngredient(String ingredient, int category, int id){        
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);

            statement = con.prepareStatement("update ingredient set name = ?, id_category = ? where id = ?");    

            statement.setString(1, ingredient);
            statement.setInt(2, category);
            statement.setInt(3, id);

            statement.executeUpdate();           
            
        }
        catch(Exception ex){
        }
    }
    
    public static void deleteIngredient(int id) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            statement = con.prepareStatement("DELETE from ingredient where id = ?");
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception ex) {
        }
    }
    
    
    
}
