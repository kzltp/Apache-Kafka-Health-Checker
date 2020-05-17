# Apache Kafka Health Checker

![alt text](https://raw.githubusercontent.com/kzltp/Apache-Kafka-Health-Checker/master/images.png)


## Installation

Download files 

```bash
git clone --config http.sslVerify=false https://github.com/kzltp/Apache-Kafka-Health-Checker.git
```

Configure apachekhc.conf file

```bash
KHOME=<Kafka home path>
HOST=<zookeeper ip or hostname>
ZPORT=<zookeeper port>
KPORT=<kafka port>
```

Shell script give execute permission

```bash
chmod +x apachekhc.sh
```
