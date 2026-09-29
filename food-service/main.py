from fastapi import FastAPI

app = FastAPI()


@app.get("/food")
def get_food():
    return {
        "food_type": "Fresh Meals",
        "quantity": 20,
        "status": "available"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }
