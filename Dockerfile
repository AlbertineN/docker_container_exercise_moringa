FROM python:3.10.6

LABEL maintainer="albertinengingan@gmail.com"

VOLUME /python_app

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1

EXPOSE 5000

ENTRYPOINT [ "python3", "manage.py", "runserver", "0.0.0.0:5000" ]