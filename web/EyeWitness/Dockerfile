#===== BUILD STAGE =====#
FROM ubuntu:latest AS builder

ARG user=eyewitness
ENV VENV=/opt/venv

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git \
    wget \
    cmake \
    python3 \
    python3-virtualenv \
    xvfb \
    x11-utils \
    python3-dev \
    tesseract-ocr \
    firefox &&\
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

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz &&\
    tar -xvf geckodriver-v0.24.0-linux64.tar.gz &&\
    mv geckodriver /usr/sbin &&\
    if [ -e /usr/bin/geckodriver ]; then rm /usr/bin/geckodriver; fi; ln -s /usr/sbin/geckodriver /usr/bin/geckodriver

WORKDIR /home/$user

RUN	git clone https://github.com/ChrisTruncer/EyeWitness.git

#===== FINAL STAGE =====#
FROM ubuntu:latest

ARG user=eyewitness
ENV VENV=/opt/venv

COPY --from=builder $VENV $VENV
COPY --from=builder /usr/sbin/geckodriver /usr/sbin/geckodriver
COPY --from=builder /home/$user/EyeWitness /home/$user/EyeWitness

ENV PATH="$VENV/bin:$PATH"

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
    chown -R $user:$user /home/$user/EyeWitness &&\
    mkdir -p /tmp/EyeWitness &&\
    chown $user:$user /tmp/EyeWitness

USER $user
WORKDIR /home/$user/EyeWitness

ENTRYPOINT ["python", "EyeWitness.py", "-d", "/tmp/EyeWitness/results", "--no-prompt"]