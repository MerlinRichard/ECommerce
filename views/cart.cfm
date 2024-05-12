<cftry>
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1"/>
      <title>Cart</title>
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous"
      />
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="../js/cart.js"></script>
    </head>
    <body>
      <cfinclude template = "../common/header.cfm"/>
      <cfoutput>
        <cfset local.cartObj = createObject("component", "component.cart")/>
        <cfset local.cartDetails = local.cartObj.getCartProducts()>
        <div class="container-fluid h-100 p-5">
        <h3>My Cart</h3>
        <div class="row">
          <div class="col-12">
            <div class="card m-2 rounded-4">
              <div class="card-body">
                <div class="d-flex justify-content-between">
                  <h5 class="card-title">Basket</h5>
                </div>
                <cfif local.cartDetails.recordCount>
                  <cfloop query="#local.cartDetails#">
                    <div class="card">
                      <div class="card-body">
                        <div class="row">
                          <div class="col-3">
                            <img
                              src="../assets/product/#local.cartDetails.fldFilePath#"
                              class="img-thumbnail"
                              alt="cart-item"
                            />
                          </div>
                          <div class="col-7">
                            <h4>#local.cartDetails.fldProductName#</h4>
                            <p>#local.cartDetails.fldDescription#</p>
                            <h6>
                              INR #local.cartDetails.fldPrice# <span class="badge bg-success">#local.cartDetails.fldDiscount# % off</span>
                            </h6>
                            <p>
                              <span class="text-muted">Sold By: </span>#local.cartDetails.fldBrand#
                            </p>
                            <div class="input-group mb-3 w-25 float-end">
                              <button
                                class="btn btn-outline-secondary removeCount"
                                type="button"
                                id="removeBtn"
                                data-productid = "#local.cartDetails.fldProduct_ID#"
                              >
                                -
                              </button>
                              <input
                                type="text"
                                name="productCount"
                                class="form-control text-center productCount"
                                id="productCount"
                                value="#local.cartDetails.fldQuantity#"
                                data-productid = "#local.cartDetails.fldProduct_ID#"
                                readonly
                              />
                              <button
                                class="btn btn-outline-secondary addCount"
                                type="button"
                                id="addBtn"
                                data-productid = "#local.cartDetails.fldProduct_ID#"
                              >
                                +
                              </button>
                            </div>
                            <div class="col-7">
                              <button
                                class="btn btn-danger deleteCartItem"
                                type="button"
                                data-productid = "#local.cartDetails.fldProduct_ID#"
                              >
                                DELETE
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </cfloop>
                  <div class="d-flex justify-content-center">
                    <a href="order.cfm" class="center btn btn-primary w-25 mt-4 rounded-5" id="buyBtn">
                      Proceed to buy
                    </a>
                  </div
                <cfelse>
                  <h4 class="card-text text-center">Your cart is empty!</h4>
                </cfif>
              </div>
            </div>
          </div>
        </div>
      </div>
      </cfoutput>
    </body>
  </html>
  <cfcatch>
    <cfmail  from="error@eshopping.com"  subject="Error - Cart Page"  to="error@eshopping.com" type="html">
      <cfdump  var="#cfcatch#">
    </cfmail>
  </cfcatch>
</cftry>
