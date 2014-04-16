var btn = document.getElementById("searchrecipe");


console.log('i added click function on btn');

function getAllIngredients(){
	var elem = document.getElementsByClassName("categories");
        var allingredients = document.getElementById("allingredients");
        allingredients.value = getValues(elem);
        
        
        var prices = document.getElementsByClassName("prices");
        var allprices = document.getElementById("allprices");
        var arrayprices = [];
        // brute force start
          if( prices[0].value ==='' && prices[1].value ===''){
                    arrayprices.push("1");
                    arrayprices.push("99999");
          }
          else if(prices[0].value ===''){
              arrayprices.push("1");
              arrayprices.push(prices[1].value);
          }
          else if(prices[1].value ===''){
              arrayprices.push(prices[0].value);
              arrayprices.push("9999");
          }
          else{
            for ( var ctr = 0; ctr < 2; ctr++ ){
                    if ( prices[ctr].value != '' ){
                            arrayprices.push(prices[ctr].value);
                    }
            }
          }
        allprices.value = arrayprices.toString();
        // brute force end
	
        var beverage = document.getElementsByClassName("beverage");
        var allbeverage = document.getElementById("allbeverage");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("condiment");
        var allbeverage = document.getElementById("allcondiment");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("fruit");
        var allbeverage = document.getElementById("allfruit");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("meat");
        var allbeverage = document.getElementById("allmeat");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("poultry");
        var allbeverage = document.getElementById("allpoultry");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("rice");
        var allbeverage = document.getElementById("allrice");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("seafood");
        var allbeverage = document.getElementById("allseafood");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("herb");
        var allbeverage = document.getElementById("allherb");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("vegetable");
        var allbeverage = document.getElementById("allvegetable");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("dairy");
        var allbeverage = document.getElementById("alldairy");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("pastry");
        var allbeverage = document.getElementById("allpastry");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("noodle");
        var allbeverage = document.getElementById("allnoodle");
        allbeverage.value = getValues(beverage);
        
        var beverage = document.getElementsByClassName("nut");
        var allbeverage = document.getElementById("allnut");
        allbeverage.value = getValues(beverage);
        
        
        $("#frm").submit();
        
        return false;
}

function getValues(good){
    var array = [];
    
    for(var i=0; i<good.length; i++){
             if(good[i].checked)
                 array.push(good[i].value);
        }
        
    return array.toString();
    
}