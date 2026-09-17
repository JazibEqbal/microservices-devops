from fastapi import FastAPI
import urllib.request
import json

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Hello from DevOps Learning Project"}


@app.get("/message")
def get_message():
    response = urllib.request.urlopen(
        "http://message-service:9000/message"
    )

    return json.loads(response.read())
