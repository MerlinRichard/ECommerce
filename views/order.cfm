<cftry>
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1"/>
      <title>Orders</title>
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous"
      />
      <link href="../css/main.css" rel="stylesheet"/>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="../js/order.js"></script>
    </head>
    <body>
      <cfinclude template = "../common/header.cfm"/>
      <cfoutput>
        <cfset local.orderObj = createObject("component", "component.order")/>
        <cfset local.orderDetails = local.orderObj.getOrderDetails()>
        <div class="container-fluid h-100 p-5">
          <h3>Order Review</h3>
          <div class="row">
            <div class="col-12">
              <div class="card m-2 rounded-4">
                <div class="card-body">
                  <div class="card-title"><h5>Payment details</h5></div>
                  <div class="card-text">
                    <table class="table">
                      <tbody>
                        <tr>
                          <td>MRP</td>
                          <td>INR #DecimalFormat(local.orderDetails.totalPrice)#</td>
                        </tr>
                        <tr>
                          <td>Total Discount</td>
                          <td>INR #DecimalFormat(local.orderDetails.totalDiscount)#</td>
                        </tr>
                        <tr>
                          <td>Delivery Fee</td>
                          <td>FREE</td>
                        </tr>
                        <tr class="table-success">
                          <td>Total Amount</td>
                          <td>INR #DecimalFormat(local.orderDetails.totalPrice - local.orderDetails.totalDiscount)#</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-12">
              <div class="card m-2 rounded-4">
                <div class="card-body">
                  <div class="card-title"><h5>Delivery details</h5></div>
                  <div class="card-text">
                    <div class="col-6">
                      <form>
                        <div class="mb-3">
                          <label for="exampleInputEmail1" class="form-label">Address</label>
                          <textarea class="form-control" rows="4" id="address"></textarea>
                          <div class="error" id="addresserror"></div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="d-flex justify-content-center">
              <button type="submit" id="placeOrderBtn" class="center btn btn-primary w-25 mt-4 rounded-5">
                Place order
              </button>
            </div>
          </div>
        </div>
      </cfoutput>
    </body>
  </html>
  <cfcatch>
    <cfmail  from="error@eshopping.com"  subject="Error - Order Page"  to="error@eshopping.com" type="html">
      <cfdump  var="#cfcatch#">
    </cfmail>
  </cfcatch>
</cftry>
