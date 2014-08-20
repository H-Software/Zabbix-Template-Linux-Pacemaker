# Zabbix Template Linux pacemaker

A Zabbix templates for linux pacemaker stats (cluster, high-availability)

Check status is based on nagios check

Tested on:
Centos 6.x x86_64, zabbix-agent 2.0.10 - 2.0.12

### Authors
* Patrik Majer <p.majer@tcpisek.cz> (<patrik.majer.pisek@gmail.com>)


### installation

* install a configure zabbix-agent

* copy file "configs/zabbix-agent-pacemaker.conf" into your zabbix include folder

* copy script "scripts/crm_mon_stats.sh" in /root/scripts (or modify agent conf)

* copy script "scripts/check_pacemaker_actions" in /srv/sensu/checks/ (or install as nagios check)

* import xml file into zabbix server as template


### Monitored items

* Pacemaker - configured nodes

* Pacemaker - configured resources

* Pacemaker - running resources on node 1

* Pacemaker - running resources on node 2

* Pacemaker - running resources on node 3

* Pacemaker health - Count of Critical states

* Pacemaker health - Count of OK states

* Pacemaker health - Count of Unknown states

* pacemaker status - offline nodes

* pacemaker status - online nodes

#### Trigers

* Pacemaker - Found critical states - AVERAGE

* Pacemaker - Found unknown states - WARNING

* Pacemaker - is not in a state OK - AVERAGE

* Pacemaker - low "configured nodes" count - WARNING

* Pacemaker - low "configured resources" count - WARNING

* Pacemaker - low "online nodes" count - AVERAGE

* Pacemaker - zero "online nodes" count - HIGH


