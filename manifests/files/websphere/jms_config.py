#This script is responsible for setting up the Service Integration Bus,
#Connection factories and queues.  This exercise is repeatable as the script
#deletes the existing set up before creating new ones.

#Global variables
#WebSphere environment related variables
cellName = 'basewebpim-devNode01Cell'
nodeName = 'basewebpim-devNode01'
serverName = 'server1'
target = '/Node:'+nodeName+'/Server:'+serverName
serverURL = '/Node:'+nodeName+'/Server:'+serverName

connectionFactoryName = "MQQ_JEC_connection_factory"
connectionFactoryJndiName = "jms/qcf/dsm_jec_webpimserver"
dmsConnectionFactoryName = "MQQ_JEC_dms_connection_factory"
dmsConnectionFactoryJndiName = "jms/qcf/dsm_jec_dmsserver"

# WEB PIM queues
productQueueName = "MQQ_JEC_PRODUCT_READY_QUEUE"
productQueueJndiName = "jms/" + productQueueName
productEmergencyQueueName = "MQQ_JEC_PRODUCT_EMERGENCY_READY_QUEUE"
productEmergencyQueueJndiName = "jms/" + productEmergencyQueueName
staticBundleQueueName = "MQQ_JEC_STATIC_BUNDLE_READY_QUEUE"
staticBundleQueueJndiName = "jms/" + staticBundleQueueName
compositeBundleQueueName = "MQQ_JEC_COMPOSITE_BUNDLE_READY_QUEUE"
compositeBundleQueueJndiName = "jms/" + compositeBundleQueueName
productHubSkuQueueName = "MQQ_JEC_PRODUCTHUB_SKU_QUEUE"
productHubSkuQueueJndiName = "jms/" + productHubSkuQueueName
extravaganzaManualUpdateQueueName = "MQQ_JEC_EXTRAVAGANZA_MANUALUPDATE_QUEUE"
extravaganzaManualUpdateQueueJndiName = "jms/" + extravaganzaManualUpdateQueueName
dmsDistributorQueueName = "MQQ_JEC_DMS_DISTRIBUTOR_QUEUE"
dmsDistributorQueueJndiName = "jms/" + dmsDistributorQueueName
dmsServiceQueueName = "MQQ_JEC_DMS_SERVICE_QUEUE"
dmsServiceQueueJndiName = "jms/" + dmsServiceQueueName
unattachedSkusQueueName = "MQQ_JEC_UNATTACHED_SKUS_READY_QUEUE"
unattachedSkusQueueJndiName = "jms/" + unattachedSkusQueueName

productEmergencyDestinationName = productEmergencyQueueName
productDestinationName = productQueueName
staticBundleDestinationName = staticBundleQueueName
compositeBundleDestinationName = compositeBundleQueueName
productHubSkuDestinationName=productHubSkuQueueName
extravaganzaManualUpdateDestinationName=extravaganzaManualUpdateQueueName
dmsDistributorDestinationName=dmsDistributorQueueName
dmsServiceDestinationName=dmsServiceQueueName
unattachedSkusDestinationName=unattachedSkusQueueName


# DMS queues
distributorQueueName = "MQQ_JEC_DISTRIBUTOR_READY_QUEUE"
distributorQueueJndiName = "jms/queue/" + distributorQueueName
serviceQueueName = "MQQ_JEC_SERVICE_READY_QUEUE"
serviceQueueJndiName = "jms/queue/" + serviceQueueName
cacQueueName = "MQQ_JEC_CLICKANDCOLLECT_READY_QUEUE"
cacQueueJndiName = "jms/queue/" + cacQueueName
intQueueName = "MQQ_JEC_INTERNATIONAL_READY_QUEUE"
intQueueJndiName = "jms/queue/" + intQueueName

distributorDestinationName = distributorQueueName
serviceDestinationName = serviceQueueName
cacDestinationName = cacQueueName
intDestinationName = intQueueName




busName = "webpim_bus"
busDescription = "Service integration bus for WEBPIM"


server = AdminConfig.getid(serverURL)
if server:
	targetObject = AdminConfig.getid(target)
	print "\nTarget object is ", targetObject
	
	#Perform delete / clean up operations	
	#Delete queues
	print "\nDeleting existing queues for the above scope."
	queues = AdminTask.listSIBJMSQueues(targetObject).splitlines()
	#print "\nQueues are \n", queues
	
	for queue in queues:
	  print "\n\tQueue to be deleted is ", queue
	  AdminTask.deleteSIBJMSQueue(queue)

	#Delete connection factories
	print "\nDeleting existing connection factories for the above scope."
	connectionFactories = AdminTask.listSIBJMSConnectionFactories(targetObject).splitlines()
	#print "\nList of connection factories are \n", connectionFactories
	
	for cf in connectionFactories:
	  print "\n\tDeleting connection factory ", cf
	  AdminTask.deleteSIBJMSConnectionFactory(cf)

	print "\nDeleting existing SIBs."
	buses = AdminTask.listSIBuses().splitlines()
	if buses:
		#print "Available SIBs are ", buses 
		for bus in buses:
		  print "Checking bus ", bus
		  if (bus.find(busName) != -1):
			print "\tDeleting bus with name ", busName		  
		  	AdminTask.deleteSIBus(["-bus", busName])
	
	AdminConfig.save()
	

	#Create a bus
	print "\nCreating SIB."
	AdminTask.createSIBus(["-bus", busName, "-description", busDescription, "-busSecurity", "FALSE"])
	AdminTask.addSIBusMember(["-bus", busName, "-node", nodeName, "-server", serverName ])
	print "\nSIB created successfully."

	#Create a SIB destination
	print "\nCreating SIB destinations."
	print "\n\tCreating an Emergency SIB destination of type QUEUE for products."
	AdminTask.createSIBDestination(["-bus", busName, "-name", productEmergencyQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating a SIB destination of type QUEUE for products."
	AdminTask.createSIBDestination(["-bus", busName, "-name", productQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating a SIB destination of type QUEUE for static bundles."
	AdminTask.createSIBDestination(["-bus", busName, "-name", staticBundleQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating a SIB destination of type QUEUE for composite bundles."
	AdminTask.createSIBDestination(["-bus", busName, "-name", compositeBundleQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating an Distributor SIB destination of type QUEUE for distributors."
	AdminTask.createSIBDestination(["-bus", busName, "-name", distributorQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
        print "\n\tCreating an Distributor SIB destination of type QUEUE for distributors."
	AdminTask.createSIBDestination(["-bus", busName, "-name", serviceQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating an ProductHub  SIB destination of type QUEUE for ProductHub Sku."
	AdminTask.createSIBDestination(["-bus", busName, "-name", productHubSkuQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating an ProductHub  SIB destination of type QUEUE for Extravaganza Manual Update QueueName."
	AdminTask.createSIBDestination(["-bus", busName, "-name", extravaganzaManualUpdateQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
        print "\n\tCreating an DMS Distributor SIB destination of type QUEUE for DMS distributors."
	AdminTask.createSIBDestination(["-bus", busName, "-name", dmsDistributorQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating an DMS Distributor SIB destination of type QUEUE for DMS Services."
	AdminTask.createSIBDestination(["-bus", busName, "-name", dmsServiceQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating a Click and Collect SIB destination of type QUEUE for click and collect."
	AdminTask.createSIBDestination(["-bus", busName, "-name", cacQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
        print "\n\tCreating an international SIB destination of type QUEUE for international."
	AdminTask.createSIBDestination(["-bus", busName, "-name", intQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\n\tCreating a SIB destination of type QUEUE for unattached SKUs."
	AdminTask.createSIBDestination(["-bus", busName, "-name", unattachedSkusQueueName, "-type", "QUEUE", "-node", nodeName, "-server", serverName])
	print "\nSIB destination created successfully."

	#Create a generic connection factory
	AdminTask.createSIBJMSConnectionFactory(targetObject, ["-name", connectionFactoryName, "-jndiName", connectionFactoryJndiName, "-busName", busName])
	print "\nGeneric Connection Factory created successfully."

        AdminTask.createSIBJMSConnectionFactory(targetObject, ["-name", dmsConnectionFactoryName, "-jndiName", dmsConnectionFactoryJndiName, "-busName", busName])
	print "\nGeneric DMS Connection Factory created successfully."
	
	#Create Queue
	print "\nCreating various queues..."
	print "\n\tCreating Queue for distributor..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", distributorQueueName, "-jndiName", distributorQueueJndiName, "-queueName", distributorDestinationName, "-busName", busName])
        print "\n\tCreating Queue for service..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", serviceQueueName, "-jndiName", serviceQueueJndiName, "-queueName", serviceDestinationName, "-busName", busName])
	print "\n\tCreating Queue for click and collect..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", cacQueueName, "-jndiName", cacQueueJndiName, "-queueName", cacDestinationName, "-busName", busName])
        print "\n\tCreating Queue for international shipping..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", intQueueName, "-jndiName", intQueueJndiName, "-queueName", intDestinationName, "-busName", busName])	
	print "\n\tCreating Emergency Queue for products..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", productEmergencyQueueName, "-jndiName", productEmergencyQueueJndiName, "-queueName", productEmergencyDestinationName, "-busName", busName])  
	print "\n\tCreating Queue for products..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", productQueueName, "-jndiName", productQueueJndiName, "-queueName", productDestinationName, "-busName", busName])  
	print "\n\tCreating Queue for static bundles..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", staticBundleQueueName, "-jndiName", staticBundleQueueJndiName, "-queueName", staticBundleDestinationName, "-busName", busName])
	print "\n\tCreating Queue for composite bundles..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", compositeBundleQueueName, "-jndiName", compositeBundleQueueJndiName, "-queueName", compositeBundleDestinationName, "-busName", busName])
	print "\n\tCreating Queue for extravaganza manual update..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", extravaganzaManualUpdateQueueName, "-jndiName", extravaganzaManualUpdateQueueJndiName, "-queueName", extravaganzaManualUpdateDestinationName, "-busName", busName])
	print "\n\tCreating Queue for ProductHub Sku..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", productHubSkuQueueName, "-jndiName", productHubSkuQueueJndiName, "-queueName", productHubSkuDestinationName, "-busName", busName])  
	print "\n\tCreating Queue for DMS Distributor..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", dmsDistributorQueueName, "-jndiName", dmsDistributorQueueJndiName, "-queueName", dmsDistributorDestinationName, "-busName", busName])
	print "\n\tCreating Queue for DMS Service..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", dmsServiceQueueName, "-jndiName", dmsServiceQueueJndiName, "-queueName", dmsServiceDestinationName, "-busName", busName])    
	print "\n\tCreating Queue for unattached skus..."
	AdminTask.createSIBJMSQueue(targetObject, ["-name", unattachedSkusQueueName, "-jndiName", unattachedSkusQueueJndiName, "-queueName", unattachedSkusDestinationName, "-busName", busName])
	print "\nQueues created successfully."
	AdminConfig.save()
else:
	print "Server not reachable or not configured correctly."
	
