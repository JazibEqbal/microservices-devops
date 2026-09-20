from fastapi import FastAPI
from pathlib import Path

app = FastAPI()

DATA_FILE = Path("/data/messages.txt")


@app.get("/message")
def get_message():
    DATA_FILE.parent.mkdir(parents=True, exist_ok=True)

    with DATA_FILE.open("a") as file:
        file.write("Message Service was accessed\n")

    return {
        "message": "Hello from Message Service",
        "service": "message-service"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }
