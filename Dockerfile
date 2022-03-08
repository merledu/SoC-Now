FROM python:3.9

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY . /code/

RUN pip install --upgrade pip
RUN pip install django

EXPOSE 8010

CMD python3 /code/manage.py runserver