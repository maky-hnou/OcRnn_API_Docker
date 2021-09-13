FROM python:3.8
LABEL maintainer="haniyousfi.me"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app
COPY ./scripts /scripts

WORKDIR /app
EXPOSE 8000

RUN python -m pip install --upgrade pip setuptools && \
    pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home ocr && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R ocr:ocr /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER ocr

CMD ["run.sh"]
