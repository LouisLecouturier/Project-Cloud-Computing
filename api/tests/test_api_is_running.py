from http import client

import pytest
from fastapi.testclient import TestClient

from api import app

client = TestClient(app)


def test_is_api_running():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}
