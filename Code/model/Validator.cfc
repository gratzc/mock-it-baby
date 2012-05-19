<cfcomponent name="Validator"
			 output="false"
			 hint="Our incredible validator for EVERYTHING!">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------>

	<cffunction name="init" access="public" output="false" returntype="any" hint="Constructor">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------>
	<cfscript>
		function checkfdsafsdfEmail(str){ return isValid("email",arguments.str); }
	</cfscript>
</cfcomponent>