## docker-node-rabbitmq-stomp-example

This is a docker example on how to configure Node-Red to be a RabbitMQ STOMP publisher and subscriber.

### Build Docker

Review the DockerFile and Makefile for any settings that you might want to tweak.

`make build`

### Run Docker

`make run`

Then access the console at http://127.0.0.1:5079/

### Export Flows

`make export_all`

### RabbitMQ configuration

I install RabbitMQ with the RPM [rabbitmq-server-on](https://github.com/mrdvt92/rabbitmq-server-on).

However, you might want to install RabbitMQ with this process.

```
echo "rabbitmq-server: enable"
systemctl enable rabbitmq-server

echo "rabbitmq_stomp: enable"
/usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_stomp

echo "rabbitmq_management: enable"
/usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

echo "firewall-cmd: add-port 61613 (STOMP)"
firewall-cmd --permanent --add-port=61613/tcp
semanage port -a -t rabbitmq_port_t -p tcp 61613

echo "firewall-cmd: add-port 15672 (Management)"
/usr/bin/firewall-cmd --permanent --add-port=15672/tcp

echo "firewall-cmd: reload"
/usr/bin/firewall-cmd --reload

echo "rabbitmq-server: start"
systemctl start rabbitmq-server
```
