from fastapi import FastAPI

app = FastAPI(title="FastAPI uv app")


@app.get("/")
def read_root():
    return {"message": "Hello, world"}


@app.get("/echo/{text}")
def echo_text(text: str):
    return {"echo": text}
