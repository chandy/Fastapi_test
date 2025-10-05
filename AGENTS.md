# Agent Guidelines for FastAPI Project

## Commands
- **Install dependencies**: `uv sync --dev`
- **Run all tests**: `uv run pytest`
- **Run single test**: `uv run pytest tests/test_file.py::test_function_name`
- **Start server**: `uv run uvicorn app.main:app --reload`

## Code Style
- **Imports**: Standard library first, then third-party (e.g., `from fastapi import FastAPI`)
- **Naming**: snake_case for functions/variables, PascalCase for classes
- **Types**: Use type hints for function parameters and return values
- **Async**: Use async/await for HTTP endpoints and async tests with `@pytest.mark.asyncio`
- **Testing**: Use httpx with ASGITransport for API testing
- **Error handling**: Raise HTTPException for API errors
- **Structure**: Keep app logic in `app/` directory, tests in `tests/`

## Dependencies
- FastAPI for web framework
- pytest-asyncio + httpx for testing
- uvicorn for server