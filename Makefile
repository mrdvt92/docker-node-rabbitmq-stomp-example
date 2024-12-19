CONTAINER_NAME=rabbitmq-stomp
IMAGE_NAME=local/rabbitmq-stomp
PORT=5079
TZ=America/New_York

all:

restart:	stop start

rebuild:	build rm run

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm:	stop
	docker rm $(CONTAINER_NAME)

run:
	docker run -d -p $(PORT):1880 --name $(CONTAINER_NAME) -e TZ=$(TZ) --restart=unless-stopped $(IMAGE_NAME)

build:
	docker build -t $(IMAGE_NAME) .

bash:
	docker exec -it $(CONTAINER_NAME) /bin/bash || true

.PHONY:	flows.json
flows.json:
	docker exec -it $(CONTAINER_NAME) cat /data/$@ > $@
	dos2unix $@

.PHONY:	settings.js
settings.js:
	docker exec -it $(CONTAINER_NAME) cat /data/$@ > $@
	dos2unix $@

.PHONY:	flows_cred.json
flows_cred.json:
	docker exec -it $(CONTAINER_NAME) cat /data/$@ > $@
	dos2unix $@

export_all:	flows.json settings.js flows_cred.json

firewall:
	sudo firewall-cmd --zone=public --permanent --add-port=$(PORT)/tcp
	sudo firewall-cmd --reload
