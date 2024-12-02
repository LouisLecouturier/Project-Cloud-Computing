from http import client

from fastapi.testclient import TestClient

from api import app

client = TestClient(app)


def is_api_running():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}
