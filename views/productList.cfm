<cftry>
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8" />
      <meta
        name="viewport"
        content="width=device-width,height=device-height, initial-scale=1"
      />
      <title>Product List</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous"
      />
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
      ></script>
      <script src="../js/productList.js"></script>
    </head>
    <body>
      <cfoutput>
        <cfset local.productObj = createObject("component", "component.product")/>
        <cfset local.productDetails = local.productObj.getProductDetails()>
        <cfset local.products = local.productDetails.products>
        <cfinclude template = "../common/header.cfm"/>
        <div class="container-fluid p-4">
          <div class="row justify-content-center">
            <cfloop query="local.products">
              <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card mb-4">
                  <img src="../assets/product/#local.products.fldFilePath#" class="card-img-top" alt="Product Image" width="200" height="300">
                  <div class="card-body">
                      <h5 class="card-title">#local.products.fldProductName#</h5>
                      <p class="card-text font-weight-bold"><i class="fa fa-inr"></i> #local.products.fldPrice#</p>
                      <div class="d-flex justify-content-center"> <!-- Centering wrapper -->
                          <a href="##" class="cartBtn btn btn-primary" data-productid="#local.products.fldProduct_ID#">Add to cart</a>
                      </div>
                  </div>
              </div>
              
              </div>
            </cfloop>
          </div>
        </div>
      </cfoutput>
    </body>
  </html>
  <cfcatch>
    <cfmail  from="error@eshopping.com"  subject="Error - Product List Page"  to="error@eshopping.com" type="html">
      <cfdump  var="#cfcatch#">
    </cfmail>
  </cfcatch>
</cftry>
 