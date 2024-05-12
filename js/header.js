$(document).ready(function(){
  $("#logoutBtn").click(function(){
    $.ajax({
      type: "post",
      dataType:'json',
      url: "../components/user.cfc?method=userLogout",
      data: {
        productId: $(this).data("productid")
      },
      success: function(response){
        window.location.href = "../views/login.cfm"
      }
    });
  });
});