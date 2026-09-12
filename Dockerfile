FROM python:3.12-slim

# Update Debian packages for security fixes
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

COPY main.py .
COPY portfolio.html .
COPY new.html .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
