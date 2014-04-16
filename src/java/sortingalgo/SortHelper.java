/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sortingalgo;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author paulo
 */
public class SortHelper {
    
    private int key; // if key = 1 sort name, key = 2 sort price asc, key = 3 sort price desc
    
    public SortHelper(int key){
        this.key = key;
    }
    
    public ArrayList merge_sort(ArrayList recipes) {
        if(recipes.size() <= 1){
            return recipes;
        }
        
        ArrayList left = new ArrayList(), right = new ArrayList();
        int mid = recipes.size()/2;
        
        int ctr = 0;
        
        for( ctr = 0 ; ctr < mid; ctr++ ){
            left.add(recipes.get(ctr));
        }
        
        for( ctr = mid ; ctr < recipes.size() ; ctr++ ){
            right.add(recipes.get(ctr));
        }
        
        left = merge_sort(left);
        right = merge_sort(right);
        
        if(key == 1)
            return this.mergeName(left, right);
        else if (key == 2)
            return this.mergePriceASC(left, right);
        else
            return this.mergePriceDSC(left, right);
    }
    
    private ArrayList mergeName(ArrayList left, ArrayList right){
        
        ArrayList result = new ArrayList();
        
        
        while( !left.isEmpty() || !right.isEmpty() ){
            HashMap tmpleft = new HashMap(); 
            HashMap tmpright = new HashMap();
            String leftval = "", rightval = "";
            
            if(!left.isEmpty()){
                tmpleft = (HashMap) left.get(0);
                leftval = tmpleft.get("name").toString();
            }
            if(!right.isEmpty()){
                tmpright = (HashMap) right.get(0);
                rightval = tmpright.get("name").toString();
            }
            
            
            if(!left.isEmpty() && !right.isEmpty()){
               if(leftval.compareTo(rightval) <= 0){
                  result.add(tmpleft);
                  left.remove(0);
               }
               else{
                  result.add(tmpright);
                  right.remove(0);
               }
            }
            else if ( !left.isEmpty() ){
                result.add(tmpleft);
                left.remove(0);
            }
            else if ( !right.isEmpty() ){
                result.add(tmpright);
                right.remove(0);
            }
        }
        
        return result;
    }
    
    
    private ArrayList mergePriceASC(ArrayList left, ArrayList right){
        
        ArrayList result = new ArrayList();
        
        
        while( !left.isEmpty() || !right.isEmpty() ){
            HashMap tmpleft = new HashMap(); 
            HashMap tmpright = new HashMap();
            float leftval = 0, rightval = 0;
            
            if(!left.isEmpty()){
                tmpleft = (HashMap) left.get(0);
                leftval = Float.parseFloat(tmpleft.get("price").toString());
            }
            if(!right.isEmpty()){
                tmpright = (HashMap) right.get(0);
                rightval = Float.parseFloat(tmpright.get("price").toString());
            }
            
            
            if(!left.isEmpty() && !right.isEmpty()){
               if(leftval <= rightval){
                  result.add(tmpleft);
                  left.remove(0);
               }
               else{
                  result.add(tmpright);
                  right.remove(0);
               }
            }
            else if ( !left.isEmpty() ){
                result.add(tmpleft);
                left.remove(0);
            }
            else if ( !right.isEmpty() ){
                result.add(tmpright);
                right.remove(0);
            }
        }
        
        return result;
    }
    
    private ArrayList mergePriceDSC(ArrayList left, ArrayList right){
        
        ArrayList result = new ArrayList();
        
        
        while( !left.isEmpty() || !right.isEmpty() ){
            HashMap tmpleft = new HashMap(); 
            HashMap tmpright = new HashMap();
            float leftval = 0, rightval = 0;
            
            if(!left.isEmpty()){
                tmpleft = (HashMap) left.get(0);
                leftval = Float.parseFloat(tmpleft.get("price").toString());
            }
            if(!right.isEmpty()){
                tmpright = (HashMap) right.get(0);
                rightval = Float.parseFloat(tmpright.get("price").toString());
            }
            
            
            if(!left.isEmpty() && !right.isEmpty()){
               if(leftval >= rightval){
                  result.add(tmpleft);
                  left.remove(0);
               }
               else{
                  result.add(tmpright);
                  right.remove(0);
               }
            }
            else if ( !left.isEmpty() ){
                result.add(tmpleft);
                left.remove(0);
            }
            else if ( !right.isEmpty() ){
                result.add(tmpright);
                right.remove(0);
            }
        }
        
        return result;
    }
}
