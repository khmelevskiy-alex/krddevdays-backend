FROM tiangolo/uwsgi-nginx:python3.7-alpine3.9

RUN apk add --no-cache gcc python3-dev postgresql-dev musl-dev
RUN pip install --no-cache-dir pdm

EXPOSE 8000

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN pdm sync -g -p /app --no-self

COPY . .

RUN chmod +x /app/prestart.sh