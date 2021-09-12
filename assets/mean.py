#!/bin/python
from PyDictionary import PyDictionary
import time
import sys, os
import getopt
md5_hash = None
pwdfile = None
argv = sys.argv[1:]
try:
    opts, args = getopt.getopt(argv, "H:P:")
except:
    print("Error")
for opt, arg in opts:
    counter = 1
    if opt in ['-H']:
        md5_hash = arg
    elif opt in ['-P']:
        pwdfile = arg
#print ("{\n",'"DISCRIPTION":',)
dic=PyDictionary((md5_hash))

#print ("}\n{\n",'{\n"MEANING": "',dic.printMeanings(),'",',"\n")
print ('{\n"MEANING": "',dic.getMeanings(),'"',"\n}")
#print ('"SYNONYMS": "',dic.getSynonyms(),'",',"\n")
#print ('"HINDI": "',dic.translateTo("hi"),'"',"\n}")

