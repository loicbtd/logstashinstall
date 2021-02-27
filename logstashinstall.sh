#!/bin/bash

echo "NOTICE: download"
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.11.0-linux-x86_64.tar.gz -O logstash.tar.gz

echo "NOTICE: extract"
tar -zxvf logstash.tar.gz

echo "NOTICE: clear"
rm logstash.tar.gz

echo "NOTICE: navigate into logstash"
cd logstash-7.11.0

echo "NOTICE: create logstash config file"
cat >> ./config/logstash.yml << EOF
# Chemin vers le dossier de data
path.data: "./data2"

# Si les évènements en sortie doivent-être ordonné ou non
pipeline.ordered: true

# Log level
log.level: info

# Nombre de worker pour pour chaque pipeline
pipeline.workers: 1

# Chemin vers les fichiers de logs
path.logs: "./logs"
EOF

echo "NOTICE: create test conf"
mkdir -p "./conf/test"

echo "NOTICE: create output and input folders"
mkdir output input

echo "MOTICE: create logstash conf for test"
cat >> ./conf/test/logstash.conf << EOF
input {
    stdin {
        type => stdin
    }
} 

output {
    stdout {
        codec => rubydebug
    }
}
EOF
