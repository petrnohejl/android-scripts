:: Getting the MD5 fingerprint of my signing certificate on Windows
:: Usage: set cert name and run mapkey.bat in keystore dir

@echo Getting the MD5 fingerprint
keytool -v -list -keystore mycert.keystore

@echo Done, now visit: http://code.google.com/android/maps-api-signup.html
@pause
