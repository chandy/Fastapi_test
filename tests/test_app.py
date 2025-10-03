import pytest
from httpx import AsyncClient
from app.main import app


@pytest.mark.anyio
async def test_root():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        resp = await ac.get("/")
    assert resp.status_code == 200
    assert resp.json() == {"message": "Hello, world"}


@pytest.mark.anyio
async def test_echo():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        resp = await ac.get("/echo/uv")
    assert resp.status_code == 200
    assert resp.json() == {"echo": "uv"}
