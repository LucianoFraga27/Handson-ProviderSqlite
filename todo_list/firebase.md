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


# Instalação 

$ npm install -g firebase-tools

$ firebase login

$ Y

# agora loge com sua conta do google

$ firebase projects:list

# esse comando vai te mostrar seus projetos


$ firebase logout // sai do firebase

# configurando o projeto 

$ firebase login

$ pub global activate flutterfire_cli

$ flutterfire configure 
-> escolha o projeto
-> escolha a plataforma


$ flutter pub add firebase_core

Adicione antes do run app:

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 


# Adicionar impressão digital

-> é parte do key store SHA1