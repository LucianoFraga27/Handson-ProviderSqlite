# FIREBASE

# gerando keystore
$ keytool -genkey -v -alias todo_list -keystore C:\desenv\lucas-workspace\flutter-workspace\certificados\todo_list.jks -keyalg RSA -sigalg SHA256 -storepass 123456 -keypass 123456 -dname "CN=Luciano Lucas, OU=Stoica, O=RJ, L=RJ, S=Brasil, C=BR" -sigalg "SHA256withRSA" 

# Usando keystore
keytool -list -v -alias todo_list -keystore C:\desenv\lucas-workspace\flutter-workspace\certificados\todo_list.jks

# INSIRA  PASSWORD: 123456

# Copia o SHA1 E coloca no firebase

# Donwload do arquivo: google-services.json
# Cola ele na pasta app



# Autenticação 

-> Sing-in method 
Habilita email , password. e Google.