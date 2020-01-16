FROM python:alpine

RUN apk --no-cache add git

WORKDIR /opt

RUN git clone https://github.com/aboul3la/Sublist3r.git &&\
	apk del git &&\
	cd Sublist3r &&\
	pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["/opt/Sublist3r/sublist3r.py"]