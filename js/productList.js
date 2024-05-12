$(document).ready(function(){
  $(".cartBtn").click(function(){
    $.ajax({
      type: "post",
      dataType:'json',
      url: "../components/cart.cfc?method=updateCart",
      data: {
        productId: $(this).data("productid")
      },
      success: function(response){
        console.log(response);
        if(response == false){
          window.location.href = "../views/login.cfm";
        } else {
          window.location.href = "../views/cart.cfm";
        }
      }
    });
  });
});