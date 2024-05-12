<cfcomponent output="false">
  <cfset this.name = "ecommerce">
  <cfset this.SessionManagement = true>
  <cfset this.applicationTimeout = CreateTimeSpan(0,0,30,0) />
  <cfset this.sessionTimeout = CreateTimeSpan(0,0,10,0) />
  <cfsetting requesttimeout="300" showdebugoutput="true" enablecfoutputonly="false" />
  <cfset this.path=getCurrentTemplatePath()>
	<cfset this.dir=getDirectoryFromPath(this.path)>
  <cfset application.sitepath = getDirectoryFromPath(this.path)>
	<cfset this.mappings["/component"]="#this.dir#components/">
  <cffunction name="onApplicationStart" returntype="boolean" output="false">
    <cfset application.datasource = "ecommerce">
    <cfreturn true>
  </cffunction>
  <cffunction name = "OnRequestStart" access = "public" returnType = "boolean" output = "false"  hint = "Fires at first part of page processing.">
    <cfargument name = "targetPage" type = "string" required = "true">
    <cfif isDefined("url.reload") AND url.reload EQ 1>
      <cfset onApplicationStart()>
    </cfif>
    <cfset local.fileName = ListLast(arguments.targetPage, '/')>
    <cfset local.extension = ListLast(arguments.targetPage, '.')>
    <cfif local.extension NEQ 'cfc' AND NOT listFindNoCase("index.cfm,login.cfm,signup.cfm,productList.cfm", local.fileName) AND NOT structKeyExists(session, "user")>
      <cflocation url="login.cfm" addtoken="false">
    </cfif>
    <cfif structKeyExists(session, "user") AND listFindNoCase("login.cfm,signup.cfm", local.fileName)>
      <cflocation url="productList.cfm" addtoken="false">
    </cfif>
    <cfreturn true />
  </cffunction>
  <cffunction name = "OnSessionEnd" access = "public" returntype = "void" output = "false" hint = "Fires when the session is terminated.">
    <cfargument name = "sessionScope" type = "struct" required = "true">
    <cfargument name = "applicationScope" type = "struct" required = "false" default = "#StructNew()#" />
      <cfset StructClear(SESSION) />
  </cffunction>
  <cffunction name="onError" returntype="void">
    <cfargument name="exception" required="true">
    <cfargument name="event" type="string" required="true">
    <cfmail  from="error@eshopping.com"  subject="Error - eshopping"  to="error@eshopping.com" type="html">
      <cfdump  var="#cfcatch#">
    </cfmail>
    <cfthrow object="#arguments.exception#" />
  </cffunction>
</cfcomponent>