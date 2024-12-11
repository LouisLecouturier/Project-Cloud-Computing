from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_is_api_running():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}


def test_non_existent_endpoint():
    response = client.get("/non-existent")
    assert response.status_code == 404


def test_post_request():
    response = client.post("/", json={"key": "value"})
    assert response.status_code == 405 


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}
    assert response.json() == {"status": "ok"}
