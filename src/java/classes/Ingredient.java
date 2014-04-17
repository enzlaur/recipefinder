/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

/**
 *
 * @author paulo
 */
public class Ingredient {
    int id;
    String ingredient_qty;
    String name;
    String ingredient_info;
    String category;

    public Ingredient(int id, String ingredient_qty, String name, String ingredient_info, String category) {
        this.id = id;
        this.ingredient_qty = ingredient_qty;
        this.name = name;
        this.ingredient_info = ingredient_info;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIngredient_qty() {
        return ingredient_qty;
    }

    public void setIngredient_qty(String ingredient_qty) {
        this.ingredient_qty = ingredient_qty;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIngredient_info() {
        return ingredient_info;
    }

    public void setIngredient_info(String ingredient_info) {
        this.ingredient_info = ingredient_info;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    
}
