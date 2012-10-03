#This script is responsible for setting up a JDBC data source.  This exercise is repeatable as the script
#deletes the existing set up before creating new ones.

#Global variables
#WebSphere environment related variables
cellName = 'basewebpim-devNode01Cell'
nodeName = 'basewebpim-devNode01'
serverName = 'server1'
target = '/Node:'+nodeName+'/Server:'+serverName
serverURL = '/Node:'+nodeName+'/Server:'+serverName

server = AdminConfig.getid(serverURL)
if server:
	targetObject = AdminConfig.getid(target)
	print "\nTarget object is ", targetObject

	# Delete existing Datasource
	print "\nDeleting existing datasources for the above scope."
	datasources = AdminConfig.list('DataSource', targetObject).splitlines()
	#print "\nDatasources are \n", datasources
	
	for ds in datasources:
	   if ds.startswith('webpim-oracle-ds'):
	      print "\nDatasource to be deleted is ", ds
	      AdminConfig.remove( ds )

	# Delete existing JDBC provider
	print "\nDeleting existing JDBC provider for the above scope."
	providers = AdminConfig.list('JDBCProvider', targetObject).splitlines()
	#print "\nJDBCProviders are \n", providers
	
	for provider in providers:
	   if provider.startswith('"Oracle JDBC Driver'):
	      print "\nJDBC Provider to be deleted is ", provider
	      AdminConfig.remove( provider )

	security = AdminConfig.getid('/Security:/')
	
	jaasAuthData = AdminConfig.list('JAASAuthData').splitlines()
	#print "\nExisting JAASAuthData is \n", jaasAuthData
	for auth in jaasAuthData:
		print "\nJAASAuthData to be deleted is ", auth
		AdminConfig.remove( auth ) 

	alias = ['alias', 'webpim-db']
	userid = ['userId', 'WEB_PIM']
	password = ['password', 'password']
	jaasAttrs = [alias, userid, password]
	
	print AdminConfig.create('JAASAuthData', security, jaasAttrs)

	print "\nCreating JDBC provider"
	jdbcProvider = AdminTask.createJDBCProvider('[-scope Node=basewebpim-devNode01,Server=server1 -databaseType Oracle -providerType "Oracle JDBC Driver" -implementationType "XA data source" -name "Oracle JDBC Driver (XA)" -description "Oracle JDBC Driver (XA)" -classpath ${WAS_INSTALL_ROOT}/lib/ojdbc5.jar -nativePath ]') 
	print "Created... \n", jdbcProvider

	print "Saving changes..."
	AdminConfig.save()

	print "\nCreating datasource"
	datasource = AdminTask.createDatasource(jdbcProvider, '[-name webpim-oracle-ds -jndiName jdbc/dsm_jec_webpimserver -dataStoreHelperClassName com.ibm.websphere.rsadapter.Oracle10gDataStoreHelper -componentManagedAuthenticationAlias webpim-db -xaRecoveryAuthAlias webpim-db -configureResourceProperties [[URL java.lang.String jdbc:oracle:thin:@localhost:1521:xe]]]') 
	propSet = AdminConfig.showAttribute(datasource, 'propertySet')
	print propSet
	rps = AdminConfig.showAttribute(propSet, 'resourceProperties')
	for prop in rps[1:len(rps)-1].split(' '):
		if AdminConfig.showAttribute(prop, 'name') == 'oracle9iLogTraceLevel':
			print "changing oracle9iLogTraceLevel to ''"
			AdminConfig.modify(prop, [['value', '']])
	print "Created... \n", datasource

	print "Saving changes..."
	AdminConfig.save()

	print "DONE"
else:
	print "Server not reachable or not configured correctly."
