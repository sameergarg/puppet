import os

#This script is responsible for setting up a custom property which will be available as system environment variable

#Global variables
#WebSphere environment related variables
cellName = 'basewebpim-devNode01Cell'
nodeName = 'basewebpim-devNode01'
serverName = 'server1'

scope = '/Cell/'+cellName+'/Node/'+nodeName+'/Server/'+serverName
scopeId = AdminConfig.getid(scope)
serverWebContainer = AdminConfig.list("JavaVirtualMachine", scopeId )
#print scopeId


webcontainerProperties = AdminConfig.list("Property", serverWebContainer).splitlines()
print "\nList of properties", webcontainerProperties
print "\nCheck for existing properties and delete if found"
if webcontainerProperties:
  for propertyID in webcontainerProperties:
    print "\n\tProperties : ", propertyID
    AdminConfig.remove(propertyID)
    print "\n\tDeleted property"


name = ['name', 'webpim.configuration']
value = ['value', '/etc/webpim/webpim-application.properties']
attributes = [name, value]
print "\nAttribute properties are ", attributes		

print "\nCreating property to store location of webpim config file"
newmp = AdminConfig.create('Property', serverWebContainer, attributes)
print "\nCreated property to store location of webpim config file"
AdminConfig.save()
print newmp

name = ['name', 'webpim.logtype.Logfile']
value = ['value', '/var/log/webpim.log']
attributes = [name, value]
print "\nAttribute properties are ", attributes

print "\nCreating property to store location of webpim clog output"
newmp = AdminConfig.create('Property', serverWebContainer, attributes)
print "\nCreated property to store location of webpim config file"
AdminConfig.save()
print newmp

name = ['name', 'dms.configuration']
value = ['value', '/etc/dms/dms-application.properties']
attributes = [name, value]
print "\nAttribute properties are ", attributes		

print "\nCreating property to store location of DMS config file"
newmp = AdminConfig.create('Property', serverWebContainer, attributes)
print "\nCreated property to store location of dms config file"
AdminConfig.save()
print newmp

	
