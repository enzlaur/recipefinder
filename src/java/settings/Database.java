/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package settings;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author cheskaalindao
 */
public class Database {
    //public static String url = "jdbc:mysql://localhost:3307/recipe_finder";         
    //public static String url = "mysql://b4e0f7518d63e8:d20a289f@us-cdbr-east-05.cleardb.net/heroku_1229b3fb6c5b963?connect=true";
    //public static String username = "root"; 
    //public static String password = "1234"; 
    
    public static Connection getConnection() throws URISyntaxException, SQLException {
    URI dbUri = new URI(System.getenv("CLEARDB_DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();

    return DriverManager.getConnection(dbUrl, username, password);
    }
    
    /*
    URI dbUri = new URI(System.getenv("CLEARDB_DATABASE_URL"));

    String username = dbUri.getUserInfo().split(":")[0];
    String password = dbUri.getUserInfo().split(":")[1];
    String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();    
    */
}
