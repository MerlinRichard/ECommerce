$(document).ready(function(){
  $(".addCount").click(function(){
    var productId = $(this).data("productid");
    var inputField = $("input.productCount[data-productid='" + productId + "']");
    var currentValue = parseInt(inputField.val()) + 1;
    if(currentValue > 0) {
        inputField.val(currentValue);
    }
    $.ajax({
      type: "post",
      dataType:'json',
      url: "../components/cart.cfc?method=updateCart",
      data: {
        productId: $(this).data("productid"),
        type: 'add'
      },
      success: function(response){
        console.log(response);
        if(response == false){
          window.location.href = "../views/login.cfm";
        }
      }
    });
  });
  $(".removeCount").click(function(){
    var productId = $(this).data("productid");
    var inputField = $("input.productCount[data-productid='" + productId + "']");
    var currentValue = parseInt(inputField.val()) - 1;
    if(currentValue > 0) {
      inputField.val(currentValue);
      $.ajax({
        type: "post",
        dataType:'json',
        url: "../components/cart.cfc?method=updateCart",
        data: {
          productId: $(this).data("productid"),
          type: 'remove'
        },
        success: function(response){
          if(response == false){
            window.location.href = "../views/login.cfm";
          }
        }
      });
    } else {
      $(this).prop("disabled", true);
    }
  });

  $(".deleteCartItem").click(function(){
    var productId = $(this).data("productid");
      $.ajax({
        type: "post",
        dataType:'json',
        url: "../components/cart.cfc?method=deleteCartItem",
        data: {
          productId: $(this).data("productid")
        },
        success: function(response){
          if(response == false){
            window.location.href = "../views/login.cfm";
          } else {
            window.location.href = "../views/cart.cfm";
          }
        }
      });
  });
});