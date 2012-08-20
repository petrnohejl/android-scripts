:: Signing Android app on Windows
:: Usage: set alias name, cert name and run 'sign.bat apk_filename.apk' in keystore dir

@echo Signing APK file
jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore mycert.keystore %1 myalias

@echo Checking if APK is verified
jarsigner -verify %1

@echo Align final APK package
rename %1 %1_unaligned
zipalign -v 4 %1_unaligned %1_aligned

@echo Done
@pause
