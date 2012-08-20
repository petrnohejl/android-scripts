:: Getting Android key hash for Facebook app on Windows
:: Requirement: OpenSSL for Windows (http://code.google.com/p/openssl-for-windows/downloads/list)
:: Usage: set paths and run facebookkeydebug.bat

@echo Exporting keystore cert
keytool -exportcert -alias androiddebugkey -keystore C:\Users\myusername\.android\debug.keystore -storepass android -keypass android > debug.keystore.bin

@echo Converting to sha1
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl sha1 -binary debug.keystore.bin > debug.keystore.sha1

@echo Converting to base64
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl base64 -in debug.keystore.sha1 -out debug.keystore.base64

@echo Done, Android hash key for Facebook app is:
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl base64 -in debug.keystore.sha1
@pause
