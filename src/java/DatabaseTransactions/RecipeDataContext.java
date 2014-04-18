/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseTransactions;

import settings.Database;
import classes.Categories;
import classes.Ingredient;
import classes.Recipe;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import settings.Database;
/**
 *
 * @author cheskaalindao
 */
public class RecipeDataContext {
    
    static PreparedStatement statement = null;
    static ResultSet result = null;
    
    private static String user = "root";
    private static String pass = "1234";
    private static final String host = "localhost";
    private static final String port = "3307";
    private static String url = "jdbc:mysql://" + host + ":" + port + "/recipe_finder";

    public static Connection connect() throws ClassNotFoundException, SQLException, URISyntaxException {
        Connection conn;
        Class.forName("com.mysql.jdbc.Driver");
        //conn = DriverManager.getConnection(url, user, pass);
        conn = Database.getConnection();
        return conn;
    }
    
    public static ResultSet getAllRecipes(){
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select * from recipe");
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }

    public static Recipe getRecipe(int id) throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select * from recipe where id=?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            if(result.next()){
                Recipe recipe = new Recipe(result.getInt("id"), result.getString("name"), result.getFloat("price"),
                        result.getInt("serving"), result.getString("time"), result.getString("procedures"),
                        result.getString("description"), result.getString("picture"));
                c.close();
                return recipe;
            }
            
        }
        catch(Exception ex){
            return null;
        }
        return null;
        
    }
    
    public static ArrayList<Ingredient> getRecipeIngredients(int id) throws SQLException, ClassNotFoundException, URISyntaxException{ //nag-add ako ng id sa select. old version of this has no id; added category
        ArrayList<Ingredient> ingredients = new ArrayList<Ingredient>();
        Connection c = connect();
        try{
            
            statement = c.prepareStatement("select i.id, ri.ingredient_qty, i.name, ri.ingredient_info, ic.name as category "+
                                            "from recipe_ingredient as ri "+
                                            "inner join ingredient as i "+
                                            "on ri.id_ingredient = i.id "+
                                            "inner join ingredient_category as ic "+
                                            "on ic.id = i.id_category "+
                                            "where id_recipe=? ");
            statement.setInt(1, id);
            result = statement.executeQuery();
            while(result.next()){
                Ingredient ingredient = new Ingredient(result.getInt("id"), result.getString("ingredient_qty"),
                        result.getString("name"), result.getString("ingredient_info"), result.getString("category"));
                ingredients.add(ingredient);
            }
        }
        
        catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return ingredients;
        
    }
    
    public static ArrayList<Recipe> getRecipeList(String search) throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Recipe> recipes = new ArrayList<Recipe>();
        Connection c = connect();
        try{
            
            
            statement = c.prepareStatement("select * "+
                                            "from recipe "+
                                            "where name like ? "+
                                            "order by name;");
            statement.setString(1, "%" + search + "%");
            result = statement.executeQuery();
            while(result.next()){
                Recipe recipe = new Recipe(result.getInt("id"), result.getString("name"), result.getFloat("price"),
                        result.getInt("serving"), result.getString("time"), result.getString("procedures"),
                        result.getString("description"), result.getString("picture"));
                recipes.add(recipe);
            }
        }
        
        catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return recipes;
        
    }
    
    public static ResultSet getPreference(int id, String type) throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select rp.id_recipe, p.name, p.id "+
                                            "from recipe_preference as rp "+
                                            "inner join preference as p "+
                                            "on rp.id_preference = p.id "+
                                            "where rp.id_recipe = ? and type = ? ");
            statement.setInt(1, id);
            statement.setString(2, type);
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }
    
    public static ResultSet getAllPreferences(String type) throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select * from preference where type = ?");
            statement.setString(1, type);
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }
    
    public static ResultSet selectedIngredientCategory(int idRecipe, int idIngredient) throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select i.id, ri.ingredient_qty, i.name, ri.ingredient_info, ic.name as category "+
                                            "from recipe_ingredient as ri "+
                                            "inner join ingredient as i "+
                                            "on ri.id_ingredient = i.id "+
                                            "inner join ingredient_category as ic "+
                                            "on i.id_category = ic.id "+
                                            "where ri.id_recipe = ? and i.id = ?");
            statement.setInt(1, idRecipe);
            statement.setInt(2, idIngredient);
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }
    
    public static ResultSet getAllCategories() throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select * from ingredient_category");
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }
    
    public static ResultSet getRecipeListByPage(String search) throws SQLException{
        try{
            
            Connection c = connect();
            statement = c.prepareStatement("select * "+
                                            "from recipe "+
                                            "where name like ? "+
                                            "order by name;");
            statement.setString(1, "%" + search + "%");
            result = statement.executeQuery();
            return result;
            
        }
        catch(Exception ex){
            return null;
        }
        
    }
    
    
    public static ArrayList<Recipe> getRecipeList (String specificIngredient, String ingredient, String price, String mealtype, String cuisine) throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Recipe> recipes = new ArrayList<Recipe>();
        Connection c = connect();
        
        String stmt = "select DISTINCT r.id, r.name, r.price, r.serving, r.time, r.procedures, r.description, r.picture\n" +
                                            "from recipe as r\n" +
                                            "inner join recipe_ingredient as ri \n" +
                                            "on r.id = ri.id_recipe\n" +
                                            "inner join ingredient as i\n" +
                                            "on ri.id_ingredient = i.id\n" +
                                            "inner join recipe_preference as rp\n" +
                                            "on r.id = rp.id_recipe\n" +
                                            "inner join preference as p\n" +
                                            "on rp.id_preference = p.id\n" +
                                            "where (price between ? and ?) and ";
            
            //MEALTYPE N CUISINE
            if(mealtype.equals("") && cuisine.equals("")){
               stmt += "(p.name in (select name from preference) ) and";
            }
            else if(!mealtype.isEmpty() || !cuisine.isEmpty()) {
               stmt += "(p.name in (?,?) ) and";
            }
            
           
            int filter = 0;
            //SPECIFIC INGREDIENT
            
            if(specificIngredient.equals("")){
                stmt+= " ";
            }
            else if(!specificIngredient.isEmpty()){
                if(!ingredient.isEmpty()){
                    stmt+= " ( ";
                }
                stmt+= " ( i.name LIKE ? )";
                filter++;
            }
            
            // INGREDIENTS
            String[] ingredientslist = ingredient.split(",");
            if(ingredient.equals("") && specificIngredient.isEmpty()){
                if (filter > 0){
                    stmt+= " or ";
                }
                stmt+= "(i.name in (select name from ingredient) )";
            }
            else if(ingredient.equals("") && !specificIngredient.isEmpty()){
                stmt+= " ";
            }
            else if(!ingredient.isEmpty()){
                if (filter > 0){
                    stmt+= " or ";
                }
                stmt+= "(i.name in (";
                for(int ctr = 1; ctr<= ingredientslist.length; ctr++){
                    
                    stmt+= "(?)";
                    
                    if(ctr != ingredientslist.length){
                        stmt+=",";
                    }
                }
                stmt+= " ) )";
                if(!specificIngredient.isEmpty()){
                    stmt+= " ) ";
                }
            }
            statement = c.prepareStatement(stmt); //tsaka mo lng i-prepare kapag ok na lahat sa query
            
        try{
            
            
            System.out.println(stmt);
            //System.out.print("length is " + ingredientslist.length+  " ");
            
            // setting of parameters
            //  setting of price
            ArrayList priceRange = separateString(price);
            statement.setString(1, priceRange.get(0).toString());
            statement.setString(2, priceRange.get(1).toString());
           // System.out.println(priceRange.get(0).toString() + " " + priceRange.get(1).toString() + " is price range");
            
            //set mealtype & cuisine
            if(!mealtype.isEmpty() || !cuisine.isEmpty()) {
                statement.setString(3, mealtype);
                statement.setString(4, cuisine);
                //System.out.println(mealtype + cuisine);
            }
            
            //set specific ingredient
            if(!specificIngredient.isEmpty()){
                if(!mealtype.isEmpty() || !cuisine.isEmpty()){
                    statement.setString(5, "%" + specificIngredient + "%");
                }else if (mealtype.isEmpty() || cuisine.isEmpty()){
                    statement.setString(3, "%" + specificIngredient + "%");
                }
            }
            
            //set ingredients
            if(!ingredient.isEmpty()){
                if((!mealtype.isEmpty() || !cuisine.isEmpty()) && specificIngredient.isEmpty()){
                    for( int ctr = 5; ctr < ingredientslist.length + 5; ctr++ ){
                        //System.out.println("LOL5");
                        //int tmp = ctr;
                        //int ans = tmp -5;
                        //int lengthofilist = ingredientslist.length + 5;
                        //System.out.println("ingredientslist[" + ans + "] is " + ingredientslist[ctr - 5].toString() + " " + tmp);
                        //System.out.println(lengthofilist);
                        statement.setString(ctr, ingredientslist[ctr - 5].toString());

                    }
                }
                else if((!mealtype.isEmpty() || !cuisine.isEmpty()) && !specificIngredient.isEmpty()){
                    for( int ctr = 6; ctr < ingredientslist.length + 6; ctr++ ){
                        //System.out.println("LOLX");
                        //int tmp = ctr;
                        //int ans = tmp -6;
                        //int lengthofilist = ingredientslist.length + 6;
                        //System.out.println("ingredientslist[" + ans + "] is " + ingredientslist[ctr - 6].toString() + " " + tmp);
                        //System.out.println(lengthofilist);
                        statement.setString(ctr, ingredientslist[ctr - 6].toString());

                    }
                }
                else if( (mealtype.isEmpty() || cuisine.isEmpty()) && specificIngredient.isEmpty() ){
                    for( int ctr = 3; ctr < ingredientslist.length + 3; ctr++ ){
                        //System.out.println("LOL3");
                        //int tmp = ctr;
                        //int ans = tmp -3;
                        //int lengthofilist = ingredientslist.length + 3;
                        //System.out.println("ingredientslist[" + ans + "] is " + ingredientslist[ctr - 3].toString() + " " + tmp);
                        //System.out.println(lengthofilist);
                        statement.setString(ctr, ingredientslist[ctr - 3].toString());
                    }
                }
                else if ((mealtype.isEmpty() || cuisine.isEmpty()) && !specificIngredient.isEmpty()){
                    for( int ctr = 4; ctr < ingredientslist.length + 4; ctr++ ){
                        //System.out.println("LOL");
                        //int tmp = ctr;
                        //int ans = tmp -4;
                        //int lengthofilist = ingredientslist.length + 4;
                        //System.out.println("ingredientslist[" + ans + "] is " + ingredientslist[ctr - 4].toString() + " " + tmp);
                        //System.out.println(lengthofilist);
                        statement.setString(ctr, ingredientslist[ctr - 4].toString());
                    }
                }
                
                
            }
            result = statement.executeQuery();
            while(result.next()){
                Recipe recipe = new Recipe(result.getInt("id"), result.getString("name"), result.getFloat("price"),
                        result.getInt("serving"), result.getString("time"), result.getString("procedures"),
                        result.getString("description"), result.getString("picture"));
                recipes.add(recipe);
            }
        }
        
        catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return recipes;
    }
    
    public static ArrayList<Categories> getBeverage() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Beverages'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getCondiment() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Condiments'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getFruit() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Fruits'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getMeat() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Meat'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getPoultry() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Poultry'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getRice() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Rice'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getSeafood() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Seafood'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getHerb() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Herbs & Spices'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getVegetable() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Vegetables'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getDairy() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Dairy'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getPastry() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Pastry'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    public static ArrayList<Categories> getNoodle() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Noodle'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
   public static ArrayList<Categories> getNuts() throws SQLException, ClassNotFoundException, URISyntaxException{
        ArrayList<Categories> categories = new ArrayList<Categories>();
        Connection c = connect();
        statement = c.prepareStatement( "SELECT i.name\n" +
                                            "FROM ingredient as i\n" +
                                            "INNER JOIN recipe_ingredient AS ri\n" +
                                            "ON i.id = ri.id_ingredient\n" +
                                            "INNER JOIN ingredient_category AS ic\n" +
                                            "ON ic.id = i.id_category\n" +
                                            "WHERE ic.name='Nuts'\n" +
                                            "GROUP BY ri.id_ingredient \n" +
                                            "ORDER BY count(i.name) DESC\n" +
                                            "LIMIT 10;" );
        try{
            result = statement.executeQuery();
            while(result.next()){
                Categories category = new Categories(result.getString("name"));
                categories.add(category);
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        c.close();
        return categories;
    }
    
    
    public static ArrayList separateString(String str){
        ArrayList strList = new ArrayList();
        
        if (str.contains(",") == false ){
           if(str.isEmpty() == false)
                strList.add(str);
           return strList;
        }
        
        String[] strArray = str.split(",");
        strList.addAll(Arrays.asList(strArray));
        
        return strList;
    }
    
    
    
    
    
}
