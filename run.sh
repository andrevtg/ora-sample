#!/bin/sh

# TNS_ADMIN é a pasta com o conteúdo do ZIP da wallet
TNS_ADMIN=$(pwd)/ora-wallet
#cat $TNS_ADMIN/tnsnames.ora

# DB_NAME é o nome escolhido entre as opções no arquivo tnsnames.ora
#DB_NAME=vtgora_high
DB_NAME=$(cat ora-wallet/tnsnames.ora | grep "_high" | awk '{print $1;}')

# URL do banco
#DB_URL="jdbc:oracle:thin:@$DB_NAME"
DB_URL="jdbc:oracle:thin:@$DB_NAME?TNS_ADMIN=$TNS_ADMIN"
#DB_URL="jdbc:oracle:thin:@adb.sa-saopaulo-1.oraclecloud.com:1522/t5lj2xbsjlzo9dj_vtgora_high.atp.oraclecloud.com"

# credenciais do banco
DB_USER=ADMIN
DB_PASSWORD=Vertigo1234A#_

# copiar properties
cp ojdbc.properties ora-wallet/

# teste
CODE=UCPSample
#CODE=DataSourceSample
#CODE=DataSourceForJKS

# compilar
javac -cp lib/ucp.jar:lib/ojdbc8.jar $CODE.java

# - apenas ojdbc8.jar e ucp.jar são necessárias em JDKs recentes
# - para tracing trocar ojdbc8.jar por ojdbc8_g.jar
JAR_LIBS="./lib/ojdbc8_g.jar:./lib/ucp.jar:./lib/oraclepki.jar:./lib/osdt_cert.jar:./lib/osdt_core.jar"

# executar
#java -classpath "$JAR_LIBS:." -Doracle.jdbc.Trace=true -Doracle.net.tns_admin=$TNS_ADMIN $CODE "$DB_URL"
java -classpath "$JAR_LIBS:." -Doracle.jdbc.Trace=true $CODE "$DB_URL" "$DB_USER" "$DB_PASSWORD" "$TNS_ADMIN"

