#===== BUILD STAGE =====#
FROM ubuntu:focal AS builder

ENV VENV=/opt/venv
WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git \
    wget \
    cmake \
    python3 \
    python3-virtualenv \
    xvfb \
    x11-utils \
    python3-dev &&\
	rm -rf /var/lib/apt/lists/*

RUN python3 -m virtualenv --python=/usr/bin/python3 $VENV

ENV PATH="$VENV/bin:$PATH"

RUN python3 -m pip install --upgrade paramiko &&\
    python3 -m pip install \
    fuzzywuzzy \
    python-Levenshtein \
    pyasn1 \
    pyvirtualdisplay \
    beautifulsoup4 \
    pytesseract \
    netaddr &&\
    python3 -m pip install selenium --upgrade

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz -O gecko.tar.gz &&\
    tar -xvf gecko.tar.gz &&\
    mv geckodriver /usr/sbin &&\
    if [ -e /usr/bin/geckodriver ]; then rm /usr/bin/geckodriver; fi; ln -s /usr/sbin/geckodriver /usr/bin/geckodriver

RUN	git clone --no-checkout https://github.com/ChrisTruncer/EyeWitness.git temp &&\
    cd temp &&\
    git sparse-checkout set Python &&\
    mv Python /opt/eyewitness


#===== FINAL STAGE =====#
FROM ubuntu:focal

ARG user=eyewitness
ENV VIRTUAL_ENV=/opt/venv

COPY --from=builder $VENV $VENV
COPY --from=builder /usr/sbin/geckodriver /usr/sbin/geckodriver
COPY --from=builder /opt/eyewitness /home/$user/eyewitness

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /home/$user

RUN export uid=1000 gid=1000 &&\
    echo "$user:x:${uid}:${gid}:$user,,,:/home/$user:/bin/bash" >> /etc/passwd &&\
    echo "$user:x:${uid}:" >> /etc/group &&\
    chown ${uid}:${gid} -R /home/$user &&\
    if [ -e /usr/bin/geckodriver ]; then rm /usr/bin/geckodriver; fi; ln -s /usr/sbin/geckodriver /usr/bin/geckodriver

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    xvfb \
    x11-utils \
    python3-distutils \
    tesseract-ocr \
    firefox &&\
    rm -rf /var/lib/apt/lists/* &&\
#
#   set permissions to $user
#
    chown -R $user:$user /home/$user/eyewitness &&\
    mkdir -p /tmp/eyewitness &&\
    chown $user:$user /tmp/eyewitness

USER $user
WORKDIR /home/$user/eyewitness

ENTRYPOINT ["python", "EyeWitness.py", "-d", "/tmp/eyewitness/results", "--no-prompt"]