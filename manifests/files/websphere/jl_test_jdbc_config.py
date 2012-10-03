#This script is responsible for setting up a JDBC data source.  This exercise is repeatable as the script
#deletes the existing set up before creating new ones.

#Global variables
#WebSphere environment related variables
cellName = 'basewebpim-devNode01Cell'
nodeName = 'basewebpim-devNode01'
serverName = 'server1'
target = '/Node:'+nodeName+'/Server:'+serverName
serverURL = '/Node:'+nodeName+'/Server:'+serverName


def createDatasource(url, name, jndiName, userId, password, authAlias, jdbcProvider, 
					dataStoreHelperClass = "com.ibm.websphere.rsadapter.Oracle11gDataStoreHelper"):

	jaasAttrs = [['alias', authAlias], ['userId', userId], ['password', password]]
	security = AdminConfig.getid('/Security:/')
	print AdminConfig.create('JAASAuthData', security, jaasAttrs)
	
	datasource = AdminTask.createDatasource(jdbcProvider, 
		 	('[-name %(name)s -jndiName %(jndiName)s -dataStoreHelperClassName %(dataStoreHelperClass)s' +
			' -componentManagedAuthenticationAlias %(authAlias)s -xaRecoveryAuthAlias %(authAlias)s' +
			' -configureResourceProperties [[URL java.lang.String %(url)s]]]') % 
			{'name': name, 'jndiName': jndiName, 'dataStoreHelperClass': dataStoreHelperClass, 'authAlias': authAlias, 'url': url})
	propSet = AdminConfig.showAttribute(datasource, 'propertySet')
	print propSet
	rps = AdminConfig.showAttribute(propSet, 'resourceProperties')
	for prop in rps[1:len(rps)-1].split(' '):
		if AdminConfig.showAttribute(prop, 'name') == 'oracle9iLogTraceLevel':
			print "changing oracle9iLogTraceLevel to ''"
			AdminConfig.modify(prop, [['value', '']])
	print "Created \n", datasource


server = AdminConfig.getid(serverURL)
if server:
	targetObject = AdminConfig.getid(target)
	print "\nTarget object is ", targetObject
	
	#check for existing provider
	providers = AdminConfig.list('JDBCProvider', targetObject).splitlines()
	
	providerExists = 0
	for provider in providers:
		if provider.startswith('"Oracle JDBC Driver'):
			print "\nFound existing JDBC Provider ", provider
			jdbcProvider = provider
			providerExists = 1
			break
	if not providerExists:
		print "\nCreating JDBC provider"
		jdbcProvider = AdminTask.createJDBCProvider('[-scope Node=basewebpim-devNode01,Server=server1 -databaseType Oracle -providerType "Oracle JDBC Driver" -implementationType "XA data source" -name "Oracle JDBC Driver (XA)" -description "Oracle JDBC Driver (XA)" -classpath ${WAS_INSTALL_ROOT}/lib/ojdbc5.jar -nativePath ]') 
		print "Created... \n", jdbcProvider

	print "Saving changes..."
	AdminConfig.save()

	print "\nCreating datasource for TEST..."
	createDatasource(url='jdbc:oracle:thin:@utajecdp01.johnlewis.co.uk:1539:pubint01', name='jl-test-webpim-ds', 
			jndiName='jdbc/webpim_jl_test', userId='web_pim', password='pimpubiNt01', authAlias='jl-test-webpim-db',
			jdbcProvider=jdbcProvider)
	
	print "\nCreating datasource for SYST..."
	createDatasource(url='jdbc:oracle:thin:@usajecdp01.johnlewis.co.uk:1538:pubsys01', name='jl-syst-webpim-ds', 
			jndiName='jdbc/webpim_jl_syst', userId='web_pim', password='pimpubSyS01', authAlias='jl-syst-webpim-db',
			jdbcProvider=jdbcProvider)
	
	print "\nCreating datasource for SYST2..."
	createDatasource(url='jdbc:oracle:thin:@usajecdp01.johnlewis.co.uk:1538:pubsys02', name='jl-syst2-webpim-ds', 
			jndiName='jdbc/webpim_jl_syst2', userId='web_pim', password='am4z1nGrac3', authAlias='jl-syst2-webpim-db',
			jdbcProvider=jdbcProvider)
	
	print "\nCreating datasource for EDUC..."
	createDatasource(url='jdbc:oracle:thin:@ueajecdp01.johnlewis.co.uk:1541:pubedu01', name='jl-educ-webpim-ds', 
			jndiName='jdbc/webpim_jl_educ', userId='web_pim', password='detenti0N', authAlias='jl-educ-webpim-db',
			jdbcProvider=jdbcProvider)
	
	print "\nCreating datasource for PERF..."
	createDatasource(url='jdbc:oracle:thin:@upajecdp01.johnlewis.co.uk:1566:puboat01', name='jl-perf-webpim-ds', 
			jndiName='jdbc/webpim_jl_perf', userId='web_pim', password='pimpubOAT01', authAlias='jl-perf-webpim-db',
			jdbcProvider=jdbcProvider)

	print "Saving changes..."
	AdminConfig.save()

	print "DONE"
else:
	print "Server not reachable or not configured correctly."
