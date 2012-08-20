:: Getting the MD5 fingerprint of my signing certificate on Windows
:: Usage: set path and run mapkeydebug.bat

@echo Getting the MD5 fingerprint
keytool -v -list -alias androiddebugkey -keystore C:\Users\myusername\.android\debug.keystore -storepass android -keypass android

@echo Done, now visit: http://code.google.com/android/maps-api-signup.html
@pause
