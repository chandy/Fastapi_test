import pytest
import httpx
from httpx import ASGITransport
from app.main import app


@pytest.mark.asyncio
async def test_root():
    transport = ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        resp = await ac.get("/")
    assert resp.status_code == 200
    assert resp.json() == {"message": "Hello, world"}


@pytest.mark.asyncio
async def test_echo():
    transport = ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        resp = await ac.get("/echo/uv")
    assert resp.status_code == 200
    assert resp.json() == {"echo": "uv"}
