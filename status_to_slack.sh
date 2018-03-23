#!/bin/bash

SLACK_WEBHOOK="https://hooks.slack.com/services/SLACK_WEBHOOK_URL" #Configurar la URL proporcionada por SLACK para el Hook
SLACK_CHANNEL="canal" #Nombre del canal donde recibis la info del servidor
SLACK_USERNAME="usuairo" #Nombre del usuario seteado en el hook

[ -z $SLACK_WEBHOOK ] && { echo "SLACK_WEBHOOK no está configurado!"; exit 1; }

# informacion del servidor

HOSTNAME=`hostname`
HOSTIP=`hostname -I | sed -r 's/(\S+) (\S+)/\1, \2/g'`
ROUTES=`ip route list scope global`
UPTIME=`uptime`
DISK=`df -hT /`
MEMORY=`free -h`

# envio de mensaje

statusMessage() {
    echo -e ":black_small_square: *${HOSTNAME}* - ${HOSTIP}\n"
    echo -e "_Uptime:_\n\`\`\`${UPTIME}\`\`\`"
    echo -e "_Memory:_\n\`\`\`${MEMORY}\`\`\`"
    echo -e "_Disk:_\n\`\`\`${DISK}\`\`\`"
    echo -e "_Routes:_\n\`\`\`${ROUTES}\`\`\`"
}

PAYLOAD="{\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"${SLACK_USERNAME}\", \"text\": \"`statusMessage`\"}"
curl -X POST --data-urlencode "payload=$PAYLOAD" $SLACK_WEBHOOK
exit 0
