<cfcomponent hint="Holds all the cart function">
  <cffunction name="updateCart" returntype="boolean" hint="To add products in cart" access="remote" returnformat="json">
    <cfargument name="productId" type="integer" required="true">
    <cfargument name="type" type="string" required="false" default="add">
    <cftry>
      <cfif session?.user?.loggedIn>
        <cfquery name="local.getCart" datasource="#application.datasource#">
          SELECT
            fldCart_ID
          FROM
            tblcart
          WHERE
            fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
            AND fldActive = 1
        </cfquery>
        <cfif local.getCart.recordCount>
          <cfquery name="local.getCartItems" datasource="#application.datasource#">
            SELECT
              fldOrderItem_ID,
              fldQuantity
            FROM
              tblorderItem
            WHERE
              fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
              AND fldProductId = <cfqueryparam value = "#arguments.productId#" cfsqltype="integer">
              AND fldActive = 1
          </cfquery>
          <cfif local.getCartItems.recordCount>
            <cfquery name="local.updateCartItems" datasource="#application.datasource#">
              UPDATE
                tblorderItem
              SET
                <cfif arguments.type EQ 'add'>
                  fldQuantity = <cfqueryparam value = "#local.getCartItems.fldQuantity + 1#" cfsqltype="integer">
                <cfelse>
                  fldQuantity = <cfqueryparam value = "#local.getCartItems.fldQuantity - 1#" cfsqltype="integer">
                </cfif>
              WHERE
                fldOrderItem_ID = <cfqueryparam value = "#local.getCartItems.fldOrderItem_ID#" cfsqltype="integer">
            </cfquery>
          <cfelse>
            <cfquery name="local.createCartItems" datasource="#application.datasource#">
              INSERT INTO tblorderItem (fldUserId, fldProductId, fldQuantity, fldCartId)
              VALUES
              (
                <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">,
                <cfqueryparam value = "#arguments.productId#" cfsqltype = "integer">,
                1,
                <cfqueryparam value = "#local.getCart.fldCart_ID#" cfsqltype = "integer">
              )
            </cfquery>
          </cfif>
        <cfelse>
          <cfquery name="local.createCart" datasource="#application.datasource#" result="local.cartId">
            INSERT INTO tblcart (fldUserId)
            VALUES
            (
              <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">
            )
          </cfquery>
          <cfquery name="local.createCartItems" datasource="#application.datasource#">
            INSERT INTO tblorderItem (fldUserId, fldProductId, fldQuantity, fldCartId)
            VALUES
            (
              <cfqueryparam value = "#session.user.userId#" cfsqltype = "integer">,
              <cfqueryparam value = "#arguments.productId#" cfsqltype = "integer">,
              1,
              <cfqueryparam value = "#local.cartId.generatedKey#" cfsqltype = "integer">
            )
          </cfquery>
        </cfif>
        <cfreturn true>
      <cfelse>
        <cfreturn false>
      </cfif>
      <cfcatch>
        <cfmail  from="error@eshopping.com"  subject="Error - updateCart - cart.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
        <cfreturn false>
      </cfcatch>
    </cftry>
  </cffunction>
  <cffunction name="getCartProducts" returntype="any" hint="To get product details in cart">
    <cftry>
      <cfquery name="local.getCart" datasource="#application.datasource#">
        SELECT
          P.fldProduct_ID,
          P.fldProductName,
          P.fldDescription,
          P.fldFilePath,
          P.fldStock,
          P.fldDiscount,
          P.fldBrand,
          P.fldPrice,
          OI.fldQuantity
        FROM
          tblorderItem OI
          INNER JOIN tblproduct P ON P.fldProduct_ID = OI.fldProductId AND P.fldActive = 1
        WHERE
          OI.fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
          AND OI.fldActive = 1
      </cfquery>
      <cfreturn local.getCart>
      <cfcatch>
        <cfmail  from="error@eshopping.com"  subject="Error - getCartProducts - cart.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
  </cffunction>
  <cffunction name="deleteCartItem" returntype="boolean" hint="To delete products in cart" access="remote" returnformat="json">
    <cfargument name="productId" type="integer" required="true">
    <cftry>
      <cfquery name="local.deleteCartItem" datasource="#application.datasource#">
        UPDATE
          tblorderItem
        SET
          fldActive = 0
        WHERE
          fldProductId = <cfqueryparam value = "#arguments.productId#" cfsqltype="integer">
          AND fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
          AND fldActive = 1
      </cfquery>
      <cfquery name="local.getCartItem" datasource="#application.datasource#">
        SELECT
          1
        FROM
          tblorderItem
        WHERE
          fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
          AND fldActive = 1
      </cfquery>
      <cfif NOT local.getCartItem.recordCount>
        <cfquery name="local.updateCart" datasource="#application.datasource#">
          UPDATE
            tblcart
          SET
            fldActive = 0
          WHERE
            fldUserId = <cfqueryparam value = "#session.user.userId#" cfsqltype="integer">
            AND fldActive = 1
        </cfquery>
      </cfif>
      <cfcatch>
        <cfmail  from="error@eshopping.com" subject="Error - deleteCartItem - cart.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
        <cfreturn false>
      </cfcatch>
    </cftry>
    <cfreturn true>
  </cffunction>
</cfcomponent>