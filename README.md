Description
===========
Zabbix check for Websphere MQ

Install
===========
* Copy files into /root/zabbix/scripts
* Execute config_generator/template_generator.sh
* Import generated template into zabbix
* Add to zabbix agent config: UserParameter=mqm.queue.depth[*],/root/zabbix/scripts/mqm_status.sh $1
* Edit check_mqm.sh header params