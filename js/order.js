$(document).ready(function(){
  $("#placeOrderBtn").click(function(){
    if ($("#address").val() != "") {
      $("#addresserror").html("");
      $("#placeOrderBtn").prop("disabled", true);
      $.ajax({
        type: "post",
        dataType:'json',
        url: "../components/order.cfc?method=addNewOrder",
        data: {
          address : $("#address").val()
        },
        success: function(response){
          console.log(response);
          if(response == false){
            window.location.href = "../views/login.cfm";
          } else{
            alert("order placed!");
            window.location.href = "../views/productList.cfm";
          }
        }
      });
    } else {
      $("#addresserror").html("Please enter a valid address.");
    }
  });
});