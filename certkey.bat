:: Getting BKS keystore of my self-signed certificate
:: Requirement: Bouncy Castle's provider jar (http://downloads.bouncycastle.org/java/bcprov-jdk15on-146.jar)
:: Usage: set cert name, password and run certkey.bat
:: Useful links: http://nelenkov.blogspot.cz/2011/12/using-custom-certificate-trust-store-on.html
::               http://blog.crazybob.org/2010/02/android-trusting-ssl-certificates.html
::               http://stackoverflow.com/questions/2642777/trusting-all-certificates-using-httpclient-over-https/6378872#6378872

:: First create PEM-encoded public certificate cert.pem from example-server.com (run in Unix Shell):
:: echo | openssl s_client -connect example-server.com:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > cert.pem

@echo Exporting BKS keystore
keytool -import -v -trustcacerts -alias 0 -file cert.pem -keystore cert_keystore.bks -storetype BKS -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath bcprov-jdk15on-146.jar -storepass mypassword
@pause
