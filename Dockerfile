FROM ubuntu:latest

ENV UNAME=abc
ENV UID=1000
ENV GID=1000
ENV SPORT=5900
ENV SHOST=localhost
ENV DPORT=5900

RUN apt-get update -y && apt-get install -y netcat && rm -rf /var/lib/apt/lists/* && rm -f /tmp/reply 2>/dev/null && groupadd -g ${GID} ${UNAME} && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${UNAME}

USER $UNAME

CMD /bin/bash -c "rm -f /tmp/reply 2>/dev/null && mkfifo /tmp/reply && while true; do  nc -l ${DPORT} < /tmp/reply | nc -N ${SHOST} ${SPORT} > /tmp/reply ; done"

