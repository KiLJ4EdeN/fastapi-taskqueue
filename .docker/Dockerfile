# brotherman tiangolo
FROM tiangolo/uvicorn-gunicorn:python3.9

RUN apt-get update

# maybe not /code
WORKDIR /code

ADD app/requirements.txt /code/requirements.txt
ADD .env /code/.env

RUN pip install  -r /code/requirements.txt
RUN pip install "uvicorn[standard]" gunicorn
RUN pip3 install --upgrade pip
