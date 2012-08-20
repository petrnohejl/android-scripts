:: Getting Android key hash for Facebook app on Windows
:: Requirement: OpenSSL for Windows (http://code.google.com/p/openssl-for-windows/downloads/list)
:: Usage: set paths, alias name, cert name and run facebookkey.bat in keystore dir

@echo Exporting keystore cert
keytool -exportcert -alias myalias -keystore mycert.keystore > mycert.keystore.bin

@echo Converting to sha1
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl sha1 -binary mycert.keystore.bin > mycert.keystore.sha1

@echo Converting to base64
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl base64 -in mycert.keystore.sha1 -out mycert.keystore.base64

@echo Done, Android hash key for Facebook app is:
C:\PROGRAMS\openssl-0.9.8k_X64\bin\openssl base64 -in mycert.keystore.sha1
@pause
