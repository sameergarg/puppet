#This script is responsible for setting up JVM settings
# in WebSphere - e.g. Heap size

jvm = AdminConfig.list("JavaVirtualMachine").split("\n")[0]
AdminConfig.modify(jvm, '[[maximumHeapSize 1024]]')
AdminConfig.save()
