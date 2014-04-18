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
public class EditRecipeDataContext {
    
    static Connection con = null;
    static PreparedStatement statement = null;
    static ResultSet result = null;
    
     public static void editRecipe(String recipeId, String name, String description, String price,
            String serving, String time, String procedures,
            String[] ingredientIds, String[] ingredientQuantities, String[] ingredientDescriptions) {
        try {
            
            int id = Integer.parseInt(recipeId);
            float rprice = Float.parseFloat(price);
            
            Class.forName("com.mysql.jdbc.Driver");
            //con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            con = Database.getConnection();
            statement = con.prepareStatement("UPDATE recipe "
                    + "SET "
                    + "name = ?, "
                    + "description = ?, "
                    + "price = ?, "
                    + "serving = ?, "
                    + "time = ?, "
                    + "procedures = ? "
                    + "WHERE id = ?");
            
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setFloat(3, rprice);
            statement.setString(4, serving);
            statement.setString(5, time);
            statement.setString(6, procedures);
            statement.setInt(7, id);

            statement.executeUpdate();
            
            /*ingredients*/
            statement = con.prepareStatement("delete from `recipe_ingredient` where id_recipe = ?; ");
            statement.setInt(1, id);
            statement.executeUpdate();
            
            String valuesSql = "";
            for(int ctr=0; ctr<ingredientIds.length; ctr++){
                valuesSql += "(?, ?, ?, ?),";
            }

            valuesSql = valuesSql.substring(0, valuesSql.length() - 1);

            statement = con.prepareStatement
                    ("insert into `recipe_ingredient`" + 
                    "(id_recipe, id_ingredient, ingredient_qty, ingredient_info) " + 
                    " values" + valuesSql);
                    
            for(int ctr=0; ctr<ingredientIds.length; ctr++){
                statement.setInt((ctr * 4) + 1, id);
                statement.setInt((ctr * 4) + 2, Integer.parseInt(ingredientIds[ctr]));
                statement.setString((ctr * 4) + 3, ingredientQuantities[ctr]);
                statement.setString((ctr * 4) + 4, ingredientDescriptions[ctr]);
            }

            statement.executeUpdate();            
        } catch (Exception ex) {
        }
    }
     
    public static void editRecipePreference(String recipeId, String origPrefId, String newPrefId) {
        try {
            
            int id = Integer.parseInt(recipeId);
            int origPreferenceId = Integer.parseInt(origPrefId);
            int newPreferenceId = Integer.parseInt(newPrefId);
            
            Class.forName("com.mysql.jdbc.Driver");
            //con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            con = Database.getConnection();
            statement = con.prepareStatement("UPDATE recipe_preference "+
                                            "SET "+
                                            "id_preference = ? "+
                                            "WHERE id_recipe = ? and id_preference = ?");
            
            statement.setInt(1, newPreferenceId);
            statement.setInt(2, id);
            statement.setInt(3, origPreferenceId);

            statement.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    } 
   
    public static void deleteRecipe(int id) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            con = Database.getConnection();
            statement = con.prepareStatement("DELETE from recipe where id = ?");
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception ex) {
        }
    }
    
    public static void addRecipe(String name, String description, String price,
            String serving, String time, String procedures,
            String[] ingredientIds, String[] ingredientQuantities, String[] ingredientDescriptions, int mealType, int cuisine) {
        try {
            
            float rprice = Float.parseFloat(price);

            Class.forName("com.mysql.jdbc.Driver");
            //con = DriverManager.getConnection(Database.url, Database.username, Database.password);
            con = Database.getConnection();
            statement = con.prepareStatement("insert into `recipe`(name, price, serving, time, procedures, description) values(?,?,?,?,?,?)",
                    PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setString(1, name);
            statement.setFloat(2, rprice);
            statement.setString(3, serving);
            statement.setString(4, time);
            statement.setString(5, procedures);
            statement.setString(6, description);
            
            statement.executeUpdate();
            ResultSet generatedKeys = statement.getGeneratedKeys();
            if(generatedKeys.next()){
                int recipeId = generatedKeys.getInt(1);
                
                /*category - meal type and cuisine*/
                statement = con.prepareStatement("insert into recipe_preference (id_recipe, id_preference) values (?,?), (?,?)");
                statement.setInt(1, recipeId);
                statement.setInt(2, mealType);
                statement.setInt(3, recipeId);
                statement.setInt(4, cuisine);
                
                statement.executeUpdate();
                
                /*ingredients*/
                String valuesSql = "";
                for(int ctr=0; ctr<ingredientIds.length; ctr++){
                    valuesSql += "(?, ?, ?, ?),";
                }
                
                valuesSql = valuesSql.substring(0, valuesSql.length() - 1);
                
                statement = con.prepareStatement("insert into `recipe_ingredient`" + 
                        "(id_recipe, id_ingredient, ingredient_qty, ingredient_info) " + 
                        " values" + valuesSql);
                
                for(int ctr=0; ctr<ingredientIds.length; ctr++){
                    statement.setInt((ctr * 4) + 1, recipeId);
                    statement.setInt((ctr * 4) + 2, Integer.parseInt(ingredientIds[ctr]));
                    statement.setString((ctr * 4) + 3, ingredientQuantities[ctr]);
                    statement.setString((ctr * 4) + 4, ingredientDescriptions[ctr]);
                }
                
                statement.executeUpdate();
            }
                   
        } catch (Exception ex) {
        }
    }
    
}
