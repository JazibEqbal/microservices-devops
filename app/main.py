from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Hello from DevOps Learning Project"}


@app.get("/message")
def get_message():
    return {
        "message": "This is a hardcoded backend response",
        "status": "success"
    }