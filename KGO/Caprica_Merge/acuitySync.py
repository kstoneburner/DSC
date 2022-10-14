###############################################
#### IP address of the Host server
###############################################
sourceServer = "10.218.116.61"

###################################################
#### IP Address of Destination to Sync/Merge With
###################################################
destServer = "10.218.116.161"

###################################################
#### Memory Number to Synchronize and Backup
###################################################
sourceMemoryNumber = "00"

#############################################################
#### Host Filename that is displayed in the switcher
#### This is Cosmetic. It can be anything that is readable  
############################################################
sourceFilename = "PC2 Pri v1_15.tar.gz"

#############################################################
#### Destination Filename that is displayed in the switcher
#### This is Cosmetic. It can be anything that is readable  
############################################################
destFilename = "PC3 Pri v1_15.tar.gz"

###############################################################
#### List of the Filenames to be synchronized
#### These Should be left alone. It's here for futureproofing
###############################################################
extractFiles = [ "custct.tgz", "shotbox.tgz", "memories.tgz", "sequence.tgz" ]

#############################################################
#### Folder Name for the backup files. Backup works best.
############################################################
backupFolderName = "backup"

webPath = "/cgi-bin/filesets"
sourceTempFilename = "PC2_source.tar.gz"
dstTempFilename = "temp.tar.gz"
tempFolderName = "exaction_temp"

import urllib.request
from urllib.parse import urlencode
from urllib.request import Request, urlopen
from urllib.error import HTTPError
import gzip
import tarfile
import os
from os import path
import webbrowser
import threading
import datetime
import requests
from requests.auth import HTTPDigestAuth

###############################################
#### Build the Backup Folder if not exist
###############################################
if not os.path.exists(backupFolderName):
	os.mkdir(backupFolderName)

### Get the current Time
now = datetime.datetime.now()

###############################################
# build Source and dest urllib requests
###############################################
#source_urllib = urllib.request
#dest_urllib = urllib.request

###############################################
# build URLs
###############################################
sourceURL = "http://" + sourceServer + webPath

###############################################
# create a password manager
###############################################
#src_password_mgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()

###############################################
# Add the username and password.
###############################################
#src_password_mgr.add_password(None, sourceURL, "user", "password")

#sourceHandler = urllib.request.HTTPDigestAuthHandler(src_password_mgr)

###############################################
# create "opener" (OpenerDirector instance)
###############################################
#sourceOpener = urllib.request.build_opener(sourceHandler)

###############################################
# use the opener to fetch a URL
###############################################
#sourceOpener.open(sourceURL)

###############################################
# Install the opener.
# Now all calls to urllib.request.urlopen use our opener.
###############################################
#source_urllib.install_opener(sourceOpener)

print("Downloading Source Acuity File")
###############################################
# Download Acuity Files at sourceMemoryNumber
###############################################
#sourceGzip = source_urllib.urlopen(sourceURL + "_get?" + sourceMemoryNumber)
#sourceFileValue = sourceGzip.read()
sourceGzip=requests.get(sourceURL + "_get?" + sourceMemoryNumber,  auth=HTTPDigestAuth("user","password"))
print(sourceGzip)
sourceFileValue = sourceGzip.content
#print(sourceFileValue)

###################################################
### Write downloaded file to Disk
### It's how we could open the File as a tarFile
###################################################
### wb = Write Byte
###################################################
print("Writing Source Acuity File to Disk")
f = open(sourceTempFilename,"wb")
f.write(sourceFileValue)
f.close()

print("Writing Source Acuity File to Backup Folder")
f = open(backupFolderName + "\\" + now.strftime("%Y-%m-%d %H_%M") + "__" + sourceFilename,"wb")
f.write(sourceFileValue)
f.close()


print("Opening Source File as Tar")
srcTar = tarfile.open(sourceTempFilename,"r:gz")

print("Building Destination Connection")

###################################################
### Build Authenticated connection to destination
###################################################
destURL = "http://" + destServer + webPath
#dst_password_mgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
#dst_password_mgr.add_password(None, destURL, "user", "password")
#destHandler = urllib.request.HTTPDigestAuthHandler(dst_password_mgr)
#destOpener = urllib.request.build_opener(destHandler)
#destOpener.open(destURL)
#dest_urllib.install_opener(destOpener)

print("Downloading Destination Acuity File")
###############################################
# Download Acuity Files at sourceMemoryNumber
###############################################
#destGzip = dest_urllib.urlopen(destURL + "_get?" + sourceMemoryNumber)
#destFileValue = destGzip.read()

destGzip=requests.get(destURL + "_get?" + sourceMemoryNumber,  auth=HTTPDigestAuth("user","password"))
print(destGzip)
destFileValue = destGzip.content

###################################################
### Write downloaded file to Disk
### It's how we could open the File as a tarFile
###################################################
### wb = Write Byte
###################################################
print("Writing Temporary Destination Acuity File to Disk")
f = open(dstTempFilename,"wb")
f.write(destFileValue)
f.close()

print("Writing Source Acuity File to Backup Folder")
f = open(backupFolderName + "\\" + now.strftime("%Y-%m-%d %H_%M") + "__" + destFilename,"wb")
f.write(destFileValue)
f.close()

#### Build the Temporary Folder Path
if not os.path.exists(tempFolderName):
	os.mkdir(tempFolderName)

print("Opening Temporary Destination File as Tar")
dstTar = tarfile.open(dstTempFilename,"r:gz")

print("Extracting Temporary Destination tarfile to Working Directory")
dstTar.extractall(tempFolderName,dstTar.getmembers())



for filename in extractFiles:
	print("Extracting " + filename + " from source Acuity File to working Folder")
	sourceCC = srcTar.extractfile(srcTar.getmember(filename).name)
	print("Writing " + filename + " to Temporary Files")
	f = open(tempFolderName + "\\"+ filename,"wb")
	f.write(sourceCC.read())
	f.close()

print("Building New File: " + destFilename)
finalTar = tarfile.open(destFilename,"w:gz")

for root, dirs, files in os.walk(tempFolderName + "\\"):
	for file in files:
		finalTar.add(os.path.join(root, file),arcname=file)
		print("Adding: " + os.path.join(root, file))
finalTar.close()

################################################
################################################
#### File Cleanup
################################################
################################################
#### Delete Files in temporary Directory
################################################
print("Deleting Temp Files")
for root, dirs, files in os.walk(tempFolderName + "\\"):
	for file in files:
		os.remove(os.path.join(root, file))

#### Delete Source and Temp Files

srcTar.close()
dstTar.close()

print("Source Filename: " + sourceFilename)
print("Dest Filename: " + dstTempFilename)

#os.remove(sourceFilename)
os.remove(dstTempFilename)

print("Deletng Temp Folder")
os.rmdir(tempFolderName)

chrome_path = 'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe %s'


t=threading.Thread( webbrowser.get(chrome_path).open(destURL), True)
t.start()
t.join()



""""
print "Current date and time using str method of datetime object:"


print "Current date and time using instance attributes:"
print "Current year: %d" % now.year
print "Current month: %d" % now.month
print "Current day: %d" % now.day
print "Current hour: %d" % now.hour
print "Current minute: %d" % now.minute
print "Current second: %d" % now.second
print "Current microsecond: %d" % now.microsecond

print "Current date and time using strftime:"
print now.strftime("%Y-%m-%d %H:%M")
"""
