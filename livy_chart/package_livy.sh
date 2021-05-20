#!/usr/bin/env bash
cd ..
mvn clean package -B -V -e -Pspark-3.0 -Pthriftserver -DskipTests -DskipITs -Dmaven.javadoc.skip=true
rm -rf zip_livy
mkdir zip_livy
mv ./assembly/target/apache-livy-0.7.0-incubating-bin.zip ./zip_livy/apache-livy-0.7.0-incubating-bin.zip

