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
	
	security = AdminConfig.getid('/Security:/')
	
	alias = ['alias', 'dms-db']
	userid = ['userId', 'dms']
	password = ['password', 'password']
	jaasAttrs = [alias, userid, password]
	
	print AdminConfig.create('JAASAuthData', security, jaasAttrs)

	print "\nCreating JDBC provider"
	jdbcProvider = AdminTask.createJDBCProvider('[-scope Node=basewebpim-devNode01,Server=server1 -databaseType Oracle -providerType "Oracle JDBC Driver" -implementationType "XA data source" -name "Oracle JDBC Driver (XA)" -description "Oracle JDBC Driver (XA)" -classpath ${WAS_INSTALL_ROOT}/lib/ojdbc5.jar -nativePath ]') 
	print "Created... \n", jdbcProvider

	print "Saving changes..."
	AdminConfig.save()

	print "\nCreating datasource"
	datasource = AdminTask.createDatasource(jdbcProvider, '[-name dms-oracle-ds -jndiName jdbc/dsm_jec_dmsserver -dataStoreHelperClassName com.ibm.websphere.rsadapter.Oracle10gDataStoreHelper -componentManagedAuthenticationAlias dms-db -xaRecoveryAuthAlias dms-db -configureResourceProperties [[URL java.lang.String jdbc:oracle:thin:@localhost:1521:xe]]]') 
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
