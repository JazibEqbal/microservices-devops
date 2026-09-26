from fastapi import FastAPI
import urllib.request
import json
import os

app = FastAPI()

MESSAGE_SERVICE_URL = os.getenv(
    "MESSAGE_SERVICE_URL",
    "http://message-service-svc:9000"
)


@app.get("/")
def home():
    return {"message": "Hello from DevOps Learning Project"}


@app.get("/message")
def get_message():
    response = urllib.request.urlopen(
        f"{MESSAGE_SERVICE_URL}/message"
    )

    return json.loads(response.read())
