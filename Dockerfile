# syntax=docker.io/docker/dockerfile:1
FROM tomcat:9.0-jre8-temurin

# tomcat managerを有効にする場合のみ使用。
# tomcat managerのリソースを配置する(デフォルトでは、そもそもManagerページ自体が無い)。
# かわりに、mvコマンドを実行する手もある。
COPY --from=tomcat:9.0-jre8-temurin /usr/local/tomcat/webapps.dist/manager/ /usr/local/tomcat/webapps/manager/

# manager-guiロールを有効化する。
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
# ローカルホスト以外からアクセスできない制限を解除する。
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml


# h2の仕様では、相対パスのみが使用される場合現在の作業ディレクトリが開始点として使用されます。
# tomcatコンテナイメージでは、デフォルトの作業ディレクトリは/usr/local/tomcatです。
# env.properties で nablarch.db.url=jdbc:h2:./h2/db/rest_example を設定する場合、/usr/local/tomcat/h2/db/が正しい配置場所です。
COPY ./h2/db/rest_example.mv.db /usr/local/tomcat/h2/db/
# /usr/local/tomcat/webapps/配下に、任意の名前でwarを配置する。この名前が後でアクセスする際のURLパスとなる。
# 例： http://localhost:8082/manager/html
COPY ./target/nablarch-example-rest-5u25.war /usr/local/tomcat/webapps/nablarch-example-rest.war

EXPOSE 9080 8080

# ./mvnw compile war:war
# FROM tomcat:9.0-jdk8-temurin-jammy
# COPY target/nablarch-example-web-5u22.war $CATALINA_HOME/webapps/