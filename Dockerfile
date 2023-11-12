FROM python:3.7-slim as builder


COPY install-pdm.py .
RUN python3 install-pdm.py \
    && rm -rf /root/.cache \
    && find / -name "*.pyc" -exec rm -f {} \;

EXPOSE 8000

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN /root/.local/bin/pdm sync -g -p /app --no-self --prod \
    && /root/.local/bin/pdm cache clear \
    && find / -name "*.pyc" -exec rm -f {} \;


FROM python:3.7-slim as app

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

COPY . .

RUN chmod +x /app/prestart.sh
