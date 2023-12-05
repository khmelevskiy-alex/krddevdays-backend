FROM tiangolo/uwsgi-nginx:python3.8

RUN pip install --no-cache-dir pdm

EXPOSE 8000

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN pdm sync -g -p /app --no-self

COPY . .

RUN chmod +x /app/prestart.sh