<cfcomponent output="false">
    <cffunction name="init">
        <cfset this.version = "1.0">
        <cfreturn this />
    </cffunction>
	
	<cffunction name="$createModelClass" returntype="any" access="public">
		<cfargument name="name" type="string" required="true">
		<cfscript>
			var loc = {};
			loc.cfcName = listlast(arguments.name, "/");
			loc.fileName = capitalize(loc.cfcName);
			loc.name = capitalize(arguments.name);
			loc.path = listFirst(replaceNoCase(arguments.name, loc.cfcName, "", "all"), "/");
			if (FileExists(ExpandPath("#application.wheels.modelPath#/#loc.name#.cfc"))){
				application.wheels.existingModelFiles = ListAppend(application.wheels.existingModelFiles, arguments.name);
				loc.path = "."&loc.path;
			}else
				loc.fileName = "Model";
			application.wheels.models[arguments.name] = $createObjectFromRoot(path=application.wheels.modelComponentPath&loc.path, fileName=loc.fileName, method="$initModelClass", name=loc.cfcName);
			loc.returnValue = application.wheels.models[arguments.name];
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>
</cfcomponent>