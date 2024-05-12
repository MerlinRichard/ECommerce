<cfcomponent hint="Holds all the order details">
  <cffunction name="addNewOrder" returntype="struct" hint="To add an order" access="remote" returnformat="json">
    <cfargument name="address" type="string" required="true">
    <cftry>
      <cfset local.result = {error: false, message= ""}>
      <cfset local.priceDetails = getOrderDetails()>
      <cfif local.priceDetails.recordCount>
        <cfquery name="local.insertOrder" datasource="#application.datasource#">
          INSERT INTO tblOrder (fldUserId, fldCartId, fldAmount, fldStatus, fldAddress)
          VALUES
          (
            <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">,
            <cfqueryparam value = "#local.priceDetails.fldCartId#" cfsqltype = "integer">,
            <cfqueryparam value = "#local.priceDetails.totalPrice - local.priceDetails.totalDiscount#" cfsqltype = "float">,
            'Processing',
            <cfqueryparam value = "#arguments.address#" cfsqltype = "varchar">
          )
        </cfquery>
        <cfquery name="local.removeCart" datasource="#application.datasource#">
          UPDATE
            tblcart
          SET
            fldActive = 0
          WHERE
            fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">
            AND fldActive = 1
        </cfquery>
        <cfquery name="local.removeCartItems" datasource="#application.datasource#">
          UPDATE
            tblorderItem
          SET
            fldActive = 0
          WHERE
            fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">
            AND fldActive = 1
        </cfquery>
        <cfset local.result = {error: false, message= "Order placed successfully!"}>
      </cfif>
      <cfcatch>
        <cfmail  from="error@eshopping.com"  subject="Error - AddNewOrder - order.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
        <cfset local.result = {error: true, message= "Order not placed. Please try again!"}>
      </cfcatch>
    </cftry>
    <cfreturn local.result>
  </cffunction>
  <cffunction name="getOrderDetails" returntype="any" hint="To get order details" access="remote" returnformat="json">
    <cftry>
      <cfquery name="local.getOrderDetails" datasource="#application.datasource#">
        SELECT
          OI.fldCartId,
          SUM(P.fldPrice * OI.fldQuantity) AS totalPrice,
          SUM(((P.fldDiscount * P.fldPrice)/100) * OI.fldQuantity) AS totalDiscount
        FROM
          tblorderItem OI
          INNER JOIN tblproduct P ON P.fldProduct_ID = OI.fldProductId AND P.fldActive = 1
        WHERE
          OI.fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
          AND OI.fldActive = 1
      </cfquery>
      <cfreturn local.getOrderDetails>
      <cfcatch>
        <cfmail  from="error@eshopping.com"  subject="Error - getOrderDetails - order.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
  </cffunction>
</cfcomponent>