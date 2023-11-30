FROM python:3.8-slim as builder

COPY install-pdm.py .
RUN python3 install-pdm.py;

EXPOSE 8000

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN /root/.local/bin/pdm sync -g -p /app --no-self --prod;


FROM python:3.8-slim as app

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

COPY . .

CMD ["gunicorn", "-b", "0.0.0.0:8000", "krddevdays.wsgi:application"]