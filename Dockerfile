FROM python:3.8-slim

RUN pip install --no-cache-dir pdm \
    && find / -name "*.pyc" -exec rm -f {} \;

EXPOSE 8000

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN pdm sync -g -p /app --no-self --prod \
    && pdm cache clear \
    && find / -name "*.pyc" -exec rm -f {} \;

COPY . .

RUN chmod +x /app/prestart.sh

CMD ["gunicorn", "-b", "0.0.0.0:8000", "krddevdays.wsgi:application"]