from fastapi import FastAPI

app = FastAPI()


@app.get("/message")
def get_message():
    return {
        "message": "Hello from Message Service",
        "service": "message-service"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }
