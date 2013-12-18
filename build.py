#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Building script for Android app using Ant
Requirement: Python
Usage: python build.py [target]
       [target] is Ant building target (usually "debug" or "release"),
       setup the script via constants and lists of commands,
       don't forget to build all dependent libraries
"""

import sys
import string
import subprocess
import shlex
import platform


PROJECT_NAME = 'example'
KEYSTORE_PATH = 'extras/keystore/example.keystore'
KEYSTORE_ALIAS = 'example'
ADT_BUNDLE_PATH_WIN = 'C:/adt-bundle-windows'
ADT_BUNDLE_PATH_MAC = '/Applications/Eclipse/adt-bundle-mac-x86_64'

COMMANDS_BUILD = [
	'$ADT_BUNDLE_PATH/sdk/tools/android update project --name AppCompat --target android-19 --subprojects --path vendors/AppCompat',
	'$ADT_BUNDLE_PATH/sdk/tools/android update project --name $PROJECT_NAME --target android-19 --subprojects --path .',
	'cd vendors/AppCompat',
	'ant "$TARGET"',
	'cd ../..',
	'ant "$TARGET"',
]

COMMANDS_SIGN = [
	'jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORE_PATH bin/$PROJECT_NAME-release-unsigned.apk $KEYSTORE_ALIAS',
	'jarsigner -verify -verbose -certs bin/$PROJECT_NAME-release-unsigned.apk',
	'$ADT_BUNDLE_PATH/sdk/tools/zipalign -v 4 bin/$PROJECT_NAME-release-unsigned.apk bin/$PROJECT_NAME-release.apk',
	'echo "Done. Final $TARGET APK file is bin/$PROJECT_NAME-release.apk."',
]


# BUILD
class Build():
	def __init__(self, target):
		# object variables
		self.target = target

		# run commands from COMMANDS_BUILD list
		for i in range(len(COMMANDS_BUILD)):
			command = self.patch_variables(COMMANDS_BUILD[i])
			self.run_command(command)

		# run commands from COMMANDS_SIGN list
		if target=="release":
			for i in range(len(COMMANDS_SIGN)):
				command = self.patch_variables(COMMANDS_SIGN[i])
				self.run_command(command)


	def patch_variables(self, command):
		# patch variables in COMMANDS list
		command = string.replace(command, "$TARGET", self.target)
		command = string.replace(command, "$PROJECT_NAME", PROJECT_NAME)
		command = string.replace(command, "$KEYSTORE_PATH", KEYSTORE_PATH)
		command = string.replace(command, "$KEYSTORE_ALIAS", KEYSTORE_ALIAS)
		command = string.replace(command, "$ADT_BUNDLE_PATH", self.get_adt_bundle_path())
		return command


	def get_adt_bundle_path(self):
		# get path to ADT
		is_mac = (platform.system().lower().find("darwin") > -1)
		if(is_mac): return ADT_BUNDLE_PATH_MAC
		else: return ADT_BUNDLE_PATH_WIN


	def run_command(self, command):
		# run command
		args = shlex.split(command)
		process = subprocess.Popen(args, stdout=subprocess.PIPE, shell=True)

		# print command
		print ">>> " + command

		# print output
		for line in iter(process.stdout.readline, ''):
			line = line.rstrip()
			print line


# MAIN
if (__name__=="__main__"):
	if len(sys.argv)==2:
		Build(string.strip(sys.argv[1]))
	else:
		target = raw_input('Enter target (usually "debug" or "release"): ')
		Build(string.strip(target))
