# Zabbix Template Linux pacemaker

A Zabbix templates for linux pacemaker stats (cluster, high-availability)

Tested on:
Centos 6.x x86_64, zabbix-agent 2.0.10 - 2.0.12

### Authors
* Patrik Majer <patrik.majer.pisek@gmail.com>


### installation

* install a configure zabbix-agent

* copy file "configs/zabbix-agent-pacemaker.conf" into your zabbix include folder

* copy script "scripts/crm_mon_stats.sh" in /root/scripts (or modify agent conf)

* import xml file into zabbix server as template


### Monitored items

TDB
