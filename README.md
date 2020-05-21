## Development Continues...

## Apache Kafka Health Checker

![alt text](https://raw.githubusercontent.com/kzltp/Apache-Kafka-Health-Checker/master/welcome.png)

Kafka health checker is an application that facilitates the basic control of the kafka ecosystem running on linux cli.

## Installation

Download files 

```bash
git clone --config http.sslVerify=false https://github.com/kzltp/Apache-Kafka-Health-Checker.git
```

Edit apachekhc.conf file

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
## Release Note
#21.05.2020 --> Message count information function added.
