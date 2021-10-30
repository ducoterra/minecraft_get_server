FROM python:latest

RUN pip install requests
COPY get_server.py get_server.py
RUN chmod +x get_server.py
WORKDIR /downloads

CMD [ "/get_server.py" ]
ENTRYPOINT ["python"]
