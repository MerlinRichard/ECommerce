<cfcomponent hint="Holds all the user function">
  <cffunction name="createUser" returntype="struct" hint="To create new user from e-commerce store" access="remote" returnformat="json">
    <cfargument name="userDetails" type="string" required="true">
    <cftry>
      <cfset local.userDetails = deserializeJSON(arguments.userDetails)>
      <cfset local.result = {error:false, message:"Registration Successful!"}>
      <cfif NOT len(trim(local.userDetails.firstName))>
        <cfset local.result = {error:true, message:"First name is required."}>
      <cfelseif NOT len(trim(local.userDetails.lastName))>
        <cfset local.result = {error:true, message:"Last name is required."}>
      <cfelseif NOT len(trim(local.userDetails.email))>
        <cfset local.result = {error:true, message:"Email Id is required."}>
      <cfelseif NOT len(trim(local.userDetails.password))>
        <cfset local.result = {error:true, message:"Password is required."}>
      <cfelse>
        <cfset local.emailExists = checkEmailAlreadyExists(local.userDetails.email)>
        <cfif val(local.emailExists)>
          <cfset local.result = {error:true, message:"Email already exists! Please try again with another email."}>
        </cfif>
      </cfif>
      <cfif NOT val(local.result.error)>
        <cfquery name="local.createUser" datasource="#application.datasource#" result="local.userResult">
          INSERT INTO tbluser (fldFirstName, fldLastName, fldEmail, fldPassword)
          VALUES
          (
            <cfqueryparam value = "#local.userDetails.firstName#" cfsqltype = "varchar">,
            <cfqueryparam value = "#local.userDetails.lastName#" cfsqltype = "varchar">,
            <cfqueryparam value = "#local.userDetails.email#" cfsqltype = "varchar">,
            <cfqueryparam value = "#HASH(local.userDetails.password)#" cfsqltype = "varchar">
          )
        </cfquery>
        <cfset session.user = {
          loggedIn = true,
          userId = "#local.userResult.generatedKey#",
          firstName = "#local.userDetails.firstName#",
          lastName = "#local.userDetails.lastName#",
          email = "#local.userDetails.email#"
        }>
      </cfif>
      <cfcatch>
        <cfset local.result = {error:true, message:"Something went wrong. Please try again!"}>
        <cfmail  from="error@eshopping.com"  subject="Error - createUser - user.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
    <cfreturn local.result>
  </cffunction>
  <cffunction name="checkEmailAlreadyExists" returntype="boolean" hint="To check the email already exists">
    <cfargument name="email" type="string" required="true">
    <cftry>
      <cfset local.success = 0>
      <cfquery name="local.checkEmailExists" datasource="#application.datasource#">
        SELECT
          1
        FROM
          tbluser
        WHERE
          fldEmail = <cfqueryparam value = "#arguments.email#" cfsqltype="varchar" />
      </cfquery>
      <cfif local.checkEmailExists.recordCount>
        <cfset local.success = 1>
      </cfif>
      <cfcatch>
        <cfset local.success = 1>
        <cfmail  from="error@eshopping.com"  subject="Error - checkEmailAlreadyExists - user.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
    <cfreturn local.success>
  </cffunction>
  <cffunction name="validateUser" returntype="struct" hint="To validate login info" access="remote" returnformat="json">
    <cfargument name="userDetails" type="string" required="true">
    <cftry>
      <cfset local.userDetails = deserializeJSON(arguments.userDetails)>
      <cfset local.result = {error:false, message:""}>
      <cfif NOT len(trim(local.userDetails.email))>
        <cfset local.result = {error:true, message:"Email Id is required."}>
      <cfelseif NOT len(trim(local.userDetails.password))>
        <cfset local.result = {error:true, message:"Password is required."}>
      <cfelse>
        <cfquery name="local.getUserDetails" datasource="#application.datasource#">
          SELECT
            fldUser_ID,
            fldFirstName,
            fldLastName,
            fldPassword
          FROM
            tbluser
          WHERE
            fldEmail = <cfqueryparam value = "#local.userDetails.email#" cfsqltype="varchar">
        </cfquery>
        <cfif local.getUserDetails.recordCount>
          <cfif local.getUserDetails.fldPassword NEQ HASH(local.userDetails.password)>
            <cfset local.result = {error:true, message:"Login Unsuccessful. Incorrect Password!"}>
          </cfif>
        <cfelse>
          <cfset local.result = {error:true, message:"Login Unsuccessful. Incorrect Email!"}>
        </cfif>
      </cfif>
      <cfif NOT local.result.error>
        <cfset session.user = {
          loggedIn = true,
          userId = "#local.getUserDetails.fldUser_ID#",
          firstName = "#local.getUserDetails.fldFirstName#",
          lastName = "#local.getUserDetails.fldLastName#",
          email = "#local.userDetails.email#"
        }>
      </cfif>
      <cfcatch>
        <cfset local.result = {error:true, message:"Something went wrong. Please try again!"}>
        <cfmail  from="error@eshopping.com"  subject="Error - validateUser - user.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
      </cfcatch>
    </cftry>
    <cfreturn local.result>
  </cffunction>
  <cffunction name="userLogout" returntype="boolean" hint="To logout the user" access="remote" returnformat="json">
    <cftry>
      <cfset structClear(session)>
      <cfcatch>
        <cfset local.result = {error:true, message:"Something went wrong. Please try again!"}>
        <cfmail  from="error@eshopping.com"  subject="Error - userLogout - user.cfc"  to="error@eshopping.com" type="html">
          <cfdump  var="#cfcatch#">
        </cfmail>
        <cfreturn false>
      </cfcatch>
    </cftry>
    <cfreturn true>
  </cffunction>
</cfcomponent>