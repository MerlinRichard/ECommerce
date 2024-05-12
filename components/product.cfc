<cfcomponent hint="Holds all the product function">
  <cffunction name="getProductDetails" returntype="struct" hint="To get product details">
    <cftry>
      <cfset local.result = {error:false, message:""}>
      <cfquery name="local.productDetails" datasource="#application.datasource#">
        SELECT
          fldProduct_ID,
          fldProductName,
          fldFilePath,
          fldPrice,
          fldCategory,
          fldBrand,
          fldDiscount
        FROM
          tblproduct
      </cfquery>
       <cfset local.result = {
          error: false,
          message: "",
          products: local.productDetails
        }>
      <cfcatch>
        <cfset local.result = {error:true, message:"Something went wrong. Please try again!"}>
        <cfmail  from="error@eshopping.com"  subject="Error - getProductDetails - product.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
    <cfreturn local.result>
  </cffunction>
</cfcomponent>