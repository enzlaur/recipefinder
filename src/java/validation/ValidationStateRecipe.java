/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package validation;

import java.util.HashMap;
import java.util.Map;
/**
 *
 * @author cheskaalindao
 */
public class ValidationStateRecipe {
    
   private String errorSummary;
    private HashMap<String, String> fieldErrors;

    public ValidationStateRecipe() {
        this.errorSummary = "";
        this.fieldErrors = new HashMap<String, String>();
    }
    
    public void addError(String field, String message){
        this.fieldErrors.put(field, message);
    }  
    
    public void setErrorSummary(String errorSummary){
        this.errorSummary = errorSummary;
    }
    
    public boolean isValid(){
        boolean isValid = true;
        
        for(Map.Entry<String, String> entry: this.fieldErrors.entrySet()){
            if(!entry.getValue().equals("")){
                isValid = false;
            }
        }
        
        return isValid;
    }
    public String getJSON(){
        String jsonValue = "{"+
        "\"errorSummary\":\""+ this.errorSummary+"\","+
        "\"fieldErrors\":{";
        
        String fe = "";
        for(Map.Entry<String, String> entry: this.fieldErrors.entrySet()){
            fe += "\""+entry.getKey() + "\":\"" +  entry.getValue() +"\",";
        }       
        
        fe = fe.replaceAll(",$", "");
        jsonValue+=fe;
        jsonValue += "}}";
        
        return jsonValue;
    }
    
}
