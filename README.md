# Logspout Usage

### Papertrail (TLS)

Use logspout to stream your docker logs to [Papertrail](http://help.papertrailapp.com/kb/configuration/configuring-centralized-logging-from-docker/#logspout).
```
$ docker run --name logspout-papertrail --restart=always -d \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    edvisor/logspout-papertrail \
    syslog+tls://<ENDPOINT>.papertrailapp.com:<PORT>
```

Note: Alternatively, you may use `syslog+tcp://` for TCP and `syslog://` for UDP

##### ECS Container Definition
```
"containerDefinitions": [
  {
    "memory": 128,
    "cpu": 64,
    "essential": true,
    "mountPoints": [
      {
        "containerPath": "/var/run/docker.sock",
        "sourceVolume": "docker_sock",
        "readOnly": null
      }
    ],
    "name": "logspout-papertrail",
    "image": "edvisor/logspout-papertrail",
    "command": [
      "syslog+tls://<ENDPOINT>.papertrailapp.com:<PORT>"
    ],
  }
],
"volumes": [
  {
    "host": {
      "sourcePath": "/var/run/docker.sock"
    },
    "name": "docker_sock"
  }
]
```

### Loggly (JSON)

Use logspout to stream your docker logs to Loggly in JSON format.
```
$ docker run --name logspout-loggly --restart=always -d \
    --volume=/var/run/docker.sock:/tmp/docker.sock \
    -e 'LOGGLY_TOKEN=<token>' \
    -e 'LOGGLY_TAGS=<comma-delimited-list>' \
    -e 'FILTER_NAME=<wildcard-container-name>' \
    iamatypeofwalrus/logspout-loggly
```

### Loggly (Syslog)

Use logspout to stream your docker logs to Loggly via the [Loggly syslog endpoint](https://www.loggly.com/docs/streaming-syslog-without-using-files/).  
```
$ docker run --name logspout-loggly --restart=always -d \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    -e SYSLOG_STRUCTURED_DATA="<Loggly API Key>@41058 tag=\"some tag name\"" \
    gliderlabs/logspout \
    syslog+tcp://logs-01.loggly.com:514
```
